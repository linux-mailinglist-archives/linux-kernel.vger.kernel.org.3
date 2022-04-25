Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDB150DCB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiDYJcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241107AbiDYJbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:31:24 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D9C24BD2;
        Mon, 25 Apr 2022 02:28:19 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P5rMlb025856;
        Mon, 25 Apr 2022 11:28:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=xzfdAwXhD1J621ynPxY+pBpZRTwVQStxyQW8pm3u5eM=;
 b=PepbvLH3wmLSWRGwLGslXk/MZ0p4yUv0dUI4zB2YCjev5UScVwahoCeOYffB+bDoycs/
 9mkfo7DVLPtJ8j8o84Uwv9W5A+L4bnyUOI0yfQMtYM9PFyjlEPqE8uXSMJltB+Q6kPo+
 8c3qOyABQnmZl/zdPOUpcteayd+R8NdZRJMMarz3w8RQM0rwb1QcVDXlNwVSRx+pDwAh
 LQt2tvbGrcGrWBEjBoRoZWS/j+oJUpXTZg27RvuFWhSwVlFx4k5W+BLc22pAHVUQyx1c
 T9kg4aiivBmEAWwJz2CEpCzMhQs6jG7BNFESWz0ha4VKwhUWzFsgrI+P0ZGJW4h2Us51 1w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fm8t1fwq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 11:28:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 09B4D100038;
        Mon, 25 Apr 2022 11:28:04 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 351682171C1;
        Mon, 25 Apr 2022 11:28:04 +0200 (CEST)
Received: from [10.48.1.150] (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 25 Apr
 2022 11:28:03 +0200
Message-ID: <442677d2-7e9f-14f0-4b5a-1f98a8f40c8a@foss.st.com>
Date:   Mon, 25 Apr 2022 11:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] pinctrl: stm32: improve bank clocks management
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220422143608.226580-1-fabien.dessenne@foss.st.com>
 <c48500cd-50be-1d70-2f2c-02c2dcede1eb@denx.de>
From:   Fabien DESSENNE <fabien.dessenne@foss.st.com>
In-Reply-To: <c48500cd-50be-1d70-2f2c-02c2dcede1eb@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_05,2022-04-22_01,2022-02-23_01
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek


On 22/04/2022 18:26, Marek Vasut wrote:
> On 4/22/22 16:36, Fabien Dessenne wrote:
>> Instead of enabling/disabling the clock at each IO configuration update,
>> just keep the clock enabled from the probe.
>> This makes things simpler and more efficient (e.g. the time required to
>> toggle an output IO is drastically decreased) without significantly
>> increasing the power consumption.
> 
> [...]
> 
>>   static struct irq_domain *stm32_pctrl_get_irq_domain(struct 
>> device_node *np)
>> @@ -1575,6 +1537,10 @@ int stm32_pctl_probe(struct platform_device *pdev)
>>               ret = stm32_gpiolib_register_bank(pctl, child);
>>               if (ret) {
>>                   of_node_put(child);
>> +
>> +                for (i = 0; i < pctl->nbanks; i++)
>> +                    clk_disable_unprepare(pctl->banks[i].clk);
>> +
> 
> There are clk_bulk_*() functions, maybe you can use those to get rid of 
> these loops ?

This sounds goods, but checking more in details I see that moving to the 
'bulk' implementation would require to move the clk information from the 
"struct stm32_gpio_bank *banks" member to its parent "struct stm32_pinctrl".

This would make the clk device information stored in a different 
structure from the other device-related information (base address, reset 
control, ...). It's better to keep all those information together in the 
same struct.

As another drawback we would loose access to 'clk' from any function 
that have 'bank' (or 'struct gpio_chip *chip') as input parameter (e.g. 
stm32_gpio_get() called from gpiolib).

So I really prefer to keep the current implementation.

BR
Fabien

> 
> The rest looks good to me.
