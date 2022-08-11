Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AE858FC2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiHKM2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiHKM2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:28:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E4494ED1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660220928; x=1691756928;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FiwlToDVtpptP3xx1Ocerz+FcWDiCrcLGEJoK/vSc6Q=;
  b=PaIXn9u2qLLVCnG61v8PMHX2RsWu1FzBfXATorCwDlT0qB8xSSQyF7W9
   n7U/qbHNLKht03ZNkYvKtfPGMDventHOmJ1cqe3/fK1/TOqMjXntSiVdm
   iFbMAAdnsBdjvm1bs4jrhoNcwlXt9ztUH6OEZPV7j7qtiIiVF7EUV8O1I
   qlyX0yK67P3Uc1GLpAfPhn3A9NKEz/K7zyiFErj6VjBZtDDfpQJ1tEy0+
   Lk6ebFDlYbgniaIY7NjXnSyRCqibnyMoW5k2Qf183zG87jNTWWEvrSKk5
   kPkVmfNbtYwV3/6OaSFhR9JW+YJBwdNnjGXC1JYbBumIYbFK5wroo6Pqp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271717705"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="271717705"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 05:28:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="933294037"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 11 Aug 2022 05:28:48 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 05:28:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 05:28:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 05:28:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 05:28:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM7Ex0IFOujQAscA4CzU91nNHuiPgayG81wPq9hi7bta8lbf8oleQu0D/CUqhs6QKJiIsh1wSYN19JmpkH6N0hRPkbxLb7lkQXDFuLSxZGXJEk/wx/Nx7WEWgklIlbDgD/6BvKYiJxXhQFTFZhNQrGDQXYvbXhdWFPLGxbbSZCdF4vdNYDEe2rxvWvkq4WJCb8MvZEAuDaBDP2RCB2KV1+T0fUzfwwKm2hhCYs98LfsW0xBphVxJeaePFJ65oF3KT12p95fLjespytJiqrw5ZtqxHvKY+DzNjju/UMPc0zJo8gAHuhJcB2hwVruwQJIw3FFemRnycdqCwbaLm3UicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlMknp0do6rLFbb0zSCUKHG3zTeDSNtZKQttj12CSdw=;
 b=CQGMFTD8Zv6YnGxcSCvLcOM6nF3vakP2VukHJzwfsdql5NOiaeE9EuK3z0qa+z+GT3fVPTLmIj7BwnEz7QTOSK6bxBDnWUfM+Zpb8a6UrEfg6wBdCXxrq1/VVGaVkbS+8Vyawz61Q1u8usWzuEGGekn4v4x7aX0zKimIuptnfEVZAn+qYdPWkTicAXEAAVdkZg/yqqqvnjeRVDMMT4aMrawGcwKUIBVmIzjT1/SORxZsCcTNBWNW8Uk7DzZLOrs8S5bdg9XvOe7xJBgWtNxYBVaBkPox7SQLeXPovj+PXZUgriZEEg+VwgBrkHa2uZmdnxP6+J/9cHyFzCtO0+sSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CH0PR11MB5412.namprd11.prod.outlook.com (2603:10b6:610:d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 11 Aug
 2022 12:28:45 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda%5]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 12:28:45 +0000
Message-ID: <3516813d-5d2a-821a-81e8-1ed78ad63561@intel.com>
Date:   Thu, 11 Aug 2022 20:28:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 1/4] x86/mm/cpa: restore global bit when page is
 present
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "song@kernel.org" <song@kernel.org>
References: <20220808145649.2261258-1-aaron.lu@intel.com>
 <20220808145649.2261258-2-aaron.lu@intel.com>
 <YvSRyjDsrbB7v2JT@ip-172-31-24-42.ap-northeast-1.compute.internal>
 <df4f40ff3e4c408931ed21ab4e8968bdb1871f79.camel@intel.com>
 <YvToWsNqXudd6cSN@hyeyoo>
From:   Aaron Lu <aaron.lu@intel.com>
In-Reply-To: <YvToWsNqXudd6cSN@hyeyoo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54a4a1f7-e5ea-4cf9-76fb-08da7b9508ab
X-MS-TrafficTypeDiagnostic: CH0PR11MB5412:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhVF64J64GMgxcW1Z4z/bm90he8e4hYC8SujxFtn6lRYAHWgW3RI7lUQKUxjZHmNclAjtLgE/IFs4Gjf+vLB77X0HH6fs8fNU/7Odnx8yvF/juAZMieyLgmcda0nc/qRkUuG9ZunFEA4fbML0N5lwyp9KkWMEh+iC5R/AxrKo3F+nDDZkWDJ8uOpko/29LxQHNcGdMB18v3T/4f0l+r2nzXJPGLfVVJXwpkMjz4tHa4PBq3DWmXk8ELtMG9GYjwJIUADCC6ozo4zaslcf92HTO24ldFnVpERvSpYuEdP176paCq/lVItmVlF+rNViioxjrYouw5Fop9qzXLFAwSoAbDEv1MOYEcThlHeeK1WX+2VZl9A7Kbi6wCGwoHVesR90fyf8wtl0NS6GElZOM8I3ijPWLcP4aZxyVcwBPrToLTjOBBS0DButRjdntmsS9LzqcHbqBVdeL9qymgvkKx9eQMbJxyCEaibKDY8+HrsSTGb/OPGxsWgCMUy/jRGorPQl6cf3vLu7oa3IRAWIYTM3p7DhH1HBw8K40mHilfw1R/FlxVqHX4nQNu1iouwvYRX8p7HIsyw2knijZ9tsqbpHgQTC2yafxTGPnhtCIOtz7sPBotlex9zgQSbV4tT+eXqNkmd7Re+QtPivxYW3q0HphQghfbLHgVZ3NJeJulCFrB6o22L2DLY/133JzZVxlBlhpDwJNm6lyT2si6Ahn9SAI7YCiKyNgg382LFwgj0/CI5CjeTvnZ40cF6ObawLWVIZPgXfUqCNrkN/aMZYU5FdlraLUHs90d+RloFiwbPMWDne2M6UiqMMX6UUxqavcwz7ElXv7PygQ8vcoJxKell9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(366004)(39860400002)(136003)(396003)(5660300002)(36756003)(44832011)(8936002)(4326008)(8676002)(66476007)(66556008)(66946007)(6916009)(54906003)(316002)(2906002)(82960400001)(53546011)(6512007)(41300700001)(6506007)(26005)(186003)(6486002)(478600001)(6666004)(2616005)(31686004)(38100700002)(31696002)(83380400001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnNzcUtkL0lYMnNCVVZwUWlhSm5kdFJVN2lZYWhSa1JGUDNTajJmQnpYT3F0?=
 =?utf-8?B?K3VFWnJlRFc4NUdUS0NFUnh6NGZXR0ZESm9FWkNsbUtNSFpySkR1MGdYOS9F?=
 =?utf-8?B?b0lKdms1WmJIb2VhYkFEUFpvSEJDUG5YL1NvRlJUcUNyZVN1ZkNVODU2dlVL?=
 =?utf-8?B?VEdTWk5MeS9iSlRRVGZINGkveldlbklJVktlbjlubTVBcDYyelVOQ3puUFU0?=
 =?utf-8?B?d1RGbU9wZDBRRkh5QUVvZ0RacitDSXFQYk1PN1Y3U3pRTFZuR3FCVGs2RnRH?=
 =?utf-8?B?OStwVzlxa0dQYzhEdzErdTRJa3hIYy9SVEtoUytDVS9wQy9zQTVQRDBDVnVH?=
 =?utf-8?B?eTZBMUNnejMzUGhDSldLbjk3VVVwUG9maFVRdkdDd0UvQUo0cFdxNXl6cmVG?=
 =?utf-8?B?ZitmeHFUR3ViNUZMUXBBaGJUVUFqRVFRYjdkT0dlSDR4YVYwZmZIdjV3ZnZl?=
 =?utf-8?B?NG5PS2hiVWlaT0VYdVJCMlh2SGlXRjJ1YTNzMTZRN0VkNXNTakcycFc5bWtu?=
 =?utf-8?B?Z051K2h4RDVlY2JaOVQ0eUh0OTFyTGNmMml6YysxTGNwd2dGbVA3SnNZT0ln?=
 =?utf-8?B?QklUdk5VVnFBckNseWhWOU9sU3VmMU9sS09iODZEZUlVMlhZOEVFNzM5czNC?=
 =?utf-8?B?SDVleU1KWUxIVDJBV21wMVJkTFBxZ0t0TkF2WjJQYzFhdzlQMjc4TDRNL1BX?=
 =?utf-8?B?WDhyRWxjVkZRSWZ3ZTR2QmpydFhRbG5DUFZPR2ZHZXQ4V3c5Z0xROWh3RENn?=
 =?utf-8?B?ci9mOWJnOEVyWW1hQWFiOTJ2TVdJNDhDVk5MTHY2cGMyRE1uRTNWLzNhang1?=
 =?utf-8?B?dVZtRkpEd2kwRVE5YysrQktTMzNmOGhhbDBtU01rbnhlYjg0ZzdIQkt4RnpC?=
 =?utf-8?B?MkVMVFlmWHdVV0RxSUQ2WHNTZFl5M0JPQVZIZHI0RVBjeTI0VDlyelRkYzBN?=
 =?utf-8?B?blh2RUxsem5FS2F5cjRaSlNNbDYxSXFQVkJWN1A5TjUzZ1owUVhRNlRpdi9z?=
 =?utf-8?B?Y1hKNlM1RXI1N2RrZGg2cmk1NnhzNWlRNE1pdWVnTm1FL1JManpPOG5oeUxV?=
 =?utf-8?B?UGVJYzFhZTBrU3d3QnVBNWsyYTAzNk8vcndXSk1TR1JxaEpqMS9EUUp6eUsv?=
 =?utf-8?B?Y3dmREhLM29mWXJ0MUxNWnMyVEJHSzVGek01bmlDLzFOSVFoWDY2NFRlREJ0?=
 =?utf-8?B?blFnTmJNbjdZN0lYYzlOMm0xTnJtT0FpWlB3L25vYjJ6NC8wVk0yL3pxSVgx?=
 =?utf-8?B?WU5YMnBCK2lLSTVXRkJhMWtFaWhTTEE3djBhajFmRjJqSlc0Wk1Gc0FSYS92?=
 =?utf-8?B?TklKakhqRjFOaXRoSHhSSmZZYVc0NXF0elpZNzdzd2JYKzdpd2NFT3lwMDVD?=
 =?utf-8?B?bXhhZjVIL1JIMjVlYk5SbkZCNFNvMnI4MmNOZHN4bWZWdEticUUwNXdnK3F0?=
 =?utf-8?B?WUpkd21nbFlZZHoxam5SS01BdVhRUjc4UklhVnFmQ1pDcVMxbHJrMk9Gcm1v?=
 =?utf-8?B?d0VrRWdVWXpiZU1pS1RuaTZhV0RCNncxd1ZoY3I0MjJIOFM1T1E1SVBGd2du?=
 =?utf-8?B?RXgrdDJ2cTdITjNZcEJoYklLS0ZUM3FOVTIyZlNQdnpJQW94YmtQVENTemI1?=
 =?utf-8?B?Zi95N3E4WDhIQnBqNkh0eHRHVDNKZzVFcng4Skd1SndoR2NSbStRbnZQMzZk?=
 =?utf-8?B?bFhWMU9tUG85UXF5Wnplc1RxSVJMOTBwQWVrV25SL0U0NVBaRnR5TVArWVc0?=
 =?utf-8?B?UlhYV1J3Y3lTRUd6ZnVzd1l2aXNJU2V1M1VlN1JWNlp2ZXlkMHd4Y0ZIRk1B?=
 =?utf-8?B?S3drV2xMS0IyOGFsNDdnR2xqZDBGZ1p3NERFQUpBVFZ6NzdWSTJPd2hwN212?=
 =?utf-8?B?YjN5bnhQVGxGMzY2UUtzWVpxdnp0NkZsV2I1MERPQlFwelFHcCt3NldrODRm?=
 =?utf-8?B?RVBRa1MxTysrR3FISjRaYVh6RDUrUjl3ZUpQWXd1YmFTVVA1bzd5OUQvQUtp?=
 =?utf-8?B?OXhOQVZFa3hYeHhvMHdBbkpyOElaZXJIM0E2YmhocjdlakozdHAzTjBDb2kz?=
 =?utf-8?B?Nk5VUmxyM2R6YzUrV0cwKzFlM0VnZUNqOEFPVndaMHFuL3FWT2hmUnNoeVcw?=
 =?utf-8?Q?wWrjAfmTCn6HpGkzm/8QqBbbQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a4a1f7-e5ea-4cf9-76fb-08da7b9508ab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:28:45.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXL3qEWjfCtPTyRc9Xv1tOfejirITKhlYiiqvD9YRxpuJqn/Vriqtj8K1AeBcYOwTWf18wJRFtzPsXuIl21yag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5412
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/2022 7:30 PM, Hyeonggon Yoo wrote:
> On Thu, Aug 11, 2022 at 08:16:08AM +0000, Lu, Aaron wrote:
>> On Thu, 2022-08-11 at 05:21 +0000, Hyeonggon Yoo wrote:
>>> On Mon, Aug 08, 2022 at 10:56:46PM +0800, Aaron Lu wrote:
>>>> For configs that don't have PTI enabled or cpus that don't need
>>>> meltdown mitigation, current kernel can lose GLOBAL bit after a page
>>>> goes through a cycle of present -> not present -> present.
>>>>
>>>> It happened like this(__vunmap() does this in vm_remove_mappings()):
>>>> original page protection: 0x8000000000000163 (NX/G/D/A/RW/P)
>>>> set_memory_np(page, 1):   0x8000000000000062 (NX/D/A/RW) lose G and P
>>>> set_memory_p(pagem 1):    0x8000000000000063 (NX/D/A/RW/P) restored P
>>>>
>>>> In the end, this page's protection no longer has Global bit set and this
>>>> would create problem for this merge small mapping feature.
>>>>
>>>> For this reason, restore Global bit for systems that do not have PTI
>>>> enabled if page is present.
>>>>
>>>> (pgprot_clear_protnone_bits() deserves a better name if this patch is
>>>> acceptible but first, I would like to get some feedback if this is the
>>>> right way to solve this so I didn't bother with the name yet)
>>>>
>>>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
>>>> ---
>>>>  arch/x86/mm/pat/set_memory.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>>>> index 1abd5438f126..33657a54670a 100644
>>>> --- a/arch/x86/mm/pat/set_memory.c
>>>> +++ b/arch/x86/mm/pat/set_memory.c
>>>> @@ -758,6 +758,8 @@ static pgprot_t pgprot_clear_protnone_bits(pgprot_t prot)
>>>>  	 */
>>>>  	if (!(pgprot_val(prot) & _PAGE_PRESENT))
>>>>  		pgprot_val(prot) &= ~_PAGE_GLOBAL;
>>>> +	else
>>>> +		pgprot_val(prot) |= _PAGE_GLOBAL & __default_kernel_pte_mask;
>>>>  
>>>>  	return prot;
>>>>  }
>>>
>>> IIUC It makes it unable to set _PAGE_GLOBL when PTI is on.
>>>
>>
>> Yes. Is this a problem?
>> I think that is the intended behaviour when PTI is on: not to enable
>> Gloabl bit on kernel mappings.
> 
> Please note that I'm not expert on PTI.
> 
> but AFAIK with PTI, at least everything (kernel part) mapped to user page table is
> mapped as global when PGE is supported.
> 
> Not sure "Global bit is never used for kernel part when PTI is enabled"
> is true.
>
> Also, commit d1440b23c922d ("x86/mm: Factor out pageattr _PAGE_GLOBAL setting") that introduced
> pgprot_clear_protnone_bits() says:
> 	
> 	This unconditional setting of _PAGE_GLOBAL is a problem when we have
> 	PTI and non-PTI and we want some areas to have _PAGE_GLOBAL and some
> 	not.
> 
> 	This updated version of the code says:
> 	1. Clear _PAGE_GLOBAL when !_PAGE_PRESENT
> 	2. Never set _PAGE_GLOBAL implicitly
> 	3. Allow _PAGE_GLOBAL to be in cpa.set_mask
> 	4. Allow _PAGE_GLOBAL to be inherited from previous PTE
>

Thanks for these info, I'll need to take a closer look at PTI.

>>> Maybe it would be less intrusive to make
>>> set_direct_map_default_noflush() replace protection bits
>>> with PAGE_KENREL as it's only called for direct map, and the function
>>> is to reset permission to default:
>>>
>>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>>> index 1abd5438f126..0dd4433c1382 100644
>>> --- a/arch/x86/mm/pat/set_memory.c
>>> +++ b/arch/x86/mm/pat/set_memory.c
>>> @@ -2250,7 +2250,16 @@ int set_direct_map_invalid_noflush(struct page *page)
>>>
>>>  int set_direct_map_default_noflush(struct page *page)
>>>  {
>>> -       return __set_pages_p(page, 1);
>>> +       unsigned long tempaddr = (unsigned long) page_address(page);
>>> +       struct cpa_data cpa = {
>>> +                       .vaddr = &tempaddr,
>>> +                       .pgd = NULL,
>>> +                       .numpages = 1,
>>> +                       .mask_set = PAGE_KERNEL,
>>> +                       .mask_clr = __pgprot(~0),
> 
> Nah, this sets _PAGE_ENC unconditionally, which should be evaluated.
> Maybe less intrusive way would be:
> 		       .mask_set = __pgprot(_PAGE_PRESENT |
> 					   (_PAGE_GLOBAL & __kernel_default_pte_mask)),
>                        .mask_clr = __pgprot(0),
> 
>>> +                       .flags = 0};
>>> +
>>> +       return __change_page_attr_set_clr(&cpa, 0);
>>>  }
>>
>> Looks reasonable to me and it is indeed less intrusive. I'm only
>> concerned there might be other paths that also go through present ->
>> not present -> present and this change can not cover them.
>>
> 
> AFAIK other paths going through present->not present->present (using CPA)
> is only when DEBUG_PAGEALLOC is used.
> 
> Do we care direct map fragmentation when using DEBUG_PAGEALLOC?
> 

No, direct mapping does not use large page mapping when DEBUG_PAGEALLOC.

>>>
>>> set_direct_map_{invalid,default}_noflush() is the exact reason
>>> why direct map become split after vmalloc/vfree with special
>>> permissions.
>>
>> Yes I agree, because it can lose G bit after the whole cycle when PTI
>> is not on. When PTI is on, there is no such problem because G bit is
>> not there initially.
>>
>> Thanks,
>> Aaron
> 
