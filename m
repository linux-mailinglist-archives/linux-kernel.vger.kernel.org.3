Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF2D5670E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiGEOXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiGEOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:23:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E63FF8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657030994; x=1688566994;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FYYTaql+tRrSQXJefVlisIEP3RbR62OMOFXLD2xClTE=;
  b=FUHxa3MsQUzwmOXoggW854nH1GFxzkPxlkMUoFDD30yEuYNgr842NocP
   gLADp3DorPpwpwD8ycWj+fRu7ECPWskp+fKkGnruX2S53vgqmszkNyy9P
   Y2TdcUIatHuvijisK2UHvdM/8SE7XZY+13fq2RBfEJ1+RgTSM+EtebJJH
   1iVil2yeRYK38Ey54NmlByd8ijOwE2p71miYW8UWAam+G76AyZGmj09gk
   iRpRmfhJ1WeX7CLiBvjTP+r8AyeO6TDODV0/PTHcgTbO2/nZhltKRd47s
   h3kMFgXSsKHdXQ7xp9pKxlxyvAtmz9c8CLtFqIRj8iOzq8PigNG4IkhqV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="369688734"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="369688734"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 07:22:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="567632967"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 07:22:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 07:22:51 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 07:22:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Jul 2022 07:22:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Jul 2022 07:22:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d43OLuja3Z8e94k3WhZEZ8g9gImS5b8YGW97SS5CR8oDDwZqjGEyJgbAHsFMWCsgfLyn1yOXZTnA9N2LGuIyRdGqEsqW+RXyp/wn6viyU5iWdJvSTDHLUxSTFmsLXa27aA4sa3m4PVIshPThe/TD+028CxIFPqwkDhSlJOTi3EYPTCiD7eq/DYL+5dkDyA2rgBOnJ3qK1+Rs9NpmRcL1u8u/mTy83d/xJ7QLIjpPlClSbF5f1hw7IMPuwEgzNEorCR2rlimDCgYekCVatVTdiMcktnITBhwrGN6a0gPqC5v1/JMBumz0nOxqpHQWjGDkAZqN5u5FRlAW+f1f43nE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdqGGElesi0vx6rmRGJvdB8CJoV4kW9267xyOXhncK0=;
 b=F6VNQg2LgpeMLT+qMvv36zmc5cIWWd4/xYldwv9ctCQoaE5tCjM4KIIzDh8itKBL4qM3vDXeVPZJMSW1MBlhwDraKepmhzQ1pFWZijio1gzSfbRsqVRdFA01I5DbK/njK8z8qMJ1iYxt+bRsYXesT+pjiRKLNBiE/OtCq8g0ksLp6VXjjvcdamr7sxp1mwpW1LZ8yTP2UsdWj3zGgGgZpfzJhZUcYjov8DuACVVslb3T3Zim3NaaPhUUD+JJg6TdFmfW5832RiWUB+l0dma1rYPd6pEYUkd0n2Ixp8+YpiZSUHdInP+hFUSkL+F3oVBo2kRUPD3O4iayatz17w109w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by BL1PR11MB5512.namprd11.prod.outlook.com (2603:10b6:208:314::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 14:22:43 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e%7]) with mapi id 15.20.5395.020; Tue, 5 Jul 2022
 14:22:43 +0000
Message-ID: <f1d1b9e3-fa4e-53a4-8971-d4e91c0c3ebf@intel.com>
Date:   Tue, 5 Jul 2022 16:22:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v1 4/4] bus: hisi_lpc: Don't guard ACPI IDs with
 ACPI_PTR()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <john.garry@huawei.com>
References: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
 <20220705114312.86164-4-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220705114312.86164-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::10) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: add1a32d-b768-463e-298a-08da5e91d31b
X-MS-TrafficTypeDiagnostic: BL1PR11MB5512:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWB1BYjKbINX1R0Nh6TD3syYGnMoJ5/i4Q6oaJpAC+doJ59UXf9SQzBg1cAa9RcTJ3gOG0AVioF/l1LUlXm5m9a821ekyYoWvi6zdu0BomNJnsFP0vWClHv8zRpB/QLkBUphVDMz/CNE813C6vCJprtC2n89EUDxD9nBnwZ7lWFpqMK+0+sxSGvmwUeXn1OBko+cHrjRAlv8jQ+Eo+kvSTHSvOCUwWvjDvmItdnqZlqdHY3ZsBHrvQXriGn4LkAxFJvzNdSY94DJnpAKV9NAsCPIhVgYmlE0NvBEz1l2r8vSP/516vUJhu44QigBcJyQYry8fZ1SQnsKs3G76kbRGc9tmQ+ALpg7ygomberzEpbbt8ibaodf0YZBTf0GNDxTCmEROhc9nENRGGiWFn0k4swKFgWOHy9aQ2UCRw6zNamjhy+WN48LrX+3GDVpx/1Y+AOjGF2FBZbqiTnV51FkCDAKGzgcDtjj8+hTnaK+KtEUsEzJVkPXkp+LIYzXiMG3kEGrslFemWKoSSfZElxkxFgrWkh7Pcb7IY5PCjDUJL7TJXUlOaiZ8aGF3IQoDu3/hkLlz1/9juSHhsSsfRYIPTTlm2RjbNsUq04mUcyXsnsir28YFdxJBxvfUVMf0kF+ialtzKSX+Q9/t6HygoLAKQ2wGoF0nnTVBRIQzJnLRSIH+GyKBXdpoqzmu/YqsnTCqJU4SVELVEFGeWs9BE7YodmiNi+cHUKbu7fOuEl0FSSDwVZvsdmDvurjp1H04zFl3mQjWaiZZKnwN2IG6KpDa6kITlRVIBdPH4wecDV2DvIyWXXePBLJoqAuxB7fAcCs5tWW1JiZJzZiAM8+M+QHIQ3EC9OH0V8HNZaB+mwt/D0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(376002)(39860400002)(396003)(136003)(2616005)(31686004)(5660300002)(4326008)(66946007)(66556008)(82960400001)(66476007)(316002)(31696002)(6666004)(86362001)(41300700001)(478600001)(2906002)(83380400001)(6506007)(36916002)(53546011)(38100700002)(6486002)(8676002)(8936002)(36756003)(26005)(6512007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFlQNmNMbEpCZFU0Z1c0eHAyb0FnU3FNVVNmbnkzSnhpMUtSV0RRV0s1N09r?=
 =?utf-8?B?KzFPWHJ0T2F1dmtJaUVOaWFVc2NJSXowVDB6SEhzOTVsT3gyZG00aXY0TElY?=
 =?utf-8?B?QVN5NWhGVUZiU2pLTEI3amk0VlZMakZXZit3Zy9yaDI4Z2J6ZiswY3UwMkNX?=
 =?utf-8?B?cWQwcEVQUUthR2FNL094cU5BZ0NHa1J2b0VpZWZSOG1oUnNDaWhleko0VWMy?=
 =?utf-8?B?K2RCVUthYzE3SlFUcjgwL201TEh0WTNPUndTSXp4R0FQd0lJMGxXWndra3F3?=
 =?utf-8?B?WU9GUVJLOUIxTjI0dXRFOEZzNmtFbEdFelBkdnQxenc2bzZEWU9DcUF2M0FB?=
 =?utf-8?B?aDAreVBUV3d2WEEzU3c2QUlvT1V2WjZUeTE1SmV5bmJGdk02cUQ5YytMSWJp?=
 =?utf-8?B?VytqajRqMVlsWVc4U2FRS2dkcUtqdElVS2ZhdksyclhEcllwTWlJOWRnSGUr?=
 =?utf-8?B?SVZxNENzdVU5dDl6eU8wRWdBamF0cUR2REI2QkhOTVJKcVFjUm5Bb2xIMXQr?=
 =?utf-8?B?N29VeVl3d3VuZVdFaXVZbzkwSnpaQzhTWmVJNG9VNWRaWHlESDZZaUxMbUll?=
 =?utf-8?B?SE9ad1QwRllpY21MbWVNV203ZEdBcE0zb1FiRGFJcHdPdFdPMmVWalREUm1C?=
 =?utf-8?B?ZHJnWDJDeGFXY2VxbEMrVzFQZlJtOU5IL0QrN2phWm5Vd2VxNU9mS1RpQTkv?=
 =?utf-8?B?OWVGUkpTQjJoVTVhVUVVQjNVVDlSd1VuZVhESjVUUnQ1RWk0VnFpSmRuMGx3?=
 =?utf-8?B?ZE4wZXQvVVZqdEVJZXhYZC9uYmRzb3RVeUpZbXQwQVRmRThGa2t4MExIR1VW?=
 =?utf-8?B?dXZaTW1saytKTlNSTUhLb2JIWGdyOVg4eDJGaGtIRGZmR2hlVXlTbEl3Y2FP?=
 =?utf-8?B?UGRHOU5iYTFKTFdOTjR5T09WbXdjdlNiaUxLdGpSaW1aU1NieUx3UGx1SlhC?=
 =?utf-8?B?YUgxSTB1TFE4enhsUG0yM0pVbVp5OG5ibHdEOU4yUytXak1VaFFMbVNwYjBm?=
 =?utf-8?B?WVJuZWp2eHducHgxT1RmbHN0OU5LY1hxT2dwdFpHbkszTUZpUjVkSnBFNjNF?=
 =?utf-8?B?Q0JURE9hSDJVaUFndCtLdEZ5Q1NreEcxVVhCSFJwUXhQNXU4aHVvVlZnaDl3?=
 =?utf-8?B?WDRxUlNXbkdnTFVLU0hBUXhOUXc4eWdXc3pRQlhXdFo1N1g2Qjd3aGJaY2xS?=
 =?utf-8?B?bFp3MHhESEZ0czlzTkI2Q2Z6SE1URjFscG9nbktzNlp3QjNjR1pGb2hhZGV1?=
 =?utf-8?B?ejlvUVVqUXRwUFpYWFhNM1k1RkprczlrbEJ2SDhJd0NYc01YRmxKWXkrSHRE?=
 =?utf-8?B?RDJaY2RqN1lpcGM2OTBEYTFzcDJPNHZYWGZkcldwTkxZZVpEYXdEREFROUds?=
 =?utf-8?B?dGRWajZkdkQyb0tUWi84b1lJdlNlQ3NvR3dtSmdQcU1rQnNNT092bDRweEVX?=
 =?utf-8?B?TGxMVHducnJ1dlgwdUVPU3FYU3lXZnYwNitZZGtEQjEydTJCV0NXWWhEeEpT?=
 =?utf-8?B?RlJiZHVpR2xCSkJvMzFFTnpwQnpIM2hNR3JYeFdyUWJUWXd3RlVhME4waTFz?=
 =?utf-8?B?QklXQ1NpR3BDTWNKNEE2NVJLYmxmU0VHOUJ0VmUyVk1DL3h2U0daWmR6VkJW?=
 =?utf-8?B?SlIyRGtOVkhrNmovVjZad21LNmpBV3VaaEdDN3JtdHArUTIwZDJlOTZuNkdh?=
 =?utf-8?B?WmVkVDhRN3pDdnFmWUc2R1l4YnNKU3J5dVhpOTJKdHpvbGU3TThkaFlMVFNa?=
 =?utf-8?B?Ny9QZ21NclIvQ01qakxWdWJSQ25lb1U1b0kyRExSTldTR2ZsOVZwZU84eFNn?=
 =?utf-8?B?YVFnVGI4RkZucE5NcEtlOWRIS3liRW5lZDJadmdkelhsOEZNZWM5WUxha1E0?=
 =?utf-8?B?SmFyRVk4Tm13SzBPZDd1dmdXQTRXUGV3TzFYdzYxK3JsNkQ3QVpkQWxkZ3k3?=
 =?utf-8?B?Sk40Uy9Eb0R4cmk2UHFlWTdHc0tTWEptMHFkbW9GZjg1Z1BQdFk5WENUbFJL?=
 =?utf-8?B?OHAxSXhNQXlUdmRwUjFweVNucTFnQ1FNc1dOWVp6aVMzY05qSGRQYTY2Y1VT?=
 =?utf-8?B?L0x0WHlTNmtNd0drOWdpSnU4YmFoMXpzem15MHdwREg0RGRWdUZIV2RvNTZD?=
 =?utf-8?B?dzBIdnR5MWFTZVBTTExsdnZPaXd3eVpkTzFweG9GWU5sL3BvbGxwaXhnT0JG?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: add1a32d-b768-463e-298a-08da5e91d31b
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 14:22:43.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +l7cgCK0DnH+LNZMU5un3YTAjplRmfR2G0iH54jHeYAbySdC+9AxpBlQigI9LBegAGHjLZXwf54Sl0R3iFbIn+6sMFAoUzDzK4Ggo6upF1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5512
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/2022 1:43 PM, Andy Shevchenko wrote:
> The OF is not guarded neither ACPI needs. The IDs do not depend
> to the configuration. Hence drop ACPI_PTR() from the code and
> move ID table closer to its user.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   drivers/bus/hisi_lpc.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index a6513a571d7b..74f4448bff9d 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -589,11 +589,6 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>   
>   	return ret;
>   }
> -
> -static const struct acpi_device_id hisi_lpc_acpi_match[] = {
> -	{"HISI0191"},
> -	{}
> -};
>   #else
>   static int hisi_lpc_acpi_probe(struct device *dev)
>   {
> @@ -688,11 +683,16 @@ static const struct of_device_id hisi_lpc_of_match[] = {
>   	{}
>   };
>   
> +static const struct acpi_device_id hisi_lpc_acpi_match[] = {
> +	{"HISI0191"},
> +	{}
> +};
> +
>   static struct platform_driver hisi_lpc_driver = {
>   	.driver = {
>   		.name           = DRV_NAME,
>   		.of_match_table = hisi_lpc_of_match,
> -		.acpi_match_table = ACPI_PTR(hisi_lpc_acpi_match),
> +		.acpi_match_table = hisi_lpc_acpi_match,
>   	},
>   	.probe = hisi_lpc_probe,
>   	.remove = hisi_lpc_remove,


