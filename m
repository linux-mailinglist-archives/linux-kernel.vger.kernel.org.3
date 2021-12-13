Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5BE47373C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243480AbhLMWIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:08:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:14449 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236504AbhLMWIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639433334; x=1670969334;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GPWAXLYUQCDtNxBnuuVAh/vJ3l21h4Q5OL41PXdv6zQ=;
  b=mDbT3bd2hiM6qSUyX4MjFbpDYpxzYQwL3JGfRxujvtlshkeC2YxXyQxF
   65rb2LF4g1B5ZTdwfvDX0y0B1uFAWG43YN1FGGHmYx+BwY6LVhmQ3wzJm
   YHJXc4qK3X6rqQxYOkUBjnXIMpAg0hmS7s+QaHZCoAtXwUXKVhm+xxqwl
   SRlFhE0lzroh61iascIFtSxc/JaKKdN4JzKvdzIgvKHfouPpKxadOHlF9
   V4cUqYQoqBJZ1w35S9kGoX8gsIZw+yyVj+y1G5KN7zGR43bQtQybD1u2j
   cQK7zBvM/E2gtN3QJfT1Z9QIk4YetFWGm2n4jvcp8uaq4iFQUzRDZqfik
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="262974088"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="262974088"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 14:08:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="505094266"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 14:08:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 14:08:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 13 Dec 2021 14:08:52 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 13 Dec 2021 14:08:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef7vZrdJI5uyKKb/AZRjiEjeAr2zPWEcnjBBMjqsBUuzSQZ5+cmLTIemeYlazbzcTYlelaZfpkyF8td/1IPXcqHx90GFlmCngcCmUZ7bB6kGuZSqW6FQneLU5tSMwdj4N9jCKWK/bUZSy8vZSSHcmF99Tz195KCH8x6xNUMy7stjBaOcbLMe6fRm6Zm8pVjcNlh/cDKcAcwVrrJmQ5IcJYkRX6U197wjU3iZi2xhcl09oSg1/iQTuFlwRpf65BP+BdyrSSrPF/KRiaJJmBLsmIVx3p1VX0KEmRTrZExFK/ZvzP6CXj38YuUIeBZrKZ4SdPi1MmErm/lia4WPd6XBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPWdMTIkNTppd+JDCxpiR2BfBpx2MnClBlvlCVITMVM=;
 b=n0tfo+nZrTIF5rSKDs8X53a8KJQg1PYEYVMfNPJmcnJFzhkQSsp0mAfJDhhLSMUGsIfgXKUZR8hGKWglF/uhaO7YAmh1DC0jL9Ksx49YaP5boG6+mapQc76sLbHaowfmFetG/thhKyfKrIKTkysIEt6IT33iS0VsjHndlo9MUWIG7dL9VLCXygtrPgynmYwma1cvncBaLItDwtOgGdWdRHj8ibFW1bBLdUDUtMbVncPDfq6buaqxO3/11n+nOIiCsFVM8yVyKJDlc1MeUCiATU7jB21o2KKG77B/STrC5rkDNr0ZwNQMmADNg05bxJERsbjDAV7SfhTSxVBPMhEGIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPWdMTIkNTppd+JDCxpiR2BfBpx2MnClBlvlCVITMVM=;
 b=FNLrQGEczWc83jzMeLAFJ+uTLlk/7K4futboDF7FzqGtvyXQy1pE2dwpvw1YZRVfftwDXsER4SoTHaW3zusfbnzr8PdNj0LogbaklW++jL4WlWFudayy4AftnI4z/0U2hL3lsanTt+uNZTodu/TjP8ePUBXw7LxKIC8n3/DfoaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR1101MB2257.namprd11.prod.outlook.com (2603:10b6:405:5a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Mon, 13 Dec
 2021 22:08:49 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 22:08:49 +0000
Message-ID: <dbdb877e-061e-8195-5aa6-f121134ec7b2@intel.com>
Date:   Mon, 13 Dec 2021 14:08:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH 03/25] x86/sgx: Support VMA permissions exceeding enclave
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
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <7e622156315c9c22c3ef84a7c0aeb01b5c001ff9.1638381245.git.reinette.chatre@intel.com>
 <Yavq83gZzvkVaDqq@iki.fi> <YavrSFDJBGqe7K46@iki.fi>
 <81308f67-a4d1-1774-f58b-223d4e81f8db@intel.com>
 <bb7757c5b5cc3fe45e74cbee1ddafb9c71c4f4e1.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <bb7757c5b5cc3fe45e74cbee1ddafb9c71c4f4e1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:301:4c::27) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 977cb8fa-a1b0-4fcc-93a2-08d9be8523df
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2257:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR1101MB22572D27833AEBE8482C9570F8749@BN6PR1101MB2257.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +vKYlV3l8g6TqXGL+9juw1eNiMKKI7140Egs/GQpwM6kZw7s0NRyDzhipcQvV4yCfdcOb5iPoCatMhCnm9Vk2a0y+VZ7bYemfzaz4y5i02Xaq45eazG4D9UjHZ6wQtfgXpTEq2dkahM68Vfcw64b1MsIwKHIqrNwzgP96OFpOI6J+lDY+VU5CxkuH8y/nXKRp61OyepN//cMpkGjZoLeNpCyDK37LLa7Znt1F++N8lpZl7UirS3o1DZlbW7l9lhE6p1xStqRoxXcA76MBU9UJehxPBe5u3j+L4yD90JFCtOLuqL6XCDsgCXTAj8+vvAh/ULjZVkJ+NcmYrUhjnzIHfgZ7B5ubEFGvFa6vgE6EyE9j+ZdPU0DNP+Wiwr28Rbmjz6Xv7pGcYb1jVcRWbh1EmMjgMMZ9DrqzOAWuCJthvmhMePUhKor5Vc2qg6QlRWoKzNu1ILPINk473VtiJy//9uAIyLGgV/DJ10u5qMx8rG1YGxMhO6dM68ifdiTSDAInEGOZmvg/aIcuin+R/KC1NecZVw5Eof6AiOmseUUHbPQNt3CfXWLpqUMux7evzjhyqdE5WL/ZEGpfb1wEgbkgran7rhlniejgipwdzp1an1+COfFGQn69lJxsdXW2+S240mwuA9qhF13z20MHnjZlmG0g2XywzjDecH3uMOkuXQei0x7wAocdvBXuojdR1pV7S2QGPpexeXZTJfSUSYOYhz6DPN8bxw3Mm7webQjMzBSeeFNR0X6uqyIxqjQ3Tcz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(66476007)(6666004)(508600001)(66556008)(26005)(186003)(7416002)(31696002)(6512007)(66946007)(4326008)(316002)(6916009)(6506007)(2906002)(53546011)(44832011)(31686004)(38100700002)(86362001)(83380400001)(2616005)(6486002)(8936002)(5660300002)(82960400001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z01PT0x6b0tUUzF3NVJITnRFZFU4NFBjV3NGbHNXZ2ZHY3hNSTllSEl4ZEVv?=
 =?utf-8?B?OFBFK1ZNOU9JOUVFcmJ6eEVDSzRlc0lHY2tVSjJrdmF4V3YxbGNEek8rTDdT?=
 =?utf-8?B?VGlkRk9PVHkyZ2J5L2QrSlJ0UExxRXZoU1lhcmU0QmhXc3lzMkVxT3NMNGJw?=
 =?utf-8?B?b3dtNml1V1pJdkJEVzVnQTBKNU9yc2Y2WUlXVndneTd6TTBFQnM5Z0hzaElP?=
 =?utf-8?B?Z3U5RzBLVUtnRzdwdUxRRFRrUlY1TVRSWXhwdmo2TkZXaU81Qk1zQVNxZE80?=
 =?utf-8?B?a1JmTG1OaWhySEIyNk16M21zTmFzZE5jSE1DQnJ1QzYvZWs3djR6MG05Q0VK?=
 =?utf-8?B?cWI1akdSaEQ2VXhrRU5laWRGclRXY3Y0LzNkbmtMNnhNMUVDTVpHTnpyMGhu?=
 =?utf-8?B?Q0hUZldiYVd6MkRneFR5Slk0aE91RnJSaWFnbzVaOHpJTi8za01xUU9xVVhs?=
 =?utf-8?B?UCtzYW5kelRBQjdXTmlhdFU5Vk1LN1VyREdWdXdIMk85ODhOZThpNnRpVU1j?=
 =?utf-8?B?My9wWWVNNjJVcFlkMko2YUk4THNSMGJ6TVdyaHlCOXk0RDlDSDZoQXpSYXVO?=
 =?utf-8?B?cDN5N3JxbWdHZU5iSVZ5cExIcGJPWmthNVcrOUpZbXNrVXBWLzl5MFhBVFE5?=
 =?utf-8?B?VndwWjBiYjFvZ29MSk1jTklaMkxRVTl2U21BdHNyUVZWa05halVDMjlhT1ZE?=
 =?utf-8?B?R0xudGNDbXB5c2czZTUvTm5DaTRoQ3J3ZTM4M3pVUjduTXVZYkVOTi9GM2E5?=
 =?utf-8?B?Q0Z2d0d3azQ0Mk5IMzNHbEZLMmwyRzBEYkQyd1hZaU1haVlsZ3hoREZ1SUht?=
 =?utf-8?B?MXlpVTNFYk1zVTZnWjltc0w5ckMvdUh5RWVDVXNaQUcvSzd3RzdTODRoMlZx?=
 =?utf-8?B?SXVTZ05reFc1RitwM0tBQS9PNGQ0ZEhtYzRaR1JRZlJOREd5Ym9kRWozRW5s?=
 =?utf-8?B?R0xMSzBpSnYxenR0ZUlUTHd3dDFNaHQ3R01aeDZDMzhqa2phNGpLT3NVSFpB?=
 =?utf-8?B?alA1dWs0bzlLdHh6U0l0eTdHQ3RVcy9lbCs4cVppaC9kTDB2UUFOVVk2T3p0?=
 =?utf-8?B?SHFzZjR4L2FVaGFSL2dpMVphUmgzZHF6cC8xei84R2lBMjhuWFN2MTFaMDJ5?=
 =?utf-8?B?YXlQYjlBYmV5em5nV2FnQnBsYW1WZllxNDhXdEdNdkJTRlUrRnM4MXNsUHdz?=
 =?utf-8?B?aGZlS1B6Wk1iU2NWU0lMT1ljL01TMXFoRW9kTXR3K3dHc0tEdjBRdVVMZW9V?=
 =?utf-8?B?YWhybldxWTdVMkE0QUtoUzV2aUNMOFZxMzMxWDFneEZoc0NGVDFmZTZ3QVhs?=
 =?utf-8?B?bEZmZU5CK3Y5cnpFZ3B4SzFaNlRRUVhGd2MraUZZYWFMSDY5Unorc2dqNjl1?=
 =?utf-8?B?V090UjVQOENIWDVVUm1OYmtCNGtKbVAva29aNStmN3Zidld4S1QwRDVpNUc5?=
 =?utf-8?B?Y3pUdnp4aU9zSm16Q2pPOHppaGZ6Ty9YekF5SU1sRGQ2aytvK3ZHcDN5QXJZ?=
 =?utf-8?B?bFdGdHdJQjZObjVJdFU4SzBJVzJ2aTJlYWNTR0hkL3c4ejlVWWZ0TjJadmN2?=
 =?utf-8?B?eDJYVzN3TFhEOVc0aVpIcklMZnEvWi9OS3N3ZnQ5S2l3Wk8zRWZjS1JLeHhP?=
 =?utf-8?B?Mk13ZWthUm1mWTdyU2dvdjJidFVxK0JFR1k5MUxkRVdHNnp1OFZ6K1FEazE1?=
 =?utf-8?B?TzNLOHJMNi9OeDJXS2RTWmxHRWlwRElZU2FpVlRKeUwxNzQyQ3hWcnlnU0pz?=
 =?utf-8?B?TGJncWVoQUpnbHlVR0tCUVRLd3VrWklVNmpTdkI1VzVIcWtCcEVIeStDK1hT?=
 =?utf-8?B?TW5qc3FINUtEYnBhRzV5U3d3emNVWEE2K212S1Y2VlFKTVZmcGZFM1dONm1X?=
 =?utf-8?B?MjhvZUY2bWpBRFpDbEpTcTFwdlJBZGVoYVh0cHZqZ2U5aXdMYnVVdldHN0Mv?=
 =?utf-8?B?d1JlUE1yTEdXSUsvNU5xTkZoOHRBdzN3eFhtYXpSQVdWZjkwb21nL3BDOW9u?=
 =?utf-8?B?VmVrOXZSdFlHazBKSGNYWm1lVmNhWTB5eHpsZnUwcmJhNlllV2tmaURwU0x2?=
 =?utf-8?B?RlhyQXI2Ry9HSGV3UzNZNDNiYzhZYnRVOFUvd1JDR2UyWTdsY1Y2RmVDeE5i?=
 =?utf-8?B?YUJ1TEg3TENkUGlOQXl6Y2c4OEM1M2NYeHRyWFZYaHA5Zm5YQUJLcFZSUlpR?=
 =?utf-8?B?NkI4UHE1N0czMGhzUndmOTZRcEc2WTVlSzUrc2JabmF5NmEwdzVWZVdOeWVI?=
 =?utf-8?Q?583YjRJP9b98O4tdFl1imGPm/uymD4d79hbPGbpvNo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 977cb8fa-a1b0-4fcc-93a2-08d9be8523df
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:08:49.4017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KytV5VCnJ0mq6TH0J59tGdYrGS2vuqJqj5rQqcuniM/p7BAMazRIBO9lPpZsyJcV9B3MwZbvWSEk9qCTrKOtBwNDxZIUxJF5I82MnO+93a4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2257
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/10/2021 9:39 PM, Jarkko Sakkinen wrote:
> On Mon, 2021-12-06 at 13:16 -0800, Reinette Chatre wrote:
>> On 12/4/2021 2:27 PM, Jarkko Sakkinen wrote:
>>> On Sun, Dec 05, 2021 at 12:25:59AM +0200, Jarkko Sakkinen wrote:
>>>> On Wed, Dec 01, 2021 at 11:23:01AM -0800, Reinette Chatre wrote:
>>>>> === Summary ===
>>>>>
>>>>> An SGX VMA can only be created if its permissions are the same or
>>>>> weaker than the Enclave Page Cache Map (EPCM) permissions. After VMA
>>>>> creation this rule continues to be enforced by the page fault handler.
>>>>>
>>>>> With SGX2 the EPCM permissions of a page can change after VMA
>>>>> creation resulting in the VMA exceeding the EPCM permissions and the
>>>>> page fault handler incorrectly blocking access.
>>>>>
>>>>> Enable the VMA's pages to remain accessible while ensuring that
>>>>> the page table entries are installed to match the EPCM permissions
>>>>> without exceeding the VMA perms issions.
>>>>
>>>> I don't understand what the short summary means in English, and the
>>>> commit message is way too bloated to make any conclusions. It really
>>>> needs a rewrite.
>>>>
>>>> These were the questions I could not find answer for:
>>>>
>>>> 1. Why it would be by any means safe to remove a permission check?
>>
>> The permission check is redundant for SGX1 and incorrect for SGX2.
>>
>> In the current SGX1 implementation the permission check in
>> sgx_encl_load_page() is redundant because an SGX VMA can only be created
>> if its permissions are the same or weaker than the EPCM permissions.
>>
>> In SGX2 a user is able to change EPCM permissions during runtime (while
>> VMA has the memory mapped). A RW VMA may thus originally have mapped an
>> enclave page with RW EPCM permissions but since then the enclave page
>> may have its permissions changed to read-only. The VMA should still be
>> able to read those enclave pages but the check in sgx_encl_load_page()
>> will prevent that.
>>
>>>> 2. Why not re-issuing mmap()'s is unfeasible? I.e. close existing
>>>>      VMA's and mmap() new ones.
>>
>> User is not prevented from closing existing VMAs and creating new ones.
>>
>>> 3. Isn't this an API/ABI break?
>>
>> Could you please elaborate where you see the API/ABI break? The rule
>> that new VMAs cannot exceed EPCM permissions is untouched.
>>
>> Reinette
> 
> I just don't understand the description. There's a whole bunch of text
> but
> 
> It does not discuss what the patch does in low-level detail what the
> patch does, e.g. the use of vm_insert_pfn_prot(). I honestly do not
> get the story here...

vmf_insert_pfn_prot() replaces the existing call to vmf_insert_pfn().

Notice how:

vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
                           unsigned long pfn)
{
         return vmf_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot);
}

vmf_insert_pfn() is replaced with the function it would call anyway. It 
is done because the PTE being installed should no longer blindly inherit 
the VMA permission as is done in the current code, but it should also 
take the EPCM permissions into account. This is because the EPCM 
permissions can change after the VMA is created.

For example, consider a RW VMA created to map pages with RW EPCM pages.
Since SGX1 does not allow EPCM permission changes it is ok to always 
install RW PTEs to access those pages and thus vmf_insert_pfn() is 
sufficient. In SGX2 the EPCM pages may become read-only and the PTEs 
should no longer be RW. This is made possible with the call to 
vmf_insert_pfn_prot() where the protection bits for the PTE can be 
provided (so that the PTE permissions do not exceed the EPCM permissions).

Reinette


