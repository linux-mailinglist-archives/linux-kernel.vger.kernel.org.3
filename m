Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4C6586DC5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbiHAPbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiHAPbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:31:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CA1237EE
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A8CC60AFB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 15:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0092C433C1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 15:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659367903;
        bh=aklGnDNOtlMe5c7cG6k7R15eB9as0Owo2oWNBYYr90I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jH+X/aKmUanHxiztvjB1cJw7wLM43PoEawebJUeNdeKRj/wnOamV2Pwo1hhpZhx5t
         lH7kSTwHGVx0Km2HI3t2RNYko7Q2rLlelFS6KfNPq4ti1jV1b3mFfPx7FhjkpmhfFd
         vVOP1AhKy59MXNU9e87tiRUD2hu8g5fuoUR7BdzCjv0ZdM7BMtVWKEVT+KYLoBht7S
         ytIMTcwFdp3uOXNGMUka7SnLSzPAb3z5E/SNDCGGRtm9c68dT0c2S5ow1sknoFGR/2
         zefGT/PhpDF8lmIDVrdyrSNC+UsMvrQynSQuK88SNiNK2Iyex2oKCqgw17vdGLfy0V
         tSuVHHRvHnSHQ==
Received: by mail-ua1-f53.google.com with SMTP id 5so4702292uay.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:31:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo3UuztGqJnOTvR/4IEEbrBKUnpmT/RgsMNtXGUxLbnrLc0f74z7
        5YECx74V4gYHVbFDge6PWRoEz6B4+HAVb71mVgo=
X-Google-Smtp-Source: AA6agR6ZSi49f7Dbvw1WdPAr4rK0mQspB7bEBrz460ZjbJKxu9WMsgXat3RKLkDpBHZJbT2egAHLKN8C2k2lbaZZ88k=
X-Received: by 2002:ab0:2359:0:b0:387:2dff:87d5 with SMTP id
 h25-20020ab02359000000b003872dff87d5mr6455801uao.104.1659367902719; Mon, 01
 Aug 2022 08:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220801121726.9681-1-zhangqing@loongson.cn> <20220801121726.9681-5-zhangqing@loongson.cn>
In-Reply-To: <20220801121726.9681-5-zhangqing@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 1 Aug 2022 23:31:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4qSbaS3=JJXk4fLMnVp2L_ZbFkrddzad0J3ewZDuGMMg@mail.gmail.com>
Message-ID: <CAAhV-H4qSbaS3=JJXk4fLMnVp2L_ZbFkrddzad0J3ewZDuGMMg@mail.gmail.com>
Subject: Re: [PATCH 4/4] LoongArch: Add USER_STACKTRACE support
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Qing,

On Mon, Aug 1, 2022 at 8:17 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> To get the best output you can compile your userspace programs with
> frame pointers (at least glibc + the app you are tracing export "CC
> =gcc -fno-omit-frame-pointer".
>
> ...
>      echo 'p:malloc /usr/lib64/libc.so.6:0x0a4704 size=%r4:u64'
>                                                 > uprobe_events
>      echo 'p:free /usr/lib64/libc.so.6:0x0a4d50 ptr=%r4:x64'
>                                                >> uprobe_events
>      echo 'comm == "demo"' > ./events/uprobes/malloc/filter
>      echo 'comm == "demo"' > ./events/uprobes/free/filter
>      echo 1 > ./options/userstacktrace
>      echo 1 > ./options/sym-userobj
>  ...
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  arch/loongarch/Kconfig                  |  1 +
>  arch/loongarch/include/asm/stacktrace.h |  5 +++
>  arch/loongarch/kernel/stacktrace.c      | 42 +++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 85d0fa3147cd..05906384d564 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -107,6 +107,7 @@ config LOONGARCH
>         select SWIOTLB
>         select TRACE_IRQFLAGS_SUPPORT
>         select USE_PERCPU_NUMA_NODE_ID
> +       select USER_STACKTRACE_SUPPORT
>         select ZONE_DMA32
>         select MMU_GATHER_MERGE_VMAS if MMU
>
> diff --git a/arch/loongarch/include/asm/stacktrace.h b/arch/loongarch/include/asm/stacktrace.h
> index 49cb89213aeb..77fdb8ad662d 100644
> --- a/arch/loongarch/include/asm/stacktrace.h
> +++ b/arch/loongarch/include/asm/stacktrace.h
> @@ -21,6 +21,11 @@ struct stack_info {
>         unsigned long begin, end, next_sp;
>  };
>
> +struct stack_frame {
> +       unsigned long   fp;
> +       unsigned long   ra;
> +};
> +
>  bool in_task_stack(unsigned long stack, struct task_struct *task,
>                         struct stack_info *info);
>  bool in_irq_stack(unsigned long stack, struct stack_info *info);
> diff --git a/arch/loongarch/kernel/stacktrace.c b/arch/loongarch/kernel/stacktrace.c
> index f4f4b8ad3917..344224c7cb0e 100644
> --- a/arch/loongarch/kernel/stacktrace.c
> +++ b/arch/loongarch/kernel/stacktrace.c
> @@ -6,6 +6,7 @@
>   */
>  #include <linux/sched.h>
>  #include <linux/stacktrace.h>
> +#include <linux/uaccess.h>
>
>  #include <asm/stacktrace.h>
>  #include <asm/unwind.h>
> @@ -35,3 +36,44 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
>                         break;
>         }
>  }
> +
> +static int
> +copy_stack_frame(unsigned long fp, struct stack_frame *frame)
> +{
> +       int ret;
> +       unsigned long err;
> +       unsigned long __user *user_frame_tail;
> +
> +       user_frame_tail = (unsigned long *)(fp - sizeof(struct stack_frame));
> +       if (!access_ok(user_frame_tail, sizeof(*frame)))
> +               return 0;
> +
> +       ret = 1;
Maybe initializing it at its definition is better?

Huacai
> +       pagefault_disable();
> +       err = (__copy_from_user_inatomic(frame, user_frame_tail, sizeof(*frame)));
> +       if (err || (unsigned long)user_frame_tail >= frame->fp)
> +               ret = 0;
> +       pagefault_enable();
> +
> +       return ret;
> +}
> +
> +void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
> +                         const struct pt_regs *regs)
> +{
> +       unsigned long fp = regs->regs[22];
> +
> +       while (fp && !((unsigned long)fp & 0xf)) {
> +               struct stack_frame frame;
> +
> +               frame.fp = 0;
> +               frame.ra = 0;
> +               if (!copy_stack_frame(fp, &frame))
> +                       break;
> +               if (!frame.ra)
> +                       break;
> +               if (!consume_entry(cookie, frame.ra))
> +                       break;
> +               fp = frame.fp;
> +       }
> +}
> --
> 2.20.1
>
>
