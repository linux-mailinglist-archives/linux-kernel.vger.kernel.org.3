Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD13E5A1AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbiHYVYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiHYVYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:24:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE88FD1;
        Thu, 25 Aug 2022 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661462687; x=1692998687;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mHOsXIWr/pM4ypc5kr9klBEWhW46AyHt/rmV0xn0Haw=;
  b=Kt+L28hRcXb8ch8i1bfHv1rajxuZaU6fY0Gjb9uc528jJ05K5NsHJflh
   dYOQpW0LOAUg/PVVuVm88IrsleZ72XiAfg6wXA5d3tFE+J0RSUouvHx2C
   lHtX7GbBsDSePul2mtJmkwUOC81hy/MjeTn1OC4rnWxMJlPcGFz9HY2mS
   SY7GyV6fQJG3Vx4xSJK71JVOrO/q2gNJuDM2ak8DButUrX7EQv1DHXw7a
   8BPxYDK4WYww8SuftfSjJMGe51jrf++rjhR2G2XlUBQjgq1iGn/mWBi1b
   JP1RHKWVh5A9nIyRAAsaOxAbJowJE4z9Fstan8JQKddZ6/optWlXlkteG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295140791"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="295140791"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 14:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="610327344"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 25 Aug 2022 14:24:46 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 14:24:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 14:24:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 25 Aug 2022 14:24:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 25 Aug 2022 14:24:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9Ty9N4nMqOUmwg8qxNUvX9adu9rro/MbZea29hDfLuGq4tlqKpw6MmO1yND+8zuXatmCUj1e/ADjTe3qA28hrioKNO8WyhyuUKySvDy/+ZpWoxrDJ4pxGS/Wp9e8M1JIt6pHordkS0PvWiUCiwo6sqzFp3x2JXhIKtqs9jWzVdw6rC20Kht4tHcX1nMh8Tqu6zshCk7ZIYMY4iXwHV4J2D5AkgvRrFnHNmgcJB3mLJwpihfk0/E6w54Ihh8NOp/Mv1NW4UIDAc0h4mrE7uv7VAjOFB2WyXP1+NwpYv5rOqhpPjH5KduiD9lWPNgIKifxV9oX4igsbC9Bv6AoD1Qvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1juXNhC+Lswi9welWLE3w0AZSRXSBmsHBLgWpECGOg=;
 b=DpkzZcLpyMwLm1Iuna+q54/wRlw4q8kWxt7gPo7FRm4MgtCKSY0iYKJyN/rAMvQTdy3u2hjBwRDscOR+zq4dkPwcSVy7IhwfcosZOAZBYZvsNoYyZASDQ9cQjV2ExWyjdUs4mU7syDTztHXjaE8iEbZFGA1wZadi1cVB0DceUkAa5lJMixlrUznRnYmeokPdPudc7a9wptgifFTX8OXqLEl8n6qB6NTYjeXRYitP0ZYi+M6sQuabDooRzzEAbJ47VdFbiCFn8ds4KiJ8HDiKRVwTM5qgEwLSCwcI0dLMip5lXlpcLECI3MDf/Qgr3H5ptDYFDPIhXI+dtoYYa+y6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB4041.namprd11.prod.outlook.com (2603:10b6:5:195::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 21:24:42 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 21:24:42 +0000
Message-ID: <3e6a0f42-86a3-18f3-1b6c-0e98791324e4@intel.com>
Date:   Thu, 25 Aug 2022 14:24:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v3 06/10] x86/resctrl: Introduce mon_configurable to
 detect Bandwidth Monitoring Event Configuration
To:     <babu.moger@amd.com>, <fenghua.yu@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bagasdotme@gmail.com>, "Luck, Tony" <tony.luck@intel.com>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117582698.6695.3458866624522799072.stgit@bmoger-ubuntu>
 <575bf1d7-8780-8c54-851c-e9849d1815f8@intel.com>
 <5d650c6c-2f17-6013-f63f-49a182961494@amd.com>
 <93d1a26f-559f-63f7-d2b1-e8831a9df62c@intel.com>
 <d970a472-1da3-19d2-bacc-05f4ed02992b@amd.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d970a472-1da3-19d2-bacc-05f4ed02992b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0098.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::39) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 260a8903-604a-4e5c-f5e7-08da86e03955
X-MS-TrafficTypeDiagnostic: DM6PR11MB4041:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3i9AFBeBOq/LFdJQgMfbB5ndCvML9HvT5aY6Q2IqltlhoyrVs2yD6GpHK56V9IUlJzj0bXRQM5iA60dmffx00zyH/bqo/40mQqwIhNu4BBm7GT9TnNudZQJih+64TFgAbqaR6UfiJ0nGS97Zzn8BvLYZdXk3EZuNDM7yA+O3Jh5VZhTLMN0BgAwLoxw5qFjKNGkmQCX32aoS+OcR3MtL973ZYPrJmhwcwjdslbnI1lx9Rr6i0Wj+gaggbzB11vspiyAXxKdMQbOPSMRWRpfoKki7c+HLqEpp5rLctA0/BuBEmtbGqAp1qd5/7e8IiWsDJfYH+yiN79xJEtM4NKcTdd2v9l42sC2qd6thuHog6SwWtU/C+cUDNDjznYZlMsnzw1HyAFzcBeAJBhTYwuvxanidhimXvLD0GhuAv4566AXpgaNVyXN3fA+7wpBL+ARswS5VbTRu3Z5LexT3hK+gt+oZsOMmKjYPSGac6ORj75FbE4BN3SXYntPCZc2s6cDxp9ZVDSNqjRsQVc8poPrm5gneIBS85YvWQGy+7uAj+kEagHZ38A6Me+vbQ7H7d8SxPLwiJaz7lF20vQm7BZ+m932VylEHUTo2xGBKs+BPsUk39wf9aQhqky9QI99CNZqcY7FtxcneeePy3XloEaKfwJAKXeVrlIWwkJ7MWCJpILU2NX2quQZwqZQELS2TNacfC1WDFnWjrEu9dCay6czloN0AUwHFoKddAC6szmz2EHuyTeYmM7MLNH7dFhx1S4EUdSCgNHN5P+Fri8oegogx/A1JdGQPBsGArl9XgxuAPtXYqJLXi0hjTKumZ7kwRVFSZgedX0IXgIJuE1HZlRKLQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(366004)(376002)(39860400002)(316002)(5660300002)(7416002)(8936002)(41300700001)(53546011)(186003)(26005)(2906002)(36756003)(31686004)(44832011)(6506007)(6512007)(2616005)(6666004)(82960400001)(86362001)(31696002)(83380400001)(478600001)(66946007)(66476007)(66556008)(966005)(6486002)(4326008)(8676002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFUrbUlhN3Jna3ZHNnBmWlQrMk0ydDNtcktQOTN6S1pCRVlDS010N3JNenlE?=
 =?utf-8?B?ZG9NVzFIdWEwMERnNG44RWRjRVZZdWU3ejVvd2VSZkZVbHVJcFhsbkhpWmtr?=
 =?utf-8?B?eXN4SCt2TVlrMWRlZ0cxSjBoSUhsZktWWU9BQjU3TzMyVnhaK1hKTXpCVCt2?=
 =?utf-8?B?ZFVUY2tXbmdpTU5SVlNZaFZUMGxkL0wzaktsYXZxT3NFZzg2N3ZJa3JHVm1Q?=
 =?utf-8?B?Rzd4VkdvT2hFYnJUYkhrRzlPaCtZT0J3a3RpNGJJM3dQaGR5RVpRSDZmUlFU?=
 =?utf-8?B?RSsxS3F4MTN6ODlhUi8vNzNOcWphVXFiM2dQVlVpQTBFbktwV3VKRUltQ3ly?=
 =?utf-8?B?RjJlOGpOUG1KL1NiaUdNdVlFTUtKdVVkZU0rWlJSQ2wvZFNSb1hBMml5d2d3?=
 =?utf-8?B?TEdQUEFYSXFiTW1RQU9kKzJwVWh3elpTcmJJQlhjSkZ3ZzlOeEJacHdzUnk0?=
 =?utf-8?B?Y3g4ZlhCL1dSZkpWNVIzQXFOaDFicUNEZ0Z1Ym9aWjFEeFNUQzZmeDRTU1ZS?=
 =?utf-8?B?clBRUktTcDdNdUZzMFJjTlgwNGVNNU1oaUl2ajdycUdjT0Evak9yZjVybGJC?=
 =?utf-8?B?YTdpTUlPUlFiamZ3UXMwemdlUGI0ZzB2UUpvZnh6Vk5PNlpobjBGcUNVSVRV?=
 =?utf-8?B?MlJINGxpbUxNM2ZPYUNmcnVrTDFDVCsxNTJJZ25UOVRQR0I3b0NWMWE5NXRp?=
 =?utf-8?B?WUQwTmFPNkVJbFBqYWJWa2p2NHY2TEpmWlVmUERxMFZ2N0ZDZHVZL1dRT0Fy?=
 =?utf-8?B?byt6eEpBVGpQRjQxOHMrYmZCdDFhM1VXcDJBV3JkejE1Zkg0TCs1VGRETkNE?=
 =?utf-8?B?MWZCcHJNeWg4N1kvcTRtUEU1bVZpR0J4NjF2clZIUEQyVVNQd2RUcCtqY1lE?=
 =?utf-8?B?K2JPQS8zYzdSQUlIU1BVTnYrTThaaUFFcyswT3I0dzVHMjA3cjkyK2FEOVpC?=
 =?utf-8?B?aWNQMTE0eTYxb0s2b2NiNkFmL2t6NTBTVkdKTk1wejdENXQxZ3JBL1U1ZW5p?=
 =?utf-8?B?NVVIbFFUKzV0TGRjZ3VhME5lM01wcG5aeG5VbXVwTHFqSDdSQUJvSlgzTVNT?=
 =?utf-8?B?V1gwTWdNMmNTc0xIOW02b0pkZUZodEpTekdWb29ueG1PWXQ3QS91OVozbnVY?=
 =?utf-8?B?d29YVzJVNHpGNUpuOWhVMU1IODNUWitwSkhPNHRnb3l4SUFXQXJza1BFcktl?=
 =?utf-8?B?ek1qaHR4Zy9yTEgvVmtibVF5a1B5cnBpc0dFNVdldTVLSG9PTTA0VDJ1MEZj?=
 =?utf-8?B?a3A2dkFmWnVSR0FJckhXcENHNlMxM0h3VlpEbjJwcUFaMlVZaWljeUdmR0dS?=
 =?utf-8?B?SFhKR0xTTUZUZ1o0NDdPaUZsaUN4OHlZaUROWjhiRml1WTdMVFMvaDVwMGYv?=
 =?utf-8?B?NlZKQnJmS0xIcTBDUHpSZGhkUTgzQjFVcVdtYmNuNVRlQ0JtMzcvZ3hnUXhN?=
 =?utf-8?B?dHhoU2xNQURzTnR1QWxTbmVTN0RJOVJNNHZ4SmUzOUlKRjBINUNrUng2anVj?=
 =?utf-8?B?anYvbzJaV2pYTlpPWEgrNzdqQmRrOUk3R1NwVmlsZ2tQZ05ac2phdFVEUWRZ?=
 =?utf-8?B?TG56WEplQW1DUUNtbWRLejhUcEhESmJrKzRrcDAwb2JVa204U3hDc2NBaVFi?=
 =?utf-8?B?K1VxOGFSVmlwYWpVSzVVaFRnY3hpN3BBUzVqL1ZlMlJPVnhrUjlPclRhVXF5?=
 =?utf-8?B?YVRPR0o2OXV3QXhBKy9UYzRkQWp3WDY4Y2piY1VQS3FGMDU3MGdrUDFwUEty?=
 =?utf-8?B?VGlNRXFWZ3VmdzhMTHdGTEQva25QdElSYVpodWd5UWlDQ203cFZYWGxyTVY0?=
 =?utf-8?B?TXZ3K1pNVTluWU83MXVITVVWNzdKVmdZVDY0VmlHQ3lFOVRIdVFsQTg0ZkVI?=
 =?utf-8?B?T015c1dBVWVkdDRpQk0zNzExcTh2YzZMR1g2b1JZRUFyUlZJZUhMbWdUeGV1?=
 =?utf-8?B?MzZNaU1CekFYOS9XcUJtLzRNOXRPNHlqUit3eEFBTGNRY2M0UllUbzdaNE5V?=
 =?utf-8?B?OTRvNHV3Qkkrdm9CcUM5TTFjSGdiNFpOMkZyWEhTZzFlRzhRS0N2WXFpdklu?=
 =?utf-8?B?Y2tBYTY5ZE5BZS90ejRUd0Y3UTRrK0lWbGJTa2c2YkZOTm5vRXJQM242cHVN?=
 =?utf-8?B?WDY0ZnZldmR6TzV5S3RWWDBsYmFSeGhaT3ZudDhxak9ZQy9mclB5ZGZySks5?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 260a8903-604a-4e5c-f5e7-08da86e03955
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 21:24:42.1889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNExxcJuMo/9hfnfdcvDnssrplcOYieJHLb66qAuZ64vqRGQJPNyCCMbU3IhvSfCnPCZQPM71K00yg03C2IvM4B9kg3Bm4s4DuxnBhNM93I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4041
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/25/2022 1:44 PM, Moger, Babu wrote:
> 
> On 8/25/2022 10:56 AM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 8/25/2022 8:11 AM, Moger, Babu wrote:
>>> On 8/24/22 16:15, Reinette Chatre wrote:
>>>> On 8/22/2022 6:43 AM, Babu Moger wrote:
>>>>> Newer AMD processors support the new feature Bandwidth Monitoring Event
>>>>> Configuration (BMEC). The events mbm_total_bytes and mbm_local_bytes
>>>>> are configurable when this feature is present.
>>>>>
>>>>> Set mon_configurable if the feature is available.
>>>>>
>> ...
>>
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> index fc5286067201..855483b297a8 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> @@ -995,6 +995,16 @@ static int rdt_num_rmids_show(struct kernfs_open_file *of,
>>>>>       return 0;
>>>>>   }
>>>>>   +static int rdt_mon_configurable_show(struct kernfs_open_file *of,
>>>>> +                     struct seq_file *seq, void *v)
>>>>> +{
>>>>> +    struct rdt_resource *r = of->kn->parent->priv;
>>>>> +
>>>>> +    seq_printf(seq, "%d\n", r->mon_configurable);
>>>> Why is this file needed? It seems that the next patches also introduce
>>>> files in support of this new feature that will make the actual configuration
>>>> data accessible - those files are only created if this feature is supported.
>>>> Would those files not be sufficient for user space to learn about the feature
>>>> support?
>>> This is part of /sys/fs/resctrl/info/L3_MON# directory which basically has
>>> the information about all the monitoring features. As this is one of the
>>> mon features, I have added it there. Also, this can be used from the
>>> utility(like pqos or rdtset) to check if the configuring the monitor is
>>> supported without looking at individual files. It makes things easier.
>> I understand the motivation. My concern is that this is a resource wide
>> file that will display a binary value that, if true, currently means two
>> events are configurable. We need to consider how things can change in the
>> future. We should consider that this is only the beginning of monitoring
>> configuration and need this interface to be ready for future changes. For
>> example, what if all of the monitoring events are configurable? Let's say,
>> for example, in future AMD hardware the "llc_occupancy" event also becomes
>> configurable, how should info/L3_MON/configurable be interpreted? On some
>> machines it would thus mean that mbm_total_bytes and mbm_local_bytes are
>> configurable and on some machines it would mean that mbm_total_bytes,
>> mbm_local_bytes, and llc_occupancy are configurable. This does not make
>> it easy for utilities.
>>
>> So, in this series the info directory on a system that supports BMEC
>> would look like:
>>
>> info/L3_MON/mon_features:llc_occupancy
>> info/L3_MON/mon_features:mbm_total_bytes
>> info/L3_MON/mon_features:mbm_local_bytes
>> info/L3_MON/configurable:1
>>
>> Would information like below not be more specific?
>> info/L3_MON/mon_features:llc_occupancy
>> info/L3_MON/mon_features:mbm_total_bytes
>> info/L3_MON/mon_features:mbm_local_bytes
>> info/L3_MON/mon_features:mbm_total_config
>> info/L3_MON/mon_features:mbm_local_config
> 
> Hi Reinette,
> 
>  Yes. That is more specific.
> 
> So, basically your idea is to print the information from mon_evt structure if mon_configarable is set in the resource structure.
> 
> Some thing like ..
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 83c8780726ff..46c6bf3f08e3 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1194,8 +1194,11 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
>         struct rdt_resource *r = of->kn->parent->priv;
>         struct mon_evt *mevt;
> 
> -       list_for_each_entry(mevt, &r->evt_list, list)
> +       list_for_each_entry(mevt, &r->evt_list, list) {
>                 seq_printf(seq, "%s\n", mevt->name);
> +               if (r->mon_configurable)
> +                       seq_printf(seq, "%s\n", mevt->config);
> +       }
> 
>         return 0;
>  }
> 
> Is that the idea?


I do not see why struct rdt_resource->configurable is needed. Again, this
is a resource wide property with an implicit meaning related to only two
event counters. Again, what if AMD later makes the llc_occupancy event counter
configurable? How can resctrl know, using "r->mon_configurable" whether
it should print mevt->config? 

How about:
		if (mevt->config)
			seq_printf(seq, "%s\n", mevt->config);

As I mentioned in [1], mevt->config can be set in rdt_get_mon_l3_config()
based on a check on the BMEC feature instead of hardcoded as it is now.
Or, if the string manipulation is of concern the hardcoding of mevt->config
(perhaps then mevt->config_name) could remain and a new mevt->configurable
could be set from rdt_get_mon_l3_config() and then the above could be:

		if (mevt->configurable)
			seq_printf(seq, "%s\n", mevt->config_name);

Reinette

[1] https://lore.kernel.org/lkml/c5777707-746e-edab-2ce2-3405ff55be56@intel.com/
