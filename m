Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F04E4FC1E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245319AbiDKQLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348445AbiDKQKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:38 -0400
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9CD2DAB1;
        Mon, 11 Apr 2022 09:08:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07465795|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.420245-0.00136469-0.57839;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.NOcTfuC_1649693291;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NOcTfuC_1649693291)
          by smtp.aliyun-inc.com(33.40.85.40);
          Tue, 12 Apr 2022 00:08:12 +0800
Subject: Re: [PATCH] mips: dts: ingenic: x1000: Add PWM device tree node
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     devicetree@vger.kernel.org, krzk+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        paul@crapouillou.net, robh+dt@kernel.org
References: <20220411100139.15672-1-aidanmacdonald.0x0@gmail.com>
 <8a3f88d8-3e94-1388-b1c6-b0f71d59f34c@wanyeetech.com>
 <YlRNgyc6eMTgFjdH@localhost>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <907aedbd-9277-0e65-bd33-49ec2cb7d2f9@wanyeetech.com>
Date:   Tue, 12 Apr 2022 00:08:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <YlRNgyc6eMTgFjdH@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

On 2022/4/11 下午11:47, Aidan MacDonald wrote:
> On Mon, Apr 11, 2022 at 08:41:26PM +0800, Zhou Yanjie wrote:
>> Hi Aidan,
>>
>> On 2022/4/11 下午6:01, Aidan MacDonald wrote:
>>> Copied from the jz4740 devicetree and trimmed to 5 timers, which
>>> is what the hardware supports.
>>>
>>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>>> ---
>>>    arch/mips/boot/dts/ingenic/x1000.dtsi | 13 +++++++++++++
>>>    1 file changed, 13 insertions(+)
>>>
>>> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
>>> index 8bd27edef216..0dcf37527c8e 100644
>>> --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
>>> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
>>> @@ -127,6 +127,19 @@ wdt: watchdog@0 {
>>>    			clocks = <&tcu TCU_CLK_WDT>;
>>>    			clock-names = "wdt";
>>>    		};
>>> +
>>> +		pwm: pwm@40 {
>>> +			compatible = "ingenic,x1000-pwm";
>>> +			reg = <0x40 0x80>;
>>
>> It seems more reasonable to use "reg = <0x40 0x80>" since the
>> X1000 has only 5 PWM channels.
> I think you mean "reg = <0x40 0x60>" but I'll do that, thanks!


Ah, yes, what a what a stupid mistake... :(


>
>>> +
>>> +			#pwm-cells = <3>;
>>> +
>>> +			clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>,
>>> +				 <&tcu TCU_CLK_TIMER2>, <&tcu TCU_CLK_TIMER3>,
>>> +				 <&tcu TCU_CLK_TIMER4>;
>>> +			clock-names = "timer0", "timer1", "timer2",
>>> +				      "timer3", "timer4";
>>
>> One line is now allowed to hold at most 100 characters,
>> so it is possible to use only one line like:
>>
>>           clock-names = "timer0", "timer1", "timer2", "timer3", "timer4";
>>
>> to reduce the number of lines in the dtsi file.
> Sounds good to me.
>
>>
>> Thanks and best regards!
>>
>>
>>> +		};
>>>    	};
>>>    
>>>    	rtc: rtc@10003000 {
> Regards,
> Aidan
