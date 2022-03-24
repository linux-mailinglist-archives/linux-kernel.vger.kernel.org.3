Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E614E6429
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350468AbiCXNgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347487AbiCXNge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:36:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F55AA8EEF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAD87B823DE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC5CC340F4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648128899;
        bh=vgO+XlM9BeCgtcvRDqRHD4knyw63jQllRBuby+RwdlI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mHJlfujDUCwmU7f5lo5U7KWNEfWXz085JS4mn8Vu5/Xy7vPOlrkOP6Y/kxVd1i2rg
         KIHDxin3cyVZsFrT55iH5hRwv7spQBiH8XSBTqKtpgD3DO5jx/MiySYLQA0ukcEcBS
         ZzBsM2T75L7uyzmrICjrVGbnNVytmK1NyeJt0LOUZ1abz4y0jiqSRH1XyRc7le+etb
         7iITocYn9tkA3jsH5BEpTtaAvgkImr/cM7Bn9vMXTubuskShCvtXYkETku8gdAOXPU
         41xmvkOUCWb7I9yg8yXbksHYfMMQlG1xUHL6Fr5sxJHpIn0selj30I72Dd2WGBPYOw
         7BvCj0haPDihg==
Received: by mail-oi1-f171.google.com with SMTP id w127so4875155oig.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:34:59 -0700 (PDT)
X-Gm-Message-State: AOAM533Fnwxj44raCe6GHIgp3blnyju0rSo9uH2E/K0bL9uzo2dSQfv7
        vkQp5EZD2806e88y6KJqtmi3Q9Uv3lOzcULnzJU=
X-Google-Smtp-Source: ABdhPJxgIkTCuePaAmv2VEwd01p+btudnn/4I7sxXMKVpACs+4YdSrhlhur/++/ZNPhVz/004zgWB/EE5KN+fpQqBbc=
X-Received: by 2002:aca:674c:0:b0:2d9:c460:707c with SMTP id
 b12-20020aca674c000000b002d9c460707cmr2661014oiy.126.1648128898797; Thu, 24
 Mar 2022 06:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220315182558.1a056d8b3975932f6589b60f@kernel.org>
 <164733793626.1008610.12121025094280924953.stgit@devnote2>
 <20220324152108.b6016621dd6b8297eddd6bb5@kernel.org> <20220324222322.9f59df377b01856f2230a4ea@kernel.org>
In-Reply-To: <20220324222322.9f59df377b01856f2230a4ea@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 24 Mar 2022 14:34:46 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFtrogyse1MOF1KDBuYwtxNDvCu3rF=o7b__83Lu6Fj4A@mail.gmail.com>
Message-ID: <CAMj1kXFtrogyse1MOF1KDBuYwtxNDvCu3rF=o7b__83Lu6Fj4A@mail.gmail.com>
Subject: Re: [PATCH] ARM: kprobes: Make __kretprobe_trampoline as a pure asm function
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -377,7 +377,7 @@ void __naked __kprobes __kretprobe_trampoline(void)
 {
        __asm__ __volatile__ (
 #ifdef CONFIG_FRAME_POINTER
-               "ldr    lr, =__kretprobe_trampoline     \n\t"
+               "ldr    lr, .L__kretprobe_trampoline    \n\t"
        /* __kretprobe_trampoline makes a framepointer on pt_regs. */
 #ifdef CONFIG_CC_IS_CLANG
                "stmdb  sp, {sp, lr, pc}        \n\t"
@@ -407,6 +407,11 @@ void __naked __kprobes __kretprobe_trampoline(void)
                "bx     lr                      \n\t"
 #else
                "mov    pc, lr                  \n\t"
+#endif
+#ifdef CONFIG_FRAME_POINTER
+               ".align 2                       \n\t"
+       ".L__kretprobe_trampoline:              \n\t"
+               ".long  __kretprobe_trampoline  \n\t"
 #endif
                : : : "memory");
 }


On Thu, 24 Mar 2022 at 14:23, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Thu, 24 Mar 2022 15:21:08 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > Hi,
> >
> > I found a better solution for this issue from Ard :-)
> >
> > https://lore.kernel.org/all/20220203082204.1176734-6-ardb@kernel.org/T/#u
> >
> > I should use mov_l instead of ldr for loading the symbol address.
>
> Hm, these macros are only for the pure assembly file (.S), so we have to
> split this in a asm file to use that.
>


What about the below?
