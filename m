Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9699B467D1D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382524AbhLCSVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:21:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:11027 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238979AbhLCSVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:21:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="217049955"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="217049955"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 10:18:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="749057819"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 03 Dec 2021 10:18:26 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 10:18:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 3 Dec 2021 10:18:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 3 Dec 2021 10:18:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6YQvsV61Vhzb1peDMbiYlxdP9/n2ubbJqpCMZf5h4HN4Idwgn6wmemU82sX5O6oa9GiCNtVg2P+8pyjbD7a2iACVBEm5PFD8R8I9g/P2UmIqi8xDZQ1zDu+FfmH+0mcVSjuZSoYSm9DbDkRvMNjC8W0yUyXJfSzvssS3JYP9ZYCuWb2Ju9og1eJrlNFRO24Nf12ZEalEN5nytdOP6nlwGBGTqOuJ8+SCZVcc0mGLqPs+slwu6xGOSl0LUxV1fRcP9s9wvEKrLkPnFKupaKTWqty8WoOfdyAIEFjUFYWNO1n0B5C/sy+i3HIBmpOb4jcf7Or1/GJmzgi35KSzfZJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDnfTVbO0n3RkGmlVMF7qN7eGJFZUUOjSbwlXjFdz8M=;
 b=VKJRJ7onJTqZGPsGcOOzClI8es1FKwKsHFBEQcXNL6AwsZvhpj5VcZDT6azRa3mZbLcDlkgifAY+z/WlQFXy2wENf5icq7sZX6ZZj8bfRO+Nlo3ABu0XptPZOMTz4QHTCSksSspFZ+KjzxKSe3YrDfjg6qGrsVhUeKNX9dLGQnIjSQ9zkBebxT76I4sFsV8DTvoomV/JEvHlFRCghdBt9kUhEwZqUuR02IkP/yvWK0YNSZJZNxmEi+K0z3LZ0ozBhk9rPhir7USbkMmPpiuBmNti3Yi1B77Q0fs8Ytas29q35ALb3eKHO82wCgcQJeEgfJME/RaMEKwC8eVdmMarDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDnfTVbO0n3RkGmlVMF7qN7eGJFZUUOjSbwlXjFdz8M=;
 b=TvbQojjUgqsD1nNPXELCM8UQtPnhF3Cgz3jMPxA7wziw2xx2CB3owvufUga2GzjGyM7Bh9WWfPff761sYHeivuC2kx38EyDN+JW5aBBPvnRe4qI2Kp0fv6ZfrBncwUwa2DULNVIpK6cpggJXf38zUltIXDyZpVpfUIS7smYNhTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN8PR11MB3554.namprd11.prod.outlook.com (2603:10b6:408:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Fri, 3 Dec
 2021 18:18:22 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Fri, 3 Dec 2021
 18:18:22 +0000
Message-ID: <a4c8f423-372c-9ec5-8e8a-52e212f0ddc6@intel.com>
Date:   Fri, 3 Dec 2021 10:18:17 -0800
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
 <24447a03-139a-c7e0-9ad5-34e2019c4df5@intel.com>
Content-Language: en-US
In-Reply-To: <24447a03-139a-c7e0-9ad5-34e2019c4df5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0019.namprd14.prod.outlook.com
 (2603:10b6:300:ae::29) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR14CA0019.namprd14.prod.outlook.com (2603:10b6:300:ae::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Fri, 3 Dec 2021 18:18:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faf17f16-62c8-4f76-3683-08d9b6894a67
X-MS-TrafficTypeDiagnostic: BN8PR11MB3554:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR11MB355471E9CFAD0C140A7C128AF86A9@BN8PR11MB3554.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fj1dN18eqMAU+ni3f6o+hfml/DUNqpISob81YLsfDXej9FOuvrQ6Fu3VvPBDO39oSycrCsGKgTdfLpumSYEMx61z1biY0cx7mEZqhgaks4r0FMkoap7cHs+xlC2lNlXrtVbybzudDrxij12JVWdClfa4jJ0tMAswM839q0w7H54uxAZ13bxP/JU/fG8Q9gmOcqgGpW7i06EJ7EkJx5SL5fjsXOdutVp4WR3ehdbFWHH5BSpgOaWBbMQRn4smKwILURL9HpOpxN5JrJ57LPOHeIRV+glY3dZ3x4w/aQnohZxhe2KEyEzfZR1D56bXg3/QN9Au76lP6ouwVT3DIU8IQJBGxDDQ9lbyS4UvraAleTG5b4OB5JTlI7ILYY88K4J5G1/jn5BMFVqcJtQUWGVa4qcrSTunaSfkru8agHkwp+eQvLl87zuQhC2gqb4bqycf/cxKynKcnrP8uwRkgvHDJJr6+FwBQ/26w9ZMD9xqbfwWbIIz1AYj5Ma4Lwn1dGG9aSGRxoH5exZsuYsEfcsBHwFs8PSEcqv8OtW6N3TkUIumjNhKEST9EzFYTp4bLRYb2ynQSI5l1+ca/mOOTypMQjgRYGw+NG66b3uM/q0OIHE8z9VY+RZhY33abHHXoYIzdOhUT/1KFirGmY077bvPFgXHJlcHGzpsNUIPlYmrEX8eKkIMwbBKoUPxjEWi6ppT+lK3DPMLvNYKzH9DxcdREc1rC9RKegXQAzNPFF9BXdLEvLPsSdvaUdayER3+1ATm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(2616005)(44832011)(956004)(86362001)(66946007)(66556008)(66476007)(6666004)(8676002)(7416002)(31686004)(508600001)(186003)(4326008)(38100700002)(26005)(5660300002)(83380400001)(316002)(6486002)(16576012)(53546011)(36756003)(2906002)(8936002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ljb3lGelE2NUQrdVdCcmx3VFI5MmNiTWZ2UmU2blF2dmlRUzJhY2o3WjhL?=
 =?utf-8?B?VWZBTEtlVFZUKythcVBRcTFudFpCSnZZRXVLeXBXVk92d1hmVm96Uk5GZlZi?=
 =?utf-8?B?enYvcWk5REJnd3dLSXF0dHhoRGtQYnZ5ZEFYNDgvZmNOMlkzT28wVmdEVldk?=
 =?utf-8?B?bWVXL2YyYlEzd0g2TkM1STZybERBK2ZySzBydUFBMXRVYllmMlErZG5Qd2RW?=
 =?utf-8?B?OThaa0xKb1NMK1Z1NDIzVjV3czNhRHVqTUZ3c1V5RldYY3R6YWlDVkUwVG1Q?=
 =?utf-8?B?SG9XdndmL0k0OVg1c1ZuRmlyVFBGYlRmdjNCWklQRkF0cTZiTmVGMTlrUVMv?=
 =?utf-8?B?QU04NXdRVllWa0M2cEU0MzZaN0VhdjlwZnRjRTd2TTVrc25hYWk5aXA1bnJR?=
 =?utf-8?B?THFVRytUK3VySTArSkxaalc3ZWUxbGFnYzVoVHBVaHlaK0IwaWdiSWhJRjA3?=
 =?utf-8?B?cWZBM2JJY2lvd1ZjVEIzWWhZd3NGUjVUYTlGQXJLdG16ZXVONnF6VFJoU2Zw?=
 =?utf-8?B?L25NMnNCdmU5UkVTZTEvemt1ZUpMV1ZodEtaLzdZMU9kdm9RTTZSTFVUK2V1?=
 =?utf-8?B?NDdJYm4yWnVJbTdxYzRXQTY5cnFobzRna2JmME9uUTZHOEhrQ0U4Y0NISC93?=
 =?utf-8?B?TG9qZ2l1Um9FdmNhYms0SHMvMWJ1azhTeWVNb2V5NVBNcVZRT2FWSFZTNFI2?=
 =?utf-8?B?WE5MT2xQTGpNVHhzdGV0Sk9jdjdvdjFwazVzNFljUTlxYnJvemVFb0JZUFRl?=
 =?utf-8?B?RllKRS9pTHo0MlFDUXYxRjdHQ2JQVVNvQWRUQzVZRHpFTTlWS2RHb2JiOEZt?=
 =?utf-8?B?YTczMnFUZmRvMW40T0kvamZ6K3Vmb0NHMzlOelROQ093ejJWRldscFZLemJw?=
 =?utf-8?B?eGRJTmd3dHJkTmpUWkJCWTBRRzlWNm5XV3VXeWJBL2hhQ2NuTkNzeWI4akdj?=
 =?utf-8?B?Wk8wRmZxRW5RRW9waTZLYjhqRGlzVVFjajhjaWtLdW9oMUovc2JxaG1XbkFM?=
 =?utf-8?B?ZndpUXVlY2pidFBDRkNLY1FpWWxJY3B5emRRbkFXY2NxRVpvb3lPOGJjTzhn?=
 =?utf-8?B?ejFlcHZ6ZG0wUXpVVDBGRG9WNngvUk40TmNoWEhWUmF5NVhWcXN4ZDVGb1Jo?=
 =?utf-8?B?UlF0YTFsdGxiY2U3WGdPMGRiMEFwOG1EUjNPaExFZnVkSjFCZzkvUkFreGla?=
 =?utf-8?B?dE1RWSt0bGg4UUVEcjBxYndNUFRFYUhJM0ZHa3NpS0w5eW5YNVFhWDB1bkov?=
 =?utf-8?B?eWZwd2tGMnFzV0lvUkplQURoVmlVamhtb3pFMHF3N1ZxeUhNWnNyYW4xRnNM?=
 =?utf-8?B?R1h3aXRhcHVnaDlLb3FHVGFFMDEzVDgwa3V5bVlmaitScTNXUk5PWmllTDJk?=
 =?utf-8?B?WHdmRUR4S0p0WEpQcFdvTUxrVFVxZ1RnMDlEWUE2ckhCU24zcFZKWXFxQWJH?=
 =?utf-8?B?ZVNRdGkrdkRqdENaOVNqZGppT1RGZG5TNzFVMWRNT2ZNeUdtL0FOazczQTRF?=
 =?utf-8?B?czlWRm1OUmE0bXpLRGtZelE3a0lkUm9GQXpaaFh1ckJMSWJpa0wvZ21lbUJD?=
 =?utf-8?B?SlJhbTNuRXdVd2thVWVvLzliTUw1RmFZSHByYWFtZHFwZjV5RUczNDYrS0cr?=
 =?utf-8?B?cG9XM3JJM1RVUGNUb2FudW04WXNPYzg0VkRDYTk0V1hNa2xZL0lhTEQ2Yzhr?=
 =?utf-8?B?WUZCMU9uaHJmUWQ0M3VWbVp6RW9pWXNDZDJKaGFPR01ucC9wSW01TUZwSTNv?=
 =?utf-8?B?Ukc2dzE3S1NMSGNnNTY0QzFaRzA2NkJUV3ZZUUsrTUhiUWcvU0w4ajJIN3Zk?=
 =?utf-8?B?ak5OY2VkYkNnQ2UvZmRGS0JKcDJ0ci9MSk5sM2p6aE5OZGxFKzJkdnZKU3Fi?=
 =?utf-8?B?Ry9zVnIrR2RXVWJHWnhhQmVVVVVrKzlRY1BqaUtHUEpaM0JuakpocTU3ZkFV?=
 =?utf-8?B?TnkwcVZ5dHliOXhDcjF0dEg0OC8yTC90T0hrZ0xNT0dxU1lCVjBveVZac1RH?=
 =?utf-8?B?U0lGTm5DbzZPcDRQVEtlMDB5d0RQNkRYSjc0TVBHZ2ZvUlMzSzJRaVVaSFNy?=
 =?utf-8?B?RWZTcllMMGFNUGZjM0JVWlBSTXVKUXcvS2FIME5oWDVlU3o4eVBnRi9wVmZ0?=
 =?utf-8?B?eTV4aGNPeFpyaE9Icm1YNjFDTDJSNUluNlRXZTk1aGNwMjVZL1RKR1NGRmxp?=
 =?utf-8?B?ZFMyQUErV1dPS3lIM3pvd2pWNWgxRzNGcmZVcjVnZ0w4REFIekR1cDcwOFov?=
 =?utf-8?Q?2IJgFDuGeGDXx1zvZmblG0/Iec5pR2TuORuW+1RCAI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: faf17f16-62c8-4f76-3683-08d9b6894a67
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 18:18:22.6938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdWuocSY9lYalhU1jTPmEUPiR8MQlT2MTbS4hxDj5fbU3yRPOyDjOFz99JrJPHLIbznhfsYHw9jimdiAIpLCL6HTh2R61/m3qnL55l3i6ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3554
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 12/2/2021 3:48 PM, Dave Hansen wrote:
> On 12/1/21 11:23 AM, Reinette Chatre wrote:
>> + * EPCM permissions can be extended anytime directly from the enclave with
>> + * no visibility from the OS. This is accomplished with ENCLU[EMODPE]
>> + * run from within enclave. Accessing pages with the new, extended,
>> + * permissions requires the OS to update the PTE to handle the subsequent
>> + * #PF correctly.
> 
> Hi Reinette,
> 
> I really dislike the Intel nomenclature here.  I know the Intel docs are
> all written around permission "extension", but I find it ambiguous.
> 
> I've been looking at these instructions literally for years now and
> permission extension to me can mean either:
>   1. The set of things you can do is extended
>   2. The set of things you can *NOT* do is extended
> 
> I much rather prefer nomenclature like:
> 
> 	EPCM permissions can be relaxed anytime directly from the
> 	enclave with no visibility from the OS. This is accomplished
> 	with ENCLU[EMODPE] run from within enclave. Accessing pages with
> 	the new, relaxed permissions requires the OS to update the PTE
> 	to handle the subsequent correctly.
> 
> "Relax" is less ambiguous.  Relaxing a restriction and relaxing
> permissions both mean doing things less strictly.  Extending
> restrictions and extending what is allowed are opposites.

Very good point.

> Maybe it's just me and I need to get this through my thick skull at some
> point.  But, I do think it's OK to improve on the architecture names for
> things when they go into the kernel.  The XSAVE XSTATE_BV->xfeatures
> rename comes to mind.
> 
> Anyway, I'd appreciate if you could keep this in mind and consider
> changing it if a future revision is needed if you believe it is more clear.
> 

Will do. I see that there is opportunity to use this terminology in my 
reply to your other message in response to this patch. I'll do so and we 
can then further judge how it sounds.

Reinette
