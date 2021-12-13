Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A6247374B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243531AbhLMWN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:13:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:13175 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243347AbhLMWN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639433607; x=1670969607;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jse3JLIxOIBLNH1mSH9pKwpt7mvFYMp4IPhn3K3I37g=;
  b=E8eg31gh6bW27yqa09TjSpfSuMBuIJYSSInVCrY1V8EH/Hnfl2T0R6CP
   lgoPju45ik+TUSsynNfaPngEuHH9lYjmv4RrVhvgVOlVkAMA79bdAWgr2
   pg/QoOHPgVeOfGUkau/6fDcf/+Ya1MDcWtQAqE7spZ6kqF3TE9kailjs0
   1yL6qviyuYa5km2YkPh9o3d65XQe9/k/ayo2PU3YZ/Ro8c9/YMuqYsIam
   2LuYnV1nMZ36bW/bne0vaZoxNbYyVQ4Aj056Qetpzn41z5mCFmRNYp7hv
   SjNw//NFYO5cs/rZcDNJkecm9ZuXW60pPTZ4ywhqpfpfEffFI07aiRrHw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="225702012"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="225702012"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 14:13:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="464819700"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2021 14:13:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 14:13:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 13 Dec 2021 14:13:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 13 Dec 2021 14:13:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9e/hrD9bgiDqHY8wDUnpNq6na5WLB9kT8e0otbLHOTVP5Gi03T8dJESHXcSRpGA5SO60X6C+aJpBbP3DRmcQgEh8RpO7xKfPLtUfhFxW7BESmcjuJGwpD/0po5aA5goSigtk4ujjTrIRhczF83u+gXGc7fSe3Q3fd064/tSIMh6xAMtIlSi+KwdV9dYENpbhrq1gV8NpwFZFD2zhCMBrEme0fnkvWZ27iAb3iK5XoDIttwfHCdmruwxn1XTP5h0Fj58VQt5hKi+IC+RsiLsgN7Cc1mPf5ArBQpsKz0juRK3W/4jC5yf63ygxMl2r/jF/iTPz3ui/xbk5h0aWftONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UlhV0E28q3LF6+zzUcwlUWU6STznS2Kw/snKGSyb3Y=;
 b=Y0k9yAydf1wtO8c7Pnp/sdDO810o25awWptAocXLgW2qT+1SczO3PSZVmABnEeJJ5G7GoAfIfwnDfqpxpne50cu+0JWJxPlFIZMmcraSlBp0I0knP/u2QHR8BUzT0zHIgqGFEvrVa3REpH1Fs7tv4BUzW0zR06bZnKSuiHW6+criTbCBqSoalEN0NEnVEmfTBo7TSXRpLPEtLwfxyB4FuP/BEsYLfWX0iZL+jjwbVuKYKPZKxngh4SDhoMDQqorSSTg3m+U+ak8HEo+IWIrK4fiRYURY1Awmj6tSDYQne2+X9qBrIY18LalTnHV//98cC3ssCkdlCG0Odu/QD0ibTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UlhV0E28q3LF6+zzUcwlUWU6STznS2Kw/snKGSyb3Y=;
 b=KX3/o8JxEq6H21rB7WAyGE4rivQU+xDRJGHJ7VAc7PkwDezWFpz3BDlP3/0FSTyQl6wuhXKpBgTZSaoJaSbVSo7lRVQ+mZsXljVM2dnfVnMF0uLLW22LF5Zt/U9Dg7iyqltC/d7yMNJZ/8VgBtTJfBG20XlDmvb/l/PWRMwScFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1908.namprd11.prod.outlook.com (2603:10b6:404:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 22:13:02 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 22:13:02 +0000
Message-ID: <e934673b-8410-d3fe-f231-fef672050e2b@intel.com>
Date:   Mon, 13 Dec 2021 14:12:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH 13/25] x86/sgx: Support adding of pages to initialized
 enclave
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
 <9ab661a845d242cb10a90ade997f8ebda33cc7c9.1638381245.git.reinette.chatre@intel.com>
 <Yav1/ZRX68cECD7a@iki.fi> <cc6ecffd-7d4b-0b15-eaf1-6f585e8b31be@intel.com>
 <ce00226feaa02dbc0f66f3f8aa7a243f61e410aa.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ce00226feaa02dbc0f66f3f8aa7a243f61e410aa.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0049.namprd19.prod.outlook.com
 (2603:10b6:300:94::11) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6c17f26-8536-4c65-99c9-08d9be85ba61
X-MS-TrafficTypeDiagnostic: BN6PR11MB1908:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB19082C38CFB28F5862607335F8749@BN6PR11MB1908.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLdwADAfh79MLsDFHeO7oS2/7Hfk9hS3bilPYIXl3wO5GBf7e4nNL1eQeqscBhPF8elG1HkCIqW5u3azyssr5BpBD+q7WSt3NFpf5viESLaO1aQiqqwmHlH8f2Mji7Fu1m85ZGsEXv2sXK9y19y8UHPEwzhyz2HjiLUisBXsO6ewRam1UyzbsgMhenva+RfVg5kks2NptPjmi/juj0Oo4TqWuvYeFVIF6Yef5GbuSx0E7+ALI3Ggjdr+IyYC4fP6Z5acKWG6XKk5E21TDefFNYpY0MhkFn+JkoZ6fTWAix1IwD4E3+4NVeIafH1jW/+KaHKa3nHSGsG0CAIBsSizi6dKkEPYV8/NuLrZkNSBek945B2bqLx+vVeA/LCbxLchBBoXEGLw8xgWK03S0kcaSgOFzpSYB7jyxz2o5K/Job9m5lrNu2F9PJ2O0O+82Q3Buf+avkZXA6vjYsQgV9mijlGZX62k71+yDrxGS73ake8bY1s+tIicQHT/SBCLeMEcy/Gn8N1pOyWLVZll0fjs19PBImcDO3wtsfmlgKGwNQDkZFIY/0yEPm1Uhs/XxzrKhwuJpGPRpVRnLZdFNMjfb/kM7CfumY7GzIvhpWQXFTu8mKeiP8/5eczUZQk4q24CiPgFgTKq3tsxUeQ2sbq4ukkV7g5OKD2OB239HkfkxZipeFUkv2CW//2rNHt95sd2A3X5tKOmZpyA5sOjWcYF0kvS2Kq+EnBdqGueQIW9630=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(38100700002)(83380400001)(8936002)(6666004)(2616005)(186003)(31696002)(26005)(6512007)(44832011)(7416002)(6486002)(508600001)(6506007)(6916009)(8676002)(82960400001)(66556008)(53546011)(2906002)(66476007)(4326008)(86362001)(66946007)(5660300002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkZJZnVCcXpIN2Eva1FjZm9hQUxnV3RhZ1d2SHlua2x2U0hYakg0b3FzMERL?=
 =?utf-8?B?RWpOUEh5aGhBWk5KTGVRQzEwSHU1cXJrRGlJQzFqZkNYWVhrTGsvdlJWQU5C?=
 =?utf-8?B?RkI4K3M3ZHdqbmwvYXBTSVJlT1JEZTV0MkFIQmtrZHpGbzJPcVNVSDhDM0I0?=
 =?utf-8?B?Y1lHQnNHNjBuMGpIWW1JbEFkUnNMOGRmUHFUNTV0NHFkK0xXUEZrNnJCUXhw?=
 =?utf-8?B?aW5rRXZvVjFXNmpoTnVpR1BUKytxU3lUL29IeFZpQ3dGS1F5ZEJJSVZ1Smlz?=
 =?utf-8?B?K1paWVRDV0FhT2ZMMjMwUm54K0ZmZThGb25HbG0wZUNRVlBkbWRZaUZCdmZt?=
 =?utf-8?B?WWpZTUVIcmxHd1pDUlo1b1N4THcxSlNndEJ0bFZvUEluUlg0MS8zbTltUzB6?=
 =?utf-8?B?M0FTeU02dVVqR3RzbnRBdm1pNGIxdkNzOUtEOHhKQXoveTQ4TFN4TkRNaVZh?=
 =?utf-8?B?ZURlVjRZRnovZ1psTEJCT1NDSG1iNDc3NTV0aGVkUUE5WVRWU3I3RFFVNWtF?=
 =?utf-8?B?U21kbGVQSnNFQWZIU2RXWENJNkRZTlNKbzBRSUEzQWNDdDRrY1QzRFZ0U0ky?=
 =?utf-8?B?cHlTRE8zZ1FKelIva01tQUtrVXhZWHgyYlRtZTBiZUxwNGVpT0dzdm5uTmVP?=
 =?utf-8?B?RTVjUWUwVXVUQkZTWTM3T2YxendwWWhKQUQxd296RWRHaXBjUGNwODhJY3oy?=
 =?utf-8?B?VUJvN3BWY2JjOUFxQzhhLzVLTkpzM0VNMjYrTVdBTTJlZXdiTzZ0UWZseFcy?=
 =?utf-8?B?bUkzWitCcGlvU3p0TWdxd0MrekkwdHo3N2FIemZZK0Z6b3JJSE9EZTg2Wlpi?=
 =?utf-8?B?b1Vra0RzcFZpUDJQSE9SRzZEU2NHVWVvSjZjb0w0MjdyOW44Sk4zd2NKMnpm?=
 =?utf-8?B?dFI5UDdzOWpQRzBReHZzT2xycDRXREVxeUpMdmtDS2dCd0FOaEdKVGlOQXd3?=
 =?utf-8?B?dU8ydTVwR2J1bnQ4aCsrM2MzaTUvTGk4MjJNYUZtNi9LNWZmVzlxOUgwc2Vk?=
 =?utf-8?B?ejR2cjM1SUFRcExGSGdlVDJXZmpUdGJtSUo1dVBWL25mRmRWMm5jdE9aZzhx?=
 =?utf-8?B?YjdOY3pELzFWakg3c1BVNkxzTzgvUjlzTFYyQmJIeGgvTVRRV2Y5VWw3U1dY?=
 =?utf-8?B?QW9PWFVWb2g3NzZRYWRnRlFmNC9PMjlKS2NOcG42OEx1WWR0ditvSGRFSmZB?=
 =?utf-8?B?azVkeDY1UmhCOEU3MStKdnZ0dFg2eUlLcnRMUno3dHJXMENIUXhldkZjanRG?=
 =?utf-8?B?VkwxRXdJc2ZmKzRvQWJiV1JlUHVhTmRnaVdocmZtdmZoR0oyVmlTdStzdlVM?=
 =?utf-8?B?RFpmaFlBK1R6MUxnYyswbG1nRE5KS2dTR1dLNjRBUXFETmd3Sm5yNkdTQTE3?=
 =?utf-8?B?cTVLcXgvbnpCY0tzdi9vRVA1bkZPMzljVlRrVUNGNmkrZC84UDNVU0xEdk0x?=
 =?utf-8?B?bE4zRGpVKzQyRm9CVyt5MXZMUVFuSFNzY3M1RGdYQytLdjBxcU1rejRDZGZS?=
 =?utf-8?B?WjlqM3BjMU9DRE12dEJYR1FPaTMrL0lrbEYzMXZLNmdYYkRkREJ5NzhrVVdN?=
 =?utf-8?B?ZlBUUkYzSnVFektOUEdiUHB6MEJ0RFpBV3ZhT2lNQ055NHY0MFoxVTlEOVlo?=
 =?utf-8?B?YWV5RVFaMnU4bnl5YmI3MTl3UFNNMFZDczFwRkRtTjRJSWN0QnlyRGQzUXRj?=
 =?utf-8?B?aFZVajFLOERIY0RsT3ArVm9iVzZ6MWo4eE14QU9PWTlnbXdsTzl5WDhkeXVs?=
 =?utf-8?B?bW9wU2sycDVqT3hVTU14Y0JldkxWVFo4azE4V3BHQ3hwVjRYODhxRFpza0Vz?=
 =?utf-8?B?OHk4dmxSRUNvQ2xyYWdORXlOVzdnRmFjeHZQZFplajhWRmZ1NmRnSkdkbks3?=
 =?utf-8?B?VERYSHBkYmUrcGcyY3N2K3RkalJhaHhhNGwwdmF4cHRUOWJ6TXpNcUJxZDE0?=
 =?utf-8?B?dGdpRFVMeE5QdEc1cXQzb2hEN3pOTVI5N2R5UnQrMElyNTFvUzN1ZnppZjRw?=
 =?utf-8?B?dkRTQlEzWVhsQzNOMUJLeXFYajhQRVZWaG9icmd4djQ3c1FtaExhelJ6ekRz?=
 =?utf-8?B?Y2VmVDFHaDZTaEo3Lzg4OW9BVXNiQXhKcEltTUJzS1hxalBiVU9lcm45UWtq?=
 =?utf-8?B?YTJxejB4QW9lamZIM2phL01nR1l6MnFldVB4Sk1HVTVjSk5hV040Rm1OeVZV?=
 =?utf-8?B?eURVUkpyUWhKRFFsK1QxTnZPNDJIOHVobUhYRGVjWWZhRmMveFZmQXJUZW1a?=
 =?utf-8?Q?rLQL0g8Cod8rkfveH4czWI3ePDG2c2+o4IHZj/Kkcs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c17f26-8536-4c65-99c9-08d9be85ba61
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:13:01.8453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KA7sfhOEmkC8g8ASzvQzPY/FsvtIc951vkGcQmKeRagEjRBtQDf9paVGUUU8E6aCkzZNP7c6xervdn6jylAmHiUChHeuQCmjY+413kfcC0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1908
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/11/2021 12:00 AM, Jarkko Sakkinen wrote:
> On Mon, 2021-12-06 at 13:44 -0800, Reinette Chatre wrote:
>> On 12/4/2021 3:13 PM, Jarkko Sakkinen wrote:
>>> On Wed, Dec 01, 2021 at 11:23:11AM -0800, Reinette Chatre wrote:

...

>>>> Accessing an uninitialized address from outside the enclave also triggers
>>>> this flow but the page will remain in PENDING state until accepted from
>>>> within the enclave.
>>>
>>> What does it mean being in PENDING state, and more imporantly, what is
>>> PENDING state? What does a memory access within enclave cause when it
>>> touch a page within this state?
>>
>> The PENDING state is the enclave page state from the SGX hardware's
>> perspective. The OS uses the ENCLS[EAUG] SGX2 function to add a new page
>> to the enclave but from the SGX hardware's perspective it would be in a
>> PENDING state until the enclave accepts the page. An access to the page
>> in PENDING state would result in a page fault.
>>
>>
>>> I see a lot of text in the commit message but zero mentions about EPCM
>>> expect this one sudden mention about PENDING field without attaching
>>> it to anything concrete.
>>
>> My apologies - I will add this to this changelog. This matches your
>> request to describe the __eaug() wrapper introduced in patch 02/25.
>> Would you like me to duplicate this information here and in that patch
>> (a new patch dedicated to the __eaug() wrapper) or would you be ok if I
>> introduce the wrappers all together briefly as in the example you
>> provide and then detail the flows where the wrappers are used - like
>> this patch?
> 
> I think it would be a good place to describe these details in 02/25,
> and skip them in rest of the patches.
> 

Will do. I do think describing this amount of detail for the new SGX2 
functions would be too much for a single patch so I currently plan to 
split that (02/25) patch into a new patch per SGX2 instruction. Is that 
ok with you or would you like to keep it in a single patch?

Reinette

