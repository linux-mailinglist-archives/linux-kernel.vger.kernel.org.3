Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBEE532632
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiEXJQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiEXJQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:16:38 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBA831D314;
        Tue, 24 May 2022 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From; bh=6bHKB
        N/3QBi7HzN/vwEopZXo21vzzru1+xafDO7zm/8=; b=L7Q/+yfYROd3FnDLltavy
        zVXjGu/4+M1TvU/HFo0Kxipslob/GjEvc4qu9bv5toD1N8hbvys54EP1BwB9yGfu
        6cmneO10AQFXUby3pKbx9+JQkp+CxEUeejCv0FEfUtqJFupl/EzUJLs7jvx/4la0
        2UE0pmtRUcWcw6aMN2qKas=
Received: from [192.168.3.102] (unknown [218.201.129.20])
        by smtp12 (Coremail) with SMTP id EMCowABnTDU8ooxiXDX+BA--.128S2;
        Tue, 24 May 2022 17:15:43 +0800 (CST)
Message-ID: <12833b83-59a9-a808-4d62-60658df8d628@163.com>
Date:   Tue, 24 May 2022 17:15:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 0/2] ARM: sun8i-r40: Enable usb otg support
Content-Language: en-US
To:     Icenowy Zheng <icenowy@aosc.io>, linux-sunxi@lists.linux.dev
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
 <a50307f826e8e5f4218bd2bfde23add8a26af0dc.camel@aosc.io>
From:   qianfan <qianfanguijin@163.com>
In-Reply-To: <a50307f826e8e5f4218bd2bfde23add8a26af0dc.camel@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowABnTDU8ooxiXDX+BA--.128S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw43GFy5WFW7trWfWw4kJFb_yoW5Cw1kpF
        W7XFZ7Gw1ktw1Syay3ua4UW3y3Z3yrXayjyFn3tFy8Ar13ur1DAanrKr95KasxWr13Zw47
        Kwn5Jwn3Kr1YgF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jONVkUUUUU=
X-Originating-IP: [218.201.129.20]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/xtbBzh8L7WI0UkpUyQAAsk
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/23 21:11, Icenowy Zheng 写道:
> 在 2022-05-18星期三的 18:17 +0800，qianfanguijin@163.com写道：
>> From: qianfan Zhao <qianfanguijin@163.com>
>>
>> History:
>> =======
>>
>> v4(2022-05-18):
>> - Enable both musb and OHCI/EHCI support
>>
>> Tests:
>> ======
>>
>> All test cases were tested on bananapi-m2-ultra.
>>
>> 1. USB DEVICE(ping test)
>>
>> Enable usb gadget rndis network, ping m2u on ubuntu host:
> Interestingly musb previous totally fail when I initially work on R40.
> Maybe some phy-sun4i-usb patches fixed it by accident?
Hi, could you please try this patch again?
>
>> ➜  ~ ping 192.168.200.2
>> PING 192.168.200.2 (192.168.200.2) 56(84) bytes of data.
>> 64 bytes from 192.168.200.2: icmp_seq=1 ttl=64 time=0.544 ms
>> 64 bytes from 192.168.200.2: icmp_seq=2 ttl=64 time=0.269 ms
>> 64 bytes from 192.168.200.2: icmp_seq=3 ttl=64 time=0.300 ms
>> 64 bytes from 192.168.200.2: icmp_seq=4 ttl=64 time=0.295 ms
>> 64 bytes from 192.168.200.2: icmp_seq=5 ttl=64 time=0.283 ms
>> 64 bytes from 192.168.200.2: icmp_seq=6 ttl=64 time=0.226 ms
>> 64 bytes from 192.168.200.2: icmp_seq=7 ttl=64 time=0.246 ms
>> 64 bytes from 192.168.200.2: icmp_seq=8 ttl=64 time=0.204 ms
>> 64 bytes from 192.168.200.2: icmp_seq=9 ttl=64 time=0.302 ms
>> 64 bytes from 192.168.200.2: icmp_seq=10 ttl=64 time=0.249 ms
>> 64 bytes from 192.168.200.2: icmp_seq=11 ttl=64 time=0.459 ms
>> 64 bytes from 192.168.200.2: icmp_seq=12 ttl=64 time=0.232 ms
>> 64 bytes from 192.168.200.2: icmp_seq=13 ttl=64 time=0.275 ms
>> 64 bytes from 192.168.200.2: icmp_seq=14 ttl=64 time=0.243 ms
>>
>> 2. USB HOST(OHCI)
>>
>> Connect an usb serial port on OTG port, nex t is the kernel log:
>>
>> [   27.824137] usb 2-1: new full-speed USB device number 2 using
>> ohci-platform
>> [   28.865504] cdc_acm 2-1:1.0: ttyACM0: USB ACM device
>> [   29.565509] cdc_acm 2-1:1.2: ttyACM1: USB ACM device
>>
>> 3. USB HOST(EHCI)
>>
>> Connect an usb storage on OTG port, next is the kernel log:
>>
>> [   17.754147] usb 1-1: new high-speed USB device number 2 using
>> ehci-platform
>> [   17.955995] usb-storage 1-1:1.0: USB Mass Storage device detected
>> [   18.024497] scsi host1: usb-storage 1-1:1.0
>> [   19.035091] scsi 1:0:0:0: Direct-Access     General  USB Flash
>> Disk   1.0  PQ: 0 ANSI: 2
>> [   19.049717] sd 1:0:0:0: [sda] 7831552 512-byte logical blocks:
>> (4.01 GB/3.73 GiB)
>> [   19.060873] sd 1:0:0:0: [sda] Write Protect is off
>> [   19.071018] sd 1:0:0:0: [sda] No Caching mode page found
>> [   19.076437] sd 1:0:0:0: [sda] Assuming drive cache: write through
>> [   19.093566]  sda: sda1
>> [   19.103492] sd 1:0:0:0: [sda] Attached SCSI removable disk
>>
>> issues:
>> =======
>>
>> The system power often turned off when I plugged an usb device into
>> the OTG port.
>> It's not clear why.
>>
>> qianfan Zhao (2):
>>    ARM: dts: sun8i-r40: Add USB0_OTG/HOST support
>>    ARM: dts: bananapi-m2-ultra: Enable USB0_OTG and HOST support
>>
>>   .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 39
>> +++++++++++++++++++
>>   arch/arm/boot/dts/sun8i-r40.dtsi              | 34 ++++++++++++++++
>>   2 files changed, 73 insertions(+)
>>

