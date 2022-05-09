Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B0D520434
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbiEISMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbiEISMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:12:30 -0400
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4711C2AACD8;
        Mon,  9 May 2022 11:08:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437433|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00800986-0.000615016-0.991375;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.Ngpb1vc_1652119708;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Ngpb1vc_1652119708)
          by smtp.aliyun-inc.com(33.37.67.126);
          Tue, 10 May 2022 02:08:29 +0800
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
To:     jringle@gridpoint.com, shc_work@mail.ru,
        Rob Herring <robh@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Paul Boddie <paul@boddie.org.uk>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-serial@vger.kernel.org,
        linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Question about SC16IS752 device tree.
Message-ID: <7c89db86-4055-90b5-6a67-611410f5759f@wanyeetech.com>
Date:   Tue, 10 May 2022 02:08:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I encountered a problem when using the SC16IS752 to expand the serial port.
I connected two Bluetooth modules to the two serial ports extended by the
SC16IS752. The device tree is as follows:

&ssi0 {
     status = "okay";

     num-cs = <2>;

     pinctrl-names = "default";
     pinctrl-0 = <&pins_ssi0>;

     sc16is752: expander@0 {
         compatible = "nxp,sc16is752";
         reg = <0>; /* CE0 */

         spi-rx-bus-width = <1>;
         spi-tx-bus-width = <1>;
         spi-max-frequency = <6000000>;

         clocks = <&exclk_sc16is752>;

         interrupt-parent = <&gpb>;
         interrupts = <18 IRQ_TYPE_EDGE_FALLING>;

         gpio-controller;
         #gpio-cells = <2>;

         bluetooth@0 {
             compatible = "brcm,bcm43438-bt";
             max-speed = <1000000>;

             device-wakeup-gpios = <&gpc 26 GPIO_ACTIVE_HIGH>;
             reset-gpios = <&gpb 17 GPIO_ACTIVE_LOW>;
         };

         bluetooth@1 {
             compatible = "brcm,bcm43438-bt";

             device-wakeup-gpios = <&gpc 28 GPIO_ACTIVE_HIGH>;
             reset-gpios = <&gpb 19 GPIO_ACTIVE_LOW>;
         };
     };
};



There are the following error messages after startup:

[    0.548417] serial serial0-0: controller busy
[    0.553572] serial serial0-0: failure adding device. status -EBUSY
[    0.559764] serial serial0: tty port ttySC0 registered
[    0.565545] spi0.0: ttySC1 at I/O 0x1 (irq = 18, base_baud = 3000000) 
is a SC16IS752
[    0.573987] serial serial1-0: controller busy
[    0.578351] serial serial1-0: failure adding device. status -EBUSY
[    0.585003] serial serial1: tty port ttySC1 registered

And only the module connected to the first serial port (ttySC0) can work 
normally.



If I change the device tree to:

&ssi0 {
     status = "okay";

     num-cs = <2>;

     pinctrl-names = "default";
     pinctrl-0 = <&pins_ssi0>;

     sc16is752: expander@0 {
         compatible = "nxp,sc16is752";
         reg = <0>; /* CE0 */

         spi-rx-bus-width = <1>;
         spi-tx-bus-width = <1>;
         spi-max-frequency = <6000000>;

         clocks = <&exclk_sc16is752>;

         interrupt-parent = <&gpb>;
         interrupts = <18 IRQ_TYPE_EDGE_FALLING>;

         gpio-controller;
         #gpio-cells = <2>;

         bluetooth@0 {
             compatible = "brcm,bcm43438-bt";
             max-speed = <1000000>;

             device-wakeup-gpios = <&gpc 26 GPIO_ACTIVE_HIGH>;
             reset-gpios = <&gpb 17 GPIO_ACTIVE_LOW>;
         };
     };
};

Then there will be no error message, and the module connected to the first
serial port (ttySC0) can also work normally.



After tracing, the problem seems to be in "serdev_device_add()" (line 
111) of
"drivers/tty/serdev/core.c":

int serdev_device_add(struct serdev_device *serdev)
{
     struct serdev_controller *ctrl = serdev->ctrl;
     struct device *parent = serdev->dev.parent;
     int err;

     dev_set_name(&serdev->dev, "%s-%d", dev_name(parent), serdev->nr);

     /* Only a single slave device is currently supported. */
     if (ctrl->serdev) {
         dev_err(&serdev->dev, "controller busy\n");
         return -EBUSY;
     }
     ctrl->serdev = serdev;

     err = device_add(&serdev->dev);
     if (err < 0) {
         dev_err(&serdev->dev, "Can't add %s, status %pe\n",
             dev_name(&serdev->dev), ERR_PTR(err));
         goto err_clear_serdev;
     }

     dev_dbg(&serdev->dev, "device %s registered\n", 
dev_name(&serdev->dev));

     return 0;

err_clear_serdev:
     ctrl->serdev = NULL;
     return err;
}
EXPORT_SYMBOL_GPL(serdev_device_add);



Is there any way to correctly describe the device mounted on the second
serial port (ttySC1) in the device tree? Or how do I need to modify the
"drivers/tty/serdev/core.c" to make the SC16IS752 still work properly
with two child nodes mounted?

Thanks and beset regards!
