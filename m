Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B4754D0F1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349739AbiFOSaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346527AbiFOSaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:30:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D0949252;
        Wed, 15 Jun 2022 11:30:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fu3so24889690ejc.7;
        Wed, 15 Jun 2022 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=0tVyV2MItMC7Xp0ChiF5DdKmNUp2ewZ5lqSMGrWKASc=;
        b=gxocVnjFbqdfBUTdrVKam+IQDV5GQh5/vy8ZoEFNIr3dW1TgmwXHMGt1O/02WiD8g2
         rP91nRYckz7bNxVqzjY+uzKfWAxCUvIGlTimiIZyr973U67kM6RQJbjkuBYEU6ItaRTO
         a6Nkf4XIURXKD63XwumNXuR2G9e7pxBmVGERbTcqFxc9WBktPlCqnWu9j270IhPmz3SO
         Ul+bdCduITEeYFAmHvvEluaSNUzwC3X8yAvg6VA+Tq9SGy2HadhTrqK0BywnZVzMNiZt
         DgJQUc/MhKNTRMk86f/PrDNp9NtcU+w04j7WHxc7Egq9l/9ZJJ6Z/lbMMNoIFELUD6qh
         9L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0tVyV2MItMC7Xp0ChiF5DdKmNUp2ewZ5lqSMGrWKASc=;
        b=2PWtNBzd2g8WvVkZ58rxebHkG93RxNVBt8I4Ya/9nQNiDwPD0wIL/X2J/+jBUOLWjU
         oxuoDsGS39rPqj02naFQ1MsID8PUq03a56M5zU9XiJV2RlWW/Zws2QOEVzVs9L59lM+u
         XLdSSEfFy2BNz9VrN2/hcFmMH4NNArv++0mr/BsfBJF5NUso5dUshPc41iMDII7UQl9x
         VlVZNKbgY6vFA6YLt9A1C3syYlX1WPv1REFw/4lxUaxXf+cKIhbEwq7TjMkVJM58L8dI
         XL/14A+qMdHNge0sDcXJhH/ZcJYAcuA/49ERkn4eokCR+sSFXht0dP017KPspu7ZQ038
         Yw9A==
X-Gm-Message-State: AJIora+SsLyPShwqnXobrBMee+j/5fH8iejc/2DbI/eJgFBh7J9NrePr
        pEIH3H1YR+Dv6U4fPbbxWa66rVQhFLw=
X-Google-Smtp-Source: AGRyM1uM41ebjYsi0V8Q6io3lK1TJ3cHgdXH58BCSObJYShmcsB7lz5YVOLlsr7DzxhCAEvYvfp42g==
X-Received: by 2002:a17:906:b208:b0:70e:c7f1:f8bf with SMTP id p8-20020a170906b20800b0070ec7f1f8bfmr997939ejz.143.1655317815135;
        Wed, 15 Jun 2022 11:30:15 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id fw37-20020a170907502500b0071579abcf3csm5425587ejc.111.2022.06.15.11.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 11:30:14 -0700 (PDT)
Message-ID: <c67b209c-4237-4c9f-3150-23a3ef99bc34@gmail.com>
Date:   Wed, 15 Jun 2022 20:30:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V3 2/2] nvmem: add driver handling U-Boot environment
 variables
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tom Rini <trini@konsulko.com>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220611204651.19947-1-zajec5@gmail.com>
 <20220611204651.19947-2-zajec5@gmail.com>
 <1ecbb1af-53d6-1ac1-fd9f-b780a7c50fd9@pengutronix.de>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <1ecbb1af-53d6-1ac1-fd9f-b780a7c50fd9@pengutronix.de>
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

On 14.06.2022 08:45, Ahmad Fatoum wrote:
>> +	if (err && !mtd_is_bitflip(err)) {
>> +		dev_err(dev, "Failed to read from mtd: %d\n", err);
> 
> Nitpick: %pe

My "err" variable in int, not a pointer (I don't use PTR_ERR()).


>> +static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
>> +				size_t data_offset, size_t data_len)
>> +{
>> +	struct device *dev = priv->dev;
>> +	char *data = buf + data_offset;
>> +	char *var, *value, *eq;
>> +	int idx;
>> +
>> +	priv->ncells = 0;
>> +	for (var = data; var < data + data_len && *var; var += strlen(var) + 1)
>> +		priv->ncells++;
>> +
>> +	priv->cells = devm_kcalloc(dev, priv->ncells, sizeof(*priv->cells), GFP_KERNEL);
>> +	if (!priv->cells)
>> +		return -ENOMEM;
>> +
>> +	for (var = data, idx = 0;
>> +	     var < data + data_len && *var;
>> +	     var = value + strlen(value) + 1, idx++) {
>> +		eq = strchr(var, '=');
>> +		if (!eq)
>> +			break;
>> +		*eq = '\0';
>> +		value = eq + 1;
>> +
>> +		priv->cells[idx].name = devm_kstrdup(dev, var, GFP_KERNEL);
>> +		if (!priv->cells[idx].name)
>> +			return -ENOMEM;
>> +		priv->cells[idx].offset = data_offset + value - data;
>> +		priv->cells[idx].bytes = strlen(value);
> 
> U-Boot environment can't hold binary values?

I believe it can't. In any case \0 is a always a separator.


>> +	}
>> +
>> +	if (WARN_ON(idx != priv->ncells))
>> +		priv->ncells = idx;
>> +
>> +	return 0;
>> +}

