Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D347D507A82
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356230AbiDSTv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiDSTvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:51:53 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B87325C77;
        Tue, 19 Apr 2022 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650397743; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMzNsOPvb8xklKCtkHvEvTftPy2uI2Gj1CIEG3tcRzk=;
        b=O6x4U4RvTGawR4DxqZcSdGOJzYdwo8dQwr0av5L2fLqhwxl8IMllC2ociiyWvlvfVTnYN3
        bL85my01orOXTkjry4SYt2mgJidfliSubskMksnz/E6BTsAoQVkS6sHV3cAr0hZAIPol/j
        8Lgw+tPykW+eJGZbSjGiknUtnRtSzrE=
Date:   Tue, 19 Apr 2022 20:48:54 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/5] rtc: jz4740: Reset scratchpad register on power loss
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, list@opendingux.net,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <I1RLAR.CF78L45NPJDC1@crapouillou.net>
In-Reply-To: <Yl8PBx5qyvMrwrV/@mail.local>
References: <20220418184933.13172-1-paul@crapouillou.net>
        <20220418184933.13172-4-paul@crapouillou.net> <Yl8PBx5qyvMrwrV/@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Le mar., avril 19 2022 at 21:35:35 +0200, Alexandre Belloni=20
<alexandre.belloni@bootlin.com> a =E9crit :
> On 18/04/2022 19:49:31+0100, Paul Cercueil wrote:
>>  On power loss, reading the RTC value would fail as the scratchpad=20
>> lost
>>  its magic value, until the hardware clock was set once again.
>>=20
>>  To avoid that, reset the RTC value to Epoch in the probe if we=20
>> detect
>>  that the scratchpad lost its magic value.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/rtc/rtc-jz4740.c | 24 +++++++++++++++++++++---
>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>=20
>>  diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
>>  index 119baf168b32..aac5f68bf626 100644
>>  --- a/drivers/rtc/rtc-jz4740.c
>>  +++ b/drivers/rtc/rtc-jz4740.c
>>  @@ -42,6 +42,9 @@
>>   /* Magic value to enable writes on jz4780 */
>>   #define JZ_RTC_WENR_MAGIC	0xA55A
>>=20
>>  +/* Value written to the scratchpad to detect power losses */
>>  +#define JZ_RTC_SCRATCHPAD_MAGIC	0x12345678
>>  +
>>   #define JZ_RTC_WAKEUP_FILTER_MASK	0x0000FFE0
>>   #define JZ_RTC_RESET_COUNTER_MASK	0x00000FE0
>>=20
>>  @@ -134,10 +137,11 @@ static int jz4740_rtc_ctrl_set_bits(struct=20
>> jz4740_rtc *rtc, uint32_t mask,
>>   static int jz4740_rtc_read_time(struct device *dev, struct=20
>> rtc_time *time)
>>   {
>>   	struct jz4740_rtc *rtc =3D dev_get_drvdata(dev);
>>  -	uint32_t secs, secs2;
>>  +	uint32_t secs, secs2, magic;
>>   	int timeout =3D 5;
>>=20
>>  -	if (jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SCRATCHPAD) !=3D 0x12345678)
>>  +	magic =3D jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SCRATCHPAD);
>>  +	if (magic !=3D JZ_RTC_SCRATCHPAD_MAGIC)
>>   		return -EINVAL;
>>=20
>>   	/* If the seconds register is read while it is updated, it can=20
>> contain a
>>  @@ -169,7 +173,8 @@ static int jz4740_rtc_set_time(struct device=20
>> *dev, struct rtc_time *time)
>>   	if (ret)
>>   		return ret;
>>=20
>>  -	return jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SCRATCHPAD,=20
>> 0x12345678);
>>  +	return jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SCRATCHPAD,
>>  +				    JZ_RTC_SCRATCHPAD_MAGIC);
>>   }
>>=20
>>   static int jz4740_rtc_read_alarm(struct device *dev, struct=20
>> rtc_wkalrm *alrm)
>>  @@ -307,6 +312,7 @@ static int jz4740_rtc_probe(struct=20
>> platform_device *pdev)
>>   	struct jz4740_rtc *rtc;
>>   	unsigned long rate;
>>   	struct clk *clk;
>>  +	uint32_t magic;
>>   	int ret, irq;
>>=20
>>   	rtc =3D devm_kzalloc(dev, sizeof(*rtc), GFP_KERNEL);
>>  @@ -369,6 +375,18 @@ static int jz4740_rtc_probe(struct=20
>> platform_device *pdev)
>>   	/* Each 1 Hz pulse should happen after (rate) ticks */
>>   	jz4740_rtc_reg_write(rtc, JZ_REG_RTC_REGULATOR, rate - 1);
>>=20
>>  +	magic =3D jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SCRATCHPAD);
>>  +	if (magic !=3D JZ_RTC_SCRATCHPAD_MAGIC) {
>>  +		/*
>>  +		 * If the scratchpad doesn't hold our magic value, then a
>>  +		 * power loss occurred. Reset to Epoch.
>>  +		 */
>>  +		struct rtc_time time;
>>  +
>>  +		rtc_time64_to_tm(0, &time);
>>  +		jz4740_rtc_set_time(dev, &time);
>=20
> Don't do that, this defeats the purpose of detecting when the power is
> lost. Returning a known bogus time is the worst thing you can do here.

So what is the best thing to do then?

Cheers,
-Paul

>>  +	}
>>  +
>>   	ret =3D devm_rtc_register_device(rtc->rtc);
>>   	if (ret)
>>   		return ret;
>>  --
>>  2.35.1
>>=20
>=20
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


