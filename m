Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660CD467FEF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 23:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383417AbhLCWh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 17:37:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:30675 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238444AbhLCWh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 17:37:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="217090906"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="217090906"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 14:34:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="460185015"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2021 14:34:31 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:34:31 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:34:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 3 Dec 2021 14:34:30 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 3 Dec 2021 14:34:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDK2GwQErdpci7hOvwnHTw8NdON6X7MDf6JLotGsmjO7GruiPrna45nljapD2OSJRmkc2rxN2e0VDpdlZ0i17F1rQjwfiN0Sd+A7TN2WpI3uICft+TR9zMg8SJVj0lU2/I2CeBUPLTpxponXVhMAMWNkcL5NWvJeN3hi11vbsQi86ZH7rUy9tVRIJ7cO8clGGIg8VZ7X0XGr8WUjqaWZCOJsmzPEaYjinCFCtkPdCQL8fZMPTi2SbRMzxU4MQU7STRA211yMxu3RK2nM4/fULRM0lxUwlCe8ZXxCFliSXAAr7F4jJGbu7FYERsQVy6XoCL+tvgHl4D+g/4ODKRsVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUAZMa4U5e1g3mhd1afiT76OkQ29pRio5/uZecTkfzU=;
 b=e+HRkKJjtxncswRdIFB+ua4prUEAC7vMAsMrZL7fy/lXsIdO3wekrttFOyaMIgrRrxyVTiXU52JGsi4qheb/wcrGBVQvGRnu9gYJspLyI41RDnQigmg0C4yB1UquAjM+Xe0wGZgTcLp2I3fuPO7oG+MUsZZCN2RxtIq1h8lJt22eOkQjO3Y3O0WKx5giRn5Y3K/WI329rEwIEYPDzg094b/IwDnbyZbFbfOyLi+ro7xSot56dyy4OTzqxOJE8pXuZdyeBhIUklJlnUevRQ1K64UXgv4OxfIM1ZSa/knOo4KY165c84WEUo+tM7QXL8CAIJnUi/cNCWL45LnibyIlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUAZMa4U5e1g3mhd1afiT76OkQ29pRio5/uZecTkfzU=;
 b=hTmxAFeyR7M445i0pMJD0jtG99GVtVW8+ak5Le6g8TOFzZTqa3FXChsKuqnL1nXm78XaVmHXrKJ9ZfwASHRf2pEXC3nGYWdtdGDw9zz4vROpgDQFh/72aPVPPC+5kW43xiHCkjU6wKVz2pFrgtesu4NaXfVI7NnbRY6VtWt1KxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1907.namprd11.prod.outlook.com (2603:10b6:404:105::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 22:34:27 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Fri, 3 Dec 2021
 22:34:27 +0000
Message-ID: <fc4a8c94-4e1a-be53-50fe-802f6f985eaa@intel.com>
Date:   Fri, 3 Dec 2021 14:34:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 10/25] x86/sgx: Support enclave page permission changes
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>, <dave.hansen@linux.intel.com>,
        <jarkko@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
        <mingo@redhat.com>, <linux-sgx@vger.kernel.org>, <x86@kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <44fe170cfd855760857660b9f56cae8c4747cc15.1638381245.git.reinette.chatre@intel.com>
 <4960c8f9-72e4-0f40-64e4-4384a76d1e69@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <4960c8f9-72e4-0f40-64e4-4384a76d1e69@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:303:8e::7) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR03CA0032.namprd03.prod.outlook.com (2603:10b6:303:8e::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Fri, 3 Dec 2021 22:34:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a28866fe-f095-42b5-4b74-08d9b6ad107b
X-MS-TrafficTypeDiagnostic: BN6PR11MB1907:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1907F9ACB08C054F1FB1A727F86A9@BN6PR11MB1907.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/b5nM9Gq8pIZsE4CkQLE8G5Pk9d6JIgzCzudYd7F8wH5OftxDqzsFO2HSC8gp7O71sGzyGVLyOfLpulva/wdNap5OcJmdHbwUVnKSSdOpTpzSLjYSY1pNJgf2xOVDj5BFz8BL48i96VjQCCeyw799KEIK5db1Zqe0UUaoWrvYaiu/iXGq5ttxGwazrIrt0PiSPS6MdormTSNYgwSNwTeewOummHY4Fuw9gz5ZFY+WRMxVRKQfZZMbrS/KO0q53r46N1zVTBDqkzEfQ/Ir7ynVj8QwDRuQ9yuM8VjaHjJIOAxujqkm7Kv+8OQF9s7Yeu2zxqnZT5omQZoa3avtBBeDlZFkPiduty5YRuYrPAK1Vinpgjd0SeRsYJGCedwm+Lyq/FxfOxcVgmgW/oG6sklBJD6POJlHPInxdmyMqQb6j5ImXyfWh2ma3gnLzDV4S8Vmi+hQAp4ueC0Uhef91QLLeyr4/WaMjLJ3kzmwqICNJUuow3MySDu79T+ZAFT9K/dMhKxOd2XyV17ygXIyuzAmL73pKvFrRp0/IojkYchHkWm51BI+PpsWz/oGwWVgIc1iXzFRdbDT5Xl1udS59zgNI/sTB8/sHw8wZxnRcJ+T/+NvmymVmdBNgFh+h7nV0vzChjtGL+RFZIXFvZrkqDJ3BD8Id31HSn246M/HTlm3vdXNniLgSeyA0zGEiHhOJoY0cVos8NZFYhAf4mZjI6vB9a/i4iFUKo8iVD/EiJf49FW2Maja9kK2sEn11/tv7R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(26005)(31696002)(36756003)(316002)(5660300002)(16576012)(508600001)(186003)(6486002)(82960400001)(66946007)(66556008)(66476007)(44832011)(53546011)(83380400001)(31686004)(7416002)(4326008)(38100700002)(2616005)(2906002)(956004)(86362001)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWQyK2pBVEJkY2dtbVJ6djdRWk5yRXBRS0krWHBWZk5yUm9QSTBQMXNxNkwz?=
 =?utf-8?B?TzVDcGRxS3Y3MlhzQ1h4OUhFRFNWbzZQdHduUkJXSzdHVjk4NUZiN2Niem9K?=
 =?utf-8?B?d0lMS2RScytFaFo4YU1xMWEydXN2alR1cGd3cWsvZS9PNEF5QTVXZTNVV0RV?=
 =?utf-8?B?MlVpWFY2OTdmRlByMlZtWXE0eWM3WUdycnVDM01WNTIyQk5rc3J5R3RBbncv?=
 =?utf-8?B?Q1FSQklVQWZxbkhwd3p4MFpCWXhiNXllNVRwWlFjNVBhamY4cGtKREhHRkpN?=
 =?utf-8?B?OWZmTmIrNnVsM3kxK0p1dDZZT2xtd1BHbHhpVzBLUWJDRTVBZ1JYSUttR2Jq?=
 =?utf-8?B?eWR5Zk9IdmcxR2c5L1dwb0luT2Jndk5yWk5nckwraHU1Q3JwbjBWYTRnWnBB?=
 =?utf-8?B?ekhRQkdrUlFFYzZkMWVSY3JRS3NPWUs4OWwxM3hmQ0UwQ0ZWdTVaekVIbERR?=
 =?utf-8?B?cnRyU2Z0Y0orV2hXTHJsN3J3cDhDMklmQVZYdXNkZ2tZc2lZaUhucGRjSVh1?=
 =?utf-8?B?bnhKbUVBYXQ3UGtYMlZ5c0ZOTnVwcGxxVjZwbmJzUkUrRWg0RmF1WGdDbVE2?=
 =?utf-8?B?am9MdTdPQUw0eFRURnFmOVBXMFNsNzV0aFFNSVNaZVpQSVJ3ZUR6ZmloY1Vk?=
 =?utf-8?B?Vm1PV09CeDlOMytpZElMWG54a2RoNE83Q2tmS0luYnpiSnQ1Uk91N1JZVTNa?=
 =?utf-8?B?VnF1N2VlQkNVV1N2NzlHRVhKNWRWOWNOVFkvbXdPVmYySDdYd1BwRVMvRUdp?=
 =?utf-8?B?TXRWZXRpYk1ldXdWTUVpeGxza1F3S3ZEOWFzVzQyQWYyMVNBaitPd1FwSkFh?=
 =?utf-8?B?U3J1aG13b3lYL0Q2ZGduVFM3d3NTUTh5bVpIQ3Budy9HTnNNUUF0a3NENXVQ?=
 =?utf-8?B?ZVM2dHFNZUFTQU1YSlI2YTRxOWpQNjVoVGFnbnVPeTRHcW9ZdHM4VFVVR2U0?=
 =?utf-8?B?WTBVOUJRdkkwOGFIUWs3WUhpSklwUTVCOHgwZU5VRU5Gb3k0L21XTFFUNmZT?=
 =?utf-8?B?R0YvRHViZ0MwbnBkcTd0RHVjZ2htRDN0OUZUYkZSeTFsem1PUENucGdicVBo?=
 =?utf-8?B?WnZ0TDFkN0tBN1A4bWRhNTlTMzFJaXJxQTIxVlBYdkNHaVhJWHhLWmZBVTFF?=
 =?utf-8?B?aUo5SXdxTEltaU1BK2FqTkFubjQxZVY1S2ZNaFhueTRzaWhLU3gxSDJoSVBo?=
 =?utf-8?B?RVNhMTk2UGNQUzVvZlU5MW1HMkxPNit1Tkx2T0NkUVJQNjdWb3cxSVNueWRT?=
 =?utf-8?B?RGtVdXJHd2xPNDRSZTh2dmZHcUlHYkpCZmhCNi94SExOV2R1bDlFZ3AvZHZP?=
 =?utf-8?B?bzhoeEVrMDJuVW1hNURzd24zUVYxeE5zbDVEaEhyM01mTlV2VTZKMGd1L214?=
 =?utf-8?B?bWNFZmFRWTltcGN5Q280cHdWSFpRSXJwTitJQXUrUkQvZXF2SHJBNHFqdU1E?=
 =?utf-8?B?UUhWQk5KT2ZWUmFwZHBkR1NYckJnM3I1K0dIOVNQeEJVYlY4SDc0TUxtNjg0?=
 =?utf-8?B?UFBPL0dxc2RSRUErWnBMMlFjN1dRUVpoQ21CVy9UZlprTlRhanNxbnF0SHZN?=
 =?utf-8?B?SnhCNExzaDNKQ3ZkSTUzWFJZaVZRQlEzSUxuNCtGUUxSV1ppdTltcHZSNDJB?=
 =?utf-8?B?Z3dtTFNmTFdtc3c1RnhVTEd6T1Qzd0FFb0R5ZnBrZHpDZ0o1ZklxejRiREpU?=
 =?utf-8?B?UDdKUDJEZHJldjgwV1UwVWFkL2dVTithS1JGZXpBOEkzM1h4OVdtd2pPTkF4?=
 =?utf-8?B?V0xWWU9nYm1vU3VQRUNuR2twVFo0QnYyWEJYUndHOHl3TGZBYldNUEFGUkh0?=
 =?utf-8?B?emtwVFRGdy9lZ2Y5WXBmclVWMWRwNGdySHdiS3pMUVRaWkJQeC9IV0lMS2Vv?=
 =?utf-8?B?aWMwQ0RZWnc1SmFqakFqZW8zRjZ5WFBGSzVIbXBiZytPbW1qMzBRSEJZUzRT?=
 =?utf-8?B?UDhsaDlzQWxqazJZTk1TdGg5NFg2MFh5VDgxM0RicEQ4cCtzMkNJbldQTTFU?=
 =?utf-8?B?YzZPbzZHWGNQTTBaZUdPdkZsWDBMRjlvQXZ5RGtvS0xrd2JkdS9ZcnlKMmw4?=
 =?utf-8?B?dFYzVXJTSGRMMzNPQkMxMEJhNTl4WXVaSnp6ZUNIVTNQcmRQT0xBN1ZkaitX?=
 =?utf-8?B?d0tvNmg3ZVk4d2ZZSzBvcHNPVzRJQzd3ZlRiUWpCSXNHWU40Tm5ReG5ZL25K?=
 =?utf-8?B?bFQ5bXV2Y3hTTHN1c1E4VjhGUjBoTngvMmNOby9ObElLdVI4ZnpOaXZFaHRE?=
 =?utf-8?Q?8fdQ0e16wlZZ4KCyPnns/iN81fNyXMmYPBgHfIUylY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a28866fe-f095-42b5-4b74-08d9b6ad107b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:34:27.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUf+1BtA4nDFKyEOfRZ1Y15jSZo7xgC2UG0MYoSGhnE6DfNDoGbIYQUQ6YWkq9ZYeZWSAl4cf+Mca+bzv3d4p8RFMD71sPbTsI6prRCYFnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1907
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 12/3/2021 11:38 AM, Andy Lutomirski wrote:
> On 12/1/21 11:23, Reinette Chatre wrote:
>> In the initial (SGX1) version of SGX, pages in an enclave need to be
>> created with permissions that support all usages of the pages, from the
>> time the enclave is initialized until it is unloaded. For example,
>> pages used by a JIT compiler or when code needs to otherwise be
>> relocated need to always have RWX permissions.
>>
>> SGX2 includes two functions that can be used to modify the enclave page
>> permissions of regular enclave pages within an initialized enclave.
>> ENCLS[EMODPR] is run from the OS and used to restrict enclave page
>> permissions while ENCLU[EMODPE] is run from within the enclave to
>> extend enclave page permissions.
>>
>> Enclave page permission changes need to be approached with care and
>> for this reason this initial support is to allow enclave page
>> permission changes _only_ if the new permissions are the same or
>> more restrictive that the permissions originally vetted at the time the
>> pages were added to the enclave. Support for extending enclave page
>> permissions beyond what was originally vetted is deferred.
>>
> 
> I may well be missing something, but off the top of my head, literally 
> the only reason that EMODPR needs CPL0 (i.e. ENCLS) is that it requires 
> a TLB flush IPI to take effect.  (Score one for AMD for being having 
> superior hardware in this regard.)

My understanding also is that it is the need for TLB flush that require 
the privilege but I am trying to get more information here.

> 
> Given that, I don't see any reason for the EMODPR operation to be 
> treated as security sensitive -- it just needs to be implemented 
> correctly.  I don't even see why the host should (or even can!) do any 
> useful tracking of the EPCM state.

The OS needs to know the EPCM permissions to be able to install the 
appropriate PTEs. If the enclave chooses to change the enclave page 
permissions from within the enclave then user space needs to let the OS 
know via the SGX_IOC_PAGE_MODP ioctl to ensure that the OS can install 
correct PTEs in support of the permission change.


> (But I am confused about one thing: to the extent an enclave actually 
> needs EMODPR, is there anything in the hardware or anything that the 
> enclave can do short of actually poking the page from all threads and 
> confirming that a fault occurs to make sure the OS actually flushed the 
> TLB?  ISTM a malicious host could attack an enclave by omitting the TLB 
> flush and then exploiting an enclave but that would have been mitigated 
> if the flush occurred.)

When enclave page permissions are restricted it requires the enclave to 
accept the new permissions from within the enclave by running 
ENCLU[EACCEPT]. This instruction requires that (it will fail otherwise) 
the OS completed an ENCLS[ETRACK] on the affected page - essentially 
ENCLU[EACCEPT] can only succeed if no cached linear-to-physical address 
mappings are present. The ETRACK flow is elaborate and I attempted to 
document it in patch 06/25. Essentially, SGX hardware flushes all cached 
linear-to-physical mappings when an enclave is exited and with ETRACK it 
can be ensured that all threads that were in an enclave at the time the 
tracking started (in this case after ENCLS[EMODPR]), have exited.

Reinette


