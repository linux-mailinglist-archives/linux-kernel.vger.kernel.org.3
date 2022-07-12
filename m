Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947E557167D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiGLKDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiGLKCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:02:44 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C6EAB6B1;
        Tue, 12 Jul 2022 03:02:31 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26C6WEvi008293;
        Tue, 12 Jul 2022 12:01:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=KF13UsJuH9FTtje1DJFmMEELOXum2Enp56A8RtBO74Q=;
 b=y3QVFV/Clt6H73yNNAmt4XtFzYhzmyrkIsngLxHSJPAux3x5gl9pUMf340CnWYX6tF6s
 0QpU/WhbKk7SO5f7bDQ3ZM88l8EHneQbPJ62W9zq5GxPwebEbHFfd7N18IJHZNoSuGAa
 dD85chRFEIDcaUbwjBarZ+M30Y6L7zyaPuZKa7lrVAqBvJGVkpIAYO7s9RazCUs7USqD
 av+DDenbFbqxcLH8+Gy5ixad1brgEDLB0OMCi9OlJCnaUs8xiTOlsDHme868I4nQ6O4t
 3Xx5fBvzvu8uu5d8u//dTtnYXWAV+lHzsEmC+VMCC7/8nHUGdKviPBneZO6Lg/yXKF+M ZQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h71128h8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 12:01:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 910C610002A;
        Tue, 12 Jul 2022 12:01:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 670BB216EDB;
        Tue, 12 Jul 2022 12:01:37 +0200 (CEST)
Received: from [10.48.1.102] (10.75.127.49) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 12 Jul
 2022 12:01:35 +0200
Message-ID: <51369b07-dade-7b56-bc9c-bc21b161916e@foss.st.com>
Date:   Tue, 12 Jul 2022 12:01:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/4] usb: typec: ucsi: stm32g0: add support for power
 management
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <christophe.jaillet@wanadoo.fr>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>
References: <20220711120122.25804-1-fabrice.gasnier@foss.st.com>
 <20220711120122.25804-5-fabrice.gasnier@foss.st.com>
 <Ys03QgD0aIF1Zl9R@kuha.fi.intel.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <Ys03QgD0aIF1Zl9R@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_05,2022-07-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 10:56, Heikki Krogerus wrote:
> Hi,
> 
> Mon, Jul 11, 2022 at 02:01:22PM +0200, Fabrice Gasnier kirjoitti:
>> Type-C connector can be used as a wakeup source (typically to detect
>> changes on the port, attach or detach...).
>> Add suspend / resume routines to enable wake irqs, and signal a wakeup
>> event in case the IRQ has fired while in suspend.
>> The i2c core is doing the necessary initialization when the "wakeup-source"
>> flag is provided.
>> Note: the interrupt handler shouldn't be called before the i2c bus resumes.
>> So, the interrupts are disabled during suspend period, and re-enabled
>> upon resume, to avoid i2c transfer while suspended, from the irq handler.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> 
> Does this really need a separate patch? Does the support depend on the
> second patch somehow?

Hi Heikki,

There's no dependency. I did a separate patch mainly to ease the review.

> 
> If not, then just merge this into the first patch. That
> g0->in_bootloader check you can add in the second patch.

Ok, I'll merge this into the first patches as you suggest, and add your
Acked-by.

Thanks for reviewing,
Best Regards,
Fabrice

> 
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
>> ---
>>  drivers/usb/typec/ucsi/ucsi_stm32g0.c | 52 +++++++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>
>> diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
>> index b1d891c9a92c0..061551d464f12 100644
>> --- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
>> +++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
>> @@ -66,6 +66,8 @@ struct ucsi_stm32g0 {
>>  	unsigned long flags;
>>  	const char *fw_name;
>>  	struct ucsi *ucsi;
>> +	bool suspended;
>> +	bool wakeup_event;
>>  };
>>  
>>  /*
>> @@ -416,6 +418,9 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
>>  	u32 cci;
>>  	int ret;
>>  
>> +	if (g0->suspended)
>> +		g0->wakeup_event = true;
>> +
>>  	ret = ucsi_stm32g0_read(g0->ucsi, UCSI_CCI, &cci, sizeof(cci));
>>  	if (ret)
>>  		return IRQ_NONE;
>> @@ -696,6 +701,52 @@ static int ucsi_stm32g0_remove(struct i2c_client *client)
>>  	return 0;
>>  }
>>  
>> +static int ucsi_stm32g0_suspend(struct device *dev)
>> +{
>> +	struct ucsi_stm32g0 *g0 = dev_get_drvdata(dev);
>> +	struct i2c_client *client = g0->client;
>> +
>> +	if (g0->in_bootloader)
>> +		return 0;
>> +
>> +	/* Keep the interrupt disabled until the i2c bus has been resumed */
>> +	disable_irq(client->irq);
>> +
>> +	g0->suspended = true;
>> +	g0->wakeup_event = false;
>> +
>> +	if (device_may_wakeup(dev) || device_wakeup_path(dev))
>> +		enable_irq_wake(client->irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ucsi_stm32g0_resume(struct device *dev)
>> +{
>> +	struct ucsi_stm32g0 *g0 = dev_get_drvdata(dev);
>> +	struct i2c_client *client = g0->client;
>> +
>> +	if (g0->in_bootloader)
>> +		return 0;
>> +
>> +	if (device_may_wakeup(dev) || device_wakeup_path(dev))
>> +		disable_irq_wake(client->irq);
>> +
>> +	enable_irq(client->irq);
>> +
>> +	/* Enforce any pending handler gets called to signal a wakeup_event */
>> +	synchronize_irq(client->irq);
>> +
>> +	if (g0->wakeup_event)
>> +		pm_wakeup_event(g0->dev, 0);
>> +
>> +	g0->suspended = false;
>> +
>> +	return 0;
>> +}
>> +
>> +static DEFINE_SIMPLE_DEV_PM_OPS(ucsi_stm32g0_pm_ops, ucsi_stm32g0_suspend, ucsi_stm32g0_resume);
>> +
>>  static const struct of_device_id __maybe_unused ucsi_stm32g0_typec_of_match[] = {
>>  	{ .compatible = "st,stm32g0-typec" },
>>  	{},
>> @@ -712,6 +763,7 @@ static struct i2c_driver ucsi_stm32g0_i2c_driver = {
>>  	.driver = {
>>  		.name = "ucsi-stm32g0-i2c",
>>  		.of_match_table = of_match_ptr(ucsi_stm32g0_typec_of_match),
>> +		.pm = pm_sleep_ptr(&ucsi_stm32g0_pm_ops),
>>  	},
>>  	.probe = ucsi_stm32g0_probe,
>>  	.remove = ucsi_stm32g0_remove,
>> -- 
>> 2.25.1
> 
