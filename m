Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5392148F2CD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiANXFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:05:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:36977 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbiANXFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642201533; x=1673737533;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1yQ7K8L1xccVdRVed13L8H3PsGwfs0UWuB/85BXc2iA=;
  b=ORytkO6xC4kIx7dDqT7PmmMkM2BR8I6iPRjvk3vM30jlJZnkVihUZzq1
   nS63VNLcrxmnjW0M5klLEpiDBQh7eL8Cnwvzi0vPC3owB92GjMqPUAmLQ
   V1Ff3w0kimB71bpoAmD9ALjDIcdEGCCYt7HYS6k8slehJv3C8DvPyHh1F
   cnjGBmCJRAsthzes+7yHt2V/tDcLzp8O2iUxpen8EesPLsphQtZZ9Lu/8
   6mbubHvXtuRleC6X/5JfdBqb4JY0ElzcNA9WYD6fkcQyMFBEK+ws3YED+
   Fr9dkzaL3FbUrcOnPYDBH5jHNXwxf8uxSSsPu+qLkllr9tfIrxz8su9BA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="224328779"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="224328779"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 15:05:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="692396663"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2022 15:05:30 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 15:05:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 14 Jan 2022 15:05:29 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 14 Jan 2022 15:05:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTQZL0CxdSLtoPljCHszu3Tkn55aeWaa08Yx0ESs41lOohwRyl68MXlCoJuSSl/gfce8daDTzD4koffE0ZM41rRnNg0VhzVPrDDngedEMTNAlcmNPFiWQE9xvLQMjAVQ79ixNBAc6TwASUhAiEvbXTKNqBl8j3zDXUcOzbHbtbg/whiB6YVRA1k5LsT6Ak9TVozqd+5UVuwC0R8FjpWW0x98ROCl4B/9mAZZTEvUYWhQsNswBcfOH8utN9oDtcjXL4aRQ4l7k4ifFbrpay79AvlDQ1uv6iCVCvWDZijqEO7IcvsojzK6ErNBXJnrs3loSf4Rd2H0BknviJ4xC0iXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7y61WyfTnYmQ5vJGWyZTzKqRKIWxPjSQvS7JjQM8Wg=;
 b=jg5e9u2fZ0j9LF3k+P93PFYJudx29+cwKFNnyvj7GurC5DZQKHlJBu2YnioUBbtcmHzn382/VebFgR2FoWq+XkTdxQU9/HdqZCwAmToFTbGfvu5voCNcRR0jPeNaVF9ivCyPgr/mz2tPXH5Z3sa//JvFREHJeKmTs6PJD5KHbf5SUkz6hRH5J2KvYD0GoMADqqIanqMBhdaGbBQBArSEl0VoysAO5XJttZ0tvf1fykXl34y+JpBXwjG2CeoPTm8mbUd3eX5WZFXHDB/STLKmzr4BfUYbRkmhoLRfhXDlj9b5IOOi0/957nrLloc968J7fuG40GpjqA7OuEQx/+c1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB3002.namprd11.prod.outlook.com (2603:10b6:5:6d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 23:05:27 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 23:05:27 +0000
Message-ID: <b0e5c1fc-aa6d-4e26-c18b-d93d93c2131a@intel.com>
Date:   Fri, 14 Jan 2022 15:05:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Nathaniel McCallum <nathaniel@profian.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <mingo@redhat.com>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <YdmxpTVM1JG8nxQ3@iki.fi> <YdmzDy1BOHgh8CII@iki.fi>
 <Ydm6RiIwuh3IspRI@iki.fi> <op.1fsvkfiwwjvjmi@hhuan26-mobl1.mshome.net>
 <YdzjEzjF0YKn+pZ6@iki.fi> <4195402f-cbf9-bc75-719d-22cea8e36e60@intel.com>
 <Yd9pMq4lUy56B+50@iki.fi> <Yd9qmMx7NO450mzZ@iki.fi>
 <CAHAy0tRi2q+wG+yBttq0FYeK-5wUAoK_=ZCtWsfQf0m8oPc1-w@mail.gmail.com>
 <168fb2c9-de3f-384a-bb17-ab84db2cf533@intel.com> <YeHwzwnfsUcxiNbw@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YeHwzwnfsUcxiNbw@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:303:6b::18) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38ceb691-df46-409b-b678-08d9d7b259f1
X-MS-TrafficTypeDiagnostic: DM6PR11MB3002:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB3002443A757F1FEF90420C11F8549@DM6PR11MB3002.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyuoxJtDs1VcAGF8XBVMf4t9KoJHAItJQ0EesHFxKb0wPBWV/KRffs19kvuhI8KCUDUMra24o0CkZe3N/h+Pbi/WRLVdLfMD0slQhDBEAw/t5vxp09+zgqwxvKjzIHwR5xVQsqE04ygMrZ0p3SbQIHAkG1o6Lq6W41Oe4ULa/K8ZdrzMmOAxizCe7D+LaMqvSl+2PVPEI2XGcpnWknMFMxITHebrRQoRpHJBuKD6CL+vDbDWdiAOA9tukRuLP0p8k32WyyISTgvYiy1mKNkmlAQuQIQEMOpQbY6GrKPAP+/Yuvt/PtUiXDcY94GvkKrG+a3wvmwp3SbXMd7k36xSpHKXzOyiyV4mTRBPM6n+MERb/uaX7hnv8X7vJpU/Stq+kxVHfaMESNNlPWvnBt00N0QxPUsGpnN7pVonjHn3VnlIthP5YqtqzlDz6z/kneTN/VZ7WSVZkfbokXZgSgUGaSjJptUQRshZ8/u8OB3wWmPeG5PJ+46oco7xPwAYx0drhL9sVSCpOao14zLALMLPC5LLn0TCcTFewSBQuHE6QeCulxSatA3V7ja7cJf9b7UJe1PNCUP0/utDTOyifSoPB9OS6nD1rm434wCMyNtlemLCdxS7+5SmT6vbETCIlowyBQl9MTcdcSPIBh9rS0c4wTw1X1W2Al9ReW4sykWL/55bhahBbvgSsZx9aSurchJds0YFWTcLCOIowBY/rVNahUnm6U73yiiDKeN6dOxTR9ZUYLoE03/SKYSergJaiF0V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(6512007)(186003)(508600001)(7416002)(6486002)(38100700002)(66476007)(4326008)(2906002)(54906003)(8936002)(66556008)(2616005)(44832011)(5660300002)(26005)(31696002)(82960400001)(36756003)(83380400001)(6916009)(53546011)(6506007)(86362001)(31686004)(316002)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzNFQm9hamZ6RjUvUDZZaDNNWTh1K0tIU3F5bVVHbk1nZ2xGV2R4am50Y2hj?=
 =?utf-8?B?M0FkYmZvOXA2OUx2M25HUVJNTTRqek1sL256OUZTNnYyc1VwSDZYWktoOVZG?=
 =?utf-8?B?Ymp5NmtVR2k3Vk1FRTAzeUpSU0I0dVpta1ZSQzRvaHluOFVUeHUrbDd6VEU4?=
 =?utf-8?B?amdVL0xZOWZKL0lOaSs5VkFibi9pSUYyKzZQZWpSbUFOK25SMWdraVhaSGxB?=
 =?utf-8?B?a01haHVWU3pKYm1XZWc2QTJGTUFZaERNUmR4a1VHMFdGTmRJaUpjWno5emNE?=
 =?utf-8?B?c1V6azlzdm02UmhIUVJaTUVrbmM0cGdHdTdBV2w3cU93YVR4TC8zS0RQZCsy?=
 =?utf-8?B?SGhoekt6VnJPYmpON1hJc2QzZTVMd3kxQ3pzS1JibFNrZWFzS3F4QkRCNy9S?=
 =?utf-8?B?TFNWcTJqR3dUNGNYeWQyanBBUWJGZWlPdzB5ZkNENkI4ZWlMR3RUTVZIUjFX?=
 =?utf-8?B?dFRnKzFLUnpGQ0RyTHJIWjNyR3dOMDh2ZnhuejBRZGpDUWtmbnZXcVNZbklP?=
 =?utf-8?B?TjlZQzNZbDl5Q1BHS2FuSGROZ0hQSmZtaEI4bW5pbmU2SHBRRXBoZVMwVEFi?=
 =?utf-8?B?bDVIT3MxOXh6UW1KZ0dVL3hIakEydU50SllEbmlSdHhEeDcydW9XK0Yzd21r?=
 =?utf-8?B?UjUrNlJSQ0s2SnMvMWtKMmVBRjVvUjZJRm4yS3BvZ2xjbVJxb2VSNWlaLzUw?=
 =?utf-8?B?SElCVHQwUGFoMTd6RC85bVVFZ3pqOFZydGltQXZWQzBVcEVCclZtOUZpODZZ?=
 =?utf-8?B?SlM1bW9VWnZxV1RlZjFlelBJMlhSZG0wMGsvdzFDaWp1UzNNUHBwY2ZsYUFI?=
 =?utf-8?B?bFdLSGZZcElwWllGeVdPZ1hoNTgyejJGYUo1bGdqNVNHNFlJVFM5QllNMDBJ?=
 =?utf-8?B?aGZzVE5ZdE1nMnB3SG4rM0ZYZkdKVmdOcjlubVV6bGlhNTZ3RENKSFFjNzFF?=
 =?utf-8?B?NFJOTnA4cUFkN2l5TXQ1dDNSTnpVL2tIMjk4eWRZNDNTYlFRa253WlVLZVdu?=
 =?utf-8?B?cThpWDV2djNrazJrRW1xVmhHMUNQL21zVjh5d1hXUjBZOWlXNlQ4dnJXR0l3?=
 =?utf-8?B?alhhR2RUL1FWMkUrQUt2WUdRVVArV3lEb01IRXV4bnNFYUNwdVA3YkRvL0dt?=
 =?utf-8?B?ck9wLzdXUDBaRWI5Tzc4R29leUFtS0NEeVlTSWRJaWhScTdPUHlTamRqTm1K?=
 =?utf-8?B?VWhSMGt0Q1FpZkRXeFNhb2VRYll4REpTcDlGWTh3aEdMYXd2TER6V1ovZ1pi?=
 =?utf-8?B?QTZPY013eVpPMDJ0S1Fmb3RLRTRaMXIrcjR2RmRBN3ZGanBGTkJFeXg4eno4?=
 =?utf-8?B?eWJ0bSt6MGxGMGxBSDdrOXFybDNhc1RiWnRQY3p2R2YyRVFPV2tteE00aU9r?=
 =?utf-8?B?ak0yS0VuaUFtbGdIY1hpRnpxMXFFVEJVSUJIK2E0S1lQYWxvN2FTZ3FlMVk4?=
 =?utf-8?B?WCt3OTlvaUpUY01HSzVUMThpYTZxTzVzR0hLQ0ZCbHoza2RzcXlGaUtkL3hR?=
 =?utf-8?B?RTlDVWFzS1hVMVBSK1NXSXJrQmRkb3d3L2x4aVdScVNsTEl5QThpcHZFY3dx?=
 =?utf-8?B?aVY3dEhycysxYXY5L2c3bitkcThoSGs3T1g5S1lPMi83UFNpd1FTTkViOEtr?=
 =?utf-8?B?ak5qQzROVHZDYkZYZFdHV0owclNDU2oraWM2cGZjcjFyQXN5YWZDTldoSjRY?=
 =?utf-8?B?NWVDaDBHeGd4cmltRGJ1aW4vOGl1Y3NNQUdDVFVsWUVuYTFtanEvdDFOVVFO?=
 =?utf-8?B?NnBKbXk4T3NFU2pYcExsamdKRzJ0Q2M0WVhlOVgzMkd0OXE1aEg5Q2k1TEVt?=
 =?utf-8?B?Ky9ab0l4Rk5HVmRLY25TUnl0dHpEeDlMMWRranhnMmt0N1VVNXVqallnOVJl?=
 =?utf-8?B?RWZwRjdjMFZhQTRma2pOaWwvbUU5eFZ3L2F3K2NiU2NTbHU5VGVId24zbHUy?=
 =?utf-8?B?L0U5R0dQRGs2YlBVQmdDdXVaMzlnV1dBaER1QnF0ck9Cc0RhemxjaDA3M05E?=
 =?utf-8?B?M3JhSGR0TFBRSlJtejlCYlFCOU9EaUFTOThPb2lxNVdVVGZjc3pDN3pPakI1?=
 =?utf-8?B?VGR3akpzaVI0SEFyc20xQ0JoZzVjZUNVUzNEQ3BoelVMQi8yblFHWXc3Q2Nr?=
 =?utf-8?B?OWRNMGRuZXNQaVZKRjJZOXZMRU5jWGpRVHFWMmRBTEtEL3hrSHJBK2FwUkcr?=
 =?utf-8?B?MUo0clBUdEdFQ1BlMHVCY0g1ZkFaL2NkQnJTWDh6amErK0liazZObElCakNC?=
 =?utf-8?Q?5BAe8zO5OKGu2jItU+YCxCKQGS2YRlJA9qjE7Ml5SU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ceb691-df46-409b-b678-08d9d7b259f1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 23:05:26.9317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aLlKuVDkNekqwFXhnhuDWT7p5U9QDzHRzg/9se3L+zRCUCgJs2uFwF5q91q2/oSpL26s2cylAWz7AxW/tfHLF8wq0HST65jK35CxlFZhHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3002
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 1/14/2022 1:53 PM, Jarkko Sakkinen wrote:
> On Thu, Jan 13, 2022 at 01:42:50PM -0800, Reinette Chatre wrote:
>> Hi Jarkko and Nathaniel,
>>
>> On 1/13/2022 12:09 PM, Nathaniel McCallum wrote:
>>> On Wed, Jan 12, 2022 at 6:56 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>>>
>>>> On Thu, Jan 13, 2022 at 01:50:13AM +0200, Jarkko Sakkinen wrote:
>>>>> On Tue, Jan 11, 2022 at 09:13:27AM -0800, Reinette Chatre wrote:
>>>>>> Hi Jarkko,
>>>>>>
>>>>>> On 1/10/2022 5:53 PM, Jarkko Sakkinen wrote:
>>>>>>> On Mon, Jan 10, 2022 at 04:05:21PM -0600, Haitao Huang wrote:
>>>>>>>> On Sat, 08 Jan 2022 10:22:30 -0600, Jarkko Sakkinen <jarkko@kernel.org>
>>>>>>>> wrote:
>>>>>>>>
>>>>>>>>> On Sat, Jan 08, 2022 at 05:51:46PM +0200, Jarkko Sakkinen wrote:
>>>>>>>>>> On Sat, Jan 08, 2022 at 05:45:44PM +0200, Jarkko Sakkinen wrote:
>>>>>>>>>>> On Fri, Jan 07, 2022 at 10:14:29AM -0600, Haitao Huang wrote:
>>>>>>>>>>>>>>> OK, so the question is: do we need both or would a
>>>>>>>>>> mechanism just
>>>>>>>>>>>>>> to extend
>>>>>>>>>>>>>>> permissions be sufficient?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I do believe that we need both in order to support pages
>>>>>>>>>> having only
>>>>>>>>>>>>>> the permissions required to support their intended use
>>>>>>>>>> during the
>>>>>>>>>>>>>> time the
>>>>>>>>>>>>>> particular access is required. While technically it is
>>>>>>>>>> possible to grant
>>>>>>>>>>>>>> pages all permissions they may need during their lifetime it
>>>>>>>>>> is safer to
>>>>>>>>>>>>>> remove permissions when no longer required.
>>>>>>>>>>>>>
>>>>>>>>>>>>> So if we imagine a run-time: how EMODPR would be useful, and
>>>>>>>>>> how using it
>>>>>>>>>>>>> would make things safer?
>>>>>>>>>>>>>
>>>>>>>>>>>> In scenarios of JIT compilers, once code is generated into RW pages,
>>>>>>>>>>>> modifying both PTE and EPCM permissions to RX would be a good
>>>>>>>>>> defensive
>>>>>>>>>>>> measure. In that case, EMODPR is useful.
>>>>>>>>>>>
>>>>>>>>>>> What is the exact threat we are talking about?
>>>>>>>>>>
>>>>>>>>>> To add: it should be *significantly* critical thread, given that not
>>>>>>>>>> supporting only EAUG would leave us only one complex call pattern with
>>>>>>>>>> EACCEPT involvement.
>>>>>>>>>>
>>>>>>>>>> I'd even go to suggest to leave EMODPR out of the patch set, and
>>>>>>>>>> introduce
>>>>>>>>>> it when there is PoC code for any of the existing run-time that
>>>>>>>>>> demonstrates the demand for it. Right now this way too speculative.
>>>>>>>>>>
>>>>>>>>>> Supporting EMODPE is IMHO by factors more critical.
>>>>>>>>>
>>>>>>>>> At least it does not protected against enclave code because an enclave
>>>>>>>>> can
>>>>>>>>> always choose not to EACCEPT any of the EMODPR requests. I'm not only
>>>>>>>>> confused here about the actual threat but also the potential adversary
>>>>>>>>> and
>>>>>>>>> target.
>>>>>>>>>
>>>>>>>> I'm not sure I follow your thoughts here. The sequence should be for enclave
>>>>>>>> to request  EMODPR in the first place through runtime to kernel, then to
>>>>>>>> verify with EACCEPT that the OS indeed has done EMODPR.
>>>>>>>> If enclave does not verify with EACCEPT, then its own code has
>>>>>>>> vulnerability. But this does not justify OS not providing the mechanism to
>>>>>>>> request EMODPR.
>>>>>>>
>>>>>>> The question is really simple: what is the threat scenario? In order to use
>>>>>>> the word "vulnerability", you would need one.
>>>>>>>
>>>>>>> Given the complexity of the whole dance with EMODPR it is mandatory to have
>>>>>>> one, in order to ack it to the mainline.
>>>>>>>
>>>>>>
>>>>>> Which complexity related to EMODPR are you concerned about? In a later message
>>>>>> you mention "This leaves only EAUG and EMODT requiring the EACCEPT handshake"
>>>>>> so it seems that you are perhaps concerned about the flow involving EACCEPT?
>>>>>> The OS does not require nor depend on EACCEPT being called as part of these flows
>>>>>> so a faulty or misbehaving user space omitting an EACCEPT call would not impact
>>>>>> these flows in the OS, but would of course impact the enclave.
>>>>>
>>>>> I'd say *any* complexity because I see no benefit of supporting it. E.g.
>>>>> EMODPR/EACCEPT/EMODPE sequence I mentioned to Haitao concerns me. How is
>>>>> EMODPR going to help with any sort of workload?
>>>>
>>>> I've even started think should we just always allow mmap()?
>>>
>>> I suspect this may be the most ergonomic way forward. Instructions
>>> like EAUG/EMODPR/etc are really irrelevant implementation details to
>>> what the enclave wants, which is a memory mapping in the enclave. Why
>>> make the enclave runner do multiple context switches just to change
>>> the memory map of an enclave?
>>
>> The enclave runner is not forced to make any changes to a memory mapping. To start,
>> this implementation supports and does not change the existing ABI where a new
>> memory mapping can only be created if its permissions are the same or weaker
>> than the EPCM permissions. After the memory mapping is created the EPCM permissions
>> can change (thanks to SGX2) and when they do there are no forced nor required
>> changes to the memory mapping - pages remain accessible where the memory mapping
>> and EPCM permissions agree. It is true that if an enclave chooses to relax permissions
>> to an enclave page (EMODPE) then the memory mapping may need to be changed as
>> should be expected to access a page with permissions that the memory mapping
>> did not previously allow.
>>
>> Are you saying that the permissions of a new memory mapping should now be allowed
>> to exceed EPCM permissions and thus the enclave runner would not need to modify a
>> memory mapping when EPCM permissions are relaxed? As mentioned above this may be
>> considered a change in ABI but something we could support on SGX2 systems.
>>
>> I would also like to highlight Haitao's earlier comment that a foundation of SGX is
>> that the OS is untrusted. The enclave owner does not trust the OS and needs EMODPR
>> and EMODPE to manage enclave page permissions.
> 
> Thanks, this was very informative response. I'll try to elaborate why
> EMODPR gives me headaches.
> 
> I'm having hard time to connect the dots between OS mistrust and
> restricting enclave by changing EPCM permissions. To make EMODPR actually
> legit, it needs really at least some sort of example of a scenario where
> mistrusted OS is the adversary and enclave is the attack target. Otherwise,
> we are just waving our hands.

The enclave itself should run in an environment that respects the foundational
security principle of least privilege. There are valid scenarios where an enclave
may need to write to a page and then later execute from it, but it should
ideally not have those permissions for its entire lifetime. As Haitao mentioned
this is to protect it from itself, which can be bugs in the code or maybe even
malicious code and is similar to how non enclave code is treated today. So in your
request I interpret this to mean that it is the enclave that is both the
adversary and the target.

At the same time the ones running the enclaves do not trust the OS to manage
access to enclave pages and that is how we ended up with the need for these SGX2
permission functions needed to change the EPCM permissions.

> 
> Generally speaking a restriction is not a restriction if cannot be enforced. 

The EPCM permissions are enforced by the hardware and in addition
in this implementation the OS will not add PTEs that exceed the EPCM permissions.

> 
> I see two non-EMODPR options: you could relax this,  *or* you could make it
> soft restriction by not doing EMODPR but instead just updating the internal
> xarray. The 2nd option would be fully backwards compatible with the
> existing invariant.

Just updating OS structures would not be sufficient. In addition to needing to
update its EPCM permissions for its security the enclave needs to ensure that
there are no cached addresses in the TLB that may still allow access to pages
with permissions that were removed.

> 
> It's really hard to ACK or NAK EMODPR patch without knowing how EMODPE is
> or will be supported.

EMODPE is currently supported and you can see an example of its use
in the testing code that forms part of this series. Please see
"[PATCH 11/25] selftests/sgx: Add test for EPCM permission changes" where you
will find support for calling ENCLU[EMODPE] added to the test enclave and the 
"epcm_permissions" test making use of it.

After running ENCLU[EMODPE] user space uses SGX_IOC_ENCLAVE_MOD_PROTECTIONS
to communicate the new permissions to the OS. Since the OS does not know when/if 
ENCLU[EMODPE] has indeed been called all permission changes are treated as
permission restriction and will thus, in addition to removing the page table
entries, call ENCLS[EMODPR], which will be a no-op (apart from EPCM.PR being set)
if user space only did call ENCLU[EMODPE]. The page remains accessible even though
EPCM.PR is set but the current implementations follows a
SGX_IOC_ENCLAVE_MOD_PROTECTIONS call with an ENCLU[EACCEPT] with the PR bit set
to ensure there are no dangling PR bit set in EPCM.

Reinette
