Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28707549B47
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiFMSRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbiFMSRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:17:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70402A27C;
        Mon, 13 Jun 2022 07:15:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m20so11418444ejj.10;
        Mon, 13 Jun 2022 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=WkY6YC/lq+OgUkV6SbT7L02is3iwBHoji0O6PsezbEM=;
        b=A/CxupUz2JYW2TKhVixeYcs9exwjKCwCOqMjHjgSygAeb5arPOL/UsaLIkfXyyovsp
         DwMJlxVOrxmGv5S4qlkbRZKZPhW+tWHMoYiiqdcdVHf3/Iovay5N/IKd16o5RTSaKGoo
         Jkmgkg83Ib1+rQzR30SbUSo8EM4zP76tKI/Vefzn/qEBnkpxhW2ftInhjS3qi+Jsn48Z
         G9Dik31zGIIv8/EdAT1DHCAsNkFONfchVE1E59nr+t4rdqcd+dSCiJncQ+Eg149nppRi
         xTrAxURHbN0O3rzw6CK8TSlhTCHbrvUnsm8AM1ZbNDpQr0jsxqCyaQgrB25m97RdirSK
         wrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WkY6YC/lq+OgUkV6SbT7L02is3iwBHoji0O6PsezbEM=;
        b=n+urkEzTxljUIuAHofVujttzmwXm0tXSG4RZ+7tGh4fhv7r6o8HhVlF3ahxs12A5GX
         uJKbH2LPdszXmW7loLvwVP4ZulizaWBUSmijiHQxeKr6eVrHk24Dq2z/MGAfAGWMl9qs
         czfP2qQdkDBRgxWFKqBmHERvbMG6Xk9I2+IxFiHSynVEqvj19PHHOjgJ17TDMC+5ge2D
         stRlX838Awa6+rKUEANIRjZ6U+L/UIyrGAErNTJfhFY7r1TYziOCJlzLlgkQaT/8xbSL
         jqoZxfeBv4ibXn4h9bNUH7ARZV4SOOTvVGBzXsrLcy3lqHQ0MtIGp3WDBZAZMkaGCDQ+
         Z+iA==
X-Gm-Message-State: AOAM533jokuQX+vscCPV0DMWE7m+kBOD+rUFkB1sU9haU6CmHyeBmhrI
        /9A0K09aV/5qUf8dndMQdDw=
X-Google-Smtp-Source: ABdhPJwWib14oqzfqvcsAH0wLXOfpeOSyAk0CLRuFBAN3USZ/7s60hA59eOGyM6r1Dtydm6AzGpTbQ==
X-Received: by 2002:a17:906:730f:b0:711:db1a:fdb0 with SMTP id di15-20020a170906730f00b00711db1afdb0mr115357ejc.54.1655129736364;
        Mon, 13 Jun 2022 07:15:36 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id jt18-20020a170906ca1200b00711edab7622sm3896839ejb.40.2022.06.13.07.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 07:15:35 -0700 (PDT)
Message-ID: <ad084c13-55fc-8506-f768-49a0c6ae4f7f@gmail.com>
Date:   Mon, 13 Jun 2022 16:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V3 1/2] mtd: allow getting MTD device associated with a
 specific DT node
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Rini <trini@konsulko.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220611204651.19947-1-zajec5@gmail.com>
 <20220613160411.48b07515@xps-13>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20220613160411.48b07515@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.06.2022 16:04, Miquel Raynal wrote:
>> @@ -1154,6 +1154,34 @@ int __get_mtd_device(struct mtd_info *mtd)
>>   }
>>   EXPORT_SYMBOL_GPL(__get_mtd_device);
>>   
>> +/**
>> + * of_get_mtd_device_by_node - obtain an MTD device associated with a given node
>> + *
>> + * @np: device tree node
>> + */
>> +struct mtd_info *of_get_mtd_device_by_node(struct device_node *np)
> 
> Shall we try to use a more of-agnostic syntax or is it too complex here?

I need some extra hint, please. This is how many similar functions look
like:

$ grep -E -r "(get|find).*_by_node" ./include/*
./include/drm/drm_mipi_dsi.h:struct mipi_dsi_host *of_find_mipi_dsi_host_by_node(struct device_node *node);
./include/drm/drm_mipi_dsi.h:struct mipi_dsi_device *of_find_mipi_dsi_device_by_node(struct device_node *np);
./include/linux/usb/phy.h:extern struct usb_phy *devm_usb_get_phy_by_node(struct device *dev,
./include/linux/usb/phy.h:static inline struct usb_phy *devm_usb_get_phy_by_node(struct device *dev,
./include/linux/extcon.h:struct extcon_dev *extcon_find_edev_by_node(struct device_node *node);
./include/linux/extcon.h:static inline struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
./include/linux/of_net.h:extern struct net_device *of_find_net_device_by_node(struct device_node *np);
./include/linux/of_net.h:static inline struct net_device *of_find_net_device_by_node(struct device_node *np)
./include/linux/devfreq.h:struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node);
./include/linux/devfreq.h:static inline struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
./include/linux/of_platform.h:extern struct platform_device *of_find_device_by_node(struct device_node *np);
./include/linux/of_platform.h:static inline struct platform_device *of_find_device_by_node(struct device_node *np)
./include/linux/backlight.h:struct backlight_device *of_find_backlight_by_node(struct device_node *node);
./include/linux/backlight.h:of_find_backlight_by_node(struct device_node *node)
./include/linux/i2c.h:struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
./include/linux/i2c.h:struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node);
./include/linux/i2c.h:struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node);
./include/linux/i2c.h:static inline struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
./include/linux/i2c.h:static inline struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
./include/linux/i2c.h:static inline struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node)


>> +{
>> +	struct mtd_info *mtd = NULL;
>> +	struct mtd_info *tmp;
>> +	int err;
>> +
>> +	mutex_lock(&mtd_table_mutex);
>> +
>> +	err = -ENODEV;
>> +	mtd_for_each_device(tmp) {
>> +		if (mtd_get_of_node(tmp) == np) {
>> +			mtd = tmp;
>> +			err = __get_mtd_device(mtd);
>> +			break;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&mtd_table_mutex);
>> +
>> +	return err ? ERR_PTR(err) : mtd;
>> +}
>> +EXPORT_SYMBOL_GPL(of_get_mtd_device_by_node);
>> +
>>   /**
>>    *	get_mtd_device_nm - obtain a validated handle for an MTD device by
>>    *	device name

