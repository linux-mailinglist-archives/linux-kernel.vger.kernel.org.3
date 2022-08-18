Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4876F597AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242534AbiHRBPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiHRBO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:14:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EA17C767
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660785297; x=1692321297;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hexIbovqNWWqwIVrlyEFfh/snr7S//BKbmFdQ9KSzjE=;
  b=lDjwl1UP7VsxpwCXLxESnOrxZvo2mKC0C42DZ9zlpykE51a98DZSG0KN
   hvwOvYbGzmmE25qvmX6DrqJZ++Ms2iZ1k8hyPuzz3GbURBYyLo1IfeSjh
   zxitKuaXI9ved4thk1GEEX1azNOf5NR5fMmHTNRaDytJ6ud6Mm64DOpW9
   DTrPclb2mbbFQHV/IaeJY5c5nvAEBlkbOeFQ0inAHw58aYI7vbsX4CeLB
   5Kw6Lkax+U++TTgk/TgSK/eKldIRlFqjKQ8lTdWRc+6tLwgY1/olc8xoL
   S+1AUryuO1jozkJ6FDTz8fRZk6WhHzaOp/oJQuxKVxcaMhOObXULMuyXt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="354378906"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="354378906"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 18:14:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="636609203"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2022 18:14:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 18:14:56 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 18:14:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 18:14:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 18:14:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6wN4uNK9W7V98Vr4kioSy2DsKs3gI0pPjNTjWf8PFozrLxgcc/4r42L4gzKrkmEK5+mbFTH3XDASGv1fmqSwVZMLEbr6O2wbciNSQBSkeXfGCN8IalZjxms0XVMknpMZOkZZXq9bi+lJDhzeOSJrOaIyhmqjTXYtU6oLPGHtwSDcOpJX1g6z9cU9gZD6TMAb26AeWyLmERMIA6Y1pvAxBhBxT+JffI0CWqa0WKUttXJY4I3lWDAEqnBcUeBIPb3lH6kDoDUf+K8uDg/Ou/0MnRZKgnaWrAGyj6otMT5sJihtTHmaTzM7Rco4V+32af6iVZda42S5Uez7c1xaQP1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiKOIW0WQ5qlh8qfB5EzOMle2sMoqwVC4T1RKJ4uitk=;
 b=VhWvMedrahcdcQ/rdhVwhSGRuwVB8wz5+5lVU82kinQr3gWdnLmGnQY+mXXramdvDF6Bdzjhu8QUo5Jk54Rjp7DAIOTAQisX7goFrqInGP0JVYjTVXXxDsM3ka0pfFgzW7AIk7rcHhzYJgvWtjy1wTbyeU4rnUjMB6xn4pgVSx887E6iZR5yavU/yyeA13joJ5StaiXBpjb23KA61ZEHt0mLDdROX/WwNcTMUnOvIWkUstCTSmIKEpSd244bmVYryZCClnPi0CO2PVgjfBWrMbCdMXhvCScV9FqGCp4P5NdgNjYAAEUhbcUGnuZJbYIpFwsbsMg04puwej/c/QK46A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BYAPR11MB3573.namprd11.prod.outlook.com (2603:10b6:a03:fe::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 18 Aug
 2022 01:14:49 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c%4]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 01:14:49 +0000
Message-ID: <019c1272-9d01-9d51-91a0-2d656b25c318@intel.com>
Date:   Thu, 18 Aug 2022 09:14:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before
 set_pte_at()
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-5-linmiaohe@huawei.com>
 <D8C00BDA-160D-40CE-AFBD-9488F85E76CE@linux.dev>
 <ea67ab10-667e-f361-b80f-dafb13da4808@huawei.com>
 <0EAF1279-6A1C-41FA-9A32-414C36B3792A@linux.dev>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <0EAF1279-6A1C-41FA-9A32-414C36B3792A@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::15)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9efa2c4a-ad55-4c03-3c79-08da80b70bb8
X-MS-TrafficTypeDiagnostic: BYAPR11MB3573:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrXLM1wOPDfl+JqlFw2hHVdeQLGrFQRzwfQux+MkJMMIPa6Njf3jH2TrC4WYGgA8a59CezK0h2jYYoSLp+s+vLcPo6n3/xJtqwvE4rHoyK87Q9xzMPTHCElZTGzNa91wRymEzGMV2ex3B1bvKbre6wW6mS+B7/25TOpiGf8I7oD3zNGS6XDr/D/UoMWhSED+0au0NixWAFte909rHxWXaAyQYqWYFCok4IbyDgQoL2y4Gv4nBj+aDUl/EJLO/Wes2sWhG42+7dxOfEuFOWIopww5X/wX2i0JpxzNP53n5QhvDZJjPJwwIMjnqhZ09a0ULlV0fVEvocD7V1h+DL5AA4LnK6vqoBZNvHJMxBTd0aQsKPGFO9iYLhsmV9C6bkru+AsSlG6ghZDLu8B7LwWxwI9UCiiaE5Ss8YY49gWJvlmdbTDvfc+f0gS7XkuI4wogNxG8IepIqL8HSgrz5Ydt5DxfREUJiT2YKo/HwquUxtVFbINgdHVbgcDta0IDenU2UsySRIZgjRGdQpJqgoC7Ye8XR9wIN1mH3A2I5byvKonzhTZv0y14Gg54R2NgYDr2yIwpCjLxdjwSpUsIzsXCI8ArGLQSYI7vDfMEEts2VI4MNQxifwyAlcZhlqUiiL7jHDd9fFxRjZp1Utfu6k+PwsN1R2JWYpvVReyTlGY9rbcGNk9WxQ0tr2QCV7rZWg8tzRaVv/6NjqTNhdIN38vX0Eseb8O5Wjv6TIAKizP3PB2tyEiihXWkDiHWQJdOT/8XEA3NAux09VCI402Z+Z2Re6pNRaVPasXFHmsyMBrnJEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(136003)(39860400002)(376002)(5660300002)(38100700002)(8676002)(31686004)(66476007)(4326008)(66556008)(66946007)(36756003)(8936002)(2616005)(186003)(6506007)(478600001)(26005)(6512007)(82960400001)(86362001)(31696002)(2906002)(53546011)(41300700001)(54906003)(6666004)(316002)(83380400001)(110136005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVBoSWNzdjMwMnMySmQzcG90blpkeEtLSThndlFiVFY4SENQNEpPb05wQVBx?=
 =?utf-8?B?VEhPamxTZDNwbEdOVnd0QzFUd1JZdDByVzNMNVJheDhTMllCN0R0c2JLdXlX?=
 =?utf-8?B?STI4a2RaeWplcWNGOXBNWGt0MmJWdlVVMG16cXJoZkVZcS9mT2lQUGVwcW00?=
 =?utf-8?B?VGdMa3F2RjVJc2dKbUFuaVlDb2tLb2oyR3R0dDczaHNNb2NRTytsbEk3cEZl?=
 =?utf-8?B?WkpweEt6S1hxZUhkbm5xeXNDcXN3eTMxejhjMjl0RGRYK3l5bGtCSTZCM0s2?=
 =?utf-8?B?a3ZKYXRWN1FNU2JFQVY1VWttaTlMZEJHQTFsUVdjaDg0STNDbnlpSHZRcWpV?=
 =?utf-8?B?YWtJM1V3TmtSUXZyK1VBa2dyZzFteTBBZzMrYWZJMXlVSVg3bUg1eDlkZ3E4?=
 =?utf-8?B?THBSK3A4d2w4dFdhamVOa0R4VFBQeGs5MG9zZFZVcnM3ejViamNrVEt3TzVw?=
 =?utf-8?B?TFc2czhFVFN0TThBQXllLzU3TVUvTG5NUy9helU5TVVSVUJhQ3FsUVdLcVdS?=
 =?utf-8?B?c1dRZGZDRlpIR3JMUDhidkQ2Z0tpS01EemFUMUw2SXhwQzdSYmNOcVpNVGNJ?=
 =?utf-8?B?V1JVODJTV1FYSnlMTUtkZllxRlRMck4xWmhBMy9oNjV6M1ROTEZWRW5HTjl0?=
 =?utf-8?B?WUsxWXZ4TTE5dW1od1puUVk1RG5TNzlOWHBsRlk3TllmaCtwZHRKcnA0S0hk?=
 =?utf-8?B?WmJEVnN1aEljQ0p2dUtzeFJqK3BVREx2VDV5b1REL09ESlVnWGo4VFhYOUlU?=
 =?utf-8?B?VmV3L1o1Tjh3aThJWE1hcVhvS0FXQnVNZk5udkJVbWhkWHMzS0tIK00vRUZ6?=
 =?utf-8?B?R01GY0pUSHU5UDVOalJTak52aW1NMXVwRlNhM1IvVnNCd2lVMStwNDFHc245?=
 =?utf-8?B?eHZGaUNiRGx4UDFTaTluNDB0cVhMK3dac0tZVHFyUzFYb001NnArVS9oRXJz?=
 =?utf-8?B?b2xWcTBEOXlUeXlORDZxbmtJUUN2TjNObEtzQ3czS2NiYVVqOHE1WWtnNHpN?=
 =?utf-8?B?dDBFelcxdDhub2lSd1lYdFZ2Wlk4UHRReGVsSHNUVlZyaXc5TWxXQmNFOEtM?=
 =?utf-8?B?Zjk3MmRRWm5zK2R0eXRlcmV5V1Q1ZjM4RzlJMVVOZVVCYkhXUWQvN1RIY1BL?=
 =?utf-8?B?bjdFd3UzelBMZ0ZLVGVSUjVCZ3M5My9XdndjbHNpQ3hUWkNhMU9UbHA3bHhB?=
 =?utf-8?B?M0EwQjA3d29seENlem5uRjJSU2V1dkh2WDVFaU1VTVZIRUthOTZ2aTJkYXVn?=
 =?utf-8?B?Z1hRMGU5L25pdE9IMXFLcEJtVnluQ2lObG9laklxS0FGR3hPdDIrVjFVUmNw?=
 =?utf-8?B?ckd6VUtFUkw5Nmh0MVVVcElwSzVMRWtaWURmT3pKZWhxc1Y1Wi9sUW9WZlVT?=
 =?utf-8?B?M3llU1lzdWZHdFlTNndXVEozaG5HeVVEcHNSL0tBcmFibmNubWhMZXpOajc5?=
 =?utf-8?B?T0Mya0JqZm1tM0JCUXlKVUo1bThOQXVKWE1pUjEweUN1bHAyS2VYblBxWTNM?=
 =?utf-8?B?UDVmeWszSzBwRnhIcGZaTVdxK20xUFRxUmlVMGtMTU9SVjR2bSt4aFBwbFdE?=
 =?utf-8?B?Skk3TjZ6Rkd1RitVZmo3Sm5xUllTUXMzVEZaTExlRzlxcVI1eTBaN081YUlH?=
 =?utf-8?B?dmNobk9kekFrMjByRk5SQjN6Vi9aaVJ3Uy9oK2ozNHZhNHBvenVYWUFSREo1?=
 =?utf-8?B?elMwTldCVWxQWDVENXFMbldpcHROOFVoeFVSNCtUMEFBOXVkOW9FSXhTUjg4?=
 =?utf-8?B?cUl6ZDc1bVhzSG5pTVZqZXJIVEtCMm5pMzJCNGdaMmJiZ3RLQ21oaDlMZGJ1?=
 =?utf-8?B?UmdTREI4VTY2K0pKemo1N3poVnFrZXQvUEVlMUFlalNGVjgxQ2tJcUlIZk1C?=
 =?utf-8?B?bXhiSW1XTkd4TGdaQWp1R0QyUHZ5UzNYTDEyUmkzZFJETktYUWVWekhva040?=
 =?utf-8?B?L3cxQlZxcDVlNngwMm1DTjdYcm0rd0lYWDIxeExMdFNwRFZxRkFSdjZ0ZjJS?=
 =?utf-8?B?YVVrdEpsUkxxdUpxWUdDbFZrMnFLMzBGMC83L1VaNVFJTGNRL2NJQ3dDZU8x?=
 =?utf-8?B?OFNocFdQbk1Maldsc0ZRdGE4WXdoVElIamV4YmhWb3FabVJYcXo3ekQ4OWlj?=
 =?utf-8?Q?BXHYQxTdXQort4KiZyWdSvYCS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efa2c4a-ad55-4c03-3c79-08da80b70bb8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 01:14:49.3309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aW5syODNNLQalUcFdOn9lE0lF0vKfBW0yQdtiIiYf4cHHDutv4LuhYc5ndYKMP4r21xkmM0gTucsTC67Vs1rBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3573
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



On 8/17/2022 7:21 PM, Muchun Song wrote:
> 
> 
>> On Aug 17, 2022, at 16:41, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2022/8/17 10:53, Muchun Song wrote:
>>>
>>>
>>>> On Aug 16, 2022, at 21:05, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>> The memory barrier smp_wmb() is needed to make sure that preceding stores
>>>> to the page contents become visible before the below set_pte_at() write.
>>>
>>> I’m not sure if you are right. I think it is set_pte_at()’s responsibility.
>>
>> Maybe not. There're many call sites do the similar things:
>>
>> hugetlb_mcopy_atomic_pte
>> __do_huge_pmd_anonymous_page
>> collapse_huge_page
>> do_anonymous_page
>> migrate_vma_insert_page
>> mcopy_atomic_pte
>>
>> Take do_anonymous_page as an example:
>>
>> 	/*
>> 	 * The memory barrier inside __SetPageUptodate makes sure that
>> 	 * preceding stores to the page contents become visible before
>> 	 * the set_pte_at() write.
>> 	 */
>> 	__SetPageUptodate(page);
> 
> IIUC, the case here we should make sure others (CPUs) can see new page’s
> contents after they have saw PG_uptodate is set. I think commit 0ed361dec369
> can tell us more details.
> 
> I also looked at commit 52f37629fd3c to see why we need a barrier before
> set_pte_at(), but I didn’t find any info to explain why. I guess we want
> to make sure the order between the page’s contents and subsequent memory
> accesses using the corresponding virtual address, do you agree with this?
This is my understanding also. Thanks.

Regards
Yin, Fengwei

> 
> Thanks.
> 
>>
>> So I think a memory barrier is needed before the set_pte_at() write. Or am I miss something?
>>
>> Thanks,
>> Miaohe Lin
>>
>>> Take arm64 (since it is a Relaxed Memory Order model) as an example (the
>>> following code snippet is set_pte()), I see a barrier guarantee. So I am
>>> curious what issues you are facing. So I want to know the basis for you to
>>> do this change.
>>>
>>> static inline void set_pte(pte_t *ptep, pte_t pte)
>>> {
>>>        *ptep = pte;
>>>
>>>        /*
>>>         * Only if the new pte is valid and kernel, otherwise TLB maintenance
>>>         * or update_mmu_cache() have the necessary barriers.
>>>         */
>>>        if (pte_valid_not_user(pte)) {
>>>               dsb(ishst);
>>>               isb();
>>>        }
>>> }
>>>
>>> Thanks.
>>>
> 
> 
