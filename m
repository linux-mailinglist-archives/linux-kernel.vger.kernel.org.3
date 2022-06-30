Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D76A5617E4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiF3K1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbiF3K05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:26:57 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79258BC86;
        Thu, 30 Jun 2022 03:26:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e28so21431366wra.0;
        Thu, 30 Jun 2022 03:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0Mw2f0H7fPk/ec2Jm4YQjTpweOlVWIlUul8A8sSfzeA=;
        b=VNdW4Reh08/XdWSDR8FuFhwwIwf1cZzqDuOWFgCOx+rN2+WnW7/caRqkPqZyviqQwF
         L+crdyksbYmdGQUmvIwGRmiAzhYtG0PqWwTw27vs2exMmi+Eho0vHBgudFeorfRbIzKY
         karr+vy4+v/Fopvz7sUXL3IRctj5BCH4PO92KG4ATNqYKl9742euZOtCyqVv3NEbvmA+
         ApO14+xSaQLohvl/ivC9L2yS0XPoRTbVgYaxWnQBDBjOm9JfV7h1CKMsLJdolaRfbddf
         NfnaBBWIsMYRLUr9RxdhGcAzGgDsleBLYAKzBYNXnquWgkjT0RFTxBez25ymRDrTicgo
         sGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0Mw2f0H7fPk/ec2Jm4YQjTpweOlVWIlUul8A8sSfzeA=;
        b=mj2zkevCgdw67u3xs1w3yjxNHQ375X3QP6PEpENJleLXyjFh+DxGIyb7fxwtB8uOT+
         VGue7r07v4pYTizzN4w4nlc41oNd+0bM0Vc+hPpP/wT9CZ0NjvqDgdlLDWZlL6QsFA6V
         SBtCty/oGB4tuxHT3vlM5LRF2rwScEiYukAymVbmCYDpPlZgI06AoclrsGLZJSIa9iPj
         DfhUkEqawxCOOCAu2PUfj9IRg/XcGWrzfiFcdd8KLEzQT20+eC5IwNPKn/9WudmDQ428
         FN7mIIIPf9qFNQocac4jsOyatbv+GIXmuJDHI6SpqZFxshrQEiVk1xDq5l+FIkYFTRB5
         80XA==
X-Gm-Message-State: AJIora9UINZIJhHhl36MvKHW/STYY7GfTbHc/sW5CE9FwsP8htddRDR3
        zuosb87DtqjSKC+qu/YzmoI=
X-Google-Smtp-Source: AGRyM1s2lT+m+UG5iej2Ui9C+qOowxH3IlYMOCSTzdIoT7UWCrV36TUg5JRZmvuFOI6CkLd1QrsEpg==
X-Received: by 2002:a5d:5047:0:b0:21b:92b2:f34f with SMTP id h7-20020a5d5047000000b0021b92b2f34fmr7461441wrt.677.1656584815026;
        Thu, 30 Jun 2022 03:26:55 -0700 (PDT)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c020d00b0039c362311d2sm2539524wmi.9.2022.06.30.03.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 03:26:54 -0700 (PDT)
Message-ID: <883b59b8-19fe-61f7-567b-f05d7e45063b@gmail.com>
Date:   Thu, 30 Jun 2022 11:26:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/7] media: ov5693: move hw cfg functions into
 ov5693_check_hwcfg
Content-Language: en-US
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220627150453.220292-1-tommaso.merciai@amarulasolutions.com>
 <20220627150453.220292-5-tommaso.merciai@amarulasolutions.com>
 <20220629081635.zvdj6pzodg4rhrdf@uno.localdomain>
From:   Daniel Scally <djrscally@gmail.com>
In-Reply-To: <20220629081635.zvdj6pzodg4rhrdf@uno.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

On 29/06/2022 09:16, Jacopo Mondi wrote:
> Hi Tommaso,
>
> On Mon, Jun 27, 2022 at 05:04:50PM +0200, Tommaso Merciai wrote:
>> Move hw configuration functions into ov5693_check_hwcfg. This is done to
>> separe the code that handle the hw cfg from probe in a clean way
> s/separe/separate/
>
> You also seem to change the logic of the clk handling, please mention
> this in the commit message, otherwise one could be fooled into
> thinking you're only moving code around with no functional changes...
>
>> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
>> ---
>>  drivers/media/i2c/ov5693.c | 53 +++++++++++++++++++++++---------------
>>  1 file changed, 32 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
>> index d2adc5513a21..d5a934ace597 100644
>> --- a/drivers/media/i2c/ov5693.c
>> +++ b/drivers/media/i2c/ov5693.c
>> @@ -1348,6 +1348,38 @@ static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
>>  	struct fwnode_handle *endpoint;
>>  	unsigned int i;
>>  	int ret;
>> +	u32 xvclk_rate;
> nit: move it up to maintain reverse-xmas-tree order (I know, it's an
> annoying comment, but since variables are already declared in this order..)
>
>> +
>> +	ov5693->xvclk = devm_clk_get(ov5693->dev, "xvclk");
> Isn't this broken ?
>
> if you use ov5693->xvclk to identify the ACPI vs OF use case shouldn't
> you use the get_optionl() version ? Otherwise in the ACPI case you will have
> -ENOENT if there's not 'xvclk' property and bail out.
>
> Unless my understanding is wrong on ACPI we have "clock-frequency" and
> on OF "xvclk" with an "assigned-clock-rates",
>
> Dan you upstreamed this driver and I assume it was tested on ACPI ?
> Can you clarify how this worked for you, as it seems the original code
> wanted a mandatory "xvclk" ? Are there ACPI tables with an actual
> 'xvclk' property ?


Sorry - late answer, but when I wrote this although it's ostensibly for
an ACPI platform, it's actually only tested with the IPU3 platforms
which work in a _weird_ way. The fix we eventually came to was to create
through the int3472-discrete driver clocks and regulators through the
normal frameworks that a dt platform would expect to consume, so even
though the devices are enumerated through ACPI, the clock/regulator
parts really work more like a dt platform.


You're right that it needs to be get_optional() here, but with that
added I think this is fine - I tested it last night and it works ok for me.

>
>> +	if (IS_ERR(ov5693->xvclk))
>> +		return dev_err_probe(ov5693->dev, PTR_ERR(ov5693->xvclk),
>> +				     "failed to get xvclk: %ld\n",
>> +				     PTR_ERR(ov5693->xvclk));
>> +
>> +	if (ov5693->xvclk) {
>> +		xvclk_rate = clk_get_rate(ov5693->xvclk);
>> +	} else {
>> +		ret = fwnode_property_read_u32(fwnode, "clock-frequency",
>> +					       &xvclk_rate);
>> +
>> +		if (ret) {
>> +			dev_err(ov5693->dev, "can't get clock frequency");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	if (xvclk_rate != OV5693_XVCLK_FREQ)
>> +		dev_warn(ov5693->dev, "Found clk freq %u, expected %u\n",
>> +			 xvclk_rate, OV5693_XVCLK_FREQ);
>> +
>> +	ret = ov5693_configure_gpios(ov5693);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ov5693_get_regulators(ov5693);
>> +	if (ret)
>> +		return dev_err_probe(ov5693->dev, ret,
>> +				     "Error fetching regulators\n");
>>
>>  	endpoint = fwnode_graph_get_next_endpoint(fwnode, NULL);
>>  	if (!endpoint)
>> @@ -1390,7 +1422,6 @@ static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
>>  static int ov5693_probe(struct i2c_client *client)
>>  {
>>  	struct ov5693_device *ov5693;
>> -	u32 xvclk_rate;
>>  	int ret = 0;
>>
>>  	ov5693 = devm_kzalloc(&client->dev, sizeof(*ov5693), GFP_KERNEL);
>> @@ -1408,26 +1439,6 @@ static int ov5693_probe(struct i2c_client *client)
>>
>>  	v4l2_i2c_subdev_init(&ov5693->sd, client, &ov5693_ops);
>>
>> -	ov5693->xvclk = devm_clk_get(&client->dev, "xvclk");
>> -	if (IS_ERR(ov5693->xvclk)) {
>> -		dev_err(&client->dev, "Error getting clock\n");
>> -		return PTR_ERR(ov5693->xvclk);
>> -	}
>> -
>> -	xvclk_rate = clk_get_rate(ov5693->xvclk);
>> -	if (xvclk_rate != OV5693_XVCLK_FREQ)
>> -		dev_warn(&client->dev, "Found clk freq %u, expected %u\n",
>> -			 xvclk_rate, OV5693_XVCLK_FREQ);
>> -
>> -	ret = ov5693_configure_gpios(ov5693);
>> -	if (ret)
>> -		return ret;
>> -
>> -	ret = ov5693_get_regulators(ov5693);
>> -	if (ret)
>> -		return dev_err_probe(&client->dev, ret,
>> -				     "Error fetching regulators\n");
>> -
>>  	ov5693->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>>  	ov5693->pad.flags = MEDIA_PAD_FL_SOURCE;
>>  	ov5693->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
>> --
>> 2.25.1
>>
