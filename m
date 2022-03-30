Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB584EC9BF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348860AbiC3Qgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348865AbiC3Qg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:36:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA8D193162
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E60DEB81D7D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECFFC3410F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648658077;
        bh=XxksR6VYfpVoCvd6RFZQQ4LAgDvEsQYSq1TNcOzLoUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fu+2gLX21a8OwVa/+N7C35Y49yttDoosDiB88ncyF2EJRJq1Y1Lm1QmWZYUjYPDWB
         LI4c3qy/o8BDQwI3IMF0/BgekvEW6O+eYkafiwwEwNZGYFVZBiuPTILQfhbXRDS4ZX
         5bmSFzBTHiBsFIQmMsqNijGUYmQx12q0ACpwfkKpK7l1tgtZrxPfTCrnxg023PGp23
         BV1vVlOtAX/+ZXz7Xo7iJqqUkB55ywTr1Fw6gTFtSaQ76Uu5Se9yVcLTVl9+AaV8tU
         xuWb3/vi/i8li2xwKeGaIs7LcvMj3y579WIIl0FuBH6UmnJ82b9TeJQa1rgj8C0oVu
         4q5yvWdb1fsIQ==
Received: by mail-oi1-f173.google.com with SMTP id r8so22591668oib.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:34:37 -0700 (PDT)
X-Gm-Message-State: AOAM532r8S5jdRptm38EHfnViLoyRaYpBTwxq1Dv2ZOux3Dm+jFDvTMG
        2epZ7D6YXXBvED2Y6Ix3x1aG+BpglKkEu32i+ng=
X-Google-Smtp-Source: ABdhPJwKJbONlsIybRQcq1GD0q/R2aFe3FxVy2bnvSOqPe2G9QX4krl3/ZC9ysACYk9ULdhpxmWojW5ClA/EpSLmp7o=
X-Received: by 2002:aca:674c:0:b0:2d9:c460:707c with SMTP id
 b12-20020aca674c000000b002d9c460707cmr291303oiy.126.1648658076649; Wed, 30
 Mar 2022 09:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <YipOoAaBIHjeCKOq@dev-arch.thelio-3990X> <2109354.irdbgypaU6@localhost.localdomain>
 <YkSBJD0oA7zxHS+B@shell.armlinux.org.uk>
In-Reply-To: <YkSBJD0oA7zxHS+B@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Mar 2022 18:34:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGLehBkaG7-t5PZqN+32MS-5BDX-QGOe6ftZnPuNDKicg@mail.gmail.com>
Message-ID: <CAMj1kXGLehBkaG7-t5PZqN+32MS-5BDX-QGOe6ftZnPuNDKicg@mail.gmail.com>
Subject: Re: CONFIG_THUMB2_KERNEL=y boot failure after Spectre BHB fixes
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Christian Eggers <ceggers@arri.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 at 18:12, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Mar 22, 2022 at 06:49:17PM +0100, Christian Eggers wrote:
> > Hi Nathan, hi Russel,
> >
> > I stumbled today over the same problem (no output on serial console
> > with v5.15.28-rt36). During `git bisect`, I had also some commits
> > where a few lines of output were visible.
> >
> > At commit 8d9d651ff227 ("ARM: use LOADADDR() to get load address of
> > sections"), the system boots up to here:
> >
> > start_kernel()
> > +--setup_arch()
> >    +--paging_init()
> >       +--devicemaps_init()
> >          +--eary_trap_init(vectors_base = 0xC7FFE000)
> >             +--copy_from_lma(vectors_base = 0xC7FFE000, __vectors_start=0x0, __vectors_end=0x20)
> >                +--__memcpy()
> >
> >                copy_template.S:113
> >                ldr8w   r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> >                r1 = 0
> >
> >
> > With the final v5.15.28-rt36 I found out that the system boots fine
> > after disabling CONFIG_HARDEN_BRANCH_HISTORY.
> >
> > Is there anything else I could analyze? My SoC system is a NXP i.MX6LL
> > with a ARMv7 core. I have access to a JTAG debugger.
>
> I think this is already fixed in mainline. Commit:
>
> 6c7cb60bff7a ("ARM: fix Thumb2 regression")
>

It's still broken - I sent a couple of patches on Monday, among which
one to fix the boot issue with loop8 on Thumb2. The problem is 'b . +
4', which produces a narrow encoding, and so it skips the subsequent
subs instruction and loops forever.
