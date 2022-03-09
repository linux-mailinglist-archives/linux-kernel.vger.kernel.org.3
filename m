Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEC54D3996
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbiCITLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiCITLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:11:16 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D043141FC8;
        Wed,  9 Mar 2022 11:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646853016; x=1678389016;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gpU10WDAU+BeImAoHnsY1t27mbtIVjh2Mwm2zI++Yu8=;
  b=n5+Ubc6ySufVFKYp8n3K6AUgqm1joLcYOuP32nW7Kv9xXtzQj4e8tHxG
   pYSxKgRzkr2uOTgC1ygyDXYCdfkAiVvs09n78UELA3oDwssZbUB/smYkb
   zqsqHwie3WWxTonwgSGrwMliec2dRQS6eDzsM3ZHwN/+isouO4QpnCFq1
   k6aY6xBbK5ot5ubVpMvJt6rvbUuM9F7SxyBW4WYrJtJjJptS2iCNIxMHj
   Xx5iQvZi6ZyL3tezQpFeyOmWtVSQLPqmF8MqaAuokV/0cT2tYhF1XXDYH
   34eMjYTkt9eybxp9hap/qS+ztLZ5Za4pQowYxXi7PBFc/P+9fDe1uyuqW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235017651"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="235017651"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 11:10:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="554254177"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 09 Mar 2022 11:10:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 11:10:15 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 11:10:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 11:10:14 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 11:10:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOvpImeFZA2Q5Ox/6Bihq6Rq046lF/OqQRLMR/N75E9yPxA6TKkR3J+odq+O77lUseFAL87YDuAkRkxRa8Cl5ImmrOt/HDe9/TV/yS58B2vy4AepJZ/9JGTZtgRIO73r4W/mmsdfS7bYf8ScpDP4fC9eIGRkg/zDW7AP7XXMLZSSHYozMndjgCLIZBcqJiz2oEYtGOfcPeKuhvf58ai2E0aAUKwPpeGxL0oljwqaMR7rxaepUAignD4jIMF6Z6T2JgCaivs9/dNXuVkzfTziPlySt6i6WUQJ6SPc66sHH+zyWVhxGb2HOL1CL5ZbMXJPmdE2R6JehGp64om5WP7emg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmxj9hlf2PLASe8wmpdcBAuGq7KiF7ZGl9rLCspVbkw=;
 b=fco3OimsXT1dVISiU/a4XyDgrwlW9AHEGhmjjboI3PvpYkPGrNsYMzLCDNkUqC5e4eo5bf3X9SqifSXRYjAwI7afbOBwbf03b1OraK0b82A4z7ZhuFF/dAqh+Ws6JQTQe+YGr/yy5BsI0p0B00CjRMtv2zX2bao8uuLYm/6khCV773T6p0zM4sWTIcirsWu/CXc05eCvkiF3LGCJ0uRP9NjmquvQoKvZsm21XLzuptKFCyCPjoAQYxMASj/dq48V387DKVOdxtCDOO5QxDyQtQmlyOae5XRPoXcK3yXbz9Gvv2asWDQcJkD7von/dC6t0XhvDivs9FQ57wgzmkPLXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MWHPR11MB1712.namprd11.prod.outlook.com (2603:10b6:300:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 19:10:11 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 19:10:11 +0000
Message-ID: <a79df871-5c7c-ff25-1cdf-508750c8d802@intel.com>
Date:   Wed, 9 Mar 2022 11:10:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [RFC PATCH v2.1 14/30] x86/sgx: Support restricting of enclave
 page permissions
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Nathaniel McCallum <nathaniel@profian.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
 <20220304093524.397485-14-jarkko@kernel.org> <YihqwiU3Dr5mvMQx@iki.fi>
 <Yih00gFMaJhLIgxa@iki.fi> <5e89a3be-0760-b1b4-7693-2f3d9ac5066b@intel.com>
In-Reply-To: <5e89a3be-0760-b1b4-7693-2f3d9ac5066b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR21CA0064.namprd21.prod.outlook.com
 (2603:10b6:300:db::26) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 826c1113-1927-440c-221c-08da02006f14
X-MS-TrafficTypeDiagnostic: MWHPR11MB1712:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB1712C0A2C7C195BA9B66515AF80A9@MWHPR11MB1712.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7BLhu4zYqZiscUY5DgfOa9s8QslOaWHhNukCI9oPbA8G+BnSnnIzpuzVwSzFfcZXwTXHhuhaEOUmWZn+iFWaG3cwrSEnuhx4eKpgCVeb7qXde064SKclh6oru3l7ylFGkwsDhaXDAmsByNhaoi62qj5XRbZ5xDrCINdy0y8AKzsYO5wTY8FEjqjKaEn/aEUSPkqOaudJP8ufmldXpt9yvMj/c62A7fjway6WIVjjXFHtjzrO/k0iSbb8VLu8u4uQZLvCYdZL1hthcfvxYDxtbxW7UZjXM2/HSW6JCBvKhpt2P8/gop4LdoMiCFKISZ8bA3d+ykCJ40uSEQaKq965DxJpUc9axE/LnyyMcEPXW1330X9M8E+ZqOuZSfjXGOMB4gJ2NNX5QwvQJvAzCIjj5eD42Jz2o8E8dIgS/BFS9ZeRU9b+mlXOaYBDc32m1iF1QpZLUe53bMzEX17wxHqsgXQ/3syxPUSnUbzBOHEWTzi5dQJm6hVH3WIMsP5GXFwhuSA0Gg8m95gRrd24Ms4ort5XhKXsw5X0KXB8DPU8BeSHBbVmQs6IRD+2v5DFcsZS2VDErsIRzkE3JyU/N4bZQCnn1/MVa6cdhxo4ACTao4lYziIhgQCqaRLLshOpCo/gje0nVdgLkuLx0ChlMbTyRmIvSQze+jvQdrIu0Reco5II3GaSuP7e3JbiixTEQmzTSINv4rHMWx0i2YuP2oNR8JFqfQ23GUz94xNDW+lZnVgsz1vXAGKSEVVoZq2OI3cqEO2j04ArAHcxvO3fFZH68+M7ASTdpUHdmmclA5Ge+6VyE/l4J5ysVMglSkl5NX9j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(8676002)(8936002)(5660300002)(2616005)(7416002)(66556008)(6512007)(66476007)(4326008)(66946007)(83380400001)(54906003)(53546011)(6506007)(26005)(2906002)(186003)(44832011)(86362001)(316002)(38100700002)(82960400001)(508600001)(966005)(6486002)(31686004)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0M4b2p2WGd2NldJQTh4NngzUUMwUXhveUNhYnlkcURyTlBWajkzb0VpTmto?=
 =?utf-8?B?dnZ2S0VVWGxqNS9sWG1DaGxFUkZXRS8vVjV6U0RlZWF2N0JPSGRZSXc5cjlI?=
 =?utf-8?B?T0ZaTFZVWkhtelFlamN0WnBzdXNuK1dxK2QyRWFUZC8xM1hqa291WUFaUEpW?=
 =?utf-8?B?SnJUOFRzRzg0YVhmYll2NXVsT3VBUDhLOFdTUUU3dnhXaVl0QUpRaXNSaFhm?=
 =?utf-8?B?a2E0azFXSTBjSldPdUtzdkhWMUdzc2Z6djhwZnY5N1dUdjZyempDb3hWNDNK?=
 =?utf-8?B?d01wN1MzMHR4SVJpYTNxc3FQU0hpUm4rVzZyQmpTVU15QU5paWNFdUhuN093?=
 =?utf-8?B?aDJqdjBrZmdkL0JNUGpUcTY4aFdYSHBmUlZZVHl2ZXY1N0NHY2I2YWoxeWIy?=
 =?utf-8?B?ZERoaEl1SU50LzRBVEJWWVZQdWEyckFScmJUMzlPUkkrNWdRS0xCZHhDZWhx?=
 =?utf-8?B?Y1Y0bEUyUnZtZlhzUEtqOFpPcThDV09qMjAwZlltc1N3NU0xeWRHK0JkZHJE?=
 =?utf-8?B?alFBNkt1NzlXZVVPdW5FaVNRcENsdENqVTV6WU14SmZMOVl5S05nUmJWY3NW?=
 =?utf-8?B?RUkrRTNUaWUwbWxDWVRtdnNnenRhZjBENVdzSTNqQVh1NWhQZlZvWkxEYTBO?=
 =?utf-8?B?cXhGN0JkdGowOXdkWjhiK1AyblVNMVRmR3BaaGtPdncva0J5akRlOExNTDBF?=
 =?utf-8?B?aGduckVxQ0RkQU9YODRndU1sQkh6QTVOSzBtUXplbElPN2N2VTZkUElBcW1p?=
 =?utf-8?B?Skw1dUFCVHBCNGx5SU9DQ1diY2QwaTk3RWtKMlJhY214UXFjN0ZyQ095NENH?=
 =?utf-8?B?N2l2ZDYxd1I0ejZiUWQ0dVRXZjJJWWwvai9KQ1JkU2pOR2gvT1Z6cE1MS2Rz?=
 =?utf-8?B?Q3dKQ0hJSEE5RjVZektLYnRZZGUzcFFZRTlBMGxWSFhXWFNnYTdHZUNTNlUv?=
 =?utf-8?B?WS9NTk81bUllWUpsZi9vb2RVaEVEVWJqb3ROUmVxRGI3elMvdDFMVW1GQ003?=
 =?utf-8?B?L1g5cEVpTkt6aUFJNU5ERXNZQjNVZ2wwaFBPMHQwbWt6TEFVNmFHdExmYzZT?=
 =?utf-8?B?SVFLZXZJaExoZk5WRTduVXFmZ3ZaUDcwNmNaUnR2RktlYXFLRjdQL1ZFQ1Vp?=
 =?utf-8?B?NUloNWQwMjlwZW5GMXJNMUJPMFlWTjNNa0dFbEsvSU92cHpJZUExNElUZ3l3?=
 =?utf-8?B?eTdpbVVXTUt5RERIU29Gd3ppVlpuVzRXRFkrT0xCYk1zTUR4clhrWEN1dklW?=
 =?utf-8?B?N1pGMWczTS80NnBPdWpkSzcxaXcxN2VGOXlSWmM3M0dzcEVveGRXQU1veXli?=
 =?utf-8?B?dUNISGJoQmxwYnJsQUR2cHNKRG1qREZEdXlwLzFLcENQWitYR2p3MitHb1dR?=
 =?utf-8?B?cHRDVVB6ODdpV3MyaFV6dktualJGb3dNaFFuOFdsZzRnU0h4R2UrUGNNUG83?=
 =?utf-8?B?clg1eHg1N09ncG5pbG1GVUtGcUNXVDhxOGxEM0lZcTVybUpzaTNnaGJJYTZz?=
 =?utf-8?B?eERMVHZuVk0zc1Q0R2JZMGFVWHhIN293Snd3VFRLL2ZEU0VSeE1CZ2Y5S2dK?=
 =?utf-8?B?MXEyUTZKYzhvNzRkZ0cwekFtUThUV0o1R2VmejlqOUlZMU95YThSSXdSVzlB?=
 =?utf-8?B?RWxlVmpJcEl4eFA3VklMS1VnNW5JOG1ZVWhLRTZGRzh5UkR0ZFo4MUw3N1Z3?=
 =?utf-8?B?K1VVTjRmaEZoS2luVkNORk1qNllrTkJmZTlwd0RpNTNKMVBIWVZaZkpaTnQ3?=
 =?utf-8?B?aktXS2ZmVEM0aURQK2w1dU0vL1JBYjkrWmdnN3FJMmMzVDl4emRXb2hYbkJU?=
 =?utf-8?B?RVVmNDRBVWtBWFN0UlJwYkhFaUQzcHRIMjh5dDNTTnJDSDNMd0duUUM4NXFp?=
 =?utf-8?B?YVVSNityNVNuSk9EdU1oTjhwOGYvWENsaFlaN2JjbjZpbTY5alM2a2FScnRn?=
 =?utf-8?B?ZENFRk1MYTd4NnEvUnBlN2JRNzBhWWU2TUlsMi95WTU0dWlwMlZlTUpzZDNy?=
 =?utf-8?B?OXRXVHVZMldzd3FxT3pRN1dmd3hveU1nQUxHRThXM2ZvWC9Oa2ZSOFVFS2hR?=
 =?utf-8?B?bzBJWVE1anlxcEdEWTZEVjR0M3ZtcTRnVlVMSzc3aDF4UHpneXJIRDVnd2E3?=
 =?utf-8?B?YnQ4NC9ua1BRbWJlUDhBS3hTQmNFVXFQeGtvSXRvWlRkRzMzcHJieEFpeWZ2?=
 =?utf-8?B?NkJMTTRYUHo3aHNwVkhycExrNlNFOGJwUklSTXB1YXpKTHVVNWZzN3FEdXEw?=
 =?utf-8?Q?kaBZ396aekiqA4V7t1ctYhNxz/iQquTgzr1hDRox78=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 826c1113-1927-440c-221c-08da02006f14
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 19:10:11.6473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kur6AUFjq324CAGG/SiaBowVc9pZ0XKepE4lAmPM6MtK1fEqRDKrPubDcOzkTRLj/jQbBJcnK3ZeS7ADZAGD9t6Ng5pVljQPkAUw8FnW7Bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1712
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

Apologies, after thinking about this more I believe that I misunderstood
your proposal in my original answer.

On 3/9/2022 8:59 AM, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 3/9/2022 1:35 AM, Jarkko Sakkinen wrote:
>> On Wed, Mar 09, 2022 at 10:52:22AM +0200, Jarkko Sakkinen wrote:
>>> On Fri, Mar 04, 2022 at 11:35:08AM +0200, Jarkko Sakkinen wrote:
>>>> +#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
>>>> +	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_perm)
>>>
>>> What if this was replaced with just SGX_IOC_ENCLAVE_RESET_PAGES, which
>>> would simply do EMODPR with PROT_NONE? The main ingredient of EMODPR is to
>>> flush out the TLB's, and move a page to pending state, which cannot be done
>>> from inside the enclave.

Why not keep the flexibility of supporting all permission restrictions?

It is already possible to call SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS with PROT_NONE, no?

> I see the main ingredient as running EMODPR to restrict the EPCM permissions. If
> the user wants to use SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS just to flush TLB it is
> already possible since attempting to use EMODPR to relax permissions does not
> change any permissions (although it still sets EPCM.PR) but yet will still
> flush the TLB.
> 
> Even so, you have a very good point that removing SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
> removes the ability for users to flush the TLB after an EMODPE. If there are
> thus PTEs present at the time the user runs EMODPE the pages would not be
> accessible with the new permissions.
> 
> Repurposing SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS with PROT_NONE to accomplish
> this is not efficient because:
> - For the OS to flush the TLB the enclave pages need not be in the EPC but
>   in order to run EMODPR the enclave page needs to be in the EPC. In an 
>   oversubscribed environment running EMODPR unnecessarily can thus introduce
>   a significant delay. Please see the performance comparison I did in
>   https://lore.kernel.org/linux-sgx/77e81306-6b03-4b09-2df2-48e09e2e79d5@intel.com/
>   The test shows that running EMODPR unnecessarily can be orders of magnitude slower.
> - Running EMODPR on an enclave page sets the EPCM.PR bin in the enclave page
>   that needs to be cleared with an EACCEPT from within the enclave.
>   If the user just wants to reset the TLB after running EMODPE then it should
>   not be necessary to run EACCEPT again to reset EPCM.PR.
> 
> Resetting the TLB is exactly what SGX_IOC_ENCLAVE_RELAX_PERMISSIONS did in an 
> efficient way - it is quick (no need to load pages into EPC) and it does not
> require EACCEPT to clear EPCM.PR. 
> 
> It looks like we need SGX_IOC_ENCLAVE_RELAX_PERMISSIONS back. We could
> rename it to SGX_IOC_ENCLAVE_RESET_PAGES if you prefer.
> 
>>> It's there because of microarchitecture constraints, and less so to work as
>>> a reasonable permission control mechanism (actually it does terrible job on
>>> that side and only confuses).
>>>
>>> Once you have this magic TLB reset button in place you can just do one
>>> EACCEPT and EMODPE inside the enclave and you're done.
>>>
>>> This is also kind of atomic in the sense that EACCEPT free's a page with no
>>> rights so no misuse can happend before EMODPE has tuned EPCM.
>>
>> I wonder if this type of pattern could be made work out for Graphene:
>>
>> 1. SGX_IOC_ENCLAVE_RESET_PAGES
>> 2. EACCEPT + EMODPE
>>
>> This kind of delivers EMODP that everyone has been looking for.
> 

As I understand it this is currently possible with
SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS.

Reinette

