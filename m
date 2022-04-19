Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E6C507B50
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353861AbiDSU4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241627AbiDSU4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:56:15 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB7F40A0B;
        Tue, 19 Apr 2022 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650401606; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U9uKVqzeLetai30xHUmUHKRNgiB0fOsmb+j/KNxuO5E=;
        b=Kb4WazaT5eGIpoe8lsOUMLB/t0kA43FxEBV25Fvb6y8mc3lyrFr4l07dBfFN7BSImbx5eZ
        Wpuk6ed7iNQc+nU+UhQ9QXr9b3kJ0hqkEjZ+30IANT1CO7IVI1wdOcDh8Ml7OU8DqKhBtE
        xwS2hb/OtdJBfjTIMeyui+SUZOd9Ax8=
Date:   Tue, 19 Apr 2022 21:53:17 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/5] rtc: jz4740: Reset scratchpad register on power loss
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, list@opendingux.net,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <T0ULAR.TKXMRCDN7DQ53@crapouillou.net>
In-Reply-To: <Yl8U4JDSHwjT9nXw@mail.local>
References: <20220418184933.13172-1-paul@crapouillou.net>
        <20220418184933.13172-4-paul@crapouillou.net> <Yl8PBx5qyvMrwrV/@mail.local>
        <I1RLAR.CF78L45NPJDC1@crapouillou.net> <Yl8U4JDSHwjT9nXw@mail.local>
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



Le mar., avril 19 2022 at 22:00:32 +0200, Alexandre Belloni=20
<alexandre.belloni@bootlin.com> a =E9crit :
> On 19/04/2022 20:48:54+0100, Paul Cercueil wrote:
>>  Hi Alexandre,
>>=20
>>  Le mar., avril 19 2022 at 21:35:35 +0200, Alexandre Belloni
>>  <alexandre.belloni@bootlin.com> a =E9crit :
>>  > On 18/04/2022 19:49:31+0100, Paul Cercueil wrote:
>>  > >  On power loss, reading the RTC value would fail as the=20
>> scratchpad
>>  > > lost
>>  > >  its magic value, until the hardware clock was set once again.
>>  > >
>>  > >  To avoid that, reset the RTC value to Epoch in the probe if we
>>  > > detect
>>  > >  that the scratchpad lost its magic value.
>>  > >
>>  > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > >  ---
>>  > >   drivers/rtc/rtc-jz4740.c | 24 +++++++++++++++++++++---
>>  > >   1 file changed, 21 insertions(+), 3 deletions(-)
>>  > >
>>  > >  diff --git a/drivers/rtc/rtc-jz4740.c=20
>> b/drivers/rtc/rtc-jz4740.c
>>  > >  index 119baf168b32..aac5f68bf626 100644
>>  > >  --- a/drivers/rtc/rtc-jz4740.c
>>  > >  +++ b/drivers/rtc/rtc-jz4740.c
>>  > >  @@ -42,6 +42,9 @@
>>  > >   /* Magic value to enable writes on jz4780 */
>>  > >   #define JZ_RTC_WENR_MAGIC	0xA55A
>>  > >
>>  > >  +/* Value written to the scratchpad to detect power losses */
>>  > >  +#define JZ_RTC_SCRATCHPAD_MAGIC	0x12345678
>>  > >  +
>>  > >   #define JZ_RTC_WAKEUP_FILTER_MASK	0x0000FFE0
>>  > >   #define JZ_RTC_RESET_COUNTER_MASK	0x00000FE0
>>  > >
>>  > >  @@ -134,10 +137,11 @@ static int=20
>> jz4740_rtc_ctrl_set_bits(struct
>>  > > jz4740_rtc *rtc, uint32_t mask,
>>  > >   static int jz4740_rtc_read_time(struct device *dev, struct
>>  > > rtc_time *time)
>>  > >   {
>>  > >   	struct jz4740_rtc *rtc =3D dev_get_drvdata(dev);
>>  > >  -	uint32_t secs, secs2;
>>  > >  +	uint32_t secs, secs2, magic;
>>  > >   	int timeout =3D 5;
>>  > >
>>  > >  -	if (jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SCRATCHPAD) !=3D=20
>> 0x12345678)
>>  > >  +	magic =3D jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SCRATCHPAD);
>>  > >  +	if (magic !=3D JZ_RTC_SCRATCHPAD_MAGIC)
>>  > >   		return -EINVAL;
>>  > >
>>  > >   	/* If the seconds register is read while it is updated, it=20
>> can
>>  > > contain a
>>  > >  @@ -169,7 +173,8 @@ static int jz4740_rtc_set_time(struct=20
>> device
>>  > > *dev, struct rtc_time *time)
>>  > >   	if (ret)
>>  > >   		return ret;
>>  > >
>>  > >  -	return jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SCRATCHPAD,
>>  > > 0x12345678);
>>  > >  +	return jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SCRATCHPAD,
>>  > >  +				    JZ_RTC_SCRATCHPAD_MAGIC);
>>  > >   }
>>  > >
>>  > >   static int jz4740_rtc_read_alarm(struct device *dev, struct
>>  > > rtc_wkalrm *alrm)
>>  > >  @@ -307,6 +312,7 @@ static int jz4740_rtc_probe(struct
>>  > > platform_device *pdev)
>>  > >   	struct jz4740_rtc *rtc;
>>  > >   	unsigned long rate;
>>  > >   	struct clk *clk;
>>  > >  +	uint32_t magic;
>>  > >   	int ret, irq;
>>  > >
>>  > >   	rtc =3D devm_kzalloc(dev, sizeof(*rtc), GFP_KERNEL);
>>  > >  @@ -369,6 +375,18 @@ static int jz4740_rtc_probe(struct
>>  > > platform_device *pdev)
>>  > >   	/* Each 1 Hz pulse should happen after (rate) ticks */
>>  > >   	jz4740_rtc_reg_write(rtc, JZ_REG_RTC_REGULATOR, rate - 1);
>>  > >
>>  > >  +	magic =3D jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SCRATCHPAD);
>>  > >  +	if (magic !=3D JZ_RTC_SCRATCHPAD_MAGIC) {
>>  > >  +		/*
>>  > >  +		 * If the scratchpad doesn't hold our magic value, then a
>>  > >  +		 * power loss occurred. Reset to Epoch.
>>  > >  +		 */
>>  > >  +		struct rtc_time time;
>>  > >  +
>>  > >  +		rtc_time64_to_tm(0, &time);
>>  > >  +		jz4740_rtc_set_time(dev, &time);
>>  >
>>  > Don't do that, this defeats the purpose of detecting when the=20
>> power is
>>  > lost. Returning a known bogus time is the worst thing you can do=20
>> here.
>>=20
>>  So what is the best thing to do then?
>>=20
>=20
> Well, -EINVAL is returned when the time is invalid, this should be
> enough. I'm not actually sure what is the issue you are trying to fix
> here.

htop fails to start and tells me:
"No btime in /proc/stat: No such file or directory"

until the date is reset. So I was assuming it was a case of the jz4740=20
driver not being correct and breaking userspace.

Cheers,
-Paul


>=20
>>  Cheers,
>>  -Paul
>>=20
>>  > >  +	}
>>  > >  +
>>  > >   	ret =3D devm_rtc_register_device(rtc->rtc);
>>  > >   	if (ret)
>>  > >   		return ret;
>>  > >  --
>>  > >  2.35.1
>>  > >
>>  >
>>  > --
>>  > Alexandre Belloni, co-owner and COO, Bootlin
>>  > Embedded Linux and Kernel engineering
>>  > https://bootlin.com
>>=20
>>=20
>=20
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


