Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D791C495177
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376650AbiATP3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:29:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:6521 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231738AbiATP3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642692546; x=1674228546;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bXBDOUiSjdjyXQ/e9VgSC062ZavNxmQjUPrcB0cRrHU=;
  b=OXlpeNV/6wMnohhDnEMjh+FQrlThqyNcTmR9AevM+vHccxVUaROcmfg2
   HqP2vxv34HG3NZrDwWIIoZ33nZ9ZFs/O0Zht32Qs4Qwam1aOG96SEcptg
   f/kfIYkwx88ztaMjJq1jPz0y9oSAR0W5coUe4Q/s0vOteDkQ2xr5NcCAL
   Veot+gCCmjBIhrVNg5aXBer05ZBFKGITutpvT31p6gTjl7Vo4t0JM7xfy
   9V/6Mjf/izgTVsDocUHcdW2SP8S6kGf8nZD4SS8wxeMuaqVpewlPJm2xE
   t4kExXXx6bnQtB1UXJqlahXljr/JDGUuOxxQBFgn2LHgvEHxZVO5CVLqs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="232739027"
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="232739027"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 07:29:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="595774333"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jan 2022 07:29:03 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 20 Jan 2022 07:29:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 20 Jan 2022 07:29:03 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 20 Jan 2022 07:29:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEeCuTS3UdQ+8HkJdsal98cJsRlMzxmKdwDbO06benCEpRsF340h6vVYMZ9EDu2rmyaYAyAZ3meYqnzjGRSxWDNgXuMh2anLEhA2Ukh+0F2lhmiNhQvGmJLm1noyW4n/uXOtQLiMPll6tkZ+AXeG7KuRUvApEl1VbVhVeNedbR1KYgJP/c7Udz/2z01ZOxfIsu5XmHlqtgV+iivRPz/XFd4BvwTMscM1kD1g+gsjhzSeLNtpj7mger3Pgq2tTddtxkQ0W9MaE18Gt4rYzfQcVCzWIe/kJs36B5b5DbWfbgOPHDHyOBNldGRV+GxzLYPZjvmzL7rjj0wwy1BW9vQ01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iu5BNv6W8H5Q9RTdkf3XGsgpBujtiheFoPeE+iYlvVs=;
 b=f2mdaNMluvQcryuhuMrALlHmoILcDJbMLDbiYxA6+1S/STr2X8SRvzEl+gmgFyg+5e3lUBBqmPLnSQAVw/HfhfEU+wVwlFlNxBtaHttbRUmgFcnebVtPCZjtErejSUSqTSGKJj96+IiYcLNf7Ujp3FbVVZDvw5QkCdpTWXuRsqwpo4MvQW/IfirUy2QL89UWIBKftzXCL3faXMmhcfy9ST5WzdUCcuFt1ccYfCswfnxswxd2CAUdHSwxErUIXMVpAvVIxcSk7WC7CijrwIpKv0gxsT5/DW2P340hzw1t9Jk4/waoIMTIpyYgkazdqFcd3sjZTGTp9FqqQxsqfCvVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CY4PR11MB1813.namprd11.prod.outlook.com (2603:10b6:903:127::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Thu, 20 Jan
 2022 15:29:00 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4909.011; Thu, 20 Jan 2022
 15:29:00 +0000
Message-ID: <38beed54-cd15-3178-8b73-1c029ba05f68@intel.com>
Date:   Thu, 20 Jan 2022 07:28:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] x86/sgx: Add poison handling to reclaimer
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <tony.luck@intel.com>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <ef74bd9548df61f77e802e7505affcfb5159c48c.1642545829.git.reinette.chatre@intel.com>
 <80083e5ca3fd0a5bd2de43ebc803fc914d09ac3c.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <80083e5ca3fd0a5bd2de43ebc803fc914d09ac3c.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:303:2a::31) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5399c85d-e86d-412c-7a61-08d9dc299518
X-MS-TrafficTypeDiagnostic: CY4PR11MB1813:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB181324FFB802D10822477B31F85A9@CY4PR11MB1813.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0SWmwOCn7/KLFmgJjcBaJ3SE6pMNwuyvboOcXMs18c/9UfuMeeveoh219uvWpcDh3KGfngVErEDPNq9ZdJQj3/7iPNQzXh9dCbxcLSoRfjkm2wlh1VNgwvtbfxVD7viy1gCP061qv7DUGFuuesX4Iq9fB5r+o8CoiWtgkOCV2dQW+DeZTtAxs63Spmz64CmovDc+Ta640PaH/lGLPJJ8NKhb/IObIN71Bwkp0fH012+GYMkSgocsIuHB0Mfw1DgVN8KDKISoMMXqBsKyNSldVwfWqpbFoHW3w8exdJ2W5KS31f0hRDKdl1KhPH9chhl2iXu9eyG20CrSNNzzTMi/v3aF6VWEgsbWhvqkZ1/Gf/djLbRfQPcESviZn56zbtDj2sZJRSiA1HV4LVhbt76duNx8Igc52UfL2ADclJjjRbc4OcobQQgkhCsfNuTQTts5Hp6/sJDbyx+0vzl9W/fdHPED7qruewBfKs0/Y6aOhsvweJQVNfVu01LUN2x1IFiCkF8Hy71MpvGXVGmJ1I7UjolJx9GxTbwpWCeyZu476KND7nU2LV0pA+Tkyi8ecayJOZEKWV0Ny7r26jX2mXDuUoWQmJHUCNW0qohYCdLhlee8V8CeoF/BBgZrT7UCc/qOJ1H3WuSvuBxQLXqA4BqYgIbX3JBJd8z9MXhq+TQUy+a8pQKJQ3OoJxJrgU/azxf4VP7iw/X4EqnLbmml4g9KbeuxsqW26RnDKoczX4HyOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(4326008)(186003)(316002)(82960400001)(86362001)(36756003)(8936002)(2616005)(66476007)(2906002)(44832011)(31686004)(66946007)(6506007)(6666004)(6486002)(508600001)(26005)(53546011)(8676002)(5660300002)(66556008)(6512007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTRMVldyQU1nbUk3OEk4ZzRlQ0hZMGNYcVlrN0d0YURzUzNNS2dpV3lCOVA0?=
 =?utf-8?B?ZU5KNS9VYzd1WkxuV2NjdTFsMGdVSXUyclBucEZ1T3U2RU41Rm9KU2IrTk9v?=
 =?utf-8?B?NUZVM1RSK09ScXRmYUhrZHVVZWlIS01INGZtRkpQbGhlTGZVY244SDJ6MnUv?=
 =?utf-8?B?YTlrdGVETFhIa3p6TVl4RVhzYTdqZWQyQS9qUFcvUGxITDcveStlOFo4QnFK?=
 =?utf-8?B?TGsyV0diL05CY3RlUENqaFFBaWhTUkRKWExHL05kOGJLUzNhV0tSbENZK1pD?=
 =?utf-8?B?UHJOVm1kbW1GKzhWeUI1SEVVUS9oK2wxb3FTOURTZmtKWkxQSHQ4WDkyU3pk?=
 =?utf-8?B?aW1GQm5md2ZYaEdVWmtZU3FOUU5CRVE4aWdYdG5xb1FmSDMyakVNa1RZUi9w?=
 =?utf-8?B?NWVsYU85OEVCZkNuS1lQKzk1bWdGTUhFbEpxVG5rSkFNclNtcG5zSDdhc2J1?=
 =?utf-8?B?cXhnOGFyTkdNeVc5MTlsNzlETjEzVzZjdVBMTzBNUXAveThUdExwbW8xYTdr?=
 =?utf-8?B?Tm9aUnFmSmZmdFVXVTRncHJ4WjlwR05EL2c4bUx3YzIwQk8zNVBQM3U2THZF?=
 =?utf-8?B?R1E3eVYrRU9ZVU55b29lNVFtQXYwMEJreS9EeDNwckUvMlJEaEZuczZITWVh?=
 =?utf-8?B?TmlzUm1iZENLd2ZzeVhYU2t4L2x1eFM1YXdEMDJRcm1pVHp2czkzSnBJdmlP?=
 =?utf-8?B?REpsSmpHRUwxeHFweEplRXpOT1JUOE1jUDgxcUl0MWs5MHJOSVNhSU92YUJh?=
 =?utf-8?B?eDRVTHJwSDdETDB1eEplMTdRSU5NcmdScFZYODVtb3JwSGYxOXpmL3pERitZ?=
 =?utf-8?B?UGVoNGdqZzVRODcvQVBDWUJQWjBBUmNkbkdnL28zV1lMeWNyUmRHMFdwcHFq?=
 =?utf-8?B?T0x4V3Z3MEFTL1BMTUVzNlRYTS9seUoxaTgwVHp6V3ZnY21DdjlIZ1hQbWpB?=
 =?utf-8?B?N3FObThoQlNGNXIzYnp1WG95S05QQndhU1NSRWt0YW1STE9qaEkydmdpMERj?=
 =?utf-8?B?ZkNsbnluVmpkREZ0Yk95bVBFQStES0xLQWwwY3pYZ2RtMTJkN2VLeHZBS01u?=
 =?utf-8?B?T3JrN0EzTXNpc1h6WjdPZDRoeGk4dkxoM01XdC9UM0YxeVFuUW04K2p4NnFB?=
 =?utf-8?B?Ulc4R1VqK2kwWDVDaGx0ckVvZENCdXo5WXd1T2lrWkZiSkNMYXdlSlJTcDB5?=
 =?utf-8?B?VTVRV0dBREF2ck9NTDZUWjJyWkhlSS9aSmVsNGZQV1ZGSUFhTGg1dGl6aUI4?=
 =?utf-8?B?cFlBK1V0R2VTT0Z2RDNrMnBEdHhIWldXR0V6S2NGQnZJT1JtVEtVeUZTb21M?=
 =?utf-8?B?WlUwclQ2a3hGNlRSZHVnckhUanBKWk4vU1I4cmNYcURvbnl4MlRHRUo5d2NJ?=
 =?utf-8?B?Und0SzRSYitrVEVYWjVZcUM3RGR1NzFvSDhEWmtQNkxYTHNFVzRYN08xakpW?=
 =?utf-8?B?QU5yVE9uSWFNaEc3WXlKTWVEdzE5TmdxbWdPV3EvNUR2TFR3OFZmbFNNU1JJ?=
 =?utf-8?B?VXc3MzVuS3Zjb1g2eXBsT3V5S2ZSOWROcXVXSzF4RnBPTFpZdGJCR2RseU5K?=
 =?utf-8?B?emhaRUwvbTVTMVpFUkVUMDBaNFBkZVpEUE50QVVGSlpzcGpXNCtZQ0JtVTZW?=
 =?utf-8?B?UWJLNzQ2dVJWb1VQdCtWb2Z6U2hjNVI0MVJSU1RuYm1tVVptTE11ZmZBYTlM?=
 =?utf-8?B?OHlWdUlIL3lUSS93clUyZ0E1Um1RR3NOTU00Wm9MYmFOaEtXVFhSN0hwa1Z3?=
 =?utf-8?B?cGdtV3NFSjR2WU1IMlFDT05sZzZCTzhhMjd1OERkdDRTbytKN1FiaHlrUzJh?=
 =?utf-8?B?cVBjOC90OWpqWURIZnVjWTF0R1FTQTgxeDlHMURzTC9LZ0pmNGZuc1lQQ2V5?=
 =?utf-8?B?b2pwOUN3REtldFJCYmtkZWx2azIwSEtLUHhhWjVzRVlmN010a05Pb2N5Mm04?=
 =?utf-8?B?TDVXRVMyS1BBbHBiOXJnV3d2d1dHb1RnYmVVM28yK1EySWNzT050b0h1R2tl?=
 =?utf-8?B?THZuRHF5RlIrWkRXOGtLRkZkUk9seFk1ajFCQmllcElsQTZYZkt1c0d0T2d1?=
 =?utf-8?B?ZXVJVlN1c1hkMnpZME5WU3h0aU9xWGw3ZUI0NHJNY1U4T2VHcDY4dDdVSFhz?=
 =?utf-8?B?M2ltRjhiZHpFMXJSVTAzdDBhRndzU1kwWFhXNllGZHJyRTdVYW1jSUN1Mmdt?=
 =?utf-8?B?ZzlrOVE0TFN5NGNWSHF5UWZJN3NqekZHemV3aTBwb01Ud2VNeTJBbFBKais0?=
 =?utf-8?B?UTJoQWFReTlEWjhDRjdLMmprbnFRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5399c85d-e86d-412c-7a61-08d9dc299518
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 15:29:00.5939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AhLIxGmdTWYtnj5JNSlr9qrQKqdh4Od6ZxEpJA8S36Gjy85Pc5lQ21wAn5/X4wdLG+7VgULqjOehXztmHqnWQkTLRmfAtHZbA7kSBJF3XE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1813
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 1/20/2022 4:57 AM, Jarkko Sakkinen wrote:
> On Tue, 2022-01-18 at 15:05 -0800, Reinette Chatre wrote:
>> The machine check recovery handling in SGX added the changes
>> listed below to the freeing of pages in sgx_free_epc_page().
>> The SGX reclaimer contains an open coded version of
>> sgx_free_epc_page() and thus did not obtain the changes in
>> support of poison handling.
>>
>> The changes made to EPC page freeing in support of poison handling
>> are:
>> 1) A new SGX_EPC_PAGE_IS_FREE flag is set when the EPC page is
>>    freed. Introduced in commit d6d261bded8a ("x86/sgx: Add new
>>    sgx_epc_page flag bit to mark free pages").
>> 2) A new "poison" field in struct sgx_epc_page is used to
>>    determine whether a newly freed EPC page should be placed
>>    on the list of poisoned or list of free pages. Introduced
>>    in commit 992801ae9243 ("x86/sgx: Initial poison handling
>>    for dirty and free pages").
>> 3) The owner field in struct sgx_epc_page is cleared when the EPC
>>    page is freed.  Introduced in commit 992801ae9243 ("x86/sgx:
>>    Initial poison handling for dirty and free pages").
>>
>> Replace the open coded enclave page freeing code in the reclaimer
>> with sgx_free_epc_page() to obtain support for poison page handling.
>>
>> Fixes: d6d261bded8a ("x86/sgx: Add new sgx_epc_page flag bit to mark
>> free pages")
> 
> AFAIK, this patch does not semantically break anything so it is not
> a legit fixes tag.
> 

The commit you refer to, commit d6d261bded8a ("x86/sgx: Add new
sgx_epc_page flag bit to mark free pages", introduced a new page flag bit
(SGX_EPC_PAGE_IS_FREE) that should be set when an EPC page is freed. The
commit also sets the bit in sgx_free_epc_page() when an EPC page is freed.
The commit should also have set that bit when the EPC page is freed in the
reclaimer, which contains an open coded version of sgx_free_epc_page(),
but it did not. This fix adds the snippet that was omitted from that
commit.

Reinette
