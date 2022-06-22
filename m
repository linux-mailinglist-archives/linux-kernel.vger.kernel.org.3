Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D66155466B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbiFVKCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbiFVKCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB25F3A71A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C40961A73
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3888C341C5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655892125;
        bh=Mi+qlIc9oN1A1gBf/aL2SASGXCJufowUFeO3EKb/utc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AZHTakBKMtCaQAVCjg3ieImHBB6H58kxcjMDigpqjh70pdsxgbueqimyiV65NNAiA
         0lopoKOE2Hsa+aRX2bbmlJiCoH4kGsBO0nBkIpBERDDoPDE7hy8INDiuAGa4ZdILvS
         U6imMrqIMaRr7ovekfYZq/7taSF36SYIqYMC0tj2lO8TmwJBwbAUKsSjyjCgmsy0Nj
         rru7YZE6bc33X+fxCyaaVio6mWfRjsrK0xYdTu/8sir26ugwxlFy+5XrswLmYTA4oh
         ymnrqDtRG0QYxaCnxf3cZz4nwVbPtRCjwEiuT/eKVwpEOVsldCbMdqovAcxQi0A9Xf
         3Qe1KHMHbpMag==
Received: by mail-lj1-f173.google.com with SMTP id a11so9922745ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:02:05 -0700 (PDT)
X-Gm-Message-State: AJIora9UHuiFsYz61L71skuVliBtFKdXoK66yv0+Zd9vJ5WasYl/hGoH
        xdvFM9fAwtRFk8iD5r1HQUVj0aU+ShFAWL9fJTM=
X-Google-Smtp-Source: AGRyM1uOi3EI4xEj6v24YZfO/fBahvkltCY3Gr+kw1Ab4NZub2vj8OW0ghj2sFMlMJheO3XYcyUxHHCnVfBf43cuHVc=
X-Received: by 2002:a05:651c:1189:b0:25a:7f29:6015 with SMTP id
 w9-20020a05651c118900b0025a7f296015mr1361117ljo.179.1655892123800; Wed, 22
 Jun 2022 03:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <1655806074-17454-1-git-send-email-yangtiezhu@loongson.cn> <1655806074-17454-3-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1655806074-17454-3-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 22 Jun 2022 18:01:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6YYhMAyOG+-PDKiLBv1fDoFmkQUSBa4zt=Lf4=HZGxHQ@mail.gmail.com>
Message-ID: <CAAhV-H6YYhMAyOG+-PDKiLBv1fDoFmkQUSBa4zt=Lf4=HZGxHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] LoongArch: No need to call RESTORE_ALL_AND_RET for
 all syscalls
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>, Jun Yi <yijun@loongson.cn>,
        Rui Wang <wangrui@loongson.cn>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu,

On Tue, Jun 21, 2022 at 6:08 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> In handle_syscall, it is unnecessary to call RESTORE_ALL_AND_RET
> for all syscalls.
>
> (1) rt_sigreturn call RESTORE_ALL_AND_RET.
> (2) The other syscalls call RESTORE_STATIC_SOME_SP_AND_RET.
>
> This patch only adds the minimal changes as simple as possible
> to reduce the code complexity, at the same time, it can reduce
> many load instructions.
>
> Here are the test environments:
>
>   Hardware: Loongson-LS3A5000-7A1000-1w-A2101
>   Firmware: UDK2018-LoongArch-A2101-pre-beta8 [1]
>   System: loongarch64-clfs-system-5.0 [2]
>
> The system passed functional testing used with the following
> test case without and with this patch:
>
>   git clone https://github.com/hevz/sigaction-test.git
>   cd sigaction-test
>   make check
>
> Additionally, use UnixBench syscall to test the performance:
>
>   git clone https://github.com/kdlucas/byte-unixbench.git
>   cd byte-unixbench/UnixBench/
>   make
>   pgms/syscall 600
>
> In order to avoid the performance impact, add init=/bin/bash
> to the boot cmdline.
>
> Here is the test result, the bigger the better, it shows about
> 1.2% gain tested with close, getpid and exec [3]:
>
>   duration  without_this_patch  with_this_patch
>   600 s     626558267 lps       634244079 lps
>
> [1] https://github.com/loongson/Firmware/tree/main/5000Series/PC/A2101
> [2] https://github.com/sunhaiyong1978/CLFS-for-LoongArch/releases/tag/5.0
> [3] https://github.com/kdlucas/byte-unixbench/blob/master/UnixBench/src/syscall.c
I test your patch and the whole UnixBench result is like this:

Before patch, single thread:

System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0    9235787.7    791.4
Double-Precision Whetstone                       55.0       2758.7    501.6
Execl Throughput                                 43.0       2386.8    555.1
File Copy 1024 bufsize 2000 maxblocks          3960.0     191752.0    484.2
File Copy 256 bufsize 500 maxblocks            1655.0      78737.9    475.8
File Copy 4096 bufsize 8000 maxblocks          5800.0     297402.5    512.8
Pipe Throughput                               12440.0     353658.1    284.3
Pipe-based Context Switching                   4000.0     120140.8    300.4
Process Creation                                126.0       5735.0    455.2
Shell Scripts (1 concurrent)                     42.4       2701.5    637.1
Shell Scripts (8 concurrent)                      6.0        894.9   1491.5
System Call Overhead                          15000.0     557467.4    371.6
                                                                   ========
System Benchmarks Index Score                                         516.1

After patch, single thread:

System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0    9235688.9    791.4
Double-Precision Whetstone                       55.0       2758.7    501.6
Execl Throughput                                 43.0       2377.8    553.0
File Copy 1024 bufsize 2000 maxblocks          3960.0     192545.5    486.2
File Copy 256 bufsize 500 maxblocks            1655.0      79735.0    481.8
File Copy 4096 bufsize 8000 maxblocks          5800.0     299621.9    516.6
Pipe Throughput                               12440.0     354969.1    285.3
Pipe-based Context Switching                   4000.0     118307.5    295.8
Process Creation                                126.0       5757.0    456.9
Shell Scripts (1 concurrent)                     42.4       2695.4    635.7
Shell Scripts (8 concurrent)                      6.0        894.4   1490.6
System Call Overhead                          15000.0     563582.7    375.7
                                                                   ========
System Benchmarks Index Score                                         517.0

Before patch, multi-threads:

System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0   36943633.4   3165.7
Double-Precision Whetstone                       55.0      11035.8   2006.5
Execl Throughput                                 43.0       8800.1   2046.5
File Copy 1024 bufsize 2000 maxblocks          3960.0     277638.3    701.1
File Copy 256 bufsize 500 maxblocks            1655.0      92530.5    559.1
File Copy 4096 bufsize 8000 maxblocks          5800.0     524344.3    904.0
Pipe Throughput                               12440.0    1359237.2   1092.6
Pipe-based Context Switching                   4000.0     571511.4   1428.8
Process Creation                                126.0      20823.3   1652.6
Shell Scripts (1 concurrent)                     42.4       6883.9   1623.6
Shell Scripts (8 concurrent)                      6.0        981.7   1636.1
System Call Overhead                          15000.0    2029539.8   1353.0
                                                                   ========
System Benchmarks Index Score                                        1367.4

After patch, multi-threads:

System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0   36943793.6   3165.7
Double-Precision Whetstone                       55.0      11035.5   2006.4
Execl Throughput                                 43.0       8768.3   2039.1
File Copy 1024 bufsize 2000 maxblocks          3960.0     277962.9    701.9
File Copy 256 bufsize 500 maxblocks            1655.0      92059.7    556.3
File Copy 4096 bufsize 8000 maxblocks          5800.0     525937.5    906.8
Pipe Throughput                               12440.0    1361566.6   1094.5
Pipe-based Context Switching                   4000.0     575835.4   1439.6
Process Creation                                126.0      20426.4   1621.1
Shell Scripts (1 concurrent)                     42.4       6877.5   1622.0
Shell Scripts (8 concurrent)                      6.0        980.3   1633.8
System Call Overhead                          15000.0    2049771.6   1366.5
                                                                   ========
System Benchmarks Index Score                                        1366.6

From my point of view, the benefit is negligible.


Huacai

>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/include/asm/stackframe.h |  5 +++++
>  arch/loongarch/kernel/entry.S           | 15 +++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
> index 4ca9530..551ab8f 100644
> --- a/arch/loongarch/include/asm/stackframe.h
> +++ b/arch/loongarch/include/asm/stackframe.h
> @@ -216,4 +216,9 @@
>         RESTORE_SP_AND_RET \docfi
>         .endm
>
> +       .macro  RESTORE_STATIC_SOME_SP_AND_RET docfi=0
> +       RESTORE_STATIC \docfi
> +       RESTORE_SOME \docfi
> +       RESTORE_SP_AND_RET \docfi
> +       .endm
>  #endif /* _ASM_STACKFRAME_H */
> diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
> index d5b3dbc..c764c99 100644
> --- a/arch/loongarch/kernel/entry.S
> +++ b/arch/loongarch/kernel/entry.S
> @@ -14,6 +14,7 @@
>  #include <asm/regdef.h>
>  #include <asm/stackframe.h>
>  #include <asm/thread_info.h>
> +#include <asm/unistd.h>
>
>         .text
>         .cfi_sections   .debug_frame
> @@ -62,9 +63,23 @@ SYM_FUNC_START(handle_syscall)
>         li.d    tp, ~_THREAD_MASK
>         and     tp, tp, sp
>
> +       /* Syscall number held in a7, we can store it in TI_SYSCALL. */
> +        LONG_S  a7, tp, TI_SYSCALL
> +
>         move    a0, sp
>         bl      do_syscall
>
> +       /*
> +        * Syscall number held in a7 which is stored in TI_SYSCALL.
> +        * rt_sigreturn call RESTORE_ALL_AND_RET.
> +        * The other syscalls call RESTORE_STATIC_SOME_SP_AND_RET.
> +        */
> +       LONG_L  t3, tp, TI_SYSCALL
> +       li.w    t4, __NR_rt_sigreturn
> +       beq     t3, t4, 1f
> +
> +       RESTORE_STATIC_SOME_SP_AND_RET
> +1:
>         RESTORE_ALL_AND_RET
>  SYM_FUNC_END(handle_syscall)
>
> --
> 2.1.0
>
