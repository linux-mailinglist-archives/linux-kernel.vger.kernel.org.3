Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF8648B2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244447AbiAKRNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:13:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:6109 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240930AbiAKRNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641921220; x=1673457220;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q5FIfAPdVORpazOSRLVUDa5SEL+9TGGLkrSv0UkLQoc=;
  b=Itcx7P3i72yP5O0j69qTqJgMbw/c3yuup6Mv05XBD9QT6/QB8bTIrynF
   brp76jJBOzW/tQ3E8+7mP8B4Vj8qng2Gd2pIytuxxLT8kPq0ciK5irWXR
   rePY3mdZJJq/feFxAXxu+wVbKqL7JXTaVH45KPYE/oWeKgwgrHlamFu7K
   PrxidqwmZb7PYzXRusrLXS1PZGDbxc98kaZNn/PfAH/mmVj6BVZUGKTrm
   nc9GyhOxab6kQzDFDHjC1jL6CD3oxVXOyd/UJa1ToeGPX0gJIZ86JwBcV
   wIj/fmjnhlnxKUfAQcBEbaR2NuuXcQ/xwbcYquANPoD2CrL7i0okbMvYh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="267878179"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="267878179"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 09:13:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="619894578"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jan 2022 09:13:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 09:13:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 11 Jan 2022 09:13:38 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 11 Jan 2022 09:13:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODcFnx2CuoDTz0QQt0U1HcKfrzNI5cBpSkogY4r3gQ6K0Js0rKBJdgNlT4Tqucdq3OLfKg0CnxiuBX3FdwILIin/z6GnX7xX+yx6fV4wpHAwTVBecSxs/YgMGjBiilWbWJN1gXusCV90S8y52BBYmPsMCKc1u0PrY93aGe636XhosBc5KXGAG1C3L4oPeIBerfvAuZyD5a00lJKRSzfXmyKE6nnNwDD2M8Kssd8XtvXF0ctjQna930uQt3hDHbXYisGzo+O7iAXJ2ZvI5pDEPt51GOldZ0f8Ucb/WUat6msiK9EEakqoFdTFOFSZ94f2nKJs0ILdKGu1r0IEIDAPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBc9T9EhbPVgaUR8DucJSwyx9kOn3DxpNI2/NZTSZgU=;
 b=ctEa4IisLGhAJJ54TkdmNda/G3kdDOMeDauhpIb0FKeIMn3Vcwg2UL3ld2pldXmjtLHjZdeLB/bwsTK15dsp3KgGYnyz20IOa/iJn09kUySu1vEkaJM3NkP3YWY1PPObA3oaEl4HMb9kwz0teSEzt9ETBdFQuBZRFuI50SwSNh+VtAJUMAI6D/95SayCzKG9i9nsAtp/MA8RPIWnp4ax1V5hqTpYJxMlfF5IQjfPYkbL3IrRX+GevWycAzrXfBOBWXMI5mGyPNBmJVRkaatcFjNWT8z7bvZugw3BntX/90zwf4vYqFZY3izEPVRifl5RhTPXg/0tTlEhAY/MP2XrWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB3241.namprd11.prod.outlook.com (2603:10b6:5:58::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 17:13:33 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4888.009; Tue, 11 Jan 2022
 17:13:33 +0000
Message-ID: <4195402f-cbf9-bc75-719d-22cea8e36e60@intel.com>
Date:   Tue, 11 Jan 2022 09:13:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>
CC:     Andy Lutomirski <luto@kernel.org>, <dave.hansen@linux.intel.com>,
        <tglx@linutronix.de>, <bp@alien8.de>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <a24bc46e4ba8a69938a7f73012019ce0f61005c2.camel@kernel.org>
 <f6a55943-13ef-41ef-609a-6406cffef513@intel.com> <YcsklLw1uFyppSji@iki.fi>
 <573e0836-6ac2-30a4-0c21-d4763707ac96@intel.com> <YdgvFTIRboHwTgRT@iki.fi>
 <op.1fmvdehpwjvjmi@hhuan26-mobl1.mshome.net> <YdmxpTVM1JG8nxQ3@iki.fi>
 <YdmzDy1BOHgh8CII@iki.fi> <Ydm6RiIwuh3IspRI@iki.fi>
 <op.1fsvkfiwwjvjmi@hhuan26-mobl1.mshome.net> <YdzjEzjF0YKn+pZ6@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YdzjEzjF0YKn+pZ6@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:300:ae::14) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d74c3a9f-3b4b-47cf-0c82-08d9d525b235
X-MS-TrafficTypeDiagnostic: DM6PR11MB3241:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB32415056F3B50E52C80AA1E9F8519@DM6PR11MB3241.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcSvUngjaFQQU4OxCRHVAe9I40dXi4ZnEcLpT3pGRJM4et0KLHd3ZmDu0EyBWvetKNxf3Y2ktsqKP5WpxTaXMDsDUyJYmT2fKTUsYXGxeWgpYWrNJFSp0xZa4VEspWOlbPLzkDqtSHyG0vXM+kDJAFxb4v55/s/6lP9V0rW12LfOsxZ9JZoevjh6GsHfEIWRJD9LfLQNMpsGlRJx8WGzyuLK96kmcu9gqXAyO015ZfyhsBAwJr985oS5u6ngFLEWN9kvHdyl8hx2Uwb1//TrPQ1lIb08ql+ee7K7kEIiKhk5i0OuqnkG8Iti/Q3P2hm0l4txu3wUiS+zphZ+wOP/GgCkgmMob6ABMamfBMncFTn6XZRWHqZKKyqnE0D3SXAhdARr88qUJDCYi5WBY1f24ZFwpDNwcnASEhlEkuo379wbWxCusZtABNSQ5tSs2V9WxHWjntQi8R8hW3AJxGNogZYTIBNQQlyLpSFqRNHJt2/vWDsOJcyBgCU9nUQaH8VQfzVQd/RwDONRajPu6BFBNq4qU9PrJP5McZl0GSadT8orGW6dVsoZNZOjRDYQ0DIzOuzov3nh9ainty+HAQV8ngXOnIW/BdscbduUpb5KxD2GF9VYNB+MY0Duu0Qz+sJ5Wit7zdoEx6TCXjDYsCnSWhZ/vkjKZDQ2gQpisulRDwoQ+6PNVulkAUU5qpGQx45jn9kmJNZoIrxVqWPeFw/e/Iz0sNZYBMFgyeTLQRdSh9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(2906002)(110136005)(6486002)(508600001)(5660300002)(2616005)(66556008)(316002)(36756003)(86362001)(4326008)(8676002)(38100700002)(6666004)(53546011)(31696002)(26005)(7416002)(8936002)(83380400001)(44832011)(6512007)(82960400001)(31686004)(66946007)(186003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3kzOUU1dFdySmtkNk8xdHRwK1NPTkFyVnJMM0s0TUprZDd4RjRpRWJsZXlG?=
 =?utf-8?B?WGhpNlI2dmg2OWNJZlJkVkxxbWdRVjlCVmlqNWU1WWdabVRhblZEcUdXeGVL?=
 =?utf-8?B?ci9TU3JhSVJIRzZHVHJ2cnRwYkRERjU1aFdVd0duSGNSclJGWnZlQzc0MFM1?=
 =?utf-8?B?cXhqRXNyZHBmRTk3WlFGdlpPMmdOMm44R1UwMDZ4dldBNThlMUZVMEQyMnpC?=
 =?utf-8?B?TVhtd2FxelE0MHdwRnJ1R2JsYWorMk1mNGlsanc3WUdCWlJxcFBlRVdtalV2?=
 =?utf-8?B?ei9KV0IrUkFNSmNaV2VPZTY2SVRoR1lic2tGMVFUS1BNUnFUeFBpZEZjWlUw?=
 =?utf-8?B?U2l4WWwvSjd1Rm8xTi9VdVQ0VGltbE44eDVDc1FIVmI2ZjIxVGZuT25nbUtM?=
 =?utf-8?B?Rm9EZXFpWU1rZjR6Q0tFMit1M2VWMkdOMkRPM1l5WExSWGpnbHNndUVHOEM4?=
 =?utf-8?B?cnJ0aE9sNWRoMEpWYmJuVHo4c1JzRElHSjBuemZUSzNaYmwrNUtlWUZkNXEr?=
 =?utf-8?B?R1ROZEkxUk85dmRHSGR6bVpNYTBZOGZzSjdsK3U0ZVY4NnBHT3krSm9VTThB?=
 =?utf-8?B?UWdvMVhoZExNdkV6TFUyNkpwbzhqQVBlL3gxblI3Q2kvWHNKMURFZ2Nyb2JQ?=
 =?utf-8?B?R0g4Q3B5UUJ3Sm9VL0I2WlJGa0RxajhmelRFMjUreHJQWllGbmgvZS9nMWcx?=
 =?utf-8?B?SEpsOFJnMUIwZVVqWUZwd1duRExuRmhqMk9vRXVGSXphcnJCZmdLeERvZEdj?=
 =?utf-8?B?cTdVLzJqYXhRb09vZy9XSVZDRnlyU1pvNU5pTGlXSnUzSW04aHBNR0JrbGth?=
 =?utf-8?B?NWoxbTZkRUZMcU1kNmhuZk1jR09kb2hIUGZiRGQxeEdiejBldzFsdVcvV0hv?=
 =?utf-8?B?bTRrazIvS1hpRHJhclNpWjg3dU5Pb2xvV3JiRGZlbXBhK0NBOUszcXJMUXQw?=
 =?utf-8?B?NjhDd3JyTFlBMVF3L0pJMzhBZUQ0YjZCYVp6ZDRrZVVKTVQzN0dqQVorMmNL?=
 =?utf-8?B?aFRlSldVbk9kdTFManA3Z2F2WnlpZS9pUXVyZWtGeldaWjhaWXIwZ1F6eENs?=
 =?utf-8?B?bXNRNWNDdDE2a0RZSU9DU0dudjdQMUJGNVVMSm9uL0VTUERDVDhzTWxBTFlB?=
 =?utf-8?B?MEV3TTh5UDMzU29TdGk2ZWVmSU1OcS9ITld1U2VHNEdsOWZpRVRXbFNCdkdU?=
 =?utf-8?B?Q0VzUXdMYTVldHdueGNpd2VENGcwN0ovTlUzcWtIVlVReHo0c1JIVVl0bTI1?=
 =?utf-8?B?Y1RuVWpvczZKSWg1cmZUQXo0dkZDTGdGcllmR3liQUtFTXFxZi93QlNpbVhy?=
 =?utf-8?B?eUc3WTVhMzRteERBUG5DTS90aGFTZGQvR1hoRUNNTlJuSGs4MUlibHoydXZC?=
 =?utf-8?B?MENjTUVwdEdtQitvRUthdGRVVW5ZNVBKMnpybFAyWjdDYnZQZEd6N05JSVhM?=
 =?utf-8?B?UW03Yy83QWRxeStzR0ZSQWJpdTM1WWNMTEtHVXV0TSs0K213aDhZNGZjWitV?=
 =?utf-8?B?UGlCT0lNNjZHU2FZRnorWExNdkpVRElEUUtwRm9GT3kzMDVmSUNmNHQrZ1NE?=
 =?utf-8?B?TmlBeDFiMlBjOGZrc1FlQXJ5K3FUZEJKMlN3QmhtaUtFbE1Ta0tpVDZGVldM?=
 =?utf-8?B?alRqVDIzUDJDTmd5ZjhLNG5GcnAzYXF4MzJ3OGdldVhRS0hORURRL28yb2tp?=
 =?utf-8?B?SUJJZDVpUzVUeGZ4M0JaQ1VObzRKZlo5Q0hrSEtxSk9NeHN3WGJLLzZIaEg2?=
 =?utf-8?B?aW1pcmVLYVdBWTlXUktnMXZzUkVKekY1M0o0Mm1jOVlpR0VnaXI1c1ZkMXlx?=
 =?utf-8?B?STJ2RGtGRWpkOTlHd2ZCdEZhdmZueVRqRklYZDAvdWgvTFVENjB1a3h4UHJw?=
 =?utf-8?B?SGRJK1VDWm1KakNtZkZUR2o3QW83eXl0U2FaS3hMbVBadzd6UUdNL3VPQnNC?=
 =?utf-8?B?Wmwvc0JWZ1ZrMUVnU05NMkhJNnZNQkRWZUlzQW5HMms2a3hodWhraEc5SklE?=
 =?utf-8?B?dGFyck8yalBQd1Znbm9oWjMrWjR3cU1TR3NSMjZTNmNrSzJsZzVZVmgvZlha?=
 =?utf-8?B?Qm0wTmFhNUR2NDU1WDFXUEZJbTNuN1dKQXpMMWJMNG05MlhpT2UzZkR2Z09Q?=
 =?utf-8?B?cUdCM3FqeFN3TGVzMC9EaVAremY2V3JScXNUcUowU3B2aEdMR1pYTkpWS0cz?=
 =?utf-8?B?U3FpVTNzWUttUDBrS0xJcVBFRTRZWWJTQWdWakErd1dZMFNlMVBEWEF1V0hz?=
 =?utf-8?B?Y0I4NjZ1MXduZDFZcmYyYk84NGdBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d74c3a9f-3b4b-47cf-0c82-08d9d525b235
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 17:13:33.4974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/+oatmKz3vdO3qhgYgS592+wreLUjAWLTtarLpsGIKvXiG5o4gOduSrGOLKFXMnJ1Rp08kXQs3UTSjVYDjAGszwv1wXFjbujJMW+fySYLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3241
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 1/10/2022 5:53 PM, Jarkko Sakkinen wrote:
> On Mon, Jan 10, 2022 at 04:05:21PM -0600, Haitao Huang wrote:
>> On Sat, 08 Jan 2022 10:22:30 -0600, Jarkko Sakkinen <jarkko@kernel.org>
>> wrote:
>>
>>> On Sat, Jan 08, 2022 at 05:51:46PM +0200, Jarkko Sakkinen wrote:
>>>> On Sat, Jan 08, 2022 at 05:45:44PM +0200, Jarkko Sakkinen wrote:
>>>>> On Fri, Jan 07, 2022 at 10:14:29AM -0600, Haitao Huang wrote:
>>>>>>>>> OK, so the question is: do we need both or would a
>>>> mechanism just
>>>>>>>> to extend
>>>>>>>>> permissions be sufficient?
>>>>>>>>
>>>>>>>> I do believe that we need both in order to support pages
>>>> having only
>>>>>>>> the permissions required to support their intended use
>>>> during the
>>>>>>>> time the
>>>>>>>> particular access is required. While technically it is
>>>> possible to grant
>>>>>>>> pages all permissions they may need during their lifetime it
>>>> is safer to
>>>>>>>> remove permissions when no longer required.
>>>>>>>
>>>>>>> So if we imagine a run-time: how EMODPR would be useful, and
>>>> how using it
>>>>>>> would make things safer?
>>>>>>>
>>>>>> In scenarios of JIT compilers, once code is generated into RW pages,
>>>>>> modifying both PTE and EPCM permissions to RX would be a good
>>>> defensive
>>>>>> measure. In that case, EMODPR is useful.
>>>>>
>>>>> What is the exact threat we are talking about?
>>>>
>>>> To add: it should be *significantly* critical thread, given that not
>>>> supporting only EAUG would leave us only one complex call pattern with
>>>> EACCEPT involvement.
>>>>
>>>> I'd even go to suggest to leave EMODPR out of the patch set, and
>>>> introduce
>>>> it when there is PoC code for any of the existing run-time that
>>>> demonstrates the demand for it. Right now this way too speculative.
>>>>
>>>> Supporting EMODPE is IMHO by factors more critical.
>>>
>>> At least it does not protected against enclave code because an enclave
>>> can
>>> always choose not to EACCEPT any of the EMODPR requests. I'm not only
>>> confused here about the actual threat but also the potential adversary
>>> and
>>> target.
>>>
>> I'm not sure I follow your thoughts here. The sequence should be for enclave
>> to request  EMODPR in the first place through runtime to kernel, then to
>> verify with EACCEPT that the OS indeed has done EMODPR.
>> If enclave does not verify with EACCEPT, then its own code has
>> vulnerability. But this does not justify OS not providing the mechanism to
>> request EMODPR.
> 
> The question is really simple: what is the threat scenario? In order to use
> the word "vulnerability", you would need one.
> 
> Given the complexity of the whole dance with EMODPR it is mandatory to have
> one, in order to ack it to the mainline.
> 

Which complexity related to EMODPR are you concerned about? In a later message
you mention "This leaves only EAUG and EMODT requiring the EACCEPT handshake"
so it seems that you are perhaps concerned about the flow involving EACCEPT?
The OS does not require nor depend on EACCEPT being called as part of these flows
so a faulty or misbehaving user space omitting an EACCEPT call would not impact
these flows in the OS, but would of course impact the enclave.

Reinette
