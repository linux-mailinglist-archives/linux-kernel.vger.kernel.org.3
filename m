Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84FC5593A9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiFXGma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiFXGm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:42:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C3E62C22
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:42:27 -0700 (PDT)
Date:   Fri, 24 Jun 2022 08:42:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656052944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wux8PrH3sXXYTLs4zQ4xefDrANKDgBKiLxQ8wvQbsSc=;
        b=hx7eiWFAV/0ZAid8v1kFraMLRLrtNW+999XVDtsYTQhH7Cd5f+dLDK0jpCXMA1oURuNEo3
        H2ZkCHyAlmYfSa5Th4ommBcDkoz9eyKg+3hnbCNh4Iocvj4BCT0MGA0AXLs6IIKKFem+ke
        ZtSs/r9e9OTwo74sMSpjZb4ZOAOxjlh5aH4V0mN9ESdlhbYxhBX9dKhRHC1UT1bzYnt+XB
        M96HapyUqBmX9OnXnS8jDxoqhYD6K6rIB5GRSMxhzJiWeyGs2H6Hn6MjPVns2JJlhTRu7N
        o90M44cA7yMMn8UFxD6A2xcA2yldJ8nvTxQR2b4PHzJkc5dySXFCc4dTtMHxTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656052944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wux8PrH3sXXYTLs4zQ4xefDrANKDgBKiLxQ8wvQbsSc=;
        b=VLmG3ZlpF6nQMSFVGdoiDpWtSejCyIrPQDG/r1K71IPkqMMgEixnXFYUYwVPZO6NZx5STO
        b55JfQb+TAwfjvBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
Subject: Re: [PATCH v2] locking/rtmutex: Limit # of lock stealing for non-RT
 waiters
Message-ID: <YrVczgIdWoOpVX1D@linutronix.de>
References: <20220621193641.609712-1-longman@redhat.com>
 <YrRriHsAdxPwEnWW@linutronix.de>
 <be4db8af-7855-1f54-c2f2-947577b71f94@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <be4db8af-7855-1f54-c2f2-947577b71f94@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-23 10:41:17 [-0400], Waiman Long wrote:
>=20
> On 6/23/22 09:32, Sebastian Andrzej Siewior wrote:
> > Do you have more insight on how this was tested/ created? Based on that,
> > systemd and a random kworker waited on a lock for more than 10 minutes.
>=20
> The hang happens when our QE team run thier kernel tier 1 test which, I
> think, lasts several hours. The hang happens in some runs but not all of
> them. So it is kind of opportunistic. Mike should be able to provide a
> better idea about frequency and so on.

So we talk here about 64+ CPU or more than that?

> > I added a trace-printk each time a non-RT waiter got the lock stolen,
> > kicked a kernel build and a package upgrade and took a look at the stats
> > an hour later:
> > - sh got its lock stolen 3416 times. I didn't lock the pid so I can't
> >    look back and check how long it waited since the first time.
> > - the median average of stolen locks is 173.
> Maybe we should also more lock stealing per waiter than the 10 that I used
> in the patch. I am open to suggestion to what is a good value to use.

I have no idea either. I just looked at a run to see what the number
actually are. I have no numbers in terms of performance. So what most
likely happens is that on an unlock operation the waiter gets a wake-up
but before he gets a chance to acquire the lock, it is already taken and
he goes back to sleep again. While this looks painful it might be better
performance wise because the other task was able to acquire the lock
without waiting. But then it is not fair and this happens.
One thing that I'm curious about is, what lock is it (one or two global
hot spots or many). And how to benchmark this=E2=80=A6

> > > Fixes: 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock =
stealing")
> > > Reported-by: Mike Stowell <mstowell@redhat.com>
> > > Signed-off-by: Waiman Long <longman@redhat.com>
>=20
> Thanks for your time looking at the patch.

no problem.

> Cheers,
> Longman

Sebastian
