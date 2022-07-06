Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38726567BF3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 04:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiGFCf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 22:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiGFCfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 22:35:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC0F1ADA2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 19:35:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3EF7B81992
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27E6C385A2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657074928;
        bh=odXUxn3yXrrHvlOzMGJbrTaSnOuDZ37Y8U+5wx5W1MI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r5s7HV8LvjO7Zm91/Mi+t9brclcE3n7WL/sLiQeWCFrKQzOzDQ33hNo5GbGqhXpeY
         F71n5aDP7thfGo52pcvGEemJaoTHD5Jg4zekdbwa4NH7V+CpxoHU/Laoy8aQ2Pn3wN
         w3+vaSiO/HT2NWkLCy+ZO15WkEBzNZLVbAKXzJzmd1N3/Lc5B4pSRiR6LOKIEw+FsG
         syThcgGdfYGPlQS+L5T1UT1DJOb929oOnRgU0YTD1xbTmlUmEy7P80TclO/uwEitW5
         NZdH/td57GJvjs2PRuMpjokgkzd3WL1fQw31A3HUJ8XMEH+YAU1evurM4Ha/H2776W
         LI4dOl+AmU2RA==
Received: by mail-vk1-f181.google.com with SMTP id b81so6781509vkf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 19:35:28 -0700 (PDT)
X-Gm-Message-State: AJIora9KBwS3XfPs1ujmAtsbdugq47ZyUfDo13pkIUiCb3c0nqtKv4x7
        j06aITpd/b81xrJBu5m6yhpwkKlIfEkjVzPxWoc=
X-Google-Smtp-Source: AGRyM1uAngO5m2udrmv51xAN0r4gQJS2lYeBLGvNMMaEU2T4TxWx008yRfQwpEADKLejzKbcgCLBxNFrv0kYPr/yo+Y=
X-Received: by 2002:a1f:17d2:0:b0:374:3ca2:def3 with SMTP id
 201-20020a1f17d2000000b003743ca2def3mr11377vkx.18.1657074927520; Tue, 05 Jul
 2022 19:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220704153612.314112-1-huqi@loongson.cn> <4273e104-8392-6a06-5d18-a1933978d8c3@xen0n.name>
 <22a1ba993e298ce12a374decefebeca484240883.camel@xry111.site> <16c9ccaa5e5a2ffd39272cff6f66e487c659b571.camel@xry111.site>
In-Reply-To: <16c9ccaa5e5a2ffd39272cff6f66e487c659b571.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 6 Jul 2022 10:35:15 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5+qd1ZrOqE8fgRmWshXy57AfEFpyKSK8ZstZZEQ53owQ@mail.gmail.com>
Message-ID: <CAAhV-H5+qd1ZrOqE8fgRmWshXy57AfEFpyKSK8ZstZZEQ53owQ@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Clean useless vcsr in loongarch_fpu.
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     WANG Xuerui <kernel@xen0n.name>, Qi Hu <huqi@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

On Tue, Jul 5, 2022 at 6:01 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Tue, 2022-07-05 at 17:49 +0800, Xi Ruoyao wrote:
> > On Tue, 2022-07-05 at 16:46 +0800, WANG Xuerui wrote:
> >
> > > Actually I'm still not very satisfied with the explanation; the code
> > > must be written with *something* in mind, since GS464V/LA464 is the only
> > > LoongArch implementation so far, it must have a VCSR to begin with. And
> > > you can't magically melt the VCSR on the tens of thousands of
> > > 3A5000/3C5000's already shipped, because the old-world kernel obviously
> > > comes with LSX/LASX and it most likely utilizes the VCSR. In addition,
> > > you didn't mention what will happen if LSX/LASX *is* enabled on this
> > > new-world kernel, *and* fcsr16 is being accessed.
> > >
> > > I think maybe you just want to remove the mentions of VCSR since they
> > > are dead code right now, as I don't believe it's gone in shipped
> > > hardware, as explained above. Except if there's magically a way to
> > > implement LSX/LASX without touching the said-to-have-disappeared VCSR,
> > > which I don't know of, and can't know because the LSX/LASX ISA manual is
> > > still not publicly accessible; so I don't feel comfortable approving
> > > this patch.
> >
> > Let me make some bold guess here.  In the MIPS-compatible 3A4000 we had
> > "MSACSR" register.  According to the MSA manual, only the 24-th bit of
> > this register is used:
> >
> > "Some MSA floating point instructions might not handle subnormal input
> > operands or compute tiny non-zero results. Such instructions may signal
> > the Unimplemented Operation Exception and let the software emulation
> > finalize the operation. If software emulation is not needed or desired,
> > MSACSR FS bit could be set to replace every tiny non-zero result and
> > subnormal input operand with zero of the same sign."
> >
> > And, it says:
> >
> > "Should the alternate exception handling attributes of the IEEE Standard
> > for Floating-Point Arithmetic 754-2008, Section 8 be desired, the MSACSR
> > FS bit should be zero, the Underflow Exception be enabled and a trap
> > handler be provided to carry out the execution of the alternate
> > exception handling attributes."
> >
> > We can see Loongson has been trying to make 3A processors more IEEE-754
> > compatible.  For example, 3A4000 is the only non-R6 MIPS-compatible
> > processor using IEEE-754-2008 NaN encoding.  And LoongArch manual
> > directly refers to IEEE-754-2008 manual in many places.  So I guess this
> > change means Loongson won't set this bit to 1 for 3A5000 at all, and any
> > attempt by the user to set this bit could be considered undefined
> > behavior (causing inconsistent behavior on 3A5000 as the kernel doesn't
> > save/restore VCSR at context switch, and SIGILL on 3A6000 as the
> > register is removed).
>
> P. S. I'm just playing an "intelligence game" writing the reply so maybe
> I'm completely wrong.  And, it does not indicate any position of me or
> my affiliation about some "controversial topics".  And, even if my guess
> is correct, it's still better to add something like "the use of VCSR is
> optional in LA464 and we've decided to remove it in future
> architectures, so it's not supported to use it even on LA464" into the
> commit message.

Maybe Xuerui and Ruoyao have some misunderstanding. LSX/LASX will
surely be upstream, this has nothing to do with cleanup VCSR16.
Because FP/LSX/LASX share the same control bits in FCSR now. Am I
right? Qi Hu?

If I'm right, Qi Hu, please tell us what control bits were in VCSR16,
and where their replacements in FCSR are. Thanks.

Huacai

> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
