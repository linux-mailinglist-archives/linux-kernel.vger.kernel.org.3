Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FCB5899D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbiHDJS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiHDJSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:18:54 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0CC3A481
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:18:53 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31f443e276fso194831127b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 02:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNY7czIwpusO61rJoPeCDEV4Qf2V9wWZoLziIXNiH+s=;
        b=vzFkIV/rafqwxh8Mr8sBx/JfIM48MDGM+Jt/kvgG9oTjkJlm+sJY5zCkmX9IFhsBai
         zDJRaeWnM/aot1ZLjJPo/6qILKNWIwYiWSj8c4uSZ4K9kMeLxTc6tX/TDCYfYrdelfik
         5Iw5oYsxqaYyARR89wCG3L1R1U9XmGtNYb2X4bffIPZWbVLXsbZ6FkX7TxWMsRnyHGzB
         W5KRWTwQ/SvKdbBZ3LgfUowTnkIvmBEfyDX7oeiNvKVlQbA3x9n3QGeHSueLV2qxbk7k
         8GQnjthxPUwk+sBRSGvxRq8sku96p+BFb3Gjex58qD/lmQCN+2u5YIB3nWbg2wHu9psl
         1XUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNY7czIwpusO61rJoPeCDEV4Qf2V9wWZoLziIXNiH+s=;
        b=o57otsHQV9mzic0N1eedH0sQs0pM3plAwjBPBWTEU7JaONo5d/jDPaAr62rnAlk2Lq
         TJu3ezFVJWSqyw/8Lg2Z+k1VY3VFz5bNp+vb132eMZWL89LBxsxl2k07kX5mjF1faNXi
         hos9F2yRPp/Ub9+nFsFbVi4zs/ZEYAXDnahAYP/FtY//kMhOmBzOIIIyY6eEQopie+dX
         ORNpdxuHvHmMWgbMbD0R7eW7bUhzPOadHns82lNnSe1NxYGhftbEERB8vwHCs/ebgS1T
         K+ajCs7Zt3qioSzw4V9oHYKNqb85abk22H6Gtnddt/cuEF0ezKhqJUn/IzsVbAq6noPb
         f43w==
X-Gm-Message-State: ACgBeo3wTJ5o8rvT7CjLREJhffPfQP0yULGy011gW9RrUEOlkUxZc/+r
        RVI5VS6sxZ+9Q2/0DgA0S1Ff8DR1FV4qgGzQGcMjGQ==
X-Google-Smtp-Source: AA6agR4OnbPJ7p4M7PNNQa0wGF0qm0yUOdd9l3yhulo7HfOqSXiut4Tj8KXeNTmFHiIsvGpfGPZr5ysGSBfMQxpAa9Q=
X-Received: by 2002:a0d:e853:0:b0:321:c297:c9b2 with SMTP id
 r80-20020a0de853000000b00321c297c9b2mr852797ywe.493.1659604733056; Thu, 04
 Aug 2022 02:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220511060521.465744-1-sumit.garg@linaro.org>
 <CAD=FV=WXoDvWuH=yjzCcqOZ5CeUtYun7C8zrtrBP4FC409GkqA@mail.gmail.com>
 <CAFA6WYPmFqCXk24J71tNO=5bJHgJRAOPFr7cGq8YYLR+MWBoPw@mail.gmail.com>
 <CAD=FV=WdMsqrsWzX=0RU5HJ1a0cy-pm4BwP47siLj=+eeEXUQA@mail.gmail.com> <CAFA6WYP_C7fOkgNw8n0OAaT92fr4UdBnCqAn_du6BT_sQB2KzQ@mail.gmail.com>
In-Reply-To: <CAFA6WYP_C7fOkgNw8n0OAaT92fr4UdBnCqAn_du6BT_sQB2KzQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 4 Aug 2022 14:48:41 +0530
Message-ID: <CAFA6WYNnb2szmP7_V-W=LrBS1sD+zwV8VrieSp-sQM7B1E4wqA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm64: Fix pending single-step debugging issues
To:     Doug Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will@kernel.org>, Wei Li <liwei391@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 at 19:21, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Mon, 11 Jul 2022 at 19:17, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Mon, Jul 11, 2022 at 5:44 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > > I'll also note that I _think_ I remember that with Wei's series that
> > > > the gdb function "call" started working. I tried that here and it
> > > > didn't seem so happy. To keep things simple, I created a dummy
> > > > function in my kernel that looked like:
> > > >
> > > > void doug_test(void)
> > > > {
> > > >   pr_info("testing, 1 2 3\n");
> > > > }
> > > >
> > > > I broke into the debugger by echoing "g" to /proc/sysrq-trigger and
> > > > then tried "call doug_test()". I guess my printout actually printed
> > > > but it wasn't so happy after that. Seems like it somehow ended up
> > > > returning to a bogus address after the call which then caused a crash.
> > > >
> > >
> > > I am able to reproduce this issue on my setup as well. But it doesn't
> > > seem to be a regression caused by this patch-set over Wei's series. As
> > > I could reproduce this issue with v1 [1] patch-set as well which was
> > > just a forward port of pending patches from Wei's series to the latest
> > > upstream.
> > >
> > > Maybe it's a different regression caused by other changes? BTW, do you
> > > remember the kernel version you tested with Wei's series applied?
> >
> > Sorry, I don't remember! :( I can't even be 100% sure that I'm
> > remembering correctly that I tested it back in the day, so it's
> > possible that it simply never worked...
>
> Okay, no worries. Let me see if I can come up with a separate fix for this.
>

After digging deep into GDB call function operations for aarch64, it
is certain that function calls simply never worked due to below
reasons:

1. On aarch64, GDB call function inserts a breakpoint at the
entrypoint of kernel (which is ffffffc008000000 from your dump) as
return address from function called. And since it refers to the
"_text" symbol which is marked non-executable as the actual text
section starts with the "_stext" symbol. I did a following hack that
makes it executable:

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 626ec32873c6..e39ad1a5f5d6 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -700,7 +700,7 @@ static bool arm64_early_this_cpu_has_bti(void)
 static void __init map_kernel(pgd_t *pgdp)
 {
        static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_inittext,
-                               vmlinux_initdata, vmlinux_data;
+                               vmlinux_initdata, vmlinux_data, vmlinux_htext;

        /*
         * External debuggers may need to write directly to the text
@@ -721,6 +721,8 @@ static void __init map_kernel(pgd_t *pgdp)
         * Only rodata will be remapped with different permissions later on,
         * all other segments are allowed to use contiguous mappings.
         */
+       map_kernel_segment(pgdp, _text, _stext, text_prot, &vmlinux_htext, 0,
+                          VM_NO_GUARD);
        map_kernel_segment(pgdp, _stext, _etext, text_prot, &vmlinux_text, 0,
                           VM_NO_GUARD);
        map_kernel_segment(pgdp, __start_rodata, __inittext_begin, PAGE_KERNEL,

2. For the GDB function "call" to work, GDB inserts a dummy stack
frame. But in case of kernel on aarch64, the stack used is common
among the exception handler and the kernel threads. So it's not
trivial to insert a dummy stack frame and requires rework of exception
entry code as it pushes pt_regs onto the stack.

-Sumit

>
> >
> > -Doug
