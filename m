Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C464BA084
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbiBQNBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:01:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiBQNBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:01:32 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9A2284212;
        Thu, 17 Feb 2022 05:01:17 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21H8Zf8e030645;
        Thu, 17 Feb 2022 14:00:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=bhcz2SL/OhIaWwGW8NTZlL5jRPSdDOHNIjAM7cbOK4A=;
 b=QHcfZeBExAc57IHbvuBQmZsCFHSwq6cPvWhrxOsUWlam1/M2J/qu+EiznLHO36g0RXvm
 UErgjsApgGVetf8qOmnGyONej+o7Uvf44iVrZ5hdSPkWtl5rXaHCJOIy944wrrBJkZh6
 x/EYmuPLMLtyAUdlE2R8gIZauXKnx405TQyb1hQA6XSkj9AtoruX3UQHDyJ+R6KprjIm
 Gai9rok/OCQ8KW907x4n0vuG8sOoMfwayO7p53Dcfyw2o9Er97DxXabUhHpAhEunoTk3
 B8IHyqUGp4Dcu7/DliTMYhcDDz9gTZT9FbkagCmBtBd1qfRrC+7q+npq68caAwtidmz/ xw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e9k069hkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 14:00:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4228100034;
        Thu, 17 Feb 2022 14:00:31 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 92D1821ED57;
        Thu, 17 Feb 2022 14:00:31 +0100 (CET)
Received: from [10.48.0.175] (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 17 Feb
 2022 14:00:31 +0100
Message-ID: <f601db90-4239-8b14-e8a5-e1f7c10c1e9f@foss.st.com>
Date:   Thu, 17 Feb 2022 14:00:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] nvmem: core: Fix a conflict between MTD and NVMEM
 on wp-gpios property
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <chenshumin86@sina.com>
References: <20220131095755.8981-1-christophe.kerello@foss.st.com>
 <20220131095755.8981-4-christophe.kerello@foss.st.com>
 <1bd281d8-a576-26dc-79c3-b1a72a4a9691@linaro.org>
From:   Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <1bd281d8-a576-26dc-79c3-b1a72a4a9691@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_04,2022-02-17_01,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On 2/17/22 12:01, Srinivas Kandagatla wrote:
> 
> 
> On 31/01/2022 09:57, Christophe Kerello wrote:
>> Wp-gpios property can be used on NVMEM nodes and the same property can
>> be also used on MTD NAND nodes. In case of the wp-gpios property is
>> defined at NAND level node, the GPIO management is done at NAND driver
>> level. Write protect is disabled when the driver is probed or resumed
>> and is enabled when the driver is released or suspended.
>>
>> When no partitions are defined in the NAND DT node, then the NAND DT node
>> will be passed to NVMEM framework. If wp-gpios property is defined in
>> this node, the GPIO resource is taken twice and the NAND controller
>> driver fails to probe.
>>
>> It would be possible to set config->wp_gpio at MTD level before calling
>> nvmem_register function but NVMEM framework will toggle this GPIO on
>> each write when this GPIO should only be controlled at NAND level driver
>> to ensure that the Write Protect has not been enabled.
>>
>> A way to fix this conflict is to add a new boolean flag in nvmem_config
>> named skip_wp_gpio. In case skip_wp_gpio is set, the GPIO resource will
>> be managed by the provider.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> ---
>> Changes in v2:
>>   - rework the proposal done to fix a conflict between MTD and NVMEM on
>>     wp-gpios property.
>>
>>   drivers/nvmem/core.c           | 2 +-
>>   include/linux/nvmem-provider.h | 4 +++-
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 23a38dcf0fc4..cb40dca6a51d 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -771,7 +771,7 @@ struct nvmem_device *nvmem_register(const struct 
>> nvmem_config *config)
>>       if (config->wp_gpio)
>>           nvmem->wp_gpio = config->wp_gpio;
>> -    else
>> +    else if (!config->skip_wp_gpio)
>>           nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
>>                               GPIOD_OUT_HIGH);
>>       if (IS_ERR(nvmem->wp_gpio)) {
>> diff --git a/include/linux/nvmem-provider.h 
>> b/include/linux/nvmem-provider.h
>> index 98efb7b5660d..4b480023c265 100644
>> --- a/include/linux/nvmem-provider.h
>> +++ b/include/linux/nvmem-provider.h
>> @@ -70,7 +70,8 @@ struct nvmem_keepout {
>>    * @word_size:    Minimum read/write access granularity.
>>    * @stride:    Minimum read/write access stride.
>>    * @priv:    User context passed to read/write callbacks.
>> - * @wp-gpio:   Write protect pin
>> + * @wp-gpio:    Write protect pin
>> + * @skip_wp_gpio: Write Protect pin is managed by the provider.
> 
> Can we rename this to ingore_wp as suggested by Miquel.
> 

OK, It will be part of v3.

Regards,
Christophe Kerello.

> --srini
> 
>>    *
>>    * Note: A default "nvmem<id>" name will be assigned to the device if
>>    * no name is specified in its configuration. In such case "<id>" is
>> @@ -92,6 +93,7 @@ struct nvmem_config {
>>       enum nvmem_type        type;
>>       bool            read_only;
>>       bool            root_only;
>> +    bool            skip_wp_gpio;
>>       struct device_node    *of_node;
>>       bool            no_of_node;
>>       nvmem_reg_read_t    reg_read;
