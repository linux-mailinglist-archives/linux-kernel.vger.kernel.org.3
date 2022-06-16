Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA0554ED12
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379050AbiFPWFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378696AbiFPWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:05:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B2D6163D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:04:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so1373151pjm.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zGBZJcSZ/U2W2OG+8NJC+fEKRwdCP8ZVUrkCa1GUjJM=;
        b=e0Ru41M0uDOh0SC3RTUpcSh7Nlh3ZyNMHyhCVi3YyHT1OLrQ2v3HzYEEiZEOvuYB5I
         ZbrKrdxNBGXS6dRyfKMA7k6a5KOG+WXZCfH2Zh08Lzp247mnrGd99VNENM+sDeAXfadB
         TRDtkfo8Y+dLVRIWh1e4ywDVaKoos9VZDb7WXOyGSHPxKudONRkBvSDtVDmT2qGCUCkI
         0Wx7XQXBruiKF5X+xfE+n1eEbujxOgHbUL9V2nsRVh1utDdSxu1KSFSCyNS8OuFns2P5
         5KHne5Iy/XNGV9kETMpzEcPy8vjYCYZwJNjQvwJNNpB53Ri2bEdZI2brtRaxXvmP2wYd
         bpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zGBZJcSZ/U2W2OG+8NJC+fEKRwdCP8ZVUrkCa1GUjJM=;
        b=ARyMRCpIpLmitsA0rE/MiCbTljrPUiI1ft2ync7uCfuOmRhVcWy7IniFQMXGh1DgU7
         txALD4jpIqvoQFJYn6SUkaxWTBqLKU4e4zvq2tKAXs2ERkpVNuXYlpF2MCzpU8eJiOoA
         gPPF0XnUQKKWI6H9iVrTgislu3tkYhBTEPkvkJlPgUQ6jhFX/tSYvsj/CB1BncdrdiXx
         09ISwcjGkPo1QZnJGA+6A7iofnye5m4MpF42HRR9o4NQL6AOK86DfqcTTdA/QNNguxiR
         hrnYAB9lpMDV6vJutPQ8EG7HA3rQETEQ6GUA6zmfALUaM2tZjUDcyOkc8QXMqUNcxtCb
         O8yA==
X-Gm-Message-State: AJIora9zAbflx4dXoO7PIqROALdn6cpHG5P5DChtamj8Ft3PAw1ARuHs
        GBFDJ7r8dSFr8sNHucY8KRykcA==
X-Google-Smtp-Source: AGRyM1sa3Yb7kZOPhKBtePqEmeLvk2njJ75iBb/jB32mvauypDbZYIcJPAXhqydTqgyhfaAqw9R2Aw==
X-Received: by 2002:a17:902:d2ce:b0:167:7637:7025 with SMTP id n14-20020a170902d2ce00b0016776377025mr6278621plc.37.1655417093786;
        Thu, 16 Jun 2022 15:04:53 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id g12-20020a62f94c000000b0050dc762816asm2255514pfm.68.2022.06.16.15.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 15:04:52 -0700 (PDT)
Date:   Thu, 16 Jun 2022 15:04:52 -0700 (PDT)
X-Google-Original-Date: Thu, 16 Jun 2022 15:04:46 PDT (-0700)
Subject:     Re: [PATCH] riscv: Invalid instruction cache after copy the xol area
In-Reply-To: <20220518081753.29589-1-po-kai.chi@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        po-kai.chi@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     po-kai.chi@sifive.com
Message-ID: <mhng-296c3110-5e5d-48a4-bd41-1d46bf7987cd@palmer-ri-x1c9>
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

On Wed, 18 May 2022 01:17:53 PDT (-0700), po-kai.chi@sifive.com wrote:
> We need to invalid the relevant instruction cache after
> copying the xol area, to ensure the changes takes effect.
>
> Signed-off-by: Po-Kai Chi <po-kai.chi@sifive.com>
> ---
>  arch/riscv/kernel/probes/uprobes.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
> index 7a057b5f0adc..9d52beeac73c 100644
> --- a/arch/riscv/kernel/probes/uprobes.c
> +++ b/arch/riscv/kernel/probes/uprobes.c
> @@ -165,6 +165,7 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>  	/* Initialize the slot */
>  	void *kaddr = kmap_atomic(page);
>  	void *dst = kaddr + (vaddr & ~PAGE_MASK);
> +	unsigned long addr = (unsigned long)dst;
>
>  	memcpy(dst, src, len);
>
> @@ -177,10 +178,9 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>  	kunmap_atomic(kaddr);
>
>  	/*
> -	 * We probably need flush_icache_user_page() but it needs vma.
> -	 * This should work on most of architectures by default. If
> -	 * architecture needs to do something different it can define
> -	 * its own version of the function.
> +	 * Flush both I/D cache to ensure instruction modification
> +	 * takes effect.
>  	 */
>  	flush_dcache_page(page);
> +	flush_icache_range(addr, addr + len);
>  }

This brings up a handful of issues:

* This always inserts a 32-bit breakpoint, but that's not quite correct.  
  This should really be checking the _next_ instruction as well to 
  insert a 16-bit breakpoint if it's a 16-bit instruction as otherwise 
  userspace might jump into the middle of the breakpoint.
* These instructions can be concurrently executing, which relies on some 
  instruction fetch ordering that's very lightly specified.  We don't 
  rely on that elsewhere (see stop_machine() in kprobes), but we 
  probably should.  It's probably worth adding something to probe the HW 
  to make sure this is supported.
* Adding the icache flush defeats a uprobes advantage in that we'll now 
  be triggering remote execution (to do the remote fence.i).  One option 
  could be to defer the fence and wait on it, but not sure if that's 
  sane and it'd likely require a lot of 

This also leaves a bit undefined WRT icache aliasing, at least in terms 
of the API used.  IMO it'd be

    diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
    index 9d52beeac73c..c857346864fc 100644
    --- a/arch/riscv/kernel/probes/uprobes.c
    +++ b/arch/riscv/kernel/probes/uprobes.c
    @@ -165,7 +165,6 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
     	/* Initialize the slot */
     	void *kaddr = kmap_atomic(page);
     	void *dst = kaddr + (vaddr & ~PAGE_MASK);
    -	unsigned long addr = (unsigned long)dst;
    
     	memcpy(dst, src, len);
    
    @@ -179,8 +178,10 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
    
     	/*
     	 * Flush both I/D cache to ensure instruction modification
    -	 * takes effect.
    +	 * takes effect.  We don't need to flush the whole icache, but that's
    +	 * all RISC-V defines so rather than worry about aliasing this just
    +	 * flushes everything.
     	 */
     	flush_dcache_page(page);
    -	flush_icache_range(addr, addr + len);
    +	flush_icache_all();
     }

which will end up doing the same thing but avoids the ambiguity.  I went 
ahead and put this at palmer/riscv-uprobe_fencei with that and some 
other minor things fixed up, LMK if that looks OK and I'll take it on 
fixes.

Thanks!
