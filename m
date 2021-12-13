Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E96A47374A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243524AbhLMWNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:13:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:15849 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243347AbhLMWNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639433598; x=1670969598;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MrAl4SNpW0wCcubltpye07vk5BQzyzelSYRYZAjlB9g=;
  b=Lg0Eo3/9heMm0W/kW8iaJ6X7xoqAOp+BUgvKivRxehWMMj/VxHxG5Ado
   xsqkLzml/kW0VkJuO6nF37OYVQWSv5Yee01p2Hue3HtKdQu/TD9XfbCVd
   O2L0PrGiuC34xMUPW9hRI/y1Bs0KfInIP+L2jhjq+cgXpa6oLSuyb7vRL
   UCvFje4PJRUNIsvJtqKDHUkD5SQCrwzE5gPgxIrYQqUs9m/LZWJcFPVWr
   KFqRgs3B/TJ8SnsTxaWEA20iOj/ej9n2hKazCvCtpDk/GPoidYAkLC0tM
   Y8pADI2xuQZI3dYKmynRE4tpfvO1611ruo2dVtgFpwyJarfFwPkWaAiuP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="238787640"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="238787640"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 14:12:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="681802685"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 13 Dec 2021 14:12:52 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 14:12:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 13 Dec 2021 14:12:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 13 Dec 2021 14:12:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9xgKQf9UrsGzIQgdKBZvHoKw67bFw2YS1ZHeNGfA8eSecmS446cROja4E6IsvljHanpjeUEFBCgSMX/xmHKD9f9kHhbRRq+HVMiqRubf9xGZ7fH1rj4WttRa5eZffLfwfjHRP9rQTHr5jr3Ueu9uvgghl74nmO/rbSeWuFWc4qdfykNI3KM4gDwEOwHVZFf84s4hM7J4YyaGPUBF7omQHsM019mX/47GZOZ7MuK0QnpwUqg08r84KH/SsN6OhTJHaWerkAEzq/v4KCA+TkPz/6dHXQWDKCW6FEIMYtWGSyfBwfg0DuXoBt6vW1G7nTMOvEIgPII1jsFlllRQf5gjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yy02FZkkFKo1uRhA8/EI9l/hXcKIeS2Mht4Tp5QpJH4=;
 b=bm5iUemrnXF82tqxT9PppvMXU9Ed3Ov727d3zldgQRKhA2uUKg6BDcoV6RC6r/yeiSIV864UrfTjlcy1YGClrf6GZbfR7jHHNaGK9M2nQwkt7yXmUEIq2EewjJTygIZGpVuzYCJsz3MVxbuYkwzwxy6LID8szw/ThhcyY/YPySq9HAwgR705+V1DM11P7AowMHPQGiOJxIKhnWfwoJqpW5rjrSx0iXvIQCtUOtZyydVts+RbjF7IoZBd63SxOIUUV0qHdLRi1qeu2ltp/yu9Jsyy+8cPiMZRSGcoVwcwP2b527FmV954dfzrUEmy1JVcAdhmwLEaWORyFVtnI71Cxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy02FZkkFKo1uRhA8/EI9l/hXcKIeS2Mht4Tp5QpJH4=;
 b=qmyPWzlfG1RDpdrof3uzBN4V9R8/mcctMd9yF1RIgDLehCsyXyVbNPmpCrNIOB0Eoi+WV0eZgAL5ILsVPat7Xff0/1BMHot30GQlDQAsLJiP06DYFUb6hP6ZJdRu2RkvuzpOdNCC1VHUEb/E6KWBxzkUwx8CZTv06XR416YCo4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1908.namprd11.prod.outlook.com (2603:10b6:404:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 22:12:49 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 22:12:49 +0000
Message-ID: <8fc271bf-548f-969d-96db-ca78b21578f4@intel.com>
Date:   Mon, 13 Dec 2021 14:12:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH 10/25] x86/sgx: Support enclave page permission changes
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
 <44fe170cfd855760857660b9f56cae8c4747cc15.1638381245.git.reinette.chatre@intel.com>
 <Yav0/3jeJsuT3yEq@iki.fi> <fff63bde-94a4-6c0c-3333-4cf392bee50b@intel.com>
 <407c12ed28b105a055c6ab6152c0458a31052963.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <407c12ed28b105a055c6ab6152c0458a31052963.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0068.namprd19.prod.outlook.com
 (2603:10b6:300:94::30) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f995afe-f9ad-43d7-14c2-08d9be85b2e2
X-MS-TrafficTypeDiagnostic: BN6PR11MB1908:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1908946EBA4D26497DE77C3EF8749@BN6PR11MB1908.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkE+XuV0ggBCzga6M3dGxJxpGO5KvRlgViMyw2otLLRKTs4xd/8zZhVNChMjjWTeN6aoUPP/6Xn/UFmfx06Gb/NZPz1+JpTBEG1RzNWCJ3oaiTGHyn0ClaeQMgn/F9fPwkIWi4/7GtJVk2qCYgXvGVmBTrBdcB2hmmWfq7dqb5paKvrwymDEywxvOanXZpXWtf3sr00CJf/6jyZs6RqJVDVQ4HRL87sVvRdJAXsKWn8fnycjimE2JzQe2z5jQeetBvYk5F5TqiDSdbKpkyb/FXcDY3EDKx45W9pG68xyBbZ+UOCQv4mjqos89aQxRle0NncisakhbEdovjwMmoMCTIDRdE7aHQFVyZK6jzOIxMoeUBiB49YoCsuJn73dASsb7Mm0MCvMMVX0XPkM9ojOashzmHzFkBhCoPPlDylsBSX0ibmlN+K6JvwHrB7ttqf0Xn+05tGgnFdKmQwpK306E06EiPc+0KyUJg8SzoBHq+NZ8mZFRDymxTY4hiY0Q+BEvAnHWAsRd0xUYfl2/ZpQwDKMoq7ucVpWwG1Yt1GGeLxlY2+XK994CmbpLZRg8LdYQS9Mb0y0M3TUdDcER7ZB0x2/RW1XCk1ICWLJlxGt/he/Jx7EU2CvClVnhdKXMBbpOkXMwQjoGhKblDfDotH++MbAcylc6B/w8iD3ITqp/92jNaj9Q8oU+BK4VT6B+fx+JZ2PiDRFchUnqL8i7aZPfI/pmD1wGiCuiJTMSJfiVYcye08fCjpmP0KQ3e7w0lJBTzTECpWmWtlkjXE6RlnOqGKmxJosK+8Dhy/DDDttQFSr+6oZUTfPGcfDePojTqTW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(38100700002)(83380400001)(8936002)(6666004)(2616005)(186003)(31696002)(26005)(6512007)(44832011)(7416002)(6486002)(508600001)(6506007)(6916009)(8676002)(82960400001)(66556008)(53546011)(2906002)(66476007)(4326008)(86362001)(66946007)(5660300002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVg4b3BsYW9iSU12UVdZc29helJYUklqbzZWWGhWSGtvd3F5YTN6RDRYNDI0?=
 =?utf-8?B?b2JNbktiMGdHNC9ieE1ZV0ppeG8rakRtYVBOUWhlaitpd0U3OGc4Q2xoRis3?=
 =?utf-8?B?VStZUzBodVRrbHFmUG84eVdHbFVtUWpKWGptTlNGTVRSdmVYYklHZUU2QlhI?=
 =?utf-8?B?eGY2QU1pc2tNcU9STlpYdnNmeVBlYUJMVVJvMFM0a3hMWnJmTXVLMmhIenV4?=
 =?utf-8?B?SXNIRkFtUUNYUlJYMjMxUjJjOWpZaFJoN1hKRXgvZ21xSFY4LzRWTFRMeHY4?=
 =?utf-8?B?ejB5QkZBOVo5Rlh6Z1Z4c2VzY1NzN3BGWGxBcFRTV05pYU9uWkZLOW5KSVIy?=
 =?utf-8?B?ditnZFZFNEtUd1Jab3Q2b0lLZ2p1aUxkWm1xR1JxaTBjNlFaaUlBQVNHcnFi?=
 =?utf-8?B?V2gvNTJRek5UZmYxaENxYnJ1NTcvMlZFNFF3c0o3TWRoc3pIVXdwOU5MVThx?=
 =?utf-8?B?NDgxL1NsWTNYa2diakJLNUkxZXQ3WmZKZ0xtOG5oaVRPODFuNjlybXMyN0Nn?=
 =?utf-8?B?Q3BUYnlNM3hMYXhNZ3dETGVjQk1rRWJMcXc0cTlnMnNzek0zejF0TGx1QmNn?=
 =?utf-8?B?NThwQyt5Nkpjb3F6VStGOEtPRUJsUk1FcmlKM0JRRHorWm51WEIvMEJsKy9L?=
 =?utf-8?B?VVZRWU1GVkpZOXdldGFyR0ZkSUhvSC91OWR1QldTbUYrQmVwVDNNQVpaVmlK?=
 =?utf-8?B?d1JZTTBxS2RkQWwzUTJQaFhnMlFpQTloMGwxVHlXdmp3blBiMlp0TlEyTVov?=
 =?utf-8?B?YjFMeDdKNmI0WXpWOExrcjVXV2ZNN0hUVUxLL1BBV2dKTm4rcUsxSUxqb1ZC?=
 =?utf-8?B?OUtVVFFhRmhaRzJka1dRZE05ZnI2RFA0MHBqSjQ3TWJVaVFQYU9rZEFHWXFN?=
 =?utf-8?B?V3NNU0RraWY3R1VPVytIOGxtKzA4dEltbW0zejI0Vy9lS2d4Y2M1cXBqMXFJ?=
 =?utf-8?B?NjBrb1BDTHZIcDFzWm5IbXJnYURValpmMjJQczl4TGhvTWp2d0RzWHQrOTJn?=
 =?utf-8?B?R0ZwU296VWYrd3EzdWwzeGplYytVZW5TZmtIVzFicHJrVTlOVVBsRzNaYkZO?=
 =?utf-8?B?NitmZXM5cUFiVStJOWgvNlFDdnA4bmRpaHVhV1hMSlF5UnQrRE9rekx6ek9i?=
 =?utf-8?B?QnJBelRHSUVudmpROVFZUmhCMHlqbk9rQmd6Q0FWODVISzhzV3JoYllRdlZU?=
 =?utf-8?B?RXdhZFRORE1ESFlDYkNXM3FOcWpOSFVIM0RES2FZeHJKWVhGS292am5UaGN1?=
 =?utf-8?B?UUI5cUNocFJvemhIMXJKU0VhUCtEUm16UlUxUkVnMlVRMnByY3lVemE2dkNR?=
 =?utf-8?B?cnFucHJVMVZzTXBUUzRSdlZ1SGRldThDdTVheE5xcEJteG45NndyY3ExMGpC?=
 =?utf-8?B?OVhUTWRTRlBYL3piWjZpZGtlRjJzaXROY09JdWFQUEFoRWxUR0RwTnBtSzBr?=
 =?utf-8?B?Rm40dndIMFhJRkwxNk9KR25remlkRlJNU01TT0lzVURqS3hlU1VkZzZJZWJ2?=
 =?utf-8?B?TnBDRUxhdXlpR0JVMGJrRDFkeTJZeEpFZzNhU0ZIQXl6a2ZNS3pyS3ZjUEhR?=
 =?utf-8?B?K2RGS0Z5NE5qbTg5VFRqbC9LYTdpNHZHM0ozSXVUMmtIaHAxV2pxbktTQW9D?=
 =?utf-8?B?RkVlaFY4cm9IN3BvQWorNThDTWdkUll4anBYOEtZTksrb2FmMnZrcVh0MExR?=
 =?utf-8?B?RHBjK2phaXR1R2s0L1FUbm80YTJNRFl3cUp4TEJFVkhYM2NzVmEzdkVMd1RM?=
 =?utf-8?B?ZXhmejJOZ09aVnYrek84YUpLL1lHTExldys0VVowRDhrWWQ1dEVuK0NYbmFi?=
 =?utf-8?B?N2xpNTBQR1dsTUp6K1Y0YzduR2NQOTNNYTdHZGxTMnFqU0paOGM4dnF4MFBa?=
 =?utf-8?B?TUNOR0d1Z1M1SFFWSDZ3WHo0WXlIY0owNDd2U2Z4NDcrRDVGQ0VqWG1RcTZ6?=
 =?utf-8?B?bUljeVJzalowcG9nUHRXUE03UzVaV1d0UFA4RTVtekkra2lJeWRZMWhSQzdN?=
 =?utf-8?B?aHVtQ0lDZDJXUHdVOGZZakZBQVdCK0IyMlNoQ2YzTjA0cXFDM2tnVVFwejBh?=
 =?utf-8?B?WUFSeXdhRnZ3RUpaelhCeUxDMkwrTE5Od0E0QkF2NnhuRHBKd29PU25qQkpQ?=
 =?utf-8?B?bC84Sm5pNUo0RXB0ZWxnSGR1LzU0aHRRZ1h3S2VBc2lpSk80YU1FSC9OcnV5?=
 =?utf-8?B?c0E5YndwK2NmVGdXb1l5KzhGWXJ0bm9GcThmQkpCMERTUisvaHIzOWpUdG9v?=
 =?utf-8?Q?24sWLGN0R7BnrT0plkxr6qeII3VM+nN4su3hkx1hQU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f995afe-f9ad-43d7-14c2-08d9be85b2e2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:12:49.2695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C93iX3C06aSph7UwRJc6NslXtm4HyzRh6teOykk9F5jAUVc+X/cIqDmwv5oNL3hdLM5h6YVrz4EjKBoxwSzQ/3yZJ0Jg781GkbVH/DuwLfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1908
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/10/2021 11:57 PM, Jarkko Sakkinen wrote:
> On Mon, 2021-12-06 at 13:42 -0800, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 12/4/2021 3:08 PM, Jarkko Sakkinen wrote:
>>> On Wed, Dec 01, 2021 at 11:23:08AM -0800, Reinette Chatre wrote:
>>>> In the initial (SGX1) version of SGX, pages in an enclave need to be
>>>> created with permissions that support all usages of the pages, from the
>>>> time the enclave is initialized until it is unloaded. For example,
>>>> pages used by a JIT compiler or when code needs to otherwise be
>>>> relocated need to always have RWX permissions.
>>>>
>>>> SGX2 includes two functions that can be used to modify the enclave page
>>>> permissions of regular enclave pages within an initialized enclave.
>>>> ENCLS[EMODPR] is run from the OS and used to restrict enclave page
>>>> permissions while ENCLU[EMODPE] is run from within the enclave to
>>>> extend enclave page permissions.
>>>>
>>>> Enclave page permission changes need to be approached with care and
>>>> for this reason this initial support is to allow enclave page
>>>> permission changes _only_ if the new permissions are the same or
>>>> more restrictive that the permissions originally vetted at the time the
>>>> pages were added to the enclave. Support for extending enclave page
>>>> permissions beyond what was originally vetted is deferred.
>>>
>>> This paragraph is out-of-scope for a commit message. You could have
>>> this in the cover letter but not here. I would just remove it.
>>
>> I think this is essential information that is mentioned in the cover
>> letter _and_ in this changelog. I will follow Dave's guidance and avoid
>> "deferred" by just removing that last sentence.
>>
>>>
>>>> Whether enclave page permissions are restricted or extended it
>>>> is necessary to ensure that the page table entries and enclave page
>>>> permissions are in sync. Introduce a new ioctl, SGX_IOC_PAGE_MODP, to
>>>
>>> SGX_IOC_PAGE_MODP does not match the naming convetion of these:
>>>
>>> * SGX_IOC_ENCLAVE_CREATE
>>> * SGX_IOC_ENCLAVE_ADD_PAGES
>>> * SGX_IOC_ENCLAVE_INIT
>>
>> ah - my understanding was that the SGX_IOC_ENCLAVE prefix related to
>> operations related to the entire enclave and thus I introduced the
>> prefix SGX_IOC_PAGE to relate to operations on pages within an enclave.
> 
> SGX_IOC_ENCLAVE_ADD_PAGES is also operation working on pages within an
> enclave.
> 
> Also, to be aligned with SGX_IOC_ENCLAVE_ADD_PAGES, the new operations
> should also take secinfo as input.

ok, will do.

> 
>>
>>>
>>> A better name would be SGX_IOC_ENCLAVE_MOD_PROTECTIONS. It doesn't
>>> do harm to be a more verbose.
>>
>> Will do. I see later you propose SGX_IOC_ENCLAVE_MODIFY_TYPE - would you
>> like them to be consistent wrt MOD/MODIFY?
> 
> I would considering introducing just one new ioctl:
> 
>    SGX_IOC_ENCLAVE_MODIFY_PAGES
> 
> and choose either operations based on e.g. a flag
> (see flags field SGX_IOC_ENCLAVE_ADD_PAGES).
> 

There seems to be different opinion about the single ioctl() as 
per:https://lore.kernel.org/lkml/0fb14185-5cc3-a963-253d-2e119b4a52bb@intel.com/

I thus plan to proceed with the two ioctls, both taking secinfo as 
input. Would that be ok with you?

Reinette


