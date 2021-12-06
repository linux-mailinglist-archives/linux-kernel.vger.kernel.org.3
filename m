Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6594046AAA8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351495AbhLFVrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:47:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:9201 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351164AbhLFVru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:47:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237223764"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237223764"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:44:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="514938190"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 06 Dec 2021 13:44:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:44:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:44:18 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:44:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbZ3e8p0iixKlP/E+OvMoxKouC6FB/t9kRZrlJF9MLel08ORJmP/FMLkQC+MPc7anOxHcnqPfZBsZ2Mlasw1iZzzH/ijXFOIFaezXn5BnetHxSYTwl5ZW8zSTl52z746smkJ7ZQmfzCT9ixP+nJBE3ympAluz81NB6J3JMckaImmWZ9036n9unqNDIZPWwhxL4VdN8v26oSWa4KgV1b2ItHXwUyfrefQCNHTNTXSgNiHRXYUgpk/YXUFwbqc2psRhCMv8w/gozLDVo4d5j44bvAdNdwa8N0pByD17NRekZnxjclkQUTvz96Kr95toz7ORiW2EeO9/3y9hTcbzGOFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5BxN7A1SzuAVEzYTg5Jpa5RgTKWl+5Sz3Dx0s06t4g=;
 b=RS1iotmS25+iD9AzJZw3TpTGHWoiT73tMOzMmo9KQdihthEgrFz+ElwLutKRgVjRgo5vjacJtZUqUxGUZkPFjTpZIZUnPyscWTJqbm/qmKfAvrzrVQ4+u0sBOmixIyLJZGxVuLqqgO8pIU2gTGJpj1PtVaC+7vNV0ElFJHKFShMKMm+TlP67Hw92OUbOE0LMf3xkOhekzNBLYMBSCzkpZbChKS1r+4vD7ULdEGCrk8pXOHEqht3dTvQ3ovkghQ0dr4s2oK0WnfwaX2Ie3RHfjXHI6wXAa14eFNF/bJ7rYdZWDM1fshP3cm7vWlqhyFvRPxgUF83s/cDbi+tex+N2aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5BxN7A1SzuAVEzYTg5Jpa5RgTKWl+5Sz3Dx0s06t4g=;
 b=S+TQhUhOlNf/MEpc2jtGUB+XbRj48g+mow9APv7emk+33NHHUAevtYNLdx9/F+DZ6eMvj09Vq4wVae6tyibH7PbANi7knu5KAlLepr92atNEqu0aOITKW62hzM1JCp+eEnH64q+3ChVb2/DSHegQ36lYa/sRxzMYTG0LtS+SOT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB0035.namprd11.prod.outlook.com (2603:10b6:405:62::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 21:44:12 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:44:12 +0000
Message-ID: <cc6ecffd-7d4b-0b15-eaf1-6f585e8b31be@intel.com>
Date:   Mon, 6 Dec 2021 13:44:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
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
 <Yav1/ZRX68cECD7a@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yav1/ZRX68cECD7a@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR21CA0058.namprd21.prod.outlook.com
 (2603:10b6:300:db::20) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR21CA0058.namprd21.prod.outlook.com (2603:10b6:300:db::20) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 6 Dec 2021 21:44:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6cce2e4-021c-4497-3add-08d9b9018acc
X-MS-TrafficTypeDiagnostic: BN6PR11MB0035:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB003552DD96D75BE70D101942F86D9@BN6PR11MB0035.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyYskWCOiBO9PwOrtYpT5WFYDN8g8Lhdd7fakbpwwOEKAdtsMhb6ebtqreGV7oh8+BHqYB1nRbUZxVQSD61lR5GBi1PxDc71r1zPdc6uf8rgB2bQJI0S8oy9BDn1wD/3L+pzyclYURWV1YsXxYBgkkwPIuJyDk1roxakkpVX1dpyvWY/2Zi+6I7WUMv0+jlVTB/sgfwnVjc92dq1a203uMI+444gCbcbwdrw6jPQUhsX9sz35ecTciQeBhHmNZ17RF9xez/pXVYG0S4gI3ws4XXf9oe89VmtESTrrO74hZkSxmwVPYbAwqPaqdGG9QHu50pMAoakIewhRP4aKkIPyrOBjvvsT9nUsT7zgdT8QXnxC95vnyfff0fscnFBGU7IzSZxYkOSpEwSDYgGI/uWtePROpokfpi5nX+t1/qpCX49WKWp3MWIYyO/fAKZ4+NKIs0DRpK9uIUCMvah0Wf+vxShizgDR+h+3zNH3Wtv/GLm8tjccY6QqQ6PapOYDNa+W0Oddcu1/VzatuB6xqnXKT2V1cOm3s1hKuh7LF1pNF+YvHaY4Gms3swhnSpc/Z3qRLWIzF9euKTyjjvI8whbfrYfrv4659QpYFEA0TWYa1Nwv+8l+2E/Kz1rj+U6IF3cD3v1EnfUv94PGCVLZGBZr1JbKxpxsn0GOhLU/UKs6WEUEYLG9V90cdnKNWPWhTx1WECE+dkyA7CiH+bD15NvgKWoZdhicYXL9Pagtx7ZuVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(44832011)(316002)(86362001)(66556008)(66476007)(66946007)(31686004)(508600001)(2906002)(8936002)(82960400001)(53546011)(5660300002)(26005)(38100700002)(186003)(956004)(16576012)(8676002)(2616005)(4326008)(6666004)(83380400001)(36756003)(7416002)(6916009)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ymh0L1lpVm1MZmNieHV0ekdvZTJ5UE9QMGY3cDd4Z05yZFpqUjJieWcxOXRh?=
 =?utf-8?B?REFvdzlzbGJmdTFEbldabVhqVHM3emM5cUJndUg0MXVBcm1HNlFqdU9kd0xC?=
 =?utf-8?B?d2dhMVdZb2IzL2duRzhEaThHYU5pRThJejU3dFFPS3ZFL09QYzBvc1ErQUxx?=
 =?utf-8?B?aG1LbHhtdzBLRnc1UkpRZjJ3c1lCMEpJaW9kSWJia29RU3NCOGM0ZXRTTmJB?=
 =?utf-8?B?Ykp5bmxtZjlsMnVqUnhEVkRmck52RHVrbmdicGxSZkg1bHRQOHBSV1FPaVds?=
 =?utf-8?B?bDQ4L1F0clVkU21oTUJBdE4rS2p2bUxNblljelJDcnFqMkhTLytVenFtWVJB?=
 =?utf-8?B?VHdjV2tNMDdlQno0dmN4cjJFSVlGUDZKV2RjTVpPQWpaKzJOdUp2MkQ5eEFi?=
 =?utf-8?B?MzI5S0JoZ1IwWlNvV2xzVU9rS0F5S05zTzdFT0VEYm9xbE5XSXE2SzFwTzU1?=
 =?utf-8?B?c1h6TE9yNjdOZ29VM1VsTW51N0hhT2FyaEdueUdhRVFZZlo0VitGWXlJN0dk?=
 =?utf-8?B?cGRBb3dReTZFTmRXSGxXektLa3F0YmIySmltd3NaVFQ2aFpHQmNjOE5mZlhT?=
 =?utf-8?B?SzljMi8vSzcvUm56QUtQSVFMZkZEOUJwbW40Y2tadWJPeVBkb3JjR1lSUHFa?=
 =?utf-8?B?MDc4VXNaeDdRc0VxdDU4aWJsU3hYNExlem4yOVhidkZxOWxNWm56VjVpaHNT?=
 =?utf-8?B?a3MxOVZDcGc0alo5anZ5clBXY09nc0xoNmRNeGk1aDBKTHlKNVF6Si9CeVd4?=
 =?utf-8?B?ZE9QREVLbjdvcVhUcjVCZi82b3lCM0ZMR2VwWjlCNjkxaHg2SndCNVpoZFph?=
 =?utf-8?B?NjNRTEJlbzI3QllQZzE0enBGSG1aOXZwOGpMaUZ6MGRIOUxoVitPNjhpYWZp?=
 =?utf-8?B?RzRMTUtHMmNvNVlRdUZKa0E4N3psUWVoV3VDZVl2bFpBU1NSTDMvTlJvcy9W?=
 =?utf-8?B?aGs5Snc5ODJtOE1ZU2tOak16Rmh3TUIxUmhYYXpqdEdReWVIdFMrdDFaaWRK?=
 =?utf-8?B?QVFpL1lQdE5oOUpWdGxHYWsvdlhoSE5URDk0SWg0eHFCaElCa0x0YWUyS1lj?=
 =?utf-8?B?TVlMNmp1bzVhT0FJNjZWMHRkZFRTeVpDZ1FqVEthSTd5MWtPdjYySjdGU1Fs?=
 =?utf-8?B?RXpFR1M2TWRWMXNmZG5KUWFDVXhwMzdRY2NrVEIxSi9ZbzJPbjJlNVg4RHdG?=
 =?utf-8?B?MVRaZFdlMW5KNUgvaG9ZV2orZjJ3R1hXcUtsaTNvT3lxWmd5bjRrdFpQOGhu?=
 =?utf-8?B?OXhjSTlRZS9qVjIwd1oraEhrbmIvdGdDMUZ1UTBvMXB4MlFtc3VBWjI2ZGQ1?=
 =?utf-8?B?VnpDREVTWnN6MjUzVm1admFXajhlKy9KaHIvZjNKRWF6SlZJayt4cjlUTEJK?=
 =?utf-8?B?d0RnbGxxcnlDRGYvRzJhd0swcy91bG5Rb0tFdXFRdjJQYWRYWGtaRHhVaWRl?=
 =?utf-8?B?V0xIK3ViZE1CbmVqbEU0T1NrSkxFTFlNd2NPK2MxZUJGZVJSY2tmYkNpVEJn?=
 =?utf-8?B?dVFkOWg5SGkzaUkvanJEZ2tHUm1oYXZ2aFkxb1hTTEE2dzZyMkdpVHJ0WHI0?=
 =?utf-8?B?ZTV5K0I5WWlWKzNGbXFud1RqR05HOStWcERNdlVkUWczZzBROG80SCtaNVVV?=
 =?utf-8?B?dGF1L296M3VPT01MMjBCVWFWUHdvdUwzNkVrM0NhdlFkOStrck1hTjRiSENn?=
 =?utf-8?B?a09Vbk9jU21sQ0FxZU9BaFg2WG9tQ3I1VU9Db2grSmZFZDFXbXZYNlB4aHVB?=
 =?utf-8?B?TGZmb1dsWXZuTDBheWpsS0NmblQ5TnU3TDYvTGFESnExZmRSQkNocnpjMjJq?=
 =?utf-8?B?TXcyQk95bnZwVXRlUEh6ZDJMZFpyM2h0WVF4L290b3ozUVdHbFNua2dzdXln?=
 =?utf-8?B?V2RHSnJhSFdzVWJkTlRkVlNiMkpROGNJclpQaXpRTHgvVWU4Tm9MTTl1eldW?=
 =?utf-8?B?blluRXNvRUxEellGeFBwcC9CVnc4YXlwUTRQcWdUOTdwNUl2aDRHNHZ1UlJS?=
 =?utf-8?B?ejZreVkrZjBWdXI0aE1YZlBWY1lCRHdCL3dsU2xHNTJtWTZUQnFoY0luME5W?=
 =?utf-8?B?UVdZZWM1OXljcUcyRytJN1M1Yk1WTnlOeEo0eVBEWkY2a0FaUlJaZzFzeWwz?=
 =?utf-8?B?RHpZVkphQ3VudXhqTitwUERmTHpQbm8reDB3dUQ2c3gwSUNHM3pQRDZDWEp3?=
 =?utf-8?B?TDJZMjB4RTd4b3ByM2sxc3BmaUltWUlqMk8zcjJrUll6Wi94cTdpcmxwS2tV?=
 =?utf-8?Q?g/6Le4LDnpAIAjdThUVnoxCqCVc3u8itECd/jB0Ayg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cce2e4-021c-4497-3add-08d9b9018acc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 21:44:12.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOyp5SN5/YYKYef/9LjUmBlHsDniNm+T9wYn7Jnx98jJI24m1zrOLCYuy2p0gbYp0ka9Wj7t8wK0cK9ImbuY3wNppeEOthZ50eBkvwmRBEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0035
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/4/2021 3:13 PM, Jarkko Sakkinen wrote:
> "to initialize" -> "to an initialized"

Will do.


> 
> On Wed, Dec 01, 2021 at 11:23:11AM -0800, Reinette Chatre wrote:
>> With SGX1 an enclave needs to be created with its maximum memory demands
>> allocated. Pages cannot be added to an enclave after it is initialized.
>> SGX2 introduces a new function, ENCLS[EAUG], that can be used to add
>> pages to an initialized enclave. With SGX2 the enclave still needs to
>> set aside address space for its maximum memory demands during enclave
>> creation, but all pages need not be added before enclave initialization.
>> Pages can be added during enclave runtime.
>>
>> Add support for dynamically adding pages to an initialized enclave,
>> architecturally limited to RW permission. Add pages via the page fault
>> handler at the time an enclave address without a backing enclave page
>> is accessed, potentially directly reclaiming pages if no free pages
>> are available.
>>
>> The enclave is still required to run ENCLU[EACCEPT] on the page before
>> it can be used. A useful flow is for the enclave to run ENCLU[EACCEPT]
>> on an uninitialized address. This will trigger the page fault handler
>> that will add the enclave page and return execution to the enclave to
>> repeat the ENCLU[EACCEPT] instruction, this time successful.
>>
>> If the enclave accesses an uninitialized address in another way, for
>> example by expanding the enclave stack to a page that has not yet been
>> added, then the page fault handler would add the page on the first
>> write but upon returning to the enclave the instruction that triggered
>> the page fault would be repeated and since ENCLU[EACCEPT] was not run
>> yet it would trigger a second page fault, this time with the SGX flag
>> set in the page fault error code. This can only be recovered by entering
>> the enclave again and directly running the ENCLU[EACCEPT] instruction on
>> the now initialized address.
>>
>> Accessing an uninitialized address from outside the enclave also triggers
>> this flow but the page will remain in PENDING state until accepted from
>> within the enclave.
> 
> What does it mean being in PENDING state, and more imporantly, what is
> PENDING state? What does a memory access within enclave cause when it
> touch a page within this state?

The PENDING state is the enclave page state from the SGX hardware's 
perspective. The OS uses the ENCLS[EAUG] SGX2 function to add a new page 
to the enclave but from the SGX hardware's perspective it would be in a 
PENDING state until the enclave accepts the page. An access to the page 
in PENDING state would result in a page fault.


> I see a lot of text in the commit message but zero mentions about EPCM
> expect this one sudden mention about PENDING field without attaching
> it to anything concrete.

My apologies - I will add this to this changelog. This matches your 
request to describe the __eaug() wrapper introduced in patch 02/25. 
Would you like me to duplicate this information here and in that patch 
(a new patch dedicated to the __eaug() wrapper) or would you be ok if I 
introduce the wrappers all together briefly as in the example you 
provide and then detail the flows where the wrappers are used - like 
this patch?

Reinette


