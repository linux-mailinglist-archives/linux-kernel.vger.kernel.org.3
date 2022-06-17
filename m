Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F6154EEDB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 03:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379537AbiFQBfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 21:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiFQBf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 21:35:29 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2090.outbound.protection.outlook.com [40.92.99.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5406353D;
        Thu, 16 Jun 2022 18:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD4AiHiJkjPUuLz3VxPzW/QvDRs2WP8MlLwAi2UrmQLiZSl9qxDejd9Sk6UxJejtDiKdzmJAaduIQtzQ5DFzTydg0mQIxLEnRMWkr4xK439BNH9Hnz/Ia5XRWU7S0zKh99IplYJIzTUHrFxrb3Ul0gesCRFFi06RK3Q5VgdY5u14qhiKEbi7/eySVD7XWgB4M0/nl/f4yGSWT8uZANq6/oNwz5puhQ2n4pKfnKYDXpm9+0THdrCsJvjLqaYpdpjWUAvoNCGYeVsKtmLfH+SoA22Bgtb0D5OpJJfQg/DIR7AeGZbTzqM02snLfUCf9diWV/vdK1YwV4GcQ+X7E6mjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUv1U8cfmOo7QeZB0EcIRiwewtL8Pp8Vf80cdyEU/cc=;
 b=WKstzG1kR+8TrSCfkzn9OQv+He7srQ5MacHNq2m/EABqj6/Hsf7nLANKvFfWK6LCAbs9hpJn+AyXJGQ5H0oZbu2mRi9pyhnHpaIqvsxrj1vjS5yMendyaUOB950WVl5Mc0EFnhYOUY7HoNrEUCxybewOLZC/GWk6LSjbVcrLEJa2cN+WbXH+rv1uOf7ehoruqF3NE9K4NoNSOpXKBikUko7EVfHAs4SBZc7ABOTufcmtnQAWqtxsRfd5iibNvVQqsl8UVlMgdM1mUu4Tjn29DFOa3aOXOkRUQ+QcQkA/Bd0lCQGbDulrPwQDvgrPCDaRBRbMJd0FdDWkBuJCTvVVLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUv1U8cfmOo7QeZB0EcIRiwewtL8Pp8Vf80cdyEU/cc=;
 b=Bl3E+3m1WuqO/TnNT2vMlbVlxHa2cS5uAYyM2bIeAoe7xqxKI8T9XvV3NUKJPNrGd5Ps7QwXmtTMAYSjrD4lygCxgKuUTNJT2eFydHZW3MJikJe5Pm9LCsUTMJDjj7lRSpXy2htCNJWh/7C087wous0AIJQuvQ7UaxazhsCQLa/ZaVPPmTL/YO9BTrIBfE5VAytCQYITxniSRuK9L1Ki239nzuoFnTTBmI2tFmxiaOvMmA508IQkOT82Wd/yDWTuIm8emetTmo3ww5hTAPPG/F/1MX44JRATsw5T0BcNkbywFZlu7FkAzRtYywydD/sHdCVplno65S3yOWmqtoN+aQ==
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
 by OS3P286MB1158.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Fri, 17 Jun
 2022 01:35:23 +0000
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9cb3:323f:e99e:39c1]) by TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9cb3:323f:e99e:39c1%9]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 01:35:23 +0000
Message-ID: <TYWP286MB2601A179E1973C5B94E231CFB1AF9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
Date:   Fri, 17 Jun 2022 09:35:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] ACPI: Split out processor thermal register from ACPI
 PSS
Content-Language: en-US
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     rafael@kernel.org, lenb@kernel.org, rui.zhang@intel.com,
        robert.moore@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
References: <TYWP286MB2601DDBB0F472C876D36FBCCB1A69@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
 <877d5gpshb.fsf@stealth>
From:   Riwen Lu <luriwen@hotmail.com>
In-Reply-To: <877d5gpshb.fsf@stealth>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [HujEl7i1HZwMJ0Z7A8hdIAFLPrNMmdaY1Umsc/qR8Uk=]
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
X-Microsoft-Original-Message-ID: <bd110487-f6da-deb7-52a1-e8a89249f4a1@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9e9feeb-9569-4263-a1cf-08da5001a5e1
X-MS-TrafficTypeDiagnostic: OS3P286MB1158:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dCc/nDKrcbZ8Pxi4Y6DpznySImFiVGgz8kkeN7Vl/fw2XnX2R7vJw6wJmivacpO3/1Q43Ql/kyrv/HK/en3GWRU52gDF4CZz1nvedcuSrFVr3F+1y7NKomHbBojUp1TmZox4TB4zjbMfTOqw0bNhtPgnayvXcgLV3p0VJvs/eej+BAUvPcu8z8bd0VTbRi5NpxXsRu701adDlQ5fnDCx+3LBKgcOrg2XMWtfEtRK3oZN56SgDy8b8D+FS+Wln/HuTT47P1MJRU4yVwaYUfewouhnfdfSFt3X0CSbUb88C67FzhFGJcoIFqOWN3sJlqAGP431ATECuM4iTEmuyluwerd/FERFLXNk9JldSGDIZXOkg7tnNBeC1sX3xOIfxxis4fzkUYpnvoTmNPzuQGS90xzlJojcOcqOqSfDwW/sBVSYqG2G9zhU2xZMkOkzbdKK9JOUqP6VHHrHJVXAyu8hBwBeDtF1JnubMWSqpIu3tOCYImnvXPtxCZ6eqaadSSXY1Gz5RaUGzvECBv2TJb5B5OiZiCk/syFejEdUxJklBLea85RJVTRgIzVBcrdJYUv+F878bO5SGoZ6fgGr5vucQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djAveTJYNnNLdlk4RmZNdEFnaDZKZUpTQy9HNUxnTC82QWpYMTBmOGhGOTBU?=
 =?utf-8?B?OWhmNVlvc29EUVNHdktzRFdmdEpHaTFtV3Q3Zm9US0pVOXNzaGM0OUZzU0dn?=
 =?utf-8?B?aE5hSVAxSEhCR1Q2MzBINUxRVVhma0hkNHlzeWJEc3luWjI5Ky8zbURYVGF6?=
 =?utf-8?B?MUdOWHM0bzlIcXc3T0xFZFNNRUdVcmM4eHBtbThCYlhIMFFHNlBIbnZDekhn?=
 =?utf-8?B?NVgraW80ZUhEK1ZsMzZDNVFaWnZjcXhKclpNa3BINzVqT0VEL2tsblYwb2NJ?=
 =?utf-8?B?MVRsYzN2MmlWcm1udHBQUnBPKytzSlRmMndBa0l6OGwrTnNzT3VKckxGMHhs?=
 =?utf-8?B?dGhPL1ZrNWpBcHpabTFUdkdZcjFGZzJnWnR1RURzVGtEaVIzRnJyaHgzakVY?=
 =?utf-8?B?bzR2dkJudVphT09HNzBuT1ZGcXJBZy9sVmtzbUo3Vlk3SDh0aVJHUDFwaDZk?=
 =?utf-8?B?L0IyVGxEejBERGNPSXlEWnBQSEhsS3pjbU9LM3BCZUpzcUlHM0ZmTzNWcnhi?=
 =?utf-8?B?cUtrcTRnV2xpalVubzlEVVBSUHBSWFVXV20xcDdWYTdJSERzYWx4aHgvSDNR?=
 =?utf-8?B?eEtYNkt3d1J4U0l5VjJwNFlrR0UwUDNCM3pxRC9NU1UwWnRGdmV5Sy9GajM5?=
 =?utf-8?B?RUdBdHY1UW9PNlNUUWp6SjlmeFRReTR6Yi8xUUZNTXF4TC9HY1NpKzFDVmV2?=
 =?utf-8?B?ZFJoSTl2NHZHZ3hzaytHbDNTdXp1U0dzV09CR1loNU9aVjNQdk1FR2VkOUN4?=
 =?utf-8?B?SUE0Ujg2SVZlVlN4UnpqYUV6emk3QW80b2kzWDNud1hVOTBpcGhsSkhtazdy?=
 =?utf-8?B?dDdjalFsTlNadEZHWDhodTJyV0Q4UTJnVnVxTU1CcW5RTFJYM1JITzN5Z3Fj?=
 =?utf-8?B?eHBYZUNKdlVDQWwvVVFyWnlXWUkvVmVSS1BDYW5LV0h3d2tvTE5sZlhTZ0tN?=
 =?utf-8?B?bExpVVFZMlJhWUVkZEdRTHdUTERPV0NLSWUxNy9OWmxWYlRBcHpueEpLLzRK?=
 =?utf-8?B?Uk5JVTVVVENNTU94bCtFbCtja1FUZ1VpbzhFbno5QXZuK1ZnZzFDMnVWQ3VX?=
 =?utf-8?B?LzM2c2RqekJLTkRDZWtPNVF0QVBDRFV0QWd4ZFJ6YWZQd3hTT3ZZUHNDWWxm?=
 =?utf-8?B?dUxFQUhLRDlGMEtlQVVXYWcwdGR4V0hGVXdDN01WaUR1TkIrUTk1N0Rha3Zo?=
 =?utf-8?B?MXFUVXhTVzdtN05KSFB1SXVsUXA4dlUrSDBaSnZpT3RRd1lrYUtwbFhkT1BX?=
 =?utf-8?B?cHdoNTJMYzNRdStpdVA3SjcyYlRyc1AzblAvVUNvTnRFNlVxRGxJZjNmWVFO?=
 =?utf-8?B?Qm5PZ1NkRTQ1S0tuT0tWaS9oZ2NiVld2UVc0eGhFTERpbEdRcE05dWNGSktL?=
 =?utf-8?B?VDFWc1hmWEU0WW1KVlJWemd3VGw3M3c5aGIrYkdDc0hyeW51enJDWDRybXJv?=
 =?utf-8?B?NC9uNkZ0ZjBNcWw3Q0R6QTFjL3ZtYXRHbksyYVJRSDlVWm9mMW9BOGIwNzZT?=
 =?utf-8?B?eTIwSWVoRkszR2FvZU4zem9WeG96cWRmdDkrVi9ZWk9xVEpZMDZiSWNiWDM2?=
 =?utf-8?B?UkRreFJ2QVBpZ2Zsd2FLcERHUnIxamZpWTY5WVRWQUhNTm5yV2Z1Z0h2YS9y?=
 =?utf-8?B?ZlJkSnhGejhnb3J3UjBTZkNOVFdEUFA0bkNRM0F3akNvckd1cm9GeXJiVnNx?=
 =?utf-8?B?eUViUDJjcFU3RDNoSkJONkN3U0YzTHdSM0JIYUI2ZENHRmJZOXhlMnBJRytu?=
 =?utf-8?B?eTV4MFdDZXNSb2E2ZWp4dWhUU3FxMUJUM001NkdSTlNYaCt5WUNIR3oxamNz?=
 =?utf-8?B?d3JlamM5b3djWkltSmw4MVc2aVhCaE1zNmUyS3ByNTlIelErOHp4WDBpMktz?=
 =?utf-8?B?NC9JaktjNnowSjE3dXpxNjU0UWptMVZaV2xYbU56TStsV3lGRzNtMjJvYjkz?=
 =?utf-8?Q?wH8jj8c/PpM=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e9feeb-9569-4263-a1cf-08da5001a5e1
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 01:35:23.6125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1158
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/6/16 22:56, Punit Agrawal 写道:
> Hi Riwen,
> 
> Usually it's a good practice to Cc anybody who has commented on previous
> versions. It makes it easier to follow your updates.
Hi Punit,

Sorry. I wanted to Cc to you, but I forgot it. I'll make the patch a v3 
version and Cc you.

Thanks!
> 
> A couple of comments below.
> 
> Riwen Lu <luriwen@hotmail.com> writes:
> 
>> From: Riwen Lu <luriwen@kylinos.cn>
>>
>> Commit 239708a3af44 ("ACPI: Split out ACPI PSS from ACPI Processor
>> driver"), moves processor thermal registration to acpi_pss_perf_init(),
>> which doesn't get executed if ACPI_CPU_FREQ_PSS is not enabled.
>>
>> As ARM64 supports P-states using CPPC, it should be possible to also
>> support processor passive cooling even if PSS is not enabled. Split
>> out the processor thermal cooling register from ACPI PSS to support
>> this, and move it into a separate function in processor_thermal.c.
>>
>> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>> ---
>>   drivers/acpi/Kconfig             |  2 +-
>>   drivers/acpi/Makefile            |  5 +--
>>   drivers/acpi/processor_driver.c  | 72 ++++----------------------------
>>   drivers/acpi/processor_thermal.c | 69 ++++++++++++++++++++++++++++++
>>   include/acpi/processor.h         |  6 ++-
>>   5 files changed, 84 insertions(+), 70 deletions(-)
>>
> 
> [...]
> 
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
> 
> [...]
> 
>> @@ -239,7 +183,7 @@ static int __acpi_processor_start(struct acpi_device *device)
>>   		return 0;
>>   
>>   	result = -ENODEV;
>> -	acpi_pss_perf_exit(pr, device);
>> +	acpi_processor_thermal_exit(pr);
>>   
>>   err_power_exit:
>>   	acpi_processor_power_exit(pr);
>> @@ -277,10 +221,10 @@ static int acpi_processor_stop(struct device *dev)
>>   		return 0;
>>   	acpi_processor_power_exit(pr);
>>   
>> -	acpi_pss_perf_exit(pr, device);
>> -
>>   	acpi_cppc_processor_exit(pr);
>>   
>> +	acpi_processor_thermal_exit(pr);
>> +
>>   	return 0;
>>   }
>>   
>> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
>> index d8b2dfcd59b5..93928db2ae5f 100644
>> --- a/drivers/acpi/processor_thermal.c
>> +++ b/drivers/acpi/processor_thermal.c
>> @@ -266,3 +266,72 @@ const struct thermal_cooling_device_ops processor_cooling_ops = {
>>   	.get_cur_state = processor_get_cur_state,
>>   	.set_cur_state = processor_set_cur_state,
>>   };
>> +
>> +int acpi_processor_thermal_init(struct acpi_processor *pr)
>> +{
>> +	struct acpi_device *device;
>> +	int result = 0;
>> +
>> +	if (!pr)
>> +		return -ENODEV;
> 
> What's the reason for this check? When will "pr" be NULL in this code
> path?
> 
I was thinking the function might be called somewhere else. It seems to 
be meaningless.
>> +
>> +	device = acpi_fetch_acpi_dev(pr->handle);
>> +	if (!device)
>> +		return -ENODEV;
> 
> Wouldn't it be better to pass the acpi_device into the function as well?
> The device is already available in the caller and it'll avoid having to
> convert it back.
> 
The same reason as above, and I'll modify it.
>> +
>> +	pr->cdev = thermal_cooling_device_register("Processor", device,
>> +						   &processor_cooling_ops);
>> +	if (IS_ERR(pr->cdev)) {
>> +		result = PTR_ERR(pr->cdev);
>> +		return result;
>> +	}
>> +
>> +	dev_dbg(&device->dev, "registered as cooling_device%d\n",
>> +		pr->cdev->id);
>> +
>> +	result = sysfs_create_link(&device->dev.kobj,
>> +				   &pr->cdev->device.kobj,
>> +				   "thermal_cooling");
>> +	if (result) {
>> +		dev_err(&device->dev,
>> +			"Failed to create sysfs link 'thermal_cooling'\n");
>> +		goto err_thermal_unregister;
>> +	}
>> +
>> +	result = sysfs_create_link(&pr->cdev->device.kobj,
>> +				   &device->dev.kobj,
>> +				   "device");
>> +	if (result) {
>> +		dev_err(&pr->cdev->device,
>> +			"Failed to create sysfs link 'device'\n");
>> +		goto err_remove_sysfs_thermal;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_remove_sysfs_thermal:
>> +	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
>> +err_thermal_unregister:
>> +	thermal_cooling_device_unregister(pr->cdev);
>> +
>> +	return result;
>> +}
>> +
>> +void acpi_processor_thermal_exit(struct acpi_processor *pr)
>> +{
>> +	struct acpi_device *device;
>> +
>> +	if (!pr)
>> +		return;
>> +
>> +	device = acpi_fetch_acpi_dev(pr->handle);
>> +	if (!device)
>> +		return;
> 
> The same comment about passing the acpi_device structure applies here as
> well.
> 
>> +
>> +	if (pr->cdev) {
>> +		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
>> +		sysfs_remove_link(&pr->cdev->device.kobj, "device");
>> +		thermal_cooling_device_unregister(pr->cdev);
>> +		pr->cdev = NULL;
>> +	}
>> +}
> 
> [...]

