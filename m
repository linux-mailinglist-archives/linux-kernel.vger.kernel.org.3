Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0576E47373E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbhLMWKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:10:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:41032 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234935AbhLMWK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639433426; x=1670969426;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xdrp5+aRYgCVsOpa3h+qmCkf5HkdIlL8ne5RfAY18SE=;
  b=fDr+BuUOv9Xp1++dNjk5yJk0ht7pCIMQ8ROXGVeuDkr/fgaYX32B9KGM
   VrBfV3TK9kghbIDBOrVfsMWN/C906KJO666iYHrumZH2jHoKQ7F6Kr8Mx
   nVXIxuKOdxY2SLie79hoYV25DNy02VKBESYoQmVdG/copeX/kXf/pmXC4
   6kvMpf7suy0WN0IREbgKnA5q9meclutAMKf5gyashJjRCDUOtXjuAsczy
   aU22U4T5JWKfU/G4nfAzkb0Z6Nhj2iGIZ+5F83rPOrTs456HWei600112
   uuhZ9+ZMVl+ySKtxuGF8e7H7Rz2lvgpQeQp1eQ+riCey/44/qC5JPptdL
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="236371747"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="236371747"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 14:10:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="481674516"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 13 Dec 2021 14:10:25 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 14:10:25 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 13 Dec 2021 14:10:25 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 13 Dec 2021 14:10:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1XRp6hShDbzgzU22jWX0G0t3yJyRzgg7HOYGZA77zUD9SuU6ZQ3/ZuVcUzrsB3VU4335mjhVo9nKLupnHJVdT/u179em0YSD5f20d6DAl6OB8UcIyZ4H53DRLaQAmWFf3tuYb49bJUzWFQp8Qm+qsxHvoM8/dQFX+nbz/GMVfud9TAvYCs/nN2HJpiLJwjqbrCo8KDzo48UaEPqgpAfyQ+bBjdFDXM1FtSBr9G7YoPNfvBSR+GVHedM7Vt54YwSyRB24nd+IGJKlHZYION1rjVCVv7M2k6KjKTB1L18lSjbLHtlXbKr+bM5A07X/ZLsZayRtroBWYQXeyDUh7tPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjdr3IspChwm6ZOCtvsrWkb9MmcYVBjGEKglbfISMvQ=;
 b=GuZQRJI/oGgg7NGO6P/MljN448Ju5Vn0LLWrn4Ce/pIIMvbb69SOwsL32vkuXhAFp6KiD/XnU2Q1nTH5RztJ9dqjjuoZpKx0P2P2WVA1EAvEZDqzuyBCARXsv3lhK1unGXWgfjp7wMmUkb9Nvijx0BtjhCODv/HUEG/b3UHkycPYImUWwq/98Ie3ggJc4zrhuraZ14oem9kIw5dJ0jythqtfC3FSDK/WFuidB6PRsrnv18/EBnZsF6s2JJqc1G4PjuGPbQBO629x5Zjrjrw6WjHCErA6Eui1GgLljpDTX+3ClV3c9CIYMRTc8iKJnlxefu7fGh1aeLC1AcMHgVnj9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjdr3IspChwm6ZOCtvsrWkb9MmcYVBjGEKglbfISMvQ=;
 b=QOCdnWODqff9KO9QL4g6TAw+BhUkRQUgQU/W1d1/c0ErUDroz3v7IkzRA06KCcJdq5CI3Lbv9XZprQefqDuwk8FLFBJt5CgYHTDXyJnycwlqJyMGK2cSL0jopw8HfkI0eHm7mzbSxfO6Dj12wBmnMy5HyxwJLvfACj4qHGKVPSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2737.namprd11.prod.outlook.com (2603:10b6:406:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 22:10:22 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 22:10:22 +0000
Message-ID: <f6a55943-13ef-41ef-609a-6406cffef513@intel.com>
Date:   Mon, 13 Dec 2021 14:10:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <mingo@redhat.com>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
 <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org> <YawAWmodeNaUbzV8@iki.fi>
 <a1b14f33-5142-8cab-3b5f-4cc79b62091e@intel.com>
 <a24bc46e4ba8a69938a7f73012019ce0f61005c2.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <a24bc46e4ba8a69938a7f73012019ce0f61005c2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:104:4::33) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eda6098d-17e0-41a6-a8dd-08d9be855b36
X-MS-TrafficTypeDiagnostic: BN7PR11MB2737:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB273703C19320A6CCF51C504DF8749@BN7PR11MB2737.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JxTUAwhFipI7HIMZrJGf57C6jDlp/83cuFLzWBIv7nIr0rPAGvwt8UtoshVPvXPuba4ZW0HF/k6paNzb2Q2t9BHheeCKH99y4y+lpdf7hfA7oIaN19grLllJiWztWQkzMN3KRVF0U2XaL5T8C4R8AB5d2v6S4DyL6kOgRyfEMnrKdDxJJFetWliXhirNz3uSPBHi4n9Syf3DCwMIwSLE1hVoDyNoenAR4aNizxnOsx1On1Q8IMIoMs1z8z28VmfF/v91tetkN/twdefOOiLFU0LJyN++R5vhrwhN0Y4tNGgIiUa+dV5Cjq3oBbSx0uwqf9/fg+p7ptME8JP2mvTIf9ZJILKi/GJTZpPOK/CkGBFrYv+8X0kyAtWCIJ/nve/GWbDeMA9rcaK5YFNU5nabmwrdMTglgqLI2j0Nl2N85T4b8yICpd8WCt7P2pxiK8b0bys1GAhb36v+T0OB7ZKdihIEzPayAR4CQ0d73XXyNVsIUVlMgGFSIvabDlxoTR44xg6NE8FFdG1uDy2a0k2Gpu26StjWdEhpZBWxaznnEiJI8RmRw0ymotAblNb1A8lpZcCFTuDW/WABRy5UxiykAUkKMbcdekbF2nXYTrtAAxCyxYw96XLfttlA4DH+6lbeI6FwZv/hzjSooAxFlUsn2DRjAygFfb8TJrslU/p7HGTOkj00O3KAUGRGOWCCDO98bE9OgOOKg/w2Cc6xaZYqyHb4oeslGWfLqfEII8Fhilk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(86362001)(2906002)(186003)(44832011)(6486002)(38100700002)(6512007)(83380400001)(110136005)(8676002)(8936002)(36756003)(508600001)(31696002)(66946007)(53546011)(5660300002)(2616005)(66476007)(66556008)(4326008)(316002)(31686004)(7416002)(6506007)(26005)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1pvRVZkMUV0a0VoT2QxYmE5RWQzbEFhbW9VNWp6UHFObTBWdUNPMjlpemN3?=
 =?utf-8?B?dkhuald4ZFczZHMxemRWNEpXcFY2a2ZXeVB3bGg1SVl0WXJPNUNsNFU1QVpR?=
 =?utf-8?B?MDJGbWZzR0tFSmJERUNJZ1VMc0UvVXoxMTRra3pnekFwMmo3ZU5CeXFiZXpZ?=
 =?utf-8?B?Vm1Wc3RBZ1lNL1hVVDJyNlVBeldxNWZjbkczSU5rTzkwL09NNEI3dDNEcjVF?=
 =?utf-8?B?d1p3ZFNhTjNQdzcyWmVwaFpxOXFiOHJHZ05paHVFb1BSRWRBQlVoNHZLczBF?=
 =?utf-8?B?UTljdVprNUZGUGZSRGRyb29iN1IwUlN5azJWNmcrZm9CemZwZTRGNU50MWtN?=
 =?utf-8?B?MUl0eGZhL2NYVnRtWlMwREpWOEVSWjI5eXFxTE5OT0NhS25uNjhnN0wvMmZC?=
 =?utf-8?B?VEEwaVVHU2cxaGxmTnJSTU9yOXhQWDh0S0pra2trT09rejhVZi9pS3VMUHh6?=
 =?utf-8?B?VkEyYVh5U3lzRkd4bzZlTHVRU05uNVQzQnJYMjlRVjRWcnhNL09JMHF0bjJI?=
 =?utf-8?B?WUlveGxVQTJUMkpLZStLck9RSDBqendVZ213TytBTVVqMUNta1BEbkllREZ4?=
 =?utf-8?B?SU5wcHZXRHVOVEowSS9BZHJjSlFqRTVpaCtuOGwvaFBaWDZ2M2VJZDBWY1pX?=
 =?utf-8?B?M0diZVR2S3AyckgzbDhGUmVkUUx1TXliSmhrejgxVVZyby9yVGQ5NDFQTFE0?=
 =?utf-8?B?Lzh2NWNzM0kxOHllbldDWnlUNXVuNUUybC9FWEQzYXdUV2l4V29EOXVQY0V4?=
 =?utf-8?B?bnhFOXB5MXNmWTNLRkhqeGIrRUVDQTdUUmVSZy91MjZFZVVyNGQyQlo1YzlF?=
 =?utf-8?B?ak1FMlNILzhEVE1kVHRyN3M3VGcvYm1kbGdSYXNPQW1pKzc5aXFNczNnS3pB?=
 =?utf-8?B?QUdGOWpnSFUwMndJcUcrUmJoY3doQzFRODdmSHNpYURjclVicVRrYTkzTm9L?=
 =?utf-8?B?amc3R3d0L1lmZERoVFZrci9xMHVIdDNtM3pUaW5CNGNOUyt0L1Y4Q1BSaUk4?=
 =?utf-8?B?UzVUazF0V1J1ZHA1OVpvL3ZsRFJHMXJmMXBFalVxcjFHWk1SZkpxMjRESXR1?=
 =?utf-8?B?TjdqMVZHY2UzdjZMWVN1SmFZN2hRdisvZzRtaDIxTkxsb3pud3ZuNldZbCtl?=
 =?utf-8?B?Y0U3b1U1YkpzZThTWHBsVTZqcXRJblZ6bFNjK21tRXZIdXduZHVKdmhPeEx3?=
 =?utf-8?B?M3FNRnhVZmNSM29pczZNSjM2NkxQckRpUVozOEtDd05MTjRYWUdQdXV3RG85?=
 =?utf-8?B?MXJVSWF6TU83Y1hKQnVjWTdIU21LK0FucGNyZjg4TVErNmwzRE1JRnRoL3lX?=
 =?utf-8?B?R2Jsc1lndjZUTmJvSGtnV25OcTVGbUswbW1qRkI3SGJVUjdDeXdJTVJUS2I2?=
 =?utf-8?B?dGY3aXJKUHQ1WDJxT0l3SW51eU9xNUFKbFBiaTRza3BBbit0blFQSE56U2E0?=
 =?utf-8?B?eXZONHFWVnlTTlc3YU1mNmErTk9Kb3BuT1lacEV5T0FaM2lIUE1mWXkwOGZl?=
 =?utf-8?B?dVRTSXZiQ2pFZXNvVVdPc1FTeE9wM05TeGlWcGVueUdqUUdFWStYTEZCcW82?=
 =?utf-8?B?bU9sbWJ5b2xXOUpqK1Azbk55ck5BS1BHcVA5Qlc2UG5Tcjltbkgzc09SREdE?=
 =?utf-8?B?b1B5bmFsSlBiZHRyaUcrejFnUVZERnRQUDIySDUveHlEcnc5R2VmZzBhWHhr?=
 =?utf-8?B?dlk0QWFHVVpxTWNJMDdZeDc3NUZtNHR6WmhGUXRIT3hrMXJOa1ZkYzl4LzhL?=
 =?utf-8?B?b0taZ0pOZnR2Tkc5TnJ3Q0YyY0pFRlF0bFd1V29HTGNpeHU3SUVVVTYrODlK?=
 =?utf-8?B?WXIxRlRxc28wUEJiRmFjSG00bjNaSDVVY2RvSEh1ZzhsZmNkenRxRG5MMGts?=
 =?utf-8?B?ZlFsSkVFZDVqVUppOFd1UEx5SWM1Z3pyRzJMK0F4ZDg0UjluMU5BM25Tcjd3?=
 =?utf-8?B?QnYvdnlwNU5UajVVdlNrMjl1c0ZVZFk5VDJCc3NFeG9xQ1dNMSt3dXI5R0NT?=
 =?utf-8?B?b1htQ1RGK3YraDhBakZ0V3o4dFJUcXlyaEQ0OVZOZCs3Yzlic0xGbjlIV1FL?=
 =?utf-8?B?cEdlVXFEcTRFcGVLMWVDRHhHWXZpQU04QWFaS2ovMU1rRUJLUTFyTHYzVjMz?=
 =?utf-8?B?MFZiZmJJVWNmeDF0cFBLVGEwL09MbUVSY2d6T25zejgxUml1VlpldmN4YytO?=
 =?utf-8?B?TkVGQ29VUDA3Zy9pVWpvdzg0SjIxZ29WaElHazk3Q1pBUUUzVXVObm9pcnF1?=
 =?utf-8?Q?5G1cV2XxAzcLOpr4KveGr9s/KC7hgoW3V6DS8/NU/k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eda6098d-17e0-41a6-a8dd-08d9be855b36
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:10:22.2610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkLfUtkgk7YJVr7CpCsO7k7Wx3QYPfuJeWByYCknNSCGHaltukmHxvRIADAXovCOsTSCU52g3JhYdj1sO9N5mrzzxeqGSki45XTORfG2oXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2737
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/10/2021 11:42 PM, Jarkko Sakkinen wrote:
> On Mon, 2021-12-06 at 13:20 -0800, Reinette Chatre wrote:
>>> This is a valid question. Since EMODPE exists why not just make things for
>>> EMODPE, and ignore EMODPR altogether?
>>>
>>
>> I believe that we should support the best practice of principle of least
>> privilege - once a page no longer needs a particular permission there
>> should be a way to remove it (the unneeded permission).
> 
> What if EMODPR was not used at all, since EMODPE is there anyway?

EMODPR and EMODPE are not equivalent.

EMODPE can only be used to "extend"/relax permissions while EMODPR can 
only be used to restrict permissions.

Notice in the EMODPE instruction reference of the SDM:

(* Update EPCM permissions *)
EPCM(DS:RCX).R := EPCM(DS:RCX).R | SCRATCH_SECINFO.FLAGS.R;
EPCM(DS:RCX).W := EPCM(DS:RCX).W | SCRATCH_SECINFO.FLAGS.W;
EPCM(DS:RCX).X := EPCM(DS:RCX).X | SCRATCH_SECINFO.FLAGS.X;

So, when using EMODPE it is only possible to add permissions, not remove 
permissions.

If a user wants to remove permissions from an EPCM page it is only 
possible when using EMODPR. Notice in its instruction reference found in 
the SDM how it in turn can only be used to restrict permissions:

(* Update EPCM permissions *)
EPCM(DS:RCX).R := EPCM(DS:RCX).R & SCRATCH_SECINFO.FLAGS.R;
EPCM(DS:RCX).W := EPCM(DS:RCX).W & SCRATCH_SECINFO.FLAGS.W;
EPCM(DS:RCX).X := EPCM(DS:RCX).X & SCRATCH_SECINFO.FLAGS.X;

> This could be achieved e.g. by having ioctl to change protection
> bits in encl->page_tree.
> 
> This would simplify things a lot given that there would be only
> two, instead of three, EACCEPT code paths.

Reinette
