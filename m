Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900465905A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbiHKRR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiHKRRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:17:03 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EE5B01
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:09:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so5693058pjk.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=Ck/kSylQVms5JwCJbdw3zQuUtzcZAeiGwMiy/xk3l3k=;
        b=5aM73j+gOKbnY2lxMUT5Vubsy9iseUG+jj5ulQc40FakpvcG4Etg70cohFi7yy9FwD
         5GLf1dEUDz2X3wE4fKvCrqOGZbVEMuXTdk7AmMOKCyxVhnOpcfgop1Ql3sGPp0UH3Luf
         kKnx0VimcbJvFpNenMwXqhfGbE+WTIUXpk+xIhbLv4MmQZWXPfx3yPCLiZVe6n7o9ZmY
         NVlYQrQbpPON9U7V66978npspef+CJkYNhrbCQ+twSrrFiy/TWPAd47JYl6TH6jRes3p
         F9CpdF87weDVAe4ugx5o1Dv85llM7BxakVF3eVRivYRoknUTLTYh3FcDAx30ajZoH9Vt
         CZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=Ck/kSylQVms5JwCJbdw3zQuUtzcZAeiGwMiy/xk3l3k=;
        b=y6k6PL1vs0OV1Wd/z6XKrdxNSF/KVJD1OopNAZ0tVghny3/IGGVimoj5em0WD1ejwm
         RQzzfjpzwZLshHLsbQHZud5wN7TViXKAX2ZYIalEPipsQOPdXRhBssysAbqhLbWnV0RI
         SG4Ega+8IMyhb34mbaurjIHiJ+7kSEJ8klYMGog7/pnFYAkwY1p7wZt6ydC4AABMeL4i
         XHwbqNn/jePMUoRZDcvnulGtfzRG8aVfhkXcjNNxx+yzz7BTFx4v6+VR+lAseqVBp7kq
         /5EEVE2BGBCmcKWrhJ+PxKtdYn7bTq3AdnhAoUr74XgPmZcjnBeZThWcxDa+UGptggKu
         WvYg==
X-Gm-Message-State: ACgBeo2uQTG/AWX3tL4t37Wy0NmhBDz5zjNncr/h6zFaKLaGaODOvQyu
        8nXUxhb1/roYcQAg1i6IOTDYqG09LNdHOg==
X-Google-Smtp-Source: AA6agR7HztU5aHFmk889S5mE0ZrMU7TcZuua217HAGdwZ+A2bijuXbm3lOJbpJ0coxigOaHrJxS4nQ==
X-Received: by 2002:a17:902:f283:b0:16f:c46:dc1f with SMTP id k3-20020a170902f28300b0016f0c46dc1fmr144542plc.162.1660237783367;
        Thu, 11 Aug 2022 10:09:43 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902b78c00b0017154ae6265sm83497pls.211.2022.08.11.10.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:09:42 -0700 (PDT)
Date:   Thu, 11 Aug 2022 10:09:42 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Aug 2022 10:09:41 PDT (-0700)
Subject:     Re: [PATCH] riscv/kprobes: allocate detour buffer from module area
In-Reply-To: <20220629011317.259986-1-liaochang1@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        mhiramat@kernel.org, rostedt@goodmis.org, liaochang1@huawei.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     liaochang1@huawei.com
Message-ID: <mhng-0e2f7f49-2680-4341-83dc-0e7cd042a3fa@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022 18:13:17 PDT (-0700), liaochang1@huawei.com wrote:
> To address the limitation of PC-relative branch instruction
> on riscv architecture, detour buffer slot is allocated from
> a area, the distance of which from kernel should be less than 4GB.
>
> For the time being, Modules region always live before the kernel.
> But Vmalloc region reside far away from kernel, the distance is
> half of the kernel address space.
>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/riscv/kernel/probes/kprobes.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index e6e950b7cf32..bc027a663b17 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -6,12 +6,14 @@
>  #include <linux/extable.h>
>  #include <linux/slab.h>
>  #include <linux/stop_machine.h>
> +#include <linux/moduleloader.h>
>  #include <asm/ptrace.h>
>  #include <linux/uaccess.h>
>  #include <asm/sections.h>
>  #include <asm/cacheflush.h>
>  #include <asm/bug.h>
>  #include <asm/patch.h>
> +#include <asm/set_memory.h>
>
>  #include "decode-insn.h"
>
> @@ -86,10 +88,28 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  #ifdef CONFIG_MMU
>  void *alloc_insn_page(void)
>  {
> +#if defined(CONFIG_MODULES) && defined(CONFIG_64BIT)
> +	void *page;
> +
> +	page = module_alloc(PAGE_SIZE);
> +	if (!page)
> +		return NULL;
> +
> +	set_vm_flush_reset_perms(page);
> +	/*
> +	 * First make the page read-only, and only then make it executable to
> +	 * prevent it from being W+X in between.
> +	 */
> +	set_memory_ro((unsigned long)page, 1);
> +	set_memory_x((unsigned long)page, 1);
> +
> +	return page;
> +#else
>  	return  __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
>  				     GFP_KERNEL, PAGE_KERNEL_READ_EXEC,
>  				     VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
>  				     __builtin_return_address(0));
> +#endif
>  }
>  #endif

This probably shouldn't depend on CONFIG_MODULES, it's just as broken to 
assume we can jump to the vmalloc region regardless of whether modules 
are enabled or disabled.  We should be able to just allocate from the 
jump-safe region either way.
