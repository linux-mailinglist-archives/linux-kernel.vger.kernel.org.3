Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CFE53FE97
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243595AbiFGMUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243728AbiFGMSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA453FB438
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:16:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F66B61743
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B7FC385A5;
        Tue,  7 Jun 2022 12:16:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="T6/Fm3Fy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654604188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXYCtnOH8D/QyBftfo4H/7oIrSJ0X4hdAIqvoJRWank=;
        b=T6/Fm3FyMhMiN9DD76jPM48CkpOZQvzHNz4hO6fSgwEueVDEPb4Y0MnYeGOopyMWkGod02
        tnkvt2LTQB3NCTfFan0tEUQd/wXLcmvOdbJ9G5aQQ2GLuJW12/a5N0ojpIxkfNt5c44trd
        KWdY2Nm5mFiDhEfG0Gx0yl0V+rK/xGQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 04ff6650 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 7 Jun 2022 12:16:28 +0000 (UTC)
Date:   Tue, 7 Jun 2022 14:16:24 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH] random: do not use jump labels before they are
 initialized
Message-ID: <Yp9BmEyOvVitZICT@zx2c4.com>
References: <20220607100210.683136-1-Jason@zx2c4.com>
 <CAMj1kXEAuh-tokcqvKCQF5Vq+jZKj4ZM=PyGaHKapXPJKVyOrg@mail.gmail.com>
 <Yp8oOH+9V336LrLk@zx2c4.com>
 <Yp8rcFrqK/IkzKXj@zx2c4.com>
 <CAMj1kXHV833uMJYrdUagJpH5hoj4ivC6zxMJvNnxLAF2NG3_sg@mail.gmail.com>
 <Yp8wz2Ey4J4u+ZlK@zx2c4.com>
 <CAMj1kXFK9pFUdOABKP0Zp7tEJNVS1dTjxp5DgSwqzM8TEYJLTQ@mail.gmail.com>
 <Yp839NjwW3scZEqi@zx2c4.com>
 <CAMj1kXF7NToZgAW66puCOwc1+d7ZTmVm_CbDYEeH+j0XJH1vug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXF7NToZgAW66puCOwc1+d7ZTmVm_CbDYEeH+j0XJH1vug@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Jun 07, 2022 at 02:03:28PM +0200, Ard Biesheuvel wrote:
> On Tue, 7 Jun 2022 at 13:35, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi Ard,
> >
> > On Tue, Jun 07, 2022 at 01:10:52PM +0200, Ard Biesheuvel wrote:
> > > Fair enough. What I would like is to remove the need to play around
> > > with the placement of jump_label_init() across architectures. Jump
> > > labels are fundamentally a performance optimization, so unless you can
> > > explain how setting it as early as possible makes a material
> > > difference, performance or otherwise, I really think we should pursue
> > > a solution that does the static key manipulation at some later time.
> >
> > Alright. It sounds like Catalin also prefers the same. This seems simple
> > enough with minimal downsides: https://lore.kernel.org/lkml/20220607113238.769088-1-Jason@zx2c4.com/
> >
> 
> That looks simple enough. Do we risk causing any boot stalls due to
> the crediting being deferred? Or new warnings about randomness being
> used before CRNG is ready?

We don't risk boot stalls. But there will be warnings for developers who
have enabled the CONFIG_WARN_ALL_UNSEEDED_RANDOM debug option.


> > So maybe we should just go that route.
> >
> 
> It is not my preferred approach, but I can live with it.

I'm not sure what your preferred approach is at this point in time
actually. I'll summarize all the approaches discussed so far:

1) Fix archs to initialize jump labels earlier:
   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=73e2d827a501
   https://lore.kernel.org/lkml/20220603121543.360283-1-Jason@zx2c4.com/

2) Defer mixing & crediting until random_init():
   https://lore.kernel.org/lkml/20220607111514.755009-1-Jason@zx2c4.com/

3) Defer crediting (but not mixing) until random_init():
   https://lore.kernel.org/lkml/20220607113238.769088-1-Jason@zx2c4.com/

4) Defer changing the static branch (but neither mixing nor crediting) until random_init():
   https://lore.kernel.org/lkml/20220607100210.683136-1-Jason@zx2c4.com/


My first choice is (1) if it's feasible.

(2) is not possible without introducing a copy, so that's out.

What's your preferred approach? Or is there a number 5 you have in mind?

Jason
