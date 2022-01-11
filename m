Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E75148B3DF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiAKR3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344251AbiAKR3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:29:31 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6F3C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:29:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso82519pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=0KOZZtBBHeRkDdzPa5q1c2gpML5kGszF4xNBuuJ1X9U=;
        b=BY+u4bbQYNdmyC//Bv7GXEy44FwwMX1t8rhum6wd1C6taLrxSBJ8VnvLfUTJnhLyJc
         zkEyjQdABPJozjs5FtWLufh9s2aO4dwtnYExrwqXs+hJJTnK5YlFQhjhsWkFbKtMrwnQ
         hl5sUhV/kCsZLAmq1IMR7VyZvWX7/qOulYJL0ipcijr+6TfmxELjjtkxcW3L9/OcEjW0
         fiKatqDE+DAJDX1tiNaHAZm/Vp7xNdxll0cDi1MXedP3l/FCC0AbKopQYeBue/Um2a5w
         C1FEf9NdCrpehpHgC8xbGi6InBo4FYj91x8oFnAmiR1gRdpd/KpLHtKG3DbKJlznmVu6
         T/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=0KOZZtBBHeRkDdzPa5q1c2gpML5kGszF4xNBuuJ1X9U=;
        b=rpRigpLO6qHHkDWKrEx2uYE82Fo1IoFbQSdTHi1lnf4DrXONjnmhhmONmXCoa+CXuH
         LqUDz/k2cgeJNXcL2PCOicbZiCEbldkzYGltaKVus9zvVF97f7Jese2P6cm914vjeAyW
         AKhtW3xxSj6fwUuhwIakn7xeR1trfV7aWKv/XHH3v9kTqUNubcB40GUhDF4DjEb4dWOG
         LNm+XusKxk5LqY8vQVPtu15uNbEZyoWNkJLLv/ma1skZnCSPwwtrMDlx2acPrRhEsjTN
         jHZ1UstT4aWBboOAkC2rU+f/pD1G17bjOlJ+oLWiH9JGB38KUq/dF7WkHSQqb5bU1VlH
         G20Q==
X-Gm-Message-State: AOAM5316dsd4T6m4cqO2Zv8j8/UugRJsziPVdpZNtaG2eKh23oWapxow
        V5Jx0Hd54HTL4psvDVnJOisvhA==
X-Google-Smtp-Source: ABdhPJyUE27xqXcOOzoFLUBZ4NAdrQAHxnQ+OXs+EEHJQJXAtXGuafe0Df391hbXvZogvp0dzrXr4Q==
X-Received: by 2002:a65:5589:: with SMTP id j9mr4910464pgs.119.1641922170977;
        Tue, 11 Jan 2022 09:29:30 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k13sm11560322pfc.60.2022.01.11.09.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:29:30 -0800 (PST)
Date:   Tue, 11 Jan 2022 09:29:30 -0800 (PST)
X-Google-Original-Date: Tue, 11 Jan 2022 09:29:03 PST (-0800)
Subject:     Re: [PATCH v2 2/5] riscv: mm: init: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
In-Reply-To: <20211206160514.2000-3-jszhang@kernel.org>
CC:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, ebiederm@xmission.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-ef554c87-32d1-443f-805d-3f74b88cd1f0@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 08:05:11 PST (-0800), jszhang@kernel.org wrote:
> Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
> by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
> and increase compile coverage.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/mm/init.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index a15640eeb334..84879a5ce818 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -748,7 +748,6 @@ static inline void setup_vm_final(void)
>  }
>  #endif /* CONFIG_MMU */
>
> -#ifdef CONFIG_KEXEC_CORE
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel
>   *
> @@ -765,6 +764,8 @@ static void __init reserve_crashkernel(void)
>
>  	int ret = 0;
>
> +	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> +		return;
>  	/*
>  	 * Don't reserve a region for a crash kernel on a crash kernel
>  	 * since it doesn't make much sense and we have limited memory
> @@ -805,7 +806,6 @@ static void __init reserve_crashkernel(void)
>  	crashk_res.start = crash_base;
>  	crashk_res.end = crash_base + crash_size - 1;
>  }
> -#endif /* CONFIG_KEXEC_CORE */
>
>  void __init paging_init(void)
>  {
> @@ -819,9 +819,7 @@ void __init misc_mem_init(void)
>  	arch_numa_init();
>  	sparse_init();
>  	zone_sizes_init();
> -#ifdef CONFIG_KEXEC_CORE
>  	reserve_crashkernel();
> -#endif
>  	memblock_dump_all();
>  }

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

LMK if you wanted me to take this through the RISC-V tree, otherwise I'm 
going to assume all these are going in together.

Thanks!
