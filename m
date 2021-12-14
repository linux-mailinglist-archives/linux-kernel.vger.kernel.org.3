Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D437747480D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbhLNQ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbhLNQ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:29:29 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CBBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:29 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 133so17721730pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=V+ydo3gew2SKxvpZ3hxRhW+QZ1Gz2SK9X1d8Iz9cNxo=;
        b=R00rhPSQX8t8g4zJf1i1Il6quwQB+ml3G14WFmUpwHwFfoyrSR9upCnwgrVingJr+R
         hEPSQv2Q8W9CMjQ/NglGNJIF8IO6zsakR2AB4z5QeEvDD8p8YroTGrFI0gfG7nGVWN77
         biP52ICj9SCqUOTn7WxsL7tEuTzHU/lBb6rwuQgCLeeW8lyy8VhKVEuL4j0vwDPpVZLi
         yKeD1nG3olaKzCBtwZvBoV1hsMy2AUCzEW6eN8LU/HFtcvFK9xAeND6NqLEehcom3jHL
         37bKgpw0sHtsI1ZrjrW0+S9M+45CRsQAEHPCeazKdnoigJscg6pGD/Cdh+fmJqWyGLGg
         D0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=V+ydo3gew2SKxvpZ3hxRhW+QZ1Gz2SK9X1d8Iz9cNxo=;
        b=Vg5KfMTFvunXqn/WBTPzXCVYbtSlP7nR7cZvmcAjTQ/IRmp+0z7OkT1SjgFql/sNkK
         v6vFs3Bj8NQt9OULjfvU1l/WBFxZB/z4p3gKHSl8aio//p1oUj09z1A+/h7TL1RexoFs
         PM+hFGaiMe4FaHLEgicbCKugAI9OxNWN4BsrNHU6JMmqW3K9+xSQ7TXM5B7RnF5j7ACp
         0+wccYcY0ipZ6Oc+4eot0sad3TjBfAdpgStKR+CgzC3bUHWq5rU8qY9HHwReDAqMPBaW
         L6Z8l7byIaPwqN3W39KY7codMqDJcU4UTpWDF06t6pq70WuJ/NBAqRyFSqIxd/9Txwd+
         OQTg==
X-Gm-Message-State: AOAM5305j5q8F1pSaDS+AhMTcFxUszLaA2tbkTN+8vYNihA3m4zMbBgr
        yLZXybUe1WoFTEYKxc7ZsJT5xQ==
X-Google-Smtp-Source: ABdhPJyYKf1iQgpEISETh/1o3WuN6++61aQmoVgMfqwklhdicGoc4eqPhD8/epozrfONZ7jod4JW+w==
X-Received: by 2002:a65:4941:: with SMTP id q1mr4513985pgs.123.1639499368927;
        Tue, 14 Dec 2021 08:29:28 -0800 (PST)
Received: from localhost ([12.163.77.120])
        by smtp.gmail.com with ESMTPSA id v13sm368582pfu.38.2021.12.14.08.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:29:28 -0800 (PST)
Date:   Tue, 14 Dec 2021 08:29:28 -0800 (PST)
X-Google-Original-Date: Mon, 13 Dec 2021 19:34:29 PST (-0800)
Subject:     Re: [PATCH v9 07/17] riscv: Reset vector register
In-Reply-To: <8612e69a10235e67fac8a55864e77a4ab8f771ac.1636362169.git.greentime.hu@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-591e217f-9290-464e-ab17-91fd84bed22b@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Nov 2021 01:48:19 PST (-0800), greentime.hu@sifive.com wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Reset vector registers at boot-time and disable vector instructions
> execution for kernel mode.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Co-developed-by: Han-Kuan Chen <hankuan.chen@sifive.com>
> Signed-off-by: Han-Kuan Chen <hankuan.chen@sifive.com>
> Co-developed-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/kernel/entry.S |  6 +++---
>  arch/riscv/kernel/head.S  | 22 ++++++++++++++++++++--
>  2 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 98f502654edd..ad0fa80ada81 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -77,10 +77,10 @@ _save_context:
>  	 * Disable user-mode memory access as it should only be set in the
>  	 * actual user copy routines.
>  	 *
> -	 * Disable the FPU to detect illegal usage of floating point in kernel
> -	 * space.
> +	 * Disable the FPU/Vector to detect illegal usage of floating point
> +	 * or vector in kernel space.
>  	 */
> -	li t0, SR_SUM | SR_FS
> +	li t0, SR_SUM | SR_FS | SR_VS
>
>  	REG_L s0, TASK_TI_USER_SP(tp)
>  	csrrc s1, CSR_STATUS, t0
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 52c5ff9804c5..551afe1de85e 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -242,10 +242,10 @@ pmp_done:
>  .option pop
>
>  	/*
> -	 * Disable FPU to detect illegal usage of
> +	 * Disable FPU & VECTOR to detect illegal usage of
>  	 * floating point in kernel space

Presumably that should be "floating point or vector", like the other 
one?

>  	 */
> -	li t0, SR_FS
> +	li t0, SR_FS | SR_VS
>  	csrc CSR_STATUS, t0
>
>  #ifdef CONFIG_SMP
> @@ -433,6 +433,24 @@ ENTRY(reset_regs)
>  	csrw	fcsr, 0
>  	/* note that the caller must clear SR_FS */
>  #endif /* CONFIG_FPU */
> +
> +#ifdef CONFIG_VECTOR
> +	csrr	t0, CSR_MISA
> +	li	t1, (COMPAT_HWCAP_ISA_V >> 16)
> +	slli	t1, t1, 16

Why?  Shouldn't the "li" pseudo handle generating that constant fine?  
It generates the expected lui for me.

> +	and	t0, t0, t1
> +	beqz	t0, .Lreset_regs_done
> +
> +	li	t1, SR_VS
> +	csrs	CSR_STATUS, t1
> +	vsetvli t1, x0, e8, m8
> +	vmv.v.i v0, 0
> +	vmv.v.i v8, 0
> +	vmv.v.i v16, 0
> +	vmv.v.i v24, 0

I don't see anything resetting vcsr here, which is explicitly required 
by ISA manual.

Otherwise this looks OK to me: I wasn't actually sure this was guaranteed 
to hit every bit in the vector register file, but IIUC it does -- VLMAX 
has a defined value, VLEN is a constant, and this form of vsetvli is 
defined to set vl to VLMAX.  Probably worth a comment, though.

> +	/* note that the caller must clear SR_VS */
> +#endif /* CONFIG_VECTOR */
> +
>  .Lreset_regs_done:
>  	ret
>  END(reset_regs)

With those minor bits fixed,

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
