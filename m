Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4414AF215
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiBIMt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiBIMt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:49:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5033AC0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 04:49:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEF15B820C6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659D9C340EF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:49:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Pj5GlnNW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644410992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UIB+abzRxDWUaHdqqp7GdEKCICHsGlT0j5x1UUeTGBo=;
        b=Pj5GlnNWAoCfOSTEgBcDkr+ID19WAIAdEto7y1ygm5Fqw39jrvOkXALqNYjn8sNsMiEjSk
        V4exleE0wpd2mP7xuZLWfje/3UBvbCgOQRPbg13HdlEMFF98iDQIBNHsL2OkBkaT6QRsd+
        Kw/hgeVe1R1tpvRkf4DrufQIZJLGIC4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3eeefe25 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 9 Feb 2022 12:49:52 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id 192so5472288ybd.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 04:49:51 -0800 (PST)
X-Gm-Message-State: AOAM532RmxpKCUfDXKMITUnbk+iEt4CGUEgOAkMclwF8L2IU8zLpiswf
        5weBa52931/r9Y6XlMv3GJuy9ryUbGpN8rukB7o=
X-Google-Smtp-Source: ABdhPJyqS2MLElCaeTviigpjpVw/Rzols6JnG2o+ZHNEQk7NszyAMO70N8t8W0y7ZuM8DjmZ7GST+fCOxreM71o8Xgg=
X-Received: by 2002:a81:c40d:: with SMTP id j13mr1913737ywi.499.1644410990717;
 Wed, 09 Feb 2022 04:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20220207153914.365931-1-Jason@zx2c4.com> <20220207153914.365931-3-Jason@zx2c4.com>
 <YgMG7niyv2+zzSWf@sol.localdomain> <CAHmME9rNv78wKvTNEvKVoC_CcxtVJdDU0cJvxjTYans1eugZqw@mail.gmail.com>
In-Reply-To: <CAHmME9rNv78wKvTNEvKVoC_CcxtVJdDU0cJvxjTYans1eugZqw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 9 Feb 2022 13:49:39 +0100
X-Gmail-Original-Message-ID: <CAHmME9pUBX6rFcQtviu12TXVaj=J31o5N14aJ=xSN4KG4boTLA@mail.gmail.com>
Message-ID: <CAHmME9pUBX6rFcQtviu12TXVaj=J31o5N14aJ=xSN4KG4boTLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] random: defer fast pool mixing to worker
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 1:36 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Wed, Feb 9, 2022 at 1:12 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > So, add_interrupt_randomness() can execute on the same CPU re-entrantly at any
> > time this is executing?  That could result in some pretty weird behavior, where
> > the pool gets changed half-way through being used, so what is used is neither
> > the old nor the new state of the pool.  Is there a reason why this is okay?
>
> Yes, right, that's the "idea" of this patch, if you could call it such
> a thing. The argument is that we set fast_pool->count to zero *after*
> mixing in the existing bytes + whatever partial bytes might be mixed
> in on an interrupt halfway through the execution of mix_pool_bytes.
> Since we set the count to zero after, it means we do not give any
> credit to those partial bytes for the following set of 64 interrupts.
> What winds up being mixed in will contain at least as much as what was
> there had it not been interrupted. And what gets mixed in the next
> time will only have more mixed in than it otherwise would have, not
> less.

I can actually make it even better by memcpy()ing the fast pool first.
This way any races only affect the fast_mix side -- harmless as
described above -- without affecting blake2s. The latter was _already_
buffering it, but memcpy()ing makes it more clear and doesn't rely on
that behavior. It also means that we get to set count to zero a bit
sooner.
