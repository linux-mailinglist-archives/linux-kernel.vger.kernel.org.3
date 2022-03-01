Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1914C90EA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiCAQxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiCAQxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:53:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BB4427F6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:52:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F9FC60F38
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 16:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10C1C340EE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646153564;
        bh=1tHh3nhKSXOYQ2q6r97FYV9g+H4AjRshQvzrxNnBogU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cmp64ulMygyV7CSU7d9NYmlRmC9dojzyFswq/07cTz61xgeDfpELD18roHgEyMwBb
         ltI5yP9WSu2jheQeLbUUHqyXA80rbAuUFlqhW+IAm+xmq7fLbKhmGYc9QNMf5UNb0l
         yc4wUBXLi0TIIqDqiOkhzrpvhl6tgUVG3pO8S/JwWKVY8vCi+oOY6aC8uuRLcnIsKs
         Z9E5PRKT3E9HSOxHhr1PozX6DfBUufEpru+K4FsUgXWU4EZUubAn2H2b/eFY+UHGFA
         /7RcSOYg/RjtcPpTIpi/MKCc1cBdGqNOZltmBaIvG68c+9yr31iITO3qLlRjIc31zd
         F4wx+Puk1b8AQ==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2dbd97f9bfcso33422077b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 08:52:44 -0800 (PST)
X-Gm-Message-State: AOAM530Eao6VutGc2ycJYD3tAJM0hYRYt9pbDlFXEuwZqB98hEPx0uMe
        HRJBBsuEkXg9EPcvOwcfwmDmR+gPwkYFSCaD1Zo=
X-Google-Smtp-Source: ABdhPJzk6Aq8yFjG8B63lv/pFfFQ4h/4giGtECsDrMe93FHunWY83IBQwfMx/4FmeaN2Ye/lWGUtZwVw4qjKYgpQuXc=
X-Received: by 2002:a0d:dfd5:0:b0:2cf:924b:105d with SMTP id
 i204-20020a0ddfd5000000b002cf924b105dmr26967912ywe.342.1646153563719; Tue, 01
 Mar 2022 08:52:43 -0800 (PST)
MIME-Version: 1.0
References: <Yh5ASXVoWoMj7/Rr@Red> <Yh5AlfprVAZvJDJA@shell.armlinux.org.uk> <CAMj1kXGRTM99F_Q29Q4G2Q4L6WSHn2YY+_QZCXQGmw=yWPe1mQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGRTM99F_Q29Q4G2Q4L6WSHn2YY+_QZCXQGmw=yWPe1mQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 1 Mar 2022 17:52:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEy6n3zZ8Z51kP=tTuOU0xCXLLfC-b6BMpdsjMoM7zGBg@mail.gmail.com>
Message-ID: <CAMj1kXEy6n3zZ8Z51kP=tTuOU0xCXLLfC-b6BMpdsjMoM7zGBg@mail.gmail.com>
Subject: Re: boot flooded with unwind: Index not found
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 at 17:37, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 1 Mar 2022 at 16:52, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Mar 01, 2022 at 04:48:25PM +0100, Corentin Labbe wrote:
> > > Hello
> > >
> > > I booted today linux-next (20220301) and my boot is flooded with:
> > > [    0.000000] unwind: Index not found c0f0c440
> > > [    0.000000] unwind: Index not found 00000000
> > > [    0.000000] unwind: Index not found c0f0c440
> > > [    0.000000] unwind: Index not found 00000000
> > >
> > > This happen on a sun8i-a83t-bananapi-m3
> >
> > Have you enabled vmapped stacks?
> >
>
> This is probably related to
>
> 538b9265c063 ARM: unwind: track location of LR value in stack frame
>
> which removes a kernel_text_address() check on frame->pc as it is
> essentially redundant, given that we won't find unwind data otherwise.
> Unfortunately, I failed to realise that the other check carries a
> pr_warn(), which may apparently fire spuriously in some cases.
>
> The 0x0 value can easily be filtered out, but i would be interesting
> where the other value originates from. We might be able to solve this
> with a simple .nounwind directive in a asm routine somewhere.
>
> I'll prepare a patch that disregards the 0x0 value - could you check
> in the mean time what the address 0xcf0c440 coincides with in your
> build?

Something like the below should restore the previous behavior, while
taking the kernel_text_address() check out of the hot path.

--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -400,7 +400,8 @@ int unwind_frame(struct stackframe *frame)

        idx = unwind_find_idx(frame->pc);
        if (!idx) {
-               pr_warn("unwind: Index not found %08lx\n", frame->pc);
+               if (frame->pc && kernel_text_address(frame->pc))
+                       pr_warn("unwind: Index not found %08lx\n", frame->pc);
                return -URC_FAILURE;
        }
