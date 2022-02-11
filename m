Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133FD4B2B87
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351962AbiBKRPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:15:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiBKRPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:15:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCEF102;
        Fri, 11 Feb 2022 09:15:40 -0800 (PST)
Date:   Fri, 11 Feb 2022 18:15:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644599738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJyDYqDoqp3BOO8EG/GCK9HSjsIr9kXicPv+GzkWx1A=;
        b=ebryZ/ovTvyftldBlOHY/pFQryX7LYnwAp4COiGEEXAX7bZl2X1U4ggtgMm4IPwogJ8toy
        GSUNkza8AaP8Yn/i6tGZT2ymAVH5ZuvHGdB9K4qxneXQX6fRAwgS8AeduKqqxWwSmvw8bk
        v/O4GBNF0aO5TjJjeTSk5cm2/RNzdVmmkeUUKRy0/SwB3+ok20thXVpcwPBNTuVxG1Odlm
        c7u1rFkpksOSdHqFFBPhcxQhLLeZ+iBK2hF67Gvm8oHlUSO+CGIKz6QIm0xKZ7+tyExyom
        9tBj7VUN+q9bf9D/8el8jUwESzTm13y2/Jq8vNQnGeVtzvPKjvy2YAAGs8QCJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644599738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJyDYqDoqp3BOO8EG/GCK9HSjsIr9kXicPv+GzkWx1A=;
        b=0CWjWOEnQbWaB3Z4tTafewf+JVbcOzU/wcNrqdku2B6LXM7m5MNTlF6sBPbTCy0zz/9/xV
        YQ9T13Gvj2NipCBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v6] random: defer fast pool mixing to worker
Message-ID: <YgaZuShru2HQiFXg@linutronix.de>
References: <YgZ6IEbiDgz5X1ON@linutronix.de>
 <20220211162515.554867-1-Jason@zx2c4.com>
 <YgaSYlVEBOxfJbSD@linutronix.de>
 <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
 <YgaV0UZO1KfmtLLh@linutronix.de>
 <CAHmME9qR02XCX48D+AoT1rOFyNo_GXubyHPzoX01BYkJDX7p1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9qR02XCX48D+AoT1rOFyNo_GXubyHPzoX01BYkJDX7p1A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-11 18:00:21 [+0100], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> On Fri, Feb 11, 2022 at 5:59 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > > Okay, I'll do that then, and then in the process get rid of the
> > > cmpxchg loop since it's no longer required.
> >
> > So the only reason why we have that atomic_t is for rare case where run
> > on the remote CPU and need to remove the upper bit in the counter?
> 
> Yes. That's the only remaining reason. Annoying, but whatareyagonnado?

A CPU hotplug notifier which removes unconditionally that bit when the
CPU goes down or sets it to 0.
We can keep it as it. Just an idea for later maybe ;)

> Jason

Sebastian
