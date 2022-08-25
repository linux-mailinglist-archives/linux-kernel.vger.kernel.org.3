Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC58F5A1632
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbiHYP5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiHYP5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:57:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB43178587;
        Thu, 25 Aug 2022 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661443022; x=1692979022;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VeglbT0NNbi7QmPMpFts5auqfNVgAQlfSqmrrvIhTBA=;
  b=AHZfACvBqpcHnoKWnXoBz/NJkMG3t1ZmikeZgBPz+mOsIkjEcGGNy2uE
   +vYN+nuFmFBl9FDTS53NKjqAK7z5SQJWNbbSGdZcLsgGn2IK68w5yS38q
   FTgOdy2TOKD+nGZFEO19b8ckb30FuQm6h7beba7sGZW0YJ9YdLGyfQiyf
   Im7ez4JcyF4eZ86IC+9uQ3SOVhc2KT8u1HSLVut/GmFm3qMt1ByLs8Ams
   XyWii/YveBAfgk9uqtRnZDc3MfHl3BoKN4aahDti1/KAhFodu860kV/4m
   +8Ttg1k3TbOmUow5LGToishYoKcOhnCFGnVbWc3gyjxyKtlK+vjzwLAHh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="293018442"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="293018442"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 08:57:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="561075852"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 25 Aug 2022 08:57:01 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 08:57:00 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 08:56:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 25 Aug 2022 08:56:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 25 Aug 2022 08:56:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7ELcfP2Jq0P3wDr2VH2zEb7KJn75HmbhPkHvG30eZePN696hN5wXzfkWzLBmdwbfW1U75zUY2XWjzw28I7/FjLHvLUJ8oKA1lS9Mw2vAao7BztJScTM/oUamoMNbl+q7j6JEH95wX5I+oVsVrFyrqz6f7ryqrIDldni+97u2/88Q+fBZwjeu0BlFqGSPqZZvhLqb45mbAwEr6LpcrHZckXDo9eIYwQFnqsP82wztSd82EHzExEiNvu8oowwcmsF9cBGruswg5lItPMYZrJFdtmKQn0veM4KZkuFxIvtFQPej8t1BIcGrAI8kQMMDzUF7zMKMI8O7ujpOWYeCBMfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsmBOEZ+5sfGG73V01zxYxjVYwDrABufYYgG3JrIwg4=;
 b=XzkcKeFc82P/LNny2YcSTcewqR+DHRluvsy6990eyS8J69Ja4U77006dVm7Te89BIT1+jBnqfPTID1jyTkRQwJokeJAtiSTkrnzv9vX+QsgwTy0wA5E2tjBjN1VYZ0/RuWedAOsIhTXcUvipyXyYN7Ua1jWmZbOlsDb1ovVC5b/PBT7ZF9unxw+y+uSqWYU8p9Pb5S/pPW8KYt7KbEcAKpD/hXH0mTL1FM6Soyi6SeoSUzheT+k0UXb57+l8Kx2cyqPGoE98/b4buneYHrVG/jfW4Aa+3Jggxgi129YASzfmPy1uIaXedkFpOoJPZcevflVFqWF32YOjTAdhCefo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN2PR11MB4758.namprd11.prod.outlook.com (2603:10b6:208:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 15:56:57 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 15:56:57 +0000
Message-ID: <93d1a26f-559f-63f7-d2b1-e8831a9df62c@intel.com>
Date:   Thu, 25 Aug 2022 08:56:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v3 06/10] x86/resctrl: Introduce mon_configurable to
 detect Bandwidth Monitoring Event Configuration
Content-Language: en-US
To:     <babu.moger@amd.com>, <fenghua.yu@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bagasdotme@gmail.com>, "Luck, Tony" <tony.luck@intel.com>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117582698.6695.3458866624522799072.stgit@bmoger-ubuntu>
 <575bf1d7-8780-8c54-851c-e9849d1815f8@intel.com>
 <5d650c6c-2f17-6013-f63f-49a182961494@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <5d650c6c-2f17-6013-f63f-49a182961494@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d64d6165-f368-410d-78c2-08da86b27011
X-MS-TrafficTypeDiagnostic: MN2PR11MB4758:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tf4iAgPRVqnc1fY5+0cezvkTOPGFRGxbEx0gPPL21Rj6qAYWmS6sjGMh8geCMTnkMTjN/tspgFVkWtOVhzWn4+QyEdiwA8AUtnrfjdGVZhJpQ04e4H1g9gNEyrnC5MFj67HyPBxR4o0FGFRJzV8KGVbGj/VC90S26kTH3RLBNFmEVoN9Ve/ONhwUdYJhMOlhOMcIWDoRrhxsHnAfm3/0VU/XP9spud7/tLn4ZzxUXpYulGziJ6SSEUQGeuFxHUuMp9FzSrU9CvnXH8+tXo8fpMqvCvNeGCD8+b6z7hTTSpZmfpk889SbXLO9JC/dJT/ilITx2qw4OsMz3QUAE575l/BSyrwH7gJF8qVegZM+78S5cDiODwY1QEk9YE/P3nF2HSjgFmwYMeW2dqhDJz+1sTyvdEpccTHn16L+SlC58h/eFYNUJMwlxM1pKxj3dKQJbmbttV3OyZ6pDUaY8mUFw6V25TSCpFH6DnxI8lFrX9KcSYLyhK142me8CsiRv3BnMB4FZKZmc73uvwJlhnIr26RK6BG/I9mBTax+NFHaS5TIEj6IG8Vn9cEJJbulhajLnLda7T9Trj3K1rMPB9x7nK5bp/sbbtYotqogE3MUMQHlj4u4RihqnxD6nz19j/vuiSn1k12GUPFB7FQNrlKLyW83E9PXNo2TbRFuQl0dGGvJ14I7BUChy7lsNqYxUkjlOsYCNFLgkomCQRW7sZfiJvt0SfqQT69evO2K88uF6TzcVlYM8XucSO3VZJE6mpB7DqTR86HIQlmSGGqrqSV88vj2oJ1+17DxnvG/RCR1SUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(82960400001)(2616005)(83380400001)(38100700002)(86362001)(31686004)(66556008)(66476007)(31696002)(66946007)(8676002)(316002)(4326008)(36756003)(186003)(8936002)(7416002)(6486002)(5660300002)(44832011)(41300700001)(6666004)(478600001)(53546011)(26005)(6506007)(6512007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEIxZHk5T0tPQ2RsSDJGcDRIMGFyL3dZR2RGZjlNTGI1TVFpaGtNMXZyS1VY?=
 =?utf-8?B?TGFJckhGV3llWVZiZ1k5UHRCN3RKcHRkd2V0bXQ1eS9wcTZzRkNCOHJpT0Np?=
 =?utf-8?B?ZWp2dVgrUHI3dGthM0ZtSUwyeHlNejZuSTBucGlUZ0RoMXoxemxWc0hJdy9B?=
 =?utf-8?B?ZEJleThYV3R2MHVoV2FKTVZGYnJRbkdVT3ZyNzlhU0ZEWXhNUHB4ZUxmOGto?=
 =?utf-8?B?TGs5dEVreTJoY3Z6OHB6eEp5SFlkcEw1QlZXTVVPbi9hQmZKV3hFbnd2SGV5?=
 =?utf-8?B?TkoyRzZqbnZrSFpwbjlvQ2Qxc2l3N2FZRGRaWHk2c2s4bXdFQStmVGkzNVJk?=
 =?utf-8?B?QmJqREtiZEltWTZCSVY4YlJtY0dBN1UvMVBDdER2RGJxOG5xbnlqejhNNytx?=
 =?utf-8?B?TElyVjBnS1h6Q242RHpJaG04WW1UVFZkOGErZjY2UVFyc0pnckFWbW1ucEhT?=
 =?utf-8?B?cThSbktRZWwzY25zbUZOUGxZbnY1OWEwTHRRdUpKSi9jeU5jL3NDNFZmTkhH?=
 =?utf-8?B?RHdwamdsSWp2ZFJYNEh6amtKTGdkY0JwYmEzaVZNUEdxOFE5ajZndXJ4QW15?=
 =?utf-8?B?aUtzLzFCRmRnRFdaS2VVZWRHLzFFaXpneXJIeS9nc2kwRVNOYWlzRmhYMkpa?=
 =?utf-8?B?TkpsWVN0Z0JKcmVlRlk5dXk1SytVemtkcHFpK3J6RklGVlZVd3NySVNlTDJh?=
 =?utf-8?B?UWNJMUVuRnpUK1Y1QytsamNCdkpPeE13KzlBTzZRQ1lQNUs5QUNsZjZCQ1Yy?=
 =?utf-8?B?VzBYVjRJY2V0b1FZK0JiVmFXODJnd3QrQnlVL01IUGxtWDQ5UkJPQjM4alh0?=
 =?utf-8?B?Vnk1eFpITC9TNXNUVDNDZ25obWFYdGpKOVg4WXgxV1lpYk5nd3ZuQU10WDQz?=
 =?utf-8?B?cUxxTkZQSVlmcFlleUxJdE1nczErSXBPOG1rUjcwckczUTZwRGFXWG16ZWJU?=
 =?utf-8?B?QmlETkZ1MU5BNTVuT1ZYZjE5cFArV1RJZ3I4akxabTJYb09tS1NsZzRBelV0?=
 =?utf-8?B?NGI2cVpsVXl5V3lROUlLRGlkOEQwa21tVXN1c2JMUTBZY2R0eTJjVzFzRC95?=
 =?utf-8?B?S0JnVldwS3Jyb3ZRVUlTOE9lVjhlSkJ5dElyN0VGNENpaWs1SlpBbC9PeWFO?=
 =?utf-8?B?OFBsczBoQ0dnb1dxeEM4ZWY2N1ZuSzl6ckxJWGlCY3A4dVI0ZU5MbTdxc3JY?=
 =?utf-8?B?d1BwQ3ZnaXNRMzNWYVVuUnE1L3pNTFBTTTVEaVMraWx3WkoyeHF5dHVrb0JW?=
 =?utf-8?B?cDgrU0huOEszQ0FBWmJxcFFWdW9BTlJoaFlQdHJsNFJnWFl1bk04RWIyUzdQ?=
 =?utf-8?B?clhwa052cFc2RjZsUEVPN0Fnekd2WnNkYktKaEVycjYzSFNGVGtZTVFlUXIx?=
 =?utf-8?B?R21QZFR2ckJaOHBEelFWeHk5OG1nZklZMmgvajJRMWhOSjBzdXUzNGhwWUpr?=
 =?utf-8?B?RHR1Mk1yeTlqMUNTSmlwYS9HcGRHSlJneUhubngzVmJ3K3gzb1pTMHdSYWJm?=
 =?utf-8?B?MGptdG1XRFlOZ0xFemFsRE55RzBrc2hHcVJYY2Z4WVp3SEEybW10TUh0QWpB?=
 =?utf-8?B?WlZrNHJaVmVkaHNvMmxHV2RiMklWeUs1R0R2OXhSOXJWT1hCakc3RE5SWjEy?=
 =?utf-8?B?SEF1VXRiMktYMTRNbzlJRE4ranJOcllIbklBeDhCckR2ak9rZi9DTTl5RWNl?=
 =?utf-8?B?UzlEWjgwVGpsNzdFWUdOYUg1UVZTczQrMjlOMFpSRGl3UExQeW0wcjZON1hT?=
 =?utf-8?B?UFpjUThBZWpwQlVITUdKSGVMTXl4bVhJaG9CWW5JQ0x6dVVzRGJqQlF6NktC?=
 =?utf-8?B?MS9BMUk0K2JxNGJscUczSWZiS0FtbUJVUEJFRktRWnduOHZqNXFSWjhUVXU4?=
 =?utf-8?B?cUhYVVBCZ2Qya21GSThjeHlnVEd5dXJVK3J1dzE5czMxT0FDQ3g1ODlhb3hz?=
 =?utf-8?B?cjZUemdyTHc5ejJyejBQVm1rZ2NQOXA2QjZ6Y0llbUc4WUhIbStNeDJoWDd6?=
 =?utf-8?B?SjVZN2g2dEZZQldWNUJ1MXZrNEVTZUFRQmlmUXJNS3FocDZiekN3VDN2WWo0?=
 =?utf-8?B?dFV6MVpyTUdwK1hKT3ZyOS8zTHU2T01WNGFsaTE0MWowVmp0THFHcUtDaGUz?=
 =?utf-8?B?SGJXWm0yTmd2ZFVnRmowZHByWkxrU3VrY0ZoTklGQk1ENzRtNGF0bytKcDR6?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d64d6165-f368-410d-78c2-08da86b27011
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 15:56:57.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXFBT0yGdbbkPGSnX8jFPdAbqdLBwb6Eo1aHX+lVLX/DTl8IPkbVxpsjZcIyfndJ42GLbqcHruBuxnbhCZDQ1PDf++bhcUdbyxI/e+p2Ze0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4758
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/25/2022 8:11 AM, Moger, Babu wrote:
> On 8/24/22 16:15, Reinette Chatre wrote:
>> On 8/22/2022 6:43 AM, Babu Moger wrote:
>>> Newer AMD processors support the new feature Bandwidth Monitoring Event
>>> Configuration (BMEC). The events mbm_total_bytes and mbm_local_bytes
>>> are configurable when this feature is present.
>>>
>>> Set mon_configurable if the feature is available.
>>>

...

>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index fc5286067201..855483b297a8 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -995,6 +995,16 @@ static int rdt_num_rmids_show(struct kernfs_open_file *of,
>>>  	return 0;
>>>  }
>>>  
>>> +static int rdt_mon_configurable_show(struct kernfs_open_file *of,
>>> +				     struct seq_file *seq, void *v)
>>> +{
>>> +	struct rdt_resource *r = of->kn->parent->priv;
>>> +
>>> +	seq_printf(seq, "%d\n", r->mon_configurable);
>> Why is this file needed? It seems that the next patches also introduce
>> files in support of this new feature that will make the actual configuration
>> data accessible - those files are only created if this feature is supported.
>> Would those files not be sufficient for user space to learn about the feature
>> support?
> 
> This is part of /sys/fs/resctrl/info/L3_MON# directory which basically has
> the information about all the monitoring features. As this is one of the
> mon features, I have added it there. Also, this can be used from the
> utility(like pqos or rdtset) to check if the configuring the monitor is
> supported without looking at individual files. It makes things easier.

I understand the motivation. My concern is that this is a resource wide
file that will display a binary value that, if true, currently means two
events are configurable. We need to consider how things can change in the
future. We should consider that this is only the beginning of monitoring
configuration and need this interface to be ready for future changes. For
example, what if all of the monitoring events are configurable? Let's say,
for example, in future AMD hardware the "llc_occupancy" event also becomes
configurable, how should info/L3_MON/configurable be interpreted? On some
machines it would thus mean that mbm_total_bytes and mbm_local_bytes are
configurable and on some machines it would mean that mbm_total_bytes,
mbm_local_bytes, and llc_occupancy are configurable. This does not make
it easy for utilities.

So, in this series the info directory on a system that supports BMEC
would look like:

info/L3_MON/mon_features:llc_occupancy
info/L3_MON/mon_features:mbm_total_bytes
info/L3_MON/mon_features:mbm_local_bytes
info/L3_MON/configurable:1

Would information like below not be more specific?
info/L3_MON/mon_features:llc_occupancy
info/L3_MON/mon_features:mbm_total_bytes
info/L3_MON/mon_features:mbm_local_bytes
info/L3_MON/mon_features:mbm_total_config
info/L3_MON/mon_features:mbm_local_config

Reinette
