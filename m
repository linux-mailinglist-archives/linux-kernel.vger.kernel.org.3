Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D238592E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiHOLfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiHOLfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:35:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2944A5F69
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:35:29 -0700 (PDT)
Date:   Mon, 15 Aug 2022 13:35:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660563327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+8j8r/+fxWtGp7ltQZJRssg22z9riGkFL/7W19HGVgw=;
        b=Az2/1EuTkB3aUvY5PgM0oPumTF+GNJmfKg8lDxMhN/I3AutoedY++iaTxoZ6iO53JMFad8
        9GPUtvHV0J/EcqgA/8+dTAnbs0WMpscmoXt4RXsZ5bHYtPvtJqU2fU/dYmYi4nOE46/LSO
        ydOxSlKSB+pBXiTLYglU9eb2w3SiWpFYBVY6wvg1irdDjFEf90cFTIXDV8nQuLW3wy+iFs
        FshHvwqao24VZEO941QhE5+aUh5arVbazaKXEmE1Ii+h04lOZOmQttWQRmN/LlhAdzH0aN
        25Hf2+ViLAfvHeMlIALrVwbgZdc2zdLkBp8iTG2zqT0BzM6nhJL0W06yv/+nAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660563327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+8j8r/+fxWtGp7ltQZJRssg22z9riGkFL/7W19HGVgw=;
        b=A5RYR5HBboV0Y6ooBm/oF6gb7FJPb61MrxG+teQUDlqcUdSibCr6sQ81EfrdX30rOK37NM
        F4GA638Rn/fdJwBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Alasdair Kergon <agk@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/3] dm-verity: optionally use tasklets in dm-verity
Message-ID: <YvovfXMJQAUBsvBZ@linutronix.de>
References: <20220722093823.4158756-1-nhuck@google.com>
 <YtrTI/CJMoLihA/1@infradead.org>
 <YtrahFs5wgweeB7f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YtrahFs5wgweeB7f@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-22 13:12:36 [-0400], Mike Snitzer wrote:
> On Fri, Jul 22 2022 at 12:41P -0400,
> Christoph Hellwig <hch@infradead.org> wrote:
>=20
> > We've been tying to kill off task lets for about 15 years.  I don't
> > think adding new users will make you a whole lot of friends..
>=20
> I don't have perspective on how serious that effort is. But ~2 years
> ago DM introduced another consumer of tasklets in dm-crypt, see:
> 39d42fa96ba1 dm crypt: add flags to optionally bypass kcryptd workqueues

I tried to get rid of the in_atomic() as it appeared work "magic" in
there and in ended in a pointless discussion=E2=80=A6

> Given that, and other numerous users, is the effort to remove tasklets
> valid? What is the alternative to tasklets?

The tasklets end up as anonymous load in the system. It is usually not
visible due to the way accounting usually works (yes we do have full
accounting) and you can't distinguish between work from USB-cam,
storage, =E2=80=A6 if everything is fed into the same context. This becomes=
 a
problem on a smaller/ slower system of one softirq throttles the other
(say the webcam processing gets delayed due to other tasklets).

With the tasklet/BH context you need to disable BH while acquiring a
spin_lock() so this ends up a per-CPU BKL since a random spin_lock_bh()
is also synchronised again the timer as well as large parts of the
networking subsystem and so on. This seems not to bother anyone in
general it becomes a problem on PREEMPT_RT where this becomes visible.

In general, a tasklet runs after the interrupt handler and were
introduced a long time ago, before we had threaded interrupts available.
Therefore threaded interrupts are a good substitute.

> Mike

Sebastian
