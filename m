Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218AB56FFFB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiGKLQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiGKLQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:16:20 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2A86113C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657535854; x=1689071854;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l241aSfbDFRaiDAjISjeppEbmJl16Z4pyYiIsz0YFbE=;
  b=VkV/KGMebLaeHup66sBVdBpwXYbpNKvEkIMQdBsXo9R4RqhkJ+w1XMKI
   PJMizEWGVWs+DLUm3H5qtOiEt0gkyB9P9qFumZ4WfF5FFfgX0UZroE5UR
   BLo0QMcPK2MRA5EAMkjMw5AYaTgE0o9kLbNz0FZN9Vd0vszWPJ41kz86l
   I45c/TMb5m55qMbGAt1FKad9FEg7OsYP0wCsDcJAfbaLu2k2Gaj7Fhm85
   zrs/V+es6FhiEsPuubjKyE6NU+InOuuSMjfm9dDoOp+CQUwXcNiFPkIIR
   /WA6EGICYW57MBJEIgda803s9diyUNez2PNkOmLXNgVhtP0a7fb1/erMX
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650902400"; 
   d="scan'208";a="206061598"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2022 18:37:27 +0800
IronPort-SDR: I07Sj9qOJ4r/Q+JE1CXT1BPpFMIE+Nhrt19LDeZKxJSlVQWerrnFRicTyWUHfy/nI3WuDldWQD
 wfqRqn9Wnmeyvpm9gASk/kkxJICQFlZWogMOPJldYTOpurxBwNsRKoIBjk+ZARDmY3j3PNzl2K
 DxAeQtM5QuEPRSDePJ/vgGKCDylZoDF6IUS1ipo+kS6mIH44vKg+m6T93ApMyzlfplSNuXG3CP
 ade7kgVYwqK1w/xj57++JEoeqnS6ykiw+3rivEtBTQ3VPiRLFRRiVl5eJS/6rhnG1ZIB7SxhpR
 MlZWUnO0Tf/zCDkg+3q2lfXQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jul 2022 02:54:24 -0700
IronPort-SDR: nNx6+4ztC7iBa7AgpsaNc8UxZC3japtZvzRpO7VUTO/dtX6JMjOjSHF0wFr5hMVMsvI/dgaQUu
 k1DpAy4nIdnrxsDS2pYeBOa9l40H4suxjcfA789pfccEsWbHPFn4juf9/fDLQQISFcveRDnFmI
 uxINPs4YfCpSZk4kYAfaTKlE6DiRaMF7ac9zPDFyB6DA8i8SKKimrTTu+kCoLOGmgwfwkr76Q6
 bwI70lwXjo0JikfKKWboqHCuH+1hTLxn60rc7sAAgz51/WNiwGbNXLxYlj3R4IHZsgHTErQrBu
 HTk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jul 2022 03:37:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LhL1K24m5z1Rws4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:37:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1657535844; x=1660127845; bh=l241aSfbDFRaiDAjISjeppEbmJl16Z4pyYi
        Isz0YFbE=; b=uFBmKrHjttS09rjyYPK/rWRNlserCH7Fpv/TDJoTiwzYVmWloQi
        PVIhIqnOgtRUKeM0+aoWSoNE2x+hQYZ140t4lw6a9KBBrffhcq5AZlBkMPgIJOab
        bAHX7HEu1mq9Jjp1reN78LwIYAFuc62GQCf9yemrYf6QPmpLCYKLAIMEOKAWwI2t
        OjLdP32uWdq3NI+QRrvd0OOEG8zRoOaRw3Wsf6X3RVxlqXpjsU+Sxll1OZ3DZocs
        /gJyw0WDv6Gg8LEHgSKJi6ul5VEUDPy+3E5BkuaKjxrJV8D9E+G9PdSm/iNs/9Kc
        8wezbkC9ewLap0M85vUvvLKqiK8DkY58aqg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7yUbzRbXRsfO for <linux-kernel@vger.kernel.org>;
        Mon, 11 Jul 2022 03:37:24 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LhL1F1m4vz1RtVk;
        Mon, 11 Jul 2022 03:37:21 -0700 (PDT)
Message-ID: <e8f91504-2b2d-76b9-cfe3-8f027824854f@opensource.wdc.com>
Date:   Mon, 11 Jul 2022 19:37:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 25/33] ata/drivers/ahci_imx: Switch to new of thermal
 API
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linexp.org>, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-26-daniel.lezcano@linexp.org>
 <a424890d-8647-48c5-68ab-742a95bb6865@opensource.wdc.com>
 <e50842cf-0179-7b70-3925-dacb4ce728ea@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e50842cf-0179-7b70-3925-dacb4ce728ea@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/22 18:14, Daniel Lezcano wrote:
> On 11/07/2022 01:18, Damien Le Moal wrote:
>> On 7/11/22 06:24, Daniel Lezcano wrote:
>>> The thermal OF code has a new API allowing to migrate the OF
>>> initialization to a simpler approach.
>>>
>>> Use this new API.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
>>> ---
>>>   drivers/ata/ahci_imx.c | 15 ++++++++++-----
>>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
>>> index 79aa9f285312..5ad9a890e71a 100644
>>> --- a/drivers/ata/ahci_imx.c
>>> +++ b/drivers/ata/ahci_imx.c
>>> @@ -327,7 +327,7 @@ static int read_adc_sum(void *dev, u16 rtune_ctl_reg, void __iomem * mmio)
>>>   }
>>>   
>>>   /* SATA AHCI temperature monitor */
>>> -static int sata_ahci_read_temperature(void *dev, int *temp)
>>> +static int __sata_ahci_read_temperature(void *dev, int *temp)
>>>   {
>>>   	u16 mpll_test_reg, rtune_ctl_reg, dac_ctl_reg, read_sum;
>>>   	u32 str1, str2, str3, str4;
>>> @@ -416,6 +416,11 @@ static int sata_ahci_read_temperature(void *dev, int *temp)
>>>   	return 0;
>>>   }
>>>   
>>> +static int sata_ahci_read_temperature(struct thermal_zone_device *tz, int *temp)
>>> +{
>>> +	return __sata_ahci_read_temperature(tz->devdata, temp);
>>> +}
>>> +
>>>   static ssize_t sata_ahci_show_temp(struct device *dev,
>>>   				   struct device_attribute *da,
>>>   				   char *buf)
>>> @@ -423,14 +428,14 @@ static ssize_t sata_ahci_show_temp(struct device *dev,
>>>   	unsigned int temp = 0;
>>>   	int err;
>>>   
>>> -	err = sata_ahci_read_temperature(dev, &temp);
>>> +	err = __sata_ahci_read_temperature(dev, &temp);
>>>   	if (err < 0)
>>>   		return err;
>>>   
>>>   	return sprintf(buf, "%u\n", temp);
>>>   }
>>
>> I do not see why the above changes are necessary. Please explain.
> 
> sata_ahci_read_temperature() is used by sata_ahci_show_temp() also.
> 
> So in order to change the function prototype for the get_temp ops which 
> does not take a void* but a thermal_zone_device* structure, this 
> function wraps the call.
> 
> Do you prefer sata_ahci_read_temperature() becomes sata_ahci_get_temp() 
> and keep __sata_ahci_read_temperature() name untouched ?

Understood. You can keep the name changes you have, but please add this
explanation to the commit message.

> 
>>>   
>>> -static const struct thermal_zone_of_device_ops fsl_sata_ahci_of_thermal_ops = {
>>> +static struct thermal_zone_device_ops fsl_sata_ahci_of_thermal_ops = {
>>
>> Why remove the const ?
>>
>>>   	.get_temp = sata_ahci_read_temperature,
>>>   };
>>>   
>>> @@ -1131,8 +1136,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
>>>   			ret = PTR_ERR(hwmon_dev);
>>>   			goto disable_clk;
>>>   		}
>>> -		devm_thermal_zone_of_sensor_register(hwmon_dev, 0, hwmon_dev,
>>> -					     &fsl_sata_ahci_of_thermal_ops);
>>> +		devm_thermal_of_zone_register(hwmon_dev, 0, hwmon_dev,
>>> +					      &fsl_sata_ahci_of_thermal_ops);
>>
>> This is the only change that seems necessary.
>>
>>>   		dev_info(dev, "%s: sensor 'sata_ahci'\n", dev_name(hwmon_dev));
>>>   	}
>>>   
>>
>> And it is hard to review a patch without the full series for context.
>> Please send all patches next time.
>>
>>
> 
> 


-- 
Damien Le Moal
Western Digital Research
