Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2939247480E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhLNQ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbhLNQ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:29:28 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02FAC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:27 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id np3so14709496pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=LbhcwdEjVBuTWcw138d9uhpwM/fmzxoan1Tk4b0oxOk=;
        b=o213zq5gjrDybTwk1avMHBjs463xMZsvVZIbrQKKDZhb/59GcjtymJ2NyqMimZN2Om
         ArOhKAfNdnAcvm03VvIZj135E4y4kKpaIu4KIyOoLGLQ6BtveAVTwdXn8nRUivKojwKM
         o16ONNQpycnxn32bRD6rSsfRA2PVfHunP4GwkKzJiGfLZf2SD3lKjyYt1e1WQq739cUH
         iVrInqIQwTMxvXrQ+z2BrbVlSRNhiGkaLiQgfiCo6sNx7P8fQWUbhTTPoUEKgsQvuU2u
         XSNQBxrnXShKAD3uIUPGJI14ZTmwIbEf7yiF3YW2hrkh8C8zippTKPbVZu0xyTEgctAx
         1RAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=LbhcwdEjVBuTWcw138d9uhpwM/fmzxoan1Tk4b0oxOk=;
        b=jtD0x8RSvv/06C5In1Z3mQDNqfHTBeEvNNh6yDaPOn9Qz3GTMMu9zlePflfAf+t2ko
         XDN/sSWyQChwpjkhLokHRkQsgfwTA/h/VTwehgpR4sZ9j6/35hUMJkW9dhwT2wGlgGJz
         D9zXU6/8JtR+bzzTfAYZD3MRwaTojZwZN+b613U3DL8Kgx31KfqAoEU+dfw7aWT9QA9C
         r0iut8os1Tmk3Z8Kb/DCj/q7iLwe4VDHBBsFJEp5M6AldI66gUVamMgI/qRjZJEOO1EB
         x20PpnNf0wLtwcI38FNLIgh1pCEn2gz6ZVU2AwgpPkb/tptFQNqmU/VK6uoTqFbPFN4A
         Bq8A==
X-Gm-Message-State: AOAM530DF/WfeBLKJ0TXy34aqRMWce+gsTHKvcHFd1vJVQcYbKcZcu/l
        lEOhMsimxm+fMBrQIcQdfQNIug==
X-Google-Smtp-Source: ABdhPJzYKzHCxWlO4x1Csefyyo13hL4E3aSLw+rdmFxGOG/bUDmCjyGV/lfWbLwo7Tkau0pcgpoTYA==
X-Received: by 2002:a17:902:d4d0:b0:141:c13d:6c20 with SMTP id o16-20020a170902d4d000b00141c13d6c20mr6689302plg.44.1639499367222;
        Tue, 14 Dec 2021 08:29:27 -0800 (PST)
Received: from localhost ([12.163.77.120])
        by smtp.gmail.com with ESMTPSA id d9sm2705493pjs.2.2021.12.14.08.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:29:26 -0800 (PST)
Date:   Tue, 14 Dec 2021 08:29:26 -0800 (PST)
X-Google-Original-Date: Mon, 13 Dec 2021 18:25:36 PST (-0800)
Subject:     Re: [PATCH v9 06/17] riscv: Add has_vector/riscv_vsize to save vector features.
In-Reply-To: <8652c476f08626d52f0412ca1a8427cfe7b4104f.1636362169.git.greentime.hu@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-bd89b83f-fd99-42b2-ac20-c3d98a4468e4@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Nov 2021 01:48:18 PST (-0800), greentime.hu@sifive.com wrote:
> This patch is used to detect vector support status of CPU and use
> riscv_vsize to save the size of all the vector registers. It assumes
> all harts has the same capabilities in SMP system.
>
> [guoren@linux.alibaba.com: add has_vector checking]
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>

IMO those SOB flags are a bit out of order, but checkpatch isn't 
complaining so I'm not sure it matters.  Otherwise:

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

> ---
>  arch/riscv/kernel/cpufeature.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 7069e55335d0..8e7557980faf 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -21,6 +21,11 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>  #ifdef CONFIG_FPU
>  __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
>  #endif
> +#ifdef CONFIG_VECTOR
> +#include <asm/vector.h>
> +__ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_vector);
> +unsigned long riscv_vsize __read_mostly;
> +#endif
>
>  /**
>   * riscv_isa_extension_base() - Get base extension word
> @@ -149,4 +154,12 @@ void __init riscv_fill_hwcap(void)
>  	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
>  		static_branch_enable(&cpu_hwcap_fpu);
>  #endif
> +
> +#ifdef CONFIG_VECTOR
> +	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
> +		static_branch_enable(&cpu_hwcap_vector);
> +		/* There are 32 vector registers with vlenb length. */
> +		riscv_vsize = csr_read(CSR_VLENB) * 32;
> +	}
> +#endif
>  }
