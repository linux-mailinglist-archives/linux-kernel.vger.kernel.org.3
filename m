Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973BA4C1CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244544AbiBWTzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiBWTzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:55:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF444C40E;
        Wed, 23 Feb 2022 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645646112; x=1677182112;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZW7aPKDpXwiZZwi95yRsOHxXr+/A+9DJSdNRovrUdKE=;
  b=AiUrMhL8rWN7J1mot9HL37B9SIIElMXhAQkQnuyDd4+VeRyqRoSlO6Nw
   WOT9LvLKTZymSo91Nll3jP355C6UDbGVdfZuFArMymWauDMqWKsZTqShT
   FGS1nnsm7/nT9MDpegJA/KU9hQe/SjQOK0sC7FGRVD43fQTPVbGy+mXt7
   jsksRb+H9p9ENU+oLec48YKvjATSNH1DV8YdmSopd5feWHX+Kp3oOtIS2
   KXaJeSFXRvrQAICtf7UHxoZgmKX+i3xrOZsLMXF9fEJDf/4IUPqjip3y2
   JNX0yktLCVsyJwtk5CmNEF46j5kCkZFHnWFnzHGA4rfqllqjsX1TGxnGw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="251987288"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="251987288"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 11:55:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="573955442"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 23 Feb 2022 11:55:11 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 11:55:10 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 23 Feb 2022 11:55:10 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 23 Feb 2022 11:55:10 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 23 Feb 2022 11:55:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9mXJc0IcXElpCheoWSM/Ql0hsuot60rtAlm8V/K8J0eq1lVTBOyP69YW4VTrVJ6LcpHT7pfX1iQauvCktIiTR0nQSzdHK4aJnl2YRQEFztUIE9ItsOscYucYsMMynsBLIrSicaFfgqo1E9236D2y4QUxRtacsijsCE9bl7W3sjN5JXXn3ZqUsgFDnGLvc2YrjTUEpfo/Jrm22aDR+zbLHv/+QXDv1hxwxSXuYK5nM4Rqm3w/Pd4QNKmAsESkRgg3KrwR4scwqxytI0O/W7Cw/nJ+e63AE8shF+tnme5nlk1y4MwYsBxo81JqU2fE5jQPDEHDjFDQGmQEGkrMd99Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMD/HV013hnUUSTUXtbBagWjjLaapy/M66/SkYjrhXQ=;
 b=dvp/NZp9KcB/t2VRZTG9qHNluJame18GRAqviBIpaITxHEX//x6wrdngL9lDYVi+ePDAq+QOC8AypjNOFgmXvZuxP6OwNNC1d3cBGjtIw2djxxgaR4bns1bleU0l7amECsVPEnpqSIQMhVEJO75Z5ER+rW/Ob3VK7eeEPgX3GG255tYK9M1hCIaaGYX8y0z2ooSpYL/ua4zcGgk92mZY/vhQEWc9VIYavSsRHYi0po6OxthGvc7HuCHngWtt4y+kZjESoTBJOlu4euPjgIbdSpoNWpEg+obKLU9iS0LA5yXPLahN38K2d3Y7zMHOmwpIVeytSeCXPI1Bj1wZlpNiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2627.namprd11.prod.outlook.com (2603:10b6:406:ae::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Wed, 23 Feb
 2022 19:55:08 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%4]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 19:55:08 +0000
Message-ID: <8edb849e-3992-187c-cf86-a047cc6ea1f9@intel.com>
Date:   Wed, 23 Feb 2022 11:55:03 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.0
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi> <d6a5c304-d448-5f0c-6367-26dcba872db3@intel.com>
 <YhZWvFSuax2GI9cQ@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YhZWvFSuax2GI9cQ@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR2201CA0051.namprd22.prod.outlook.com
 (2603:10b6:301:16::25) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f68f948f-0817-4013-7ae4-08d9f706648c
X-MS-TrafficTypeDiagnostic: BN7PR11MB2627:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB26270B3569A610665845813AF83C9@BN7PR11MB2627.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TpR91JJKgzSp2+KE789MV1nTZzLx5WL0iPSwfRcq6p7QVDnc9nqpGWWFE866xOUpdeb9mafTUchAn+HDWmh4Jdn6AVyAfspD1o97ivrWQ3rpFieWfL39OpkEtDk1HW/MCFEWWm+nY0rIGi790pZd3QonC7m/oVGgagzKptDncIoVv77lP6/AXPzLWWb8Zt7/H7b+FhNC7kxf8kOyT4oBdIGrnXSkZzTqFNLhbsNvCzNf4MQNGAcP8SFTRBunPG3H+RTsMvMCVlJcELHguBYUPsA3joop8DDLewx1awlsXuzpPsYYrhRnsCyufuievaRcS22IEF9Acqw+cehLfthkMio9bHPsidfZOfRBd1IhWOKudYIDBuPmcR32c56OqFX6LThUouCxOqia0FTSaNtc76Hzx+FX/Cj4GMgCf65Ib0u16xi2RxkdrIjETweNo8UuEnVEhL0warJFRs/HKsr6zUT2W+cSE/xhegtIX5XttVlaPlttfPPJnBvorbL60dv8KMGvakCSThZqTENpTqzjLQ69cvj44rH+t3lg3023au2wBvXDrXDfFf3mnqsrDx0ZZJQDYILIbUUJo5T0YuFiGY/rEHkCEbU/zKN4uyX7OsViQzjHt1gJdF129GN+Pjnq2Z7S6iOV4pqvKEQ8H9Vws6E9SzJECpVthUckMCP2wILLw2qSYKuhcd7Hnge5+w674MGH4N0hIOYx77H6IWhkpv07a72mWvJOVWuLeGBFXD0xt6/+jyi5jLIRletthlz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(6506007)(186003)(26005)(86362001)(44832011)(38100700002)(6666004)(82960400001)(31686004)(53546011)(2906002)(7416002)(508600001)(316002)(6916009)(4326008)(83380400001)(31696002)(6512007)(8936002)(2616005)(5660300002)(66946007)(66556008)(66476007)(8676002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDhUTzUwc05aVlFGYUxVNXFTR280WGRGNXkzRzZCRy83RnpxbVltSnNPYzdn?=
 =?utf-8?B?KzBnRzg4SDdSUXEyM3pKZVFxNnpXY0V2Rm43WCtFbWFPNjRySXViVnAzelM5?=
 =?utf-8?B?bHIzSHhsTHkrZVpwVmh1QzV5OE03M0lvUnFnc2ZJMjVJcTA1NzQwT0d4SGFO?=
 =?utf-8?B?SkFicXRXa2ZZL0MyMHhEYVZxY2NEZ0M3Rmo2eEFoUTltVmhHZlRETlpsWThT?=
 =?utf-8?B?M1BRcGxmdkIvS21QMU5GaytlT2pzU3h3NmNKWVRMb3Jnc2h0cU5KRVFGNmFB?=
 =?utf-8?B?NnJQZlhJRi9aQXRacXY1djNYMHVqZ3luRVk5Sm5PazQvMWJIVmR2d2FGdzRU?=
 =?utf-8?B?KzdRQ3l3L2ZjRTI1MGxaK1JyYWNXQ2xpblBHMEgxc3BWMGlQVHBXeEdnMmZM?=
 =?utf-8?B?c2JGL1ViMmFGdGF6Q3RaWkkvUjVmbkYyYjJoODA3dmVwbU1lY0ZsZFVIZnZo?=
 =?utf-8?B?RzB5VXZDekU2NlBKTk1lZEhVK0YwNC9XeHFKVTlWdGp0bVVnemN2SWxBMENu?=
 =?utf-8?B?SHpmT1NqRVAxckRaVlh1ODRpREJSN09xb2poMnlFUzJzS0I0dk9rN3Vnd2Yr?=
 =?utf-8?B?MG04d0hENVdBRlVtYXoxQlVvMVNIb1QyQzRaR0N5MFR4elRDZ0docVdQeDVD?=
 =?utf-8?B?TDZ6QjFsOFJ5RXhSK0V2Z0o3OE5XbUduRmZRalBTMzdCVkxKT0Y3Tm02eU5l?=
 =?utf-8?B?SFJoYkV2Q0lUZGtrbkQ1MkhOMXdLR016VVowWVg1Q0VBUVFGZ21ncEV6WU1Y?=
 =?utf-8?B?bk1uVUJmVWwwQityLythMjBmM0lHRFc2QVpEYjVURUd4YU80blVTaSsyckwv?=
 =?utf-8?B?Z3FFQ1N6UVV4TzJ3ZFQ1UnhWNFJIaEswdkZ3b2syUXlaVVpuR29meGR4WUVs?=
 =?utf-8?B?TTFZYzlMSjZpK29BdEFQdTJLUk1UdTViMmVUUm9scWlwb3pIa01RNEFiZDdj?=
 =?utf-8?B?TTJua2Y5Z1BVMXgvSWpva3JjclRLajMvN2hpNjVwNmVVbUJ3V3VtS3FpeWta?=
 =?utf-8?B?dlUyKzBLM3c1VU1kRTUyWmxhV2h0UEVXYVE4cGlXOUVkdVh0WVBYcnM4NWJG?=
 =?utf-8?B?REROT0NZZkx0YW1BVEIyWUgvZzZlU2oxZjBIbTZjdkNFd0Vvd0Nnb2RiSmcv?=
 =?utf-8?B?NVdzS3FNU3JxMEtrUWw5cEM4R0dDTWNkdUZTelZ6UmE4Q0JZZFpxcGVVNGNT?=
 =?utf-8?B?RkdvU3MvL3puaVVjRXRaVmdGc2s5M1NxOHR5emtoa0RCTEJDam5IRkRDajlE?=
 =?utf-8?B?ZjNYTXh3NUl4Y0lyRUZicGJBNGZaRDU3cjA3VzV2ZVYzRmdNVExnNlNSd2pL?=
 =?utf-8?B?NTFWM01oLythQTg4NS9XL3ZTNEtHTUJDdlNQNkZJQ2RHbk1WOGJUTXJEdVc3?=
 =?utf-8?B?T1hCenpFdHR6SHV0VVRYOG4xakVpN0d0Qng1R3k5VlorK0JWSFNLbVUrV0RH?=
 =?utf-8?B?aUo1OWplS29ycTZac1JCbkp1ZU5sZ3N5Ty96S29CY0p1aEFYUzJ5eDVqSWdJ?=
 =?utf-8?B?ZEhzZTE2dVAveVdJczhkc0QvaTdpVFR2cUdUcklRb1pibDlybkRpbldFaXky?=
 =?utf-8?B?TVBleHhTWXlEekpvZUJYaUcyZUlHU3hva05NZ0xzazl4RGlqODlIbkFKMmJr?=
 =?utf-8?B?WlYwc0o2RDZLNXl0N2s3NU9IS3A3dE5XcGdrbUV3YVlySG0vYVFiV3N3ekJo?=
 =?utf-8?B?WGh5djF5Sk5pMklQY01kVjhFbXRQekFKVExkYzZaUmYrNUpINVpTbzJrMHEw?=
 =?utf-8?B?Wm9GbFlybGR6Wk5EVEtyWDh1U0k4VnRsZnBBUFVnSGd6Rmc5YjZaYzVzVmll?=
 =?utf-8?B?TjVYdy9VR1N6bWl3Vm1nTnM5cWIwYTFoWnBpek8ybjlLYU83WEFweDE3ZEow?=
 =?utf-8?B?YlpNa0JBTlRUdE9VR0VpZGRuTDVmcFQxb3E0Q3BXOEl0dzI1VjJTbHEzY3Vm?=
 =?utf-8?B?WWNYNlJPZ2ZTaHByL0tvM3dmNzU2UjBnZ3ovR3dPcFJHLzhyMlpEV012aFd0?=
 =?utf-8?B?bjZGNmtZdFJaWDBHOGkyb2QvVGJrb2MvUG1UMXdYSkdDVndZbHRnM2hYenlU?=
 =?utf-8?B?M2FlMVRYSHM4V2J5VDdaUGNuRkxvZ3AxZTZtSlNCekVaUjRPQkVhUFNMZHZj?=
 =?utf-8?B?MjNWS2EzKzlvTXE5ejlOdW82TktpWTd5Z0pPaHJRU0dxcithZy9kUXlZRXR5?=
 =?utf-8?B?Mlcwd1FMOFg5clRFVmdrM0lraDhJRlV5OXZZalVaNXk4NWJOT2R0L1JjZFJy?=
 =?utf-8?Q?AS4b1AYrdAtzoIukaq89CykGwb9oHJsmyUk84gqFEw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f68f948f-0817-4013-7ae4-08d9f706648c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 19:55:08.2021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5ZTOLNEcdXv+TROqxnAf8QZT9q905FHCZPweJBzzNB+DyWHdG8F1Ne5dLTnCHCvOx++sTSOl6LzRtJQokZqekiR6tSVETDDYHlXd6189sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2627
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 2/23/2022 7:46 AM, Jarkko Sakkinen wrote:
> On Tue, Feb 22, 2022 at 10:35:04AM -0800, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 2/20/2022 4:49 PM, Jarkko Sakkinen wrote:
>>> On Mon, Feb 07, 2022 at 04:45:38PM -0800, Reinette Chatre wrote:
>>
>> ...
>>
>>>> diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
>>>> index 5c678b27bb72..b0ffb80bc67f 100644
>>>> --- a/arch/x86/include/uapi/asm/sgx.h
>>>> +++ b/arch/x86/include/uapi/asm/sgx.h
>>>> @@ -31,6 +31,8 @@ enum sgx_page_flags {
>>>>  	_IO(SGX_MAGIC, 0x04)
>>>>  #define SGX_IOC_ENCLAVE_RELAX_PERMISSIONS \
>>>>  	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_relax_perm)
>>>> +#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
>>>> +	_IOWR(SGX_MAGIC, 0x06, struct sgx_enclave_restrict_perm)
>>>>  
>>>>  /**
>>>>   * struct sgx_enclave_create - parameter structure for the
>>>> @@ -95,6 +97,25 @@ struct sgx_enclave_relax_perm {
>>>>  	__u64 count;
>>>>  };
>>>>  
>>>> +/**
>>>> + * struct sgx_enclave_restrict_perm - parameters for ioctl
>>>> + *                                    %SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
>>>> + * @offset:	starting page offset (page aligned relative to enclave base
>>>> + *		address defined in SECS)
>>>> + * @length:	length of memory (multiple of the page size)
>>>> + * @secinfo:	address for the SECINFO data containing the new permission bits
>>>> + *		for pages in range described by @offset and @length
>>>> + * @result:	(output) SGX result code of ENCLS[EMODPR] function
>>>> + * @count:	(output) bytes successfully changed (multiple of page size)
>>>> + */
>>>> +struct sgx_enclave_restrict_perm {
>>>> +	__u64 offset;
>>>> +	__u64 length;
>>>> +	__u64 secinfo;
>>>> +	__u64 result;
>>>> +	__u64 count;
>>>> +};
>>>> +
>>>>  struct sgx_enclave_run;
>>>>  
>>>>  /**
>>
>> ...
>>
>>>
>>> Just a suggestion but these might be a bit less cluttered explanations of
>>> the fields:
>>>
>>> /// SGX_IOC_ENCLAVE_RELAX_PERMISSIONS parameter structure
>>> #[repr(C)]
>>> pub struct RelaxPermissions {
>>>     /// In: starting page offset
>>>     offset: u64,
>>>     /// In: length of the address range (multiple of the page size)
>>>     length: u64,
>>>     /// In: SECINFO containing the relaxed permissions
>>>     secinfo: u64,
>>>     /// Out: length of the address range successfully changed
>>>     count: u64,
>>> };
>>>
>>> /// SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS parameter structure
>>> #[repr(C)]
>>> pub struct RestrictPermissions {
>>>     /// In: starting page offset
>>>     offset: u64,
>>>     /// In: length of the address range (multiple of the page size)
>>>     length: u64,
>>>     /// In: SECINFO containing the restricted permissions
>>>     secinfo: u64,
>>>     /// In: ENCLU[EMODPR] return value
>>>     result: u64,
>>>     /// Out: length of the address range successfully changed
>>>     count: u64,
>>> };
>>
>> In your proposal you shorten the descriptions from the current implementation.
>> I do consider the removed information valuable since I believe that it helps
>> users understand the kernel interface requirements without needing to be
>> familiar with or dig into the kernel code to understand how the provided data
>> is used.
>>
>> For example, you shorten offset to "starting page offset", but what was removed
>> was the requirement that this offset has to be page aligned and what the offset
>> is relative to. I do believe summarizing these requirements upfront helps
>> a user space developer by not needing to dig through kernel code later
>> in order to understand why an -EINVAL was received.
>>
>>  
>>> I can live with the current ones too but I rewrote them so that I can
>>> quickly make sense of the fields later. It's Rust code but the point is
>>> the documentation...
>>
>> Since you do seem to be ok with the current descriptions I would prefer
>> to keep them.
> 
> Yeah, they are fine to me.
> 
>>> Also, it should not be too much trouble to use the struct in user space
>>> code even if the struct names are struct sgx_enclave_relax_permissions and
>>> struct sgx_enclave_restrict_permissions, given that you most likely have
>>> exactly single call-site in the run-time.
>>
>> Are you requesting that I make the following name changes?
>> struct sgx_enclave_relax_perm -> struct sgx_enclave_relax_permissions
>> struct sgx_enclave_restrict_perm -> struct sgx_enclave_restrict_permissions
>>
>> If so, do you want the function names also written out in this way?
>> sgx_enclave_relax_perm()        -> sgx_enclave_relax_permissions()
>> sgx_ioc_enclave_relax_perm()    -> sgx_ioc_enclave_relax_permissions()
>> sgx_enclave_restrict_perm()     -> sgx_enclave_restrict_permissions()
>> sgx_ioc_enclave_restrict_perm() -> sgx_ioc_enclave_restrict_permissions()
> 
> Yes, unless you have a specific reason to shorten them :-)

Just aesthetic reasons ... having a long function name can look unbalanced
if it has many parameters and if the parameters themselves are long it
becomes hard to keep to the required line length.

Even so, it does look as though the longest ones can be made to work within 80
characters:
sgx_enclave_restrict_permissions(...
                                 struct sgx_enclave_restrict_permissions *modp,
                                 ...)

Other (aesthetic) consequence would be, for example, the core sgx_ioctl() would
now have some branches span more lines than other so it would not look as neat as
now (this is subjective I know).

Apart from the aesthetic reasons I do not have another reason not to make the
change and I will do so in the next version.

Reinette
