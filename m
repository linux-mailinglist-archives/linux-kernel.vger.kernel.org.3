Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2F14ECAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349440AbiC3Rod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343849AbiC3Roa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:44:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9A9F47CF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:42:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FB4E618A9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D72C36AE3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648662163;
        bh=I2nwMsi0ASZuANmFO4D1q4EQjpFm+YKdWDV/S1qQdgI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FZ2l9bRDejt84c449bQ8hFmBugEh4ngaORwyNebdds5Vjs+hO4eIfYlYJldqQ3nNK
         QCwl50twfPNO3ziojiuMerBKvGxxIub990HcMr86mBlfRm1aBkVZiM2NPYYYOLhVBW
         aS8YJiKmZZTer9XXLLNYxigFLQRgD0PhyiC+4EcWIKcdCQUmTPtDpxcGKkEkEVcH5a
         TzLAsk//ijZ6Aa4F+8YixhuqkQJvq2/gCYnJfU2UhK7IAlBBJmk2w+5VxL5M2gKlUs
         n94ZlOCC2mcah6c0U0vFQ6di2PkqooUItM2L1jYnyokumZ/C4EhpE41PH9iZDL8mkS
         ZqBQAfZ3rjTkQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so22762219fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:42:43 -0700 (PDT)
X-Gm-Message-State: AOAM530N0S5ZBfOrwWgjtMlO5QfD/nPh1u+KmZnrLbgwqZE3IwsZd9XZ
        Zoyz0wYk3R9ceuhXddiGoq9PCXEWAI3rrI2KVe0=
X-Google-Smtp-Source: ABdhPJxVwc1vcsNmifyLf6iCDsIRT/4G7CdnAH+8eeTpR1xBYRGvRayW8V+k/WnefL7MglY1+3MBxoJgQt3zkfQEiW8=
X-Received: by 2002:a05:6870:b027:b0:de:7fcd:fabf with SMTP id
 y39-20020a056870b02700b000de7fcdfabfmr431384oae.126.1648662162730; Wed, 30
 Mar 2022 10:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <YipOoAaBIHjeCKOq@dev-arch.thelio-3990X> <YkSHJ65qGHO4bonJ@shell.armlinux.org.uk>
 <CAMj1kXFcrG6TrSU+KcmXCVM7ZWZ2fMjiN8c_dtEwxBugJS_UAQ@mail.gmail.com> <10062923.nUPlyArG6x@localhost.localdomain>
In-Reply-To: <10062923.nUPlyArG6x@localhost.localdomain>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Mar 2022 19:42:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGbNtJPEowha8=vFgjdv_m2viHJ2Q7AqtJeqOPLa8-1Sg@mail.gmail.com>
Message-ID: <CAMj1kXGbNtJPEowha8=vFgjdv_m2viHJ2Q7AqtJeqOPLa8-1Sg@mail.gmail.com>
Subject: Re: CONFIG_THUMB2_KERNEL=y boot failure after Spectre BHB fixes
To:     Christian Eggers <ceggers@arri.de>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
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

On Wed, 30 Mar 2022 at 19:33, Christian Eggers <ceggers@arri.de> wrote:
>
> On Wednesday, 30 March 2022, 18:45:18 CEST, Ard Biesheuvel wrote:
> >
> On Wed, 30 Mar 2022 at 18:37, Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Wed, Mar 30, 2022 at 06:34:25PM +0200, Ard Biesheuvel wrote:
> > > > On Wed, 30 Mar 2022 at 18:12, Russell King (Oracle)
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Tue, Mar 22, 2022 at 06:49:17PM +0100, Christian Eggers wrote:
> > > > > > Hi Nathan, hi Russel,
> > > > > >
> > > > > > I stumbled today over the same problem (no output on serial console
> > > > > > with v5.15.28-rt36). During `git bisect`, I had also some commits
> > > > > > where a few lines of output were visible.
> > > > > >
> > > > > > At commit 8d9d651ff227 ("ARM: use LOADADDR() to get load address of
> > > > > > sections"), the system boots up to here:
> > > > > >
> > > > > > start_kernel()
> > > > > > +--setup_arch()
> > > > > > +--paging_init()
> > > > > > +--devicemaps_init()
> > > > > > +--eary_trap_init(vectors_base = 0xC7FFE000)
> > > > > > +--copy_from_lma(vectors_base = 0xC7FFE000, __vectors_start=0x0, __vectors_end=0x20)
> > > > > > +--__memcpy()
> > > > > >
> > > > > > copy_template.S:113
> > > > > > ldr8w r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> > > > > > r1 = 0
> > > > > >
> > > > > >
> > > > > > With the final v5.15.28-rt36 I found out that the system boots fine
> > > > > > after disabling CONFIG_HARDEN_BRANCH_HISTORY.
> > > > > >
> > > > > > Is there anything else I could analyze? My SoC system is a NXP i.MX6LL
> > > > > > with a ARMv7 core. I have access to a JTAG debugger.
> > > > >
> > > > > I think this is already fixed in mainline. Commit:
> > > > >
> > > > > 6c7cb60bff7a ("ARM: fix Thumb2 regression")
> > > > >
> > > >
> > > > It's still broken - I sent a couple of patches on Monday, among which
> > > > one to fix the boot issue with loop8 on Thumb2. The problem is 'b . +
> > > > 4', which produces a narrow encoding, and so it skips the subsequent
> > > > subs instruction and loops forever.
> > >
> > > And what's the current status? Sorry, I've way too much email from the
> > > last 2.5 weeks to find it myself.
> > >
> >
> > https://lore.kernel.org/linux-arm-kernel/20220328134714.205342-1-ardb@kernel.org/
> >
> > Nobody bothered to respond yet, I can drop the first two in the patch
> > tracker if you like.
>
> I just switched to v5.15.31-rt38 which already includes
> 6c7cb60bff7a ("ARM: fix Thumb2 regression")
>
> This kernel boots fine now, even with CONFIG_HARDEN_BRANCH_HISTORY=y. After
> applying the patch series from Ard, the system still boots fine.
>
> I haven't any understanding what these patches do. Is there anything I shall
> test?
>

Thanks for confirming. The first fix affects all Thumb2
configurations, my patch only affects Thumb2 configurations that
actually enable the loop8 mitigation for Spectre-BHB.

What type of CPU are you booting on?
