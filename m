Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAA84E7858
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349861AbiCYPr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376763AbiCYPrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:47:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3212D3D1CC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:46:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2BA7616CD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D7BC340E9;
        Fri, 25 Mar 2022 15:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648223161;
        bh=mPuYiGeXboo/JzYYaY6gaHdDwS1ZbhGYz7ajLqD1pqI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AE/0lKbxZ6Wfu6t+Divs1AlYxXxA0XQChUxEWLkegJw/AdsZRmW01WV+DcpS9bIZT
         o8C9HukYcZZjDVOyKbCNrmp12z9q88yRzcQw3kqbj9/m08MukKHBjGdVNThrJ0S8Nr
         ZdbeEdvuRaLJyLvkLUL2Lvz8Im0m9vUpezQSkS0j/w3rkB5J3zIasGy2RAayEabBCy
         NWfQOjdtKNic6y/IrEx+8xhpS+O2RqBxkxTHLJc9qcqoeMZikHdmhYrX7LBYsNOpRz
         s7S7cIfcKvATx7uj7WcwMA95uRt4/xRmgckP67ZXZSqqpaHbtQxetFt1HGjuXsRb3C
         aztQyMn9oaxmw==
Message-ID: <9e1a95ef-69ad-1f6c-e1f3-dcff3ed65e79@kernel.org>
Date:   Fri, 25 Mar 2022 08:45:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] x86-32: Clean up GS segment handling
Content-Language: en-US
To:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220325153953.162643-1-brgerst@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220325153953.162643-1-brgerst@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/22 08:39, Brian Gerst wrote:
> Since commit 3fb0fdb3bbe ("Make the canary into a regular percpu
> variable"), the GS segment is no longer switched on kernel entry for
> 32-bit kernels.  Clean up the remaining code that handled lazy GS
> switching.
> 

Acked-by: Andy Lutomirski <luto@kernel.org>

Thanks!

> Brian Gerst (4):
>    x86-32: Simplify ELF_CORE_COPY_REGS
>    ELF: Remove elf_core_copy_kernel_regs()
>    x86-32: Remove lazy GS macros
>    x86: Merge load_gs_index()
> 
>   arch/powerpc/kernel/fadump.c               |  2 +-
>   arch/powerpc/platforms/powernv/opal-core.c |  2 +-
>   arch/x86/include/asm/elf.h                 | 15 ++-------------
>   arch/x86/include/asm/mmu_context.h         |  2 +-
>   arch/x86/include/asm/segment.h             | 12 ------------
>   arch/x86/include/asm/special_insns.h       |  7 ++++---
>   arch/x86/kernel/process.c                  |  5 +----
>   arch/x86/kernel/process_32.c               | 11 ++++-------
>   arch/x86/kernel/ptrace.c                   |  6 +++---
>   arch/x86/kernel/signal.c                   |  8 +++++---
>   arch/x86/kernel/vm86_32.c                  |  4 ++--
>   arch/x86/lib/insn-eval.c                   |  5 +++--
>   arch/x86/math-emu/get_address.c            |  2 +-
>   include/linux/elfcore.h                    |  9 ---------
>   kernel/kexec_core.c                        |  2 +-
>   15 files changed, 29 insertions(+), 63 deletions(-)
> 

