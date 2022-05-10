Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7282520B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiEJCeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiEJCd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:33:58 -0400
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38651B774A;
        Mon,  9 May 2022 19:30:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08325132|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0186495-0.000315131-0.981035;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.Nh22IJP_1652149798;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Nh22IJP_1652149798)
          by smtp.aliyun-inc.com(33.18.97.150);
          Tue, 10 May 2022 10:29:58 +0800
Subject: Re: Question about SC16IS752 device tree.
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, jringle@gridpoint.com,
        shc_work@mail.ru, Rob Herring <robh@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-serial@vger.kernel.org,
        linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7c89db86-4055-90b5-6a67-611410f5759f@wanyeetech.com>
 <ZYNMBR.VDVV3VHFQBMO1@crapouillou.net>
 <04bd0853-7e34-5210-f1b5-f3ea8c35e484@wanyeetech.com>
 <501852E6-6934-4BB2-850C-B53A07580568@goldelico.com>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <8533f999-f584-ea31-0c44-1ce29c066d88@wanyeetech.com>
Date:   Tue, 10 May 2022 10:29:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <501852E6-6934-4BB2-850C-B53A07580568@goldelico.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

On 2022/5/10 上午4:19, H. Nikolaus Schaller wrote:
> Hi,
>
>> Am 09.05.2022 um 20:41 schrieb Zhou Yanjie <zhouyanjie@wanyeetech.com>:
>>
>> Hi Paul,
>>
>> On 2022/5/10 上午2:13, Paul Cercueil wrote:
>>> I can't say for sure that it's your problem, but your bluetooth nodes are missing "reg" properties.
>>
>> Unfortunately it doesn't seem to be the problem here, I added "reg" and
>> the problem persists, and I've looked at other device trees that contain
>> "brcm,bcm43438-bt", none of them use "reg", and "reg" is not mentioned in
>> neither "Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt" nor
>> "Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml".
> what happens if you remove the serdev children from DTS? Does the driver create two separate /dev/tty ports? And do they work?


Yes, there will be two separate /dev/tty ports (ttySC0 and ttySC1), and
both ports can work normally, but at this time the two bluetooth modules
are not working.

I guess it is because the driver does not detect bluetooth module nodes,
so the inability to operate "reset-gpios" and "device-wakeup-gpios" causes
the bluetooth module to work incorrectly.


>
> Maybe the sc16is752 driver does not separate them for child nodes, i.e. while "reg" should be added it may not be handled?


I'm not too sure, I'm not very familiar with serial port systems.
If the truth is what you think, how should I improve it?


Best regards!


>
> BR,
> Nikolaus
