Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AEC58AA1F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbiHEL2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbiHEL2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:28:11 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34D676445;
        Fri,  5 Aug 2022 04:28:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t22-20020a17090a449600b001f617f2bf3eso194194pjg.0;
        Fri, 05 Aug 2022 04:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=hI1NrNO8see2bW+n78dHinnMiy0Z4qhlKeMLT1FoHZk=;
        b=DybZX71j82P8LwUbSUquVALRfFvR7EPtuQXG3SDacXQzty+lBdGKY9YlFsCO4Znte3
         PoWZJbFq0PoMtF4NOFXjCDsEg0ukzlEZqBjgMS+Ff0U2oZ/LrPuqP8JRYVbOKInPNezF
         o3Ras5kzLE9aCHaQHw9wTOlEeFiPcakgxP1i0KdMpts2Z8wyqvNSeobSjS1Unt9M9jN1
         8vFALsptqth6w65vKzZ83oyj0NPuW7Fw/Ujlr6fEfLZ/PpLYoG7eNNLLTUkrkr/o1lkA
         Q/qOTDgTfEer3eouL9yQV1+BDsiLVgnVdalz3La0+9K4bVJVcEK/p/mE5ajRR6Qmf+6H
         lWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=hI1NrNO8see2bW+n78dHinnMiy0Z4qhlKeMLT1FoHZk=;
        b=EoiVviaPLBxymPy/lDKNr3sX7NWKpGUlc3m3cnrj4pFG/JGpfkMIfa+ysUckFs3AeK
         tHUaBuA+l0v0vm9SGt80equtvH6w7uYhTxUzbgRpQMNlRz8BvV72G/IdfiYE+OXnd0tz
         52Zh9r0JK0P+ZVOmiw7oT6l+nPYePQkPRY8jscWed/rPEVx4sP/aknJOi5vsmOZFIN6N
         xtRXxG3aD5JlFACCati2gKGOkOylYBbAYXq5rrXIPy5usKk0HhlBCBmyTMvdkLLoniuM
         9iTA9gPAh8eAe5u4vXZAwJa41qw+63j+YS4wstvXIuTx/iYMXePvMI2zroPha3eOuSY8
         As7g==
X-Gm-Message-State: ACgBeo2jxZgK/gfFgmrZUSP4Dvjws3inbrxu+ssE/IwX6m9cFhJlxwcS
        Z8plRbGpXE/SsX9hXJ+gn+g=
X-Google-Smtp-Source: AA6agR6w6/3VmR7fVxv4KqNyr42sDEFDD9iHgCYkYCgOKPVBY/m47ug1jjjTd0UpAMvXTnBtpJqwhg==
X-Received: by 2002:a17:90a:e7d1:b0:1f5:665:4607 with SMTP id kb17-20020a17090ae7d100b001f506654607mr15775755pjb.77.1659698890077;
        Fri, 05 Aug 2022 04:28:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a2f0100b001f04479017fsm2779245pjd.29.2022.08.05.04.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 04:27:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 5 Aug 2022 04:27:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: Re: [PATCH v4 5/7] usb: typec: tcpci_rt1711h: Add compatible id with
 rt1715
Message-ID: <20220805112750.GC1011279@roeck-us.net>
References: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
 <20220805071714.150882-6-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805071714.150882-6-gene.chen.richtek@gmail.com>
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

On Fri, Aug 05, 2022 at 03:17:11PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add compatible id with rt1715, and add initial setting for
> specific support PD30 command.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 43 +++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 5c51d04..ff7deae 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -18,6 +18,8 @@
>  
>  #define RT1711H_VID		0x29CF
>  #define RT1711H_PID		0x1711
> +#define RT1711H_DID		0x2171
> +#define RT1715_DID		0x2173
>  
>  #define RT1711H_PHYCTRL1	0x80
>  #define RT1711H_PHYCTRL2	0x81
> @@ -29,6 +31,7 @@
>  			    (((ck300) << 7) | ((ship_off) << 5) | \
>  			    ((auto_idle) << 3) | ((tout) & 0x07))
>  #define RT1711H_AUTOIDLEEN	BIT(3)
> +#define RT1711H_ENEXTMSG	BIT(4)
>  
>  #define RT1711H_RTCTRL11	0x9E
>  
> @@ -47,6 +50,7 @@ struct rt1711h_chip {
>  	struct device *dev;
>  	struct regulator *vbus;
>  	bool src_en;
> +	u16 did;
>  };
>  
>  static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
> @@ -83,8 +87,9 @@ static struct rt1711h_chip *tdata_to_rt1711h(struct tcpci_data *tdata)
>  
>  static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>  {
> -	int ret;
>  	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
> +	struct regmap *regmap = chip->data.regmap;
> +	int ret;
>  
>  	/* CK 300K from 320K, shipping off, auto_idle enable, tout = 32ms */
>  	ret = rt1711h_write8(chip, RT1711H_RTCTRL8,
> @@ -92,6 +97,14 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Enable PD30 extended message for RT1715 */
> +	if (chip->did == RT1715_DID) {
> +		ret = regmap_update_bits(regmap, RT1711H_RTCTRL8,
> +					 RT1711H_ENEXTMSG, RT1711H_ENEXTMSG);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	/* I2C reset : (val + 1) * 12.5ms */
>  	ret = rt1711h_write8(chip, RT1711H_RTCTRL11,
>  			     RT1711H_RTCTRL11_SET(1, 0x0F));
> @@ -229,7 +242,7 @@ static int rt1711h_sw_reset(struct rt1711h_chip *chip)
>  	return 0;
>  }
>  
> -static int rt1711h_check_revision(struct i2c_client *i2c)
> +static int rt1711h_check_revision(struct i2c_client *i2c, struct rt1711h_chip *chip)
>  {
>  	int ret;
>  
> @@ -247,7 +260,15 @@ static int rt1711h_check_revision(struct i2c_client *i2c)
>  		dev_err(&i2c->dev, "pid is not correct, 0x%04x\n", ret);
>  		return -ENODEV;
>  	}
> -	return 0;
> +	ret = i2c_smbus_read_word_data(i2c, TCPC_BCD_DEV);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != chip->did) {
> +		dev_err(&i2c->dev, "did is not correct, 0x%04x\n", ret);
> +		return -ENODEV;
> +	}
> +	dev_dbg(&i2c->dev, "did is 0x%04x\n", ret);
> +	return ret;
>  }
>  
>  static int rt1711h_probe(struct i2c_client *client,
> @@ -256,16 +277,18 @@ static int rt1711h_probe(struct i2c_client *client,
>  	int ret;
>  	struct rt1711h_chip *chip;
>  
> -	ret = rt1711h_check_revision(client);
> +	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->did = (size_t)device_get_match_data(&client->dev);
> +
> +	ret = rt1711h_check_revision(client, chip);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "check vid/pid fail\n");
>  		return ret;
>  	}
>  
> -	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> -	if (!chip)
> -		return -ENOMEM;
> -
>  	chip->data.regmap = devm_regmap_init_i2c(client,
>  						 &rt1711h_regmap_config);
>  	if (IS_ERR(chip->data.regmap))
> @@ -316,13 +339,15 @@ static int rt1711h_remove(struct i2c_client *client)
>  
>  static const struct i2c_device_id rt1711h_id[] = {
>  	{ "rt1711h", 0 },
> +	{ "rt1715", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, rt1711h_id);
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id rt1711h_of_match[] = {
> -	{ .compatible = "richtek,rt1711h", },
> +	{ .compatible = "richtek,rt1711h", .data = (void *)RT1711H_DID },
> +	{ .compatible = "richtek,rt1715", .data = (void *)RT1715_DID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, rt1711h_of_match);
> -- 
> 2.7.4
> 
