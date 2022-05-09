Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C4751F323
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiEID7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiEIDzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:55:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C971A043
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:51:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v12so17586925wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 20:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kY8j3urZiYftEoIWj6itnjrLji/bjKW8y+9+36z3Zcs=;
        b=x1Timy6cr18MwlxY9CF20GOJ+EnM2i6uvBz1w/xy/gkEKH0DgUot6cF7QhnrQn6KL8
         9Ry9NGv/m6fXIAOBPNitKX7+Oup8CPJBsSoYtximCtydKFwTLK5grzqVsIph+N7vJIEC
         eyzDRFYZxht7POr0XFGsw7Qu/aBfAre1m7VjYbJOCOfMXCV5WKmcHQtGg6dCGuD4Ye5w
         PMSwN6Q2BpYNmhg+hSklRbTVHJJKcN5+aQCvAopHMDtQXrKjkd1UdaXrNZ1QOY2TtcAb
         1jH0OOjse1qPAJijLMVZJr58Z27OUbdb91gOA+mMQcYgrGFNEIPpMXgGXqsnFeV1gOTS
         Dqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kY8j3urZiYftEoIWj6itnjrLji/bjKW8y+9+36z3Zcs=;
        b=rvL0Wh+pKSGcodGKxzeYnQbzqgVx3eWx0686hJiQYD0E1OY5469D9ehl4ILbhCHLg5
         pU5iSEUCQETf2WDmBv+VmZ1NonZClVwSrasfJ+bzjlY1mUN0sdxxi2rsVBKGLw0oaz0B
         PRpXKZZPHjy/Cj3AsSPks20agB+0pCz208zXf4q+kCn+jQ7WBEfPJVxwsONhXMVqeAb+
         31xmpb63+3sdNu6aTNAEjAfyCnL7+w+QTv3kEAbA2fyw7lyTPWZ7iCPaYDQD49UmRrTQ
         hMvXwcQGGpWURSXha/GG/cgej+lX2S4OnNy5hMO9Z/5KRx6Zn3YQ5u9EdVt/2kuvH8ru
         I7NA==
X-Gm-Message-State: AOAM531V47hTYeoEiwhiqlswYuLmA2Li9o2R9ax7P6tAnznaL7m1mqtT
        RWXFdojT00RHe0BBhgnDNKuyvdbgAfYNQa649GyvFg==
X-Google-Smtp-Source: ABdhPJzGALp9+kp1rOS/bBcWeW4rsd2dKqwnGmnsPp3YJ+N0Itw9CLsIZkoFqr5YwhcZF3R01ErVkbi/Wfw0+uHyIOo=
X-Received: by 2002:a5d:6483:0:b0:20c:5c21:5c8c with SMTP id
 o3-20020a5d6483000000b0020c5c215c8cmr12089506wri.86.1652068280641; Sun, 08
 May 2022 20:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220509012121.40031-1-samuel@sholland.org>
In-Reply-To: <20220509012121.40031-1-samuel@sholland.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 9 May 2022 09:21:09 +0530
Message-ID: <CAAhSdy0U23M1wL9xxh20w23xEY-MjxoxxdXVy50G7p8=eXxWKw@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/riscv: Events are stopped during CPU suspend
To:     Samuel Holland <samuel@sholland.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 6:51 AM Samuel Holland <samuel@sholland.org> wrote:
>
> Some implementations of the SBI time extension depend on hart-local
> state (for example, CSRs) that are lost or hardware that is powered
> down when a CPU is suspended. To be safe, the clockevents driver
> cannot assume that timer IRQs will be received during CPU suspend.
>
> Fixes: 62b019436814 ("clocksource: new RISC-V SBI timer driver")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>
>  drivers/clocksource/timer-riscv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 1767f8bf2013..593d5a957b69 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -34,7 +34,7 @@ static int riscv_clock_next_event(unsigned long delta,
>  static unsigned int riscv_clock_event_irq;
>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
>         .name                   = "riscv_timer_clockevent",
> -       .features               = CLOCK_EVT_FEAT_ONESHOT,
> +       .features               = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
>         .rating                 = 100,
>         .set_next_event         = riscv_clock_next_event,
>  };
> --
> 2.35.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
