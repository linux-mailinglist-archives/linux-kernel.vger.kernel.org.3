Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05CF52D01E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbiESKFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbiESKFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:05:36 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89C199C2F8;
        Thu, 19 May 2022 03:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From; bh=FZ3hy
        egvo2S44gZY7fZKV/hVLJK/8ShMe+XuaT4PYxc=; b=dxl60OA1T6jte5C/lcC2p
        G/JraAB2FkY3J+YMjw76lediE6XrGrQUz+X5TwvvviQm5qFJV+7zkiMje1iNUS99
        5yO0O+0qch0kPhXkFgedPGrNcQsb+JcVAL4wPx3mI5tG5xkdtjBHCVfKI8bYIjps
        glABlVo6Mna6eQwC9OO4pc=
Received: from [192.168.3.103] (unknown [218.201.129.20])
        by smtp12 (Coremail) with SMTP id EMCowABHHpAxFoZiI0+HAQ--.1426S2;
        Thu, 19 May 2022 18:04:35 +0800 (CST)
Message-ID: <264cb004-677a-13df-cc68-676ef3c2e7d8@163.com>
Date:   Thu, 19 May 2022 18:04:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 0/2] ARM: sun8i-r40: Enable usb otg support
Content-Language: en-US
To:     linux-sunxi@lists.linux.dev
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Evgeny Boger <boger@wirenboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220518101706.26869-1-qianfanguijin@163.com>
From:   qianfan <qianfanguijin@163.com>
In-Reply-To: <20220518101706.26869-1-qianfanguijin@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowABHHpAxFoZiI0+HAQ--.1426S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw1UGr45urW7uF48Gw1DAwb_yoW5urWDpF
        W7XrZ3Gw1kt343AFW3WFWUXa1fA3yrZ3yUJrn3tFy8Ar43ur4DA3ZrKrZ8KasrWr17Zw47
        Kwn5Jrn7Krn0gF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jONVkUUUUU=
X-Originating-IP: [218.201.129.20]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiXBMG7VXl29+6cQAAsb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/18 18:17, qianfanguijin@163.com 写道:
> From: qianfan Zhao <qianfanguijin@163.com>
>
> History:
> =======
>
> v4(2022-05-18):
> - Enable both musb and OHCI/EHCI support
>
> Tests:
> ======
>
> All test cases were tested on bananapi-m2-ultra.
>
> 1. USB DEVICE(ping test)
>
> Enable usb gadget rndis network, ping m2u on ubuntu host:
>
> ➜  ~ ping 192.168.200.2
> PING 192.168.200.2 (192.168.200.2) 56(84) bytes of data.
> 64 bytes from 192.168.200.2: icmp_seq=1 ttl=64 time=0.544 ms
> 64 bytes from 192.168.200.2: icmp_seq=2 ttl=64 time=0.269 ms
> 64 bytes from 192.168.200.2: icmp_seq=3 ttl=64 time=0.300 ms
> 64 bytes from 192.168.200.2: icmp_seq=4 ttl=64 time=0.295 ms
> 64 bytes from 192.168.200.2: icmp_seq=5 ttl=64 time=0.283 ms
> 64 bytes from 192.168.200.2: icmp_seq=6 ttl=64 time=0.226 ms
> 64 bytes from 192.168.200.2: icmp_seq=7 ttl=64 time=0.246 ms
> 64 bytes from 192.168.200.2: icmp_seq=8 ttl=64 time=0.204 ms
> 64 bytes from 192.168.200.2: icmp_seq=9 ttl=64 time=0.302 ms
> 64 bytes from 192.168.200.2: icmp_seq=10 ttl=64 time=0.249 ms
> 64 bytes from 192.168.200.2: icmp_seq=11 ttl=64 time=0.459 ms
> 64 bytes from 192.168.200.2: icmp_seq=12 ttl=64 time=0.232 ms
> 64 bytes from 192.168.200.2: icmp_seq=13 ttl=64 time=0.275 ms
> 64 bytes from 192.168.200.2: icmp_seq=14 ttl=64 time=0.243 ms
>
> 2. USB HOST(OHCI)
>
> Connect an usb serial port on OTG port, nex t is the kernel log:
>
> [   27.824137] usb 2-1: new full-speed USB device number 2 using ohci-platform
> [   28.865504] cdc_acm 2-1:1.0: ttyACM0: USB ACM device
> [   29.565509] cdc_acm 2-1:1.2: ttyACM1: USB ACM device
>
> 3. USB HOST(EHCI)
>
> Connect an usb storage on OTG port, next is the kernel log:
>
> [   17.754147] usb 1-1: new high-speed USB device number 2 using ehci-platform
> [   17.955995] usb-storage 1-1:1.0: USB Mass Storage device detected
> [   18.024497] scsi host1: usb-storage 1-1:1.0
> [   19.035091] scsi 1:0:0:0: Direct-Access     General  USB Flash Disk   1.0  PQ: 0 ANSI: 2
> [   19.049717] sd 1:0:0:0: [sda] 7831552 512-byte logical blocks: (4.01 GB/3.73 GiB)
> [   19.060873] sd 1:0:0:0: [sda] Write Protect is off
> [   19.071018] sd 1:0:0:0: [sda] No Caching mode page found
> [   19.076437] sd 1:0:0:0: [sda] Assuming drive cache: write through
> [   19.093566]  sda: sda1
> [   19.103492] sd 1:0:0:0: [sda] Attached SCSI removable disk
>
> issues:
> =======
>
> The system power often turned off when I plugged an usb device into the OTG port.
> It's not clear why.
It is not caused by software.

According to the schematic of M2U, there is a 100uF capacitor on the 
USBVBUS,
but noting on ACIN. The board is powered by ACIN when I test usb otg,
plugged an usb storage into the otg port, USB0 enter host mode and will
enable the USBVBUS power supply through N_VBUSEN. At this time due to the
limits of ACIN, the input voltage dropped and AXP enter shutdown protection
state.

This problem was sloved when I mounted a large capacitor on ACIN.
Both usb device and host stack can work fine now.
>
> qianfan Zhao (2):
>    ARM: dts: sun8i-r40: Add USB0_OTG/HOST support
>    ARM: dts: bananapi-m2-ultra: Enable USB0_OTG and HOST support
>
>   .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 39 +++++++++++++++++++
>   arch/arm/boot/dts/sun8i-r40.dtsi              | 34 ++++++++++++++++
>   2 files changed, 73 insertions(+)
>

