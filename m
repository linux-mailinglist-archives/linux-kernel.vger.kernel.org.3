Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EAC57BEFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 22:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiGTUJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 16:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGTUJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:09:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1796D47BBE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658347785; x=1689883785;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YJChNwAu4rqHlbUbWPJeOeX4OnJ4HC6xYgcXFyvE6Bk=;
  b=QYtX+CndgYMYbQ8wlAvMrnH4AkRZTqMDTV7xKeJHiEHq2K3gLx9hbevF
   CIR8XwV9xnhOxxDrvWT5aZWpl3g/YdFNfE2gL6W0GsoPe2VPZowRJ4BwS
   R9u6Oz9kOC7nuzTrBExcgVLl9Dm9vPOt09orI1Dhk3gT/hzb+V/mNMdtn
   MAghbSon435xAxvuljSMAUdr6m2seZyt5KKCDRJwewh6/gdzhsD644wY6
   O9H+dbawpSDoy0qocWiS1qSu6fGmtLiBIOgt5JSjIoXWNjVsjQx/9E1jj
   4bZCH2dwqzf2f3iHI9OKVp8z7UayPqVCzd5UJxVs8SiVXYpBn6CwAcRVL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="288035129"
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="288035129"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 13:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="573450584"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 20 Jul 2022 13:09:37 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 20 Jul 2022 13:09:36 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 20 Jul 2022 13:09:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 20 Jul 2022 13:09:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 20 Jul 2022 13:09:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhLS8aYhlC2F8t005F67+n/roBBI+I7IMs+NO6q2k0AUNFWHygD0DONCxrv9YolvLDvJVgMjohulm7eeCUaTb88qNzILQP2D7qHU5SVuPiWCR6UUxvPSJoYyoQdEBbFU3CivyUtOFQ8tEkyLIs0wFMYSQG08mrYTUMrrO5QymkNiYtGSniz1Ky+ZyrbmEpVdMGIgVr1w++zDixwJNI4+gnlPew4S+KfN2nFeRli+47Vy/DIiI7a6MvZXUhO1CZkMfVHE5YTkAUSyelv0BQgPB2CToF2RZPoGbXPK//jcp4L7EkxdbdqK1dwL4SJMULzL8zHthWTaN05iLn8UeH5GIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buFIkCFfAIlGtB/rP8uWeFUbLXy3RIB1Gs+/VI1wESI=;
 b=Za4eSFHf3zUUXq2DS3XyJsKYfIu3bBNIzI7Ojhzz+ws/HjwA+am0gNRco6RvMM1DbKCQrtlcdyqHsOkNdjSv8RHu7p4LUYXSchEXfG2DfGBkpTErry2GhvY2KnTDJ14wOK+KMpSRZrns26f+Mz66zi8qcVnCFJCTLjZbthBnoeFhJyQ/YPTY3u9FdGk+sp5/D7/mayNa6UbvphGj7dBndgL5vgpdG1U856xtgvfIFO+uJB073k/Lstr40xzBJPjUbJHtT4LHG/9qj/ZDahlpX/Hrz2aGONcav6GOSKeRI4h+1ZqYmWpm5c6K/YwQX3k0Z+axGcGOqsRQp98hXY3eOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 BN6PR11MB2036.namprd11.prod.outlook.com (2603:10b6:404:4a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.18; Wed, 20 Jul 2022 20:09:34 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::852b:5f7:46eb:fca6]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::852b:5f7:46eb:fca6%6]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 20:09:34 +0000
Message-ID: <71f92970-1e76-ed47-e878-d66f747aec86@intel.com>
Date:   Wed, 20 Jul 2022 22:09:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC:do not initialise statics to 0.
Content-Language: en-US
To:     Xin Gao <gaoxin@cdjrlc.com>, <perex@perex.cz>, <tiwai@suse.com>
CC:     <fred.oh@linux.intel.com>, <akihiko.odaki@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20220720195809.9470-1-gaoxin@cdjrlc.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220720195809.9470-1-gaoxin@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::15) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f4c48d6-af68-4e24-46e5-08da6a8bc383
X-MS-TrafficTypeDiagnostic: BN6PR11MB2036:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhvM3Toc/90x+WvMVqhd5qVaNIZS4Fyvypzxso4AAJyPN91Dhi5RWtpJeQv1EpGJu2ZVeQ6/0mKVqWZRWv7lFvpQnwzoWpWEGZEBKlgFGF/xvfjsEyuqJ5txWf2bDTE3a/tq0H1ynx3y1h7xUsto4mrXUmipGmv9GH4w0Qo36pupc4JeSzM3C47kItNmRNk5hqMBS1b58ID+hhFTUuv/pEaut3cmqpG5/6nwsRgj/82OMY6t5Rd4vFtkG8tXmlIuSl+uVpD1orwLXolkbH5lsbmHoYV/9TyCoKHVEg99pBRXpOBbcHFGEdfyPyDEc4a1wWTWWd41vdCTRtb1MCJNLb9U92G3f4eQOPB2FY6u8Ut9IpcPBvfbUPK6NIfPmP9oquPtYKQ/JcREok3k0hHZWcsZ7Smu69VPFPXBRiXBnu7I3TaUBHYRw5BINtlyoap7S6b3soQfNrKV0kivYVEUQ0KSRw4g6RJKxommeim52aBnrhHsTaT2GOGNLdSk1O/j/F24GsvnVb05FRgve6pdfHDNM7OSmmjbehEoKsKfyza4CaACh8Qyvo1JJPEH18mlyJzS9f6RVxMZcbeNQ+9WiwwTqjT1KS8IBSLfHSU2eUXfnohz/+3H7ll2Ir34L48tO1P06uTDeHS4HQkrsrT/ANFoSDDs58dBE2c6I7rQAkGgPqf40W4phL4Kp3UQ6G/q26fnLWkselYmby+vCP/KGsVb5Qtc7KuuZ/P2txR9uqnBXg03Dhq5qciLs/0Ak1p3FPIad5zmo3kSsgrVHFrgH9aAR8NgeBl73+Ak0siH3lqa7TDR9diw8YGKSZBJq/5HuZhz/tc6gMUqtyVfS9SOAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(136003)(366004)(346002)(376002)(5660300002)(44832011)(8676002)(66946007)(8936002)(4326008)(66556008)(66476007)(2906002)(83380400001)(82960400001)(36756003)(86362001)(38100700002)(31696002)(6486002)(2616005)(6512007)(316002)(26005)(186003)(41300700001)(478600001)(31686004)(53546011)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1Jzd01BTitob2UzMjdENHFSa20yd2hqR0x2cVNFRnFrL0h0YkNZbUFwN2tE?=
 =?utf-8?B?TjQzOUZBb2RKRkptVURVMDZ1RnJOOHRYRzVpN2lPUzVzZGZJdnF1VisvY3pi?=
 =?utf-8?B?ejJldHZkc0Q0MTRiZ3dTd2hGOUtMeGs5QnNmNng2Sml2ekhrdjUwWkxnV2ZF?=
 =?utf-8?B?aGxFSzBsM2RrSGxadlBRczRqOHZkeHpBQmZTOGYvTDZDVnY1VCt0L2E3am9S?=
 =?utf-8?B?RWhjVGZzbWk0cWdGblhxeVRCWkRoc01vNityanhWalh0WjVnV05Vd0tKNzR2?=
 =?utf-8?B?eHprTHVLT3NmdWNlZzRQVTJlR2NNb2k2d2NyaXVoZS8yMkJJOVhZZ2JpNG1O?=
 =?utf-8?B?ZTZPTVRYYXJESFdRaUFvSThHMlV6K2JPek9ZcmpSMTNNVkNsVXVzckdQZ0cx?=
 =?utf-8?B?Vmx3ZCtLWXlGZEU2bDd1RWNVaFZzQXFBTGNEMDNVZ3NsMmpmZUZIZHpDT2xw?=
 =?utf-8?B?eFBad3V0alhMRUovbTZhUUtnRjgya3RZaHZHTytrRnBoUlZ3WEdvd0VGWjQy?=
 =?utf-8?B?VUtOdEF3TUh4MEZpK2NrdW5UWGdMWFY0RmlWMkN4aXJyb1lvT3JkSDdDZnds?=
 =?utf-8?B?a3JZaWhCZUk1d0RhYWYrRW56bnVkelhTSUduYWFYcHcvZTdvNjR4NHZ1enp2?=
 =?utf-8?B?UUVENDRLdEJXQU1aaVRuUGRuVFpKOERrTTRMVXFMRDZPeUZKQjA5dXhpUGpm?=
 =?utf-8?B?UVU0cG02VWxQU3BJWGJYKzg2cGhLbC9zUEtrdlUyL3FjT0g2dWlqaklhR095?=
 =?utf-8?B?S2oyUzNRUGFBNExLVG1zbG1Kc2dpZjQvM3RtNWhQR1lrNG1odzBPeVd3UmNU?=
 =?utf-8?B?ZnFhZmNiNDVKOXdMbDRkc2VJb3JPWlBuTW9iK25uZnBmOVpSbkRuOVpyNDZv?=
 =?utf-8?B?cnJveUFYNStqSFNoaGh5L2xjcjRSY2UzS3VuNXdjNDRnL0ZtOGlxWmF3TlBZ?=
 =?utf-8?B?eGZVOVNVM2hPZVY5cWhibTZqczlHSEFQRlp6b0ljZ3Bnd2s0VHhvZUs0R2tL?=
 =?utf-8?B?U2V0bFBDVUpCazlOOUtiSkJsNjZCTkk1elIyMXZxYnM5bXRRcitFUW9ZQjFu?=
 =?utf-8?B?TFZ2L0kwWGw2RGo2TGhoTFlFT3hRWHNpcXg5ZW92YzRHMTZETzY4UkxjNUg3?=
 =?utf-8?B?QXRHaGlDcUJyR2VKUVYySEFXYUtSQ3QvTVFqbkhVNUkvSnlRRURheVFzbHdQ?=
 =?utf-8?B?dUIzSWd3VXNlbzBTU0hLUGwzU0p6TElmcmxWUGFhUi9GUi9jRFU3VzBNSmcw?=
 =?utf-8?B?eFlKU042eXBzVDByMGRoMVg3aTFJTk9WTnBYRUxuTDBlcUo3cUg0aUJHS08x?=
 =?utf-8?B?ODZsOVRCL1N3a0U3Qmxzc2FqWGkvYjRIbWZVMDhjYktIUTNVWGUyV1pFUmg2?=
 =?utf-8?B?cExmb0l0SmZscUZjZGdXeEsrdG1wU1hBY0JyOGk1cVRaUlJFOFpibC8wZnUx?=
 =?utf-8?B?ODgxUDlQbXBreHFkSE5RUDk2YVpGUUU4VG10dFJQL2N0ZWZpT1BTV0pLNTRV?=
 =?utf-8?B?dlkzTUN1WnAyWS9zTHRtRFEzU1dKaXFHNE5RejltNXVHdzR0bjlhcTFlbzE3?=
 =?utf-8?B?SFZFUk96R3lPTVN5T0hYZi9WNkZxTGt6OUR2Nk9lbWwrdGxqazVUdVRWTWcr?=
 =?utf-8?B?SmJ6ZXFldC9ia2RtK3RHbUhxaWRVWWpNUE1Fa1JUbjVMdVRFL29IQ0czYVFy?=
 =?utf-8?B?dHB2Z0hXQ2R2QXpHM05WbTVleW9mKzFKMXZaamhZZm1MOUZLQTIwN0lEdmdQ?=
 =?utf-8?B?MEEvYTdXNkxqQlJza1oxMDdyUUJ6cXl1cHJYUy81d1IrVUhKNUdiRXRMeWhI?=
 =?utf-8?B?ODlsL0NDeHBOc2tZM3J0Sk9reUo0Rm5SOVcwbUt5VkprZGRjSEJYTytqaDNE?=
 =?utf-8?B?aHM0b0NSd3QyNmJhT1VkL0dsNStiU2tCeEJLb2RaSnd5bnhJNnN4MzhaUXUx?=
 =?utf-8?B?ekEweUVvVmdjOXI5cDFkNjBYcXBZeHZkbGkxVUtZV1pEV0VNRU1JT0ZqdDNF?=
 =?utf-8?B?STFxY1hzUTZHU3gzRmZiUzg2MUdtNDlEYll5SkhSc1FnT0xYTVQxQ203aXY2?=
 =?utf-8?B?UzVPVXF4eE5TZnkxN2NHMkZnRDVjNzEzOEIxV1FPaGllMm0xSHNoSlZKSWw2?=
 =?utf-8?B?b0JDTXpXRWxVVE1xd2M3N0wwVTlmZEo1bjJyenZ6OXNDR3FPNUZTa2lUaUw5?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4c48d6-af68-4e24-46e5-08da6a8bc383
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 20:09:34.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ed7oE8lib/iLhOFp6apEPRZIeHY8zNZVOERAhsVZFrbmPEujK6lgbUDZm+MoY9T6V78zDkSnpN902uYj4MckvQbbHeZsFb+IBR51gv0xmEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2036
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-20 9:58 PM, Xin Gao wrote:
> do not initialise statics to 0.

Hello,

Please do not repeat the title in the commit message - brings no value.
Also, the spelling isn't correct - s/initialise/initialize/.

I'd suggest to adhere to title formatting common to given subsystem. git 
log should help you understand which scopes should be part of commit 
title for changes targeting Intel code in ASoC domain. Last but not 
least, title is not a sentence - drop the full stop at the end of it.


Regards,
Czarek

> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
>   sound/soc/intel/boards/cht_bsw_rt5645.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
> index 45c301ea5e00..8a8b25589c55 100644
> --- a/sound/soc/intel/boards/cht_bsw_rt5645.c
> +++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
> @@ -50,7 +50,7 @@ struct cht_mc_private {
>   #define CHT_RT5645_SSP0_AIF2     BIT(18)
>   #define CHT_RT5645_PMC_PLT_CLK_0 BIT(19)
>   
> -static unsigned long cht_rt5645_quirk = 0;
> +static unsigned long cht_rt5645_quirk;
>   
>   static void log_quirks(struct device *dev)
>   {
