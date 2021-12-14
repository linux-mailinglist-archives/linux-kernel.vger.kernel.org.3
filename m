Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F0647480B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhLNQ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhLNQ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:29:23 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7322FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:22 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id v19so13920865plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=eGG/x4QPCqQaP6RMM2MdkMv32cbPnjErqQtlCB+0gYU=;
        b=glgVLWX7QdhSZMa+a5vYgaJNAC6Eun2qtkU6G4DuAhBKTePbsoQ0rQfp+LKTdbZv4L
         AZBBsQDh3nlUwz8Sg2KxLy06NLZshqPGCOUnfRb+VaYhapvTpAmOf14EAHvr49fBYs2L
         NnciCdq7E2Pe0IVgR4tyw2gnMJgx9UAjfMyQ8OOo2v/0G2GceDxa6ACzQOxQFjFbGscR
         RrhZYHtvF88ZWRoDke9HIR8ISicxXy/TCBsp7+DGvMn0RMdB3MODY0LhWcjV9JlUQs8f
         7sGdreaJ/pmbNSBaDJ70UFOTJVgXvG7jBAd+82M0xwkm2pN2kb/qNnOUJeq4a7QK7OtR
         jXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=eGG/x4QPCqQaP6RMM2MdkMv32cbPnjErqQtlCB+0gYU=;
        b=YD7uDd+jAwSgiWm2+3Q7OzDUGyQ5sLUrE57Fki5ibs65xTVICUB9n8Mvt59nVmD99m
         1kwgW+dsqKxFTY5hPuTaaHi/XuTcBGl+Gh4WfsFnwEZPSsojoedNwcXsGKExOonE506w
         /TatyqQNoUGg0hckIz9zpDQyCn+9zVFT7mDmsIj3C20LSM07E/Az/YGIuI/aH5L6qMJQ
         h7CLCGZU1yN8XO2YbR+7M4F3gqDGTTnZWXZVVnRyFVzZp73LoTZITSXt65U+ojLDJMCj
         JT1vcFgxBg90bi05J6p0voPgnCWaSgxZCUPMBZP3mVfbUTlZzNHXq5EWEABnl0tKn35u
         gZRg==
X-Gm-Message-State: AOAM533mufGhhlXA1lk/AUCuy08nIynkBpW3UzuSSWbFiS34HmgJQ8tb
        8qqDW1m8/+cOvdxb8FDyMT0rmQ==
X-Google-Smtp-Source: ABdhPJy1wQZ5WGmO3vI65foVzRWZ21x/ADXJMxiQZn5VY0tHECLjo8zjzS6MdJfZJLL+1q0/L+EfBg==
X-Received: by 2002:a17:902:b097:b0:141:ec7d:a055 with SMTP id p23-20020a170902b09700b00141ec7da055mr6449771plr.3.1639499361893;
        Tue, 14 Dec 2021 08:29:21 -0800 (PST)
Received: from localhost ([12.163.77.120])
        by smtp.gmail.com with ESMTPSA id h15sm301593pfc.134.2021.12.14.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:29:21 -0800 (PST)
Date:   Tue, 14 Dec 2021 08:29:21 -0800 (PST)
X-Google-Original-Date: Mon, 13 Dec 2021 18:18:04 PST (-0800)
Subject:     Re: [PATCH v9 03/17] riscv: Extending cpufeature.c to detect V-extension
In-Reply-To: <802edef897b4bd40f3ebc2cb47c02b8e2f61a666.1636362169.git.greentime.hu@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-37fab3bf-8fa6-4f02-a7ea-a19f775369a6@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Nov 2021 01:48:15 PST (-0800), greentime.hu@sifive.com wrote:
> From: Guo Ren <ren_guo@c-sky.com>
>
> Current cpufeature.c doesn't support detecting V-extension, because
> "rv64" also contain a 'v' letter and we need to skip it.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/include/uapi/asm/hwcap.h | 1 +
>  arch/riscv/kernel/cpufeature.c      | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/hwcap.h b/arch/riscv/include/uapi/asm/hwcap.h
> index 46dc3f5ee99f..c52bb7bbbabe 100644
> --- a/arch/riscv/include/uapi/asm/hwcap.h
> +++ b/arch/riscv/include/uapi/asm/hwcap.h
> @@ -21,5 +21,6 @@
>  #define COMPAT_HWCAP_ISA_F	(1 << ('F' - 'A'))
>  #define COMPAT_HWCAP_ISA_D	(1 << ('D' - 'A'))
>  #define COMPAT_HWCAP_ISA_C	(1 << ('C' - 'A'))
> +#define COMPAT_HWCAP_ISA_V	(1 << ('V' - 'A'))
>
>  #endif /* _UAPI_ASM_RISCV_HWCAP_H */
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index d959d207a40d..7069e55335d0 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -73,6 +73,7 @@ void __init riscv_fill_hwcap(void)
>  	isa2hwcap['f'] = isa2hwcap['F'] = COMPAT_HWCAP_ISA_F;
>  	isa2hwcap['d'] = isa2hwcap['D'] = COMPAT_HWCAP_ISA_D;
>  	isa2hwcap['c'] = isa2hwcap['C'] = COMPAT_HWCAP_ISA_C;
> +	isa2hwcap['v'] = isa2hwcap['V'] = COMPAT_HWCAP_ISA_V;
>
>  	elf_hwcap = 0;

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
