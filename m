Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F74F5A1500
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiHYPAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242172AbiHYPAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:00:30 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DE8474E5;
        Thu, 25 Aug 2022 08:00:28 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f4so16287776pgc.12;
        Thu, 25 Aug 2022 08:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=CG2vRnBkw/IB98N0UEAokZeGwT6lNQECf31j5eLxSqk=;
        b=QpZJVRSfcoX26S9Rhbf8ENNzWFYRAnQkdoYJCdfti5WXmM6tMG39TunQM4WXW66AY0
         UuBNRurfjDXGzDEDyYBYODLxeAfYsGCIDoN0CJAt42YA8yB6tIs5u4z4OLxVR/w/CJdD
         Eau3d1jfGdLavOgSxwHSEa0iz/r6OQuncr0edNAxosN3NGQfTSL5NzihKz4s3y0mPk5I
         KbYl6CRNgM7GQBv74efwdnp3lsk9gZUp/hZmlRESlygkomJcvvnEjOUIFC8FpZ2o879D
         s0Yy62DrDdqSLucchp37fjXUCNrjuWnNDM5c6lkz9ba1DegLd2o52cURrs3HAC3SaGut
         rvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=CG2vRnBkw/IB98N0UEAokZeGwT6lNQECf31j5eLxSqk=;
        b=agK48l+5vOEV8i740Wt8+e7VXImYV0hDml27y1KiM24C7X3dEeVVQoAOX6V6VAgevo
         nWsETqoQLcJfzIKNS1fHgmFl7To9YtRWWYPWw0myMWE8mlKEK+Hzgm9XMZyt40RGMZIy
         tS7SJDLLDunI6RHb8Oz1Uxix0Lf4QWNGpcJuiEFuIKbqikDwGr5/0nU/7lC3nU1S+nv3
         fZBPvuC7O2J7EMI2liQC1zv+3Yg2uo2mCc0fGZVp8RvNIfVWapZJ42Nq0NblWpDt+9kQ
         1HVO8IP6khcRXZrw4AdpHMIwJJkQrNUlzV8i9f0Pcihr4pqKvTbDc5Eit52RxOFDHW3c
         I10g==
X-Gm-Message-State: ACgBeo0ItoTroJydA0JliqCURDnXT2bzDKYPWa9CERU2BPGojJG/aWeg
        8yIyOIyGHptK2UxpFIRPG7Q=
X-Google-Smtp-Source: AA6agR5YGQbRDD7DvXFv9C2lVhwrEE8FwWP4SWJCO7cg7YfOpLuIoDjF2/zXLjD//QY3lKZrFanVKw==
X-Received: by 2002:a05:6a00:234f:b0:525:1f7c:f2bf with SMTP id j15-20020a056a00234f00b005251f7cf2bfmr4383652pfj.14.1661439627619;
        Thu, 25 Aug 2022 08:00:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id rv7-20020a17090b2c0700b001f50e4c43c4sm3659781pjb.22.2022.08.25.08.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 08:00:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 25 Aug 2022 08:00:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andreas =?iso-8859-1?Q?B=F6hler?= <dev@aboehler.at>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: tps23861: add support for initializing the chip
Message-ID: <20220825150025.GA240395@roeck-us.net>
References: <20220825141043.75354-1-dev@aboehler.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220825141043.75354-1-dev@aboehler.at>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 04:10:42PM +0200, Andreas Böhler wrote:
> The tps23861 driver does not initialize the chip and relies on it being
> in auto-mode by default. On some devices, these controllers default to
> OFF-Mode and hence cannot be used at all.
> 
> This brings minimal support for initializing the controller in a user-
> defined mode.
> 
> Tested on a TP-Link TL-SG2452P with 12x TI TPS23861 controllers.
> 
> Signed-off-by: Andreas Böhler <dev@aboehler.at>
> ---
>  .../bindings/hwmon/ti,tps23861.yaml           | 76 +++++++++++++++++
>  drivers/hwmon/tps23861.c                      | 81 +++++++++++++++++++
>  2 files changed, 157 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> index 3bc8e73dfbf0..ed3a703478fb 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml

Devicetree bindings need to be a separate patch.

> @@ -35,6 +35,50 @@ required:
>    - compatible
>    - reg
>  
> +patternProperties:
> +  "^port@([0-3])$":
> +    type: object
> +    description: Represents ports of the device and their specific configuration.
> +
> +    properties:
> +      reg:
> +        description: The port number
> +        items:
> +          minimum: 0
> +          maximum: 3
> +
> +      mode:
> +        description: The operating mode the device should be initialized with
> +        items:
> +          - enum:
> +              - auto
> +              - semiauto
> +              - manual
> +              - off
> +
> +      enable:
> +        description: Whether the port should be enabled
> +        items:
> +          minimum: 0
> +          maximum: 1
> +
> +      power:
> +        description: Whether the port should be powered on
> +        items:
> +          minimum: 0
> +          maximum: 1
> +
> +      poe_plus:
> +        description: Whether the port should support PoE+
> +        items:
> +          minimum: 0
> +          maximum: 1
> +

The above properties are out of scope for a hardware monitoring driver.
A hardware monitoring driver should only affect hardware monitoring
functionality, not chip operation. Port control functionality should
be implemented in a phy driver.

Having said this, I notice that the driver's 'enable' attribute is
misused (abused). It should enable or disable port monitoring, not
port functionality. That attribute should be removed from the driver.

Guenter

> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
>  additionalProperties: false
>  
>  examples:
> @@ -47,5 +91,37 @@ examples:
>                compatible = "ti,tps23861";
>                reg = <0x30>;
>                shunt-resistor-micro-ohms = <255000>;
> +
> +              port@0 {
> +                  reg = <0>;
> +                  mode = "auto";
> +                  enable = <1>;
> +                  power = <1>;
> +                  poe_plus = <1>;
> +              };
> +
> +              port@1 {
> +                  reg = <1>;
> +                  mode = "semiauto";
> +                  enable = <1>;
> +                  power = <0>;
> +                  poe_plus = <1>;
> +              };
> +
> +              port@2 {
> +                  reg = <2>;
> +                  mode = "manual";
> +                  enable = <0>;
> +                  power = <0>;
> +                  poe_plus = <0>;
> +              };
> +
> +              port@3 {
> +                  reg = <3>;
> +                  mode = "off";
> +                  enable = <0>;
> +                  power = <0>;
> +                  poe_plus = <1>;
> +              };
>            };
>      };
> diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
> index 42762e87b014..27bf8716cf12 100644
> --- a/drivers/hwmon/tps23861.c
> +++ b/drivers/hwmon/tps23861.c
> @@ -85,6 +85,8 @@
>  #define PORT_DETECT_CAPACITANCE_INVALID_DELTA	11
>  #define PORT_DETECT_CAPACITANCE_OUT_OF_RANGE	12
>  #define POE_PLUS			0x40
> +#define POE_PLUS_MASK(_port)	\
> +	GENMASK(_port + 4, _port + 4)
>  #define OPERATING_MODE			0x12
>  #define OPERATING_MODE_OFF		0
>  #define OPERATING_MODE_MANUAL		1
> @@ -94,9 +96,22 @@
>  #define OPERATING_MODE_PORT_2_MASK	GENMASK(3, 2)
>  #define OPERATING_MODE_PORT_3_MASK	GENMASK(5, 4)
>  #define OPERATING_MODE_PORT_4_MASK	GENMASK(7, 6)
> +#define OPERATING_MODE_PORT(_mode, _port)	\
> +	(_mode << (_port * 2))
>  
> +#define DISCONNECT_ENABLE		0x13
> +#define DISCONNECT_ENABLE_MASK(_port)	\
> +	GENMASK(_port, _port)
> +#define DISCONNECT_MASK(_port)	\
> +	(GENMASK(_port, _port) | GENMASK(_port + 4, _port + 4))
> +
> +#define DETECT_CLASS_ENABLE		0x14
>  #define DETECT_CLASS_RESTART		0x18
>  #define POWER_ENABLE			0x19
> +#define POWER_ENABLE_ON_MASK(_port)	\
> +	GENMASK(_port, _port)
> +#define POWER_ENABLE_OFF_MASK(_port)	\
> +	GENMASK(_port + 4, _port + 4)
>  #define TPS23861_NUM_PORTS		4
>  
>  #define TPS23861_GENERAL_MASK_1		0x17
> @@ -548,7 +563,16 @@ static int tps23861_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	struct tps23861_data *data;
>  	struct device *hwmon_dev;
> +	struct device_node *child;
>  	u32 shunt_resistor;
> +	u32 reg;
> +	u32 temp;
> +	const char *mode;
> +	unsigned int poe_plusval;
> +	unsigned int mode_val;
> +	unsigned int power_val;
> +	unsigned int enable_val;
> +	unsigned int disconnect_enable_val;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -577,6 +601,63 @@ static int tps23861_probe(struct i2c_client *client)
>  				TPS23861_GENERAL_MASK_1,
>  				TPS23861_CURRENT_SHUNT_MASK);
>  
> +	regmap_read(data->regmap, POE_PLUS, &poe_plusval);
> +	regmap_read(data->regmap, POWER_ENABLE, &power_val);
> +	regmap_read(data->regmap, OPERATING_MODE, &mode_val);
> +	regmap_read(data->regmap, DETECT_CLASS_ENABLE, &enable_val);
> +	regmap_read(data->regmap, DISCONNECT_ENABLE, &disconnect_enable_val);
> +
> +	for_each_child_of_node(dev->of_node, child) {
> +		if (of_property_read_u32(child, "reg", &reg))
> +			continue;
> +
> +		if (reg > (TPS23861_NUM_PORTS - 1) || reg < 0)
> +			continue;
> +
> +		if (!of_property_read_string(child, "mode", &mode)) {
> +			if (!strncmp(mode, "manual", 6)) {
> +				mode_val &= ~OPERATING_MODE_PORT(OPERATING_MODE_AUTO, reg);
> +				mode_val |= OPERATING_MODE_PORT(OPERATING_MODE_MANUAL, reg);
> +			} else if (!strncmp(mode, "semiauto", 8)) {
> +				mode_val &= ~OPERATING_MODE_PORT(OPERATING_MODE_AUTO, reg);
> +				mode_val |= OPERATING_MODE_PORT(OPERATING_MODE_SEMI, reg);
> +			} else if (!strncmp(mode, "auto", 4))
> +				mode_val |= OPERATING_MODE_PORT(OPERATING_MODE_AUTO, reg);
> +			else
> +				mode_val &= ~OPERATING_MODE_PORT(OPERATING_MODE_AUTO, reg);
> +		}
> +
> +		if (!of_property_read_u32(child, "enable", &temp)) {
> +			if (temp) {
> +				enable_val |= DISCONNECT_MASK(reg);
> +				disconnect_enable_val |= DISCONNECT_ENABLE_MASK(reg);
> +			} else {
> +				enable_val &= ~DISCONNECT_MASK(reg);
> +				disconnect_enable_val &= ~DISCONNECT_ENABLE_MASK(reg);
> +			}
> +		}
> +
> +		if (!of_property_read_u32(child, "power", &temp)) {
> +			if (temp)
> +				power_val |= POWER_ENABLE_ON_MASK(reg);
> +			else
> +				power_val |= POWER_ENABLE_OFF_MASK(reg);
> +		}
> +
> +		if (!of_property_read_u32(child, "poe_plus", &temp)) {
> +			if (temp)
> +				poe_plusval |= POE_PLUS_MASK(reg);
> +			else
> +				poe_plusval &= ~POE_PLUS_MASK(reg);
> +		}
> +	}
> +
> +	regmap_write(data->regmap, POE_PLUS, poe_plusval);
> +	regmap_write(data->regmap, POWER_ENABLE, power_val);
> +	regmap_write(data->regmap, OPERATING_MODE, mode_val);
> +	regmap_write(data->regmap, DETECT_CLASS_ENABLE, enable_val);
> +	regmap_write(data->regmap, DISCONNECT_ENABLE, disconnect_enable_val);
> +
>  	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
>  							 data, &tps23861_chip_info,
>  							 NULL);
> -- 
> 2.37.2
> 
