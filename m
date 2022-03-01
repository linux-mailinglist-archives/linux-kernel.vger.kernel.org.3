Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1EE4C911B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiCARJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbiCARJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:09:24 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38D4B35;
        Tue,  1 Mar 2022 09:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646154522; x=1677690522;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=15AzPLVxTIVPv+7gAZcMNRMIaF1m6aoBm47iqIb2CTE=;
  b=m61VO2WQz1ALrl/JF1Rt9NYSaT78xXT/u9QJvzDD8yS0PLjw/4HbZQYv
   vOU/Z5S8ftAo/pP9ytyXuiv4zbwFPqs+o2QvYBFzrbJTNZ0HPsqeUzwfw
   0lC7FfHOO8wJ0+BUI5/20Ehn+yARbDAo38Gc0RxGCA3kM7mLPVrbxZOwu
   50Eb8qoYA7/v/59UOk2w6W6eSj850EcThwyCSLLz42MyoUXuwr/SE5MAH
   WXOevqkcjWPAdVT+hVYR2z3fpRTEHFrs7fw7/p2gJIh0m+8c2hiIyZSvn
   08SK1oTT3MkOt9UCA8I5Bpf+HzJOhFzZCpS3/K48Vzzzp9mXq5NuVZsMg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="277853619"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="277853619"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 09:08:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="493185273"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga003.jf.intel.com with ESMTP; 01 Mar 2022 09:08:41 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 09:08:40 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 09:08:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 1 Mar 2022 09:08:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Mar 2022 09:08:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGAuAdb0dbBQq+soS52EYlO6KgCtPHCEfaeD8EoVcTDbwwaRzX+KUN8YljXLih2ZbX89oiFyc/F5bG0Cda/XH1U3JBOchZE/LKo4FbO7uNIlz/RQ17Lragkb9+oKapsmKUUhPjAGDDmdkMcH57YgYsfulPhcuHcWxf2gn2bFQtDGTmrILwZLhpURjwSP6Uo/WsXoclYlmtaNz+7cuPGvQvZ5m69jE7KBBKuakBasAGNShLw14uzVojoctPSOVfPFCO0v786ASKhavlm/Qf6weFVrb5i35uAxJxTDU7iV6JBp3dARAjwRt7JpVDV5rfWNrDYT0I56ZaXsE0YVzHOhKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfsaK6tUo9ADoyhljShtrynmhFqQKXqrVIFAiwylltQ=;
 b=oYjsEBxtJVsyATgpHsqmSvt3M6moGJrScsF44QfnQt47HDTpedh3YLcGHF5vpXTd5zkcJxaKK7vUw5XO+iwnVBYqoRk1uAf5oynfH5syxup6NszOh2Bsoi37L5YrC6iv4E1J21dOo5EcWvVzkTB4E20nJ9lpRK+qWG4swJZzgEkbFZNn3ZvetcWvGwW+9EXvczhxpB912BeTnKeTl2BUobYwBtsArLwlZfr/Ab7MCy27uhwHBCnABlcx1opSNofT24q7Fy8oRpDfwRgFxIsygWD5pk+mXLSlrlhD+EhlEbYlYKiUS5UVxIG7naXZdHV7hr5dN/1cTu8Rr5GWuy1UaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM8PR11MB5624.namprd11.prod.outlook.com (2603:10b6:8:35::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Tue, 1 Mar
 2022 17:08:36 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 17:08:36 +0000
Message-ID: <22bee745-7753-a35a-afc0-e81e6c192248@intel.com>
Date:   Tue, 1 Mar 2022 09:08:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH 13/25] x86/sgx: Support adding of pages to initialized
 enclave
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <9ab661a845d242cb10a90ade997f8ebda33cc7c9.1638381245.git.reinette.chatre@intel.com>
 <Yh44CahjtgAarDad@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yh44CahjtgAarDad@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR21CA0061.namprd21.prod.outlook.com
 (2603:10b6:300:db::23) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 844ae36d-d2c1-4266-99cf-08d9fba61f3a
X-MS-TrafficTypeDiagnostic: DM8PR11MB5624:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM8PR11MB56243E1C40AB0C38965CB0C5F8029@DM8PR11MB5624.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5DKewlnvPyza+cH8g57tEuupC636T29VozgwhF05kivRpBd76StylbZFk+KwNhUkbA0gOiqCqO+AGHpZO0Ym0HHkp7VUGFT5JM3hetREEl9vvCA/IrOqHrqtW9e2gIWqGWAYoFccyrmZJXu049AFhatWBPHZWV6aMVBONq567HqSLu3Y4kAjnXYDxv4XZwVGj74o4qOLLA+iKh8Fa9EEQC6wr/f+NAI47ZAp+k/ZNN5I96xjggIQ3QgwfW3JWuuFHhZAXCYxSK5iUtCjhIVZmXl5X6lJSPGmekVZljE6GmE5MyZWZ4PhN1C4id8XaGCUoU39Uq53GCSFNdYKD+l21tZIcSsmWg/zdQMcjjshyjoqSlM1ihUYYRtMsyggyF6KDdgjkcgvkNUs5E7m+mZe+DOm6vodWD1c16PqHf3rMmOHiKB/2JfTd7IHttNxr/ZrU3RP+fhV62eR32epAR/6FugwpfefkMgFN4ALEpgi0ESHNKgVn/YYP2lbw2aTluN0tB1Sl/JmRf9layPRU/zyY/QnjAoHgl7mYAf8+grM3svTeHuhBDxfsz5JP2mDgWpzhMq8pUO2nVTjdvuSxytiYNaKQdG0SO3ACoGK89c2H7E3nrUGv08mVIM+1Ndro1fIIjck8uzVon9TEGQADbOy57HVHlW7M/swWmLTMswcAMJZ3KPi93no88SYEdfSplHLb8OfqVfu2vvhxnA6FGWKJrzy6V7+nCcXn/DEZN4bRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(8676002)(2906002)(31696002)(4326008)(66556008)(6486002)(5660300002)(66946007)(36756003)(38100700002)(508600001)(82960400001)(31686004)(7416002)(8936002)(86362001)(44832011)(83380400001)(53546011)(2616005)(316002)(186003)(6512007)(6666004)(6916009)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVpBY0I5UEhNejRGbHgwY1d3anJXbHRvYTBXTlYvbEZpSk9ZMFFBME1JOTh5?=
 =?utf-8?B?RkFkNElFdnNjUXMzK3R2dEoveEdnYTBQamdOL3dnaGJnMEpzLzN2VnRvZzdp?=
 =?utf-8?B?TWJEOFBqc05YbWd2cTk4ejhrcFY1b1BkQ1IwNlhrZTNseG1mMnFKTC94Ukow?=
 =?utf-8?B?c09VdFVQZXVmbUpjS1dRb0dWdnF6TDRhczBpNkNWSlZqSFNLdnB0RkJzSnQx?=
 =?utf-8?B?bmdqSis0MDJuZmR2VmZoTXJULzdwcTFtQUcxOGhTU3RDUmlFN2Y0eXhRU1Nh?=
 =?utf-8?B?bnNwWWNwcGN2RW45TWRPc1FZblRibEYydVBaY1JvWVpQclFhaThJOWZLTjg2?=
 =?utf-8?B?YXRDdmFqd3ZSNmNqM3VWTXUrNVJtclVVcHlWWjdTa2g5eUFzbitRNGZFbm9X?=
 =?utf-8?B?Smw1aHY2VDdEMEFTaGZ4Yys0Slk4UXVoZnczeG1yaktUQkRDeS9uR1dYTW1L?=
 =?utf-8?B?RnJ3amhFUS9xRFdPZU1hc3NOOXY0MHhWZitKbE4zTUc0MVdiYWdWQndXOEZL?=
 =?utf-8?B?VjRibVc3enNNRlAwVTgvVUx6NGorWGRNN2FDanhDN2hrMG9BZjJyK2s1V0My?=
 =?utf-8?B?YVk0dUxRUElPSi9nT1QxeGdacTNXZU5OQi95MkQzUUNLdnQ0dE9Oek9KUDBv?=
 =?utf-8?B?M1VJZjhzdkdNUTA2MU9IcmZVSXZySzlod1B2Z2xqQVFSdzBQYjJhL3VOTy9N?=
 =?utf-8?B?ODYrUjVMaCt6K0xqc2JaaDc5b2hmNEVNMlAwc1k1UFJYUDJxMXdUdjNZUTlZ?=
 =?utf-8?B?dDNlSjBxMTgzeGhzZzM2ZUxXM1lsT2paUUJ5RnpDSngxUkZNc2U1aEYrY0Ry?=
 =?utf-8?B?ckEvSXlrRzNkY214S1lqMWo1QXd3eXNOcFppVFdJOS9mRWJPbGRtbjRIK21Q?=
 =?utf-8?B?SmdFaEk0dkQ4ekhzTTQ2amdmWVZMaXgzeXM4N3VueERPNXZrUURXazhFRWNZ?=
 =?utf-8?B?Q1YwVEowM2xySFNrTWVvQ0g2YUZDdW9VQmZmQUZyQUZwSXhJMExJOWJySGRn?=
 =?utf-8?B?RnNBWEFPeVJocXVrSGdnZHBlaExSVkFFVFRDVFhRRUhKbDhQLzNlKzB4NVJG?=
 =?utf-8?B?a1FoZnppWUJ0SWxSM3I5b3hKb2RGRncwRkZkQVBxdXRNWHFOcHpxM3RGakl5?=
 =?utf-8?B?VEh6VGpKRE9xSmk0cTFVQTRGaVhpUmszd0NlN015OEZScDNQUE1senVNSU80?=
 =?utf-8?B?YTQxalFLNHhmSDZaalFKV1ZoRWVIRUlpSFJuQW9ROS9seDg3eDFiaHBHcDJ0?=
 =?utf-8?B?aG1QMHRKZkZJTzBCZnF1ZUJ6RVVaRFJwZE5IMWw4M3FwTHUramVoY2RnN2Nu?=
 =?utf-8?B?eU9Rc0tROW9PUWNQMUVWZW41VnQzVlpuYk5ONHMvQTlmcTQ4blZ4c1dtVkRa?=
 =?utf-8?B?b0wzeTZpdnkzTVI1ZFk1QUJPT3lFblp6VmpYSGlXRnZ6MWcvZGNLejZVLyti?=
 =?utf-8?B?aVZyNi9pRHJOYlNsbmdtcVhsVGJvQUdqbjVlbUE4VjVscUhQNUE1MmU3ayt2?=
 =?utf-8?B?UWpFVkVEQTZMS2pVZlhVQmgzTW9hNUE3djRWc2V2b0VyRmZzMXhzMGg1OURx?=
 =?utf-8?B?dXRaQnJ4UHZrS0ZrS2dkeHE5WmNsS2gzTnAybDhSUXh3ZW9IM2xEdWVJWHdF?=
 =?utf-8?B?eVVhWllzL2pYWFBUSkNHVEFyV3Q3dGxzWitEaDVIejgvbUVnd0tUSk40STlj?=
 =?utf-8?B?bFl5TlBHeUVSMDBwWnd5Z05PQ0RRcUNZSEZDRFlPVWFzc1pMSW1PTjlTUUIr?=
 =?utf-8?B?Slp3NmdONmdJVHZJOFNlYllHNWsrdzBsY0p6UFVuRzcxUkhkQldETHN1Ty84?=
 =?utf-8?B?MmU0Zjl3cXZZVlZ4QndzanhXOExQSk94bTQzYzE2VGN1S3BTVTBwWkowZVZv?=
 =?utf-8?B?ekxXTUFRZm1DQThuSmRHeVZOV0pDU2ovZSsvT3NyK2hEK2h3VjFaQ0JvSUdU?=
 =?utf-8?B?RURkcEw5MEo1YmlhUEZPZ3lrNHdXUU8wOTUvQWJHOGlQMnh1U3lmbkVUbGxx?=
 =?utf-8?B?Rnd5bU9ERE1Ob3Y1aHh4L21ScDhpeHVJdy9JMFBkWG9wVmpMRTl4QXB4YWRD?=
 =?utf-8?B?eC9zT2VnZ1BUTDZPVDF0Wjl4eEZTYmJCdkFkMVZTMXVuR1NEcVZ1TWg1N0x3?=
 =?utf-8?B?SGdleENvNFZIMnNjUnBBTC83bkVKUWtMTTFSQzJuQlcrN08zTTFuOWVENXV0?=
 =?utf-8?B?bXJRRlZYaXIwaXUrL2kyNk00Ly91aWljVWhtUTFPT1FJUk5KdjhWU1pKN0hp?=
 =?utf-8?B?RHpoVnRIYTBwWFNDZGtEN2s1emhnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 844ae36d-d2c1-4266-99cf-08d9fba61f3a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 17:08:35.9837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obRN02wgLX5FUFE4HuPFktyjJDwCQJRZcfa5kUNXL9wmcNRjhYHvWaLIR58Nn7u4ZIlI1EPr/jnO3Nr6rdljv5gCpyNkDCXsQco5yVBU2mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5624
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/1/2022 7:13 AM, Jarkko Sakkinen wrote:
> On Wed, Dec 01, 2021 at 11:23:11AM -0800, Reinette Chatre wrote:
>> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
>> index 848a28d28d3d..1b6ce1da7c92 100644
>> --- a/arch/x86/kernel/cpu/sgx/encl.h
>> +++ b/arch/x86/kernel/cpu/sgx/encl.h
>> @@ -123,4 +123,6 @@ void sgx_encl_free_epc_page(struct sgx_epc_page *page);
>>  struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
>>  					 unsigned long addr);
>>  
>> +struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl);
>> +void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page);
>>  #endif /* _X86_ENCL_H */
>> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
>> index 5dddb3c9f742..de0bf68ee842 100644
>> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
>> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
>> @@ -17,7 +17,7 @@
>>  #include "encl.h"
>>  #include "encls.h"
>>  
>> -static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
>> +struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
>>  {
>>  	struct sgx_va_page *va_page = NULL;
>>  	void *err;
>> @@ -43,7 +43,7 @@ static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
>>  	return va_page;
>>  }
>>  
>> -static void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
>> +void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
>>  {
>>  	encl->page_cnt--;
> 
> Nit: this should be a separate patch, e.g.
> 
>   x86/sgx: Export sgx_encl_{grow,shrink}()
> 
>   In order to use sgx_encl_{grow,shrink}() in the page augementation code
>   located in encl.c, export these functions.
> 

Sure, will do.

Reinette
