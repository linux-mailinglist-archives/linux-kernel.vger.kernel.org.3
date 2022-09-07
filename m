Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BAE5B1047
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiIGXTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGXTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:19:02 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C915A5C63
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:19:02 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n202so12741705iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5s+/z3LbG16phtl9JO7vOWUQlm5jNkM0JFVTs4xEW9s=;
        b=GPQ3jJEEy5M5EX1xdIrIdhDRh7M+5SaaxpNluTRX0qdq8pZH/NFDUkT1E1cya2Gudi
         6SYA6TWH5qyszXcE9MYGBKRGqN3dkLxtG6AZomv0IThffRJr6gYSugm54lcFzbm7HVNT
         82Hl7LGUfM4jElD+9WDa56y8MqJqqMmiNBaF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5s+/z3LbG16phtl9JO7vOWUQlm5jNkM0JFVTs4xEW9s=;
        b=yVVfiTf4T3VNyDnznaZKh47mzf8Rdd+s6TzR7euUFGuHaajl5ADmMXb3avF9xOEaRG
         CDbBHWepIjSdWWCsCx+7f2lOQ2eV+oOT1MAI2uK5SGMeHrr8QmS0oJwiG7yzOq0L4chP
         gGx/myw6pWh23pFW7fL2JzCOuWydAygr0aIL2JVHIp/zX5vyB2BFe4MZe2iRJcBZL8Ie
         IfHu0XcvazE8+M5lKZYQxntiF0Psc/K3aqwuWdfq8v+eus/P+dY+E//PxE2NuMb/iaSu
         TWpl/YHNEzOd5LssHJrspdMcufhunTYjwIX+BLHeFNh4TETISvBh+3ySOBvJbU+qRTTj
         tl/w==
X-Gm-Message-State: ACgBeo13+3xf52+0bNUcnxYcQDbTu27jSbOiDqIYhkqBdhbFJp96mBDL
        28HlWABypifdPD2+j8MuM+zOM7aQYV6OHlpWr2Hq
X-Google-Smtp-Source: AA6agR4qVC6K53oiD5S2CXD4kDmiPRnlO9iJamA6NEcnBmtjeBcMDgfblyBkIw2bVgVaD5cRhH8CGSB3WRcauTPh+90=
X-Received: by 2002:a6b:c504:0:b0:68b:6802:2bfe with SMTP id
 v4-20020a6bc504000000b0068b68022bfemr2925600iof.22.1662592741648; Wed, 07 Sep
 2022 16:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220903161309.32848-1-apatel@ventanamicro.com> <20220903161309.32848-2-apatel@ventanamicro.com>
In-Reply-To: <20220903161309.32848-2-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 7 Sep 2022 16:18:51 -0700
Message-ID: <CAOnJCUJb0cYe=fcpAi4cnNatH6ukvFP+GgEQZhmx7t=niFLcng@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] RISC-V: Clear SIP bit only when using SBI IPI operations
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 3, 2022 at 9:13 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> The software interrupt pending (i.e. [M|S]SIP) bit is writeable for
> S-mode but read-only for M-mode so we clear this bit only when using
> SBI IPI operations.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>  arch/riscv/kernel/sbi.c | 8 +++++++-
>  arch/riscv/kernel/smp.c | 2 --
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 775d3322b422..fc614650a2e3 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -643,8 +643,14 @@ static void sbi_send_cpumask_ipi(const struct cpumask *target)
>         sbi_send_ipi(target);
>  }
>
> +static void sbi_ipi_clear(void)
> +{
> +       csr_clear(CSR_IP, IE_SIE);
> +}
> +
>  static const struct riscv_ipi_ops sbi_ipi_ops = {
> -       .ipi_inject = sbi_send_cpumask_ipi
> +       .ipi_inject = sbi_send_cpumask_ipi,
> +       .ipi_clear = sbi_ipi_clear
>  };
>
>  void __init sbi_init(void)
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 760a64518c58..c56d67f53ea9 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -83,8 +83,6 @@ void riscv_clear_ipi(void)
>  {
>         if (ipi_ops && ipi_ops->ipi_clear)
>                 ipi_ops->ipi_clear();
> -
> -       csr_clear(CSR_IP, IE_SIE);
>  }
>  EXPORT_SYMBOL_GPL(riscv_clear_ipi);
>
> --
> 2.34.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>


-- 
Regards,
Atish
