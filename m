Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71596520FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbiEJIaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbiEJIaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:30:07 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2101.outbound.protection.outlook.com [40.107.117.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333A7220D9;
        Tue, 10 May 2022 01:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeQJRbgQ0b3YSyDGlFwCmO/z6fcit/p2CkvwD4YRoenqA4daqEZToacfAqxgOHP+PvFxBefUXKVHcQAS1KsAEx1fCuxWFpL6FGfbmJVYh4xlbmYjILGjnWE+WIsmcwA4uAYgELTh5Xw3fLvrtfStHhxHnJ0ocxN1puOKswYGZnx0fCZy0kGpkTsZHIiH9utd13tbPdqPoISsdi/t0YYSusKxe04S0b77o3tWTu9cNNUXG4gMx9Buei4eQsn3HDKTQLVr5kLr4cwTxTaxSyTCp61EsbHf1caIV9/DS1h3sp8VrJZpy4e/qIe6mUhpBZVZlF0L73aVcYV4NRGHoFLZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knkxT1M2h6JzFJrJl6pTr9vsHrZv6/y7t97q9o6FSAo=;
 b=IQTnuDVtL47AEri5TOJUvajLUtUO7Ivv0aQZTJipZEDCN1r32ujLtWg5pzOQ8Rw5/2Ev4dnaG4lFBkr7u1W8ew/vYM+plXyDudCpgX1Q6afloeT4cJs6mnFAp6B+KHNBp3anTWTo4GIxBQ+gPDfdcD+qqH6GZ3rslIdB6lnPq0nQuJ0lz13gk9om4X4aEnzSqUGpZ9eNq8jWNEyo5HGyCKt4saoMAGG9k3vWjZemRHKbtoQzdc5gkbdnWa7mp50KpWya7I/gQyk25ZwXRJ1OMv0TXbZhYzB1d9Z+j0nJD8NunNGHOXCu+qmHyBrgoImrZFDV9Ds8H7dAtQXyC0wxvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knkxT1M2h6JzFJrJl6pTr9vsHrZv6/y7t97q9o6FSAo=;
 b=IKvNnUHZnzjYa0FjSSbWWbQGc7Rp7RPYDzYJJNMIpixr8+MvpMQCnvk8WSUv6j3df0X5TpZI3nR4/4Ess1MuJkNQmaJWK1/E5r0ucwA4A0DXnmeoAJnzlCjrX7P2pwwA1pXsK/McWmfco4Fd+u/0ZYp+ZFvJl3gFvMHmQ405W30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TY2PR06MB3359.apcprd06.prod.outlook.com (2603:1096:404:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 08:26:07 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5227.022; Tue, 10 May 2022
 08:26:07 +0000
Message-ID: <61a4b23f-9740-6fb4-abd0-640d3353e788@vivo.com>
Date:   Tue, 10 May 2022 16:26:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] cpufreq: mediatek: Fix potential deadlock problem in
 mtk_cpufreq_set_target
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220510080136.11950-1-wanjiabing@vivo.com>
 <20220510081232.4u25qgryszzqblho@vireshk-i7>
From:   Jiabing Wan <wanjiabing@vivo.com>
Organization: vivo
In-Reply-To: <20220510081232.4u25qgryszzqblho@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR04CA0071.apcprd04.prod.outlook.com
 (2603:1096:202:15::15) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa246d00-83ef-4295-6e24-08da325ebac6
X-MS-TrafficTypeDiagnostic: TY2PR06MB3359:EE_
X-Microsoft-Antispam-PRVS: <TY2PR06MB3359676489AE13ADD79F5FA2ABC99@TY2PR06MB3359.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0Ht0tJ5b/je0u24xyILutPusg5V+ua+SgVJioF9rsDqnwVa9M3RsPKl/yETn0LKdQ8nuLZokh1GJdLzoAU05Eeon/X47OivCGlwDru5jMs1SBDqHpwgDDzsZKUTHYySjmfZ5shnj550dCp5hCxuzKaT3BaUH1El/8yY9VgHrXotdFe0KAXWSZMxlXP2JJUi7ruwWuZkn4v+jKt0o5rj+0sn31+ON1f3ONcm1WuLeZjsDYGnqZVetctHB2Vi3cDEscdJPRzf+omn/9iTMtOpOHLKBqZYiqhs+nN5Cj0DAmEJPLUDskLikGQefKw8WEya9HpeIUzXts3rkLb7Y1XhUGJBGA4vNTlHc2OxGngqatIZNddCux5ZHIeOcapKTOUp/l2vHBsu+etPeZcNl/jbJ9WZEitIdgET61Hh+aXOLQqFSvGcBGWl+q6l1QelW7GcBePTgbogZbEZj+7aDGx9sw6HUOwa7mUGQxz4RtYpiFtQzA0VEP2CuX5CdfvUqP45kq9b5/GaqwjIY+iZbh8RkEbCa2xDDDi3jGg6QGpg6ewsqr4qC0ptEflv+vcSslGHxzXQLDcC89K6XFTo7m3p42AaTKqBtlCBxT1yyoyBWg8+YGPZakV1LXIi79wQgxj1weZ0p+bfGf+DZGYOaTmNd6CauEW1mi+Lqo9kyZhqLXsyYtrYv2RDCnHD0/jKyRUVcWafVIgGLOCWvBJ2PxdcCh596VEsZ/+nBdpxNp6+kd61VaSpkYMd5ZRPiBREryLFlI69w5AkbvmfzFwEKHPwLN1OtctajvtHatULzyUu2wc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(38350700002)(36756003)(53546011)(86362001)(6506007)(2616005)(38100700002)(66476007)(36916002)(66556008)(52116002)(54906003)(66946007)(6666004)(316002)(6916009)(4326008)(8676002)(2906002)(508600001)(83380400001)(6486002)(31696002)(49246003)(5660300002)(7416002)(6512007)(26005)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnJ2dm1OcG1nRlFpa3d2WVBISllxU0w2ZTcwSExzWCtZN3V2S24wbml5d3NU?=
 =?utf-8?B?NWZFVnd6ZG5RYnRsUkxOb0lEUkNraThLVmhGYjJXYVZFQ1YzL01JNjhVWjRF?=
 =?utf-8?B?dWJkcUpZVVNwY0NXY1VtZ1o3NDBOWk1FOUpKUlVGU1ZjQzd2T0FvRUwycWM5?=
 =?utf-8?B?Z1h0ZVVrVGw1WDJYRUlwcWRoTzQzZGc5c2ZkRk85cnBlU1dKSENYYXlyRXRz?=
 =?utf-8?B?RUF6TVlzSGIrODEyRWNlcFNIelczUXJSdStBNjR6RVpuOTJCZVJNUlg0U1ow?=
 =?utf-8?B?VzdwbEFOUFE0UzVOYnB1OERwZkZHUlRoOXU5NHlMQVBxL3ZwbFFKajJMZ0xy?=
 =?utf-8?B?QzJMMjBTZHVhWTF2S2YvRWxqK0MwYVNjRmUvaUVoSlFGdTZGdGRUVTVIbjlw?=
 =?utf-8?B?K2FWa01DM3IvVzljLzRDWEt2QVJKYjVnekNIOGIzQk8rSVVHb2RnYUV4QkxQ?=
 =?utf-8?B?WUtFTnZDMkZIUnRGTXR0RWhEcE95Y1JuYllDRjcyZDluRzZjeXJqOHVSMFVE?=
 =?utf-8?B?YUowM2tqNFZBbnVLRHlpcURDcnh1c1p1ZnFoamRESTkzRW5JNCsyQkRiRmgw?=
 =?utf-8?B?MmNLNERMUWFVS2lRVHNEMUd1RndRNVNRZS81a2haVm9pUk5kdmFiSXA2VSto?=
 =?utf-8?B?a0lWWWR0LzRQY2VFR1lsWkxPdHFqVnB4MDJTeFFWMWEzeTVGMFJnREo0bldo?=
 =?utf-8?B?NUxOUmJpZW84STcxV0tpemxEcXlWOGRFb3UvSDd1UURuVisyYzZGY2ljY0x6?=
 =?utf-8?B?ZVgyOUltaHZ1a0d5T0JmZzNwNm82MUNwWFlIRUxRdEM4WGtRKzVsR1g3bjZm?=
 =?utf-8?B?dHljaFFCclJIb3pjYnUzNUFKZ2ZaelpjRFE5YTU2eXA5QThza09SWUVrL2l1?=
 =?utf-8?B?UFg1c2h4MzllUHdsWHRXQjk4b0h6UnlpMWVKYkl2VUN2Y29mejkwWk91NXd1?=
 =?utf-8?B?OS9EZFhiTEkzQVlLUnRjTFNUbnJPd25SN1hGZTlPbDZOZGhtYytvY2F0TkVs?=
 =?utf-8?B?NjFYYjVrNlQ4T3F1TjNIQzgxQ29zVW1NN2FrK1ZRUjJyVGFKM1E1NTJGVWN6?=
 =?utf-8?B?b2Y1UURNQ053WFdNbnBzam01NTZwQVpQNEdRYVdBaXlOeTVXVGtJU3E4VDFW?=
 =?utf-8?B?Nzk2RHZ4L1FDVWVDMXh3YTNlSFEzOWdyY1NOWEtGSVprMXpQdVdjS0c0dGRa?=
 =?utf-8?B?VkFvQTZZdnpvTFppaXNJNUx6d2RnK0pyV2RGWHdvUVhZTWtZOVcrZHBjQVp0?=
 =?utf-8?B?SFZuUEVONm1PYmRJbkdCRktyNk8vOXpjQ3ZkNk1haEUyWVRwNVBqUEY4WG9w?=
 =?utf-8?B?SHgzU0o5V1VyZDk0QVRRSHh1cElPL2d3V2dYd1ZLNENva01XR1p6MzhhNHV2?=
 =?utf-8?B?cXpaZENJc0gvelowMWdNQXpGREtXeWJFeHpKaVRwQThRbXdFWVhkbkg5YTBB?=
 =?utf-8?B?VzYrMWJqUVlhNHowem5EQ3NLZ2swNitwWVRQRHU5SjFQSkFDeEtISXhQS2xy?=
 =?utf-8?B?N2t4ZERyY0pJTGhWYjZtZUc0Qm5qYkZEOGtMaEhqWEVXSHErUVF1RHNCemdz?=
 =?utf-8?B?R1cyWlV5K1BBSkZyTkpKYU9OVXppUDBVWURIeFdrZXp6UVNvWXcxVHAyRTJj?=
 =?utf-8?B?SlZlby9vcmN3K21QemszcGJXdGo3ZmZVeWZqbDI4TldhcXRCYld6N1FxQ0Jk?=
 =?utf-8?B?MUpQbHo3M0s4WENGN0VOMENHdGE0VU9jZlpLcGt2VXQrdGVZMnpmY2FQakUw?=
 =?utf-8?B?dDRYbk1iSGliQnVCRytLdCtYY1dIbHhWaVJwUmVFYW82UUFnR0c5dmt5WUxu?=
 =?utf-8?B?ZGxUVzhTMzNFMEM0WlVLVWhtbTR0amEvMENRNzB2M3dFbDI1azM1dHFSMDJl?=
 =?utf-8?B?RFBoeUZHNVJ6Vlp3aUQwcWlkbEJjRHZnVzVjUVdjaWdkWU9wU2hrcjR5OUpM?=
 =?utf-8?B?aUdOQUEweG8wRkNNbTIzMVpoWGRZU2lwUURYVmtLbjQrNEhQTmU4VHZqUE9L?=
 =?utf-8?B?T25QZEJEeFUzT3JJbFVLdm4rNTFVZ1ZIdmJsZU1Pc3FLbjFMOVNqTnZXSit3?=
 =?utf-8?B?SFpubjJncDZuc3FjN2s5Tk1rS0ZXK1pTeVQ4eVAzNk15ZnVVUVhkU3M0cjdj?=
 =?utf-8?B?N0dKMFlkTGI4UkVobVI1aGgyWUZ2RFk4OTRKTU9rT040Q1hiek95R1FZcnpX?=
 =?utf-8?B?eTBKVVMwSk55Zml4OHhoem9KSmlUOGk2QnhSbW9jWmMzajBhMVpNMHVSSDJu?=
 =?utf-8?B?L0Z6TkI4Rnp0b1luOWNwVUJONStqMEFXTlhxMm1vU3U2ZzhBeWNUYWJjQjJ6?=
 =?utf-8?B?TFAzalVLaXgwc3BwdWJjUjZMYkhUdE9EeUJyZkVNcEw5U0xmRk8wUT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa246d00-83ef-4295-6e24-08da325ebac6
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 08:26:07.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgY2fKN0/H5Ihqsc9F25J2Dx12sjrIhii+O8J6aEV/IQOG6APJ1M6b7HEoBb+NvVrTwYbsf44sjmQhAc2/6jdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3359
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Viresh Kumar

On 2022/5/10 16:12, Viresh Kumar wrote:
> On 10-05-22, 16:01, Wan Jiabing wrote:
>> Fix following coccichek error:
>> ./drivers/cpufreq/mediatek-cpufreq.c:199:2-8: preceding lock on line
>> ./drivers/cpufreq/mediatek-cpufreq.c:208:2-8: preceding lock on line
>>
>> mutex_lock is acquired but not released before return.
>> Use 'goto out' to help releasing the mutex_lock.
>>
>> Fixes: c210063b40ac ("cupful: mediatek: Add opp notification support")
> cupful ??

Sorry for the typo...

By the way, is this patch correct?

I am not sure whether it should return with the mutex_lock.
But IMO, it should release the lock before return.

If correct, I'll fix this typo in v2.

Thanks,

Wan Jiabing
>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>> ---
>>   drivers/cpufreq/mediatek-cpufreq.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
>> index 75bf21ddf61f..4c6d53c99d79 100644
>> --- a/drivers/cpufreq/mediatek-cpufreq.c
>> +++ b/drivers/cpufreq/mediatek-cpufreq.c
>> @@ -196,7 +196,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>>   
>>   	if (pre_vproc < 0) {
>>   		dev_err(cpu_dev, "invalid Vproc value: %d\n", pre_vproc);
>> -		return pre_vproc;
>> +		ret = pre_vproc;
>> +		goto out;
>>   	}
>>   
>>   	freq_hz = freq_table[index].frequency * 1000;
>> @@ -205,7 +206,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>>   	if (IS_ERR(opp)) {
>>   		dev_err(cpu_dev, "cpu%d: failed to find OPP for %ld\n",
>>   			policy->cpu, freq_hz);
>> -		return PTR_ERR(opp);
>> +		ret = PTR_ERR(opp);
>> +		goto out;
>>   	}
>>   	vproc = dev_pm_opp_get_voltage(opp);
>>   	dev_pm_opp_put(opp);
>> -- 
>> 2.35.1

