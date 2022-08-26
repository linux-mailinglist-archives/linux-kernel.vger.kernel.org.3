Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944F95A222A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245482AbiHZHpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245587AbiHZHoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:44:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F308D3468;
        Fri, 26 Aug 2022 00:44:40 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MDWy03ZZhzmVLR;
        Fri, 26 Aug 2022 15:42:16 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 15:44:37 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 0/2] allow gpio simulator be used as interrupt controller
Date:   Fri, 26 Aug 2022 08:02:28 +0000
Message-ID: <20220826080230.1712978-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series allow gpio simulator be used as interrupt controller, the use
case is mockup some device which using GPIO as interrupt controller, such
as mcp2515 CAN device. With the dts [1], we can mockup a mcp2515 device,
and trigger irq by following commands:

 $ echo pull-down > /sys/bus/gpio/devices/gpiochip0/sim_gpio0/pull
 $ echo pull-up > /sys/bus/gpio/devices/gpiochip0/sim_gpio0/pull


--[1]---------------------------------------------------------
/dts-v1/;

#include <dt-bindings/interrupt-controller/irq.h>

/ {
	clk24m: clk24m {
		compatible = "fixed-clock";
		clock-output-names = "clk24m";
		clock-frequency = <24000000>;
		#clock-cells = <0>;
	};

	gpio-sim {
		compatible = "gpio-simulator";

		bank0: bank0 {
			gpio-controller;
			#gpio-cells = <2>;
			ngpios = <16>;

			interrupt-controller;
			#interrupt-cells = <2>;

			line_b-hog {
				gpio-hog;
				gpios = <0 1>;
				input;
				line-name = "irq-sim";
			};
		};
	};

	spi: spi {
		compatible = "spi-mockup";

		#address-cells = <1>;
		#size-cells = <0>;

		can0: can@1 {
			compatible = "microchip,mcp2515";
			reg = <1>;
			clocks = <&clk24m>;
			interrupt-parent = <&bank0>;
			interrupts = <0 IRQ_TYPE_EDGE_BOTH>;
		};

	};
};
------------------------------><-----------------------------

Wei Yongjun (2):
  genirq/irq_sim: Allow both one and two cell bindings
  gpio: sim: make gpio simulator can be used as interrupt controller

 drivers/gpio/gpio-sim.c | 2 +-
 kernel/irq/irq_sim.c    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.34.1

