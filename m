Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B792552232C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348441AbiEJR5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbiEJR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:57:30 -0400
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEF460B9E;
        Tue, 10 May 2022 10:53:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436371|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0728242-0.00472228-0.922454;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.NhaEB4._1652205206;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NhaEB4._1652205206)
          by smtp.aliyun-inc.com(33.32.24.88);
          Wed, 11 May 2022 01:53:28 +0800
Subject: Re: Question about SC16IS752 device tree.
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, jringle@gridpoint.com,
        shc_work@mail.ru, Rob Herring <robh@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-serial@vger.kernel.org,
        linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        johan@kernel.org, tomasz.mon@camlingroup.com,
        l.perczak@camlintechnologies.com
References: <7c89db86-4055-90b5-6a67-611410f5759f@wanyeetech.com>
 <ZYNMBR.VDVV3VHFQBMO1@crapouillou.net>
 <04bd0853-7e34-5210-f1b5-f3ea8c35e484@wanyeetech.com>
 <501852E6-6934-4BB2-850C-B53A07580568@goldelico.com>
 <8533f999-f584-ea31-0c44-1ce29c066d88@wanyeetech.com>
 <1B523C47-1F9C-42EE-B242-EF63F89B94F9@goldelico.com>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <35c60fea-ac74-9d23-51ac-b877a5b4eb86@wanyeetech.com>
Date:   Wed, 11 May 2022 01:53:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1B523C47-1F9C-42EE-B242-EF63F89B94F9@goldelico.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/5/10 下午11:31, H. Nikolaus Schaller wrote:
> Hi,
>
>> Am 10.05.2022 um 04:29 schrieb Zhou Yanjie <zhouyanjie@wanyeetech.com>:
>>
>> Hi Nikolaus,
>>
>> On 2022/5/10 上午4:19, H. Nikolaus Schaller wrote:
>>> Hi,
>>>
>>>> Am 09.05.2022 um 20:41 schrieb Zhou Yanjie <zhouyanjie@wanyeetech.com>:
>>>>
>>>> Hi Paul,
>>>>
>>>> On 2022/5/10 上午2:13, Paul Cercueil wrote:
>>>>> I can't say for sure that it's your problem, but your bluetooth nodes are missing "reg" properties.
>>>> Unfortunately it doesn't seem to be the problem here, I added "reg" and
>>>> the problem persists, and I've looked at other device trees that contain
>>>> "brcm,bcm43438-bt", none of them use "reg", and "reg" is not mentioned in
>>>> neither "Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt" nor
>>>> "Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml".
>>> what happens if you remove the serdev children from DTS? Does the driver create two separate /dev/tty ports? And do they work?
>>
>> Yes, there will be two separate /dev/tty ports (ttySC0 and ttySC1), and
>> both ports can work normally, but at this time the two bluetooth modules
>> are not working.
>>
>> I guess it is because the driver does not detect bluetooth module nodes,
>> so the inability to operate "reset-gpios" and "device-wakeup-gpios" causes
>> the bluetooth module to work incorrectly.
> I would assume that it is not prepared to handle two serdev subnodes and
> assign the right gpios.


I found something new now, if I follow the practice in 
"fsl-ls1012a-frdm.dts"
and put the clock node inside the node of SC16IS752:

&ssi0 {
     status = "okay";

     num-cs = <2>;

     pinctrl-names = "default";
     pinctrl-0 = <&pins_ssi0>;

     sc16is752: expander@0 {
         compatible = "nxp,sc16is752";
         reg = <0>; /* CE0 */
         #address-cells = <1>;
         #size-cells = <0>;

         spi-rx-bus-width = <1>;
         spi-tx-bus-width = <1>;
         spi-max-frequency = <6000000>;

         clocks = <&exclk_sc16is752>;

         interrupt-parent = <&gpb>;
         interrupts = <18 IRQ_TYPE_EDGE_FALLING>;

         gpio-controller;
         #gpio-cells = <2>;

         exclk_sc16is752: sc16is752 {
             compatible = "fixed-clock";
             #clock-cells = <0>;
             clock-frequency = <48000000>;
         };

         bluetooth@0 {
             compatible = "brcm,bcm43438-bt";
             reg = <0>;
             max-speed = <1000000>;

             device-wakeup-gpios = <&gpc 26 GPIO_ACTIVE_HIGH>;
             reset-gpios = <&gpb 17 GPIO_ACTIVE_LOW>;
         };

         bluetooth@1 {
             compatible = "brcm,bcm43438-bt";
             reg = <1>;
             max-speed = <1000000>;

             device-wakeup-gpios = <&gpc 28 GPIO_ACTIVE_HIGH>;
             reset-gpios = <&gpb 19 GPIO_ACTIVE_LOW>;
         };
     };
};

This will cause all bluetooth modules to not work, and if the clock node 
is moved
to the end of the child node, the bluetooth module connected to ttySC0 
can work
normally, which seems to mean that only the first child node can work 
correctly.



And I found this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/drivers/tty/serdev?h=usb-next&id=08fcee289f341786eb3b44e5f2d1dc850943238e

It seems to mean that the SC16IS752 driver does not correctly 
distinguish between
the two serial ports, which makes the serdev driver think that the child 
nodes are
on the same serial device bus, which leads to the current problem.


>
>>
>>> Maybe the sc16is752 driver does not separate them for child nodes, i.e. while "reg" should be added it may not be handled?
>>
>> I'm not too sure, I'm not very familiar with serial port systems.
>> If the truth is what you think, how should I improve it?
> Unfortunately I also don't know how the serdev implementation really works.
>
> It was my nagging to make it happen by persistently proposing a non-universal
> solutionsome years ago until one of the maintainers had mercy to write a general
> solution. So I could switch my driver to simply use the serdev API. It was for a GPS
> client device but not a tty side driver.
>
> I think if you look up the first patches for the serdev interface this should
> reveal the original author an he should be able to help.


The original author of the serdev driver is Rob Herring, the original 
author of the
SC16IS752 is Jon Ringle, they are already on the CC list, I also added 
Johan Hovold
and the two authors Tomasz Moń and Lech Percza who sent patches to the 
sc16is7xx.c
driver in this year.

Hopefully they can guide us here.


Best regards!


>
> BR,
> Nikolaus
