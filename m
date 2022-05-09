Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464B351F2C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiEIDFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiEIDAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:00:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0080A82D02
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 19:56:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x18so17562075wrc.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 19:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zGLs8GoeHHxow0QHkE6WAhpRqq163am1P8u8l/0Qawg=;
        b=bAwc46bgzRfoc2DLiYdlzCkJPvcTGnfgzRzweu1C2fVcg65WP1trATs3acTrH2BCpt
         81BISgEST0FFiyAi91rjBzJ2CcK8WtoctbuwX8fVb6oHVQkkPjJti5aNXrfLRwEwdBwh
         Pooh4iBSsUnxbSHf7vQeTOP+CzQZbTv++VBlRsCQdHVNNn2ASO5mLA/QefvHvWD+6s0a
         eUj93XWAurLLDFWehur4TNlOEyKlCHm5EZoURSXu6c1XR7zzsn21bwm7Xhp36MO+emEL
         WZSA6YWOrVmJ2oan2T0b2rg6BfN2ZIYMVD5tTFdyhEhhJ+6MnkGdDRz3FeTqBXkviG3a
         arKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zGLs8GoeHHxow0QHkE6WAhpRqq163am1P8u8l/0Qawg=;
        b=aQd5NTbn1gQoxAMcnS7AgXvtnJCcgl3nIClTIM1F3AlNeFlAIPJY1ZnjmK60CLmskJ
         Q1D3ZEmGPifoJgSj91JL2INDYe0qJDjsiq/bYEWF+Z633VsUvdO/eC0QEAIpAKlcxXMf
         9aTSMpKgclv0FeR7ivSQYjkisCqSr9CmOkugx0x2/vBbYa1I0BCoizgKg975Ty9j8rpT
         69QJcQsixuNNoLiqMMViG/BGJyvDurscwn8OvrTja/5rl0qYFVKN9eqT6Wm1zAvls+Gp
         sG3thUcSZa8S97F3KZ6qvlEOOVawoR/hayTtTLrODeUzddKEhnjFv6E/akmeAw61xI8B
         gFuw==
X-Gm-Message-State: AOAM53204jmQ6791MaNamXEmZEXZrVlksY9MQYNQhTa+F8+Mg/8cnncF
        dSBdLouuNaHxFQFI9vkEotIKog==
X-Google-Smtp-Source: ABdhPJy059/eM8oV+XQ+w8slguW1SE1QSeWz1ma5e97+6eHR1i6LQS94bQGbba8RybbXFq3PKp2VTw==
X-Received: by 2002:a5d:584a:0:b0:20c:45fe:b02e with SMTP id i10-20020a5d584a000000b0020c45feb02emr11717800wrf.504.1652065004531;
        Sun, 08 May 2022 19:56:44 -0700 (PDT)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id q20-20020a7bce94000000b0039456fb80b3sm13680708wmj.43.2022.05.08.19.56.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2022 19:56:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] clocksource/drivers/riscv: Events are stopped during CPU
 suspend
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20220509012121.40031-1-samuel@sholland.org>
Date:   Mon, 9 May 2022 03:56:43 +0100
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <878D1D3C-E8F1-4B37-93F1-B3560E3F271E@jrtc27.com>
References: <20220509012121.40031-1-samuel@sholland.org>
To:     Samuel Holland <samuel@sholland.org>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 May 2022, at 02:21, Samuel Holland <samuel@sholland.org> wrote:
>=20
> Some implementations of the SBI time extension depend on hart-local
> state (for example, CSRs) that are lost or hardware that is powered
> down when a CPU is suspended. To be safe, the clockevents driver
> cannot assume that timer IRQs will be received during CPU suspend.
>=20
> Fixes: 62b019436814 ("clocksource: new RISC-V SBI timer driver")

Surely that=E2=80=99s not right? A commit from 2018 can=E2=80=99t have =
been expected to
predict the future, I would expect this to be one of the patches adding
suspend to RISC-V which came years later.

Jess

> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
> drivers/clocksource/timer-riscv.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clocksource/timer-riscv.c =
b/drivers/clocksource/timer-riscv.c
> index 1767f8bf2013..593d5a957b69 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -34,7 +34,7 @@ static int riscv_clock_next_event(unsigned long =
delta,
> static unsigned int riscv_clock_event_irq;
> static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) =3D =
{
> 	.name			=3D "riscv_timer_clockevent",
> -	.features		=3D CLOCK_EVT_FEAT_ONESHOT,
> +	.features		=3D CLOCK_EVT_FEAT_ONESHOT | =
CLOCK_EVT_FEAT_C3STOP,
> 	.rating			=3D 100,
> 	.set_next_event		=3D riscv_clock_next_event,
> };
> --=20
> 2.35.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

