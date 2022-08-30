Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1B5A6896
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiH3QmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiH3QmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:42:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF9882D23;
        Tue, 30 Aug 2022 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661877737; x=1693413737;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LTuZNOnTP+P7/gVyHhoMMVVMW7lU7Mk0Fa6ZOwh/1ug=;
  b=jzDsptGgmwO6LqAxWDrjAv7HGm0J6Vqy7DyaTQSwJWJf1opAOO7Ab1EG
   JcMdq3ES1bXfWh0jTc/NxLReJETn0jXAnU28IfQuRPRIPfwcxHbiFfa2p
   V3fj+KhLOC0/WcQhjWkl/NgbiHsAdML4msRCtlQX1kvlaCT8K0Q4Q3KfI
   xrKL2iHFOsAPEJkTGy+s7QcCNvlZS0zOZDuisTLcb9p+CCAyYOAACBND4
   Z+sxcIH/8Vhp8LiO4u7ht3hCSuJ7EjeGprblj2SXu5lxN6cXC4kkCDEDh
   jN5WhHz6LPvJbTzsuTsudq5wU97PTcsGdp1BVmVPiIoo2rSSoHqUkyaDJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="274986788"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="274986788"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 09:39:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="611777144"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 30 Aug 2022 09:39:44 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 09:39:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 09:39:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 30 Aug 2022 09:39:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 30 Aug 2022 09:39:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/tsWE2PaTJLQGmR7dPcRvsL6VoYtQ/rrq6Ux2OM4rQMMDDRSISfP6DDTTT9+Vme0JUBnW78DmvyZRevMtXHrIi1o0D5ZHvpjrGiyX4JHQk6oqIxagnLHg0oRlNEpw7hkpuUR2mTBfXZ9HrF4lIaDeXTV0lR5+5PLFUZ8aM6SxA9mzuLq4F4VxNLZWoSqAf3VE83GVvasqVxxVc1H/Cr9Xt9aoZQ6yJue82+S5AaZR7mZtDIi2M5VNhErlVC7Exh/VRbzJuEifPnj29QXen8WA3c4DW9+6Xci/tnjSeRGl/OEaYH3/hUsPu5g43Wk2OKoVn1bJM/I0JG6IZNyhdL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sWVicqTzFI68R39QDPgdbYehNX3+EpTMG3sLTJeTbc=;
 b=cwqE20nUxAVjq4d3EJxdT0ls/wdzGyJ0vbMqXYVPsqvDg3NumS5heSEZq8vpVb3S3kFvz4R6Vsaq9E5UKAiiQViijrD6uNWZi1gvLwS68Wt6W1S9UJCOvrxu8nDZKucvEPP2oxVGGkeP+5qMWVOStIb1tza4BPsjXlv44BqQ2/8SY9rECzNnmQhl99LTdH9hEj9cO90ZFghkgKYmxnyo99YsL0ge76kmpxxf74kERj40mxYCk6+L5VGzhv4Sb2ly7rOtDZOUvqbBgk8eIyvftuhSGjS12eJmHwjJvxNXIiQmRPD+fl8iOM/OdBn8G+v/IPfGTGZuoO9tZ0RlQTgADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MWHPR11MB0080.namprd11.prod.outlook.com (2603:10b6:301:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 16:39:40 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 16:39:40 +0000
Message-ID: <59259155-6c51-a750-216a-ebbb0702d200@intel.com>
Date:   Tue, 30 Aug 2022 09:39:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v3 02/10] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
To:     Babu Moger <babu.moger@amd.com>
CC:     <bagasdotme@gmail.com>, <bp@alien8.de>, <corbet@lwn.net>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <fenghua.yu@intel.com>, <hpa@zytor.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <tglx@linutronix.de>, <tony.luck@intel.com>,
        <x86@kernel.org>
References: <9965edff-c558-2962-4aad-3342480026bc@intel.com>
 <20220829232554.53763-1-babu.moger@amd.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220829232554.53763-1-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0044.namprd11.prod.outlook.com
 (2603:10b6:a03:80::21) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db89522b-32c7-4892-1bda-08da8aa63c0c
X-MS-TrafficTypeDiagnostic: MWHPR11MB0080:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42Bn4AsJbCQSt5rR6oYz28Dob1WT9bt0C0Ch3mj0vA1aBZQmWzsRqOnRMmAzyWzX7d1BMhP1B78qTNzq8PFvduxizsXX9X4BPBNEeWGHWTexlQwwy5U9Lkb1fNYvXgdn0L8jAY34gUHQ1ZER6EaNJx0ifLSX2UxvofGkiqzZyRdu4qbwB3xVEN2CSx/8gjTIS3QexMWNpfxiAM4ZcBeW8gB/+IUyV90PwUs1fh94d1HOLCsflgp6rTxa1w5MYJ3wBlf3QoXTKDXfXtdeudyzpCy3ohbXGscarAhGIRR3YQtVROE5c/qDOh6ATTr/2GytRUlgDx9G8yYYflmNeDUDo2h7LA5PxjO1pOpLnXxJGpEtMJrw47RqWCeQiPevGpSf6q7625waPxYZX35+USM3czul8UvagWdptXyjNGQC9T5rNUS5ZJSe2/52KZQORPqzfkhvPSUKh3v0HF5B4U+vmqQGuv39sjucHkx0sSguf3YkXVIy4icd71/pwyq7wHprohrBvce/43nlf2tSo/OahPSLnnKqcKlFn+cto8dvWpT9ZZORegfUPHESGW1fzAVz0w0kX+39eP0TSvBZDl2GCpfMbOrYMtpDmRG4Hloz4+EBEk5QST09yisW39GxhixcsnsUWcTG1fuQ6n8T1dcza5GFHItvX22ToRRPekdJjYI6uRxp1kpBD8KtDXCjJd3ByrkeD+c8XkFccrTmlxEluqI3x5K7taT90qI1ULfjrK5l9iboLWuFePE/T5Um4jCZCg1ugXXapGhxSV3btXiy3lFF8Ips00evPbWhChDiHz3RDFYSavdQsX1JmJhRecSxzOSccMN7Q36gzRg/buAnWZGoSuR9Df98QYfOugeJ4gA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(39860400002)(376002)(346002)(8936002)(966005)(8676002)(66946007)(316002)(66476007)(66556008)(4326008)(31696002)(31686004)(6486002)(86362001)(6916009)(478600001)(5660300002)(36756003)(41300700001)(7416002)(82960400001)(53546011)(6506007)(2616005)(6512007)(26005)(2906002)(6666004)(44832011)(38100700002)(83380400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHF4TTd2MlZ4UFRqTEx4NnRBZ3MzajZqY1JicnQ3bHZpRHhFZEFCWFNEMVpW?=
 =?utf-8?B?NXRsR0ZLVWprVEVBQWg1bmFEVXhUaloyYzJkY2lOQW12VTg5SkdmalBnUUtK?=
 =?utf-8?B?VDJXTElzVXdxUjFocXZPcDUyc3c3YWVuK0FPWk1vVUlEUHdKVVJYdC9Lcml2?=
 =?utf-8?B?dHZYTWVoL2o3R2crajJrVmFMZGthVUZ1WDBUNWZMV1dkdmlYVHEwaXExNG5S?=
 =?utf-8?B?bWcxbDZNb1RFSkdUeVUrU1ZLZXh5T1ovWkRKVzFVVFNYMENORnlENUdtQkFU?=
 =?utf-8?B?b1c5VDRncTRJT2V0Z2V2YldvTmttUzdrWDlCN1VCWHdNdkxNdTZ3TWExZyt2?=
 =?utf-8?B?a2s0Vzh2ZWtmRzY4RkFqWlV1RHEwT3dqMDBnVXJ5MmFtY3hOM0VjMSszV2ZI?=
 =?utf-8?B?b3E2dnVwd3hmREVLbTBabjVFVzNSL3VTbG5tOXN4WmxxVTUzWXd3Zm42bFJM?=
 =?utf-8?B?RlJaUWZleW1kWkJZVStweDFaNVg1UE8wTVNSVlgxaXUzaTRHbHVZZUwrV0hv?=
 =?utf-8?B?Smd5ZnVydGJNMnB3SFVXaSt0WDU4Y2VTRzlXR0dYMVhNWUd2ZFhLL3RMSk1z?=
 =?utf-8?B?czhTUlIvOXhPaFNtZWdxSUZ3dVZGYlV1cFJYYUVDZFVaaGtCaTN0Q3d5d1Vw?=
 =?utf-8?B?L1ZGS0tzSktvUm9pNUU4SHBwUWVGNFA2QkM3M3JrcllpTmpRWllNTUIxUTdx?=
 =?utf-8?B?YVpsK1J4OHVObjNnbVA2MWxYVFZpc0FlMGJQQTY4VFpRTG9XRGVDcXlGM3lN?=
 =?utf-8?B?TXBPRTh2T3hsalZhQ2N4TUZYNjc4ZDMrK0xWc0JoZHhmcjlZaE1YMmd2KzdJ?=
 =?utf-8?B?TnZpOEZodGlzbmZTMU9uUmQzbmNCVFhkZFJTVkRZVTJUYjZYd1RwQUlyN0ho?=
 =?utf-8?B?Uk83aWlHU29WSUhNUHMvWWlZRENUVWlHTHpkOG9kRGJOQVZocjIxODUyS09l?=
 =?utf-8?B?bzJDT0ZQT0c1ZjFzVEliN3pkUVlYVHpYeWR6ZjlDQmk1VXgydmF6azA1RytE?=
 =?utf-8?B?NmxmS3VZM3I0T1JoUkE0b2F4TWVEb3lVUWwxMUxSRld1MmlUOHBMTXN0MWhp?=
 =?utf-8?B?b1I2Zll4Yy9nWDEyQWN3N2t5WUNuYUZiQkJQcmlMZ2J5ZHlndjZKQngxVVor?=
 =?utf-8?B?VXhzNzJCVWdPbElkNmU3K3lmTDVzU0JlUldzdjBWQzFBMjlSbDg5TUxWWjZ4?=
 =?utf-8?B?M3RCMVA2MTRlZ0ZKelpVTFRFZ0RSTDlpbElNc0UyZzNLM2FQSzZWNk0zLzNV?=
 =?utf-8?B?OUxpblNjSEgwMGdWUVpYTVVNU3RwL0p5aUZoVmRRUGFkZjJySWM5MWoySGlD?=
 =?utf-8?B?b0ZzbTUvNWVRVXdaRW1YM0FsRTJpTUJZZTI2VUJrUm44MUw5ZU1xdXV1ZHEv?=
 =?utf-8?B?ais1U0plMUs0RHJiaitCck92bGNKWFZmOXp1OGh5NDhYRU5hUStyaURqdEk3?=
 =?utf-8?B?L0E0dEtJRk43YTdyY3FzdFM5SUJFcU92THpWMFpSN3dSSDd6eFN4YThpcmdM?=
 =?utf-8?B?aTFidjVDNTZJdzRIcmFaT1pSYkR3YjRCVldoUFVrSWVDY3JWNDZFelhPRlNq?=
 =?utf-8?B?UDM3SnMwMjk5TkNEMFJVWWJ4OEpMajRKOUlPaGdCN21wc0hqb0o4NlpyTkFT?=
 =?utf-8?B?dyt0ZmV6eldxb0dMOGVwU1ZqdmJBS005L0FpbHJJbUUvVm9OOUNiaVR3bVpF?=
 =?utf-8?B?cXdaMzdrSHBiR0NPa0NPUlFzOVRwNjdWRUtDeFloaTdWbGMxK3l0aDhPOGdT?=
 =?utf-8?B?cjZJS2tRMTBteU9WSnArTXAwWlJNZ1VwdnAwKzllZmhNZUVuaXBOazkrQ3dx?=
 =?utf-8?B?c2JkVzdDODUxQnR2M1Z3bzBCc0dVWHVxRlRtcnhySFNBOXdQWVZDSFdGVDJN?=
 =?utf-8?B?dndyZkgxTStIYkh5NDBSTDA1YnpBT0ppdXVKOW0vVE01MUcyWW1kc0RKUUkw?=
 =?utf-8?B?cTJwaUh0UHRmSmIxYkdBTU45aHp3dEFaWE1pZzVMMlJtZkFGaURvS3Rxd0pu?=
 =?utf-8?B?TkpHelV2RW54bTVJSUpNS1pNSXZuUExDeG54UFFQQkw4M0hidk9KdVFaVC91?=
 =?utf-8?B?dFlFajh6SkVEc1dpeHZXMU9QWmdBdmhCOXJFajVTeThjR3hXalZvZGhnMVh2?=
 =?utf-8?B?U2V1TWt0czB0SFBHdlAxOTdsQzIxRWR5QXNLK2pQNVBuMG8velRkeEY0ZTVP?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db89522b-32c7-4892-1bda-08da8aa63c0c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 16:39:40.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkgHxT+ENw/3tpdlcy/Y7ec1p1JnvQnTYNyyquRD6hsKfku+rEC8vYJhHPPpVli6t9RyZRKYgsCXpMMYZtM+uAyTCgwUxR50n+tECRdRO58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0080
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/29/2022 4:25 PM, Babu Moger wrote:
> Hi Reinette,
>    Some reason this thread did not land in my mailbox. Replying using git sendmail to the thread 
> 
>> (snip modified links)
> 
> Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
>> When you say "in this case", is there another case?
> 
> There is no other interface. It is only CXL memory device.
> 
>>
>> Should "Slow Memory Bandwidth Allocation" thus be considered to be "CXL.mem
>> Memory Bandwidth Allocation"? Why not call it "CXL(.mem?) Memory Bandwith
>> Allocation"?
> 
> Checked with our team here. The currently only supported slow memory is CXL.mem
> device. As for the naming, the "slow" memory landscape is still evolving.
> While CXL.mem is the only known type supported right now. The specs says
> "Slow Memory Bandwidth Allocation". So, we would prefer to keep it that way.

If you prefer to keep "Slow Memory Bandwidth Allocation" then please also
provide clear information to the user on what is managed via "Memory Bandwidth
Allocation" and what is managed via "Slow Memory Bandwidth Allocation". This
could be in the documentation.

>> I am not familiar with CXL so please correct me where I am
>> wrong. From what I understand CXL.mem is a protocol and devices that implement
>> it can have different memory types ... some faster than others. So, even if
>> SMBA supports "CXL.mem" devices, could a system have multiple CXL.mem devices,
>> some faster than others? Would all be configured the same with SMBA (they
>> would all be classified as "slow" and throttled the same)?
> 
> I have not tested the multiple devices with different memory speeds here.
> But checking with team here says it should just work the same way. It appears
> that the throttling logic groups all the slow sources together and applies
> the limit on them as a whole.

"the throttling logic groups all the slow sources together and applies
the limit on them as a whole.". This is valuable content for
the documentation about this feature. Could the changes to
Documentation/x86/resctrl.rst be updated to include a paragraph
describing SMBA and what is (or is not) considered a "slow resource"? 

>> I do not think these devices are invisible to the OS though (after
>> reading Documentation/driver-api/cxl/memory-devices.rst and
>> Documentation/ABI/testing/sysfs-class-cxl).
>>
>> Is there not a way to provide some more clarity to users on what
>> would be throttled? 
>>

I repeat the question you snipped from my email (please don't do that). Could
you please answer it?:
Would the "SMBA" resource be available only when CXL.mem devices are present
on the system? Since this is a CPU feature it is unclear to me whether
presence of CXL.mem devices would be known at the time "SMBA" is enumerated.
Could the "SMBA" resource thus exist without memory to throttle?

>> How does a user know which memory on the system is "slow memory"?
>>
>> It remains unclear to me how a user is intended to use this feature.
>>
>> How will a user know which devices/memory (if any) are being
>> throttled by "SMBA"?
>>
> This is a new technology. I am still learning. 
> 
> Currently, I have tested with CXL 1.1 type of device. CXL 1.1 uses a simple
> topology structure of direct attachment between host (such as a CPU or GPU)
> and CXL device.
> 
> #numactl -H
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
> node 0 size: 63678 MB
> node 0 free: 59542 MB
> node 1 cpus:             (CPU list is emply. Node 1 have CXL memory)
> node 1 size: 16122 MB    (There is 16GB CXL memory) 
> node 1 free: 15627 MB    
> node distances:
> node   0   1
>   0:  10  50
>   1:  50  10
> 
> The cpu-cxl node distance is greater than cpu-to-cpu distances.
> 
> We can also verify using lsmem
>  
> #lsmem --output RANGE,SIZE,STATE,NODE,ZONES,BLOCK
> RANGE                                 SIZE  STATE NODE  ZONES BLOCK
> 0x0000000000000000-0x000000007fffffff   2G online    0   None     0
> 0x0000000080000000-0x00000000ffffffff   2G online    0  DMA32     1
> 0x0000000100000000-0x0000000fffffffff  60G online    0 Normal  2-31
> 0x0000001000000000-0x000000107fffffff   2G online    0   None    32
> 0x0000001080000000-0x000000147fffffff  16G online    1 Normal 33-40
> 
> Memory block size:         2G
> Total online memory:      82G
> Total offline memory:      0B
> 
> 
> We can also verify using ACPI SRAT table and memory maps.

I think that adding (in general terms) that "SMBA throttles CXL.mem
devices" to Documentation/x86/resctrl.rst may be sufficient for
a user to understand what will be throttled without needing to go into
details about CXL device discovery. 

Reinette
