Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0184897DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245053AbiAJLs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245105AbiAJLqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:46:18 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EAEC034008
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 03:45:52 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e9so24727867wra.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 03:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ciFNDdkrJ9fOiffEwbOi/NpOH84t8pFRrH9WMSddenc=;
        b=jrruEbBO64wEOxmgbk82P8FWt7jGZ7npwslc+MKM54VAtKHciUOMkKSpiuoooPMq5w
         aPOhrTo54nBCNd8tXUuilql1vWF05/z7LUQ8FGtRjXTcjVyLlPmkiQjqwOm3kDcfsi3r
         eJUytQUAn28Ri+0NMBuqH7tSM5M2r8z/7ls2gZmG2sgk5H+UnmmTYeY+BMcFHoC03j2D
         pvF/VOwy2wSLoAMWfnU8r1drnuJwi3E+flvxBLdNa1/zfNEvnr7MRPS+HoezwJipf5ne
         8LRVtiFle5SCyNuXva6hT+gMJCAKQSOVnNzwY4hSI1Csv77PrVb2CcIno8QB3fQa8CK1
         kLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ciFNDdkrJ9fOiffEwbOi/NpOH84t8pFRrH9WMSddenc=;
        b=DbGAR9j3bU0rivkxgSKP9wt9nz4iH0laGJi0fBT6O+PG3QsHvHwBVnm2z+P2bncApP
         U3FMmuVzllScYvUBmQ/yOQlJhX1OSkNdaIWkVH2b6Wr9rK+ZSM+7rdwwUDGMJ4TeC6vp
         yrefk2O4S+oFGSfk1u4oToKmOTDqo7Z6jhetRb/5dc+s+9VFkupE3q7r6k8Za/9SlNfe
         Myhb6yx0N3oKW1oyotkhHt1Vh0dk3ZoN3S9xkCZ90iiy8cNQ+zXWae1+CT0GeY8HvVZz
         dmlUS9QVhuphRZUIFtXtnTjF0IBrnrWreLHbGWXdT8drMHguPpqc+PzH9gxO64oSNstj
         56hA==
X-Gm-Message-State: AOAM530qaBIFFp7dvJMaXY7GuR2bj3YkPtz4jYVRsRX0l9TkvVXayptH
        ly7ReBtWgtAjHbrg9mw0JjNHpw==
X-Google-Smtp-Source: ABdhPJyK0kUjSKSMBeEh8JM8GQTqeTnHY/9kVlZ/kgHtD+2JSzz43eaJPZ+dIXY6tNtTvXuXg8HEcg==
X-Received: by 2002:a5d:6dad:: with SMTP id u13mr66397737wrs.604.1641815150985;
        Mon, 10 Jan 2022 03:45:50 -0800 (PST)
Received: from [192.168.1.20] ([81.178.195.252])
        by smtp.gmail.com with ESMTPSA id bd21sm6548401wmb.8.2022.01.10.03.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 03:45:50 -0800 (PST)
Message-ID: <53e76d68-3e47-f221-b5c4-5e29a958c5fc@linaro.org>
Date:   Mon, 10 Jan 2022 11:46:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 1/7] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Content-Language: en-US
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sumit.semwal@linaro.org,
        amit.pundir@linaro.org, john.stultz@linaro.org
References: <20220106173131.3279580-1-caleb.connolly@linaro.org>
 <20220106173131.3279580-2-caleb.connolly@linaro.org>
 <20220109165743.7e01e226@jic23-huawei>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20220109165743.7e01e226@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/01/2022 16:57, Jonathan Cameron wrote:
> On Thu,  6 Jan 2022 17:31:25 +0000
> Caleb Connolly <caleb.connolly@linaro.org> wrote:
> 
>> Some PMIC functions such as the RRADC need to be aware of the PMIC
>> chip revision information to implement errata or otherwise adjust
>> behaviour, export the PMIC information to enable this.
>>
>> This is specifically required to enable the RRADC to adjust
>> coefficients based on which chip fab the PMIC was produced in,
>> this can vary per unique device and therefore has to be read at
>> runtime.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Hi Caleb,
> 
> Some comments inline.
Hi Jonathan,

Thanks for the feedback, I had a question about one of your points below.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>   drivers/mfd/qcom-spmi-pmic.c | 108 +++++++++++++++++------------------
>>   include/soc/qcom/qcom-pmic.h |  63 ++++++++++++++++++++
>>   2 files changed, 114 insertions(+), 57 deletions(-)
>>   create mode 100644 include/soc/qcom/qcom-pmic.h
>>
>> diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
>> index 1cacc00aa6c9..6b75c2f52b74 100644
>> --- a/drivers/mfd/qcom-spmi-pmic.c
>> +++ b/drivers/mfd/qcom-spmi-pmic.c
>> @@ -3,51 +3,24 @@
>>    * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>>    */
>>   
>> +#include <linux/device.h>
>> +#include <linux/gfp.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>> +#include <linux/slab.h>
>>   #include <linux/spmi.h>
>>   #include <linux/regmap.h>
>>   #include <linux/of_platform.h>
>> +#include <soc/qcom/qcom-pmic.h>
>>   
>>   #define PMIC_REV2		0x101
>>   #define PMIC_REV3		0x102
>>   #define PMIC_REV4		0x103
>>   #define PMIC_TYPE		0x104
>>   #define PMIC_SUBTYPE		0x105
>> -
>> +#define PMIC_FAB_ID		0x1f2
>>   #define PMIC_TYPE_VALUE		0x51
>>   
>> -#define COMMON_SUBTYPE		0x00
>> -#define PM8941_SUBTYPE		0x01
>> -#define PM8841_SUBTYPE		0x02
>> -#define PM8019_SUBTYPE		0x03
>> -#define PM8226_SUBTYPE		0x04
>> -#define PM8110_SUBTYPE		0x05
>> -#define PMA8084_SUBTYPE		0x06
>> -#define PMI8962_SUBTYPE		0x07
>> -#define PMD9635_SUBTYPE		0x08
>> -#define PM8994_SUBTYPE		0x09
>> -#define PMI8994_SUBTYPE		0x0a
>> -#define PM8916_SUBTYPE		0x0b
>> -#define PM8004_SUBTYPE		0x0c
>> -#define PM8909_SUBTYPE		0x0d
>> -#define PM8028_SUBTYPE		0x0e
>> -#define PM8901_SUBTYPE		0x0f
>> -#define PM8950_SUBTYPE		0x10
>> -#define PMI8950_SUBTYPE		0x11
>> -#define PM8998_SUBTYPE		0x14
>> -#define PMI8998_SUBTYPE		0x15
>> -#define PM8005_SUBTYPE		0x18
>> -#define PM660L_SUBTYPE		0x1A
>> -#define PM660_SUBTYPE		0x1B
>> -#define PM8150_SUBTYPE		0x1E
>> -#define PM8150L_SUBTYPE		0x1f
>> -#define PM8150B_SUBTYPE		0x20
>> -#define PMK8002_SUBTYPE		0x21
>> -#define PM8009_SUBTYPE		0x24
>> -#define PM8150C_SUBTYPE		0x26
>> -#define SMB2351_SUBTYPE		0x29
>> -
>>   static const struct of_device_id pmic_spmi_id_table[] = {
>>   	{ .compatible = "qcom,pm660",     .data = (void *)PM660_SUBTYPE },
>>   	{ .compatible = "qcom,pm660l",    .data = (void *)PM660L_SUBTYPE },
>> @@ -81,42 +54,47 @@ static const struct of_device_id pmic_spmi_id_table[] = {
>>   	{ }
>>   };
>>   
>> -static void pmic_spmi_show_revid(struct regmap *map, struct device *dev)
>> +static int pmic_spmi_load_revid(struct regmap *map, struct device *dev,
>> +				 struct qcom_spmi_pmic *pmic)
>>   {
>> -	unsigned int rev2, minor, major, type, subtype;
>> -	const char *name = "unknown";
>>   	int ret, i;
>>   
>> -	ret = regmap_read(map, PMIC_TYPE, &type);
>> +	ret = regmap_read(map, PMIC_TYPE, &pmic->type);
>>   	if (ret < 0)
>> -		return;
>> +		return ret;
>>   
>> -	if (type != PMIC_TYPE_VALUE)
>> -		return;
>> +	if (pmic->type != PMIC_TYPE_VALUE)
>> +		return ret;
>>   
>> -	ret = regmap_read(map, PMIC_SUBTYPE, &subtype);
>> +	ret = regmap_read(map, PMIC_SUBTYPE, &pmic->subtype);
>>   	if (ret < 0)
>> -		return;
>> +		return ret;
>>   
>>   	for (i = 0; i < ARRAY_SIZE(pmic_spmi_id_table); i++) {
>> -		if (subtype == (unsigned long)pmic_spmi_id_table[i].data)
>> +		if (pmic->subtype == (unsigned long)pmic_spmi_id_table[i].data)
>>   			break;
>>   	}
>>   
>>   	if (i != ARRAY_SIZE(pmic_spmi_id_table))
>> -		name = pmic_spmi_id_table[i].compatible;
>> +		pmic->name = devm_kstrdup_const(dev, pmic_spmi_id_table[i].compatible, GFP_KERNEL);
> 
> Managed allocation that you call kfree on in remove().
> 
>>   
>> -	ret = regmap_read(map, PMIC_REV2, &rev2);
>> +	ret = regmap_read(map, PMIC_REV2, &pmic->rev2);
>>   	if (ret < 0)
>> -		return;
>> +		return ret;
>>   
>> -	ret = regmap_read(map, PMIC_REV3, &minor);
>> +	ret = regmap_read(map, PMIC_REV3, &pmic->minor);
>>   	if (ret < 0)
>> -		return;
>> +		return ret;
>>   
>> -	ret = regmap_read(map, PMIC_REV4, &major);
>> +	ret = regmap_read(map, PMIC_REV4, &pmic->major);
>>   	if (ret < 0)
>> -		return;
>> +		return ret;
>> +
>> +	if (pmic->subtype == PMI8998_SUBTYPE || pmic->subtype == PM660_SUBTYPE) {
>> +		ret = regmap_read(map, PMIC_FAB_ID, &pmic->fab_id);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>>   
>>   	/*
>>   	 * In early versions of PM8941 and PM8226, the major revision number
>> @@ -124,14 +102,14 @@ static void pmic_spmi_show_revid(struct regmap *map, struct device *dev)
>>   	 * Increment the major revision number here if the chip is an early
>>   	 * version of PM8941 or PM8226.
>>   	 */
>> -	if ((subtype == PM8941_SUBTYPE || subtype == PM8226_SUBTYPE) &&
>> -	    major < 0x02)
>> -		major++;
>> +	if ((pmic->subtype == PM8941_SUBTYPE || pmic->subtype == PM8226_SUBTYPE) &&
>> +	    pmic->major < 0x02)
>> +		pmic->major++;
>>   
>> -	if (subtype == PM8110_SUBTYPE)
>> -		minor = rev2;
>> +	if (pmic->subtype == PM8110_SUBTYPE)
>> +		pmic->minor = pmic->rev2;
>>   
>> -	dev_dbg(dev, "%x: %s v%d.%d\n", subtype, name, major, minor);
>> +	return 0;
>>   }
>>   
>>   static const struct regmap_config spmi_regmap_config = {
>> @@ -144,22 +122,38 @@ static const struct regmap_config spmi_regmap_config = {
>>   static int pmic_spmi_probe(struct spmi_device *sdev)
>>   {
>>   	struct regmap *regmap;
>> +	struct qcom_spmi_pmic *pmic;
>>   
>>   	regmap = devm_regmap_init_spmi_ext(sdev, &spmi_regmap_config);
>>   	if (IS_ERR(regmap))
>>   		return PTR_ERR(regmap);
>>   
>> +	pmic = devm_kzalloc(&sdev->dev, sizeof(*pmic), GFP_KERNEL);
>> +	if (!pmic)
>> +		return -ENOMEM;
> 
> Within the code visible here, why can't this just be on the stack?
I allocated on the heap beacuse the data has to be read by other drivers 
(it's handed over in spmi_device_set_drvdata() below). I don't have a 
whole lot of C experience so please forgive the potentially ignorant 
questions - is it ok to allocate on the stack if the object needs to 
have a lifetime longer than the function?
> 
>> +
>>   	/* Only the first slave id for a PMIC contains this information */
>> -	if (sdev->usid % 2 == 0)
>> -		pmic_spmi_show_revid(regmap, &sdev->dev);
>> +	if (sdev->usid % 2 == 0) {
>> +		pmic_spmi_load_revid(regmap, &sdev->dev, pmic);
>> +		spmi_device_set_drvdata(sdev, pmic);
>> +		qcom_pmic_print_info(&sdev->dev, pmic);
>> +	}
>>   
>>   	return devm_of_platform_populate(&sdev->dev);
>>   }
>>   
>> +static void pmic_spmi_remove(struct spmi_device *sdev)
>> +{
>> +	struct qcom_spmi_pmic *pmic = spmi_device_get_drvdata(sdev);
>> +
>> +	kfree(pmic->name);
> 
> Looks like this is cleaning up a managed allocation unless I'm missing something
> which means you'll get a double free on remove.
> 
>> +}
>> +
>>   MODULE_DEVICE_TABLE(of, pmic_spmi_id_table);
>>   
>>   static struct spmi_driver pmic_spmi_driver = {
>>   	.probe = pmic_spmi_probe,
>> +	.remove = pmic_spmi_remove,
>>   	.driver = {
>>   		.name = "pmic-spmi",
>>   		.of_match_table = pmic_spmi_id_table,
>> diff --git a/include/soc/qcom/qcom-pmic.h b/include/soc/qcom/qcom-pmic.h
>> new file mode 100644
>> index 000000000000..59114988582d
>> --- /dev/null
>> +++ b/include/soc/qcom/qcom-pmic.h
>> @@ -0,0 +1,63 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright (c) 2021 Linaro. All rights reserved.
>> + * Copyright (c) 2021 Caleb Connolly <caleb.connolly@linaro.org>
>> + */
>> +
>> +#ifndef __QCOM_PMIC_H__
>> +#define __QCOM_PMIC_H__
>> +
>> +#define COMMON_SUBTYPE		0x00
>> +#define PM8941_SUBTYPE		0x01
>> +#define PM8841_SUBTYPE		0x02
>> +#define PM8019_SUBTYPE		0x03
>> +#define PM8226_SUBTYPE		0x04
>> +#define PM8110_SUBTYPE		0x05
>> +#define PMA8084_SUBTYPE		0x06
>> +#define PMI8962_SUBTYPE		0x07
>> +#define PMD9635_SUBTYPE		0x08
>> +#define PM8994_SUBTYPE		0x09
>> +#define PMI8994_SUBTYPE		0x0a
>> +#define PM8916_SUBTYPE		0x0b
>> +#define PM8004_SUBTYPE		0x0c
>> +#define PM8909_SUBTYPE		0x0d
>> +#define PM8028_SUBTYPE		0x0e
>> +#define PM8901_SUBTYPE		0x0f
>> +#define PM8950_SUBTYPE		0x10
>> +#define PMI8950_SUBTYPE		0x11
>> +#define PM8998_SUBTYPE		0x14
>> +#define PMI8998_SUBTYPE		0x15
>> +#define PM8005_SUBTYPE		0x18
>> +#define PM660L_SUBTYPE		0x1A
>> +#define PM660_SUBTYPE		0x1B
>> +#define PM8150_SUBTYPE		0x1E
>> +#define PM8150L_SUBTYPE		0x1f
>> +#define PM8150B_SUBTYPE		0x20
>> +#define PMK8002_SUBTYPE		0x21
>> +#define PM8009_SUBTYPE		0x24
>> +#define PM8150C_SUBTYPE		0x26
>> +#define SMB2351_SUBTYPE		0x29
>> +
>> +#define PMI8998_FAB_ID_SMIC	0x11
>> +#define PMI8998_FAB_ID_GF	0x30
>> +
>> +#define PM660_FAB_ID_GF		0x0
>> +#define PM660_FAB_ID_TSMC	0x2
>> +#define PM660_FAB_ID_MX		0x3
>> +
>> +struct qcom_spmi_pmic {
>> +	unsigned int type;
>> +	unsigned int subtype;
>> +	unsigned int major;
>> +	unsigned int minor;
>> +	unsigned int rev2;
>> +	unsigned int fab_id;
>> +	const char *name;
>> +};
>> +
> struct device;
> 
>> +static inline void qcom_pmic_print_info(struct device *dev, struct qcom_spmi_pmic *pmic)
>> +{
> 
> Need an include to get you access to dev_info() and possibly so
> 
> Headers should stand and build on their own including any inline functions they
> contain.
> 
> 
>> +	dev_info(dev, "%x: %s v%d.%d\n",
>> +		pmic->subtype, pmic->name, pmic->major, pmic->minor);
>> +}
>> +
>> +#endif /* __QCOM_PMIC_H__ */
> 

-- 
Kind Regards,
Caleb (they/them)
