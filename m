Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B5C4EC9E5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348990AbiC3QrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348998AbiC3QrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:47:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B535125DA82
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4650D617E4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3CFC34110
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648658730;
        bh=tehy4fHX+fMMENwFIm23z4gzb7EwaFuXoodcZ5+V27o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Td1kpocYHFTaB9eUIqD3NNf1L3jLMoGgepA24KfMV7j4b8W1lKrQh9bTu8sKWcfRX
         Uk/Xk4X8KmPdHSE17nexD4LqqoWJSYSda032DDneslxAZTE+MpBdk4O6Q+L8ZFuEkS
         x+zfq7Ga+lW0iU8BGxAkJT1ygpsYUevmiv4srHHFAhJc+V24AohL9m5UkpmB6i6Asi
         VcfXYM4QtApqgSi3vfj4Isx7NOWhHt8qmZXO3NSuEh8vp8YqQjc3yVLKT8yRPgIMYz
         DVxuNFsCUjh5Eaq1WwB484tj5l+XGhk1PKRWa1Z1Hmf2xmbRxx5+65GkfAqgJ8ghTx
         RuQj9tgYCz8Yw==
Received: by mail-oi1-f172.google.com with SMTP id q189so22579663oia.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:45:30 -0700 (PDT)
X-Gm-Message-State: AOAM5319OVfrgrwa3RpVQ/Ft6nabepxTW2pbPF1rvpa5aFzOA3pn3hsq
        BT6lGpchSdvkRSYQ2FtlPjDhohaW93ssO5Jsmxw=
X-Google-Smtp-Source: ABdhPJwBoN0uG1mMLGLZK9UjENjN3bUI1x0D1u1hskI6ccwVubYyNW6mi5ndVVDJ8ZEd1vVoEjyEOIJXmcjdMeR+Dj8=
X-Received: by 2002:aca:674c:0:b0:2d9:c460:707c with SMTP id
 b12-20020aca674c000000b002d9c460707cmr321468oiy.126.1648658729844; Wed, 30
 Mar 2022 09:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <YipOoAaBIHjeCKOq@dev-arch.thelio-3990X> <2109354.irdbgypaU6@localhost.localdomain>
 <YkSBJD0oA7zxHS+B@shell.armlinux.org.uk> <CAMj1kXGLehBkaG7-t5PZqN+32MS-5BDX-QGOe6ftZnPuNDKicg@mail.gmail.com>
 <YkSHJ65qGHO4bonJ@shell.armlinux.org.uk>
In-Reply-To: <YkSHJ65qGHO4bonJ@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Mar 2022 18:45:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFcrG6TrSU+KcmXCVM7ZWZ2fMjiN8c_dtEwxBugJS_UAQ@mail.gmail.com>
Message-ID: <CAMj1kXFcrG6TrSU+KcmXCVM7ZWZ2fMjiN8c_dtEwxBugJS_UAQ@mail.gmail.com>
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

On Wed, 30 Mar 2022 at 18:37, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Mar 30, 2022 at 06:34:25PM +0200, Ard Biesheuvel wrote:
> > On Wed, 30 Mar 2022 at 18:12, Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Tue, Mar 22, 2022 at 06:49:17PM +0100, Christian Eggers wrote:
> > > > Hi Nathan, hi Russel,
> > > >
> > > > I stumbled today over the same problem (no output on serial console
> > > > with v5.15.28-rt36). During `git bisect`, I had also some commits
> > > > where a few lines of output were visible.
> > > >
> > > > At commit 8d9d651ff227 ("ARM: use LOADADDR() to get load address of
> > > > sections"), the system boots up to here:
> > > >
> > > > start_kernel()
> > > > +--setup_arch()
> > > >    +--paging_init()
> > > >       +--devicemaps_init()
> > > >          +--eary_trap_init(vectors_base = 0xC7FFE000)
> > > >             +--copy_from_lma(vectors_base = 0xC7FFE000, __vectors_start=0x0, __vectors_end=0x20)
> > > >                +--__memcpy()
> > > >
> > > >                copy_template.S:113
> > > >                ldr8w   r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> > > >                r1 = 0
> > > >
> > > >
> > > > With the final v5.15.28-rt36 I found out that the system boots fine
> > > > after disabling CONFIG_HARDEN_BRANCH_HISTORY.
> > > >
> > > > Is there anything else I could analyze? My SoC system is a NXP i.MX6LL
> > > > with a ARMv7 core. I have access to a JTAG debugger.
> > >
> > > I think this is already fixed in mainline. Commit:
> > >
> > > 6c7cb60bff7a ("ARM: fix Thumb2 regression")
> > >
> >
> > It's still broken - I sent a couple of patches on Monday, among which
> > one to fix the boot issue with loop8 on Thumb2. The problem is 'b . +
> > 4', which produces a narrow encoding, and so it skips the subsequent
> > subs instruction and loops forever.
>
> And what's the current status? Sorry, I've way too much email from the
> last 2.5 weeks to find it myself.
>

https://lore.kernel.org/linux-arm-kernel/20220328134714.205342-1-ardb@kernel.org/

Nobody bothered to respond yet, I can drop the first two in the patch
tracker if you like.
