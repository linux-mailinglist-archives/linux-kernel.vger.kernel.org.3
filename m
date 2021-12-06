Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D7846AB37
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356285AbhLFWLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:11:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:49833 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239517AbhLFWLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:11:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="217442650"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="217442650"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 14:07:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="579537643"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga004.fm.intel.com with ESMTP; 06 Dec 2021 14:07:26 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 14:07:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 14:07:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 14:07:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 14:07:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsO5GVrQMIGV1sY8Tok0eL2cGWC8sIXKNRzdC6x39n7EVjsx7QqU+mKcleiw8kFOwRHP+KHt2OoJfFtOtQmLe1V4DUU/N2wxXsUSxqXEclqMqRCWRQxg9TTN7uMutg1TFfdke6WzB0kbfFHInLTnpQyZmTz5fepWjLz1JXdOa9brUBWCEjQA3pPPkSVtUDGurqdn5yJ5OcTOPKMmRw5G8aV61vYmuKfmuLsciPsknuJGraBRJDOkTPMim0PQK0cr02GyQG4P/4nRYcxVUBghOuGFY2KIF1Vq9iEx9T+jT94aaIBYqChy/xp/zMHCkQI3A9AbXesziEFPGiovWI7ueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZH3S1Zg0Dh8uhHrGC8WNUD+10kCtagALts/ekMpslM=;
 b=LCLTYT5HpKUpX1GyLBipCPzRoQ+AvBmUeygqlg+TKkqM341zOwZC5oKL9pVWpUYECD9ZMFxkAe8sNEyXtzAHoe7wgjZwffo9jsEhBEnUZgRbhrwaJm6yx2E08zFwOw+OkMbCY2oX4YRJUeUdim+XToSuL9pLZ7L/KcIxV03SkuRMm98fW7MWiNMO49CSGYhWUg5CwyYkkMtLMYXjNKgpifllwvcmI+vfpDaCulEvcMAccrFUWGpvTSRRsLB8YzUiI+lIKXp13wkcTRhQfl0LYkuBSQY2J1lfPoR6MvLYIvfF+rS0M9c9SMwhX5iyJTS9AiTdrr8sdujes9KzGPjdjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZH3S1Zg0Dh8uhHrGC8WNUD+10kCtagALts/ekMpslM=;
 b=e7IYWtlWt6QiqRbtqzKdm7UStmw+lgbL6gLOk1+eEL6sr+CWm+ugpgMLAeWGCcSdl8OM9WTQ90xRVf8ws3RCCm9ceoq0E5+jEYIFeI9r47sD1PyuYEoFU78Bt8qRK6dAbdRep2BNIbrBojw227MfYvKHgemhAL/53zq0WVfdAlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB4148.namprd11.prod.outlook.com (2603:10b6:405:81::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 22:07:23 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 22:07:23 +0000
Message-ID: <0ccd75d1-1595-f213-c8b7-95988ab1c842@intel.com>
Date:   Mon, 6 Dec 2021 14:07:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 24/25] x86/sgx: Free up EPC pages directly to support
 large page ranges
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
 <4d3cc24f06ae75d99449f1d505cbff9ba53819a9.1638381245.git.reinette.chatre@intel.com>
 <Yav99E+wkPaQzH7N@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yav99E+wkPaQzH7N@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:300:95::21) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR13CA0035.namprd13.prod.outlook.com (2603:10b6:300:95::21) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 6 Dec 2021 22:07:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed1a3b02-dd97-4f42-df2c-08d9b904c769
X-MS-TrafficTypeDiagnostic: BN6PR11MB4148:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB41486C1D9619316DEC56E774F86D9@BN6PR11MB4148.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XpUhF6FQ/b1fMPoKAdh6857y3zj/98uwNBZE6XE0h2j2lYj2BZgG00VqnSIknpV2dq78xPIWtnEr2BW3IPkGAoXsFX8lGHphuL1AaJkEYKKwu9Fxu9yLkj6STr23zCipBf/X1TFkILSHrSpJGZXMdbhG2utoH0Z2pr0BQ2n+ZfZ+Ac1a6E2yYKDCLcrqemZDx84qm7IE2pTqD7O80/F8lyFO4cwG6kLTrdLIsI9VnbXinod3tm3DJ83djigL1Hi0SHZooLo7sqyzbRcO8GImlz1+RqE5n2g3FTvUKxr+aoh9/pTXjKtCVV2WFpV4ka9jUoKdi817GWoXeoXtdbkgvBRRKs/+L7eTF5GVxeLQfIvALp9FSxoBTf5VM8rpMICGNxMXGx1qrgRFDBpuyU9pafzUQR7eE6kzvBez1Z6WEVDiSm9XbZkp5Dewk+0rp/zAQuQOlTAPsCtA01qD+3vCucd0+g5ftLtnW3f4VrZCaQlOg8anjW7StIGvTQHpPq56g7ylHP3wMMx5vLoXZQxNDN/UugiMV+0f8EJKYv1Q0VqUchVkDQoIlq6t5qSu2L+EevJ3VMVxbGb3Pf/evYsnM9EKaGo/786kE8FMZZR0BWt3SDXNfNLtxXX5OGjsjwsQ7CfPFAhcxWyfCP+Xksb2NWrTZoSI3uS9UCCYyTMDGnIHChFbLXcbRA7ExsXJ6hU3oUo3rTsbPluGbFvlIT8J/TCrcLn/SXVyeB3QTzZiIJHq0QWK1euQ2CXgteFxOA4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(83380400001)(38100700002)(956004)(6486002)(66476007)(66556008)(66946007)(7416002)(16576012)(36756003)(31686004)(2616005)(2906002)(5660300002)(508600001)(82960400001)(44832011)(186003)(316002)(53546011)(6666004)(8676002)(86362001)(8936002)(4326008)(26005)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmtTMDFjV0ZhOGlHdmkyUjEzSHZsQ0dvci96QTJpVFRIT3RTb1dwUmdtWEZ0?=
 =?utf-8?B?ekhqYUIyUHN1bjRKTHhjK1FGZld0OVAwMnJrUlZpRlRIV2UwSW8rV214MkFq?=
 =?utf-8?B?QlFoVkdzNVF3UWRsU1hXMEVNVmRaWlp2RHQ5VHU4R0xGMDArY05tVGNST1pG?=
 =?utf-8?B?T1hjWE9yMWpISDZSOEJCRUp6cG01VU9ScFVPOW5ZWjZ0dGRaR28xSmdpY2Qw?=
 =?utf-8?B?TXRkditSUCtLdnV1Ym1zYzRRNFRrUFpDcnZxWXdiRUdnTncxTWVGTndNbDQ3?=
 =?utf-8?B?VEwxa2h5L2Q0NDIvMVMvUVlva3pPcEtWTjV0dlpYU3p4M0loejNHVnlZZTVT?=
 =?utf-8?B?cEJvVjlqOEJVTDRlNDllQnE4ZjNqZkZhb1BlV1dLeSt6RW94N0V1V0FNcURM?=
 =?utf-8?B?VmxTWXFuRFJTNzhNMUVHa21zWXhteUtmMnM2M29Hei93c3JxSStERmJPVkJx?=
 =?utf-8?B?Y25SOVNQNFBRcDk3cFNPdUVneXVFZGlXbG9mU3hMMld5aEM0YzRpaS9sbGxs?=
 =?utf-8?B?RDJTbVZqUytoa0pST1RFb3o2Um11MEI1d3NGeHhwRjBmaVo4RlQwb0kzSHpQ?=
 =?utf-8?B?UStOc1YwOU9TMklVdHlycE14cStzMFUyR2ZlcndhUDBPSExvM3NVR2RjTFdS?=
 =?utf-8?B?eUpDQlVjejQ4WUFiZVhxalh5eURKSytVbUFhcS9vYm5vYVdGMys3Ly82eWNB?=
 =?utf-8?B?U0NsWmRsRUFQRWE2LzY2YVNXZ2xLUGJORWVVdzArL0hkYTd1ME4xWG9pM0RY?=
 =?utf-8?B?cElCQkxONWp6V0Fqa21Ocm55cVlCT0NaQWtMbkplRUVZNmROZ2RZZjc2RC9h?=
 =?utf-8?B?aExiYjV4ekptQjBUOE5UeW5MOVhiYlpKeUpGVjRPQitGU0UyVEZSRFNEckc4?=
 =?utf-8?B?NWxaWVpIOVplMDBsRTFJQitmRmZCaUJVSTV1REdJZHczT1ZtTGN5N3MyVkwy?=
 =?utf-8?B?VmRpelcyc1JVM3AwQ0NEbjN5QjhDYndPU3lJSjErZHhxck9WNUNLSzd4a3ll?=
 =?utf-8?B?WERoc1JBL041WUdjRGgrb3BWL0V5TmJKZnBuMzhvaEVwVGJPTFdsYlZkTHBq?=
 =?utf-8?B?SEtCMWc2OGl6YXZBN1lCMFNRUDFLOGlEQ2U5NTNYcSszWUIzMkJMb2NobzMy?=
 =?utf-8?B?K0U1TFh3cU5rUXZJd3YxTFdETkE2NlNyN3ArajYxKzVrcCtvMHR5TlhoNXNm?=
 =?utf-8?B?Z3dhVWhzbG1rZjVPNEpwUmZkV0UvZUxxQks3Q1lFbGFxYURtQVc4WlltZmZt?=
 =?utf-8?B?Z1RsRTZPcGVjTjhuQTcxbHpoTW1VSWhkcloyT2xMM2dqZjdhb0ZTRnJQbVIv?=
 =?utf-8?B?ZGN4eENlRGtLdGFXMS9sVG9kRG4wSDVRbFVzZGpqUHVCbVlZVnIzQU1Bc0dZ?=
 =?utf-8?B?R0hNYVgvc2p3N2ExQS94NnNuNVVNMFNRK3JQNXRwek1pNTM2R1pSZHVEdlV5?=
 =?utf-8?B?R1lmTmJMVjMyVUJUY0FkSlQ4NjZQSFpCRFBsL0tncENvdWNOQXR0djY0Nk5q?=
 =?utf-8?B?Vm9xeFFsWHRhRWY4MGw1dG13QjFvQTJ5dDBtd2VodlQ5ckFYYThacWF6K3Fo?=
 =?utf-8?B?eVR6TnhQZmVuVGYvZkNEWUNXVHZtelppZjV3MHVZcTYyczl3WmpLTENBUHFE?=
 =?utf-8?B?YTB0bDN5N3Y2UDJkSTMwT0FzaTdyL2FIRmwvVUxvWkI3RWRNVnV2UnJ6Wlpv?=
 =?utf-8?B?L1BCYmdvRkZPTDFPRFlhTGdDNG1FUEZSYXpvR3luZWU1TGVVY3dCMXF1d3U2?=
 =?utf-8?B?aHNHZDJEMEx2djdkWDdsalBuWUV3blBLWjcrTDhtMG9FYitmNmVUczhMNVNN?=
 =?utf-8?B?SlRFL3UxMjBWaTBjR0NtSURYU0VCZ01Tek9jaCs1bnJ6S1pvRTgzRFN3Vml3?=
 =?utf-8?B?ejNZZmhhc20yeTh2WlhRcXVXL1RZSG8vYktCZjZvRjhJL0dUZDQ2aDVQV2Nw?=
 =?utf-8?B?SjlJN2tGMUExZnprN1V0R29TZEphUXhSbk1NclR3Nm9jTmw0UTFHaDFCTmRY?=
 =?utf-8?B?dndOZjFDQ1RsUDFqTTBISFdQL1d0S2NXVmpxTUY2VTA1QW1udUdIaXo3cTRw?=
 =?utf-8?B?N3pRcUUwSjZSL3VzdWZPOE10bklNYTEvRlVtcWZKc3FxOXNLZ1VJLzFJc013?=
 =?utf-8?B?TXBHNHlNVTZtakY2ZllkdE5NTnpZbjMzT295OUpQZnZzc21LSmdzWGtLUFNM?=
 =?utf-8?B?UkUrc3VtcGlQN1UwVzQ5ZHhhcU5Rb2lVSjFpZ0hFVWZ0SGt6aGFWaHNUekJT?=
 =?utf-8?Q?ZGid24KGsx9YCbDaje2yiYQptU50Pk+qk1d0m4xtW4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1a3b02-dd97-4f42-df2c-08d9b904c769
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 22:07:22.8617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lB7u51+8SaIVxhX0q3RWp5TbAe/6jr1sysRC8eB4BQ6i8zAFB3mUM7LcMqPJmBL8DO92MPe/OIMG2Wfv/zLEIOlzT38E9lRGKMc4vHhRT6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4148
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/4/2021 3:47 PM, Jarkko Sakkinen wrote:
> On Wed, Dec 01, 2021 at 11:23:22AM -0800, Reinette Chatre wrote:
>> The page reclaimer ensures availability of EPC pages across all
>> enclaves. In support of this it runs independently from the individual
>> enclaves in order to take locks from the different enclaves as it writes
>> pages to swap.
>>
>> When needing to load a page from swap an EPC page needs to be available for
>> its contents to be loaded into. Loading an existing enclave page from swap
>> does not reclaim EPC pages directly if none are available, instead the
>> reclaimer is woken when the available EPC pages are found to be below a
>> watermark.
>>
>> When iterating over a large number of pages in an oversubscribed
>> environment there is a race between the reclaimer woken up and EPC pages
>> reclaimed fast enough for the page operations to proceed.
>>
>> Instead of tuning the race between the page operations and the reclaimer
>> the page operations instead makes sure that there are EPC pages available.
>>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Why this needs to be part of this patch set?

When pages are modified they are required to be in the EPC and thus 
potentially need to be loaded from swap. When needing to modify a large 
number of pages in an oversubscribed environment there is a problem with 
the reclaimer providing free EPC pages fast enough for all the page 
modification operations to proceed.

What that means is that if a user attempts to modify a large range of 
pages in an oversubscribed environment it is likely that the operation 
will fail to complete but instead it would result in partial success of 
as many pages as was on the free list. This is because the reclaimer may 
not run fast enough to free up sufficient EPC pages in a dynamic way.

This becomes complicated for user space. It could increase the priority 
of the reclaimer but that has been found to be insufficient*. There 
would still not be a guarantee that after one page modification call 
fails enough pages would have been freed up in support of a second page 
modification call.

With this change it would be ensured that when pages are being modified 
that there are sufficient EPC pages available to support the modifications.

Reinette

* The test that follows this patch was used to explore this scenario.


