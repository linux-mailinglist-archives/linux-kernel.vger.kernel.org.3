Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5604C49EE5E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbiA0XAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiA0XAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:00:22 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB18C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:00:22 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f8so3640648pgf.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=tq+t6dQQFVkt1ehPK5dsRce++PeJ+NkaC2Fr9danrFg=;
        b=BuErwWWlO434CFRs160cmmmqeCVMq4U++BxGBAu6HZFmRUHzvqVMu04MGgHnuraFMr
         +33ZFKW7NH/vlk9bvSxkNRocThdzS/IRyMqFLFO9/tOscGu00GpVN7ZhTD0Dp1SUeBj4
         Qc6OjS2Eqw3oE5fbIKOGFCmwxjuYpzdOZ77cT+fMRNZHpwmOGruueSfZCC2pe6ppxq2S
         yMgzFP7Gag5dFOOGRWd2PWjFIyiet/vHjfULH+d+DdEHSLfndWouf399u229H5VpZ8xn
         uV4pWRwMgylNSDJPHf06RZsMeb+VTt+lHv7clQbT9zHBwYjOW2iMcHBnXrYdc/JKWp3D
         TF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=tq+t6dQQFVkt1ehPK5dsRce++PeJ+NkaC2Fr9danrFg=;
        b=hWdGiNhJnY68B/c3O+6g+4HB8BfhAZD8EqhjVZVPTfAIidb0DB0enAaM/7emDlO792
         +qNetVH1wOS2pxF3Aq8jtLxYafkh7W50V7hVSw/yTtvpa7LryUucX2C39AZIJtw7eD7w
         5yIbR1a97Qzl5o8bxJQNR0xXRkq+0/+E6NIy2uGNHXHRf12IUF89Uiuqg8R9sOrWww10
         E3vNTsSuj8csuU22itOHb8oUv2CcBSsSgHEq3+xpEONTNQSiK932kQDjXtnWIHiTicWR
         m61CNt6y9i4f54oxga0k/25OTo6Jz9PmHRS7qrRRtDNGjSWknM8FCBqTCVULt4Hwo6eR
         vFeg==
X-Gm-Message-State: AOAM533sdWsdD5zbFZTFq0sfColi4L84+6pkcbQJYnDbPloBY9qJiTWE
        26iP5O/OplBfT09L4qW7gQguYA==
X-Google-Smtp-Source: ABdhPJxpcmPb3nGBT2wvGe/q2isQrAKpZg2RNFkHBXl7+vTN26uFcrQDHHCG5MC6e3PSipgfXYj0ig==
X-Received: by 2002:a05:6a00:10d2:: with SMTP id d18mr5119105pfu.2.1643324422178;
        Thu, 27 Jan 2022 15:00:22 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id d18sm4610605pfu.127.2022.01.27.15.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 15:00:21 -0800 (PST)
Date:   Thu, 27 Jan 2022 15:00:21 -0800 (PST)
X-Google-Original-Date: Thu, 27 Jan 2022 14:59:18 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Prevent sbi_ecall() from being inlined
In-Reply-To: <20220127195554.15705-1-palmer@rivosinc.com>
Message-ID: <mhng-a2eafdcc-50bf-4947-a52c-e7c89a0f6c86@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        Atish Patra <atishp@rivosinc.com>, jszhang@kernel.org,
        vincent.chen@sifive.com, sunnanyong@huawei.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>, stable@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Atish Patra <atishp@rivosinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 11:55:55 PST (-0800), Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> The SBI spec defines SBI calls as following the standard calling
> convention, but we don't actually inform GCC of that when making an

As per some discussion on the SBI spec, this definition isn't internally 
consistent.  I've got some WIP to make proper inline SBI macros -- 
that'll be necessary either way the spec goes (ie, to get rid of all the 
zeros), but I'm going to leave this alone until the spec gets sorted 
out.

> ecall.  Unfortunately this does actually manifest for the more complex
> SBI call wrappers, for example sbi_s, for example sbi_send_ipi_v02()
> uses t1.
>
> This patch just marks sbi_ecall() as noinline, which implicitly enforces
> the standard calling convention.
>
> Fixes : b9dcd9e41587 ("RISC-V: Add basic support for SBI v0.2")
> Cc: stable@vger.kernel.org
> Reported-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> This is more of a stop-gap fix than anything else, but it's small enough
> that it should be straight-forward to back port to stable.  This bug has
> existed forever, in theory, but none of this was specified in SBI-0.1
> so the backport to the introduction of 0.2 should be sufficient.
> No extant versions OpenSBI or BBL will manifest issues here, as they
> save all registers, but the spec is quite explicit so we're better off
> getting back in line sooner rather than later.
>
> There'll be some marginal performance impact here.  I'll send a
> follow-on to clean up the SBI call wrappers in a way that allows
> inlining without violating the spec, but that'll be a bigger change and
> thus isn't really suitable for stable.
> ---
>  arch/riscv/kernel/sbi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index f72527fcb347..7be586f5dc69 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -21,6 +21,11 @@ static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
>  			   unsigned long start, unsigned long size,
>  			   unsigned long arg4, unsigned long arg5) __ro_after_init;
>
> +/*
> + * This ecall stub can't be inlined because we're relying on the presence of a
> + * function call to enforce the calling convention.
> + */
> +noinline
>  struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  			unsigned long arg1, unsigned long arg2,
>  			unsigned long arg3, unsigned long arg4,
