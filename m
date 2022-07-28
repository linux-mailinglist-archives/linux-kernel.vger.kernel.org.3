Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B720B58433C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiG1Pk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiG1PkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27CF4E61E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5914E61BCE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79CEC433C1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659022822;
        bh=PnLRe8DPgb5C0NP0/UiXF6v21WnJVk8lR9e0zQ/5llA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dh+X8XvXY5meH2t+/EOJBb8EJ05RtHBrDLsCrwBS8rt3FBD+c9WjR0aaUsBDuGf2Q
         KVrRL7R2jBOVPbvBzGTP56dozkT+STgpgCKGAJ4HIeA+CFj+qrergLUicqU28RRi0v
         3LgnRqgiGBkn3yU+0PpvxL2sflnNS3c/4IhRrbWPIT0Go/3phVSrC9IlGmrLPQJJFG
         mfZZjbFHJJxg+9A4JQ7nNmz33aFvnW/yWrzijC3jsc18C1LZA1PS41yEV9Pv94XTnL
         rA/r84vZ0ypnHZCUXYT+gBkffTzI2Ku5CSOwOQcFroD7Mcy9ddSBVAwEFQtmQrF90H
         IH0e717VUbCbw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-f2a4c51c45so2749727fac.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:40:22 -0700 (PDT)
X-Gm-Message-State: AJIora/foIS3MmSBJjSq3RRSlcZohHL3ScWEZdZTEQ5+0VoQqhKhft/C
        fkcpF9BBSoB4xwDg+qUqMVjEsHXexNZJ6tjQwxc=
X-Google-Smtp-Source: AGRyM1u4gYleexKCkLgdyIM/RvOWOKlFlOBMtqt7iI88zBRdD9Ur32A2D/5F/TDRxWlg2MT+HljQbgOG3xn7at7tM2g=
X-Received: by 2002:a05:6870:a90a:b0:10d:9e83:98a6 with SMTP id
 eq10-20020a056870a90a00b0010d9e8398a6mr17264oab.228.1659022821818; Thu, 28
 Jul 2022 08:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220709084830.3124-1-jszhang@kernel.org> <CAMj1kXEy7_zyDqQC_e9Rf1a8HuMBz_HbZOAP-WBzeeDVu8Mwmw@mail.gmail.com>
 <YuKh2pmJC6/17Riy@xhacker> <YuKokvBjDxATePpH@xhacker>
In-Reply-To: <YuKokvBjDxATePpH@xhacker>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 28 Jul 2022 08:40:10 -0700
X-Gmail-Original-Message-ID: <CAMj1kXFQ86TgA-tUM4C5-LryDiry4w0uDo=TNdBPOiJvT1UXcQ@mail.gmail.com>
Message-ID: <CAMj1kXFQ86TgA-tUM4C5-LryDiry4w0uDo=TNdBPOiJvT1UXcQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: save movk instructions in mov_q when the lower
 16|32 bits are all zero
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 at 08:26, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On Thu, Jul 28, 2022 at 10:49:02PM +0800, Jisheng Zhang wrote:
> > On Wed, Jul 27, 2022 at 08:15:11AM -0700, Ard Biesheuvel wrote:
> > > On Sat, 9 Jul 2022 at 01:58, Jisheng Zhang <jszhang@kernel.org> wrote:
> > > >
> > > > Currently mov_q is used to move a constant into a 64-bit register,
> > > > when the lower 16 or 32bits of the constant are all zero, the mov_q
> > > > emits one or two useless movk instructions. If the mov_q macro is used
> > > > in hot code path, we want to save the movk instructions as much as
> > > > possible. For example, when CONFIG_ARM64_MTE is 'Y' and
> > > > CONFIG_KASAN_HW_TAGS is 'N', the following code in __cpu_setup()
> > > > routine is the pontential optimization target:
> > > >
> > > >         /* set the TCR_EL1 bits */
> > > >         mov_q   x10, TCR_MTE_FLAGS
> > > >
> > > > Before the patch:
> > > >         mov     x10, #0x10000000000000
> > > >         movk    x10, #0x40, lsl #32
> > > >         movk    x10, #0x0, lsl #16
> > > >         movk    x10, #0x0
> > > >
> > > > After the patch:
> > > >         mov     x10, #0x10000000000000
> > > >         movk    x10, #0x40, lsl #32
> > > >
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > >
> > > This is broken for constants that have 0xffff in the top 16 bits, as
> > > in that case, we will emit a MOVN/MOVK/MOVK sequence, and omitting the
> > > MOVKs will set the corresponding field to 0xffff not 0x0.
> >
> > Thanks so much for this hint. I think you are right about the 0xffff in
> > top 16bits case.
> >
>
> the patch breaks below usage case:
> mov_q x0, 0xffffffff00000000
>
> I think the reason is mov_q starts from high bits, if we change the
> macro to start from LSB, then that could solve the breakage. But this
> needs a rewrite of mov_q

No it has nothing to do with that.

The problem is that the use of MOVN changes the implicit value of the
16-bit fields that are left unspecified, and assigning them in a
different order is not going to make any difference.

I don't think we should further complicate mov_q, and I would argue
that the existing optimization (which I added myself) is premature
already: in the grand scheme of things, one or two instructions more
or less are not going to make a difference anyway, given how rarely
this macro is used. And even if any of these occurrences are on a hot
path, it is not a given that shorter sequences of MOVZ/MOVN/MOVK are
going to execute any faster, as the canonical MOVZ/MOVK/MOVK/MOVK
might well decode to fewer uops.

So in summary, let's leave this code be.
