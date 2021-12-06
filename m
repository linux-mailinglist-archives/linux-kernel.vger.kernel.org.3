Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD3B46AA78
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351740AbhLFVeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:34:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:53318 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349317AbhLFVeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:34:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="298210183"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="298210183"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:31:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="515161832"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 06 Dec 2021 13:31:14 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:31:13 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:31:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:31:13 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:31:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDNHK0hHHEEkpl1cW1H3MIRXAe8iXucKV0VT8Xi9mqtZKplkAjFuRFQ94j8XMePWPWj+O+kGDrVueVt6woRSxDb8TGVxk1ZRPCIafxSDKYaSQSgbjKNPmjaoGTE8wt4X4FpxylWaOdICCYBDubZVa4MEHqJvhV44OrUBz0CB4zga1bWnZ8m3vLKZ8FnSaE6m+TNMfcyg+T85sp97ZajAPnChkklXYR5UtoDv4MmVC+HeKlwKKjwNS0jXo+0dJ9FrzFF0EH4WO/DdDK0Ti8tVhweMqob8O7spivCC55CGbyupv3inYHsaa5U2EvoGTM8hnjgkeiG+Sm1uG6gr5HdYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5353dX6dsXXIkg6JFxYPhdrJLocURiwulwmFpsv2V6w=;
 b=WrB1GMzXiSEUV0oF9x6Wl93HmxAW55uAlBspWvqvGP4CXGJ/Xc7AfVpbt9fCUa/LJMuMNcwctQzWF40DmHY2ohiCqIP40V2Jwdya/BCG/cHhtkU6LseDMlIAvUSS+FiH12gbc9S2eqUSpf0rVJoTu64eqzYuwBNdvQyidzkchdtU0f0tW74Su8MFRtU0sxmeOOQXsPFCc0RTNR611Zs3Mx9q3JTkzl4KPaJISLHDijWjSBHzJZdEOa5DXFB+GOxLsCT8igCwQT2oooHiAI2vCl6cnKloDqKRPA8xxL0VlkbVkFER+lm7+wbvcTb0bc1oIdQbbyJ3H0bKuQG76bWx8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5353dX6dsXXIkg6JFxYPhdrJLocURiwulwmFpsv2V6w=;
 b=pdCjL1juwf7jdxlBFekjzG5XglArKVWBxXVNJuVvm9FRXzgV1O4Ih2vz2ukwFTxSgefJA0jl7rmoqUWbJZN3er3G/Uz8skj+eiZkgZvwh+68uFvfttT+UodnsSjBFVXPiT86rebfiFMiW59hjvFdy3bMG2XIh2Y6ZegaUlvGIrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1843.namprd11.prod.outlook.com (2603:10b6:404:fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 21:31:01 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:31:01 +0000
Message-ID: <66151f3a-0e32-fc57-cb54-5b714588389b@intel.com>
Date:   Mon, 6 Dec 2021 13:30:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 07/25] x86/sgx: Move PTE zap code to separate function
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
 <bd228c90c139437bb4fcc4b7b99063bfd3eb1439.1638381245.git.reinette.chatre@intel.com>
 <Yavy5JTYAkdZjnK2@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yavy5JTYAkdZjnK2@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::26) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 21:30:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 498b59cd-4c4e-489b-b6a3-08d9b8ffb354
X-MS-TrafficTypeDiagnostic: BN6PR11MB1843:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB18436506DC7BE5313E2609C2F86D9@BN6PR11MB1843.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMaeassjZ8KCdLH7ff4gtXIpIv3LyiL81jeGfMWM7kgBV/vUS6qsk/t6H9ZvgltICJ9GrOoON1crqXu+tvMbz8C0tEpDckAqNbqA+oUzuU1t9VtzZvuI0MqKg4NJEs1YXClJOYJumDUHlL/1HcLKSGRgU/TUsTD6Tsd2vq8xUzdJs8qIcEt4lrEsnSM2rIyXutlARPQHidt2NGLLd79y41VoMG7atl0LnrW10UWoOY27hAGCf8W25hKFWff+N+Z3bswhwUmjTmSh9IfeJghY37vk5/AgTUEJztxgzJcDf063fxhBY2QGb7EZXsG/lxjYiyopNFJY8+PUwYzB5FcV4cxoUIeu2h8hUdJ1wkvRiO/Xu0iBBsy9sLCVvnp+17EiFmL2uof4mApRsc0sfans+6OPICo1fLyZWhRMU1tCJ/S5hp+cgCkeFxHbQj6AFo4/Bq5Yb7Ktx1zyX11zzy8LsICoBdnwtePHnuZL8R8Vz0Jbby632ZdFmVvAOhCjntnHeyUW0svAIMiVdQ+mz5e4wjteh11tLSQgOJloXXOO7ZSD3eqqxXAuMwvcfkbMu5RLopVtrWlEvuteWCqlp775Tl3aseoyYETgGOaBZbpagYinKQJd/9/N5DJU3CqngFlC6pXbDEdAGBGbMAz92eyfmXKN2R3Ord+lcg+o87hrYvlulze8NsZdQs+c2+AO6FlOLYtlBwJlYdbIHyWXl6oFtu7b70+dtHHhnLTy97sokmozs8/lHNem3TRN+WMnm3Ju
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(5660300002)(186003)(6486002)(31686004)(86362001)(16576012)(2906002)(8676002)(4326008)(53546011)(2616005)(7416002)(956004)(26005)(316002)(44832011)(66476007)(36756003)(66556008)(6916009)(66946007)(38100700002)(508600001)(82960400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3QrVWR5WERoWmlLeldRM215d0ZielNxYXhhK3R3TTVjREhIMFBmbVZBTDFT?=
 =?utf-8?B?L1crcmlDdU5MQjNPUEVLUi9KeXJBbStvQzVBTnZMaE43aGlaQ2wvNjZ1Nk12?=
 =?utf-8?B?TGxWRnVzS1BQOHMyNGhkSnNEcnVDK3dhdEkxRmdMVUR0V29aNm5BRTk3UWpK?=
 =?utf-8?B?YnpZaFp6VjBXM0IzVzFyekhJcjNrb0VmRE1rZFdQZHdOMXZlN1BpcjV1UzBO?=
 =?utf-8?B?eG04VFZ5RlZqV2hscEF5VkJFNVlhcEtWaWY1TXdHMVZNUWMxcE1hRGNPVXBI?=
 =?utf-8?B?TTRzNTA3KzVaRm03cmNEU3N5NUIvMW9DbU9sR0FWZVJiUk1KeHVldWx0S1Br?=
 =?utf-8?B?YXlkSmJpeGI5TVpXUjNHQlRFd2JhQVdYMXlyNGhlM0Q1RGhvTEc3MFJlRSsy?=
 =?utf-8?B?aENyZVBTejVhRnBETE1oYU5ORlovWU5oNWxQd3FFSjV5aXlwTC92a2M1ajlm?=
 =?utf-8?B?UDJVRkM0S2QxMi85U2h1VVBmUXl4N2k2d3EycjhveUIvNTRBVGRZRHhMZ0VR?=
 =?utf-8?B?Y0s3Nk1VcmpqM3RaQUtpVHdSdmhJdkJmWHVTZkpDRmpzK202eW1NQWY0UGNE?=
 =?utf-8?B?UjRrOGtnL2V5RDNYS1NwS0xmQWdtZmp0TTk4M0dTWFBYbGpIUVQyMmNBMFRk?=
 =?utf-8?B?ZWw0RUMyKzFHeDlNVytRN0doVTJiZzFZTldPL3E4ajc3TysvS3ZGR1pZdXQ3?=
 =?utf-8?B?WWIvdUVCYUk3b3l6OTNTcWNCL2daTVNuVGR1MDZTanVoVVUzVU5vMGgyQnNZ?=
 =?utf-8?B?Z1RIcWVhYmx3KzNLWnkzb2FyS0Y5YmE0YTVuYXBBR3BKWE15dXVFY3FFVnBw?=
 =?utf-8?B?THY0bTFpY05pSW5zejEwTGxMVTkyc0MxRjQzTWFlVkRGazcwUzRMbEhiQVFs?=
 =?utf-8?B?d0orTVdXOVFHNVdmODRxU2VTVUZtdE9BbTJHbFQrYlNyZEp5c0VTbmFPZmFj?=
 =?utf-8?B?WXJ6bkdmVEhnR3BaV2ZNK0lWeFAvMXl4RkFGMW9lK1pwOUhjd2l6dENKRE1t?=
 =?utf-8?B?dDNPTnhkVjZ1UXIwV3JMM2RWODF6RjNONE5KcnVQNUxPaVhWUldGaUVxUTRl?=
 =?utf-8?B?Zmswb1pscU44QWd5MWp1UDc5VnBhN3FXb01yOFV1SHBidGJGOWNCU05yQlpz?=
 =?utf-8?B?cVZra1Foc1JsSXp1cjBOdTBkNHZUbWxNRTBSeEsySE4vWHNVcGw1NlBvYUNS?=
 =?utf-8?B?TjJ5M21XZDBvSGhJWktpbnlUTmUvRGZiSjVQTFQ2VmdyTUNrL3hhMkkzUzFi?=
 =?utf-8?B?V0hTL0FXQnIxUWFJNXMyQm9rb2l1WUhkYnRMbFdZdS9uQWVFUzlTaTRxL2N2?=
 =?utf-8?B?bWRITXBSakpFa2NRT1Z4alpvMTdDL0M1bytWekFZU3phWGVGZlZwWG8wcDBn?=
 =?utf-8?B?cHZ3b0pyd3RLVmg2VnBwdisvSXpjL25ibmxZK0FiVUhGWFVCbjFuYTlreXBZ?=
 =?utf-8?B?M2laZ1Y0clZxSjVER053Rkx0TEZMUDNzRStMZ3B3eG9oZE9yQmFHZ0JDbDhj?=
 =?utf-8?B?VVp2UjRHVEluOUhqcE1qd2hjUUtHNmVjZlVYbDBORGNvYVZqMU1LZ2cvWnZL?=
 =?utf-8?B?NUhTcjNHaExYdFlvdFFNUHFOemR2TmFwRUJCOTF5Z2ZmQXhmOEJ0eUtUeVVL?=
 =?utf-8?B?dE9saitHaDJsVFlEeFBDMTY3bFJxcVRQZlViSHVaMDZjdk5lM2ZLSHJ1cUE5?=
 =?utf-8?B?UGtXWjdLdi9YZkVOYi9zNis3c2pQVnNTNG5kcFU3U0tUOU5lU1ErQXFlcHV3?=
 =?utf-8?B?QnFtTFJsNXNvdGxzZjBlU2tPVXBXRHBVeEZ5UEFMOTdYZjhoV29Ea0VnU1k0?=
 =?utf-8?B?OXdqSFJOVjZkeDdBYStqSUxQTWljOEtTbjhSbSswNFpzM3VmMmk0cGk1R2dM?=
 =?utf-8?B?YjlIZGZ1VGhTM1hKVUZ4dTZsK0RXUWtmOWdMS054NHRidUVpUkZIbGdqUUti?=
 =?utf-8?B?OU1iNzdLdEpVNzRCb1FNWk9RNlhDeFVSaUFZZmtlUUhKUU9Ua0Zhc3VYeE1r?=
 =?utf-8?B?TzBQakxhUnJaM25kQ05yTEF0NGdmcGJrMFpZMnQrUDA2cWVqN2ZCMmluM0Ru?=
 =?utf-8?B?N2IzbTFySGU1TVVkZy80L1I5Rml0UTR3a3U1RHZQNTd2eWIzOXVuWlBPQUV1?=
 =?utf-8?B?K0twNW9hTmxvOUhoMzF6OERRRFd0OXo4cWlnU0FEbFlvNWdSTmJObU43akxJ?=
 =?utf-8?B?c1FJZ0JvcFBOaVpQS1RQSDZLVU5ENmJQTzdnK2cxQ1JGOERLUGZXOGZlZWdT?=
 =?utf-8?Q?1N8apGlq7uy6KHqF0Oo42RvGleIGuoO00VOCa4voTA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 498b59cd-4c4e-489b-b6a3-08d9b8ffb354
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 21:31:01.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEOYEiGSid2MwFL646REnwUPY3PnUqSfAnUVD0J1pyMidUY5H6VQlHntvI92oKFIokABJIGFYHm5xBwM+TuXTUbMQ12Z+L00BRNjC0CrQvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1843
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/4/2021 2:59 PM, Jarkko Sakkinen wrote:
> On Wed, Dec 01, 2021 at 11:23:05AM -0800, Reinette Chatre wrote:
>> The SGX reclaimer removes page table entries pointing to pages that are
>> moved to swap. SGX2 enables changes to pages belonging to an initialized
>> enclave, for example changing page permissions. Supporting SGX2 requires
>> this ability to remove page table entries that is available in the
>> SGX reclaimer code.
> 
> Missing: why SGX2 requirest this?

The above paragraph states that SGX2 needs to remove page table entries 
because it modifies page permissions. Could you please elaborate what is 
missing?

> 
>> Factor out the code removing page table entries to a separate function,
>> fixing accuracy of comments in the process, and make it available to other
>> areas within the SGX code.
>>
>> Since the code will no longer be unique to the reclaimer it is relocated
>> to be with the rest of the enclave code in encl.c interacting with the
>> page table.
> 
> This last paragraph should be removed. It can be seen from the code change
> and diffstat.

I understand that the code movement can be seen from the diffstat but 
the reason for the move may not be obvious to everybody. If it is ok 
with you I'd rather keep this text.

Reinette
