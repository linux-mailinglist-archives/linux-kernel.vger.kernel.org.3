Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E79468877
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhLEACm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 19:02:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:38162 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234327AbhLDX73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:59:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="236963156"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="236963156"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 15:56:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="501645007"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2021 15:56:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 4 Dec 2021 15:56:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 4 Dec 2021 15:56:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sat, 4 Dec 2021 15:56:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sat, 4 Dec 2021 15:56:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awvAXGYPugYTesY5vMvdEI7Xm6yAhUgUAlGkDQr2MV6J4UKiPnWjnxKymVz/L1F9gsk7ATfXyf3H6iaYGA1OHCt4C+I9jrDcYaXbUOR8Y2ctECsZkusmtxSfiT3MvITsv6RNPZXuJwOiz5Y7Y8oJGUQmxR9dx47lUypxCTem/rjpCUxWL4Qb9MTWImW2TQISmIC17Ch71DkXHTIVMlGRT+taMA7fk4u5oM1stGoPMVZP4G1vl3V2JDDfybBwbvebQcbCDiaVXJThqsGddMIdlS8ZacoQkfIag8Zd8ZzfOgQMmQnILj0XXKHiyTMIdli2T0h+KnpUryOWq4rZ/RG8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwwkC864A/tBrlOCd3hCUGxJ9Cv/86F81Q24F/jEiCs=;
 b=nC5XgGdyrGMdVGIuX2WyZMkyppuiVxpZy58mFOnmvVyMFZAxVIY+ELKzjp0LPf7v96OV6WlrN9DsdKcoCQ/SHJFuw/dOfEka9wXq4Ax4HzbrbbR23rUdzP3JDpdlwUkmZvcg/pcJVY6lcF+PwUWacqxBeDTu0/OvFyJwYpooIYv4w9RIUIO/+YDvWZp4G5HBgbSR53VNiZv0T7c1vnqikd33Q3z5z5diAcPGlFw7uof6idghzxZjL5gZbQs9KahGleEmkjnBw52BE2CEe3tnTfC0OvVMpiIuT2I+t2Olw9xbZ0HCdUOVmZzebpe4z1aWVfRNy+tp75OvlYFB7MS6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwwkC864A/tBrlOCd3hCUGxJ9Cv/86F81Q24F/jEiCs=;
 b=EOu5vcghv3SeiFC+tfQDaTeCUjTCaGmbyHlPj4oNQT1ZPXI2f1uZ9Lc0vAtByN0M06VmliQuZmi+WZVOmEfcgl609jFSLBP/djYDMqU1NImJOvEYAlNuimKP+xD8Wl/gWbJn8wwMQJyim+JujOIemiWfEi6ztBfQq82KOfdKt7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (20.180.176.208) by
 BN6PR11MB3924.namprd11.prod.outlook.com (10.255.129.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Sat, 4 Dec 2021 23:55:59 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Sat, 4 Dec 2021
 23:55:59 +0000
Message-ID: <855ab0ac-1e9b-dd3b-63ec-d15d0f0fda77@intel.com>
Date:   Sat, 4 Dec 2021 15:55:54 -0800
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
 <c0aab85a-f6a1-ed5c-5540-b03778ffe24a@intel.com>
 <4f50b3b3-2cd5-30a4-5715-3350ef2174d9@kernel.org>
 <ea7708f6-a4c7-9f00-3c69-39cae0c7ac86@intel.com>
 <67993dd0-827e-5f08-d853-4fb0273adb5f@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <67993dd0-827e-5f08-d853-4fb0273adb5f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:303:b4::21) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR03CA0256.namprd03.prod.outlook.com (2603:10b6:303:b4::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Sat, 4 Dec 2021 23:55:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5b5f024-7033-492e-3acc-08d9b7819e6e
X-MS-TrafficTypeDiagnostic: BN6PR11MB3924:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB3924B9D6009CDFBDAA4AC1DEF86B9@BN6PR11MB3924.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LyLKCvhdPdCdM/laZWTc9ZiFwkPfiTwSbBnfIHGzDQR6YMt5fU3HJNZ1z6bbuQ7DE4jfr6BMxj04bYDVJV5tRxTvEHU1NkaLKmuOM3ytPy1+jBOG4eS0h82zDozyT4QnOXCEHnxex1eDJG2KiHVPwquTSloaT8o5PgvZDLwm4HXlhKTuLZfgSgylA3PwVAFBqds/v9oXc6csAZG8iYYVUumZBN9zkHQnni6ZPe7/2YXP60VaUBm0LNFCz7JsnNappnOhF0dtMQyuOMmLN8+YM7iVTWXedCOGqJwyGj9EKnTZ+YNfN8ufS0SDQ1UUXBAss3MwrqjCCW0qPG083vusRunOmSyHlALs0wRuLVALPSm0L9CiimJVQeF4zuBx2UfRRElOhc2cX8OJstAjz21KBTnh1TRnmMl69BDZo5G2X44NrL1o4AStDFO2rNhb+vmv+bQgbZxyT06/k5v+XLVxZLvBo5PrhL3yrQeqtSv70BejAbB3wsf28+bpClhjw6o/aHfNQxwC/DJpqCu1bigpJWOAOhZq8nz7YKeMeG7ipaBgXw5kNlRJXN3VbpqrhZxdusNHnoHRGruSnxz3IyFBvZVLZnh60Y4Hk1e05MP0CcGNXuaMJH/zT2L3/ORnaTqb+2rptSFLKVEu5i/+/VhwcXcY+ZJKfjPElaTScisgoSMILfxR0UQfu6g7nWxPShJF5edGQAUjMKomDuQ1P5Z3DrZb2AGCaPZFWb3GWVL8PeOxKbLgh4d2Guks22q2hyR+gX0oTlDLSwt2CPRzUQN+nq7+CczlCFaegtdI017iGgrYE7Nc/4YgHisMIT0EFO0Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(66476007)(86362001)(316002)(2906002)(966005)(508600001)(66946007)(16576012)(66556008)(31696002)(83380400001)(44832011)(8676002)(6486002)(5660300002)(26005)(38100700002)(4326008)(82960400001)(7416002)(31686004)(2616005)(53546011)(956004)(36756003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkxSZUJLeHNGcXFnMGpWbFR5M1NrQTZIYVc5SWk1MTVFdkQ1UmZtL3dMcTNt?=
 =?utf-8?B?T2Z1SlhZdzJiSktmdlRsY05DTXRaQjN0VWhJRHpXbDJYc2tHeER4QjRQV01a?=
 =?utf-8?B?aHo2emhsRXc0ODhNTzdvc3hSL29wUjlXdEU0U0dralR1NE9janNEd2puNUY0?=
 =?utf-8?B?T21ybmtHcVRBZmRTRU5RTXVTeE9lc3RvdzRiRlZ2M3VQY2JYdTNTMXhLa0J2?=
 =?utf-8?B?cUN3U1p5T0l5Vm9wSDh1M2szaUlVSy90R244RXlnY2xSOWpYWklCQjkwRDlz?=
 =?utf-8?B?MkM2VHBEeDZySE9ZYzEyeXlaS1IzaDZJMFVxb3p6RTRZd295TXZ1UVpHMmJ4?=
 =?utf-8?B?ejJmbm9yWEhrZnZGK1JEMkl5ZkpuQTBvWnFvVkRuR1p4OXFyQWlSdmV4c1ZU?=
 =?utf-8?B?OHB6bDhpYnVUaVR1d0gxT0ZTYjdlamZYeE9ESjVlMnVoRFQ3Z1ljcFNWcVI3?=
 =?utf-8?B?R20zdWg2SWNmNE4raVFCeFI5enZRRTF2MUNCaUlPVHl5QytlcnBON0hLcnZh?=
 =?utf-8?B?eWZ4Ny9HM01paFllMG53MmFLeGhMRzBvdm54dW9hMk85cjZkSEZJRE92cDRl?=
 =?utf-8?B?QjVlWjJnWjg2SzgzMHYvT0xTR2EyUVFxcWFJbE1PakVKaUlWZjVLODBEQ2VU?=
 =?utf-8?B?MGhDTi9IWnJPV3kvMEQ1djdDQ1FQSCtqakNJclJibm5yaFhSdEwydUVwbGJT?=
 =?utf-8?B?ek5NMjdRQTVZVWNHRnIyVkVKUzFnbnBGcys0M3F6ZHRCV1FiS1h3SkhVNVIz?=
 =?utf-8?B?R3A3Slc5UzcwZy8wWUh4dXR1T2I3TDVOcWErTTVZODJiNktzUkc0R0I3dkhZ?=
 =?utf-8?B?T2hOcG8xZGhNWktHRFVlMlB5SmViTGJGcUZEdjZuSVR1TzFZQzhOUE94ejJq?=
 =?utf-8?B?bTlhZkNzTWo1dmpSdXFCSjhzMWJSenNHUXZKS2lwSVpZRGZmWVpOeFJuMCth?=
 =?utf-8?B?L2hsZWdyTVlkUEVIckxhbE0xSitYN1pCTGlJb2hQL3N2cDc0b2R4aGpVWStt?=
 =?utf-8?B?bldoV0h0N01yc2lqa05jWmlHcHRwSkRZZnRqdDRZT3JwRHhaaU1FNnZnUlBX?=
 =?utf-8?B?L1hmZnNxUTVsVzAxd1dNVTFDdDVxeHZ6SzY4by9WZ3A4TnVBd1VQWGRJNGxI?=
 =?utf-8?B?WTdyYmp6WWRBNTFQbWQ0UWQvSDZVVFgra0hidFhSTjFhMGFGcG5ueFdaYmd6?=
 =?utf-8?B?dERZYmR6VGJQangvN1poZTErNEgyaDV3QUNCcWNEeGxCdTZBcnhNaWpaM0Nt?=
 =?utf-8?B?TzduaUwyKzN2NnQyL3pmSFl4K2pUcjNkTnByV0ppQ3pOQnFSMlhJdFVQeGMz?=
 =?utf-8?B?bjZzUmZsR29uR2JRUFhSTkdseU5NVG9naGRwaEpLMm91NElyeDRUK0NsVERv?=
 =?utf-8?B?Z1hTdHB2WjBOL1ZyWHdBTEV4cmtaN0h1MjVpSzExVGI1NzFzd0dhaGxNWlFu?=
 =?utf-8?B?T2dxa1cyMnhVYkh1YzE3RFIvTThjOHNuazRtWEFXUG1UNzV1S1dLTlJZQUNi?=
 =?utf-8?B?amluMnhlVXpwdnFNZzJaTEVHbWFXbzM5alBQUjEwbmplN2FMdGhNa3d3WjQ5?=
 =?utf-8?B?elZXZ0VtWkllVm0xNlJyakdBNFUxM0RKSkI3enJsOUU3N25BSjllR3ZCL3Av?=
 =?utf-8?B?K1grdGJVNW9NZHpsZHUwZmxZbjN3c0cxZzR2VXFuWUNTM0ZoN05VandvMHVw?=
 =?utf-8?B?RDBKeWNEdU8vOVlnS1hBcFJXV2Q0SGo1Q1BCT0h3SUtieGNuQUhQYUZKZEhP?=
 =?utf-8?B?SGxEZGh3R1V2Yk8xb2FybktuYjRibTVDeTFzRnVuRDR3UlJnYVh0aTM3YTJF?=
 =?utf-8?B?U2FqWWJMaTROYmorLzVTSHlQTnBIdjB5Q2s3ZHROQXRrdTJzaXI0NnhUT2RW?=
 =?utf-8?B?alE3dzlIb08reFVBZmhWYktFRDJyakpvSUpwdGhYQWk3cnBmT0o3OEVCMXMz?=
 =?utf-8?B?dUswRnI4ZXlWRzlqUlIyNzJveG1KLzc2V1AzVXZiNEdEcUxlM2RkZHp4ai9i?=
 =?utf-8?B?bnkxdy9PODZNamVSLzhKNHJRV1F4d1lhREptOTB1cVV6bUlZM3R6UWtXWkNp?=
 =?utf-8?B?S3A1cUdQVzBhUWtNTy9PMUxOMzdtdGVoUWtVMjZYQk9GRFZtUjlCZGthNnMw?=
 =?utf-8?B?czhLbGhpd3ptbDVkRFJNYUI5bThrVFJldkhudWlVdldkdDh0OTJOZjRjMG5G?=
 =?utf-8?B?NXJYR0VpVEZzSHNXWFEwMWRSN2tDMjNvU1BoQ2phUnRBQWpsN3FEdVhJQXQz?=
 =?utf-8?Q?vHElXNbbpUDGnBiphcR3KnwRmngo4NS+fViyobcHu4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b5f024-7033-492e-3acc-08d9b7819e6e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 23:55:58.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYweyoeC1/u5H2FTKGjf3+iFlgKWi56alnFU4honzomqXyNZsgeKOrDYIXi3PzoTUvai4R3itITXjRrvdVl1UIXQKqpKIowiGjdm8tgAJ7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3924
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 12/4/2021 9:56 AM, Andy Lutomirski wrote:
> On 12/3/21 17:14, Reinette Chatre wrote:
>> Hi Andy,
>>
>> On 12/3/2021 4:38 PM, Andy Lutomirski wrote:
>>> On 12/3/21 14:12, Reinette Chatre wrote:
>>>> Hi Andy,
>>>>
>>>> On 12/3/2021 11:28 AM, Andy Lutomirski wrote:
>>>>> On 12/1/21 11:23, Reinette Chatre wrote:
>>>>>> Enclave creators declare their paging permission intent at the time
>>>>>> the pages are added to the enclave. These paging permissions are
>>>>>> vetted when pages are added to the enclave and stashed off
>>>>>> (in sgx_encl_page->vm_max_prot_bits) for later comparison with
>>>>>> enclave PTEs.
>>>>>>
>>>>>
>>>>> I'm a bit confused here. ENCLU[EMODPE] allows the enclave to change 
>>>>> the EPCM permission bits however it likes with no oversight from 
>>>>> the kernel.   So we end up with a whole bunch of permission masks:
>>>>
>>>> Before jumping to the permission masks I would like to step back and 
>>>> just confirm the context. We need to consider the following three 
>>>> permissions:
>>>>
>>>> EPCM permissions: the enclave page permissions maintained in the SGX 
>>>> hardware. The OS is constrained here in that it cannot query the 
>>>> current EPCM permissions. Even so, the OS needs to ensure PTEs are 
>>>> installed appropriately (we do not want a RW PTE for a read-only 
>>>> enclave page)
>>>
>>> Why not?  What's wrong with an RW PTE for a read-only enclave page?
>>>
>>> If you convince me that this is actually important, then I'll read 
>>> all the stuff below.
>>
>> Perhaps it is my misunderstanding/misinterpretation of the current 
>> implementation? From what I understand the current requirement, as 
>> enforced in the current mmap(), mprotect() as well as fault() hooks, 
>> is that mappings are required to have identical or weaker permission 
>> than the enclave permission.
> 
> The current implementation does require that, but for a perhaps 
> counterintuitive reason.  If a SELinux-restricted (or similarly 
> restricted) process that is *not* permitted to do JIT-like things loads 
> an enclave, it's entirely okay for it to initialize RW enclave pages 
> however it likes and it's entirely okay for it to initialize RX (or XO 
> if that ever becomes a thing) enclave pages from appropriately files on 
> disk.  But it's not okay for it to create RWX enclave pages or to 
> initialize RX enclave pages from untrusted application memory. [0]
> 
> So we have a half-baked implementation right now: the permission to 
> execute a page is decided based on secinfo (max permissions) when the 
> enclave is set up, and it's enforced at the PTE level.  The PTE 
> enforcement is because, on SGX2 hardware, the enclave can do EMODPE and 
> bypass any supposed restrictions in the EPCM.
> 
> The only coupling between EPCM and PTE here is that the max_perm is 
> initialized together with EPCM, but it didn't have to be that way.
> 
> An SGX2 implementation needs to be more fully baked, because in a 
> dynamic environment enclaves need to be able to use EMODPE and actually 
> end up with permissions that exceed the initial secinfo permissions.  So 

Could you please elaborate why this is a requirement? In this 
implementation the secinfo of a page added before enclave initialization 
(via SGX_IOC_ENCLAVE_ADD_PAGES) would indicate the maximum permissions 
it may have during its lifetime. Pages needing to be writable and 
executable during their lifetime can be created with RWX secinfo and 
during the enclave runtime the pages could obtain all combinations of 
permissions: RWX, R, RW, RX. A page added with RW secinfo may have R or 
RW permissions during its lifetime but never RX or RWX.

So far our inquiries on whether this is acceptable has been positive and 
is also what Dave attempted to put a spotlight on in:
https://lore.kernel.org/lkml/94d8d631-5345-66c4-52a3-941e52500f84@intel.com/

This above is specific to pages added before enclave initialization. In 
this implementation pages added after enclave initialization, those 
needing the ENCLS[EAUG] SGX2 instruction, are added with max permissions 
of RW so could only have R or RW permissions during their lifetime. This 
is an understood limitation and it is understood that integration with 
user policy is required to support these pages obtaining executable 
permission. The plan is to handle user policy integration in a series 
that follows this core SGX2 enabling.

> it needs to be possible to make a page that starts out R (or RW or 
> whatever) but nonetheless has max_perm=RWX so that the enclave can use a 
> combination of EMODPE and (ioctl-based) EMODPR to do JIT.  So I think 
> you should make it possible to set up pages like this, but I see no 
> reason to couple the PTE and the EPCM permissions.
> 
>>
>> Could you please elaborate how you envision PTEs should be managed in 
>> this implementation?
> 
> As above: PTE permissions may not exceed max_perm, and EPCM is entirely 
> separate except to the extent needed for ABI compatibility with SGX1 
> runtimes.

ok, so if I understand correctly you, since PTE permissions may not 
exceed max_perm and EPCM are separate, this seems to get back to your 
previous question of "What's wrong with an RW PTE for a read-only 
enclave page?"

This is indeed something that we could allow but not doing so (that is 
PTEs not exceeding EPCM permissions) would better support the SGX 
runtime. That is why I separated out the addition of the pfn_mkwrite() 
callback in the previous patch (04/25). Like in your example, there is a 
RW mapping of a read-only enclave page that first results in a RW PTE 
for the read-only enclave page. That would result in a #PF with the SGX 
flag set (0x8007). If the PTE matches the enclave permissions the page 
fault would have familiar 0x7 error code.

In either case user space would encounter a #PF so technically there is 
nothing "wrong" with allowing this - even so, as motivated in the 
previous patch: accurate exception information supports the SGX runtime, 
which is virtually always implemented inside a shared library, by 
providing accurate information in support of its management of the SGX 
enclave.


> [0] I'm not sure anyone actually has a system set up like this or that 
> the necessary LSM support is in the kernel.  But it's supposed to be 
> possible without changing the ABI.
> 

Reinette
