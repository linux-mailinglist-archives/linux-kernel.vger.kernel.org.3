Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75368467FB6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 23:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383345AbhLCWPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 17:15:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:15285 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241447AbhLCWPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 17:15:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="217753898"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="217753898"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 14:12:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="513882657"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 03 Dec 2021 14:12:25 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:12:25 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:12:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 3 Dec 2021 14:12:24 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 3 Dec 2021 14:12:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfD3WZtEFWQpui1VLic8+rvvVQEpETFICg8kpDnk/f3D3RQ3zuNip4YT+XkzXFDdlnGsp4Q1SNbl7ppAMJDBoLhpgZt+W4X2j3s0HNcqBD/8uB5dclcsQ4B3VuVUvlL9SR/FfwloqHCWfHja+BC18cCnAO33r8QdfMeojaTn7zvJjfYT6r8+8fMsLOb5xnjkDCzrwOa+7m0ivXMNxdhjc8BpmhmY5qTc3D7ETCN9sviSR+Cx0O3Cm+pCpNj4NmhMvvl/uxKriLmV6T6x981W92O0+ti2mO8t/Z+USwa9tPAjPs3bEE8E7l8Xpd3eHeC3R1ea7lwp4UdNNRS4lStOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zPzOtv1KsYhhTNZDpBHtZKYzm61AeHik3vqIwCenrs=;
 b=QCLpTCqAdngu8VmxnkpReLTDBnc9+Ya8//gXXycADfwClqX95KTU6EyWCVb1/ZXYfQoyKC9OQ7ed51/C+46Abt2hZOet/hIYscP0zfy7r+0I7PpoojFYpd0hRSFnxpyW4t9xpn6UAUDJ8Y9GATkKLmEcwAiQim6rKQ3ulx0QR9rvgqETPxELTxuINUTYYe+f4NCeV5GS50B/4lc0M9L/hvt/Fy3MZrLsHy6nlnbqb1tZ6ieL80H6afd6rpOSU98/LUOkaj7X6yz7bW68XhRPXTe+Rfb+7ivYsLQXZrK6F36bASCk7KVFrdnQ1DvRtC+BFEGezHfkJfcswjPUqoB3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zPzOtv1KsYhhTNZDpBHtZKYzm61AeHik3vqIwCenrs=;
 b=YXsRnaaG8DeBQbW6tnBCWF1Aa3wXiJFlzok4e/OguksUjTDGkiFRWRM6SdT/ea4nEk0rrqOqaqo1rWCfhJ0q+UktFmKsXSv6oAArzvdpeHfpFyfoCuXoj48zRaWhg5PJjvAGRV3bgMIfUI2w40ApJqGdiOKP8eGcKoyjRfzgwog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB4114.namprd11.prod.outlook.com (2603:10b6:405:84::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 22:12:22 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Fri, 3 Dec 2021
 22:12:22 +0000
Message-ID: <c0aab85a-f6a1-ed5c-5540-b03778ffe24a@intel.com>
Date:   Fri, 3 Dec 2021 14:12:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>, <dave.hansen@linux.intel.com>,
        <jarkko@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
        <mingo@redhat.com>, <linux-sgx@vger.kernel.org>, <x86@kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
 <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0248.namprd04.prod.outlook.com
 (2603:10b6:303:88::13) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR04CA0248.namprd04.prod.outlook.com (2603:10b6:303:88::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Fri, 3 Dec 2021 22:12:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f7fd571-b773-472d-888f-08d9b6a9faa2
X-MS-TrafficTypeDiagnostic: BN6PR11MB4114:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB4114D5AC978C4A65644E0007F86A9@BN6PR11MB4114.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXabfK+WGeuanW7AsmQi/sCx8OmUoag9XJZuEa6COBHwJnjyp3/1rFGNCLnWk3I+ZduM2ucFpVJYeXu8YRybm95H1S2rRnV5RySKVTgXE+pHfgu6nT44bjthYxI2zKFlw60jLXI17JoDlVopbFr9BG+ghdGaE29g5F0DP2kahi0OSa0d5Xek4StCMEzAQHUSDFig4iimx/uqr2DZ7Hv5HAAmQb3kTot3yQnwIbMgnrVu4fB3u+S/ApZXRGMwWT2uYGrTmlsUj+9g+BNa3j8c+KDcEIcDTmbG4TRCFY1g0Bk7tm8EbzaPmsRT+T08m3xLRgUqdR2A/TtkNfDZ5ko6xLLYGzTFrsZI8bXjDBLt5bqu4en9WYvIs3jJDQnYfVEffUlEPOVnlDr6JFtSAwH3FSq2uyXm423TaddPKpOT7+rZh7fModSwywqAFppfaMswnLXAnxhi99npNlYqapkch8uzuOxcwDbRmI0gPyrtykSBwVlP0TRCM3UWsHqcDwMdsVYZLjrBNWY5dLJzW/DtqkAMxPu1R1xlRCvYkBdP9F1lfqgXEV4OZztsbY4MEm0iLbABHlZTrAtgSBspF8RhJizLoMkDpp7hLv8jOV5ofI+v00KDvPOqRRDqvFcyzwAI8obBG0BEjld5k77654LYRy5s7gVbA+LDlNM+QEswMKTOGiQ15pXI81WgZWAhicfCWHthFPI+3wEEn+vpacpuEkhVc3kJ8V2x5ZJdnqLeOf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(6666004)(8936002)(66946007)(38100700002)(5660300002)(66556008)(31686004)(2616005)(44832011)(83380400001)(31696002)(8676002)(66476007)(53546011)(36756003)(6486002)(16576012)(4326008)(2906002)(316002)(186003)(508600001)(26005)(86362001)(956004)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmpTUzdMamZ6RWU4L3g2V0JXaFVkUnJHRll4VkhzMmdSU1B2ZXhzY1phS0o0?=
 =?utf-8?B?ZGZpSWg1MTJnUElGKy83TFYrbXRXVHpWOGYzMnN6SFBtcHJzMllZdC9qK2RP?=
 =?utf-8?B?NWkwTnlwNWlxVG0wWXhVQytia2FCUC9lZTMzeDRZZ0RtVWlqbU9wNGxoeFhD?=
 =?utf-8?B?UExIcHpOYVJ5WnBiOTY5MGxPaDNobndLTzh6WUlkT3pidkFlQVNVVWtPaGJi?=
 =?utf-8?B?TkZmZytyOXg3dTl2OFcvN2ZYRE1XRFVHTXNqNmFmQXZaT2daV1NuNUxFSkRI?=
 =?utf-8?B?Q3dZNUkyMFdvdllYK2tmbC9PdDJ1Wm90MU12ZWthWm1VenVScmlXVWdYQnF2?=
 =?utf-8?B?M1hGUnZDZVlVTkQ4NCswQ3BxSjQ0TUdYL1lrMWtRbWUzSXFwby82MGxGbGNx?=
 =?utf-8?B?QTM1cmU4V3ZtcFhwNG1NYmNIL0M0UjdldkEyTlVrajhGRGdyM1FxWUgrRktM?=
 =?utf-8?B?cjBTcTNnSFVtNTk4eHBFMGp1UmNUS3crUC8zREUwOEFRbzVTbXFFMGVLc214?=
 =?utf-8?B?cktYRUNCd0MvQnJMRVovaU0xaWZrM2pWbGtTWDVYR2l3dXJQQzc1anBHQk9K?=
 =?utf-8?B?QXdKdUI0ZWFGaEdCeG5wQS85VkNaQ0d2bFJzSmxseGNKclRGR2MxSHVQam1n?=
 =?utf-8?B?N3M2UCtWajhoaXVNcitXbUorTnhyb2RoZm9lZ20wWUhoaDdHckpYYUZpOWEr?=
 =?utf-8?B?aVFtOWFzL3ZEcmhqajZScnIzVUFLcFlLU2NGQ1JmUmp4dGNEL0hpSTBlb0xm?=
 =?utf-8?B?SjhDOERkQ1Z4bnpKZlRkbDdLaVlBdjVUNXREUFpQWC9PcnVoN1RPNnVaWFZI?=
 =?utf-8?B?aFkxcGdYcjFmTzFxVXpRWWtiNmI1YUVHamdqbEs4RE9HR0c2bUg5L2RMd3NO?=
 =?utf-8?B?QldyYU1GR2Z2WEZNbjZ2WU5haGF3NW85OTBRcUQxcjE0RVFNWG9uYityVVVx?=
 =?utf-8?B?OTFKUmJMc3ZkRWgxdzAyeXVYdzlhNWUvckphNk1yMTI4czBCcTRBL0JkUjNF?=
 =?utf-8?B?TUs0Wlh6M2NQNVQ5RUt1d1dpaGJ2V0tJMEtoeHc0SWxKY3BYMkd4bENBT3la?=
 =?utf-8?B?Mk82dytndnYwNWp6UEhkOFBwWi9pODFPQzZKTFVyOFBjYmdSRUZaMXZFQ1A2?=
 =?utf-8?B?UzhSd01xK1FBVUswZXEzSXFZQ0h0aVRaQlZaSVJsQnhzaGNZVk9Ua2J0VWYv?=
 =?utf-8?B?NG9HcjdpVnFrUHZWcHBWSFF5dzlwaG9YNmw0RFRwNUxaMGxyOUg5OVJkSjhn?=
 =?utf-8?B?TjN5R0YxUGN1L3VWaEk2dGoxSk8zMDFCTWRnLzdEeWE3MStPNGVDd1c5UjN6?=
 =?utf-8?B?U0FZYWJVSUFnTG8zdmp5TDNHcSsrOTBCT1lESUhXT0I5NnkwTXhRdzl3eDJv?=
 =?utf-8?B?MFI1alNHbG9zUlJQNlpKOGRwN0p1eGVkYmJ1K1ZKeVA2MjlKcGhuUHlUWmE0?=
 =?utf-8?B?WWJCWnBWT3hGRFlNSjNyWEZ3VXE3Q0dzTHZkU0ljd085eFJ5SGdnQnNlbUV4?=
 =?utf-8?B?YWh3UVJNbXV3Y3pQZVpsWnZZWjU5QUVkRThpM0tQUXFONDlhT3A1OENsR0d3?=
 =?utf-8?B?eWh4MFJSdW93bmpsc3h0UUtJcXphckZSbkRjSWI4c0o0aGhNYVdHQlFMYktR?=
 =?utf-8?B?bFVzVEhzemRudnRlejIxTHdoS2lZV3BmNENvaDBnQmJ5MU10OXlDUng1dk1r?=
 =?utf-8?B?dzJ0V0ZmUENsUWk3KzVMYk1JNjczanZ6RUxkb3B1VjdhRHQxNEFKaXpTY0Zw?=
 =?utf-8?B?NG53b0c2TjlxWkhwR0F1ZzhJZFgveEJBdE9qWjIxczdEeTdiUHYvTW5PNENy?=
 =?utf-8?B?N0Y4U2xhTTRVMVZJbHJLNkNMaG1jVTNkVnF3R2hxWlZNVUg0UC9MckRnRnpu?=
 =?utf-8?B?RWZHV01EQWVzVjdGYXRVTFFFenF0ZlVVVkxKTGhlM0JnL1hNUHRtQnRrWGYw?=
 =?utf-8?B?RmZpZ250WFNkdk5UT1RyalNXNjlsREVWS25XTG85UGJVM09ETGtTRnBKMmNK?=
 =?utf-8?B?TEJpa3VVQ2Z1cW5zR0dYd2pGclFNL2UwbTJid1BHYmwzblhpbXk1MlM2aS9z?=
 =?utf-8?B?N25HQiswa2Y4c2wrUjRKT2tnTjlnN1MzOEFJZUFmT0pqK01tUms4UW9NSzVK?=
 =?utf-8?B?UUo1aWRGM2xERkVtRmxLT1o0aXloQzdLZ0d6Qy9oWkxPbkwxMTgvOXpXS1RO?=
 =?utf-8?B?b3AxekhERkI3c3hVOUN0OHBnNldIS2tuUVdScEUyRXVHNGxnRWpIcXk2SkM2?=
 =?utf-8?Q?KhUpovZyYAZiR1O1fwBKbRMf2GeYtO3wg0emzfZvQ4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7fd571-b773-472d-888f-08d9b6a9faa2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:12:22.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsYO68rZiG0Tn4RA5xmSdsG770dqlaZ2ScbL8q19V6n+w9rNCDc7DQmZH1oklBiVJgCvysdCel2MATuu84Biiqj8yStQQ93jKZqbXBYUdHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4114
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 12/3/2021 11:28 AM, Andy Lutomirski wrote:
> On 12/1/21 11:23, Reinette Chatre wrote:
>> Enclave creators declare their paging permission intent at the time
>> the pages are added to the enclave. These paging permissions are
>> vetted when pages are added to the enclave and stashed off
>> (in sgx_encl_page->vm_max_prot_bits) for later comparison with
>> enclave PTEs.
>>
> 
> I'm a bit confused here. ENCLU[EMODPE] allows the enclave to change the 
> EPCM permission bits however it likes with no oversight from the kernel. 
>   So we end up with a whole bunch of permission masks:

Before jumping to the permission masks I would like to step back and 
just confirm the context. We need to consider the following three 
permissions:

EPCM permissions: the enclave page permissions maintained in the SGX 
hardware. The OS is constrained here in that it cannot query the current 
EPCM permissions. Even so, the OS needs to ensure PTEs are installed 
appropriately (we do not want a RW PTE for a read-only enclave page) and 
thus the OS keeps its own record of EPCM permissions to support this.
As you note later even in current kernel the enclave can change these 
permissions without OS knowing. EPCM permissions can only be relaxed 
without the OS knowledge though so the OS record of EPCM permissions can 
only ever be stricter than the actual EPCM permissions.

VMA permissions: Current behavior (not changed in this series) is that 
the OS enforces that a new VMA should have the same or weaker 
permissions than the EPCM permissions.

Page table entries: These should match the EPCM permissions without 
exceeding VMA permissions.

> The PTE: controlled by complex kernel policy
> 
> The VMA: with your series, this is entirely controlled by userspace.  I 
> think I'm fine with that.
> 
> vm_max_prot_bits: populated from secinfo at setup time, unless I missed 
> something that changes it later.  Maybe I'm confused or missed something 
> in one of the patches,

Yes, vm_max_prot_bits is currently and continues to be populated from 
secinfo for pages added before the enclave is initialized and in a later 
patch it would be hardcoded to RW for pages that are added after the 
enclave is initialized.  In the current implementation vm_max_prot_bits 
is the OS's record of the EPCM permissions used to guide VMA and PTE 
permissions.

On a higher level, the implementation decision is that vm_max_prot_bits 
is the static "vetted" permissions of a page - the maximum permissions a 
page is allowed to have during its entire lifetime. This matches the 
current implementation. In the current implementation permissions are 
only able to change via VMA and PTE ... for example a read-only VMA can 
access an enclave page with vm_max_prot_bits of RW. With the SGX2 
support permission changes are allowed to EPCM permissions - but in this 
implementation they are not allowed to exceed the originally vetted 
vm_max_prot_bits.

In this SGX2 implementation an enclave page could thus be added to an 
enclave with secinfo and vm_max_prot_bits of RW that would only allow 
that page to have R or RW permissions (VMA, PTE, and OS view of EPCM 
permissions) in its lifetime, never RX or RWX. Yes, it may be possible 
for the enclave to change the EPCM permissions from within the enclave 
using ENCLU[EMODPE] but to access the page the enclave would need the OS 
to install the appropriate PTE and the OS would not do so if 
vm_max_prot_bits does not allow it. Neither would the OS allow an 
executable VMA.

> 
> vm_run_prot_bits: populated from some combination of ioctls.  I'm 
> entirely lost as to what this is for.

With SGX2 it is possible to change the EPCM permissions of an enclave 
page after the enclave is initialized. vm_max_prot_bits would provide 
guidance to what permissions a page is allowed to have while 
vm_run_prot_bits contains the current view of EPCM permissions used by 
the OS to guide whether requested VMA permissions are allowed and guide 
what PTE permissions should be.

Consider this example how vm_max_prot_bits and vm_run_prot_bits are used:

(1) Add enclave page with secinfo of RW to uninitialized enclave
     vm_max_prot_bits = RW
     vm_run_prot_bits = RW

(2) User space runs SGX_IOC_PAGE_MODP to change the permissions to read-
     only. This is allowed because vm_max_prot_bits = RW. Now:
     vm_max_prot_bits = RW
     vm_run_prot_bits = R

     Now VMAs are created and PTEs installed based on value of
     vm_run_prot_bits - write access will not be allowed.

(3) User space runs SGX_IOC_PAGE_MODP to change the permissions to RX.
     This will be denied because vm_max_prot_bits = RW.

(3) User space runs SGX_IOC_PAGE_MODP to change the permissions to RW.
     This will be allowed because vm_max_prot_bits = RW.

     Now VMAs are created and PTEs installed based on value of
     vm_run_prot_bits - write access will again be allowed.

> 
> EPCM bits: controlled by the guest.  basically useless for any host 
> purpose on SGX2 hardware (with or without kernel support -- the enclave 
> can do ENCLU[EMODPE] whether we like it or not, even on old kernels)

Indeed - permissions can only be relaxed without the OS knowledge so the 
OS's view would always be the same or stricter than the enclave.

> So I guess I don't understand the purpose of this patch    or of the 
> rules in the later patches, and I feel like this is getting more 
> complicated than makes sense.
> 
> 
> Could we perhaps make vm_max_prot_bits dynamic or at least controllable 
> in some useful way?  My initial proposal (years ago) was for 
> vm_max_prot_bits to be *separately* configured at initial load time 
> instead of being inferred from secinfo with the intent being that the 
> user untrusted runtime would set it appropriately.  I have no problem 
> with allowing runtime changes as long as the security policy makes sense 
> and it's kept consistent with PTEs.

This SGX2 enabling indeed builds on the current implementation where 
vm_max_prot_bits is inferred from secinfo. The intent is for 
vm_max_prot_bits to reflect the maximum allowed vetted permissions.

At this time vm_max_prot_bits is indeed static and thus creates the need 
for (dynamic) vm_run_prot_bits that reflects the current EPCM 
permissions and guides VMA and PTE permissions while vm_max_prot_bits 
guides new permission requests. From what I understand this 
implementation follows the current security policy - permissions are 
never allowed to exceed the originally vetted permissions. PTEs are kept 
consistent in that they match the (vetted, OS view of) EPCM permissions.

> Also, I think we need a changelog message or, even better, actual docs 
> in kernel, explaining the actual final set of rules and invariants for 
> all these masks.

I will add a section to Documentation/x86/sgx.rst.

Reinette

