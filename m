Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67DE5A85CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbiHaShq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiHaShH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:37:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7359A1132;
        Wed, 31 Aug 2022 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661970814; x=1693506814;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mwW7Ju5X/cjXcL4Ts2vFzRy0S80Vu1uZbxchiLiSLUU=;
  b=bOp50FTgIgecWx9/SmH4hdq+ikaB2qVlYAzh0BBb4xf1HibgF47c1BMV
   RmnQSoJ7WNJCvz90wgg0ToGtluLSSLsmfLafg2xSGSm73bAG5olDHziKd
   R72fMOuBccZCPEzx6ohtMpCWUZtOf/Xo7PYGZZQR65pv+nSfdkFKzVHaF
   VfoTTOOELHW4NOz9afQv6k0l5S9zlNfAMfzOojjHppob2ywYrrD2mOsFT
   XzYV14y7sc1XuqnzhkjkNmZ4Id5sqOl5vh+8cSM0ibN73bwvpDFuc7Lb7
   TSXFj/wQKwjeEM6MsaaN42CbamxNckeaplt2QFa/152TdxupTH4w6+liz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="293093537"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="293093537"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 11:33:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="589132750"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 31 Aug 2022 11:33:33 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 11:33:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 31 Aug 2022 11:33:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 31 Aug 2022 11:33:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJKcXX7eIQC0v5JX7PUoZ8kUhspIIaLKMGbzHPbUUmriwslsMHQcwyhMaV+cPOojVgPhxsGkfqFEDa6QWEo/vn0OZ4SHJwkYUneOQVVYELkc0TQ81PXPwJ3ygDcwEuwN+hGRcDF1/c0nhnjC87xAg0HZhRWoYBsrUWiF5sDjDIsIBDrCxQ6K5zO5N7OkNL4YiW7ybCulPpzJWPAosyvOfqgpNXuVoavLcIX2Ia6JdCDPE4PhK9WgXrSKvHkJIVBYyHoPncCwxiiPFF4liF0kkkBT0w4z+bfPNHXM0ba24LDv1eLAEyqOYiL4Q/ZNcRMye+8Ohn0D4cfgm0dFiRNklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaDbWD9qSnqY2xEHfFh73t0VzVNU7bJ68nO/ALuh3VU=;
 b=Yztd6HdViln1MceWJ3VQ8eyjGTLuFXEkW8HrZEoyxkcExCrRGZd3avspIcIuPkBHcweajc2gr4fihtnFAiMLI3MnL41FSXLy9GNVBPkiLg0gFiHEfaettt3+sU6r4qyZqGBycbWdpqkFfIKmj0Ax3QaC5BrruEWJ65ooG9dSK9EDyAmQ8RpA8DFtr7To9LDUH6ksjcHL/JzEpU+4E/rYr3+JLsXaZWuDrlSd6WGtfJPCGRKNw5quCfACsq502ISUBrI9qDzOoIlb4KApZxLRcigjHnoojWPsbCdwEzP6ga/yiZm55vmt9YYwskmY5Y18rVMeMfHp0PBhsZNK1ExFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA2PR11MB4906.namprd11.prod.outlook.com (2603:10b6:806:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 18:33:31 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 18:33:31 +0000
Message-ID: <4c24e461-5ac7-7d79-9764-52f8fdfc311e@intel.com>
Date:   Wed, 31 Aug 2022 11:33:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v2 3/6] x86/sgx: Handle VA page allocation failure for
 EAUG on PF.
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <linux-sgx@vger.kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
 <20220831173829.126661-4-jarkko@kernel.org>
 <20991fdc-1ae4-ef68-c6d4-12372b4e6f73@intel.com>
 <Yw+mtfFs3dvOWOv2@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yw+mtfFs3dvOWOv2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0055.namprd16.prod.outlook.com
 (2603:10b6:907:1::32) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 240bb3e8-f0f6-45a7-41fc-08da8b7f4e0a
X-MS-TrafficTypeDiagnostic: SA2PR11MB4906:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upCev8AvQH0bFodUN8waNlNYm8jjiCRta0KPDtZK7qr1vrheNLYCoBv57QTRjQT8NuV8ViLstJ0wxYxDNfd1U5UWe7rvksIl+z43DasbjTF/Noi6KdDPITsip0o4AoTc312YLR8cmkdBr3/DGgtyHsIClaTdjoFS7gSw6yMCXhggEuKQlCxDvff75KdvocVE6fDy4nhuGuc7H3UixYpdSW1Mjxi7ycz+mhSsb2fgaedRqTnMB+/fJztTvhyrTd4N4liCJ3mNSMGeftO83lR4Nsc5Vey7SvEpO9t2vSz+R7KWscCq6JKlif08sBo/ZztqBbnqxMt0F8tEChS0tZMjMRGXjTZSzQHyoO/rL23zInlvFaY2coA7xKYz4g0Z8JT65FUahuMQ2dokkJ3MDPfFfo40h8p9RuNkhL9wRteuxxxotKYA5fsTRttbQvrQvU8fgRJ9IB2kxajY1yDZUbVN/9D+irnt1uNdnn0U8r3UxVlNE31kXWBQtErInm8Ugguy9Hr1UAvToyWTxI6ennd78IfqLY/pznMqD+Spoi3N0cUfD/q0devL5JJk1ZEBkUXzkeprf8QrGkZKr9MAiD955HceSgUIB5tJ9lOZrcbI8Qb7GBWqmXLV+mb31I3KdjjiG+GsPrS+QWmQMdRQXVDFE7xMxwIzuFifWYuUHyaUaLaZITWOxXYIGn7G91c/FbkiTYYD8r5I5E62HV4mHLOY/8RztRpYTGhbdYKqk5m2ra1YlxEu8g42ag8nLbwSwXzBR9Jw5svRBWSEFwrTSNlGwZR97w/9E2YxsE4PymwB1EY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(346002)(366004)(396003)(6512007)(31696002)(86362001)(53546011)(558084003)(6506007)(478600001)(6486002)(41300700001)(26005)(38100700002)(82960400001)(186003)(6666004)(66476007)(4326008)(5660300002)(2616005)(66946007)(66556008)(7416002)(8676002)(54906003)(8936002)(2906002)(316002)(6916009)(36756003)(44832011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzdUWEp5OHZ5KzM3Y0JCcGx0R0JUbGdzR1JqSGYvZ0ZpUEI5dkpMdEFmZ2FS?=
 =?utf-8?B?QXM1NzBQdk5zZ3NzTzM5NHkrNENUTEpCQitGR3h3aTNNYy8rbkYvR2NXeXJr?=
 =?utf-8?B?RHpYdmJkU3V5d3NCQzJKT2ZoYnFZaGsyMFRnQjNhQlhRMWoyMjRob1NSMHdM?=
 =?utf-8?B?MkNpbEpqNXQ1NlNSNmxxRE9SNUswUDVjMGUwTHN3bWxIcTduSksxWnVvY21Z?=
 =?utf-8?B?RExTQkE4TjdhYkJqcmN0SjQyNGpIWldRaHplclZrUHY5MWQ3N2VRMVZLNEFD?=
 =?utf-8?B?VFZVMTJkMGxWOEFUczdJWkVBZWttY2FpY0lNdFh1RVB4SXE4SXFyT2NZMWhV?=
 =?utf-8?B?MnI5aytOOEJPeG5aakNTeVRNMFNBWTZZSHhSUys2YlJLQnRBYklXSEtnYStM?=
 =?utf-8?B?d1hiaVNTNzBxWjJUdUtuQjI4dUdxQXlYRDEvbHBCZ0lMbjFoN2N5UTQvOXBj?=
 =?utf-8?B?NlJTVTNMSGJvOW5pMzJiZ0V4R1YwZFJGYTJ5emZPV0dwYW1vUW1FUGZsWHJn?=
 =?utf-8?B?aVZIR2FrcURxTmlPM1JDODBPRitvZHVvRC9QVU91VlN3Q0FLNUEyS0ZIK2xG?=
 =?utf-8?B?RkdsYW1aTytDYW4xSkU1cDRUZm41WGRQWmZubmRGbU5zNGROcWFKK3RHTlBH?=
 =?utf-8?B?cUlYU3E5QmVub2gwakpQTGpSbUZ0SStOR3AzZkttN3JrTFFORjlwVk5wNjZa?=
 =?utf-8?B?bHlPTWFETmMwUFVYUklYR3hSL09wcTAzM042ZE4vMG41WENvTU42MEw5REtv?=
 =?utf-8?B?bDdmUjFid2dVMlpzS3ZTUG5jenBjTGxDMGcyazFlM29hYmNBZmozSGMzVUpI?=
 =?utf-8?B?a0Urb3lIM201R2w1QzI2VXIyUnhadHdpK1YwTlVHblpPRUQ1Q1ZzWjVFQnVM?=
 =?utf-8?B?eW5JVmhwMUswZk9LOHhpMzgxS3pmSEUreG52T25rK1NubmRJTkNoc1pETHdj?=
 =?utf-8?B?ZURpOSs4ekFYR0c0eEhPZTlFWlNNNTV5ZTlVeW9HT0dCZUlxcnVweGVOTlkx?=
 =?utf-8?B?anIya095enJ3dHlUM3dWM3U4WFU5b0Jjak1JVlM1NGJBeXpjRFl1RGIxeDlw?=
 =?utf-8?B?am9uUWJvc2FmOWQ5SEY5L0doNlY5SGpDZGplTTZ2MEFWSE5IdXl4dzh2R2Zw?=
 =?utf-8?B?RCs1RkxnZjdLZm5xeEZwZGd4Zm1PWXZZUlVkbjJTZmhWeEYwY2lsdFZDMmtQ?=
 =?utf-8?B?R3BBR3dGU2hldDRIMWdwLzZ5Qy9nNFM3TjFVcGwxZmh0ajY5OHJyLzJpbFlM?=
 =?utf-8?B?UmhLcHMrMUtCQ2M4TzgrdWxhVzhjdnZvRElITDZXN3ZWVnQwRE96TVRyYll5?=
 =?utf-8?B?VGlBbTlTbUZkT296YVU2R2hER2Z4ZVBlMTBhSXp5bTJwQUtrOXdIQTFqSG5t?=
 =?utf-8?B?aDVZZ0FKTCt6dWd5YXB2d0djZFpZdWVjcVowR3FZV0lRYWZiQ285ZFdQekEv?=
 =?utf-8?B?empFQ2dOQW5pRHNrWTBMdmlubnkwcUJKcmpCZVRGLzRnSDY1R2NRRU5wWlZs?=
 =?utf-8?B?b29pQTIxL05rNTN5bFlRZ0JPYXU2OFEwZmI3d1hTTG1USCt0cGV5OTFhbytw?=
 =?utf-8?B?N2I1Nit5M2VhMUlkZ3FtSE8zVnJnREs0NGI2R0d4RVIrT3FQTGZKSWM3dndQ?=
 =?utf-8?B?ZktEZ2lOejV4Z0hSaEZEUGJmbSt3Nis0VUdHdXNNVWZ0ZnB5QnlLTk9td05P?=
 =?utf-8?B?MHB4V05uZzhHYUp1UitwYjdXMUtLT1ZRZEZ2ejFCOEliYTBVR0FQOWdnNUhp?=
 =?utf-8?B?eDcrTHVnWU1wcGNxcG9wanZSTjVOdXhTWmt5WW4ycTJQVmxYTlEyTFZtTkR4?=
 =?utf-8?B?S3FHUGkzT2FlMEI5ank0a0pFRFNMY3lQV25XN0oxeDhxZGJJYWtjS3k4YmhT?=
 =?utf-8?B?SHBQK2tXUlJZeG1tb0pYUkYzeUZKRmt0UUk1V0RnVmtWQUpiZ0l2SDR1QUJq?=
 =?utf-8?B?K25taTRRSHJ3UjFwVGhmNG42U1FROE1BbXpLb21JbERhSkZmbEphRjcvOUND?=
 =?utf-8?B?enpYWm5QWmdKNFJLODlrS2MrbENFbk5IMjJxVVFlek8vREhuMzBBcjRtbkpO?=
 =?utf-8?B?OG83bmFRSkhjay9TUE9ZdllOd0xrQWVBS3pDaUQ1ZkhJcXVmcmlvcXpIM0xn?=
 =?utf-8?B?ZTNOR2JYQWpxVWgyblVyUHQ0SVhvVnViSThYQ0MvOWFHbW1aOG5CZVBKY3Zt?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 240bb3e8-f0f6-45a7-41fc-08da8b7f4e0a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 18:33:31.4311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9trHvITfP9yCNE0JG17S5E8bFXfUCpXMIqUe5Ay/nVj4GJErN3bNdPzstgf+k66tP35DybWpu3q4ti/mJiDQeI9yJ9neXuZ9kBgFe5oY908=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4906
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 8/31/2022 11:21 AM, Jarkko Sakkinen wrote:
> 
> Can you point out what exactly is the whitespace issue?

There is an extra space after the "=" in:
       vmret =  VM_FAULT_NOPAGE;

Reinette
