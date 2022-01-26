Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E49C49C84C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiAZLJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:09:11 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48518 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240482AbiAZLJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:09:10 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20Q9nERc012928;
        Wed, 26 Jan 2022 12:08:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=QFR2dN8dkibpF8B0/9wAubqoFJzjHR76hN1qSB1UNQc=;
 b=CJQz9enHEakzEJDRo8gWXXxkHkaYq1wEEHzQA2WpFfqlt5TKNpSdTQAsGdNvYswfkbP6
 o+X6HLUvphRs6/HC+gmlqmPtPHJosL6IG3z+EOuBzhB2pBfiXhQnMpACtRT2RM2oyuND
 jVuawcLFB6TgxcImxKZxSNhdOBY4IlxQgP+kXyko9UGyHJ7vRNxKlM8vMQYqw3jR+ss+
 Wo9pfAlGzYNVja5DSfZNyGfoibXeHlhYIYL2bhBODXaM341XCHHQmJPMBgiUGe3zbg+d
 tntyCPb9aE9taxvPJe7Sw+fRR5h3DaIS1WrTpUd0C74I3dfrbC6lUkggL7QwCDlbw5yx jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3du40ngeb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 12:08:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CCA4410002A;
        Wed, 26 Jan 2022 12:08:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B5D70216EE0;
        Wed, 26 Jan 2022 12:08:39 +0100 (CET)
Received: from [10.48.0.175] (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 26 Jan
 2022 12:08:39 +0100
Message-ID: <9662651a-12d9-4893-95c2-aa1a3a10302d@foss.st.com>
Date:   Wed, 26 Jan 2022 12:08:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] nvmem: core: Fix a conflict between MTD and NVMEM on
 wp-gpios property
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <chenshumin86@sina.com>
References: <20220105135734.271313-1-christophe.kerello@foss.st.com>
 <20220105135734.271313-4-christophe.kerello@foss.st.com>
 <3f9a9731-c096-bc9b-63df-bd1dff032737@linaro.org>
From:   Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <3f9a9731-c096-bc9b-63df-bd1dff032737@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_02,2022-01-26_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas, Miquel,

On 1/25/22 11:44, Srinivas Kandagatla wrote:
> 
> 
> On 05/01/2022 13:57, Christophe Kerello wrote:
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index e765d3d0542e..e11c74db64f9 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -769,7 +769,7 @@ struct nvmem_device *nvmem_register(const struct 
>> nvmem_config *config)
>>       if (config->wp_gpio)
>>           nvmem->wp_gpio = config->wp_gpio;
>> -    else
>> +    else if (config->reg_write)
> This is clearly not going to work for everyone.
> 
> A flag in nvmem_config to indicate that wp gpio is managed by provider 
> driver would be the right thing to do here.

Based on your inputs, I will add a new boolean flag in nvmen_config 
(proposal name: skip_wp_gpio) and I will set it to true in mtdcore.c 
when nvmen_config structure is initialized. It will be part of the V2.

Regards,
Christophe Kerello.

>>           nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
>>                               GPIOD_OUT_HIGH);
> 
> --srini
> 
