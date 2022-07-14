Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9913E57564C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbiGNUXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiGNUXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:23:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ADD11172
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657830231; x=1689366231;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/0OJ0nzyrctthLczJgP+qJylBXirm8Qg6iKCnUL7OFA=;
  b=eGs0CO0FB6fYI+3gz9+IDmcf5MBR47IglEjrzrDDTnAvL9bsnd+yrlbC
   DeNdLp/SWOEPSrExb2Zr4MIZ6uohyPGKepraS1l8wnX4EY3WioiTFi8rd
   /id/LqfB72VAOeMbU69R0kfhPgPUI8c5guSTpj59UWtw+ywvI7ZnzihM/
   r4Klyj724Y1CId17LZiZkKgBwDos8XZGfWhHmrp2oCt0mMbPaqNQxEbpt
   lnPizk6oO/q9PZc4V6Hiim9r9d0XQfMQXyYjTdKZPe8EYUluro+HfjoZ3
   pYXsqjN9cN0gnsKgxJ86+gLVvOIFUdx47puAh/XQ16cYbuleXFvaFT/0T
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="371937432"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="371937432"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 13:23:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="654025841"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2022 13:23:51 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 13:23:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 13:23:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 13:23:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyR2a4YemPl3o7Hm2mghUSlUfVE6ViIa3sip7+gzrcj50eDDxL0eDIUVa8QG2+uXRC680xtPykGDvL/0Qj9lpOZs35Nv6Z2EN/b6Kag5+mBzafGHPlZyPiCfZZ3hPj5n4iHxANyiwQcOyz8W3uuxBnyodjUtJT/pEJn3+LN5+9QUHySYOlkgRwjtsBcSWPFT1m/Win6xWMYj3p6vzTPXiCNLrrFwmh5hZK12sMp+Rs6KV/d2tDdbNz01PyjXGmbxbuNyyGYJyxYwNqM/+Vpfx3II/dcgY49thhYRsnAuyxlSz0f7CWsugpplZfcQGxB9wMN+twXAR4xiBmBJ+YlvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3o1va4yO8Q2AKwIw4+jEBpEdMv9EcZOa/9CnE8W/HI=;
 b=RosrtaATu/YOwJh94WqkH7tyaBOt1HfDciRmUXHyWzFn6jqYQS8X3hd+NtD4rjJ0qYJ+3ViBVvxZuhDZ2wmQiURcWsHzvGJA5RR5ghA5T+hGdsA780ivHMSs0msMaVh4jgZcrwc+JUYSTOW9Ns03l4PKmA4EsQCzAIEX0F3kZ2Z2Ef/l42Mikysg+9IQegij9gtDZTRpMS+dwcwEZnouIhMgloRFfuybfQUXgMTthBpPeQIEPyG0I6RGC3wLNV6htWx15iP31G/0OtzjHb4k1JkqWOsBM0ry+RGJ8oi2W7EXekHHdrPgdiEfCFZIfReVcbtMdFGhChg2a5bFUym8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB3497.namprd11.prod.outlook.com
 (2603:10b6:5:6e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Thu, 14 Jul
 2022 20:23:48 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.014; Thu, 14 Jul
 2022 20:23:47 +0000
Date:   Thu, 14 Jul 2022 13:23:45 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Richard Weinberger <richard@nod.at>
CC:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Williams <dan.j.williams@intel.com>,
        "Christoph Hellwig" <hch@lst.de>, <jane.chu@oracle.com>
Subject: RE: [PATCH] um: Replace to_phys() and to_virt() with less generic
 function names
Message-ID: <62d07b5120291_16fb97294fb@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220714184600.3981953-1-linux@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714184600.3981953-1-linux@roeck-us.net>
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eec1cb5-b892-48da-e729-08da65d6c1dd
X-MS-TrafficTypeDiagnostic: DM6PR11MB3497:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0C5v3FSwCgjp4XW1k7ErsalVCwI45kA6lb0ZbeufQ0KojLEzjN25/aJI8qktyr9XlaJVUbupe/ibWdh0AkifUPGDlbhpIE91pUJPTY4vXR9sXQkNMOALvSqLOLNaCsADXFu63NmTeOB3QTMNbIQk7ortDPR62qclfGzmIPe/AUxhhGUSuVyjLjcOujrA8ylw6tqbqBuTHvd7HEdzDrQyJjMcuvs1uCQ0TSehRAOoombuimEDK6FH5EiA783h7pG3i1vBXhwdxe/aWXKUGOmv5kowaOJ3YUl8gRfBCMF0gInOOR0FrolLYZAqvu2aHRWfq9kubi5Mp7D+NlGuIHjdEUYlQ5BJGUyUd2YkOFTJoMk8qd05auuL3e1QKbU72FXo1OdUf+U3JsuTg5nZvbKsjMpv+q8mvvJmdu1/rb7C5KDKSsjhYtJV1UMtdtIh8d/R51bzVwZAjYfHUlRiNJDLMJRdCRa7mXcxFq66NCWLLE5UADef14PPURFblOBUc8cADH6B/5G7nYeiEIZQY7lbFGyOFGKgShxFULaXFnYzcktr1rG/g+kCffTbAV9C4baeImD16kt6rQVQI6rEDI+tOTuNEmR0g25n4Wb3pDrx082DDdagDguklgGzZemwFAmIqaz44if/yF6sVx3c7DlAJPBHLMXxazxdwM7UH+h2ug5FwODetCqEAeU80qTTS+Wo0du9k1pBVt1S8LLqbvSR+A5ikEc8Lrz6nJ1AUZbnUsGyrlGq6w1Cr0SugaHSQDsTXLnbrcHnrz/9pOFC9S+NHxk5f/5y05kFsG9ZriuC271zHH0DA3CxeSCLDAVJ53yMJ+oeTRwP1HiYrnA79ezvXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(136003)(376002)(39860400002)(966005)(86362001)(66476007)(2906002)(6486002)(8676002)(8936002)(54906003)(110136005)(66556008)(316002)(5660300002)(6512007)(66946007)(478600001)(26005)(9686003)(186003)(41300700001)(83380400001)(4326008)(38100700002)(82960400001)(6506007)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGQ0UUZDTHFBT3RjUjJvZW85dytwc3FVNisxbXF0Um1WbUorbTlBWEhoelBL?=
 =?utf-8?B?MVRxQWhrZi9Id1d0NWlnL05NZ2FodHVSNGk5Zk5xVjRvR0M0Uk41QnJSeTlV?=
 =?utf-8?B?REhpR3JNcVo1OU5waXRlajdBWWdteE9qT1EzWGZIT3BYcDFwMHhmZExTZzF2?=
 =?utf-8?B?cFltOVphcGNMM0RBSlo4MGpTUnhiSXBNVkJiU2lnZWhDTVBrbmcrNHFVbmRz?=
 =?utf-8?B?bkxGWFZBc2d2Zi9hOS9tamo0MzFQK2ppTk9FTHk2Y3F3Nlo0cjRSN3Q2NW95?=
 =?utf-8?B?SjdPR1pQMTh3ODhYUW84TTBoNFVqT0ZycXlLUC94cFdYWE9iSm1RaXpQOHhM?=
 =?utf-8?B?WUVnUmhpYTd6Y21OdkJpeTNZRHMxdk9JSS8wVlZTKzhBekFwQXBmNmhqcjN0?=
 =?utf-8?B?MVllSXNZYTJSMWlyMGh4Vlh0Q3p2YnpETjU1aW5pNzJjQ2xoNlgyQ0tFb09Q?=
 =?utf-8?B?azZrem9QWkU4c0RQQ3VteVo5RitGSGI3MGxJQzNFQ1ZOMTV5TTFhWE5iR2kz?=
 =?utf-8?B?WDRzUUYzOTZUZ3dvZlFJam5OTG0yaWtocjZMbHBQYkhBck5rOTVSc2RJdndm?=
 =?utf-8?B?Wk14S1NRZ1c4WnQvYmt3Z09oeFQyQy9DRmNCNWhSYnRhUWZQQkFPM0JRa1dW?=
 =?utf-8?B?M0lieDhtbHQ3NHdaanVnT2FYMTg5NnRpemhaZUR6cmlsaEhacnovZ2tjbjEv?=
 =?utf-8?B?S2sxK0krcVAwelIzaFBCT21xY3ZyMHpoQjMzZ2tFUHhydUxrTU5NN0ZyRW1G?=
 =?utf-8?B?Z3B2REpNL2dNcStBSC9WeDFiSmJrRFNTTk5XVzFBZzgyTW40a3lUSk52elZL?=
 =?utf-8?B?bjZjUEI3S2U5d2tZODJHN2h0a29zUHZ1aFp3eXN5OGxXeithT2VaTitaZ08v?=
 =?utf-8?B?UGY4SEVzd1lLUFRRazV6My80Y21ISkpiSkgyUi93bVhFbFZTM0gxd1Bvajdp?=
 =?utf-8?B?NFJMWXZldG1taUw1ODlPU0JJUG5ROW5qK0g3UGFOaXg4a2JIcWt0eXA3M0JQ?=
 =?utf-8?B?aGd0MWo2ZG0vQWNiTXhEb1NrNUdLUDJyVU1NSXhzWURmQTgybnNabjBySXZP?=
 =?utf-8?B?RkdFakthWVg5VkJZMGx3OW1md2crVmFKZTh2Y2F6WCt3SW45Vm5pRlUrM0JZ?=
 =?utf-8?B?QUpGazdaZm9HYTBDbitQem0weXVtazBaMDdrenZZM2c2c1ZqSkgvVEU1dDVu?=
 =?utf-8?B?K29LbnBramRwNUozZy9NZ2l2Rkl4RldORnp2bnhja2wrTDlCS0cwejltV2s2?=
 =?utf-8?B?ZkhJZ0pGT093RDVGcFd5SVJRRmp6MXUzdXN4Ly9ZekFUeU96dmIwMjErNVln?=
 =?utf-8?B?S0s3SGpsd01nZHN5UkZySi95SDVPM1M0bUxQWkVSUytmaDBvN2hpYWg3c3lY?=
 =?utf-8?B?dmVLZ3h3OFowbnlrTlhZMUtRTkFILzRzOVdsUEpLUE9NVU1NcEFuZ1R1MGps?=
 =?utf-8?B?R2diRC9VTXZTWHpybUE5LzR6TVVkUGNmRW9NUWRtY2x2d29NTFNaaVB2ZWxu?=
 =?utf-8?B?THk0OGxGVFFaVFZHZW1vQThreE4vS25lV1VKaGQ1bXdxdHVFRU01OGp6UHhj?=
 =?utf-8?B?MERsaWFpakV2a29UM3F3MFlySUFYYTRvQW9wb2RkQVBoYlJzekIxdFZST0Uv?=
 =?utf-8?B?c0pEUW1mejB0MXZpcDc0bkczU3dDQUx3azE1czBkcm5DbnpuZ3JiQkNOZ2Z5?=
 =?utf-8?B?TkxOZEYvUnFvNG51TVNMRjlIQ2FtTmZMOElKcm15aVJzSFVRR2Jwd29rcnVs?=
 =?utf-8?B?SDVzeGN2d3BUSzNTV1RKZFhUYVFSVHk5SnEyVjQ4cEF3cXhTbXg5QnVNcS9V?=
 =?utf-8?B?N3R3RXVaNmhDbHBodmpPK1VOcmFSSFdTMlYrZ3RhMjFORlFubjRVR2RKaHcz?=
 =?utf-8?B?Zks1WXRPRHJqMGtLOG5EWWFpSS9hanpqaTJVU09lSkdhZGdjUEhkcE0yQnVl?=
 =?utf-8?B?cHR4SFJHbS84dGdBY1JXdGMvM3VPTCtMZUdraVEyL0czMDI3aisrQTJaRXpy?=
 =?utf-8?B?MkQ4L0c3QzhZemJHQi9kS09GTXRoelRPYkw0MFVjbXlPY29ucFJEYzlMcis0?=
 =?utf-8?B?S3BRNW9Cc3ZTalRaQjJoc0FDZjZIUHhiNEF3UnU5a2J0SVpSNU9uYk1aZzNi?=
 =?utf-8?B?UTZhQ2NOTlVlNkk0ZVF2MEFQeGMyVGdNQTBqWGJnYWxqUEFJOW44K1BiRGc4?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eec1cb5-b892-48da-e729-08da65d6c1dd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 20:23:47.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQp09Bga8oXHDLnZWS1DNe6BM7q+fNSo/kOTIGuK0DsNbgQ6EmXKzDa/U65X4RyRPKOlI2BVhOX610PMk6j19/+fKNn5deGVTRjHiwvRws0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3497
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Jane ]

Guenter Roeck wrote:
> to_virt() and to_phys() are very generic and may be defined by drivers.
> As it turns out, commit 9409c9b6709e ("pmem: refactor pmem_clear_poison()")
> did exactly that. This results in build errors such as the following
> when trying to build um:allmodconfig.
> 
> drivers/nvdimm/pmem.c: In function ‘pmem_dax_zero_page_range’:
> ./arch/um/include/asm/page.h:105:20: error:
> 			too few arguments to function ‘to_phys’
>   105 | #define __pa(virt) to_phys((void *) (unsigned long) (virt))
>       |                    ^~~~~~~
> 
> Use less generic function names for the um specific to_phys() and to_virt()
> functions to fix the problem and to avoid similar problems in the future.
> 
> Fixes: 9409c9b6709e ("pmem: refactor pmem_clear_poison()")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>

Acked-by: Dan Williams <dan.j.williams@intel.com>

Jane had sent a pmem local fixup, that I was about to push to linux-next:

https://lore.kernel.org/nvdimm/20220630182802.3250449-1-jane.chu@oracle.com/

...but I like this one too, lets do both.

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/um/include/asm/page.h      | 4 ++--
>  arch/um/include/shared/mem.h    | 4 ++--
>  arch/um/os-Linux/skas/process.c | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)
