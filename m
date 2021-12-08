Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA9046CDF0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 07:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbhLHHAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:00:20 -0500
Received: from mail-eopbgr1300110.outbound.protection.outlook.com ([40.107.130.110]:49568
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231193AbhLHHAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:00:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coAy3kbUk7vohV/kyiB8I5fmqzdGovR9Do7v1jJ9Nv43OpV4nkOJrl95RA3bMT/Sajz0+OPEL45CT194Jea4FTmvLgo+KLvj65ZtRPbPyg7nEZZlendE5JIpGTWBPBUMVY+IcA7AKk0UctL2+tIuSeHj1yJiKkmLVP5UOZoRetIoqEQ6kf2HW+E/UviuKVNaQfwr0si81WSxDC/w9lJLfEWyj8cNw5Tzpe/InB26c23GC82oXAoNoE7MoK9iS/bUfNHTNCeWxPyWe/3C1OvltVmF9ahQ/MTyvW7b1Odn4DA8/SHIKY5UYGAspdPVcaTEWnl6Sc9FUHdS+um3TCu4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAkIkdFRaDzvdVJ+HNABWmKsYiIaOOIEAxAHvza/vIE=;
 b=dR6//hWWNlBppzA0tqWhZC+vobphez9GxqG1ugLeqSnqKB7mOp2x3b+f8Pw4Xedr3Mx0SbyoSftR7vzgnqQFRCkMSEy9YE6JKxqHrFRE65+FyZSxBWzdmDd1r6Q41ejhLwaKCkhJj5P2kBbqZ1ZWNCUoUDAQONscyUiPx5wSHuaUg6RrqzRIQsWLEQDd3Y6QeiurQkglECbRlMRuGNpvQlHoikJcZBthpAqwn65tWhJHxXu2o9ACEhaI7FklZhBb2YUJuJ0NDAqaTsT8rl3t9Fqp2/J1fBEzsbk+OfkeuUZVn/7dtbyTjZali8u2K7bdnF37ZK3Cz2zCwuzWvwOSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAkIkdFRaDzvdVJ+HNABWmKsYiIaOOIEAxAHvza/vIE=;
 b=ckU3RIAp0vo2I4wYw5jMEU8Ca3Vly4YfknhsI+1ofs3N/4ClBiixbcJLB7KOcMNIQ/oWj9C7dEtgMTcOwPa9ATSanTSzKZaddvLXksT5AXV5knIqqgq3iXzF3R5hDjAfa3VhTJgEAJz0IOIK/cZLeUIEUnVvCug0ADZPgRF9+Qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK2PR06MB3427.apcprd06.prod.outlook.com (2603:1096:202:33::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 06:56:38 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61%3]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 06:56:38 +0000
Message-ID: <f0a6ae0e-4a6c-7db5-7924-a957f1a0b70b@vivo.com>
Date:   Wed, 8 Dec 2021 14:56:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] phy: qcom: fix bug: application of sizeof to pointer
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel <kernel@vivo.com>
References: <20211207131642.5313-1-guozhengkui@vivo.com>
 <AO6AKgBME5Y4PNQLIg0Wlap9.9.1638889943341.Hmail.guozhengkui@vivo.com.@PFlhOTZLT3luc080NzhjVnhAcmlwcGVyPg==>
From:   Guo Zhengkui <guozhengkui@vivo.com>
In-Reply-To: <AO6AKgBME5Y4PNQLIg0Wlap9.9.1638889943341.Hmail.guozhengkui@vivo.com.@PFlhOTZLT3luc080NzhjVnhAcmlwcGVyPg==>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0200.apcprd06.prod.outlook.com (2603:1096:4:1::32)
 To HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from [172.22.218.99] (203.90.234.87) by SG2PR06CA0200.apcprd06.prod.outlook.com (2603:1096:4:1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Wed, 8 Dec 2021 06:56:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cc55f9a-cad5-46e2-0b1a-08d9ba17e12e
X-MS-TrafficTypeDiagnostic: HK2PR06MB3427:EE_
X-Microsoft-Antispam-PRVS: <HK2PR06MB34277BE4C3B5183B8C74529AC76F9@HK2PR06MB3427.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0MV5LdEqHMdUciEptLFdOv1rtaALQIapiC+zijoQMM8j7lx00admJL/ZFO5EakkRimcbWny99ruQmI+tLorGryPA0CcAxx+Lcu05JxSaM7uWsh5YZcY0amN4ldAtGqFFANiQzW/6Mww4y1n4R3iZ+6oB9U75oztqNHiBhWpl0oIinniYOrB3mp7NYhW+114qTZm1BRfVnLd54brAeFEWBgSkTaeamERTvYZvmKiD7Qc/hl5SzEpF17inG9reh/FXSBYEPgDx0gN0lJ8azA+azdVaCuliH/OA6pnrLgmyDoWeODqXWLJ8uY0cpbAypxeZeQPgtXo7aG9UDRf+496FITZ9wVcrPAPSUm0dhwHmf7vMot9xOJIzvFjuWXYCjp2rrGHD032QAlRlWrp19OZly77t+wPTg+SAKjGNWf4PNXGztAI6aPyYIM3sfPIYGlJAe66Js13tSYF2Ujg4zoYe1vs2EupEZxTaPRdbFHTbFMmoNZIx7OdI8UjH8JwXExUzGyc0+LpeQb3RrJ4GG9uUIDf7ZkEQ1gTpg2Rw0zNpIWVKgJxpNrE0yDTcw++ZuuzGuoiTo531hlCgbFwigt3G2ihjMKaovEmSjEwlQE69ybhINSja/DJ6azFOTLInHg/y47dP8cV+YvTr1SrhOQ9gLGMsAqyx8/Sk3oC/cr7+h22aBnEW6gvCBFAlbI95dtun7uVvkb+9Y48PO5e4mturgBKayzkI1Bm7KFq8LdeTCSiTkc5R8goXVzAZR5//5QwuQnasbJUb0ex3aD+8caeKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(508600001)(54906003)(4326008)(186003)(107886003)(16576012)(31696002)(2906002)(36756003)(31686004)(6916009)(66946007)(2616005)(316002)(38100700002)(38350700002)(66556008)(956004)(53546011)(83380400001)(66476007)(86362001)(26005)(6486002)(52116002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUovdVNrZ21vN1RWSXlnWnQrM1Z1b29kcG5ZdDF3d1JqN0pWajJ2dnYwUzN2?=
 =?utf-8?B?VnF6VFB1TWJ4RUZkZVVUME0vVkN5WWt5b1pIMWxGOFRzc29GTGtSd3JCSS9y?=
 =?utf-8?B?b2k5VGJjYzRzd0RuMkcxc0pIY3R6Qk9Od20yUEhiSUdQOTAwL3NYZHBKbDJv?=
 =?utf-8?B?VDdkTld1TlJtbUVMb0p5aVByS0RxV2p5UHc5TW9mVmM3Lys0cXFwd2NRUFV6?=
 =?utf-8?B?aDkwOXRJRzZjaFRkQjM4QUk1Q09HRnJ5N3lOeEwwNXVuTWFCaWttcC9RNVN2?=
 =?utf-8?B?Nm1oaThTNlhmMC9yaE43a1RRbXljUEl4aUxPVGhpQm5ETlREaFIwTzhaWWhT?=
 =?utf-8?B?N1NKOUhEeHRlR2YwNjRtU08zMk9wbnBvMkZUMFVMVGZBZFg1dzZ4eitaelNm?=
 =?utf-8?B?MFF4NXpxK0U3bFV2dzFjeXhaVi9ubzBhRVhaL1hPa1FzZ0lYbUZRTEdIQitl?=
 =?utf-8?B?ak5qYzI0MWFIbmhVdjgweUdRcSt6VkR1dTBMRzR1a2laR1RDMVVmcTJkVkY0?=
 =?utf-8?B?TnAxWlFFZEV0emVDSWZDQjFhU1E2OWhEL0kweTU0V0hvcUx1anBwVjZjUDdU?=
 =?utf-8?B?THVqdjMwZ3pkQVRiZW5QS3FpaGlhRndoZmM2ZTlhUkUwTWNpRFh4ZE1odGFO?=
 =?utf-8?B?c2JrRjFiZi8vSzZ2aEYvbXZ6S0Vjcnl3aVh3SHZycmNnU3A2M1VUUmJZT2dQ?=
 =?utf-8?B?djdDajZvZER4aEZGaFI1L3NTZnZqU1dENElDcjVHMHFoUWhHWHcxUEJMTHdl?=
 =?utf-8?B?UnU2Tk9LbzdSdFQ5YytwVHFIV0FOaWVNbXE2YS9SNCtxZ3ZjenNvOTM2Ynd4?=
 =?utf-8?B?akFpNXlMYm9mbkVNbFBqT3ZjQ3pqOW9tRURhd3hxV1ZJa1lwS0NuMlFUUG5L?=
 =?utf-8?B?T2FvZnNlREQ4T3dWOGh6dGJrSWZtZFBDMThNaTIvb0lENWkvcmVXRkhCbEk0?=
 =?utf-8?B?cnJ4RTd3NXlZcGhZczBNYzlDbnByblBxNjhHaThoMEl4UXBYSUg5REVNUlpI?=
 =?utf-8?B?dTJkQVFjSlBpc1FFdS9QazlLckE1bE4rM3F6MFNqU3VQRVJzeE85VUpGSDkw?=
 =?utf-8?B?d3ZFRkIwc25TV3gyektFc1o2aG1HZ3lxYktTUmZ4ZXlpbXJtanBLUk9udHY0?=
 =?utf-8?B?bTBxYTdJWlFTaGx4YWJYVTdHYjN4TTdGd1pKcWQ0bmprQVZUTmJNOUwrSERB?=
 =?utf-8?B?TS9pYU1yVzZWUjJ1ZDI1SmlyUFZNamJ1YlNWaGdzNEdVdVQ3d1laM2g2T3hX?=
 =?utf-8?B?UjluQ2x2dlN2azV4SFBjQmRUYmY0dmU5eEpqTmNGSG5UMEsrTzhjZlhTQ2lh?=
 =?utf-8?B?OTJtSWc0d3NmL3JUQ1o5NEVHeTlIK0dVZnRUbXlVdnJ2UHJDWVB0Q0luMFhj?=
 =?utf-8?B?eGlIY0o1OWZBYUdyTnZrbUthMWc4R29tYmpiUkVHNzFuN0JoWmFwLzNxQmp0?=
 =?utf-8?B?NUhEam5GQzEwL0k3bElueStkWFdwL0FWb0haQVd3cGRIL2FyUndTS3Y5RWcw?=
 =?utf-8?B?VVllUnpuNTQveENIWWhhSHpEcUxWY2tFSjl1Z2ZaMGxiUVdkSHEvY1huWXZk?=
 =?utf-8?B?Mi91YkpTMitEVVduazNzdEpIZFZCMHlKK0t2ZE1aRUVWNXlUQ1U5ZnhwOWRR?=
 =?utf-8?B?SkFhY2lDOFNkd3JNN3BWd0pZSnBPejR2Mkl6aDVwdWhObGVnSUtyQnRoMzRI?=
 =?utf-8?B?UkVObzQ4UWV6Q1NuZllTUUgrcXBZL3dhQXZlbGdqVUh3NE9hbUUyU09INUhW?=
 =?utf-8?B?OHgxNEwzOTZScDIzTkFTYlh4b0h0cWlJVXRwbnQ5UE1qQllKSG1qbjVUejVD?=
 =?utf-8?B?SFJIZXBDTGtsNm5YZUQ3Z2Rvd0RLcUFYTU84MmNTaWJUT0tYQlVJbHZHTXpZ?=
 =?utf-8?B?TDUwclFsK3JDSnB1cG1FSnFtN1R6QmNvQUNsMkh0cCtSbE5sYzE1VHB2NWE2?=
 =?utf-8?B?ZkVGb1U5RWQvWHlNOVE1aFNHTnI0ajA1REljWHY3aVRxSXVOWklQUERSSW01?=
 =?utf-8?B?c0ZWM09URVRZdUNzWFppWkp5Umh3ZTVpQ29lU1g3OXJ5ajBpRlQ0QVNmRzVx?=
 =?utf-8?B?RHp3OGs0Y2xScnhPYnRMUWpLMWlUaWtnNUZFM0x6WkFuWmwyQ2NxTGJCU003?=
 =?utf-8?B?dXJ5YXN3ZEV1NWVRWTQwKzlhMGJPL1JxRUpEaFk3UzAyREpNQXZPV21taXZ0?=
 =?utf-8?Q?z2fqZdssf2867gyYvHUaYxY=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc55f9a-cad5-46e2-0b1a-08d9ba17e12e
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 06:56:37.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4youiS7BKx4+ShqfLC9ktpGhIOPWKN3Zlx633DrrYbcCevPTbf5TFyM1kurwBtK1ahrelw0Gvyos69VgFcgA+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB3427
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/7 23:13, Bjorn Andersson wrote:
> On Tue 07 Dec 05:16 PST 2021, Guo Zhengkui wrote:
> 
>> Fix following coccicheck error:
>> ./drivers/phy/qualcomm/phy-qcom-edp.c:574:31-37:
>> ERROR: application of sizeof to pointer.
>>
>> Use sizeof(*data) instead.
>>
>> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-edp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
>> index 17d5653b661d..5fe4eab9cac1 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
>> @@ -571,7 +571,7 @@ static int qcom_edp_clks_register(struct qcom_edp *edp, struct device_node *np)
>>   	struct clk_init_data init = { };
>>   	int ret;
>>   
>> -	data = devm_kzalloc(edp->dev, sizeof(data), GFP_KERNEL);
>> +	data = devm_kzalloc(edp->dev, sizeof(*data), GFP_KERNEL);
> 
> Ouch, thanks for catching that!
> 
> But the clk_hw_onecell_data actually has a variable size array at the
> end and as you can see further down I store 2 items in that array.
> 
> So that sizeof should be struct_size(data, hws, 2)
> 
> Would you be willing to update your patch with that?
> 

OK, I will commit another patch. Do you mind I add a "Suggested-by" tag 
of your name in the new patch?

Zhengkui

> And please add:
> Fixes: f199223cb490 ("phy: qcom: Introduce new eDP PHY driver")
> 
> Regards,
> Bjorn
> 
>>   	if (!data)
>>   		return -ENOMEM;
>>   
>> -- 
>> 2.20.1
>>
