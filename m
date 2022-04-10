Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D764FAB9B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 05:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiDJDQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 23:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiDJDQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 23:16:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F56B8B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 20:14:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so18286295wrg.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 20:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQhVZa5zS/cp4cV+errRXLAMnB+DiB4HyYAPMjkY4K8=;
        b=UFYOXOPG9FCkpBR5SfB6ZkR44JnMOZCnPMNEPGolirtBvQ5K8HohB+06K/9nHFwa2a
         Ph+deIvvix/BQHExSvsHrBVJh5/3eJVwlhPZC+jtXBtIdP/mS+7iB2vgMggKu3S63kiO
         x4Z/QwptpNQyCRLDUz0IYLVtM0E1stgu9ufs1Zs4QCdfwW0sQXW7YOtlMyjr8MHK12Im
         oEaKinFIzLptFh64JdAFr3hPeP0rbqADjvC8pLENolThAhE5ljrA2F32Whd8KIjAKvSl
         jqgibbhtcvZxHoDCj/LZaQjhQwkcSh9xylhniCJeSpQei8K+4dDuLGSLb2mZk5vBbMZa
         xEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQhVZa5zS/cp4cV+errRXLAMnB+DiB4HyYAPMjkY4K8=;
        b=59aHHsg/bz6Sbz8vz0CAXsxFgyOwkr1gRS5n3sCMV1ymCGX9lo5xcA+uv55OUkYjOO
         YXnFaYy43ni9tZF9y6q4AHVUiAVgyqUpJmPWA8mnqqaT67nD3D11/vPksCJeoO5RYdrZ
         /RGs+VXLFnUK3PYpkYmMD3PhTKGDAacxmTcExAqi3ooFQiibi7rSGPFUilg9chkuEV8j
         NGf1kLm667F1kcpjc3zcr7gAPvACeHFl4Q5I3v/aFjqmILAzYCJt48z+WYj6rxJm0YxM
         36Vp2ZLvcf9PPTXxVJLHLfAeWevJtAPDi3PlXZsBOi6+CIl5ifhUP3J8IhR73Iio0kmI
         SQ5A==
X-Gm-Message-State: AOAM5316nNp0ilHNew+AQZC0IP5ljAnri6tqvjv3Tqr9wdtuO/ksTw5H
        5pa+FugB2QOuWkHIAFITBCPj4fwEXBUmkXLJqUEuAg==
X-Google-Smtp-Source: ABdhPJz6wvOSYjEON6CTS085brMf7i9aM1nV/OcdrAV1FXqDOFTBq5x40YE4Gs5+r/euPjtovDTFnNddAHIceO6pOGY=
X-Received: by 2002:a5d:6e84:0:b0:206:147b:1f59 with SMTP id
 k4-20020a5d6e84000000b00206147b1f59mr19852120wrz.86.1649560455158; Sat, 09
 Apr 2022 20:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220409225317.14332-1-rdunlap@infradead.org>
In-Reply-To: <20220409225317.14332-1-rdunlap@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 10 Apr 2022 08:44:03 +0530
Message-ID: <CAAhSdy2090hRn9eS=-NpRVqTHKXYdeed4LORo-sQ-j-eXDfDMQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: cpuidle: fix Kconfig select for RISCV_SBI_CPUIDLE
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 4:23 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> There can be lots of build errors when building cpuidle-riscv-sbi.o.
> They are all caused by a kconfig problem with this warning:
>
> WARNING: unmet direct dependencies detected for RISCV_SBI_CPUIDLE
>   Depends on [n]: CPU_IDLE [=y] && RISCV [=y] && RISCV_SBI [=n]
>   Selected by [y]:
>   - SOC_VIRT [=y] && CPU_IDLE [=y]
>
> so make the 'select' of RISCV_SBI_CPUIDLE also depend on RISCV_SBI.
>
> Fixes: c5179ef1ca0c ("RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Anup Patel <apatel@ventanamicro.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/Kconfig.socs |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -38,7 +38,7 @@ config SOC_VIRT
>         select SIFIVE_PLIC
>         select PM_GENERIC_DOMAINS if PM
>         select PM_GENERIC_DOMAINS_OF if PM && OF
> -       select RISCV_SBI_CPUIDLE if CPU_IDLE
> +       select RISCV_SBI_CPUIDLE if CPU_IDLE && RISCV_SBI
>         help
>           This enables support for QEMU Virt Machine.
>
