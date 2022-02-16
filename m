Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7D14B826C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiBPH5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:57:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiBPH53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:57:29 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A87462C5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:57:17 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id l125so3614558ybl.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMtBLX0dxO/FEXDrSK4WwXrfvEvOmP/i+ozpjhDxh2o=;
        b=EGr7uINoD4BR8i3qX/tomHNRruYcjc/QbsipOZJBMwQk2ZyhvOQqpMphIFGGGWNWd3
         JuGaeHSzEymH3RXHvUYHLSTERTs3AOZYPXnaVJ7N/QHn/Lzy8Soxfsdbwy63HmyHvoGF
         ibPohfBIFhqTBcVfC4PMPdPyf0zXr8PsqaP7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMtBLX0dxO/FEXDrSK4WwXrfvEvOmP/i+ozpjhDxh2o=;
        b=rWEPJV5rjUkIumhETRs6qVqAR5D7bHqYdS9UCbY4ujZWmVGrqKTnDg5ufxTVVbP+b/
         MqZAJx3RtAtD/z/4u/GnsBAoE9aSxIxqaUxgC/EJB58OewPvUfrehNiMddJw/qvSDlUE
         Bn30PKhCLWpckj6K/AC4iUM3o26zdmytnB0cu6KjZTC3ZkfimZpBo00ZP/P4/scnBSPW
         R+aHaP2HlsbZGGNvGJ1nygh8p6gPuicILzlgIN+7PvxhR7UUHfBWBcPz7A2bC3B1WDD7
         Sur3F9K/dw8RCbKPHfsp92tOzvyN4aJ1RXNvqQXiBiRnWUDHcimkqETUhP9bSxXDE/sS
         b+Wg==
X-Gm-Message-State: AOAM533Gw2qoafu38DN/Z5ZxxI9oJtdoqwMcSwfmsPCAY8zU0wwY2v5v
        fm3uV8oDyW2pPu9TzP+d5F8+DMph09bNTIU+cRou
X-Google-Smtp-Source: ABdhPJxexRI1WA8BLHddNiaTLw6WNqMOfbfVIS1bSiAe/Miw7A1PF3HzHsObN1ZBqCdCL+fBicqD5iLDeOuq1uHkDM4=
X-Received: by 2002:a5b:ec5:0:b0:615:4edf:4641 with SMTP id
 a5-20020a5b0ec5000000b006154edf4641mr1079024ybs.494.1644998236462; Tue, 15
 Feb 2022 23:57:16 -0800 (PST)
MIME-Version: 1.0
References: <20220210054947.170134-1-apatel@ventanamicro.com> <20220210054947.170134-5-apatel@ventanamicro.com>
In-Reply-To: <20220210054947.170134-5-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 15 Feb 2022 23:57:05 -0800
Message-ID: <CAOnJCU+VpiMtkoKBTLn9kzNxdLaFmedhNX=K36O+42nTkfZ0-A@mail.gmail.com>
Subject: Re: [PATCH v11 4/8] RISC-V: Add SBI HSM suspend related defines
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        kvm-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
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

On Wed, Feb 9, 2022 at 9:50 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> From: Anup Patel <anup.patel@wdc.com>
>
> We add defines related to SBI HSM suspend call and also
> update HSM states naming as-per latest SBI specification.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
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

Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
