Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4112058C589
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbiHHJ3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiHHJ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:29:09 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336E710FF1;
        Mon,  8 Aug 2022 02:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659950945; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a7J0vR8AIXFte6kf6RumD2/hPX01XBSOZ5betqd1ZxY=;
        b=IWecwd1TxppEdTMgaK+uLejB/zbujszArsEOnTiFEYxKkLptk3sPkSzWOukY4ERydRCmT0
        1Z+9TZMXxnTB/y+uC3x3/WsiZWAyME7FccLFmePBmRBLjzFVsfx4ZOR4olmhi5ENuPZJT5
        GuqS31Mzy+5J0HNoxcPykwFlz+qqTag=
Date:   Mon, 08 Aug 2022 11:28:58 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 13/28] mfd: sec: Remove #ifdef guards for PM related
 functions
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Message-Id: <ACIAGR.7NVZ6UO1UX632@crapouillou.net>
In-Reply-To: <a625a1b4-6ecd-79d9-3d13-f42fd5b8275c@linaro.org>
References: <20220807145247.46107-1-paul@crapouillou.net>
        <20220807145247.46107-14-paul@crapouillou.net>
        <a625a1b4-6ecd-79d9-3d13-f42fd5b8275c@linaro.org>
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

Hi Krzysztof,

Le lun., ao=FBt 8 2022 at 12:11:02 +0300, Krzysztof Kozlowski=20
<krzysztof.kozlowski@linaro.org> a =E9crit :
> On 07/08/2022 17:52, Paul Cercueil wrote:
>>  Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
>>  to handle the .suspend/.resume callbacks.
>>=20
>>  These macros allow the suspend and resume functions to be=20
>> automatically
>>  dropped by the compiler when CONFIG_SUSPEND is disabled, without=20
>> having
>>  to use #ifdef guards.
>>=20
>>  The advantage is then that these functions are now always compiled
>>  independently of any Kconfig option, and thanks to that bugs and
>>  regressions are easier to catch.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>  Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>=20
> The address does not work. Please don't add it to commit log.

That's what get-maintainers gave me, and I didn't get any error sending=20
at that address. But I'll take your word.

>>  Cc: linux-samsung-soc@vger.kernel.org
>=20
> This is also not really needed in commit log... it's just a mailing=20
> list...
>=20
> I actually never understood why people want to add to commit log, so=20
> to
> something which will last 10 years, Cc-ing other folks, instead of
> adding such tags after '---'. Imagine 10 years from now:
>=20
> 1. What's the point to be cced on this patch after 10 years instead of
> using maintainers file (the one in 10 years)? Why Cc-ing me in 10=20
> years?
> If I am a maintainer of this driver in that time, I will be C-ced=20
> based
> on maintainers file. If I am not a maintainer in 10 years, why the=20
> heck
> cc-ing me based on some 10-year old commit? Just because I was a
> maintainer once, like 10 years ago?
>=20
> 2. Or why cc-ing such people when backporting to stable?
>=20
> It's quite a lot of unnecessary emails which many of us won't actually
> handle later...
>=20
> I sincerely admit I was once also adding such Cc-tags. But that time=20
> my
> employer was counting lines-of-patch (including commit log)... crazy,=20
> right?

Yeah, well, I can add these tags after the '---' line. Nobody ever told=20
me that I was doing it wrong, and I see Cc: tags quite often in commit=20
messages, so I thought it was common practice.

>>  ---
>>   drivers/mfd/sec-core.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>=20
>>  diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
>>  index 1fb29c45f5cf..a467de2b2fea 100644
>>  --- a/drivers/mfd/sec-core.c
>>  +++ b/drivers/mfd/sec-core.c
>>  @@ -455,7 +455,6 @@ static void sec_pmic_shutdown(struct i2c_client=20
>> *i2c)
>>   	regmap_update_bits(sec_pmic->regmap_pmic, reg, mask, 0);
>>   }
>>=20
>>  -#ifdef CONFIG_PM_SLEEP
>>   static int sec_pmic_suspend(struct device *dev)
>=20
> Did you test W=3D1 with !CONFIG_PM_SLEEP? No warnings?

I tested the PR with !CONFIG_PM_SLEEP, correct. sec-core.o compiles=20
fine. No warnings with W=3D1.
>=20
Cheers,
-Paul


