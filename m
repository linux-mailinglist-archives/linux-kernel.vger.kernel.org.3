Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7516F4D1CBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348106AbiCHQHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348096AbiCHQHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:07:13 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29032506C9;
        Tue,  8 Mar 2022 08:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646755576; x=1678291576;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VY3am+G6/a+K59XViLb73dpmUg6b3cMPRLQ2kWeCOY8=;
  b=ip0OmbO2hujIfOStEhtD6YkXQmKVYW7clDP1/An4zBoK7vAS/tpOjgue
   TrGZdYAgwcyRMnJS2FUHjs6eIbSVwUYkTj/QHdcgdD2HSYfFGNrd8vadx
   XVQCHyQbsQyzvWzbvyoDnIjqLgP5qCWVSr/GhPREAOUVL4F/zjq14Nz7Y
   DzMfHl5dfel4k/ksGtEo+x4i7XQkDj3vMKR1P+m18iERVZ7dwL6/6lqQr
   7t7nu0vnUOLeQxBcp6tIMz37EYKU7v/gpvf/WmYUoQfBfKnIVMgDCmuoh
   KE9/cpE7jkQnrS6qbfZox9I/3lmjiOofwpt0sa50fzYthcYdfbqgGfiYs
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252293107"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="252293107"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 08:04:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="814055697"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 08 Mar 2022 08:04:45 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 08:04:44 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 08:04:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 8 Mar 2022 08:04:43 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 8 Mar 2022 08:04:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3oUrro0r6/YvK8YVZ/DoxYmRYEx8DBiWNpPdLgUVf5GJoHlrIQX+JCpvtnyzdKK/AVvQXtxncqWxX64gK+TR5FqM6W1OSoRFtwr2yehzx93bneLM2yAx3qSfzcjCxPob6wgNq9iQtase5ZOhecjX91cO1LFHbSgdkLyMmc6MikiO4YZkfstnfJFgGZ3a/KUBvwjxkTp5N+HwuYfRv5Kub1hAAaqfP2HshMeLEces/jSjwGJdft8GHMTCpraOKd2g5PQoU7+ORJbRi9aZ4Dszdk0DkPi2XmWLBMpF3TuayyLDm8TjzL4Z9W5mnQiZfjzy7D0P8XoHG3kbIWem8cNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/U1Af0wEqe5ewW9jG3Omxn9tbLPSWPn1jdJ4ni3XsEQ=;
 b=Rb1/qdGXij8LeeQ9bkWT3W0kPeEfDCAcJgWTfzMcT4imY7GobE8p/8buN1xCNYWFGKjSUbhOiw1mnSonuzW1ApjOT+66St7FVFONkOgpY4mdxxurGW9zye/OcDnGtg6See3prziV/aaKCmOaOz7kb+FRXNiUlWss3RXZkUqDTMi4BmSbBoeT18oqOikKABc69I6tK59upu0uDolQhAuYXwUS4kwI53kAQoHg9lGtpRmqcGdkhELFRduNK7qeKgo1dSewyW8tK71bBwzfTOtnU4VgiSxPrP4RdCvV80L1E7VKztvzhw+PMrIHel59mgsRS6FG1P2ETrrJvJExwygp2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MW3PR11MB4697.namprd11.prod.outlook.com (2603:10b6:303:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 16:04:38 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:04:38 +0000
Message-ID: <e7e8dde9-b929-4a01-1e39-dbf3303fdd0c@intel.com>
Date:   Tue, 8 Mar 2022 08:04:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH V2 06/32] x86/sgx: Support VMA permissions more relaxed
 than enclave permissions
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
 <0555a4b4a5e8879eb8f879ab3d9908302000f11c.1644274683.git.reinette.chatre@intel.com>
 <YiY8bD/QcmcHH8dz@iki.fi> <774e906c-53fc-279c-1fb7-0922557a9da5@intel.com>
 <YicQbzR1o1qZUGbw@iki.fi> <YiccplUukAJ5SeFn@iki.fi> <YiceFtul/VsViuUu@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YiceFtul/VsViuUu@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:907::32)
 To BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36045b73-1d9f-4271-7488-08da011d58ea
X-MS-TrafficTypeDiagnostic: MW3PR11MB4697:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MW3PR11MB469722AB99F29B18FAD22BB7F8099@MW3PR11MB4697.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQFKhG+IAYZAp2gxhgj81mNSza8UsoYow2iLxQ2qppopHquZVvf0hAPxEkMiMubuOfIhk1Uezc9ZqPG+fU/WBA6S693hj28v8H6ERIo51YNd0HL7E5081+XUYOXvgdbxL5mzE83Vaq9dsaSBHpbj1RAAjDSEMy7NojgwTtWdS9VkcCPax5QywunjgQfEjQ9LdM5c7ES2S5NzR07NBvOhv66d/KZrS3BZu+H4gJO54QjobF6+2yznAZkZFacCar/ohynzUlwVCyqn6NVy/lg3rNxfog7sgQqYtYrStWKyMebMT8C0KReeyH2ajV1iTHq+XEy/UxKHdOKYZGQXUu4aBOcWUAqyyt0sYSobnjbY2NrmP+26K3Fh6kYr1R1vWZ90zjm3CKAAUbNbdyoZX//Wxp2KaunmDKoGNV9qZ3sE6llTeuprz3wlLVpQ7S95jNbmqZKNihiIqG6e/w22gGxo+wIUDohBpsQw/fOt+GuhaBLcKgJGS7eN/eDNsgSH2ov7lJXxKXkoyzkGLNZV60VigUH25uIw2bjnHPVC746bqXD3Vwb7hoDrzSk0jwn/KhuAZU0Hx49jZxnuPtFJw1fjPF3MU27ffereGV/Bs9P592FsHutYbibCqJCms8VfFGUZoHsTaPPaYiCKcb+F2ReLu4ZkHBzO3nQWiLnLcZKc7o2jDuvBs6LSY7dfHbcYFo0WyTRugp5hTnE71YVI920yo4NAaxKV1yZjdPWi/0T/+x8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6916009)(6512007)(66476007)(66946007)(31686004)(6506007)(53546011)(186003)(26005)(36756003)(30864003)(6666004)(86362001)(83380400001)(4326008)(5660300002)(6486002)(8676002)(7416002)(31696002)(44832011)(8936002)(82960400001)(2906002)(2616005)(316002)(508600001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2JlZkh0ZDRnWmZpU0xPOXlvZzZFKy9xZ1lyV3UrSmFwazV1ZC9mNlZJM0s1?=
 =?utf-8?B?VnhjMDZWazVPOWFwb2xXRnFLaTNtUU9HWWVlYklvSnhrRk5mUnEwTkhJdjhY?=
 =?utf-8?B?NnJhUS9OajR5bWtFTnJvQmVEdXErZmVBWTJLZjlVSmpxOGpzR0w0Z2VGQU9D?=
 =?utf-8?B?TjdzUzgxYXZXT1VtTWFYTEpDR09obzBkQVAwTlVpNlpwTmVKbGFXc0VhcXBu?=
 =?utf-8?B?VDF0emVDQzRhRlpOQ2h2UjZYV1hod2RNWW05VXZxenQ4SGFqWGxIV1hUS2JQ?=
 =?utf-8?B?TUFKaml3bjRjd2xGenNzeVk3dUdOdEdVbzFORW5qSkpUVHZVZSttaVBPckJ5?=
 =?utf-8?B?aFBmVUcxM3lkTktxWE5iRTdRTTlrOFZ1NStnakszdktBU0kyTXZ1VTVjMk1l?=
 =?utf-8?B?eEwxSXV3VHVzOUpvVVlZTmJMekxmTlRxZzFaTW1IdjNCWjdGQ3pqbm0vRjNY?=
 =?utf-8?B?azNZc1B5NjhQV2VydVNXNTlWTGRXVVFBckM3bEFnaUk4MHA0OXBBTVY4bUVT?=
 =?utf-8?B?UXNyVUZ6N2lMWUw4TXAwdkxOZWorSnpLYnFhRjJjekpNRjRpMStyRWVjUkJl?=
 =?utf-8?B?VEVOQ25oaXEvbmhFWjN5OW5VbUNVZzdKQ2ZwWGlPTnF2cGdTeFoyMkgxZmtW?=
 =?utf-8?B?dU40T29BTEdnKzI5SUxnRWFKMG00R3BETm5QV1BiVFp4WkJSYkY2TWIzL0Fx?=
 =?utf-8?B?S2RyTW1obU5uSCtFTFlPUDAxNVFHTjRtR1U0RmVzaTZYcTYxSnR6ZXdiTVVP?=
 =?utf-8?B?Sm01OUwyU2czOVVvbTVOcWYvak1FcHRUT1JzTmJFbkFnQWNISFNyeDBWREkw?=
 =?utf-8?B?MzB1cXM0SkZMOERCREg2VFYrZmtUalJRT21tS3VEYUVDcW5aODZDOWJvUjZn?=
 =?utf-8?B?b2RZYXVtMERaOUVtazBFZnZiNWxiWnVTTlhyYVVBSVR6cEV4dWpCem5qc3gv?=
 =?utf-8?B?RWFPdFV6alF1dXJLT0owN0h6SGhTUXZYZHByZURucHFEdDJMYitHM3EwWUZv?=
 =?utf-8?B?eWo1OHYvOWdFMlByS2k1NU0wNkwwaWRiMDlOL1YrQTJKZlEweUhNN3BDckgv?=
 =?utf-8?B?bUxuQ2xvdXV5VGh3RWovSUxrRXZIZ2lVRVdYK1VHY2hJbnhMNWFLMVFSbGhI?=
 =?utf-8?B?b1dCQUNUbXoxTE1LZUFMR0NFR2J5bVNQT1I0VUNPcEx1MXQ3d1MwSUY4NjJK?=
 =?utf-8?B?aXN6aFVMMS9DSUMxbHlma1J5MksxNXJaSisvTDh3aE4yNjJrRkZ5N2UyNFV5?=
 =?utf-8?B?NXYzMEFHRjJpalNOY05TSVVXRWI2M3JtYjlkYzJnSnlkWGNiQ2JxbEZjTU0x?=
 =?utf-8?B?WGU2aTA1dWRPc0VsMURxMDZpb0hEMWdVaWNCSmt2QTRyaTdDbCtaWWNNQ1p6?=
 =?utf-8?B?d1hOczdPK3Zjeks2U3EwcCt6YllMNS9EZzBSYm01MmN0VllVSDh6bmZxQ2h4?=
 =?utf-8?B?bkJYbWhZK0JtWlpJSGZ4RFlaWjBxUk9kL0dCa1laWGkvckV1TVpmWUk2ZlRw?=
 =?utf-8?B?N3RHOFFld3VoVWZGZVJlZ2dTdzFGeWRJa0Zza3I5S295Uk1FeHJWTWxtdk5h?=
 =?utf-8?B?YlYzdlZ0Zy9VTkJtSkpUYmZmblVWZTlpanZKTzUvWEZ5MS9CQ2Z2RDV1RHVE?=
 =?utf-8?B?QTIwakdudWtNNHh2Z3laZ2ROWVNGbStwcnFURjFFZjNEWDU0Tk55dllFenRK?=
 =?utf-8?B?MFZ4TGhjYjlTRG9TaGVlVEpKdVA0Znc2YUNoRjhpVFBnZlMxVW5ybDAvTmtT?=
 =?utf-8?B?c3l4V3lqZFdHTWlFYUZwa3lxQ2dnQmNwK0QxWFphaE40cStocE12OFN0c1E1?=
 =?utf-8?B?YlBxVk9PY3crL1lsMk5UYjFXbzhUdi9KYWtRdlZreEw4RVVDNzR6NnJwRndm?=
 =?utf-8?B?Q2xUVE1rdTFzNVljL3JvNWdpa2NQbGl1cXh5SmdFa1crQ3V5TXc0cDNFeUQ0?=
 =?utf-8?B?NFpGWXQ0ODdsUXlhZ3hFNCs5RlFLVVJVTmdhNmVkODc3SHZNbjhybUtDMEk1?=
 =?utf-8?B?OE9ZNDRpVmZQT0FwbVNKdnBBZ3VwVlhoTG9ac3N0S2J3akVIMHlJbG5oWTh6?=
 =?utf-8?B?ODdNbGp1R0JXYTJadzlGQXJQcyt3RGplQ0F5RTBmeGQxY2lMVm5JSTlDa2x3?=
 =?utf-8?B?cnR4RjBUYVdROFZKeTFDUkVrTlpaRkxkL2MyVlA1QzhTb0Y4RnEwbWc3U1pk?=
 =?utf-8?B?NlVvV0VTUWVzajZxTHNlRkxwQzJEWXZpVDgwazU4c0h5Q0RQOWxDMDJDaTk4?=
 =?utf-8?B?cEtwbnJqc3BTUXcvd1E3WnBuTEdnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36045b73-1d9f-4271-7488-08da011d58ea
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 16:04:38.6598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1UC0ZA3wm8ImsutOiTpdzxZ4p1cmtBb12UixUj/R+S4HmbCLnmWa23vS9H9HHutrewAQ15HABio9hif/p/S9LsugDJiUFGYvhxo2+I7KAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4697
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/8/2022 1:12 AM, Jarkko Sakkinen wrote:
> On Tue, Mar 08, 2022 at 11:06:46AM +0200, Jarkko Sakkinen wrote:
>> On Tue, Mar 08, 2022 at 10:14:42AM +0200, Jarkko Sakkinen wrote:
>>> On Mon, Mar 07, 2022 at 09:36:36AM -0800, Reinette Chatre wrote:
>>>> Hi Jarkko,
>>>>
>>>> On 3/7/2022 9:10 AM, Jarkko Sakkinen wrote:
>>>>> On Mon, Feb 07, 2022 at 04:45:28PM -0800, Reinette Chatre wrote:
>>>>>> === Summary ===
>>>>>>
>>>>>> An SGX VMA can only be created if its permissions are the same or
>>>>>> weaker than the Enclave Page Cache Map (EPCM) permissions. After VMA
>>>>>> creation this same rule is again enforced by the page fault handler:
>>>>>> faulted enclave pages are required to have equal or more relaxed
>>>>>> EPCM permissions than the VMA permissions.
>>>>>>
>>>>>> On SGX1 systems the additional enforcement in the page fault handler
>>>>>> is redundant and on SGX2 systems it incorrectly prevents access.
>>>>>> On SGX1 systems it is unnecessary to repeat the enforcement of the
>>>>>> permission rule. The rule used during original VMA creation will
>>>>>> ensure that any access attempt will use correct permissions.
>>>>>> With SGX2 the EPCM permissions of a page can change after VMA
>>>>>> creation resulting in the VMA permissions potentially being more
>>>>>> relaxed than the EPCM permissions and the page fault handler
>>>>>> incorrectly blocking valid access attempts.
>>>>>>
>>>>>> Enable the VMA's pages to remain accessible while ensuring that
>>>>>> the PTEs are installed to match the EPCM permissions but not be
>>>>>> more relaxed than the VMA permissions.
>>>>>>
>>>>>> === Full Changelog ===
>>>>>>
>>>>>> An SGX enclave is an area of memory where parts of an application
>>>>>> can reside. First an enclave is created and loaded (from
>>>>>> non-enclave memory) with the code and data of an application,
>>>>>> then user space can map (mmap()) the enclave memory to
>>>>>> be able to enter the enclave at its defined entry points for
>>>>>> execution within it.
>>>>>>
>>>>>> The hardware maintains a secure structure, the Enclave Page Cache Map
>>>>>> (EPCM), that tracks the contents of the enclave. Of interest here is
>>>>>> its tracking of the enclave page permissions. When a page is loaded
>>>>>> into the enclave its permissions are specified and recorded in the
>>>>>> EPCM. In parallel the kernel maintains permissions within the
>>>>>> page table entries (PTEs) and the rule is that PTE permissions
>>>>>> are not allowed to be more relaxed than the EPCM permissions.
>>>>>>
>>>>>> A new mapping (mmap()) of enclave memory can only succeed if the
>>>>>> mapping has the same or weaker permissions than the permissions that
>>>>>> were vetted during enclave creation. This is enforced by
>>>>>> sgx_encl_may_map() that is called on the mmap() as well as mprotect()
>>>>>> paths. This rule remains.
>>>>>>
>>>>>> One feature of SGX2 is to support the modification of EPCM permissions
>>>>>> after enclave initialization. Enclave pages may thus already be part
>>>>>> of a VMA at the time their EPCM permissions are changed resulting
>>>>>> in the VMA's permissions potentially being more relaxed than the EPCM
>>>>>> permissions.
>>>>>>
>>>>>> Allow permissions of existing VMAs to be more relaxed than EPCM
>>>>>> permissions in preparation for dynamic EPCM permission changes
>>>>>> made possible in SGX2.  New VMAs that attempt to have more relaxed
>>>>>> permissions than EPCM permissions continue to be unsupported.
>>>>>>
>>>>>> Reasons why permissions of existing VMAs are allowed to be more relaxed
>>>>>> than EPCM permissions instead of dynamically changing VMA permissions
>>>>>> when EPCM permissions change are:
>>>>>> 1) Changing VMA permissions involve splitting VMAs which is an
>>>>>>    operation that can fail. Additionally changing EPCM permissions of
>>>>>>    a range of pages could also fail on any of the pages involved.
>>>>>>    Handling these error cases causes problems. For example, if an
>>>>>>    EPCM permission change fails and the VMA has already been split
>>>>>>    then it is not possible to undo the VMA split nor possible to
>>>>>>    undo the EPCM permission changes that did succeed before the
>>>>>>    failure.
>>>>>> 2) The kernel has little insight into the user space where EPCM
>>>>>>    permissions are controlled from. For example, a RW page may
>>>>>>    be made RO just before it is made RX and splitting the VMAs
>>>>>>    while the VMAs may change soon is unnecessary.
>>>>>>
>>>>>> Remove the extra permission check called on a page fault
>>>>>> (vm_operations_struct->fault) or during debugging
>>>>>> (vm_operations_struct->access) when loading the enclave page from swap
>>>>>> that ensures that the VMA permissions are not more relaxed than the
>>>>>> EPCM permissions. Since a VMA could only exist if it passed the
>>>>>> original permission checks during mmap() and a VMA may indeed
>>>>>> have more relaxed permissions than the EPCM permissions this extra
>>>>>> permission check is no longer appropriate.
>>>>>>
>>>>>> With the permission check removed, ensure that PTEs do
>>>>>> not blindly inherit the VMA permissions but instead the permissions
>>>>>> that the VMA and EPCM agree on. PTEs for writable pages (from VMA
>>>>>> and enclave perspective) are installed with the writable bit set,
>>>>>> reducing the need for this additional flow to the permission mismatch
>>>>>> cases handled next.
>>>>>>
>>>>>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>>>>>> ---
>>>>>> Changes since V1:
>>>>>> - Reword commit message (Jarkko).
>>>>>> - Use "relax" instead of "exceed" when referring to permissions (Dave).
>>>>>> - Add snippet to Documentation/x86/sgx.rst that highlights the
>>>>>>   relationship between VMA, EPCM, and PTE permissions on SGX
>>>>>>   systems (Andy).
>>>>>>
>>>>>>  Documentation/x86/sgx.rst      | 10 +++++++++
>>>>>>  arch/x86/kernel/cpu/sgx/encl.c | 38 ++++++++++++++++++----------------
>>>>>>  2 files changed, 30 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
>>>>>> index 89ff924b1480..5659932728a5 100644
>>>>>> --- a/Documentation/x86/sgx.rst
>>>>>> +++ b/Documentation/x86/sgx.rst
>>>>>> @@ -99,6 +99,16 @@ The relationships between the different permission masks are:
>>>>>>  * PTEs are installed to match the EPCM permissions, but not be more
>>>>>>    relaxed than the VMA permissions.
>>>>>>  
>>>>>> +On systems supporting SGX2 EPCM permissions may change while the
>>>>>> +enclave page belongs to a VMA without impacting the VMA permissions.
>>>>>> +This means that a running VMA may appear to allow access to an enclave
>>>>>> +page that is not allowed by its EPCM permissions. For example, when an
>>>>>> +enclave page with RW EPCM permissions is mapped by a RW VMA but is
>>>>>> +subsequently changed to have read-only EPCM permissions. The kernel
>>>>>> +continues to maintain correct access to the enclave page through the
>>>>>> +PTE that will ensure that only access allowed by both the VMA
>>>>>> +and EPCM permissions are permitted.
>>>>>> +
>>>>>>  Application interface
>>>>>>  =====================
>>>>>>  
>>>>>> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
>>>>>> index 48afe96ae0f0..b6105d9e7c46 100644
>>>>>> --- a/arch/x86/kernel/cpu/sgx/encl.c
>>>>>> +++ b/arch/x86/kernel/cpu/sgx/encl.c
>>>>>> @@ -91,10 +91,8 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
>>>>>>  }
>>>>>>  
>>>>>>  static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
>>>>>> -						unsigned long addr,
>>>>>> -						unsigned long vm_flags)
>>>>>> +						unsigned long addr)
>>>>>>  {
>>>>>> -	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
>>>>>>  	struct sgx_epc_page *epc_page;
>>>>>>  	struct sgx_encl_page *entry;
>>>>>>  
>>>>>> @@ -102,14 +100,6 @@ static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
>>>>>>  	if (!entry)
>>>>>>  		return ERR_PTR(-EFAULT);
>>>>>>  
>>>>>> -	/*
>>>>>> -	 * Verify that the faulted page has equal or higher build time
>>>>>> -	 * permissions than the VMA permissions (i.e. the subset of {VM_READ,
>>>>>> -	 * VM_WRITE, VM_EXECUTE} in vma->vm_flags).
>>>>>> -	 */
>>>>>> -	if ((entry->vm_max_prot_bits & vm_prot_bits) != vm_prot_bits)
>>>>>> -		return ERR_PTR(-EFAULT);
>>>>>> -
>>>>>>  	/* Entry successfully located. */
>>>>>>  	if (entry->epc_page) {
>>>>>>  		if (entry->desc & SGX_ENCL_PAGE_BEING_RECLAIMED)
>>>>>> @@ -138,7 +128,9 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
>>>>>>  {
>>>>>>  	unsigned long addr = (unsigned long)vmf->address;
>>>>>>  	struct vm_area_struct *vma = vmf->vma;
>>>>>> +	unsigned long page_prot_bits;
>>>>>>  	struct sgx_encl_page *entry;
>>>>>> +	unsigned long vm_prot_bits;
>>>>>>  	unsigned long phys_addr;
>>>>>>  	struct sgx_encl *encl;
>>>>>>  	vm_fault_t ret;
>>>>>> @@ -155,7 +147,7 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
>>>>>>  
>>>>>>  	mutex_lock(&encl->lock);
>>>>>>  
>>>>>> -	entry = sgx_encl_load_page(encl, addr, vma->vm_flags);
>>>>>> +	entry = sgx_encl_load_page(encl, addr);
>>>>>>  	if (IS_ERR(entry)) {
>>>>>>  		mutex_unlock(&encl->lock);
>>>>>   
>>>>>> @@ -167,7 +159,19 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
>>>>>>  
>>>>>>  	phys_addr = sgx_get_epc_phys_addr(entry->epc_page);
>>>>>>  
>>>>>> -	ret = vmf_insert_pfn(vma, addr, PFN_DOWN(phys_addr));
>>>>>> +	/*
>>>>>> +	 * Insert PTE to match the EPCM page permissions ensured to not
>>>>>> +	 * exceed the VMA permissions.
>>>>>> +	 */
>>>>>> +	vm_prot_bits = vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
>>>>>> +	page_prot_bits = entry->vm_max_prot_bits & vm_prot_bits;
>>>>>> +	/*
>>>>>> +	 * Add VM_SHARED so that PTE is made writable right away if VMA
>>>>>> +	 * and EPCM are writable (no COW in SGX).
>>>>>> +	 */
>>>>>> +	page_prot_bits |= (vma->vm_flags & VM_SHARED);
>>>>>> +	ret = vmf_insert_pfn_prot(vma, addr, PFN_DOWN(phys_addr),
>>>>>> +				  vm_get_page_prot(page_prot_bits));
>>>>>>  	if (ret != VM_FAULT_NOPAGE) {
>>>>>>  		mutex_unlock(&encl->lock);
>>>>>>  
>>>>>> @@ -295,15 +299,14 @@ static int sgx_encl_debug_write(struct sgx_encl *encl, struct sgx_encl_page *pag
>>>>>>   * Load an enclave page to EPC if required, and take encl->lock.
>>>>>>   */
>>>>>>  static struct sgx_encl_page *sgx_encl_reserve_page(struct sgx_encl *encl,
>>>>>> -						   unsigned long addr,
>>>>>> -						   unsigned long vm_flags)
>>>>>> +						   unsigned long addr)
>>>>>>  {
>>>>>>  	struct sgx_encl_page *entry;
>>>>>>  
>>>>>>  	for ( ; ; ) {
>>>>>>  		mutex_lock(&encl->lock);
>>>>>>  
>>>>>> -		entry = sgx_encl_load_page(encl, addr, vm_flags);
>>>>>> +		entry = sgx_encl_load_page(encl, addr);
>>>>>>  		if (PTR_ERR(entry) != -EBUSY)
>>>>>>  			break;
>>>>>>  
>>>>>> @@ -339,8 +342,7 @@ static int sgx_vma_access(struct vm_area_struct *vma, unsigned long addr,
>>>>>>  		return -EFAULT;
>>>>>>  
>>>>>>  	for (i = 0; i < len; i += cnt) {
>>>>>> -		entry = sgx_encl_reserve_page(encl, (addr + i) & PAGE_MASK,
>>>>>> -					      vma->vm_flags);
>>>>>> +		entry = sgx_encl_reserve_page(encl, (addr + i) & PAGE_MASK);
>>>>>>  		if (IS_ERR(entry)) {
>>>>>>  			ret = PTR_ERR(entry);
>>>>>>  			break;
>>>>>> -- 
>>>>>> 2.25.1
>>>>>>
>>>>>
>>>>> If you unconditionally set vm_max_prot_bits to RWX for dynamically created
>>>>> pags, you would not need to do this.
>>>>>
>>>>> These patches could be then safely dropped then:
>>>>>
>>>>> - [PATCH V2 06/32] x86/sgx: Support VMA permissions more relaxed than enclave permissions 
>>>>> - [PATCH V2 08/32] x86/sgx: x86/sgx: Add sgx_encl_page->vm_run_prot_bits for dynamic permission changes
>>>>> - [PATCH V2 15/32] x86/sgx: Support relaxing of enclave page permissions
>>>>>
>>>>> And that would also keep full ABI compatibility without exceptions to the
>>>>> existing mainline code.
>>>>>
>>>>
>>>> Dropping these changes do not just impact dynamically created pages. Dropping
>>>> these patches would result in EPCM page permission restriction being supported
>>>> for all pages, those added before enclave initialization as well as dynamically
>>>> added pages, but their PTEs will not be impacted.
>>>>
>>>> For example, if a RW enclave page is added via SGX_IOC_ENCLAVE_ADD_PAGES and
>>>> then later made read-only via SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS then Linux
>>>> would keep allowing and installing RW PTEs to this page.
>>>
>>> I think that would be perfectly fine, if someone wants to do that. There is
>>> no corrateral damage on doing that. Kernel does not get messed because of
>>> that. It's a use case that does not make sense in the first place, so it'd
>>> be stupid to build anything extensive around it to the kernel.
>>>
>>> Shooting yourself to the foot is something that kernel does and should not
>>> protect user space from unless there is a risk of messing the state of the
>>> kernel itself.
>>>
>>> Much worse is that we have e.g. completely artificial ioctl
>>> SGX_IOC_ENCLAVE_RELAX_PERMISSIONS to support this scheme, which could e.g.
>>> cause extra roundtrips for simple EMODPE.
>>>
>>> Also this means not having to include 06/32, which keeps 100% backwards
>>> compatibility in run-time behaviour to the mainline while not restricting
>>> at all dynamically created pages. And we get rid of complex book keeping
>>> of vm_run_prot_bits.
>>>
>>> And generally the whole model is then very easy to understand and explain.
>>> If I had to keep presentation of the current mess in the patch set in a
>>> conference, I can honestly say that I would be in serious trouble. It's
>>> not clean and clear security model, which is a risk by itself.
>>
>> I.e.
>>
>> 1. For EADD'd pages: stick what has been the invariant 1,5 years now. Do
>>    not change it by any means (e.g. 06/32).
>> 2. For EAUG'd pages: set vm_max_prot_bits RWX, which essentially means do
>>    what ever you want with PTE's and EPCM.
>>
>> It's a clear and understandable model that does nothing bad to the kernel,
>> and a run-time developer can surely find away to get things on going. For
>> user space, the most important thing is the clarity in kernel behaviour,
>> and this does deliver that clarity. It's not perfect but it does do the
>> job and anyone can get it.
> 
> Also a quantitive argument for this is that by simplifying security model
> this way it is one ioctl less, which must be considered as +1. We do not
> want to add new ioctls unless it is something we absolutely cannnot live
> without. We absolutely can live without SGX_IOC_ENCLAVE_RELAX_PERMISSIONS.
> 

ok, with the implications understood and accepted I will proceed with a new
series that separates EPCM from PTEs and make RWX PTEs possible by default
for EAUG pages. This has broader impact than just removing
the three patches you list. "[PATCH 07/32] x86/sgx: Add pfn_mkwrite() handler
for present PTEs" is also no longer needed and there is no longer a need
to flush PTEs after restricting permissions. New changes also need to
be considered - at least the current documentation. I'll rework the series.

Reinette
