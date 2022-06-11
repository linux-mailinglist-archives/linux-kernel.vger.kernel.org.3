Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF615475C2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 16:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiFKOsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 10:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiFKOsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 10:48:25 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B62248EF;
        Sat, 11 Jun 2022 07:48:22 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8849EFF807;
        Sat, 11 Jun 2022 14:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654958901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eDM8O+rqP1wADt6VJGoNDpprxjDy/WHcqoHAGOP5wbg=;
        b=oThTq7V99MH2DTE+Wnb4flgjT+M1w/hObHBj0lC/trDIHVJUCW6wRPAAmvpVCc/doEqDZV
        yemikSZbTqgYBOfcjL4pTE3qS0A7Ydtn2LvSnGzxAilJu9Io6apmbxis+J1Rw06yldvvr+
        WBVMrqZ0ojNLq5ai/EfrI43fe6sKrjA67B+A3tWVYBVXkqmoA4DlhvIa77bY25dDCTLm7l
        R1Hm79u4RchC7443a5sx+ChdpbLtqWy7qSjMsCD7ZnCw7P0OsYlnzVcHIL8ysWme+61rtx
        s5UxwNqDK/ZGFciQDDMySf5BXsOlk0Fda2BLIZUePE3dRuKjtqC/gu3OjVdq3w==
Date:   Sat, 11 Jun 2022 16:48:19 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Dianlong Li <long17.cool@163.com>,
        Wolfram Sang <wsa@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: use simple i2c probe
Message-ID: <YqSnwf7paZa1+uuh@mail.local>
References: <20220610162346.4134094-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610162346.4134094-1-steve@sk2.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 10/06/2022 18:23:43+0200, Stephen Kitt wrote:
> All these drivers have an i2c probe function which doesn't use the
> "struct i2c_device_id *id" parameter, so they can trivially be
> converted to the "probe_new" style of probe with a single argument.
> 

I think you should explain why you want to do that as the trend is to do
the exact opposite to allow support for those RTCS on x86 systems.

> This change was done using the following Coccinelle script, and fixed
> up for whitespace changes:
> 
> @ rule1 @
> identifier fn;
> identifier client, id;
> @@
> 
> - static int fn(struct i2c_client *client, const struct i2c_device_id *id)
> + static int fn(struct i2c_client *client)
> {
> ...when != id
> }
> 
> @ rule2 depends on rule1 @
> identifier rule1.fn;
> identifier driver;
> @@
> 
> struct i2c_driver driver = {
> -	.probe
> +	.probe_new
> 		=
> (
> 		   fn
> |
> -		   &fn
> +		   fn
> )
> 		,
> };
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  drivers/rtc/rtc-ab-b5ze-s3.c | 5 ++---
>  drivers/rtc/rtc-ab-eoz9.c    | 5 ++---
>  drivers/rtc/rtc-bq32k.c      | 5 ++---
>  drivers/rtc/rtc-ds1374.c     | 5 ++---
>  drivers/rtc/rtc-ds1672.c     | 5 ++---
>  drivers/rtc/rtc-ds3232.c     | 5 ++---
>  drivers/rtc/rtc-em3027.c     | 5 ++---
>  drivers/rtc/rtc-fm3130.c     | 5 ++---
>  drivers/rtc/rtc-hym8563.c    | 5 ++---
>  drivers/rtc/rtc-isl12022.c   | 5 ++---
>  drivers/rtc/rtc-max6900.c    | 5 ++---
>  drivers/rtc/rtc-pcf8523.c    | 5 ++---
>  drivers/rtc/rtc-pcf85363.c   | 5 ++---
>  drivers/rtc/rtc-pcf8563.c    | 5 ++---
>  drivers/rtc/rtc-pcf8583.c    | 5 ++---
>  drivers/rtc/rtc-rv3029c2.c   | 5 ++---
>  drivers/rtc/rtc-rx6110.c     | 5 ++---
>  drivers/rtc/rtc-rx8581.c     | 5 ++---
>  drivers/rtc/rtc-s35390a.c    | 5 ++---
>  drivers/rtc/rtc-sd3078.c     | 5 ++---
>  drivers/rtc/rtc-x1205.c      | 5 ++---
>  21 files changed, 42 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
> index 6e3e320dc727..f2b0971d2c65 100644
> --- a/drivers/rtc/rtc-ab-b5ze-s3.c
> +++ b/drivers/rtc/rtc-ab-b5ze-s3.c
> @@ -817,8 +817,7 @@ static const struct regmap_config abb5zes3_rtc_regmap_config = {
>  	.val_bits = 8,
>  };
>  
> -static int abb5zes3_probe(struct i2c_client *client,
> -			  const struct i2c_device_id *id)
> +static int abb5zes3_probe(struct i2c_client *client)
>  {
>  	struct abb5zes3_rtc_data *data = NULL;
>  	struct device *dev = &client->dev;
> @@ -945,7 +944,7 @@ static struct i2c_driver abb5zes3_driver = {
>  		.pm = &abb5zes3_rtc_pm_ops,
>  		.of_match_table = of_match_ptr(abb5zes3_dt_match),
>  	},
> -	.probe	  = abb5zes3_probe,
> +	.probe_new = abb5zes3_probe,
>  	.id_table = abb5zes3_id,
>  };
>  module_i2c_driver(abb5zes3_driver);
> diff --git a/drivers/rtc/rtc-ab-eoz9.c b/drivers/rtc/rtc-ab-eoz9.c
> index e188ab517f1e..2f8deb8c4cd3 100644
> --- a/drivers/rtc/rtc-ab-eoz9.c
> +++ b/drivers/rtc/rtc-ab-eoz9.c
> @@ -495,8 +495,7 @@ static void abeoz9_hwmon_register(struct device *dev,
>  
>  #endif
>  
> -static int abeoz9_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int abeoz9_probe(struct i2c_client *client)
>  {
>  	struct abeoz9_rtc_data *data = NULL;
>  	struct device *dev = &client->dev;
> @@ -580,7 +579,7 @@ static struct i2c_driver abeoz9_driver = {
>  		.name = "rtc-ab-eoz9",
>  		.of_match_table = of_match_ptr(abeoz9_dt_match),
>  	},
> -	.probe	  = abeoz9_probe,
> +	.probe_new = abeoz9_probe,
>  	.id_table = abeoz9_id,
>  };
>  
> diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
> index 2235c968842d..e0bbb11d912e 100644
> --- a/drivers/rtc/rtc-bq32k.c
> +++ b/drivers/rtc/rtc-bq32k.c
> @@ -249,8 +249,7 @@ static void bq32k_sysfs_unregister(struct device *dev)
>  	device_remove_file(dev, &dev_attr_trickle_charge_bypass);
>  }
>  
> -static int bq32k_probe(struct i2c_client *client,
> -				const struct i2c_device_id *id)
> +static int bq32k_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct rtc_device *rtc;
> @@ -322,7 +321,7 @@ static struct i2c_driver bq32k_driver = {
>  		.name	= "bq32k",
>  		.of_match_table = of_match_ptr(bq32k_of_match),
>  	},
> -	.probe		= bq32k_probe,
> +	.probe_new	= bq32k_probe,
>  	.remove		= bq32k_remove,
>  	.id_table	= bq32k_id,
>  };
> diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
> index 8db5a631bca8..b19de5100b1a 100644
> --- a/drivers/rtc/rtc-ds1374.c
> +++ b/drivers/rtc/rtc-ds1374.c
> @@ -467,8 +467,7 @@ static const struct watchdog_ops ds1374_wdt_ops = {
>   *
>   *****************************************************************************
>   */
> -static int ds1374_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int ds1374_probe(struct i2c_client *client)
>  {
>  	struct ds1374 *ds1374;
>  	int ret;
> @@ -575,7 +574,7 @@ static struct i2c_driver ds1374_driver = {
>  		.of_match_table = of_match_ptr(ds1374_of_match),
>  		.pm = &ds1374_pm,
>  	},
> -	.probe = ds1374_probe,
> +	.probe_new = ds1374_probe,
>  	.remove = ds1374_remove,
>  	.id_table = ds1374_id,
>  };
> diff --git a/drivers/rtc/rtc-ds1672.c b/drivers/rtc/rtc-ds1672.c
> index 4cd8efbef6cf..a3bb2cd9c881 100644
> --- a/drivers/rtc/rtc-ds1672.c
> +++ b/drivers/rtc/rtc-ds1672.c
> @@ -106,8 +106,7 @@ static const struct rtc_class_ops ds1672_rtc_ops = {
>  	.set_time = ds1672_set_time,
>  };
>  
> -static int ds1672_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int ds1672_probe(struct i2c_client *client)
>  {
>  	int err = 0;
>  	struct rtc_device *rtc;
> @@ -150,7 +149,7 @@ static struct i2c_driver ds1672_driver = {
>  		   .name = "rtc-ds1672",
>  		   .of_match_table = of_match_ptr(ds1672_of_match),
>  	},
> -	.probe = &ds1672_probe,
> +	.probe_new = ds1672_probe,
>  	.id_table = ds1672_id,
>  };
>  
> diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
> index 168bc27f1f5a..dd31a60c1fc6 100644
> --- a/drivers/rtc/rtc-ds3232.c
> +++ b/drivers/rtc/rtc-ds3232.c
> @@ -566,8 +566,7 @@ static const struct dev_pm_ops ds3232_pm_ops = {
>  
>  #if IS_ENABLED(CONFIG_I2C)
>  
> -static int ds3232_i2c_probe(struct i2c_client *client,
> -			    const struct i2c_device_id *id)
> +static int ds3232_i2c_probe(struct i2c_client *client)
>  {
>  	struct regmap *regmap;
>  	static const struct regmap_config config = {
> @@ -604,7 +603,7 @@ static struct i2c_driver ds3232_driver = {
>  		.of_match_table = of_match_ptr(ds3232_of_match),
>  		.pm	= &ds3232_pm_ops,
>  	},
> -	.probe = ds3232_i2c_probe,
> +	.probe_new = ds3232_i2c_probe,
>  	.id_table = ds3232_id,
>  };
>  
> diff --git a/drivers/rtc/rtc-em3027.c b/drivers/rtc/rtc-em3027.c
> index 9f176bce48ba..53f9f9391a5f 100644
> --- a/drivers/rtc/rtc-em3027.c
> +++ b/drivers/rtc/rtc-em3027.c
> @@ -111,8 +111,7 @@ static const struct rtc_class_ops em3027_rtc_ops = {
>  	.set_time = em3027_set_time,
>  };
>  
> -static int em3027_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int em3027_probe(struct i2c_client *client)
>  {
>  	struct rtc_device *rtc;
>  
> @@ -148,7 +147,7 @@ static struct i2c_driver em3027_driver = {
>  		   .name = "rtc-em3027",
>  		   .of_match_table = of_match_ptr(em3027_of_match),
>  	},
> -	.probe = &em3027_probe,
> +	.probe_new = em3027_probe,
>  	.id_table = em3027_id,
>  };
>  
> diff --git a/drivers/rtc/rtc-fm3130.c b/drivers/rtc/rtc-fm3130.c
> index 677ec2da13d8..f59bb81f23c0 100644
> --- a/drivers/rtc/rtc-fm3130.c
> +++ b/drivers/rtc/rtc-fm3130.c
> @@ -340,8 +340,7 @@ static const struct rtc_class_ops fm3130_rtc_ops = {
>  
>  static struct i2c_driver fm3130_driver;
>  
> -static int fm3130_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int fm3130_probe(struct i2c_client *client)
>  {
>  	struct fm3130		*fm3130;
>  	int			err = -ENODEV;
> @@ -518,7 +517,7 @@ static struct i2c_driver fm3130_driver = {
>  	.driver = {
>  		.name	= "rtc-fm3130",
>  	},
> -	.probe		= fm3130_probe,
> +	.probe_new	= fm3130_probe,
>  	.id_table	= fm3130_id,
>  };
>  
> diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
> index 90e602e99d03..cc710d682121 100644
> --- a/drivers/rtc/rtc-hym8563.c
> +++ b/drivers/rtc/rtc-hym8563.c
> @@ -495,8 +495,7 @@ static int hym8563_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(hym8563_pm_ops, hym8563_suspend, hym8563_resume);
>  
> -static int hym8563_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int hym8563_probe(struct i2c_client *client)
>  {
>  	struct hym8563 *hym8563;
>  	int ret;
> @@ -572,7 +571,7 @@ static struct i2c_driver hym8563_driver = {
>  		.pm	= &hym8563_pm_ops,
>  		.of_match_table	= hym8563_dt_idtable,
>  	},
> -	.probe		= hym8563_probe,
> +	.probe_new	= hym8563_probe,
>  	.id_table	= hym8563_id,
>  };
>  
> diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
> index 961bd5d1d109..79461ded1a48 100644
> --- a/drivers/rtc/rtc-isl12022.c
> +++ b/drivers/rtc/rtc-isl12022.c
> @@ -232,8 +232,7 @@ static const struct rtc_class_ops isl12022_rtc_ops = {
>  	.set_time	= isl12022_rtc_set_time,
>  };
>  
> -static int isl12022_probe(struct i2c_client *client,
> -			  const struct i2c_device_id *id)
> +static int isl12022_probe(struct i2c_client *client)
>  {
>  	struct isl12022 *isl12022;
>  
> @@ -275,7 +274,7 @@ static struct i2c_driver isl12022_driver = {
>  		.of_match_table = of_match_ptr(isl12022_dt_match),
>  #endif
>  	},
> -	.probe		= isl12022_probe,
> +	.probe_new	= isl12022_probe,
>  	.id_table	= isl12022_id,
>  };
>  
> diff --git a/drivers/rtc/rtc-max6900.c b/drivers/rtc/rtc-max6900.c
> index 4beadfa41644..0a33851cc51f 100644
> --- a/drivers/rtc/rtc-max6900.c
> +++ b/drivers/rtc/rtc-max6900.c
> @@ -197,8 +197,7 @@ static const struct rtc_class_ops max6900_rtc_ops = {
>  	.set_time = max6900_rtc_set_time,
>  };
>  
> -static int
> -max6900_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +static int max6900_probe(struct i2c_client *client)
>  {
>  	struct rtc_device *rtc;
>  
> @@ -225,7 +224,7 @@ static struct i2c_driver max6900_driver = {
>  	.driver = {
>  		   .name = "rtc-max6900",
>  		   },
> -	.probe = max6900_probe,
> +	.probe_new = max6900_probe,
>  	.id_table = max6900_id,
>  };
>  
> diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
> index b1b1943de844..6174b3fd4b98 100644
> --- a/drivers/rtc/rtc-pcf8523.c
> +++ b/drivers/rtc/rtc-pcf8523.c
> @@ -390,8 +390,7 @@ static const struct regmap_config regmap_config = {
>          .max_register = 0x13,
>  };
>  
> -static int pcf8523_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int pcf8523_probe(struct i2c_client *client)
>  {
>  	struct pcf8523 *pcf8523;
>  	struct rtc_device *rtc;
> @@ -485,7 +484,7 @@ static struct i2c_driver pcf8523_driver = {
>  		.name = "rtc-pcf8523",
>  		.of_match_table = pcf8523_of_match,
>  	},
> -	.probe = pcf8523_probe,
> +	.probe_new = pcf8523_probe,
>  	.id_table = pcf8523_id,
>  };
>  module_i2c_driver(pcf8523_driver);
> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index bb3e9ba75f6c..c05b722f0060 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
> @@ -350,8 +350,7 @@ static const struct pcf85x63_config pcf_85363_config = {
>  	.num_nvram = 2
>  };
>  
> -static int pcf85363_probe(struct i2c_client *client,
> -			  const struct i2c_device_id *id)
> +static int pcf85363_probe(struct i2c_client *client)
>  {
>  	struct pcf85363 *pcf85363;
>  	const struct pcf85x63_config *config = &pcf_85363_config;
> @@ -436,7 +435,7 @@ static struct i2c_driver pcf85363_driver = {
>  		.name	= "pcf85363",
>  		.of_match_table = of_match_ptr(dev_ids),
>  	},
> -	.probe	= pcf85363_probe,
> +	.probe_new = pcf85363_probe,
>  };
>  
>  module_i2c_driver(pcf85363_driver);
> diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
> index 9d06813e2e6d..11fa9788558b 100644
> --- a/drivers/rtc/rtc-pcf8563.c
> +++ b/drivers/rtc/rtc-pcf8563.c
> @@ -509,8 +509,7 @@ static const struct rtc_class_ops pcf8563_rtc_ops = {
>  	.alarm_irq_enable = pcf8563_irq_enable,
>  };
>  
> -static int pcf8563_probe(struct i2c_client *client,
> -				const struct i2c_device_id *id)
> +static int pcf8563_probe(struct i2c_client *client)
>  {
>  	struct pcf8563 *pcf8563;
>  	int err;
> @@ -606,7 +605,7 @@ static struct i2c_driver pcf8563_driver = {
>  		.name	= "rtc-pcf8563",
>  		.of_match_table = of_match_ptr(pcf8563_of_match),
>  	},
> -	.probe		= pcf8563_probe,
> +	.probe_new	= pcf8563_probe,
>  	.id_table	= pcf8563_id,
>  };
>  
> diff --git a/drivers/rtc/rtc-pcf8583.c b/drivers/rtc/rtc-pcf8583.c
> index c80ca20e5d8d..87074d178274 100644
> --- a/drivers/rtc/rtc-pcf8583.c
> +++ b/drivers/rtc/rtc-pcf8583.c
> @@ -275,8 +275,7 @@ static const struct rtc_class_ops pcf8583_rtc_ops = {
>  	.set_time	= pcf8583_rtc_set_time,
>  };
>  
> -static int pcf8583_probe(struct i2c_client *client,
> -				const struct i2c_device_id *id)
> +static int pcf8583_probe(struct i2c_client *client)
>  {
>  	struct pcf8583 *pcf8583;
>  
> @@ -307,7 +306,7 @@ static struct i2c_driver pcf8583_driver = {
>  	.driver = {
>  		.name	= "pcf8583",
>  	},
> -	.probe		= pcf8583_probe,
> +	.probe_new	= pcf8583_probe,
>  	.id_table	= pcf8583_id,
>  };
>  
> diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
> index 8cb84c9595fc..eb483a30bd92 100644
> --- a/drivers/rtc/rtc-rv3029c2.c
> +++ b/drivers/rtc/rtc-rv3029c2.c
> @@ -784,8 +784,7 @@ static const struct regmap_config config = {
>  
>  #if IS_ENABLED(CONFIG_I2C)
>  
> -static int rv3029_i2c_probe(struct i2c_client *client,
> -			    const struct i2c_device_id *id)
> +static int rv3029_i2c_probe(struct i2c_client *client)
>  {
>  	struct regmap *regmap;
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK |
> @@ -819,7 +818,7 @@ static struct i2c_driver rv3029_driver = {
>  		.name = "rv3029",
>  		.of_match_table = of_match_ptr(rv3029_of_match),
>  	},
> -	.probe		= rv3029_i2c_probe,
> +	.probe_new	= rv3029_i2c_probe,
>  	.id_table	= rv3029_id,
>  };
>  
> diff --git a/drivers/rtc/rtc-rx6110.c b/drivers/rtc/rtc-rx6110.c
> index 758fd6e11a15..cc634558b928 100644
> --- a/drivers/rtc/rtc-rx6110.c
> +++ b/drivers/rtc/rtc-rx6110.c
> @@ -419,8 +419,7 @@ static struct regmap_config regmap_i2c_config = {
>  	.read_flag_mask = 0x80,
>  };
>  
> -static int rx6110_i2c_probe(struct i2c_client *client,
> -			    const struct i2c_device_id *id)
> +static int rx6110_i2c_probe(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
>  	struct rx6110_data *rx6110;
> @@ -464,7 +463,7 @@ static struct i2c_driver rx6110_i2c_driver = {
>  		.name = RX6110_DRIVER_NAME,
>  		.acpi_match_table = rx6110_i2c_acpi_match,
>  	},
> -	.probe		= rx6110_i2c_probe,
> +	.probe_new	= rx6110_i2c_probe,
>  	.id_table	= rx6110_i2c_id,
>  };
>  
> diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
> index aed4898a0ff4..14edb7534c97 100644
> --- a/drivers/rtc/rtc-rx8581.c
> +++ b/drivers/rtc/rtc-rx8581.c
> @@ -248,8 +248,7 @@ static const struct rx85x1_config rx8571_config = {
>  	.num_nvram = 2
>  };
>  
> -static int rx8581_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int rx8581_probe(struct i2c_client *client)
>  {
>  	struct rx8581 *rx8581;
>  	const struct rx85x1_config *config = &rx8581_config;
> @@ -326,7 +325,7 @@ static struct i2c_driver rx8581_driver = {
>  		.name	= "rtc-rx8581",
>  		.of_match_table = of_match_ptr(rx8581_of_match),
>  	},
> -	.probe		= rx8581_probe,
> +	.probe_new	= rx8581_probe,
>  	.id_table	= rx8581_id,
>  };
>  
> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 26278c770731..81d97b1d3159 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
> @@ -420,8 +420,7 @@ static const struct rtc_class_ops s35390a_rtc_ops = {
>  	.ioctl          = s35390a_rtc_ioctl,
>  };
>  
> -static int s35390a_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int s35390a_probe(struct i2c_client *client)
>  {
>  	int err, err_read;
>  	unsigned int i;
> @@ -502,7 +501,7 @@ static struct i2c_driver s35390a_driver = {
>  		.name	= "rtc-s35390a",
>  		.of_match_table = of_match_ptr(s35390a_of_match),
>  	},
> -	.probe		= s35390a_probe,
> +	.probe_new	= s35390a_probe,
>  	.id_table	= s35390a_id,
>  };
>  
> diff --git a/drivers/rtc/rtc-sd3078.c b/drivers/rtc/rtc-sd3078.c
> index 24e8528e23ec..e2f90d768ca8 100644
> --- a/drivers/rtc/rtc-sd3078.c
> +++ b/drivers/rtc/rtc-sd3078.c
> @@ -163,8 +163,7 @@ static const struct regmap_config regmap_config = {
>  	.max_register = 0x11,
>  };
>  
> -static int sd3078_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int sd3078_probe(struct i2c_client *client)
>  {
>  	int ret;
>  	struct sd3078 *sd3078;
> @@ -218,7 +217,7 @@ static struct i2c_driver sd3078_driver = {
>  		.name   = "sd3078",
>  		.of_match_table = of_match_ptr(rtc_dt_match),
>  	},
> -	.probe      = sd3078_probe,
> +	.probe_new  = sd3078_probe,
>  	.id_table   = sd3078_id,
>  };
>  
> diff --git a/drivers/rtc/rtc-x1205.c b/drivers/rtc/rtc-x1205.c
> index d1d5a44d9122..ba0d22a5b421 100644
> --- a/drivers/rtc/rtc-x1205.c
> +++ b/drivers/rtc/rtc-x1205.c
> @@ -614,8 +614,7 @@ static void x1205_sysfs_unregister(struct device *dev)
>  }
>  
>  
> -static int x1205_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int x1205_probe(struct i2c_client *client)
>  {
>  	int err = 0;
>  	unsigned char sr;
> @@ -681,7 +680,7 @@ static struct i2c_driver x1205_driver = {
>  		.name	= "rtc-x1205",
>  		.of_match_table = x1205_dt_ids,
>  	},
> -	.probe		= x1205_probe,
> +	.probe_new	= x1205_probe,
>  	.remove		= x1205_remove,
>  	.id_table	= x1205_id,
>  };
> 
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> -- 
> 2.30.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
