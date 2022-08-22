Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D670C59C081
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiHVN1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbiHVN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:27:07 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B8131352;
        Mon, 22 Aug 2022 06:27:05 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MBCln0byczGpch;
        Mon, 22 Aug 2022 21:25:25 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 21:27:02 +0800
Subject: Re: [PATCH -next] gpio: mockup: remove gpio debugfs when remove
 device
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220816145225.84283-1-weiyongjun1@huawei.com>
 <CAMRc=McG5Pf4b5HymV1iaFAGqMMEtyYSQi23z9LmjvzmbF4rYg@mail.gmail.com>
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
Message-ID: <7d1b0bb8-838e-1a1e-886f-507b75066df1@huawei.com>
Date:   Mon, 22 Aug 2022 21:27:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=McG5Pf4b5HymV1iaFAGqMMEtyYSQi23z9LmjvzmbF4rYg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 2022/8/19 20:49, Bartosz Golaszewski wrote:
> On Tue, Aug 16, 2022 at 4:34 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>>
>> GPIO mockup debugfs is created in gpio_mockup_probe() but
>> forgot to remove when remove device. This patch add a devm
>> managed callback for removing them.
>>
> 
> The tag -next is for patches that address issues that are in next but
> not yet in master.
>>


> 
> This isn't very relevant as the module needs to be unloaded anyway in
> order to reconfigure the simulated device but I'll apply it as it's
> technically correct. Did you see we have a new one - gpio-sim - that
> uses configfs?
> 
> Bart
> 


I am using gpio-mockup as a interrupt-controller with the change[1],
it works will with overfs dts[2], and can success mockup device and 
trigger the irq. But when switch to gpio-sim, device can not be created 
by dts[3]. Not sure what's wrong with it. Any suggestion?


---------------[1]--------------------------
diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index a2e505a7545c..2b103861fa06 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -447,7 +451,7 @@ static int gpio_mockup_probe(struct platform_device 
*pdev)
  	for (i = 0; i < gc->ngpio; i++)
  		chip->lines[i].dir = GPIO_LINE_DIRECTION_IN;

-	chip->irq_sim_domain = devm_irq_domain_create_sim(dev, NULL,
+	chip->irq_sim_domain = devm_irq_domain_create_sim(dev, dev->fwnode,
  							  gc->ngpio);
  	if (IS_ERR(chip->irq_sim_domain))
  		return PTR_ERR(chip->irq_sim_domain);
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index dd76323ea3fd..e8f71f806a85 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -149,6 +153,7 @@ static void irq_sim_domain_unmap(struct irq_domain 
*domain, unsigned int virq)
  static const struct irq_domain_ops irq_sim_domain_ops = {
  	.map		= irq_sim_domain_map,
  	.unmap		= irq_sim_domain_unmap,
+	.xlate		= irq_domain_xlate_twocell,
  };

--------------------------------------------

---------------[2]--------------------------
/dts-v1/;
/plugin/;

#include <dt-bindings/interrupt-controller/irq.h>

&{/} {
	clk24m: clk24m {
		compatible = "fixed-clock";
		clock-output-names = "clk24m";
		clock-frequency = <24000000>;
		#clock-cells = <0>;
	};

	gpio: gpio {
		compatible = "gpio-mockup";

		gpio-base = <0>;
		nr-gpios = <0x200000>;

		gpio-controller;
		#gpio-cells = <2>;

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

&{/spi} {
	can0: can@1 {
		compatible = "microchip,mcp2515";
		reg = <1>;
		clocks = <&clk24m>;
		interrupts-extended = <&gpio 0 IRQ_TYPE_EDGE_BOTH>;
	};
};

-------------------------------------------


---------------[3]--------------------------

/dts-v1/;
/plugin/;

#include <dt-bindings/interrupt-controller/irq.h>

&{/} {
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
			#interrupt-cells = <1>;
		};
	};
};

&{/spi} {
	can0: can@1 {
		compatible = "microchip,mcp2515";
		reg = <1>;
		clocks = <&clk24m>;
		interrupts-extended = <&bank0 0 IRQ_TYPE_EDGE_BOTH>;
	};
};

-------------------------------------------
