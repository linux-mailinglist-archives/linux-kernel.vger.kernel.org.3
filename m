Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179BF4D050B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbiCGRPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiCGRO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:14:58 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6718AE5C;
        Mon,  7 Mar 2022 09:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646673244; x=1678209244;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jhx20D42yjI5q4k1RnMuILLZVomYj4AQH0WcUq9eyQg=;
  b=YRHhpaQyJDRMx4TwEsiVZp1z7KZS4hr+XR/n5dwCIyAhN3NPpb+5uprm
   HrY/msK6AnAWKbfG6IxTSK7kBbCrwcIXQGKaJt+gXwSs5n9u4kVWIocC8
   fRIsrNAob0SbOu2DfeNTpSEEauK/yAa8dcfiuPyqPSGgukWnlMwsqDPCr
   5I60LCoXPKohPUNAIpGQ/6K+soYsTyTnY2MnBk/mDePbZ6dS1DTgTk+Ee
   JuzLa0WIxG+lDJEzK5H+UUkPNalg34Xqs+shPnrv1AmbebeZyKQYEWXIQ
   CwrHz5pfGnpMAWiK7hu+jqKKnBw9INCGvEG1QD/96U/A5F/+cX6oGvcrl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="235057770"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="235057770"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 09:14:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="687607084"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2022 09:13:58 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 09:13:56 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 09:13:55 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 7 Mar 2022 09:13:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 7 Mar 2022 09:13:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMYi7jwdch93em6wr1dLITSEGnc5kJPLJFsLuNEY8exOEvFKOqhRVlpc1y9nCKWWpJCFKirRmt10QLWhvJF0/sJEcWJVnk+Soc0rRAIhyFkpsvcPy3eDsF066cP93BmCm2jcOehQXUsk8Ig05qTvoIRGido/7rJFhkN5f7SlFI1d/x7/I784+BxKJJVrZCoCjaKO0rLIvtSSdLT0JgzV/hmee4m0lmFgfm9IldSaBkEnscFGAd7f+xzR2bnCiBsImcqA3FfX21RSKn9zCdtoPEUlUEvrFZbtc5Z3nOj0QNU1u5gzcM/AIIAFfnqJrRaNuDiR21ntZ8PiyU2v/MdFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDAjKnJGbCEgDFpdSBni6iH5iF2T4qLQ0VNHYFyBt9I=;
 b=RuLNMwYFbMjawSfOQ1iWxTzAPI+mjGu9Nfvc14aZJWm/rhmpvVQ/hjCvN2iF0BFahDXE3dConQFDjpV4yOf7JhKupxPaP/0EeHK5ltVp7DnJJeBEf0lRxII61ceXiX6FIAkvN2rFlsiKdA+jiALTLS3Xe8Gs/CIIDxD4TD6SK7c+xWOqb0kypYSkH01p6rigfp+GHVjdQXI57P4MD5cArHCFLbsxNtvfCDyr6jJEj/TQjOJwdYREUBFW8sl+0PU3JochgXT9anEIOVyUiBWqa/RVnv2hTPRBekXK7qxXbEMOrE8wPKnloIWMM/R2dUoSJ7o0/FHiLsK+9SJqN6vywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SN6PR11MB3118.namprd11.prod.outlook.com (2603:10b6:805:dc::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Mon, 7 Mar
 2022 17:13:53 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 17:13:53 +0000
Message-ID: <fd560bc9-cb0b-0f7d-9a60-76735bc55c5e@intel.com>
Date:   Mon, 7 Mar 2022 09:13:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH] x86/sgx: Enable PROT_EXEC for EAUG'd pages
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <20220307153504.198112-1-jarkko@kernel.org>
 <YiYseF3aKI70x3d8@iki.fi> <YiYuH95wps+yHDk1@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YiYuH95wps+yHDk1@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0072.namprd22.prod.outlook.com
 (2603:10b6:300:12a::34) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d98aa188-70b9-4cb7-db9d-08da005ddab0
X-MS-TrafficTypeDiagnostic: SN6PR11MB3118:EE_
X-Microsoft-Antispam-PRVS: <SN6PR11MB31184F21DC8DAB58152613F3F8089@SN6PR11MB3118.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T650Ami0LmfzUqNS22k0U3zy1wijcNZ+vfIXl5Bcb7CfR6owCRYYdqU1F4dthEIVN8IV+/vkywu8OaO0A0E2C1dGhjltjDhJmLMBt4VIcy3dSRofMhTmVKuUreALTX0yuLQZKnBNQQk36xt5ZWtsUhoGLvgC4CsBn8HJD7BY3obccEEg5xv+BuRy8Z8MvPzVwJMvuzAQCPoJWIxkyJhg/2gURZZ6pT6kMOpvuiphZJ0BKP2TpF+GvIbdiNErq8wvngIqlAcQICaujdLU9r2X8KVpA6abL/Vi9bXxAqhp98d6f1Y6h/gw+ojePtaOkWZBinzyAJLtu5AaV1rjJ4nkTHiiEdmnTOSwxlExT1/vI5fiCiCWO55UjbbQBNaQkv45yAmY9WgqoyrqYcGngLhOvZZIaqqauUrGzmuABuJw+Dphbj5NvTl2ELHLRGAm0MJvsGILfnRP3+QCM8cvUhnVP6KPG6n1cgtMvKvwl0Wf+fOX/zEWcjHpM1f86sO8I1gDi4w+pQ21v5kP5xQEYPQqPkwRktfZkgRAiiXzvbIAjLw15uDJumOIZLjmInpaXCkZwNjjCp4w+hUC4LGP+pNU/1tgZ0ao6/1Au5uzo4S+J1gTh8M1BHKz6Sn+p2rP6c3ehEW5b/nb6UOljCAXDwNDp8FM7uXl05OcKHvhGILUWQ7OYvBI9761BBSke2dD/7p3dzP5RNe0E85cptDTfmiGOl911b1rYTecZgm/EnLApoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(53546011)(36756003)(38100700002)(2616005)(31686004)(83380400001)(2906002)(82960400001)(66946007)(5660300002)(316002)(26005)(54906003)(66556008)(6512007)(8936002)(44832011)(31696002)(6486002)(86362001)(186003)(6666004)(8676002)(4326008)(508600001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VklqNVM0UU9leC9KTEdyeDRJdUhxV2xlM3o4a3NnR3REdlF1b0ZrUXZZb2c2?=
 =?utf-8?B?TTNJSDR5K0NGU1Zob2JHTXBRMXhuYVg4NEdRYkl6QkNHQWR5V1I2aWlkUHY1?=
 =?utf-8?B?Qy9RRGk1amJ1VVNvYm1JMGVXWWJXeFQxT1F5ZTRPR1hkMDdnVERybEFNRXQ0?=
 =?utf-8?B?ZWQwMGZDcFN0MkRpSkd1ZHJYak4waS8zZkZ6ekRoakVncXZaMGpyZHZadHB6?=
 =?utf-8?B?dGI1ck9QTzJaZzBPNXBsUG5Gam0wKzFTN1RIQ1JIdld0VkpnSVRFNU51SWc0?=
 =?utf-8?B?TzNuc3hsd1FUeXpubGthTHhWTEJoQ3NHdWxGUkRvOG54eDVYT2NMd1VZeFg0?=
 =?utf-8?B?L3h0UnhDTTRnZUJHZXhDOE0rQmdmNUxOc0JhVFpsWUV5TGZWQmlDUGI1OVh6?=
 =?utf-8?B?azYrWjRJNTBqb2pzWXlmRDVHK3BHWHBPb2N1NjJxZnd4Q3JYeG1FdW9iNUlq?=
 =?utf-8?B?MzJ1MDdqSytEa1hrVU4vVkc3UVE4SmVyck14Y0IvSndOYmY0bldmUm11K2JN?=
 =?utf-8?B?VE1CUnlLb0h4Zk02MkVJSG10UWJsWTcwak1IbmFzTDZUOHNYR0o1NDBBTjBQ?=
 =?utf-8?B?bnFnNlh1OEpWRDVzTkZneGp4U3ExNlBDNzd4dTl5dzJsbDdJL3JRVWhua0pm?=
 =?utf-8?B?UzdBcFNPU0lSWU9HUnBPL3VTS0kxaFZxSDEzVlF6YVpuUlJRd1hrSEMyekJa?=
 =?utf-8?B?V253YmhJODh2NWFUbU03K1BtN3NicG80NUJnRHlUaEVac0NXY2ovc2ZSQm5p?=
 =?utf-8?B?VzJrcHpTM2FGSjY3VURIVVRtQmJONCsyUWVWeGxNcnZ2K09uWWh3SGNFK09U?=
 =?utf-8?B?OW5xOFliSVZ6S29zalNCczRWbkZZUUlBSFJUeVFZbUpQU1VLMVZGOEdpMWVh?=
 =?utf-8?B?MFdhRyszZjdEWVdiVXZyMFdqeVZsblMvTnlEQW1KY0c0Zlk2Yi9Zcko1aE5V?=
 =?utf-8?B?UC9HWnM5WVZLaW5IWTZDcmQ3TnN5c2lUTzhzOWc5eVE3eU9yL0ZTYU5maFBE?=
 =?utf-8?B?K1JYbWdQbnpxSjdhYVp0K3ljMFhmOXpmRkhLYW5RaUh3eWtjNEhxQ2d5UnQw?=
 =?utf-8?B?UXhLWXYyMWZWVFhlM0NMSWg1eDRCbWVYeUdqNVg5aEJXVHBDOGw2ZytYZWpH?=
 =?utf-8?B?Z3hGVnhBcmVLZitOdXdIcnhBbFF1RDRnaldkRlBRZHlkOE1zbjdVT0xUcVFL?=
 =?utf-8?B?NUlSZHBCaUFlRGpUQktYaGZ1TzdQR3Q0bUNheUpzTzRJN0RFdFg0WDBpeUxR?=
 =?utf-8?B?ZklnVTc0TEdxNyt5YjNJT1RscDBUMTA1N0JZejJOUnhCOG9ic0JzNm93dnVN?=
 =?utf-8?B?STZmQWp2OXBtZUo4T1JMVkx6elFJNjhlMWNpNFZmWGthMTNGUHMyL0t2SmJY?=
 =?utf-8?B?cnZxc0tXc0JLWWNCdTVBa1dtZWFyWXkrVDY0aTZ5S1NnMHBmd09jVE9LNzdj?=
 =?utf-8?B?S2pJbk5YZ1Y1enRUNzRhMzdyekt2Q2tYSnlnTFVKeFZtVXRpcUlYSy8yOEdn?=
 =?utf-8?B?T3o2Vk5iL2VqZW1vcStMVkwvRjgzMWExV0VKRFRNbkdIaS9DUFBPQitkQ3Zi?=
 =?utf-8?B?K2FLM2tjUXR6QmJWajFGbk5SSDh0VEhXQkpxcEhZMnQweXoyZC8xTEFIL0sz?=
 =?utf-8?B?MHB2TExqZDUxQTVqTDc2b1Y4QkdKMTFZR2tHNTk5TjNCNGpBWm9ReThRVHNG?=
 =?utf-8?B?YXR1Y2VJcmhRVXRKeUN0RkMxNEpJQWRQMERLQjRQZFpuakZ2ZGJObGdVNWlH?=
 =?utf-8?B?WVdJWDNHeVl0dkpjb0FYM1ZLUTl2WUYrY1ozUG0wUWZIdFMwOGVKL0tFdkFK?=
 =?utf-8?B?NWNHUjlnaVlMc2tQKzNJSmZQUXRGa0VUeElRd0tEeVFUMlR2aGh4WVNJZHlT?=
 =?utf-8?B?V1ZLbFdkSmZKNjg4elB5SlZKakJoWjZTMTJpa0ZXejFFSzljZkoyTi9XeGg4?=
 =?utf-8?B?UVBqME1wdnNzRldDNTdrT1MyRHpwUTBUZkFNYi9XQW5WZW1NdjhlSG9taFRB?=
 =?utf-8?B?U2hJWk9hbGdqZlZYV214SXhtRC95TTU0cEdhWnlHTy93WGVlREtPaXorWWFY?=
 =?utf-8?B?eUxEbmNKWi9OQ0hwN2FIcWV2VmxWeFl3S2xyakFkdVlQOTNiRUdTZS9VNzFy?=
 =?utf-8?B?ZlMvUmc5bVhqSnpGSWtVQ205UXBCa04xU0dDbGtSQ0tkQnVyeFVLZjZ4MzNw?=
 =?utf-8?B?bS9VNWY2MldkNlhtWUZpSlIxaEZVK3EzWUtueDBYZWxWOEpXaUNra1FISWZD?=
 =?utf-8?B?ZnkzRkJ6eEZ6ZHZZMkFoK0d5UXhnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d98aa188-70b9-4cb7-db9d-08da005ddab0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 17:13:52.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXkIjrtpGvhv09Db8qgiqx6GxyJ0JQrT+XjXtOTuICooAFGs7Eis7HNT4jn/KwIc1or8ClLWhTuyYH1kJbS7/G21/83O/Clr/AK9ZK/RTFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3118
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/7/2022 8:09 AM, Jarkko Sakkinen wrote:
> On Mon, Mar 07, 2022 at 06:02:03PM +0200, Jarkko Sakkinen wrote:
>> On Mon, Mar 07, 2022 at 05:35:04PM +0200, Jarkko Sakkinen wrote:
>>> vm_max_permissions was created to control the pre-initialization content
>>> that contributes to MRSIGNATURE. It was never meant to be as a limit to
>>> dynamically added pages.
>>>
>>> E.g. static content could be used as a hook for LSM's to decide whether
>>> certain signature is qualified for EINIT. Dynamic content has nothing to
>>> do with that. The current mechanisms only add to the complexity on how
>>> to control PTE and EPCM permissions, and do not add anything else than
>>> obfuscity to security side of things.

Linux has mechanisms to enforce what can be executed. For example, with SELinux
a process can be required to have PROCESS__EXECHEAP or PROCESS__EXECSTACK 
before it can be allowed to execute writable memory.

A few SGX runtimes enables unmodified executables to be run within SGX enclaves.

Does a change like this not enable executables prevented by existing 
security mechanisms to circumvent such restrictions by running within
a SGX enclave?

>>> Thus add PROT_EXEC to the permissions assigned by the #PF handler.
>>>
>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>> ---
>>>  arch/x86/kernel/cpu/sgx/encl.c | 9 ++++-----
>>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
>>> index 79e39bd99c09..0256918b2c2f 100644
>>> --- a/arch/x86/kernel/cpu/sgx/encl.c
>>> +++ b/arch/x86/kernel/cpu/sgx/encl.c
>>> @@ -160,12 +160,11 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
>>>  	encl_page->encl = encl;
>>>  
>>>  	/*
>>> -	 * Adding a regular page that is architecturally allowed to only
>>> -	 * be created with RW permissions.
>>> -	 * TBD: Interface with user space policy to support max permissions
>>> -	 * of RWX.
>>> +	 * Dynamic pages do not contribute to MRSIGNATURE, i.e. they are
>>> +	 * controlled only by PTE and EPCM permissions. Thus, the no limit
>>> +	 * is set here.
>>>  	 */
>>> -	prot = PROT_READ | PROT_WRITE;
>>> +	prot = PROT_READ | PROT_WRITE | PROT_EXEC;
>>>  	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
>>>  	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;
>>>  
>>> -- 
>>> 2.35.1
>>>
>>
>> This is really a show stopper. I think here's a logical mistake on for what
>> purpose vm_max_prot_bits are used for. They are meant for the static and
>> also signed content of the enclave.
>>
>> These changes in the patch set that are related to vm_max_prot_bits only
>> messes up what already exists, and make incredibly hard to implement
>> anything decent on top of SGX2 features.
> 
> I.e. once signed content has passed EINIT ioctl, and whatever checks
> there are now or in future (e.g. LSM hooks), the system has accepted
> the enclave behaviour, and it includes also the use of EACCEPT opcode.
> 
> It's the exec or no-exec decision point. The thing that these patches
> do is making an obfuscated mess of all this. When EINIT has passed,
> it has been decided that the enclave can do its workload. Let's not
> throw stick in front of it, and make everyones life misserable.

A common use for these dynamically added pages is to increase the heap
and stack. Always allowing PTEs of RWX on these pages irrespective
whether it will be used for heap, stack, or relocatable code does
not match with how the kernel manages protections.

As I said before I am not comfortable with such a change and cannot
sign off on this. I would defer to the maintainers to choose the
direction.

Reinette

