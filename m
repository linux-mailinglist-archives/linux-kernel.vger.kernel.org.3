Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB0B583818
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 07:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiG1FIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 01:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiG1FIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 01:08:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A20142AF6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 22:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658984928; x=1690520928;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Oj/OXMrn9y7F55uZD0DsmSkWZSpgpfTQLkZlPP5kJZs=;
  b=K7oCxAFgrtx0Zj/JUU8DrQwQfwGnUVOpsJUXNw0kX2lpneOOdM4ac/dC
   M480mIf1d9c4uVmd8BWQ9HUzD//nmxlDFJRPtcutXGbgswot4eQ39BwTa
   4vodROAanXwvDDzwzd8HMabEFK27E1HSgGyZ4Um64sFttJwbKVwxYL4o3
   CSShT1flaGjKyz7jk9NH8YLvxhM3kg6feLg0Dv9L9lbdxCzHz3+j8buhh
   ogSbJGzOln8ty9a9c1i4AIDiR0Hp0N8vmOP+CHlVlKxtFr+mquaNra21s
   k2F4ddW0pHojFMsxgxeOxTrLQ2khGR+DXhWCtC4jxMkjxeDGJtxH+YsSO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="285969911"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="285969911"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 22:08:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="604416960"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jul 2022 22:08:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 22:08:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 22:08:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 27 Jul 2022 22:08:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6EcDg9AIlXtUuAbwXmOikS0NOw2b1AAwNsFcLl4KtZG7+3QrMwJEX3+bFuiYmXOIOsxADu/Fi0oSM1sRXFRnuA8hBJaEfoJoYdEZUUpX3Zf0bg+GgvKNQMO4+O6529rQlxbRbIlGTp/Sn1OLEA34kgli5sQIsU2ry/N2OQ72tOw4kG1xWgsd2CBkcEJbB8JEp+uCG4Egiziwl1ZjbpcufdcJaoYG+3vdpT5TPntAdPWPb09r0CLwIUu6v+GeBxJyX2VId93OfB9/zHaUS01+9BE9nHnr9VDRA4dRQMXDwaNwwjTI9RGn40ubKFJEuUlsDzJtCPeFKhgfZztv7iDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVAetIuZRewaakdSGJSGZ2KnXArddR3W7aSs5G8PhGQ=;
 b=blHcuUU1GTJsYfixvyNCmn0c03eBHElH5eIFC9PxfU2wC1giUhfR9FRJRoIYUONh1EDhS2AlUj7Ve2qOz9yDnx+XXmdyq38ph+XZtCaEi/JTFPx8kguxHQMM/B5OQgI913nmAU8UumZd8MDLDrI+t6XU6BNv8ZgqhiwsLBcr6N2tA9sTNm88Q3o9+6iv2+uZ+0ClH950airuNCgMIvrd8YFquyWysc35nobZ1cNZ1toTyHoIjnhBb/SZV85QeyYmVmfTEvxKic9EMyV6Atwhj2xMP1pIlNuXv8TvGhqRVomVrQvsSJU+5/FCTxuMkn4l5s10cVQv1W6YgJQADrIBGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by CY4PR11MB1477.namprd11.prod.outlook.com (2603:10b6:910:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 28 Jul
 2022 05:08:34 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::dd55:c9f5:fbc7:8a74]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::dd55:c9f5:fbc7:8a74%3]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 05:08:34 +0000
Message-ID: <bcff18b0-5da7-860a-410c-3868b019c717@intel.com>
Date:   Thu, 28 Jul 2022 13:08:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2] memblock test: Modify the obsolete description in
 README
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>
CC:     <rppt@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220728011228.23691-1-shaoqin.huang@intel.com>
 <YuIK7cU8uH7zVP+S@bertie>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <YuIK7cU8uH7zVP+S@bertie>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebf0371e-546f-47bb-2bab-08da7057385b
X-MS-TrafficTypeDiagnostic: CY4PR11MB1477:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9fr3LSA7F5UALkVQYhMjddHGagPlqDTsMeHEhPDG7EAXfS3gXWTk3YT8ro5YoPJKxzF5N0qWU7o/cG5rtSjBqRhhemacjgbp+6bt7e+iSyxapMYrka1Kg2HcXyiTsJc03yo/iNF97IfBPqnRAtZgsWBZBqW9kqc5cmA/mqo29/1yn6eYGpvBN5ENx0KcEFyHDs5hZuEZZF0JHlZPfBhs4jsJG3khEcFcvtQYaElJaVaeW0osWyCFdk2bSB0pduDioqiHwSPP3UN/7ohbtOtIepKFZ2yNrHJJZ+2BfZel8KafnW7/RAKwORKElWYM3eREwnlFcJy3Eoum2DELOdB7Yby/ijwAAO4N0vPWgtaGNuKmCFBZJ7xrrkldGt9dp7PD4RxXhzWaZvkyj3uZhkX7Yxaxa6ol6HRrCtxb4ZaL/jY5bBBmd/K30pnJ1ds/z+O+1BBpVxv8kEYF0zt4kVoi6hYN+LD6kDWja0Z23/9/Xju5PA+tH4FXoAgbb1ZBxnak/KGNxMvWwD+0In+CNWqFXFuVSapd+JZOycP4wFoFbYhHCoW52IvCRBzZn3imYgnXSgBJpQfh57pxkULm468ZCVTHbSicsAiRaxGlEZvMsboDHla6/gnFHwgd+XVM2d8dmAkHx5IhhapxxY6CjMhdsKoykEZFk1Lbf23SY60JGiL1QJ5lmUiDXLQKVPeXGlSo7K7hdMVRXeAW6OjZSuOzrWlfCEn+UE2cnok7biysNuIWDGQmhhwuLhSPmzbXOUltFD5TeZTUEx4iAkk+LIFUD8G4k2fR1dAHzC+FQpm3rlfFTz7syhzCT3hRtEtTs2aJ2mWlhVrWVbynVuUnOdizA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(366004)(396003)(376002)(26005)(8936002)(5660300002)(6512007)(6666004)(53546011)(6506007)(6486002)(41300700001)(31686004)(36756003)(478600001)(186003)(2616005)(38100700002)(83380400001)(82960400001)(86362001)(31696002)(316002)(6916009)(4326008)(2906002)(8676002)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHhQYkVwQkZoSEhiclJNTG9rNkpRWkFVV2pIRm00Rnk5aEhxbDhGVm9GOStO?=
 =?utf-8?B?UkZqYnJjM1duTm5YWUh2QmJQVVJhOWZ3VFVXL0c5SzdiU0o0QzMzR2l6eEFF?=
 =?utf-8?B?MHEyd0c0RXhVd0IrcytRODZJQzkyVDN1RllrYjRHL21FTWQwZzIwVUhUaUM2?=
 =?utf-8?B?OEsxK2JnTnphYlR4MTBLM0RybmttQVl0a2ZUQk5kSFE0aDhhZjZFUE5MVm0w?=
 =?utf-8?B?QXJBejUzSXovc1pPbWlQVEtwWkpONnR1WHlJMmtZRmlFdUt3Qm9iQ1FQVnJK?=
 =?utf-8?B?WmlXMndiM3A4R1R0UlNwMUJVY2MwOE9BYVhjNW9KV1p0dDMzcUd0T1JENCt4?=
 =?utf-8?B?TkhmVlMyRHJEbjJNUWFEU29yQTd4VElqcmN3cWFrK1hKazBqWEdtcHhxa2Nx?=
 =?utf-8?B?QkRaOHJvVVpqanNuNG1qS2tqeEZaL2wrV0hGMUl3cytEcDVzY1p5VzllUDFk?=
 =?utf-8?B?SGNaWHR5c1RKc3hoT2hLK0tudnB0dTJTbE9KRW9BYVd0dUxpUDNkUk9rTmJ6?=
 =?utf-8?B?cGhUS2dxRXBHRFN0dFMyTmtNY0xtRjRVeW9GNjBPMGNINTh0bUc3WjZRTmVM?=
 =?utf-8?B?cVNDM0lZZjNqRW9RbE1GREgvK0EzUEdWRkNSY0VFKzdraE4yMWVIenY1MGFP?=
 =?utf-8?B?RktJQTJZV1NNMTYzY0JtRXUzQjV2dXRmeWQ5TGFVcVVUaExhR3pQRkRLZTIr?=
 =?utf-8?B?UVNqdEprelc1WjVnbG03WnN2bHNqYzNwRDIrdjUrbHhzMlVIN3RlWDZoMEdM?=
 =?utf-8?B?ZDh1dThVTkV4OFdxYStOTk1MeHZGbmhWSnkyNlJlYzExNDdIL2RBc2c3TURB?=
 =?utf-8?B?SHhNZEdkZE1jZis5cERhaVVESVE5eVQ1VW1FS3g5TTJPaFpkRkhGYksyY3Bl?=
 =?utf-8?B?R2xZVzRqS1ZCZEFVT0sxbkMxa2tqNWxiL1o0S1YxSDBBUzZrTUJzUFFYdk42?=
 =?utf-8?B?NzNlY1ZXNWcxcEV6NjJLdldKTjhWdkdNRzBXYWd0endTWFlFRlJqMGxGSWFh?=
 =?utf-8?B?WlQyMm5vbkJRaUR0ZFRSMjBvSW1wWXk4LzFVb0RiSkpMM3F6TXljcTZ6TWsz?=
 =?utf-8?B?WXVMdHhXNWJpOGRvcUxvRUJpb3Npa2tJTmRBdGdiaTdsQnd5STFISUVGcXE2?=
 =?utf-8?B?T011emk2SGMrVS9aWjlJVmRLWDhrdnQ3bUh1elZXRFlNMDdCbGE3ZWFnYXV6?=
 =?utf-8?B?TFFLU3lhS2FzYUZWcG5EYkZnaWttaUZTYS9VQzFabC9NYlBTdmJndW9BbW91?=
 =?utf-8?B?dU5PSXZJMjV3QVFzNHZjWC9tSlpNelkxL1J5U0xYSHRLS1Q2VzRDN2x1dC9S?=
 =?utf-8?B?SkRlbFc5N2tKQWFteG43REJ0eFdPcjJqUkpqRm8zMGN5UElpWmJiWDVwcFpt?=
 =?utf-8?B?Y25TOHFlQ0s5MkVjTUVWRVo5Q24vK1dqYkZqdmp1RFlyajRjdUZDOXJKQWEr?=
 =?utf-8?B?NmppczcraE9XTTkxeW5ZZHptK040Sk9zdDhHcVdTM2JoUVZQY0lxeHNSS2V2?=
 =?utf-8?B?ZC9PK3JtVG1XVG5HVmp6aEF4YWY4bVBEbjNOazQ2cDM2UkhpZHAvczd0VUJT?=
 =?utf-8?B?NmVQUzdiTlQxSUVESk53a1phamNlYlBaaG0rcjUzakNRZ3VSWFBDbG5OU1Z0?=
 =?utf-8?B?UHVPM2NPOG1JYkh3aUhiU2Rnc0VVRTFGb1JoRHBHRlMvNlJqbHJ4R1lvK3BK?=
 =?utf-8?B?cWl4b3NLS1VYVUlCaG15Ti94WjNjY1lLREt6VStURTNFRXUrQ0l2RlBZano5?=
 =?utf-8?B?L0U1RVhraEU0ZHdpanVJcXlpeEp3ZHpwUEh3MHdXcHIwR3NXNkhUbVlXMHR2?=
 =?utf-8?B?WFVoWU1MeVN1UWhqUTc3L2YyeGhpRS9hVi9TVFJXdytqdVE0RFBTalRrdG8x?=
 =?utf-8?B?dkdGdnpHSFFiYWttR25hVkp2N1RDdDdxYUwvVWJ5UGNJMWNmVjBDZHptc0Np?=
 =?utf-8?B?ZXM5SmJrT3Zxamx3QVI5U0lSWm9uQWY4Y0J1REdOa0VrT2xxN2lzc0xMRnlH?=
 =?utf-8?B?UHVyZGVOQ29rd0N1MmlDcnoyUGtpemhKZ05GeURPaHdrRkc3bXcrYitiQ1Ax?=
 =?utf-8?B?R0N4bVRMUm82c2FNcm5NVndGbzFpMW54UWtmbTBSWUUyNC9mZ2wvL3JWdkxD?=
 =?utf-8?B?dFQ5SllpM1ZNWk8rc01zVFIzamlGZFpmVERUSnl5RDZ3NUV1bGNpQjdQNjlk?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf0371e-546f-47bb-2bab-08da7057385b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 05:08:34.0217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVj02JPAdoEVkQ2+eQDrq34pa6novs3KQBv8Ae5zb/CmxH9cnUVEjWfaNjqGyWfqZ1Sh+P4TCQclgBdDcjD/5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1477
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2022 12:05 PM, Rebecca Mckeever wrote:
> On Wed, Jul 27, 2022 at 07:12:28PM -0600, shaoqin.huang@intel.com wrote:
>> From: Shaoqin Huang <shaoqin.huang@intel.com>
>>
>> The VERBOSE option in Makefile has been moved, but there still have the
>> description left in README. For now, we use `-v` options when running
>> memblock test to print information, so using the new to replace the
>> obsolete items.
>>
> Thanks for catching this!
> 
>> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
>> ---
>> Changelog:
>> ----------
>> v2:
>>    - Tweak the sentence to make it more clear and continuesly.
>>    - Commit log changes.
>>
>>   tools/testing/memblock/README | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/memblock/README b/tools/testing/memblock/README
>> index 058146b528a5..d3875e7065fd 100644
>> --- a/tools/testing/memblock/README
>> +++ b/tools/testing/memblock/README
>> @@ -33,16 +33,19 @@ To run the tests, build the main target and run it:
>>   
>>   $ make && ./main
>>   
>> -A successful run produces no output. It is also possible to override different
>> -configuration parameters. For example, to include verbose output, specify the
>> -VERBOSE flag when building the main target:
>> +A successful run produces no output. It is possible to control the behavior
>> +by passing options from command line. For example, to include verbose output,
>> +append the `-v` options when you run the tests:
>>   
>> -$ make VERBOSE=1
>> +$ ./main -v
>>   
>>   This will print information about which functions are being tested and the
>>   number of test cases that passed.
>>   
>> -To simulate enabled NUMA, use:
>> +For the full list of options from command line, see `./main --help`.
> 
> --help will display the list of command line options by default, but a
> help command line option isn't explicitly implemented. I'm planning to add
> the help option, so if you want to remove this sentence, I will add it when
> I implement the help option.

Hi, Rebecca.

That's ok. I didn't notice the --help has not been implemented. So I can 
remove the line:
-For the full list of options from command line, see `./main --help`.

But after remove it. There seems a little stranger about how to get the 
full list of options at the time. How do you think about it?

>> +
>> +It is also possible to override different configuration parameters to change it
>> +test functions. For example, To simulate enabled NUMA, use:
>>   
>>   $ make NUMA=1
>>   
> Maybe you could add "build" before "options" in the line after this:
> 
> -For the full list of options, see `make help`.
> +For the full list of build options, see `make help`.
> 

Thanks for you advice to makes it looks better.

>> -- 
>> 2.30.2
>>
>>
