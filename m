Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D9546AAEF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353063AbhLFVwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:52:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:24865 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351808AbhLFVwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:52:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="236152243"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="236152243"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:48:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="479277305"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 06 Dec 2021 13:48:38 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:48:38 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:48:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:48:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:48:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtH+1JWtVtRa+GvMfl57wliMc+E0wU7uELx4KEMKuq23yV7jPo84ELGArzRCWpc+sneNVV9e5nW8iieej5e23Ro2j8q9MmYlo5qixu6M+iZhGqq8QMBd47OoKd+FN++L7IlaFRejBtcE1m9hdXhe1uUNlaXTBv9oBR4w6Wkhrw5B4somZQ9mvNybhBKXmgV3wjt4gwtHZH/AhlkqGP0DZUA1nj8osNWSDu1QSiXSvd4uWhhX/RhqV1f9zB6yaRSZqLaTfAapMKjYPz43vE4M7zFU0HJg4wcQAzzOHylnZgKqLxJlZvtO+NpwlIkmlmORx+bmOT3bv11SLMEyiFEk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oNKYG2kF7KnGmEQO23yqsvKLXeLs5Zxw7p3R1nuhbM=;
 b=Nilw1x14qdUQ5mz/4aKulnLe2Gp8n8IMZzIxTqiSoWu6C0ADzauhb89Bo1WO7nGqnsbKwtad5VtfTEbrvCkb3ovBjoxqrwHv1hsvuPhLz3UK2NXFB6lfAUNhyl9OUrWfAaXFzOIUfcWI/mU486/5HOev10pT+TgaLPxu0TxOHkA6wrvCM2nEAAGR7OyfbpYUepRdAS1tQmhFXDHyd1ZFokkrU5maZlGFL8y/6VdlNKvGOPWhSMVLnV73Z9oz7hzYPwCT6yWlI4wYOKrCy5g2xR0cIAnGU9G0Z2UDy08slzRZ53A/P34pGB4wuqwIB6jHDvlp0Iqa55aayVuT1YTHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oNKYG2kF7KnGmEQO23yqsvKLXeLs5Zxw7p3R1nuhbM=;
 b=kATgx8y+CTKN040PLCBY6WJo7U/S11XERk4GY+jiizoKT0WwdvvngCim6u6gRIwXsC2FBUMw13M5v3OvfbvxcozFi1N8XHl1V7ANwQ3tM7YCF392PSYzwdYMpQ2DtrnVuMQRCtMdIGzLX8UeFypQxx8Ix0Jpz4MKmIoweNS8UoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1715.namprd11.prod.outlook.com (2603:10b6:404:49::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 21:48:36 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:48:36 +0000
Message-ID: <dc74a876-54fe-5caa-6602-8887cfe34315@intel.com>
Date:   Mon, 6 Dec 2021 13:48:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 16/25] x86/sgx: Support modifying SGX page type
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
 <c0f04a8f7e1afd9e9319bb9f283db9a3187f7abc.1638381245.git.reinette.chatre@intel.com>
 <Yav9g4+L8zg48DRf@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yav9g4+L8zg48DRf@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR2001CA0021.namprd20.prod.outlook.com
 (2603:10b6:301:15::31) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR2001CA0021.namprd20.prod.outlook.com (2603:10b6:301:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 21:48:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2811d380-fb5d-40fe-b730-08d9b90227cf
X-MS-TrafficTypeDiagnostic: BN6PR11MB1715:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1715708F3B6C98517901BA37F86D9@BN6PR11MB1715.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i1IZxsUZnoenpcvEubcQX+5W91EfdyXfmhw/z5K+FzYV2lqHH2YrQiq7j9ZmTGaS93GbODtDalNKtMLIbDj/sUBxVUhqIU6vl5BMWi0ZC4nIMUOwp7izbPDr2QDtmWrJEuqA4yJQ8jmeke+AVoVCCa/7K70hv3P1WB//Of2a/fo1JR3ci6qqv5ai7OodJqjXDjSBDYYvr5E4fbTYkeWw56wNqi/+w7iI+UWuESlbEOdbvNVht9wIMPMbpS4VvwJ/VD5dCt/rLxqmyGV06cPUZl23AKepVJ3PfQNBAulG8tDtjH/Q9ANTFirpzqbnTzr8E+A6Fid3zaLjmA+J1x65cnuLSOHJd5+yTzD/uJQ+Z2EIhmDF5fpcPxwESzAB0AbcFI5HVdKm0Gx1TozfHDEhYkli7xY9mQnFq2fU9R/kZ8bno7VdOUxWkEgSF2R8f/VNfNP7hZLWEgSMrWfTJzX9DGmEMSYi3Y2JTU1AK0tieIuKd8GtI9JufF11JHqE5sbvzd1tqsG/0IZmkEvfb1QESSiN2u6Af/aHjqfmvgv4QB40EAoi8wcfyWZInxz8Joy8YdlBxa48C4YmBOnHDKMheui0v3wlxXznkVvHOXT82A8gWKRCVBMEm7fFJ1dN1u6umVTTHQNBtVIG9wGQ5I16Ltz3EWxBsGi5SAzd8hpK7KX8/CS62MFe5HDRlyaT2nbfccJqfv7nlcwWCWDPyeCDuy6WeL7EkY1y6eCS+IyxmQII/5TsXNyFrNJPc8mAXBJN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(186003)(8676002)(16576012)(26005)(66946007)(66476007)(66556008)(956004)(8936002)(508600001)(2616005)(316002)(44832011)(83380400001)(6916009)(2906002)(82960400001)(36756003)(6486002)(31696002)(31686004)(7416002)(86362001)(38100700002)(5660300002)(6666004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXV5emJKcXVsQW56U1pNdy9RbUo2NG9QbEVEQmUrb1hybGhLaDBqODhGWkZ0?=
 =?utf-8?B?aVhRVWtMbjFCZmZXbzJ4NEg1NFAxOEcreGNDZytQMHZ0UXpqcVkvREd2NFZN?=
 =?utf-8?B?TWZDNitYNXplemRyaUozaHNZQWtnbjZiNkx2di9weVliR1VzVHRvRldhc2lu?=
 =?utf-8?B?NEFyZ24rQlkzbDJJTWxjRlcrZmthMTB2N0xnY0ZXcWZLT1pHakhSd3hZSkNp?=
 =?utf-8?B?N1hMK1RUbkdQc2YxVXBmeUU1VFY3YmZkR3VaQzJXRkI3MHdNV1NTNHliS1cw?=
 =?utf-8?B?ZFhlN25JNzM0ckVzYVhISDJyUlh1cDB6aUNZZHZkZi9EN2VqcE01T1Y4djN6?=
 =?utf-8?B?aHJmaVA5RExVZ096ZDFxY2piYXExalhaWGM4YjBrMk1QZjArUUNXUmIrbUZ1?=
 =?utf-8?B?RVNHNmJPTWRmZTFpeUxZUEViWW9qTFVyMEhtSjBBV0x6ckREcUZlUjRUTU9a?=
 =?utf-8?B?YTZXRW9hQjUzL3hvazVmak1DTHhjNTkxbVAyaFNocEJQQ3MzUmZWemlaR1pw?=
 =?utf-8?B?dm9lbklTdC9pL1pOR0pGMDRuWEFQSDRoeWRFQVdlZU1QMDltUlpxbitYUitz?=
 =?utf-8?B?cmVwZlkxUjJXRHhIVUdpNGlmc0w2Y21OdkM2Sm5yMXlTdy9BaWx0Vzc5NTJs?=
 =?utf-8?B?Y1pBS1lkRlkyNkZLZDJkcDNlUmVSTFlhNklmVlc3L1pFYzZvWlk5cHJpQ08y?=
 =?utf-8?B?WHJIcTFPbzh6WmJaSHU3RnVxN1FUN1A5SmNyZmhPbmJNd1g4TTl4ZlN4MFJI?=
 =?utf-8?B?UWFYd1k1bytsOXEzbmQ1NjJtSVdrRTRmemFtMVVEc256dkdlbTJ4akNpZ3Y2?=
 =?utf-8?B?WFBLTERoZlVoK0V2cDFsNkxjNXFzNkRGSngyQmRybCtuYlNRRnN1QmtHUTZ0?=
 =?utf-8?B?N25NOXN2NEFsN0hwUFFST0dTdU85L0o3ZHpWOS9pTnczenltejNGNzhNRUEw?=
 =?utf-8?B?QmRMMG9xKzRzdHdmR1BhOXBuTEZFckgyZEJ6SjJPSS8renNKNlB3enpPcndP?=
 =?utf-8?B?dkRXNFR0enEzVTFNWno5bXFxYmQ2UlAwaWxzaTR6QUl5MVI3d1IzdzR3dzVo?=
 =?utf-8?B?Z0xaL3hZeHF6NGo3bFdqbkViVCsrZ1luWVVrdmc4WXZPeEI4K0hGZnY4Y1Bq?=
 =?utf-8?B?S1JPdCt6T29xbjVzekRRbUtEcTBHZkJkTm1jQ05iblMzenFVaSt5Y0lOOThI?=
 =?utf-8?B?UGk2K1FzNW85WTJtMDNqTFBzcFl1YmtYcnN1MXp5aDQyOFF3aCtGanA2cGRi?=
 =?utf-8?B?RURuaE1hMlErVFNJMnlxWlZyTUlIWlZaTE1LckNkMjhyNWY2c0UrVmhPUE4y?=
 =?utf-8?B?SURrVVZyQmFUR1Q0eHZGMXU4eEp3NmxLVTNhcC9OQk9HNWdUYWM0ZXRJRGFJ?=
 =?utf-8?B?bHRpckRTL0lsZDdmdDJRRXJUWHY5RTFta3lqcWtRS2NoT2NldDBMUXFpcktR?=
 =?utf-8?B?WGl4ZGNnYjJ3L0pCMGxoZmJ1aUIrc0JNQTFHNVpPUFpTd2ppVzFvbHJMOUxB?=
 =?utf-8?B?dHlCWnFuU3JpR0FDNEw1Wk5SN0tKSU1iV21IQm5wMlBSYmQrLzZ0a21vN3JF?=
 =?utf-8?B?K1NCWE9Ld3l6MUQ4TmRwako4cTVGTHlMNzBiZkVGMDNBOVJnYTNGL1JaK3R5?=
 =?utf-8?B?dVJ4ZEZqblF5NFRYd09STE9IdEpNbzd0UHVJMWFSc3hzWXBiazJnVDlNa3ho?=
 =?utf-8?B?VkxYdGtpb0thZ0MvNG81Y2I0RGtGd0tXTUZyUzRFYU1aWE1wTzdCMjA1bi9j?=
 =?utf-8?B?UVp1cFVucXFZL0V2aXVudXE4dFhKK2NxUFBWUXI4TDBab2pJSUlDUko1cXRY?=
 =?utf-8?B?ZjF3K3VKczFxV2FqU2RuRy9wTS9jUjJNYzhCRGtFc3k1a3lZN0JBUlNXbFhG?=
 =?utf-8?B?dWNFc3huMGwrUjlvUVBHUlMxOUNjeTYvZ09XdTliTmJXcnV1Q3dRU29tbW00?=
 =?utf-8?B?RCswbFU4dXFBSXpjRHNZcVFrS2ZYQ0UxMDNYRzc5blFTTGlwSFNXZDFDTElI?=
 =?utf-8?B?TERwaFhUeG93V05rL1E1TzJHSkxmQy9iUW9MbnNYdVJDY3pzKzdwdXlXRHZw?=
 =?utf-8?B?WHdJNytIQVB3WDMvbEVGMEhmSUZlMXgwK1NvNjZGUnpKZC85V2FUUUhwdWk4?=
 =?utf-8?B?WWp1ZUJBQzFtUVNEU3pROW1qTTVaZVZ5S3gvc01yUGNBRGs2OVhsb2c0ZTM2?=
 =?utf-8?B?L2tacmN0eStvSHlhRXZKbXl2OCtOSENNR2srUkdYNzVQRE5aY2JOcUFYSE5B?=
 =?utf-8?Q?2CTudNtWUGzNZyOkZld0N7HWhT+rGdcrVKSqY37S9U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2811d380-fb5d-40fe-b730-08d9b90227cf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 21:48:36.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWN+YaUlceWA5rw66SAUP3Nppw2Qmqqvcz0aszyJ6OoVgr30gr+YlkPtHh3n6IYQdJaNWMzgl1zXxUvrvdhE0QpYcV4biLXygr4l+pp51C4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1715
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/4/2021 3:45 PM, Jarkko Sakkinen wrote:
> On Wed, Dec 01, 2021 at 11:23:14AM -0800, Reinette Chatre wrote:
>> Every enclave contains one or more Thread Control Structures (TCS). The
>> TCS contains meta-data used by the hardware to save and restore thread
>> specific information when entering/exiting the enclave. With SGX1 an
>> enclave needs to be created with enough TCSs to support the largest
>> number of threads expecting to use the enclave and enough enclave pages
>> to meet all its anticipated memory demands. In SGX1 all pages remain in
>> the enclave until the enclave is unloaded.
>>
>> Earlier changes added support for the SGX2 feature where pages can be
>> added dynamically to an initialized enclave.
> 
> Please remove this paragraph, i.e. do not tie the commit order like
> this.

Will do.

>>
>> SGX2 introduces a new function, ENCLS[EMODT], that is used to change
>> the type of an enclave page from a regular (SGX_PAGE_TYPE_REG) enclave
>> page to a TCS (SGX_PAGE_TYPE_TCS) page or change the type from a
>> regular (SGX_PAGE_TYPE_REG) or TCS (SGX_PAGE_TYPE_TCS)
>> page to a trimmed (SGX_PAGE_TYPE_TRIM) page (setting it up for later
>> removal).
>>
>> With the existing support of dynamically adding regular enclave pages
>> to an initialized enclave and changing the page type to TCS it is
>> possible to dynamically increase the number of threads supported by an
>> enclave.
>>
>> Changing the enclave page type to SGX_PAGE_TYPE_TRIM is the first step
>> of dynamically removing pages from an initialized enclave. The complete
>> page removal flow is:
>> 1) Change the type of the pages to be removed to SGX_PAGE_TYPE_TRIM
>>     using the ioctl introduced here.
>> 2) Approve the page removal by running ENCLU[EACCEPT] from within
>>     the enclave.
>> 3) Initiate actual page removal using the new ioctl introduced in the
>>     following patch.
>>
>> Support changing SGX enclave page types with a new ioctl. With this
> 
> What is "a new ioctl"? Why not just write "Add <ioctl name>""?

I do so to reduce the changes required during the ioctl naming 
discussion churn.

>> ioctl the user specifies a page range and the enclave page type to be
>> applied to all pages in the provided range. The ioctl itself can return
>> an error code based on failures encountered by the OS. It is also
>> possible for SGX specific failures to be encountered.  Add a result
>> output parameter to communicate the SGX return code. It is
>> possible for the enclave page type change request to fail on any page
>> within the provided range. Support partial success by returning
>> the number of pages that were successfully changed.
>>
>> After the page type is changed to SGX_PAGE_TYPE_TRIM the page continues
>> to be accessible from the OS perspective with page table entries and
>> internal state. The page may be moved to swap. Any invalid access
>> (any access except ENCLU[EACCEPT]) will encounter a page fault with
>> SGX flag set in error code until the page is removed. Removal of
>> trimmed enclave pages on user request will be supported in following
>> patch. Trimmed enclave pages are also removed when enclave is unloaded.
>>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> This is lacking discussion of EPCM interaction, most importanly
> .MODIFY field of an EPCM entry.

I will add that. I have the same question here as in EAUG patch - would 
you like a duplicate description in this patch and a new patch that 
introduces just the __emodt() wrapper or would you be ok with all new 
wrappers introduced together and the detailed description of their 
hardware supported flows only present in the patch that uses those wrappers?


>> ---
>>   arch/x86/include/uapi/asm/sgx.h |  19 +++
>>   arch/x86/kernel/cpu/sgx/ioctl.c | 235 ++++++++++++++++++++++++++++++++
>>   2 files changed, 254 insertions(+)
>>
>> diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
>> index 24bebc31e336..f70caccd166c 100644
>> --- a/arch/x86/include/uapi/asm/sgx.h
>> +++ b/arch/x86/include/uapi/asm/sgx.h
>> @@ -31,6 +31,8 @@ enum sgx_page_flags {
>>   	_IO(SGX_MAGIC, 0x04)
>>   #define SGX_IOC_PAGE_MODP \
>>   	_IOWR(SGX_MAGIC, 0x05, struct sgx_page_modp)
>> +#define SGX_IOC_PAGE_MODT \
>> +	_IOWR(SGX_MAGIC, 0x06, struct sgx_page_modt)
> 
> I'd suggest to change this as SGX_IOC_ENCLAVE_MODIFY_TYPE.

How about SGX_IOC_ENCLAVE_MOD_TYPE to be consistent with your earlier 
suggestion of SGX_IOC_ENCLAVE_MOD_PROTECTIONS ?

Reinette
