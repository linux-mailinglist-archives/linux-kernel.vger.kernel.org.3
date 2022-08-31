Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0E75A82B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiHaQJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiHaQJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:09:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7A7C6979
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:09:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r4so19008184edi.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=D7yrSuruo4s6Z23jqQyZUhfBAxCgqVkzY+scyb8Ze7Y=;
        b=Ted5C+YR4oK+wxcyEHOLKj6FzsoImkMpRJuLUTQYnKgNH0dOcGYOFPS32XrXRNYkJi
         GGEcItqqTSqrgKly5MLlB/AGOl21JifWWR4OiCBtY352EayXAhdSGL3pPzvBZm7tGt6Q
         WXW2In0ruibGeyq7GjoaAAcbH9+mMSxYVFvUcQkUOF7CAEzxT5hb2ZULwLrHr+etRB5s
         CE7zI4a0tbKTHYGwo5L2Rrg4YhmL62ULp8Vp/1lTaslvbuusgFG5hFhUvS3hU3sJnjuX
         UZZN62GW4BShk0ONNVMjGu9BPyG+x8KRPq4Sa7f7F+61nL17mbhPJE7EmSZSdNzaiIFD
         S+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=D7yrSuruo4s6Z23jqQyZUhfBAxCgqVkzY+scyb8Ze7Y=;
        b=M5oPBLhqc3iUxDxpu0yGVLUewku9zIUkExuLjqEcqHTIf/vLesP5FBrvQoVCpM2VQj
         zwAtGahbIOJqUL6mnNdk/Q2M4owFtAhCxnwW6QbIYlIEoDve+VOGbxTa+Io0rB/f/nfJ
         WIGzaoYUhLEElMjg3ju9CpXhsM0t7Oa8b21PvwMhwlOhlBYhiKKq8qepZVhQ0iF1PZZy
         LelC9Swcbz709IrwSskVPQMnfecBySnb1/wWv/XMznA/9V9K/ecrt3ejpeK+PpgmpJDO
         RRFAX5LOLxhJtEzT5Tq1lAJtmRrhdE9GDYVBcbkXbUDmCH9b4OIIwOS4Tv4oufBsi/XX
         fIow==
X-Gm-Message-State: ACgBeo3NFbb1KZ2gJpNRSE7g/2h9sVxLLBChIV3YxUe3odXvYBYabS2J
        sbkuW3GGT28PqUoLUCsf2E1Ffv10RA1KQraXF7iAMPdrCMM=
X-Google-Smtp-Source: AA6agR6DdtjePB9gwvaF5LlCA7k+h+JVOH8EzgULLXXQVz0tsM+PlgJyv/B9XBmEZjlvBwuP83chUqc3STtbZzM+4b4=
X-Received: by 2002:a05:6402:71a:b0:447:ebb2:18f2 with SMTP id
 w26-20020a056402071a00b00447ebb218f2mr20551185edx.408.1661962144262; Wed, 31
 Aug 2022 09:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220826080230.1712978-1-weiyongjun1@huawei.com>
In-Reply-To: <20220826080230.1712978-1-weiyongjun1@huawei.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 31 Aug 2022 18:08:53 +0200
Message-ID: <CAMRc=Mc-m7JfDqM3ALy43T+S9DdpV8boEy+J6ruQZjLkqbZHPw@mail.gmail.com>
Subject: Re: [PATCH -next 0/2] allow gpio simulator be used as interrupt controller
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 9:44 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> This series allow gpio simulator be used as interrupt controller, the use
> case is mockup some device which using GPIO as interrupt controller, such
> as mcp2515 CAN device. With the dts [1], we can mockup a mcp2515 device,
> and trigger irq by following commands:
>
>  $ echo pull-down > /sys/bus/gpio/devices/gpiochip0/sim_gpio0/pull
>  $ echo pull-up > /sys/bus/gpio/devices/gpiochip0/sim_gpio0/pull
>
>
> --[1]---------------------------------------------------------
> /dts-v1/;
>
> #include <dt-bindings/interrupt-controller/irq.h>
>
> / {
>         clk24m: clk24m {
>                 compatible = "fixed-clock";
>                 clock-output-names = "clk24m";
>                 clock-frequency = <24000000>;
>                 #clock-cells = <0>;
>         };
>
>         gpio-sim {
>                 compatible = "gpio-simulator";
>
>                 bank0: bank0 {
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                         ngpios = <16>;
>
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
>
>                         line_b-hog {
>                                 gpio-hog;
>                                 gpios = <0 1>;
>                                 input;
>                                 line-name = "irq-sim";
>                         };

Why do you need this hog? The GPIO will be marked as requested once
the interrupt is taken by the driver.

>                 };
>         };
>
>         spi: spi {
>                 compatible = "spi-mockup";
>
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
>                 can0: can@1 {
>                         compatible = "microchip,mcp2515";
>                         reg = <1>;
>                         clocks = <&clk24m>;
>                         interrupt-parent = <&bank0>;
>                         interrupts = <0 IRQ_TYPE_EDGE_BOTH>;
>                 };
>
>         };
> };
> ------------------------------><-----------------------------
>
> Wei Yongjun (2):
>   genirq/irq_sim: Allow both one and two cell bindings
>   gpio: sim: make gpio simulator can be used as interrupt controller
>
>  drivers/gpio/gpio-sim.c | 2 +-
>  kernel/irq/irq_sim.c    | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> --
> 2.34.1
>

Can you add some info about this to the documentation?

Otherwise looks good.

Bart
