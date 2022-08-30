Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3D95A70D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiH3W2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiH3W1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:27:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8508E861E9;
        Tue, 30 Aug 2022 15:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661898389; x=1693434389;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B4IcvOJz3gAZtHIj+YSEMn8bD0JVroxoCupIhCFuZQc=;
  b=HUr8r3u/grvpQiArzgL68ITeAGhl8UDKlwqaxVg9OpmPKZM1T1R5Kn+2
   F0CidTtlr6Jflh6qHZG0DR7qFd5KruXqTSWvCF7sqek+IGYhybusxm1Hg
   UDFWjPPH6JTkjxudrqDdngk75UCHHxNpoNjWHDwCka0IjcV5VPB+OVt8b
   F/Xeuoz06ozFHNGl56H6IG+StfRXQLRkxYkzAjQ7veun9hlrrWz7irhZj
   3RSTvmZAMCe8nhv5YsJgwE6tbP1joPsFVRzZUnm1h3DFy3SW9U4poZHY5
   PE3x59kM0Yy+ffISYOqNHfW/TrT2jcGrTS2FnzXbI9xsB1XUZcaNLWMhK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="359280360"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="359280360"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 15:23:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="641592726"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2022 15:23:24 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 15:23:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 15:23:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 30 Aug 2022 15:23:23 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 30 Aug 2022 15:23:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDKS3U7ks7oEQ/a/FISBhulSEkbqmz27x+1pUonGpmpu+DB60jWkKZ6Fm/lIEgLsXjUD5vGk2hQ/7lxAfSVs/Zq3wmcYiXCETS2UB8aEKNXE+9N2hOocR7dkI7V4nE+FwWNjyv3/l0sN5WxGBwV2tTFO4eT5PQgScjydOYD0Yg0GxHBEYiqWMh9XjHOEfhF4nYI5jNxFS+BGJ0bZDhQIgUEIFqU8Kb0juL+SzgXvFgg3K6tfHB1IaWtgCIfk42uKitQdzhV2AY7wB6QZ/B82GkR7Kpyx0ddqngnaljvi4qB7OBr2Xt1dTnAvb/rLDQKXpb2FyB/Oo2Q79a63HkOizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YhOek31gTdn6Uwyt+Io7RsnSaVKWLuqP7Ll3sSvnxY=;
 b=UoY2D/ngEscPhAeqVp5GZAbZg+J1AG48bu4Vq//lFK5wvXGpdL2HLTeKz24J0Zpdx17kqdk4J0Qa1wBgpQWMD8ChOY2hij9NO/GdXGpAdIQ8yJdTAm7EstmCchjFemxx9/BQNLdJMU7ENogr6FG6G+alLRumiQTbh/8tcoOrbF9uIxJsw+DftKeGtOe89awjBypPvEqVZA7BP9X9mH/Fd3vOsokYLYlD1GL/Lbi3+0aWKRuB0J4kEJf+S8ohqhNRwCGcuiXy46iqKTDxhpwx8bO2DtX6ln6YKeWOjHuGdGxsD/dEMmWmCBTq1GpmkQAXBDH+qkvAaAURzDYNod4Q6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5560.namprd11.prod.outlook.com (2603:10b6:408:105::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 22:23:20 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 22:23:20 +0000
Message-ID: <a0712968-973b-b1f4-e955-bca2925fd79f@intel.com>
Date:   Tue, 30 Aug 2022 15:23:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v3 02/10] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Content-Language: en-US
To:     <babu.moger@amd.com>
CC:     <bagasdotme@gmail.com>, <bp@alien8.de>, <corbet@lwn.net>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <fenghua.yu@intel.com>, <hpa@zytor.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <tglx@linutronix.de>, <tony.luck@intel.com>,
        <x86@kernel.org>
References: <9965edff-c558-2962-4aad-3342480026bc@intel.com>
 <20220829232554.53763-1-babu.moger@amd.com>
 <59259155-6c51-a750-216a-ebbb0702d200@intel.com>
 <3aa991a8-ac08-297d-8328-5380897f6dd9@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3aa991a8-ac08-297d-8328-5380897f6dd9@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::14) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b00696a-7810-4473-0e56-08da8ad63e82
X-MS-TrafficTypeDiagnostic: BN9PR11MB5560:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98TnkFXOjta80nPoXZgI9dLDoOAXRXRYo0zYuOUyKCj2SVDAWn3MpvTZ3NafOf7enGD8GhfJEgGcL0nwHa/82IWbcwAMct7M06s0DaY1DiSDVvP24ZpGbKcY/2d5kkc8TPm6bOpw41l3syAGabUCn9Q4MBTlZudcm2+q4XXhb7k1rPejdStA2VQh2gWsIdOfQ9X964dt4/k0ewcOwGb/OtpOuoXEQq2X6quGxFLmBjnugtzeNLZ5HJDWCQfDJHy2e5vtK/dRKYlIiXJIUBiMJz0LWmSRAvL804MipAQbuH+uEfxmF2ojbjgkwcMaSSMoZDJduZrtCMW6jRyYvuRY2HVw1/MUvNPMwfXFXms1v30iUfb94xPJAGd7VhJZVoBMuVrnE1miqccCVaYs1BRucvpZGJ7rkIGut1O47V0TR7wXaxc3B2HGANiXJFGbvqr+7Gx5Eu0SoX156RwddaeJD/KQSoihYdTBrBA/B50CL/WTv780Bal4C/c6zxzIhj2nQWIgUSuQn3axeNvJ3Q6TXqtiLGAvh88iybUkRJejJcSGUEOz/nz/Wi7oUGMhbjDRtORw02PDfGftUP11pZud6JRysgHwQX1XsTa7GOnCPE/IabtSBU6vDwmeGA7hmGTSdL+v96hC/827/OZlJ5aC8c8H2UFkOi9wxwsLmmYsaMgVc22dZUiHV0s2JPuKoQsjbtUY8aw+KieFXSLkh1IcLVOaHa7aDw1kNXTPIxrCtunZMIROp4U3Qo/VmEnNiTGqGnHnI7fn3pSY5J6CnlrKqZ925GAO+l2YP07Iqba6WlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(346002)(396003)(136003)(39860400002)(186003)(8936002)(38100700002)(6486002)(2616005)(2906002)(4744005)(478600001)(31686004)(5660300002)(36756003)(44832011)(7416002)(316002)(6916009)(86362001)(66946007)(66476007)(8676002)(4326008)(66556008)(82960400001)(31696002)(6666004)(6512007)(26005)(6506007)(83380400001)(41300700001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0RtZ0V4QnJJbmZBU1l3VGJ4VE5wbUw5aDZ2TlRCU2ZyOHI2UnZVZTR3SE9m?=
 =?utf-8?B?aEJVZmxaa3RFdWFFQnlEQXFHQWpHcnl6S3RmTExMYyt2UDBwb3hjOWpVVGJP?=
 =?utf-8?B?RUs4VWRkRDQvWHk1bVUwVFNWK3JPbTJTUHFaK2VNbkZ4dHRmNld1RVhUYWRN?=
 =?utf-8?B?RnVYSG90dDh3ZjVNU3UwdjIxZUFWTmdzK3lFNkFGSU9hV0xXV09PSGI1UWxy?=
 =?utf-8?B?ZUFmMmtObWpjU2hLVnRpSnhhRUpnQTFmZHZOQ0xINlY3Ym5QRko5M0U1K2RI?=
 =?utf-8?B?SHpwRmxsaGsrWjNVTHNBUW9TSjdQdmp5TXdEeFpxcjNKM2VqYkovL1QzYlJ0?=
 =?utf-8?B?ZUZLWmtlYWFKV01IYTN1b2FzbkNMSVZjTVp4MkNzSTgydkVObndrVzN1TnMy?=
 =?utf-8?B?VlgrK0FuRXVrRjRtZ1VxVkF5QkNlVjJFNGRPZ0RuaVU5eUlvZm82M3dpTnBM?=
 =?utf-8?B?RTdDalllV2hDZzdRblZrTi9KYWpwb0NHeXZCb3Q5MFRncDVNQi9hb0lCZ2JJ?=
 =?utf-8?B?ZVR2V2Z2aTZETWUxM1FkdW1WeUM2SVphNldyU293UXB6N0lmQm53cGVQenA2?=
 =?utf-8?B?Qzg0UWE1aUx1ditTOHFvclpFWGZ1N2trYWtaaFdldEwrRXFnRkJXcVRpN214?=
 =?utf-8?B?RW5hbkF5M0k0eFVkQXhsaE1XVTBIZFRRMDB2dnhlS3IrRGNLbzlZNGRramNL?=
 =?utf-8?B?UU5FVk5OVjV5T3NFS29pbXpibmxnMUwrL2NaUG43M2tzUmdraGhLcERxY3lo?=
 =?utf-8?B?b1Y1WURUL2dQMHNRTVRvakhlUTAxbXEyUDdRaHpGSHMrVVp4dGI3a0NxVTho?=
 =?utf-8?B?cjVLVnJmc1d1N0c5emcyWkgvLzkwRm1ocjFIQkRjN201NU1iaThjVGNXT2l0?=
 =?utf-8?B?WFZYM01FZUpiamV2WXErcThkOVVsd0ZCR2ttdmMwSjZNY0p0ZGtnU0xRVW54?=
 =?utf-8?B?Yy9ubmFaREV1OUFaZUFPeUJJNk5mRFNPV05MSVkrMmllUlVHem0rdGhxNGJH?=
 =?utf-8?B?dktRalQramRWM1FDQlFkb090L0NmTWNiV01NcGFIdCtQTk9PQkM0Sjd1dUcv?=
 =?utf-8?B?TUtQV0NlZG50M3RRbUltaHhUejJQTE1WMWpqMzlsbnNpcy9HTCtpVk5qMG1u?=
 =?utf-8?B?Tk52L3QzWEhxUDZ1WmNMSUhsNGFTTCtiYWg4Q0JWYVRBdFVuODB3cWk4Y21w?=
 =?utf-8?B?aVROSUs1QW9MQTJ5cm9lVDdUTExWVDJYaFRDRWhSVFZCaGpIeklGeVFzcEpE?=
 =?utf-8?B?YkJ0NmdEdUJHMzh1TGNOZlhhYVB4ZnIzcHBHR3RkTmczMHVoRXVYY2hFczA1?=
 =?utf-8?B?K1N6RTFFcGQwQmVYbTVjdWJIS2ZLQlZBSk1GbWdBNW8rRjZXc0lNbGVKV3Ba?=
 =?utf-8?B?UitZNEkyZ2FwZ3FqenFUZ2tFU1ZDYzM2MktGNGFhUFZXUExjWUFHdEtITDYz?=
 =?utf-8?B?Q0Erb1crR1JwaXBZbTNWZlZPdkNtOEpzOXZ4U0Y2amxuLy9RY2J5UjUvcU82?=
 =?utf-8?B?bjZmZTlTUFN5UjA2MG5Id0RhTUJMdStJV3R2eE9ZVzUzS1FoU1E4MFF3clN3?=
 =?utf-8?B?NHMzVG05a1FFMW9CWjU2SkdIclUrT1ZaSVJmUkNpRkt4d3Z5Z3ZNL0dHekdS?=
 =?utf-8?B?OGoxMU1hS0t4Z0tsVHoxTmgvS25wdmN5ZFJuMlE4YTN5UkVzdTBiRWZSTk5X?=
 =?utf-8?B?ZEUwdmh5Z0dmTytUbVVlK2ROVFJqaCsyaTJFYXl3OEd1R0dlL1JsOEx1dDlH?=
 =?utf-8?B?cXZQTDBWSEh0SmZDZDRJQU41N2pFVzg2UXJNQlpva3lzNFZUQkQ5ODQvckRS?=
 =?utf-8?B?UjU2KzhKUzBmT2R5NksvSjdUbG1ndDhUWnVvRTJ0VXNVMG5YcDNtVUVRcWU2?=
 =?utf-8?B?WXdwajRFWHlRWWFYek5sNHZjMXI4Z0E1TE91MDBuZXYzcjJtbXlLdFZQV0ts?=
 =?utf-8?B?NmpMTk1pWFhyMXdHTTE1bDIwK2crTWFWRWp5dkhaNUVldGVLRXROK0RVN2hS?=
 =?utf-8?B?N3R2ZXB1d0tBN0t5U2ZsbDMzajFxUHc3cHZXVzQwbmkrcXhxMm0wRWw0RTlF?=
 =?utf-8?B?YTE3QkUvbitmNTZxbkM3U1A4TGtpYk9KUm1Sa2FwZXpCYWhtN05GcFFiYkxw?=
 =?utf-8?B?MVhYQ1BjRVRhTXg0SEpJckplNVkzWnJtZjhUQUU2Z2FpSG94eHA5S1JCclFK?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b00696a-7810-4473-0e56-08da8ad63e82
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 22:23:20.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFublIdTow11VguEt2cFFsZSl2vtecoo2SGxfnexAF8l+HWfgG1teWFye38nlAoK0HAQo7rU5gcFqhkkP0b6DW5Uc7bpf/dsDWfMrbwsmi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5560
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/30/2022 3:10 PM, Moger, Babu wrote:
> On 8/30/2022 11:39 AM, Reinette Chatre wrote:

>> Would the "SMBA" resource be available only when CXL.mem devices are present
>> on the system? Since this is a CPU feature it is unclear to me whether
>> presence of CXL.mem devices would be known at the time "SMBA" is enumerated.
>> Could the "SMBA" resource thus exist without memory to throttle?
> 
> Yes.The presence of the SMBA feature(with CXL.mem) is independent of whether slow memory is actually present in the system.If there is no slow memory, then setting a SMBA limit will have no impact on the performance of the system.
> 

I think this is significant and should also be documented.

Reinette


