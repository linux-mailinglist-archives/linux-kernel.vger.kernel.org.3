Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DB7467D1F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382531AbhLCSWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:22:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:65350 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234843AbhLCSWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:22:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="236970335"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="236970335"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 10:18:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="541706743"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 03 Dec 2021 10:18:46 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 10:18:46 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 10:18:45 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 3 Dec 2021 10:18:45 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 3 Dec 2021 10:18:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wtkxxoc6yz8j8HH7QVy2lvXsg/di6z0IlPDiRM3297n9rjRyL3Kr9scsgI+uaLt0UzmEkWWvRjneotpQmRZkmKemREZujGsMbqIzjPl8Pw+zRjcWuSI3cXRUAc9k1ZGL3sjnPCyXtUbsxYVokJUTLUfU1rDuC17EOhmYUt1Id1c5sJnZlJmTBtD80U91cvXBG816j034O/ysIFP+7VERsrO+gCUQUK8vb+xbwazuU3uuYq/h2pykAkxqSYuQLGx3RVqUhAYS3tx002ftnRdwqV5RxZRPV89xiz78KoQlZhMrhR8tbmw1wbgaikqzNTZ+Z/ldQuRB69CK0nq6oj/SOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jh10JGv9Oydi0x6d30kjlpwtOz+wLUZVe8DKpVGtVV0=;
 b=dQdT0Y+2Pvu8cCX5G3UEotgo390lVm6bHgy7Kn0eV9wjGfRXNEWHdKHGExwpe+HZJ7MbKLUJI3uHND5Kyu0LZvWgZGXj/omWDxopBtIK2RajVIj5l5S3CKssI4gsQQ3/tVKy38hhSzG8AoRTWtA1X179tr4HuaNR2XwALRJuYp/5K3rQY7GaX0ws//97MwJc5NqWxLo8hW5pFv4QbwKi1R+xpSJjYK9kcPwsolAKk66EcESyuEHozVWRepl6aEjQ1qySgmEv6X/Px7guuVbv78oFj7CwNSSmpcQpuqQzVqEVWEoFVETNVvBJj5tKKtSDnEwBpzJln5bxFx2moefYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jh10JGv9Oydi0x6d30kjlpwtOz+wLUZVe8DKpVGtVV0=;
 b=HDQyCBaPr66v09a3XxaICF/aqN0vDuqu92F5Q1B4SgXvpbDqNjm8LxcHLsobpF7xMWjpvP6E9+APb5i4vHbmzXKoVGgcnehwcRFA6hHfY1VszLCHfJAkOf7creHAZ9qAzUe+2FdGVQvoq4coAFxpoIX923+6G13Zb8YEVKFoW4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN8PR11MB3554.namprd11.prod.outlook.com (2603:10b6:408:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Fri, 3 Dec
 2021 18:18:37 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Fri, 3 Dec 2021
 18:18:37 +0000
Message-ID: <18a4a859-7175-48b4-e792-076014db775c@intel.com>
Date:   Fri, 3 Dec 2021 10:18:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
From:   Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH 10/25] x86/sgx: Support enclave page permission changes
To:     Dave Hansen <dave.hansen@intel.com>, <dave.hansen@linux.intel.com>,
        <jarkko@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
        <luto@kernel.org>, <mingo@redhat.com>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <44fe170cfd855760857660b9f56cae8c4747cc15.1638381245.git.reinette.chatre@intel.com>
 <d78eb8b6-86ed-f39a-63a1-38785ea92a50@intel.com>
Content-Language: en-US
In-Reply-To: <d78eb8b6-86ed-f39a-63a1-38785ea92a50@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0001.namprd14.prod.outlook.com
 (2603:10b6:300:ae::11) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR14CA0001.namprd14.prod.outlook.com (2603:10b6:300:ae::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Fri, 3 Dec 2021 18:18:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df669442-bf91-42d5-5767-08d9b689532f
X-MS-TrafficTypeDiagnostic: BN8PR11MB3554:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR11MB35544CF62C7FC0530DEF2E69F86A9@BN8PR11MB3554.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HpATseaoE+1USzAX27d3X3e7TWogLAWOAUyDu53KPfUwCkPhp3QkQUJznsjusYINhwFeONA41zXmv7Wh45ZJ1AFUANCtwxWqLU6neswA7dzvwkIMZadRa15z/qL3U2Mlk5GR71WhJGZA6hEB5kaxtLwdJQEbBb3W1BWJ5l3Bbxuupr6jeeG6taqlXcy13sur/WNi/gCJbRbYm7l/E8haMkFyRA9y/7cBgcJ/QTQeCvRHBHkMdnHuKeH8EbcB8GX4Cj/HTnXVhKn4fKkE9qZ/mcSfniHtlDwEIuHDZ/+pI1YiRZsl7fJYDsYeqPwHeEBRyX5RpZaAU/bAYzIo+m8p/tCgdXpJ8GP8BtYiJ0EdDsm+pdVL09NEeYa2WCFHmP2DvdsxSxvUQ7Txw60Y32kryKr9rdgLvxQiM1l1WCQNadh8q6gTPkS4RmkF4wNHzmjxPGMSmZx0W9Gf1+R5Z/0pr1Jf6sXJKKbQslcA5sdvpoCNhIRxMM3r6JPRmVxhGfaTHMlJR1EDAi+EMLniqrr21O/I4njio6DXUDs8T1NsfhoD+lESHzCwyKBcMoq0IJUkHbidZBkmiHsAxsq9fDKC8wpkMEKWCXuEVRGGBlvArF5Xzz2766Mhnr4S54rWCoFjDQJpfOQP6/PthHQTmxWi4stgap/F7XUKZhog3uvfEMrjmfBWWinfwmxWJep1f6k01vq0mDXiPjcPJPzhp1Hlq2r+rYaLjLLYrOqNHSDKLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(2616005)(44832011)(956004)(86362001)(66946007)(66556008)(66476007)(8676002)(7416002)(31686004)(508600001)(186003)(4326008)(38100700002)(26005)(5660300002)(83380400001)(316002)(6486002)(16576012)(53546011)(36756003)(2906002)(8936002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3dBTjRVdk5lc1F5bzZqNmprc2VMM1c2Tmc5Qy83NTdwM0dYa0NiUkxabDJo?=
 =?utf-8?B?Zzk5S3BGcG9XbVR5MVNUb2lkZnFWU3B4SXRJNnhmcWphZDg5RUN3QjlXeWpN?=
 =?utf-8?B?aTBtT0Q0VWZmOHd6Z1F6QVEzWHdTMUc2M0ZrRmJkK2dTY3pqb1d4aTJ3WE4w?=
 =?utf-8?B?dDQrUW1kdmN0d2ZkMlcxWUVPWERFYzlGTVpiZnI4ZTdxRDluZjlMV3g2Nktz?=
 =?utf-8?B?ZWs5UmxjbkJsVkVOUXluaSt1N21peDJnenVMcUlsc0o0bmRKcmZudEpYaUJh?=
 =?utf-8?B?S0F5dVk4TmRaQmFQN2RUL09HZE1FOUJzaGxISWZ1VUdSQ2orSksrQXlxOUY0?=
 =?utf-8?B?MWwyN2ZRQ3YzcDI2K0pSVXlGZXk1T1ZwQTRNaGtXU09LQUhIazRYWnFiV3d1?=
 =?utf-8?B?S1UzNVBzMjA2ZmhUSnlVOE5HUTR0bzNCaFU2TWVYc2ZyUEJRKzhGQmRwdE5w?=
 =?utf-8?B?UHNvekZKeXJpNkhyd3FVMk1ZazMwelRxZ1RxcmZPWUpFWXlVUk9JWTQzN0c1?=
 =?utf-8?B?N1N4ZmJROTY3SCtFcFpwdHVYV1M4RGQvUWF4d1lMNTN6eTNzdzZBb0NlcWk1?=
 =?utf-8?B?M1VhMll1U1ZyU0ZLUkR4TllDUmZoTkw2THR0eWFWRjJNN1NENWtNUFROYjdF?=
 =?utf-8?B?RWVyekF4RWFqeUxabkd1SkhvTTBsR3FvSmxvN09pczc1MlJhYXlMeE9HUXMr?=
 =?utf-8?B?V25LZlhYcnhlWDQ1c01OeFFUSjk5SlpFYTd5TTY2T2VpUXdGMndBSCsvM1p5?=
 =?utf-8?B?TytSa0YrcnNKeGgwdzhVL1YyczR3cHE4OXBsa2dvd0Q5elVjSkgveUpUVlBw?=
 =?utf-8?B?UEE0YlViNk5LVzdCc3JoOXFaUGxhbDdZMDRDTUh2SC9rYlg4N2RIeDZ6ejNW?=
 =?utf-8?B?YWtKYnZ1V1U3Qmc3TUl2WmZKd3JBSVJYcklEVE55TDlVeHNwZ1cwK0hqY1VF?=
 =?utf-8?B?UDRRUzhDYThTcFBvUGlOdWNGRnc2MkFFZzY3UDZ4NUNaOUphRnFrOS9pT2FV?=
 =?utf-8?B?ZEQ2YUNISlNKdjVocVZtM3FBVm5oOVNReXRIdGl5a3N0WFE1b3ZXdnJyL0Y2?=
 =?utf-8?B?c2RscUQ4bko3RFVOVFFmOU5MbjFOVXdvdjQ5aXlCbkx6dkhRcGFTSkEvVGJm?=
 =?utf-8?B?VTRUNTFhdGpkMlUyY1BpU1paRDBaeVMwNm5IeXQ2dzBCTC91bGtocTB6ZmxB?=
 =?utf-8?B?Q0VTbzRPTndmR3BubUlLOXpBa2FKeHVjNXRjeTEydUQrRC9iaDhUWmJnMTlv?=
 =?utf-8?B?K2R2YlI5NmVwRHRnd29EQjVUSk9GQUFXcklzVmg0MzRlZTZ2alhTVUFsbGN2?=
 =?utf-8?B?dnMzVzRkOHVEVDQ5ZkdxWTIvRzZQYU01R3hjY2UxdGFZOHUvZVFuTk5odjR1?=
 =?utf-8?B?eXNCSnRGU1loQ20rRmpsYzFFTEs5b05NSWNWQmpEZXZvZ1RGTE9tQjB0dUJO?=
 =?utf-8?B?eXdWQVVpalpGWXR1Nk9wNTF6QkFSSjJpdXI1MWtqaFdKYjVQUHA2ZkhmN0FJ?=
 =?utf-8?B?c1VCY1hEMnpTWGx3VERUNThtWjRUQ2tXaGtETjBOUUZGRkYvdlhrRzlaSVNy?=
 =?utf-8?B?NEpDZm9hN2k2TEZ1TTZrMERROFJDelNKY3RNaENRYlhhc09HdDlXTTZKcE1q?=
 =?utf-8?B?MU1wVzh1MnZXM1htenVtVnJXcWx5U2EzTWF6MVNkTFNTS01Iem9ZUnZxRkJa?=
 =?utf-8?B?UjBwR2VvcERRZFVFNWxzVnlJaUpKckQ1T0ZCOVRVbzBHWm82UXpWRmJocXp5?=
 =?utf-8?B?TlZYaEd3ajR0L2JjWFRGZkpyMDdNbDRyNllXa3lpQ0krTlpPUVExOU5yVWRt?=
 =?utf-8?B?YzNQOCtEcjNsSGxxZk9yRzVCM2xXVG1Lai9rTy9lOE5YSkNLVXIvUlVXTXht?=
 =?utf-8?B?bUwxQ0k1WnRaK3YwOUV3N3hRZGw5ZkM4ejF3Y08rNUdWeHlkMzBvblVqdzRZ?=
 =?utf-8?B?SFBoTkRrSmcvNm5ocDEwckEycXJSV1pDZnpxTW42elMyZkx6WTc4SlZmcXJN?=
 =?utf-8?B?YkZSMzZsWWVnM05pNGQxclZZZ21jeW5QUUkxSlQ3NEozSnAxS1hXenJ1cCtr?=
 =?utf-8?B?TVl3RFA1enExTEVzUGJsTHAybGNDUVpJTzFYWTJEQ1lzRTBlc1RkN3c2ck81?=
 =?utf-8?B?TURHZVhDNnZucGp1Tmh1Ui9nUjdIUEtTVHhyYUNLTVB3VTNXa1F6b0NYdUdv?=
 =?utf-8?B?c2VFV1lLQm5pU0d6NFdzQkswa2NTZEptWVlEdGRGQUpzSHJGMnp5ditFOFVK?=
 =?utf-8?B?aGdpWmVHNXRCNnRIekRzZk11VzlnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df669442-bf91-42d5-5767-08d9b689532f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 18:18:37.4152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uRVZFNAf+2XP86XcP9b1SJbTWYR0uMnFdGeP2hQv+4vVpObpBRG8wRljajw+wdH9hrvlTPubyHUevgORMWpu5DyMLOdmMVMqgwb5Mc+/us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3554
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 12/2/2021 4:32 PM, Dave Hansen wrote:
> On 12/1/21 11:23 AM, Reinette Chatre wrote:
>> Whether enclave page permissions are restricted or extended it
>> is necessary to ensure that the page table entries and enclave page
>> permissions are in sync. Introduce a new ioctl,
> 
> These should be "ioctl()".

Will fix.

> 
>> SGX_IOC_PAGE_MODP, to support enclave page permission changes. Since
>> the OS has no insight in how permissions may have been extended from
>> within the enclave all page permission requests are treated as
>> permission restrictions.
> I'm trying to wrap my head around this a bit.  If this is only for
> restricting permissions, should we be reflecting that in the naming?
> SGX_IOC_PAGE_RESTRICT_PERM, perhaps?  Wouldn't that be more direct than
> saying, "here's a permission change ioctl(), but it doesn't arbitrarily
> change things, it treats all changes as restrictions"?

The ioctl is named from the user space perspective as opposed to the OS 
perspective. While the OS treats all permission changes as permission 
restrictions, user space needs to call this ioctl() to support all 
enclave page permission changes:

* If the enclave page permissions are being restricted then this ioctl() 
would clear the page table entries and call ENCLS[EMODPR] that would 
have work to do to change the enclave page permissions.
* If the enclave page permissions are relaxed (should have been preceded 
by ENCLU[EMODPE] from within the enclave) then this ioctl() would do the 
same as in previous bullet (most importantly clear the page tables) but 
in this case ENCLS[EMODPR] would be a no-op as you indicate below.

Since user space needs OS support for both relaxing and restriction of 
permissions "SGX_IOC_PAGE_MODP" seemed appropriate.


> The pseudocode for EMODPR looks like this:
> 
>> (* Update EPCM permissions *)
>> EPCM(DS:RCX).R := EPCM(DS:RCX).R & SCRATCH_SECINFO.FLAGS.R;
>> EPCM(DS:RCX).W := EPCM(DS:RCX).W & SCRATCH_SECINFO.FLAGS.W;
>> EPCM(DS:RCX).X := EPCM(DS:RCX).X & SCRATCH_SECINFO.FLAGS.X;
> 
> so it makes total sense that it can only restrict permissions since it's
> effectively:
> 
> 	new_hw_perm = old_hw_perm & secinfo_perm;
> 
> ...
>> +/**
>> + * struct sgx_page_modp - parameter structure for the %SGX_IOC_PAGE_MODP ioctl
>> + * @offset:	starting page offset (page aligned relative to enclave base
>> + *		address defined in SECS)
>> + * @length:	length of memory (multiple of the page size)
>> + * @prot:	new protection bits of pages in range described by @offset
>> + *		and @length
>> + * @result:	SGX result code of ENCLS[EMODPR] function
>> + * @count:	bytes successfully changed (multiple of page size)
>> + */
>> +struct sgx_page_modp {
>> +	__u64 offset;
>> +	__u64 length;
>> +	__u64 prot;
>> +	__u64 result;
>> +	__u64 count;
>> +};
> 
> Could we make it more explicit that offset/length/prot are inputs and
> result/count are output?

This follows the pattern of existing struct sgx_enclave_add_pages. Could 
you please provide guidance or a reference of what you would like to 
see? I scanned all the files in arch/x86/include/uapi/asm/* defining RW 
ioctls and a few files in include/uapi/linux/* and I was not able to 
notice such a custom.

Would you like to see something like a "in_"/"out_" prefix? If so, would 
you like to see a preparatory patch that changes struct 
sgx_enclave_add_pages also? If needed, I am not sure how to handle the 
latter due to the possible user space impact.

> 
> ..
>> +	if (!params.length || params.length & (PAGE_SIZE - 1))
>> +		return -EINVAL;
> 
> I find these a bit easier to read if they're:
> 
> 	if (!params.length || !IS_ALIGNED(params.length, PAGE_SIZE))
> 		...
> 

I am not sure about this. First, (I understand this is not a reason to 
do things a particular way), this is re-using the vetted code from 
sgx_ioc_enclave_add_pages(). Second, my understanding of IS_ALIGNED is 
its use to indicate that a provided address/offset is on some boundary, 
in this case it is the length field being verified (not an address or 
offset) and it is required to be a multiple of the page size.

I understand that the code ends up being the same but I think that it 
may be hard to parse that a length field is required to be aligned.

No objection to changing this if you prefer using IS_ALIGNED and I will 
then also include a preparatory patch to change 
sgx_ioc_enclave_add_pages() and make the same change in the following 
patches.

Could you please let me know what you prefer?

>> +	if (params.offset + params.length - PAGE_SIZE >= encl->size)
>> +		return -EINVAL;
> 
> I hate boundary conditions. :)  But, I think this would be simpler
> written as:
> 
> 	if (params.offset + params.length > encl->size)
> 
> Please double-check me on that, though.  I've gotten these kinds of
> checks wrong more times than I care to admit.
> 

I am very cautious about boundary conditions and thus preferred to 
re-use the existing checks from sgx_ioc_enclave_add_pages(). Your 
suggestion is much simpler though and I will use it. Would you also like 
to see a preparatory patch that changes the existing check in 
sgx_ioc_enclave_add_pages()?

Reinette
