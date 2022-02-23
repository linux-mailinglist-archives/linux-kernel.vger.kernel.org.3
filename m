Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7654C0CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbiBWHC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238526AbiBWHCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:02:54 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6793BFB7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:02:26 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so37962922wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRZEca9XxWtSPuMYjIlFseYg4Esas5bKwsfEt1eCOA8=;
        b=QIZAImlqRhQHCLYGSrjuJDOCauDvhW1Xw72lbZyNLZmlfJUmufZxFSBB8H2EoKBfKN
         jxoSwFnND2lhvOlCrC0AidfwIohJ6YEjrVIrXGyyGzc+TWJgHAZww2WFDkbsbRxXjul8
         qVPvMzBNI6gfzqTmYteg2xN1VqQ7fqk+Pc1po1AtwoR1q6n08ExvZHauK5YFE7VYcj0Z
         P7U3rFT/AD4Nlw2WtttkORxq2jersjOa1mPgV6CpwJlXuQyh4yx6S86RN13NT2apUzMc
         VKjIZnG57JmHU6woyskYANNc8Yk+LiEB0wEfmqBnv/2JpZcQP5nQaLkRkyXGn6EddG07
         h/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRZEca9XxWtSPuMYjIlFseYg4Esas5bKwsfEt1eCOA8=;
        b=3jAA/xvG2FyZpFD9QozEW3zNB3A7iPcN+QeIw0cGENJtYaWYPsUGchbqilhXtzTg4M
         6qSrx171x+MzOfVGAw16SF7d0M//5liO+zLhIIiiPv7LMJyveeyV6T7YI+EZLAMsx4ai
         tP5ndQ9tXFJiqn73VdAgJxBlTuuSh4focMRGX492w6EWnyFcsSaw6VqbEiHHEjHSzzZ6
         R+8ew4N/l3WsD2URCCFOJueD+97lyp2SADybCEdaddZJEIoiVt15WjJ/DQzmogWMK9Zi
         3w1Er+S1HG9a7kQw3kW1uLoaxZJ9x557fE2un/ZaFpfa8CuPgytI2cZNeTkbMrodXy/N
         OJzA==
X-Gm-Message-State: AOAM532pgBX2RUUrgMWxgUPUKy1Bu/Tm1UErUDw3523Ll+5KAl23Ptvx
        eULBcNcwYgHtVm0+s7xxO/NB/c6TqAeAULWQ8qCBUg==
X-Google-Smtp-Source: ABdhPJzIrMTIABtJTtVWuTHPjm8BpgI0RV6d0ZUOVxs96DHbAWugAxYt8PRNLPnq+EeeWflAFVTZPUTf3jvN2iH+k6Y=
X-Received: by 2002:adf:ec47:0:b0:1e4:a380:bb73 with SMTP id
 w7-20020adfec47000000b001e4a380bb73mr22204190wrn.86.1645599744652; Tue, 22
 Feb 2022 23:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20220210054947.170134-1-apatel@ventanamicro.com> <20220210054947.170134-5-apatel@ventanamicro.com>
In-Reply-To: <20220210054947.170134-5-apatel@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 23 Feb 2022 12:32:11 +0530
Message-ID: <CAAhSdy3jK26WFhG8Q=Up8hhHPpJCCkA09EKOi+B-Kp0U9Rwg7w@mail.gmail.com>
Subject: Re: [PATCH v11 4/8] RISC-V: Add SBI HSM suspend related defines
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <apatel@ventanamicro.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvm-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer

On Thu, Feb 10, 2022 at 11:20 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> From: Anup Patel <anup.patel@wdc.com>
>
> We add defines related to SBI HSM suspend call and also
> update HSM states naming as-per latest SBI specification.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>

This patch is shared with "KVM RISC-V SBI v0.3 support".
(https://lore.kernel.org/all/20220201082227.361967-2-apatel@ventanamicro.com/T/)

How do you want to handle this ?

One option is that I take this patch through the KVM RISC-V tree
and you can send this series (minus this patch) for 5.18 after the
KVM RISC-V changes have been merged.

Regards,
Anup

> ---
>  arch/riscv/include/asm/sbi.h    | 27 ++++++++++++++++++++++-----
>  arch/riscv/kernel/cpu_ops_sbi.c |  2 +-
>  arch/riscv/kvm/vcpu_sbi_hsm.c   |  4 ++--
>  3 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index d1c37479d828..06133b4f8e20 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -71,15 +71,32 @@ enum sbi_ext_hsm_fid {
>         SBI_EXT_HSM_HART_START = 0,
>         SBI_EXT_HSM_HART_STOP,
>         SBI_EXT_HSM_HART_STATUS,
> +       SBI_EXT_HSM_HART_SUSPEND,
>  };
>
> -enum sbi_hsm_hart_status {
> -       SBI_HSM_HART_STATUS_STARTED = 0,
> -       SBI_HSM_HART_STATUS_STOPPED,
> -       SBI_HSM_HART_STATUS_START_PENDING,
> -       SBI_HSM_HART_STATUS_STOP_PENDING,
> +enum sbi_hsm_hart_state {
> +       SBI_HSM_STATE_STARTED = 0,
> +       SBI_HSM_STATE_STOPPED,
> +       SBI_HSM_STATE_START_PENDING,
> +       SBI_HSM_STATE_STOP_PENDING,
> +       SBI_HSM_STATE_SUSPENDED,
> +       SBI_HSM_STATE_SUSPEND_PENDING,
> +       SBI_HSM_STATE_RESUME_PENDING,
>  };
>
> +#define SBI_HSM_SUSP_BASE_MASK                 0x7fffffff
> +#define SBI_HSM_SUSP_NON_RET_BIT               0x80000000
> +#define SBI_HSM_SUSP_PLAT_BASE                 0x10000000
> +
> +#define SBI_HSM_SUSPEND_RET_DEFAULT            0x00000000
> +#define SBI_HSM_SUSPEND_RET_PLATFORM           SBI_HSM_SUSP_PLAT_BASE
> +#define SBI_HSM_SUSPEND_RET_LAST               SBI_HSM_SUSP_BASE_MASK
> +#define SBI_HSM_SUSPEND_NON_RET_DEFAULT                SBI_HSM_SUSP_NON_RET_BIT
> +#define SBI_HSM_SUSPEND_NON_RET_PLATFORM       (SBI_HSM_SUSP_NON_RET_BIT | \
> +                                                SBI_HSM_SUSP_PLAT_BASE)
> +#define SBI_HSM_SUSPEND_NON_RET_LAST           (SBI_HSM_SUSP_NON_RET_BIT | \
> +                                                SBI_HSM_SUSP_BASE_MASK)
> +
>  enum sbi_ext_srst_fid {
>         SBI_EXT_SRST_RESET = 0,
>  };
> diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
> index dae29cbfe550..2e16f6732cdf 100644
> --- a/arch/riscv/kernel/cpu_ops_sbi.c
> +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> @@ -111,7 +111,7 @@ static int sbi_cpu_is_stopped(unsigned int cpuid)
>
>         rc = sbi_hsm_hart_get_status(hartid);
>
> -       if (rc == SBI_HSM_HART_STATUS_STOPPED)
> +       if (rc == SBI_HSM_STATE_STOPPED)
>                 return 0;
>         return rc;
>  }
> diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.c
> index 2e383687fa48..1ac4b2e8e4ec 100644
> --- a/arch/riscv/kvm/vcpu_sbi_hsm.c
> +++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
> @@ -60,9 +60,9 @@ static int kvm_sbi_hsm_vcpu_get_status(struct kvm_vcpu *vcpu)
>         if (!target_vcpu)
>                 return -EINVAL;
>         if (!target_vcpu->arch.power_off)
> -               return SBI_HSM_HART_STATUS_STARTED;
> +               return SBI_HSM_STATE_STARTED;
>         else
> -               return SBI_HSM_HART_STATUS_STOPPED;
> +               return SBI_HSM_STATE_STOPPED;
>  }
>
>  static int kvm_sbi_ext_hsm_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
> --
> 2.25.1
>
