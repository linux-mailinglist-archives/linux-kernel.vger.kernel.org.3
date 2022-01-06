Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91433485F70
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 05:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiAFEAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 23:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiAFEAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 23:00:30 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4125C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 20:00:29 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d10-20020a17090a498a00b001b33bc40d01so631568pjh.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 20:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=0WJAe8vxjl7vSZNcsIANJLCfbMukeeVxdbXpzSS2gAY=;
        b=ytgcbQT85rdiawNwIyNcmPAuOq1gXc082nJNwsH/uch+gt+c/Q6UZ07G5jrsOgOop1
         bO7jsFge3z23IBfV0H/87EJWQNukgjXSxVLoZsyWjBnVMUETB175M2Nr9E631UjjBmSa
         dsRZehQs/7k3uyGOUkuwZk2fdhnqSkNATY5oVO1rEcDxaJ9AS94RrYWGMvAfTiStc7FA
         rhVGcKTMoYcqxDaC7Hb1rbQW3bkyPu/KY5iCIUjKoRnq0OoQwm9WzN402ZwYapdc5EPt
         Yvq0aHZnueTzCBh64xNI+SvxqAVt6biXZ0odcK0/bepo47S3XUxZKCU+ExWWnLsMhqT4
         HLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=0WJAe8vxjl7vSZNcsIANJLCfbMukeeVxdbXpzSS2gAY=;
        b=cmoY6r2Hi/YouaHtbi19tK1nrCj/pSxz+L2nq0tYm8JyYyU63zRA7IagIInXYDbfyq
         D0EV72TVpqW3wyaqykVdI7xZ6LhhE7EzY0L/qi30qJsP4jf6XqlQEjzXrKNq48XaboLB
         k7U6WXCn6Orl3Xva40Nurpcb7eu16adztUrB3An3iystHhJPH8x5M1ZtLn9YLj+fh+F6
         V3lJSjuxB/ZunNfy3qTtI2IWWYmo8CREwUwOd+K7grO/PEL4M05uLLf2ukXNb81aISTS
         jl4ar+0p3mtY3oxsadypL0DcFxEP2MY6PRpbxOLwxx9uRtREXfD5cGMmSepsmsKsX+42
         82dQ==
X-Gm-Message-State: AOAM533louMwEJQs0rMKXRPezz3M1TplojwlwCYn2VLKm7zupokY2eB3
        e7ByLX9jfqAEclOkPii7mRqc2g==
X-Google-Smtp-Source: ABdhPJwt+sA0b9fOzrA68i35DqvHURvTEr2bonu6wgYtO3so+VTX2HerFCO2ByZL3HWYpBfKyW5mSw==
X-Received: by 2002:a17:902:8ec7:b0:149:8d21:3e49 with SMTP id x7-20020a1709028ec700b001498d213e49mr39833770plo.111.1641441629379;
        Wed, 05 Jan 2022 20:00:29 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id l191sm441909pgd.8.2022.01.05.20.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 20:00:28 -0800 (PST)
Date:   Wed, 05 Jan 2022 20:00:28 -0800 (PST)
X-Google-Original-Date: Wed, 05 Jan 2022 19:32:22 PST (-0800)
Subject:     Re: [PATCH] riscv: Make vmalloc/vmemmap end equal to the start of the next region
In-Reply-To: <20211118134539.137212-1-alexandre.ghiti@canonical.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.ghiti@canonical.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexandre.ghiti@canonical.com
Message-ID: <mhng-2006bfc7-264b-4d1b-96a3-6b4a012f8be9@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 05:45:39 PST (-0800), alexandre.ghiti@canonical.com wrote:
> We used to define VMALLOC_END equal to the start of the next region
> *minus one* which is inconsistent with the use of this define in the
> core code (for example, see the definitions of VMALLOC_TOTAL and
> is_vmalloc_addr).
>
> And then make the definition of VMEMMAP_END consistent with VMALLOC_END
> and all other regions actually.
>
> Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 4 ++--
>  arch/riscv/mm/fault.c            | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index d34f3a7a9701..5155048274c2 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -25,7 +25,7 @@
>  #endif
>
>  #define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> -#define VMALLOC_END      (PAGE_OFFSET - 1)
> +#define VMALLOC_END      PAGE_OFFSET
>  #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
>
>  #define BPF_JIT_REGION_SIZE	(SZ_128M)
> @@ -53,7 +53,7 @@
>  #define VMEMMAP_SHIFT \
>  	(CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
>  #define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
> -#define VMEMMAP_END	(VMALLOC_START - 1)
> +#define VMEMMAP_END	VMALLOC_START
>  #define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
>
>  /*
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index aa08dd2f8fae..41ae0aa8f2b8 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -235,7 +235,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  	 * only copy the information from the master page table,
>  	 * nothing more.
>  	 */
> -	if (unlikely((addr >= VMALLOC_START) && (addr <= VMALLOC_END))) {
> +	if (unlikely((addr >= VMALLOC_START) && (addr < VMALLOC_END))) {
>  		vmalloc_fault(regs, code, addr);
>  		return;
>  	}

Thanks, this is on for-next.
