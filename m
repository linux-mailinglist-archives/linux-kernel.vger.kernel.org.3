Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A1D575053
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbiGNOGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbiGNOGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:06:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C042B13CFE;
        Thu, 14 Jul 2022 07:06:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fd6so2567110edb.5;
        Thu, 14 Jul 2022 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=0hOtpE8/DojU1Gra2Zcppwv31AJSFLzQNq6R8EQC+4g=;
        b=eh+g1jMnhER3KxbGx8XlnkuEL8uvIzkJC+Hbfxugn0LRfbnVUKADfDHMSiTQAEkbak
         2RBfH+YCe1MsDHjD5DVVoEKXnFm3i6+TdtY9w/msF1M3AbL6rPOQsRhiaO3hWMBwGde+
         QtrSjc7XWze9MA0AP30S2ywZoxO8jlMSRW69qDEZgcXtU7Js7KLEeuIE7q6NNK2UMOFa
         RNuiWFJjSnWvKVU6mhOSM8BryTr7KU5DiYECtgHSaaoJWoN9rzYRxGUJv7s4Q1yvy1Pc
         W5i0dgeDm5mrKZbiFAnQfqYliqfxNNEh5UrXW3d6EvoiCL1DH0xRXdEXzAHrY/4a6/JG
         +TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=0hOtpE8/DojU1Gra2Zcppwv31AJSFLzQNq6R8EQC+4g=;
        b=7NhkbtZjWxpxFOMlLM9+gh5FSVL3dFrEAr2yynRsstBsGDgkFuQC/n4jynv5RjlvNC
         ljZrtSk7BXvSaFk5C3d0HsDW2/KZEZEZpbu5yJrpRsJHgdnqgcWlSYlY9A7IKT8+ZtVp
         KGPj0sQJHXN4X58M8OBJsPP6MyuMxf2bg5O7+JieQj7QwbeD1LI3oMJggNU4slvOeOB9
         n6KKSXgtqUV12pimFdCrSfX5/3EFawSZhuWQ9FNlzHJBluOPQHrHp1UF5lG1sEFtfPHH
         awnfC/m7Rrd30oLtjyS8Qt0Hjtdb0f9BAUvHrTrSbUlhijJY+cIwyhy/rdijQiM5+23l
         BfOw==
X-Gm-Message-State: AJIora8ov6Wse1mIgw1dLSxEBJYCuDVWi6b9vyDiS3YifdO0VAzQX/dp
        ktcFnI2PN8PkWrpS3KVUGuI=
X-Google-Smtp-Source: AGRyM1vNRLkkTwQrChTf+7Nhf5MHtguBSGOfNIzBuKpQq0skpIiiHl13VjT2pnZ6b/xxpjWxTczcRw==
X-Received: by 2002:a05:6402:5513:b0:43a:b866:b9ab with SMTP id fi19-20020a056402551300b0043ab866b9abmr12723120edb.290.1657807604292;
        Thu, 14 Jul 2022 07:06:44 -0700 (PDT)
Received: from [192.168.11.247] (185-165-241-34.hosted-by-worldstream.net. [185.165.241.34])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7d1cd000000b00435a742e350sm1084960edp.75.2022.07.14.07.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 07:06:43 -0700 (PDT)
Date:   Thu, 14 Jul 2022 18:06:32 +0400
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH v2 3/3] media: i2c: ak7375: Add regulator management
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Lee Jackson <info@arducam.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <WIK0FR.TSG3JTBEBBDN@gmail.com>
In-Reply-To: <20220713073951.qrg3slmvqbibwc5o@uno.localdomain>
References: <20220711144039.232196-1-y.oudjana@protonmail.com>
        <20220711144039.232196-4-y.oudjana@protonmail.com>
        <20220713073951.qrg3slmvqbibwc5o@uno.localdomain>
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


On Wed, Jul 13 2022 at 09:39:51 +0200, Jacopo Mondi <jacopo@jmondi.org> 
wrote:
> Hi Yassine
> 
> On Mon, Jul 11, 2022 at 06:40:39PM +0400, Yassine Oudjana wrote:
>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>>  Make the driver get needed regulators on probe and enable/disable
>>  them on runtime PM callbacks.
>> 
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Have you seen this ?
> https://github.com/ArduCAM/IMX519_AK7375/blob/main/AK7375/0002-media-i2c-ak7375-driver-add-optional-regulator-suppo.patch#L172
> 
> It claims
> +	* Initialisation delay between VDD low->high and the moment
> +	* when the i2c command is available.
> +	* From the datasheet, it should be 10ms + 2ms (max power
> +	* up sequence duration)
> 
> 10ms seems like a long time, it would be nice to have the datasheet to
> cross-check.

It does seem quite long. I couldn't find a datasheet anywhere
so the value I discovered is the best I have. I've added the
author of that patch to CC; maybe they have some info to
contribute.

> 
> Thanks
>    j
> 
>>  ---
>>  Changes since v1:
>>    - Reorganize variable declaration
>>    - Change the power-on delay range to 3000-3500 microseconds.
>> 
>>   drivers/media/i2c/ak7375.c | 39 
>> ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>> 
>>  diff --git a/drivers/media/i2c/ak7375.c b/drivers/media/i2c/ak7375.c
>>  index 40b1a4aa846c..c2b2542a0056 100644
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
>>  + * lack of documentation.
>>  + */
>>  +#define AK7375_POWER_DELAY_US	3000
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
>>  @@ -133,12 +149,24 @@ static int ak7375_probe(struct i2c_client 
>> *client)
>>   {
>>   	struct ak7375_device *ak7375_dev;
>>   	int ret;
>>  +	int i;
>> 
>>   	ak7375_dev = devm_kzalloc(&client->dev, sizeof(*ak7375_dev),
>>   				  GFP_KERNEL);
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
>>  +	usleep_range(AK7375_POWER_DELAY_US, AK7375_POWER_DELAY_US + 500);
>>  +
>>   	ret = ak7375_i2c_write(ak7375_dev, AK7375_REG_CONT,
>>   		AK7375_MODE_ACTIVE, 1);
>>   	if (ret) {
>>  --
>>  2.37.0
>> 


