Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54B857502B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbiGNN6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbiGNN6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:58:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B279B5A2C2;
        Thu, 14 Jul 2022 06:56:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id os14so3591502ejb.4;
        Thu, 14 Jul 2022 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=huOHFhiKYChVhaBgp849ZBbjkKqaUG8zLm+rmNlDftc=;
        b=blSp5PU5j+OZQzk3d1rGLs8WlNo8uk5FatkT9uyCo9BlnV8uqZ8lGYqlLQyasQLYMF
         TYcGi1u+5HAda3RbB1L1GCVu9sDzeSC088i8dZEFu2LdTCfumbNhjZFTSrZG8rzaKbWt
         mP4tQLsJm1OBZXh21aGjxUWgBAq4Ib2pofDWSY1LOQiAWLbfM0AQzVVKWpHBKCxRkcnB
         D9HkxdYUHPxR44ywvm31SylQfMrwrzz27rHTlYmRK7QjSoVbkZpMOeRzxOCU45dZ7SYP
         WnvsmcNx1PIVhRATbc5ZgX9rCeHhGg6zZ9gr62nE88UcGgTP7/0hvmqhCbUhaEBJH/jD
         LhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=huOHFhiKYChVhaBgp849ZBbjkKqaUG8zLm+rmNlDftc=;
        b=X+CaZz6hb9K6Xpd4WElin95Eh9kG0mppiGJX6K/FiQxRbxu2C31Yg2QPOVnKAa5KxD
         0G6CwUyGa5A4suU8y2WG/HngcLuMXLzJnFpv97n1iHeoxBkzX5Fs5y5S+dygFlkGHhGo
         qQ/QCmBR8dgWm0j5cZuP4J0qTHyUqbtd1tLLU4TBQzMfl8nchGeOsAYICOIfev4DM1gy
         SRTy+ps9UqgadxQ351A6grqNNTPNdnj+sYOXYxKRSD5aA0TOnGu1wx4hhSspEI8fly+0
         cIH9vXkrU3wLQR/+HKTV9IpHcF2XXEwwbmYZqMrRuxVSCIrMpIBvxy3b7T6l4g5KwbOI
         uHuw==
X-Gm-Message-State: AJIora+IMkqiJ+vjjwwk6bNaWrLYFpdCu8PhIQ/9bq22GQPoxXv4C3cJ
        qA7OObjWhF54JNbfHa+GEEo=
X-Google-Smtp-Source: AGRyM1s6di3Gdf6v/Alu4+Ie2FZrOpMo07l8U/qYGbgGQuw4Qj4dYQe7twBb7qv3UijaEAj+W+9mPw==
X-Received: by 2002:a17:906:5055:b0:6ff:1dfb:1e2c with SMTP id e21-20020a170906505500b006ff1dfb1e2cmr9073337ejk.200.1657807000145;
        Thu, 14 Jul 2022 06:56:40 -0700 (PDT)
Received: from [192.168.11.247] (185-165-241-34.hosted-by-worldstream.net. [185.165.241.34])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906293200b007052b183d51sm723690ejd.132.2022.07.14.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:56:39 -0700 (PDT)
Date:   Thu, 14 Jul 2022 17:56:29 +0400
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH v2 3/3] media: i2c: ak7375: Add regulator management
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <52K0FR.YCGQA83H5U3W@gmail.com>
In-Reply-To: <20220711173123.55abjsli3tmqgegj@uno.localdomain>
References: <20220711144039.232196-1-y.oudjana@protonmail.com>
        <20220711144039.232196-4-y.oudjana@protonmail.com>
        <20220711173123.55abjsli3tmqgegj@uno.localdomain>
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


On Mon, Jul 11 2022 at 19:31:23 +0200, Jacopo Mondi <jacopo@jmondi.org> 
wrote:
> Hi Yassine,
> 
> On Mon, Jul 11, 2022 at 06:40:39PM +0400, Yassine Oudjana wrote:
>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>>  Make the driver get needed regulators on probe and enable/disable
>>  them on runtime PM callbacks.
>> 
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
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
> 
> Why are you using %pe here ? Your return value is not a pointer

In order to have it print a symbolic error name instead of a value
with CONFIG_SYMBOLIC_ERRNAME=y. There is no format code for an
error integer (or at least I couldn't find one mentioned anywhere
in the docs), so instead I use %pe then wrap `ret` in ERR_PTR().

> (Also, missing \n at the end of the string)

That wasn't intentional. I'll fix it.

> 
> From Documentation/core-api/printk-formats.rst:
> 	%pe	-ENOSPC
> 
> For printing error pointers (i.e. a pointer for which IS_ERR() is 
> true)
> as a symbolic error name. Error values for which no symbolic name is
> known are printed in decimal, while a non-ERR_PTR passed as the
> argument to %pe gets treated as ordinary %p.
> 
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


