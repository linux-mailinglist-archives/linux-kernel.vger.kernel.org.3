Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D174C570517
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiGKOJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiGKOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:09:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252B261B23;
        Mon, 11 Jul 2022 07:09:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r14so7201575wrg.1;
        Mon, 11 Jul 2022 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=x2FwgOdiviKc21na7ZeEL1STsNQh/sVL41XUf3gedcc=;
        b=TPlU+M9oGx1mze+WdbVSqIDnwy5LAOrTd/lbEjl69f1UAbD0Lw9Z9veZYduWYlkmyM
         dUfs2b6mm4OIW0Mzlu38PN0B7+P9jZMT9mtaUZoZn5q4ohIQLAvEapxKDLBkAYkH3cSz
         6yrnWDpmDWhUeEY65i0qh1b9ZHh/eYEb5GWTc/9ySXeTivvBfXOLIyG8NmCNmU2rvuKF
         2PH4oyawrJPOxlWB3osQ7Wqld83OepdKkSDAzq2x7GdjaRqhcCT/ZcNJjswxDJMv0Cbe
         C/G2LtXF1lk2E6k6Uoluf+CailgftMMSYJJc7bDM55NoRrsx/DWO7wkabKLi8A5I7YvU
         4N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=x2FwgOdiviKc21na7ZeEL1STsNQh/sVL41XUf3gedcc=;
        b=ByBv9ZT01cvTLYduqa0L2gcS8i4YLfpdld15ByasT9JAUnPvs4mAWMApUigQ3zPrNS
         tx5lU4kuaqDnZPmgV8MZhzWKDsn+gypBYoN+QtIi1Zc5AtfkI7qRjxnWev0Bq61EgiaA
         h8HnL6iuXl54G52A77XOHHwV3kZQHwMbT1ZHVJtj4rG49V6ANOSJCMdVMMU/5BVZAiTV
         Yi3ICW3lXhp9Fdk+TAaGcaAont5S69om87yagy1gRH9hvKfr8k+UmxgrERGLFDxtEamE
         utGD/5kduovma5X2vEKFrViJzalQnRkPCdXa99CfMPZCiS/Sr9JPlWX3nsAgM9v/2UvK
         yo/Q==
X-Gm-Message-State: AJIora9ea15J6WHhPBlW7xZxmIcHuKS2VRPBTtcIT2BGEq8CBE8GQOU/
        4N5D2EUW/M4cw+yxYj78sxk=
X-Google-Smtp-Source: AGRyM1u+pldjsBeBkbIyiDwokUZeBqDMLwj4/xAyoxod+DcsL0JPXreH5nrQBG0R9+uySKQdULIVLA==
X-Received: by 2002:adf:eb48:0:b0:21d:7ffc:4919 with SMTP id u8-20020adfeb48000000b0021d7ffc4919mr17595386wrn.537.1657548545552;
        Mon, 11 Jul 2022 07:09:05 -0700 (PDT)
Received: from [192.168.4.247] (89-39-107-113.hosted-by-worldstream.net. [89.39.107.113])
        by smtp.gmail.com with ESMTPSA id h15-20020a1ccc0f000000b0039c54bb28f2sm7085334wmb.36.2022.07.11.07.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 07:09:05 -0700 (PDT)
Date:   Mon, 11 Jul 2022 18:08:53 +0400
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH 3/3] media: i2c: ak7375: Add regulator management
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <TM0VER.DLTH01AKOV622@gmail.com>
In-Reply-To: <20220711133423.w6yzbcfqwv2muu34@uno.localdomain>
References: <20220711042838.213351-1-y.oudjana@protonmail.com>
        <20220711042838.213351-4-y.oudjana@protonmail.com>
        <20220711133423.w6yzbcfqwv2muu34@uno.localdomain>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jul 11 2022 at 15:34:23 +0200, Jacopo Mondi <jacopo@jmondi.org> 
wrote:
> Hello Yassine
> 
> On Mon, Jul 11, 2022 at 08:28:39AM +0400, Yassine Oudjana wrote:
>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>>  Make the driver get needed regulators on probe and enable/disable
>>  them on runtime PM callbacks.
>> 
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>  ---
>>   drivers/media/i2c/ak7375.c | 39 
>> ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>> 
>>  diff --git a/drivers/media/i2c/ak7375.c b/drivers/media/i2c/ak7375.c
>>  index 40b1a4aa846c..59d5cb00e3ba 100644
>>  --- a/drivers/media/i2c/ak7375.c
>>  +++ b/drivers/media/i2c/ak7375.c
>>  @@ -6,6 +6,7 @@
>>   #include <linux/i2c.h>
>>   #include <linux/module.h>
>>   #include <linux/pm_runtime.h>
>>  +#include <linux/regulator/consumer.h>
>>   #include <media/v4l2-ctrls.h>
>>   #include <media/v4l2-device.h>
>> 
>>  @@ -23,17 +24,32 @@
>>    */
>>   #define AK7375_CTRL_STEPS	64
>>   #define AK7375_CTRL_DELAY_US	1000
>>  +/*
>>  + * The vcm takes around 3 ms to power on and start taking
>>  + * I2C messages. This value was found experimentally due to
>>  + * lack of documentation. 2 ms is added as a safety margin.
>>  + */
>>  +#define AK7375_POWER_DELAY_US	5000
>> 
>>   #define AK7375_REG_POSITION	0x0
>>   #define AK7375_REG_CONT		0x2
>>   #define AK7375_MODE_ACTIVE	0x0
>>   #define AK7375_MODE_STANDBY	0x40
>> 
>>  +static const char * const ak7375_supply_names[] = {
>>  +	"vdd",
>>  +	"vio",
>>  +};
>>  +
>>  +#define AK7375_NUM_SUPPLIES ARRAY_SIZE(ak7375_supply_names)
>>  +
>>   /* ak7375 device structure */
>>   struct ak7375_device {
>>   	struct v4l2_ctrl_handler ctrls_vcm;
>>   	struct v4l2_subdev sd;
>>   	struct v4l2_ctrl *focus;
>>  +	struct regulator_bulk_data supplies[AK7375_NUM_SUPPLIES];
>>  +
>>   	/* active or standby mode */
>>   	bool active;
>>   };
>>  @@ -132,6 +148,7 @@ static int ak7375_init_controls(struct 
>> ak7375_device *dev_vcm)
>>   static int ak7375_probe(struct i2c_client *client)
>>   {
>>   	struct ak7375_device *ak7375_dev;
>>  +	int i;
> 
> I would have moved this one down to maintain variable declaration
> in the in-famous reverse-xmas-tree ordering. Up to you.

I'm used to declaring variables in the order of first use,
but I don't really mind it either way. I'll move it down.

> 
>>   	int ret;
>> 
>>   	ak7375_dev = devm_kzalloc(&client->dev, sizeof(*ak7375_dev),
>>  @@ -139,6 +156,17 @@ static int ak7375_probe(struct i2c_client 
>> *client)
>>   	if (!ak7375_dev)
>>   		return -ENOMEM;
>> 
>>  +	for (i = 0; i < AK7375_NUM_SUPPLIES; i++)
>>  +		ak7375_dev->supplies[i].supply = ak7375_supply_names[i];
>>  +
>>  +	ret = devm_regulator_bulk_get(&client->dev, AK7375_NUM_SUPPLIES,
>>  +				      ak7375_dev->supplies);
>>  +	if (ret) {
>>  +		dev_err(&client->dev, "Failed to get regulators: %pe",
>>  +			ERR_PTR(ret));
>>  +		return ret;
>>  +	}
>>  +
>>   	v4l2_i2c_subdev_init(&ak7375_dev->sd, client, &ak7375_ops);
>>   	ak7375_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>>   	ak7375_dev->sd.internal_ops = &ak7375_int_ops;
>>  @@ -210,6 +238,10 @@ static int __maybe_unused 
>> ak7375_vcm_suspend(struct device *dev)
>>   	if (ret)
>>   		dev_err(dev, "%s I2C failure: %d\n", __func__, ret);
>> 
>>  +	ret = regulator_bulk_disable(AK7375_NUM_SUPPLIES, 
>> ak7375_dev->supplies);
>>  +	if (ret)
>>  +		return ret;
>>  +
>>   	ak7375_dev->active = false;
>> 
>>   	return 0;
>>  @@ -230,6 +262,13 @@ static int __maybe_unused 
>> ak7375_vcm_resume(struct device *dev)
>>   	if (ak7375_dev->active)
>>   		return 0;
>> 
>>  +	ret = regulator_bulk_enable(AK7375_NUM_SUPPLIES, 
>> ak7375_dev->supplies);
>>  +	if (ret)
>>  +		return ret;
>>  +
>>  +	/* Wait for vcm to become ready */
>>  +	usleep_range(AK7375_POWER_DELAY_US, AK7375_POWER_DELAY_US + 10);
>>  +
> 
> Isn't 10usec a very small delay to be given to usleep_range() for a
> delay of at least 3msec ? Also assuming 5msec just to be safe seems a
> little arbitrary. Adding 2 milliseconds in the wakeup path introduces
> a non-negligible delay.

I must admit that I didn't give it too much thought. I just
did it similar to the other delay used in this driver
(AK7375_CTRL_DELAY_US). As for adding 2ms, I don't know what
the worst case wake-up time is since I don't have a datasheet
on hand, so I just wanted to stay safe. Also, this driver
doesn't really recover if it fails to resume (which is what
used to happen before adding a delay). Rounding up to 5ms
felt good enough.

> 
> It's likely a detail, but according to 
> Documentation/timers/timers-howto.rst
> 
>         Since usleep_range is built on top of hrtimers, the
>         wakeup will be very precise (ish), thus a simple
>         usleep function would likely introduce a large number
>         of undesired interrupts.
> 
>         With the introduction of a range, the scheduler is
>         free to coalesce your wakeup with any other wakeup
>         that may have happened for other reasons, or at the
>         worst case, fire an interrupt for your upper bound.
> 
>         The larger a range you supply, the greater a chance
>         that you will not trigger an interrupt; this should
>         be balanced with what is an acceptable upper bound on
>         delay / performance for your specific code path. Exact
>         tolerances here are very situation specific, thus it
>         is left to the caller to determine a reasonable range.
> 
> If you have a min of 3msec I would try with a range of (3000, 3500).
> What do you think ?

Seems good. I haven't yet had it fail to power on within 3ms of
turning on regulators so I guess there is no reason to worry about it.

>> 
>>   	ret = ak7375_i2c_write(ak7375_dev, AK7375_REG_CONT,
>>   		AK7375_MODE_ACTIVE, 1);
>>   	if (ret) {
>>  --
>>  2.37.0
> 

Thanks for the review,
Yassine


