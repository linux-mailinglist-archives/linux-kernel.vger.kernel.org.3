Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D0B46A9DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350975AbhLFVUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:20:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:37673 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350882AbhLFVUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:20:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237353126"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237353126"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:16:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="514929360"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 06 Dec 2021 13:16:25 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:16:24 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:16:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:16:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:16:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0oTW8MXz74XwdmRKqArIK4ItyCRzk9ulbrHTes2ApnjT+qYCgPGLtdOFjj0e4rVN4ewwQnmAoKJnFeZcb8sWZNCIL2r29IYcGOMq6eIOjyN6ebQZz1GTbd7FHNo0lBWuNUilPlFO0bUO5MjfVHkjgzYFLhTyufBk71JmCmjqcghpZuFehNLQlud7fQqtYemqZNYlRCApdza45fVFl7Ti5NY5dTXjJZj30f/k3xxJhjxuWRm8MH0hZDFPWaZLwLuu+LPGWo708dHQuLBfzMaM4Yg7KBYnd5KM5YeQP0CNqnie9QrmetwPd0TeCs0kvmR+swCQEUk5jMo2n8xNtlQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5SpyvaBxB09q4lWjnRbWqCW7fSsZu+0i9PuXUeGfKU=;
 b=Kni4JlKy3zyU7ubR5U6Y+2VDdCsYIq06nukyb6khYklN3M7UsBurpXXGPQfY71Tuq/p4WHdZmj2V1ci8vkxTWmkQ2kdq+DsGaeyT3Y66/vReCMdD+S6Mnc/9huC7tVG3PWjDXW84/9RrKIoj1w9Pt4vJCSTOSaMa0Q1xQfY1uVnb/I9FomATAa5ljvE2zSLd/ygw1h96A5/y+E7vib1JuGKdbf3JV1ByqWNKh60/A+wn1pIDRAYHkculVbhleAqk5ilHS3RfkrgvqSowiZe/vmjGG/jJKaU8iItOhiDgxKQnpWTcGIV7yiytQo2cbXbpIubyb1ay+xXug8YWlcLmeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5SpyvaBxB09q4lWjnRbWqCW7fSsZu+0i9PuXUeGfKU=;
 b=CVyJUTREXJB1TiiQN+a/xFwDpMtPxGfLl7TJEWFI+mvO9tKlfWXFkXzZtn/PhKEoNPO+j6zolSEfO/DZf5DcpyXPSy/WeEUR2i4NvCGWAXL/sMz+1gBCkCj2L8c64UsMAmkvSIpx+Q003ZRButRkG0ufU4SzlEHKzO90aiXr9H0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5513.namprd11.prod.outlook.com (2603:10b6:408:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Mon, 6 Dec
 2021 21:16:22 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:16:22 +0000
Message-ID: <81308f67-a4d1-1774-f58b-223d4e81f8db@intel.com>
Date:   Mon, 6 Dec 2021 13:16:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
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
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YavrSFDJBGqe7K46@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0073.namprd15.prod.outlook.com
 (2603:10b6:101:20::17) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by CO1PR15CA0073.namprd15.prod.outlook.com (2603:10b6:101:20::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Mon, 6 Dec 2021 21:16:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fb720d2-8837-47f2-b134-08d9b8fda6fe
X-MS-TrafficTypeDiagnostic: BN9PR11MB5513:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN9PR11MB5513B99623C6EF80A0274E16F86D9@BN9PR11MB5513.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmjG9/PoNSEW0NhjUpgTOlywoR1Dpejop3/vY1T88Xi7s0tqffPTVR9SnGewGUICI4EY2EjV3DrmHdFepJOg3DtwywO7JRjksLboiTQ243lh2IcPc1FwdXOiN33F6Pmv0Ym0r5j2xOs+G23mN0F1bdpf2synX2AlgWaaI1Alc6xX6uNn3OdVDxPfpwD1GJ4IeSS67utJUE811eZ+eXzuwhJAeqM/XLY+LAayrEWMtSAvgLpi31W+3Vyp9bYoguUgFllbTa1OnK5GyP5UAvgUd+OUR/LnevLxwNOWopE6GeRHTrtUpbj0XSD8wg6u6Q2Qcxr3af1lzwHN3/ejp9/Q5l9Y4uHRHbUid0h3Ui9aAKMhPdAr12AkgK/xR2xO+hltZjDEU3s9XpVtcb6KhWS2w7BOQhhwKtYQw1iCYvjXzYPm0xjmihwCLMQ1/C4PWDBwdCtxyTRnrIZLT2SC1YjC9Z1vBMakaMaRv1Eo06LMlYtErjrdutjl3eEfL6yh+LYwd1ZzVvbfheaLwlvUgLxeQuPSx81guotq2t1pjKc6NhARExHS4hcLe9KPjwHD0UKigRFIUjSd20kdUaP/gYlgcogAFT0tygucK0JJeetGAhSNDjNo/Pd8xlCuaCpgszotkuC2QJ4btu94c3Rdn9I6TyMOItYXckiI7aUM2MgNanjR1N96U92/NIA+xO86TLJpBYe6yPwMuPJE544mCVcszhVRm6pleDGTyPl4IZfVE2SYha/1vXshLNL4/FybzXwx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(66556008)(7416002)(16576012)(86362001)(956004)(2906002)(66476007)(4326008)(2616005)(38100700002)(5660300002)(316002)(6916009)(36756003)(83380400001)(6666004)(53546011)(31686004)(8676002)(6486002)(8936002)(31696002)(26005)(44832011)(508600001)(66946007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTQwdjZVTmQxWVNRN3Jubi9XOGdkbzdiNVdpYnNCK3BVemVTU2lycDNSMy8r?=
 =?utf-8?B?ZzFBM2V3ZFN2dkpiVmZNczI4b21wOVhpQ1VWQmFuYVd4dGVnUWxYbUY4M0kz?=
 =?utf-8?B?Tkw4WFJ4MWRzVXFnVlNPS2xZT0Yycmdqem5WRE1jRVgwSjg3WlFkeldoUWND?=
 =?utf-8?B?ZnZCZFN4c3RIMW5lTlp1Uzc0ZHhVZlNKbjZMR2Jndng2M2dIRDBtaWVYaVJj?=
 =?utf-8?B?eHBVZmtHMERaYlJmanVyVDVlMDUvNTNIbUFWelBRQk1sNlRMQ0F3VzlpN2tC?=
 =?utf-8?B?ZWdWSDZJSVpkVkNGZ1hESFNmb1VLRzAxSEUvbkdjdjlyd0wzdU9oVkV2UXYx?=
 =?utf-8?B?cDJzQU84SjBBUjQ3aUg5MDFyUlRpYktrZWF1U1lYckVxd2hzRGpiczV3Wmhv?=
 =?utf-8?B?YnFZcDlOdGcyWGorZUJnelhLN0ZnVUVneU5uZVlYdWlkblkvbFZ3QUpQSWh2?=
 =?utf-8?B?ZnFvZFBXU1lLVlJ4TjIxYm9tUVJNWDNOcW4vdlNGTHBkaEExZWVSbUFobnRk?=
 =?utf-8?B?cHB4TUZVK0VpOUs1NERhdUZUSmZtMnM2QXV3a3l2d0tzMmVNb0oxVDR2UmZu?=
 =?utf-8?B?NDRjZExHUDBPMUdwMlJtL05sbm9ETXV2Z0NFWDZWVUlKKy95bWRKckpGbzhX?=
 =?utf-8?B?cTd4cVVjb2pOMGVhSkphTy93QUZZUE1wZHNMNkZ6bDhpZFk2UGpETSt5Rys0?=
 =?utf-8?B?eEdEdDl1eERVcldOWlIvbm8zYkZGTlJMTE51NFRwT1JNTVhKWXVxOXhVTURQ?=
 =?utf-8?B?VjN5c2JXanNFa1hwaTUyOUl1Z1lmVVhoMXV1M0pianJhL09FSXRnTzR6M3F3?=
 =?utf-8?B?MHh0cFdpVTVuR3JERHYreTBtdnZHaGZTYXlRUlM3Q29DQ1lmMi9VL2xxYW9y?=
 =?utf-8?B?alRlMHZ3UGtrdkt0UzZTMHhTVjhlVHhnWUI4VGdJSHhDMXpkNmNGQUxUSWI4?=
 =?utf-8?B?TVhFa0NBaDlIZW1IVzFtK2YwN0dZLzI5Zm1aSmxSUFJQWWdJb0FXbFRJbGc1?=
 =?utf-8?B?aHYvdVJPVml5aTloc1pNSWR5cy9KZzRXZmNYbkxWRjQxNXMzRzBhaWRyMXJ4?=
 =?utf-8?B?bmtiNGJ0OFVzcjYxZ0dRazZKQSs4aU9taGd5dlNyb1hkTmVKbnNoQXc3S2xL?=
 =?utf-8?B?cGhPcGpEOVplUHZ5bHUwYW9reWc1c1NlTkdNaUdGY0dTLzE0UTRTaDNoaFkr?=
 =?utf-8?B?dFRrOXRFd1dTZW9VWktja3FxNFVxZEVqb2lrL0NBdmNvMi92U2ljK0JMamdM?=
 =?utf-8?B?cXM0dzhqMkhnN2tieG1VQ2dRT0R2OVZxZHdVbWsyTEVaSFdpUExEUS9FNU9N?=
 =?utf-8?B?SDlRS1QzVGtjRnRScXVFYkc2WFVaSWdyOWkrVDZ2VWFkb0t6RHNvQ0dTakRT?=
 =?utf-8?B?U0FEVmRwN1dBLzk5KzI0VGRMaE5lbDl4bTB3bmZWcUhTUVNVVGdDeDNVSHFL?=
 =?utf-8?B?NUViNG90bzR6Z0ZPUHEwMUEvSnRHMXVQVWRwSi9YanNVaStCdWlsQ3lRV3RF?=
 =?utf-8?B?d1JvbklPVGErZSs4dHRhMlRlbCs3L3ZGVmxOek43VFpnMTExaTB2bTZueVAy?=
 =?utf-8?B?Tmx3emFuQmZ3d0w2TzZlY1JCRFZBN3IrYUJ3UFJaRm9pYTNRWTFzSXdIdlBm?=
 =?utf-8?B?by96TENGTTBIT21wTUdtWXowbURLZHJPNHJnRGdMTEdmNHhvODQ3SklrYW4y?=
 =?utf-8?B?eGE0VnhyUklBbUlUVFFxS1lHZTh2ZnA4OVdoQmVWWnRSMHoxRnk0Rmh6SUsw?=
 =?utf-8?B?QWh4V0N1K0lxNERSOUx2REZwVk1jaThoOG9zYWtXc0RGU2NqU2h3ejFhTm1j?=
 =?utf-8?B?SmNaVVpaQ2RIeFNZM1h3RzRWSkdUK09vdWhqaFR5bklGcHpqcVVlQkswWnJa?=
 =?utf-8?B?QXByRFRIQ3pxYWEyVVV2MTNzaUdHK0FuQnZDclpCcDFFNmJrS0l6djUzVjNl?=
 =?utf-8?B?VTI5ZlMrSXBhM0JSejFIUVFCZ0lpWHFINmZ1NmZFa0w3TVdSYlpKVGdCMnNq?=
 =?utf-8?B?QVQ1VGRsNk4zdzNlc1RDN21BdGVsV3NrbEkwazZTc3l0QVRaZ0Q1bU9oU1A0?=
 =?utf-8?B?RUVCMXlVd3lxWTRGbWpxYXNxbjNRaEFoOC9mYnhPV2phQ0F6ZDhNck5FTmRU?=
 =?utf-8?B?SEs5L1BwT293NGxTNTdXZXZMSHlyOHA5NGpsUlg1aGRNZVVVOHRvMnQrNXE2?=
 =?utf-8?B?ODBCdHVmTnFlbGcyUXBxUzZqcEtSeEZ5QnFwdXFxQk5VY1hGdmhWT0Z5MnRG?=
 =?utf-8?Q?VDj3Epg4+hpGMi2vBYJWLrpzSsuFV6p4QDLi8dJXBA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb720d2-8837-47f2-b134-08d9b8fda6fe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 21:16:21.9015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 390UZ65mtjCD9xs5QIj9zKWxBDWZjHrhZQLgJZcb6sbnybSEeNHjQ2Q6uon+eYsNxGHQ1T0xtkVUmzOJmpm7QrqU/X846F/DAc1wTceNkjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5513
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/4/2021 2:27 PM, Jarkko Sakkinen wrote:
> On Sun, Dec 05, 2021 at 12:25:59AM +0200, Jarkko Sakkinen wrote:
>> On Wed, Dec 01, 2021 at 11:23:01AM -0800, Reinette Chatre wrote:
>>> === Summary ===
>>>
>>> An SGX VMA can only be created if its permissions are the same or
>>> weaker than the Enclave Page Cache Map (EPCM) permissions. After VMA
>>> creation this rule continues to be enforced by the page fault handler.
>>>
>>> With SGX2 the EPCM permissions of a page can change after VMA
>>> creation resulting in the VMA exceeding the EPCM permissions and the
>>> page fault handler incorrectly blocking access.
>>>
>>> Enable the VMA's pages to remain accessible while ensuring that
>>> the page table entries are installed to match the EPCM permissions
>>> without exceeding the VMA perms issions.
>>
>> I don't understand what the short summary means in English, and the
>> commit message is way too bloated to make any conclusions. It really
>> needs a rewrite.
>>
>> These were the questions I could not find answer for:
>>
>> 1. Why it would be by any means safe to remove a permission check?

The permission check is redundant for SGX1 and incorrect for SGX2.

In the current SGX1 implementation the permission check in 
sgx_encl_load_page() is redundant because an SGX VMA can only be created 
if its permissions are the same or weaker than the EPCM permissions.

In SGX2 a user is able to change EPCM permissions during runtime (while 
VMA has the memory mapped). A RW VMA may thus originally have mapped an 
enclave page with RW EPCM permissions but since then the enclave page 
may have its permissions changed to read-only. The VMA should still be 
able to read those enclave pages but the check in sgx_encl_load_page() 
will prevent that.

>> 2. Why not re-issuing mmap()'s is unfeasible? I.e. close existing
>>     VMA's and mmap() new ones.

User is not prevented from closing existing VMAs and creating new ones.

> 3. Isn't this an API/ABI break?

Could you please elaborate where you see the API/ABI break? The rule 
that new VMAs cannot exceed EPCM permissions is untouched.

Reinette


