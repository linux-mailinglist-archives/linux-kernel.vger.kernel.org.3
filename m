Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97055AF536
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiIFUBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiIFUB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:01:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FB11658D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:57:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b16so16591684edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 12:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=o3FJxGbvo/djmf1/vSZvVYYgwgJJ+geM2X/sdQK6HR0=;
        b=AvqcZcCnPk5VAPbLzem17L6T87zN2kazPPScK9Y9l1+t8COyNRphx0SVnhuE3Lz0pA
         vnV2hNbLPc0OAMgbZQXglLnhmiDxG+gjKcEcEZmnME3Cuub10N0L07UIvsZrToRrTqVt
         4EptUWVyAWuDEKXYZnFZ/ypnjqPuZ9WRJIvh42R8jC+pXis03VCH0xFPP5sz8jpvxgXd
         nAeMaiwqB2aZHBR85LIrsuH60VPqX5z3FS8uCdVWBGXrvn6CFpUUB3+ruOyellRD4Lvo
         w5qlFJMLPkAujnmi4/GLTmgc+1JJLn+hwwNSNuhh3+RXn4RQIVshe0qdj1kqGbooZvAX
         BqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=o3FJxGbvo/djmf1/vSZvVYYgwgJJ+geM2X/sdQK6HR0=;
        b=m0f0Nb42Uo74dWV1C+3ICHydaKBLZ6HEd3Ufch/I7lAw0FLjWxNCo86SqECptcyJCc
         9x/RP3q3P0ZVuJyrefYDem+h542ITn+I1EcbBAtl5kOUgOOa/C8kSAiV7ui8fNiLnwJK
         yB9yz3ea2QtjWHUIlRpfUp68rieiIxtHLMeOW1XvLuzUOOwAoOtYWXKRN2rBNKqHs0UD
         4DWr6BWtsbag3LhtQzOL00okOaqSgSFV9o27lmfyEa1CzuaZMSrKFHtijvf/ajKgcJrp
         W24fDVmpyf47oKonQFNAS01TIsqA7osBmK7XR7A9Um3qi4xPekK61UT28KZVk2JXqDWz
         8njA==
X-Gm-Message-State: ACgBeo1bKccu8+K19cNupkc9rcTpdJLOcAmB9gnT6PKvaWlv4flwH4p4
        eLC8k3quO62b0hQ0ALlDv84=
X-Google-Smtp-Source: AA6agR5hdGoggyr7fRQYHp8N7yV1d5NR3lZZ6rZ6eA78jVDZ/BEMIc5kqWx5sFYkBgBmhAhjqOW0YA==
X-Received: by 2002:a05:6402:2b88:b0:43a:6c58:6c64 with SMTP id fj8-20020a0564022b8800b0043a6c586c64mr204259edb.348.1662494057026;
        Tue, 06 Sep 2022 12:54:17 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906264a00b0073cf8e0355fsm6941414ejc.208.2022.09.06.12.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:54:16 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     maxime@cerno.tech, daniel.lezcano@linaro.org, tglx@linutronix.de,
        wens@csie.org, samuel@sholland.org,
        Victor Hassan <victor@allwinnertech.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [RESEND] clocksource: sun4i: add definition of clear interrupt
Date:   Tue, 06 Sep 2022 21:54:15 +0200
Message-ID: <2113704.irdbgypaU6@kista>
In-Reply-To: <20220906052056.43404-1-victor@allwinnertech.com>
References: <20220906052056.43404-1-victor@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 06. september 2022 ob 07:20:56 CEST je Victor Hassan napisal(a):
> To prevent misunderstanding, use TIMER_IRQ_CLEAR instead of TIMER_IRQ_EN
> in function sun4i_timer_clear_interrupt.
> 
> Signed-off-by: Victor Hassan <victor@allwinnertech.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clocksource/timer-sun4i.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-sun4i.c
> b/drivers/clocksource/timer-sun4i.c index 94dc6e42e983..e5a70aa1deb4 100644
> --- a/drivers/clocksource/timer-sun4i.c
> +++ b/drivers/clocksource/timer-sun4i.c
> @@ -26,6 +26,7 @@
>  #define TIMER_IRQ_EN_REG	0x00
>  #define TIMER_IRQ_EN(val)		BIT(val)
>  #define TIMER_IRQ_ST_REG	0x04
> +#define TIMER_IRQ_CLEAR(val)		BIT(val)
>  #define TIMER_CTL_REG(val)	(0x10 * val + 0x10)
>  #define TIMER_CTL_ENABLE		BIT(0)
>  #define TIMER_CTL_RELOAD		BIT(1)
> @@ -123,7 +124,7 @@ static int sun4i_clkevt_next_event(unsigned long evt,
> 
>  static void sun4i_timer_clear_interrupt(void __iomem *base)
>  {
> -	writel(TIMER_IRQ_EN(0), base + TIMER_IRQ_ST_REG);
> +	writel(TIMER_IRQ_CLEAR(0), base + TIMER_IRQ_ST_REG);
>  }
> 
>  static irqreturn_t sun4i_timer_interrupt(int irq, void *dev_id)
> --
> 2.29.0


