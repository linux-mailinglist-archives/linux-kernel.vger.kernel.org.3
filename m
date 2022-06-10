Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5231545B39
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 06:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242236AbiFJEl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 00:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiFJElW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 00:41:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692C8C52
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 21:41:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a15so26401702wrh.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 21:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yt/WwA0fPdpkz+DW1Do2fCGe1LbramqI/akP0aYymAg=;
        b=q7Po0YHXmsuyzhhHC13aDuIszgqL9Hbd6PbRejQui41zVvZUsVWnMh+U6rcN2Sodt/
         h/KyKp/KyzzEyRe3UkmGGaNou1jiZBUxUpAZosChxFarIjKXsw2ccrOyhou1V4wE8q2T
         S4jZiY91degtVO60Fz0K3bZkDxKibL+yaJ/Km0OEvvbevXbagiFEIHYW11HTtBwDJgno
         ct8djD81IMnjOlIts3KBLhK2qJGZCso5qMZSB2V4tZs0r3y9PxQq6PD7rVg90ujhWakh
         Rt6Tsogk5Ki5Dq/8PFMKeg8i6PXr7d/QnKb0ETAs+XlJRvGjlnFVbcL8k+pLt0hJ0Qtz
         twmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yt/WwA0fPdpkz+DW1Do2fCGe1LbramqI/akP0aYymAg=;
        b=pgoC/hucdooKKIfQOMBjQyAdFCQG8U927a+wiG298KVC06noJg8gwitY8ScKHwW/tw
         oJC7Gxgp9Di3AJjkVkz1E4VuQcxflbe7aBmPRRoq20WBvH/ZvlZKF9w5hQaztvnXv6x8
         JMI42RtRrDLmD2A01QRqDw6IV4yRAjEa2E1Sb5Aqpuk0+YT7XoHtfQpy3t/QH/DHh8Ft
         rc2rm8/SCBx0pqQOGCzY9/m3pm8WB7eM+bLS51sMz60iT3FJ4N+PIzpOpn6JLrwCUWh/
         a1Z0rV4HfWldQEAcoR0Um3GbwhnCnkKH9Hb8GXmgAzGKiSfaFTzNdAo72YZhZvBVviuR
         IpHA==
X-Gm-Message-State: AOAM531azrjABxBpns28366tIW0LswGFh+TF2V+8A8peyDW22fgR5AWD
        dZheEvhILoZsL/s5IGNVNApiiUcNQXQpTLEC5YWxow==
X-Google-Smtp-Source: ABdhPJyEHkhtUsa7VS+Z9pjWWeNx1hKCBu75zYTWG1q9BxBnEuaMRuqcwOdxyMWY7IzMybJ5MVOxNs1qSycr+w1MeaY=
X-Received: by 2002:a5d:6384:0:b0:210:5f39:53af with SMTP id
 p4-20020a5d6384000000b002105f3953afmr40247331wru.346.1654836078797; Thu, 09
 Jun 2022 21:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220527042937.1124009-1-atishp@rivosinc.com> <20220527042937.1124009-4-atishp@rivosinc.com>
In-Reply-To: <20220527042937.1124009-4-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 10 Jun 2022 10:11:06 +0530
Message-ID: <CAAhSdy3DXobZK-QSJ9tvG+hLEOD_dz4eqD7yO=Pna1ghhMghKQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] RISC-V: Prefer sstc extension if available
To:     Atish Patra <atishp@rivosinc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 9:59 AM Atish Patra <atishp@rivosinc.com> wrote:
>
> RISC-V ISA has sstc extension which allows updating the next clock event
> via a CSR (stimecmp) instead of an SBI call. This should happen dynamically
> if sstc extension is available. Otherwise, it will fallback to SBI call
> to maintain backward compatibility.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/clocksource/timer-riscv.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 1767f8bf2013..881d9335c92d 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -7,6 +7,9 @@
>   * either be read from the "time" and "timeh" CSRs, and can use the SBI to
>   * setup events, or directly accessed using MMIO registers.
>   */
> +
> +#define pr_fmt(fmt) "timer: " fmt

The "timer: " prefix is too generic. I suggest to use "riscv-timer: "
as a prefix.

> +
>  #include <linux/clocksource.h>
>  #include <linux/clockchips.h>
>  #include <linux/cpu.h>
> @@ -23,11 +26,24 @@
>  #include <asm/sbi.h>
>  #include <asm/timex.h>
>
> +static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
> +
>  static int riscv_clock_next_event(unsigned long delta,
>                 struct clock_event_device *ce)
>  {
> +       u64 next_tval = get_cycles64() + delta;
> +
>         csr_set(CSR_IE, IE_TIE);
> -       sbi_set_timer(get_cycles64() + delta);
> +       if (static_branch_likely(&riscv_sstc_available)) {
> +#if defined(CONFIG_32BIT)
> +               csr_write(CSR_STIMECMP, next_tval & 0xFFFFFFFF);
> +               csr_write(CSR_STIMECMPH, next_tval >> 32);
> +#else
> +               csr_write(CSR_STIMECMP, next_tval);
> +#endif
> +       } else
> +               sbi_set_timer(next_tval);
> +
>         return 0;
>  }
>
> @@ -165,6 +181,12 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>         if (error)
>                 pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
>                        error);
> +
> +       if (riscv_isa_extension_available(NULL, SSTC)) {
> +               pr_info("Timer interrupt in S-mode is available via sstc extension\n");
> +               static_branch_enable(&riscv_sstc_available);
> +       }
> +
>         return error;
>  }
>
> --
> 2.25.1
>

Apart from the minor comment above, this looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
