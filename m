Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117EB4EE188
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbiCaTQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiCaTQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:16:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D9A265B;
        Thu, 31 Mar 2022 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648754074; x=1680290074;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X8hMiD65BwBac2nERlYNPwdcnZ65NrE+HSRCKpU0Hps=;
  b=fbmPUaWGbzp2VRcp3Rxt5vi6Altj1k96RkDJH+l7L3Jz9QCn4keiUPvi
   jmBxHsKWTi6oSo5Fzg0UAol6/7TDt9FBWFka2taW3mCd9SgkVg7lqkvJF
   186Bs/IRl+g7fIoTVo0VqdQE15PM+g0fd0a2DwKCwbHJHPTLM0dgJ0cy3
   i+eofbJQvCXdPD2MGvsTOCs3lNEzkWB3RDHhGLfKKhVfOkabPQSa6BY2J
   nRAEChLQ1XNtw0MDiwTudw5WBp1fMfzKf1OfpxNKGkioH/TRwSzzN++dm
   JbHODSIk/f1ojoFA0gOjd7hgsxPqzKTZonGZaLw/3Bs3n5mL7DWMbREr+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="240521030"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="240521030"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 12:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="586554951"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 31 Mar 2022 12:14:19 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 31 Mar 2022 12:14:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 31 Mar 2022 12:14:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 31 Mar 2022 12:14:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjIAVvjFvWK9Kw6qaVDzfS4S7Jrl9HOu55U8/eIdqOIXzwZ48W5dvxDY3exKJBIAnS5fFe5Y1u0aCkH7LjWLcNVAkO3xAdwGchPNiudzAcGme0pWhqceoLDaQwtvPFrAAQ+YdsOWX0HJWku7nqCGrAuM0UyNlRynGmSTLgttpgI9dbbpmuoSCAtk6SeSwcczgB5rp10JBRHu2+voLYXz7d4sZGPgSD5jLlbjTmtpxlj3ht4Hw6LrWSiQzd5FJDCqPYWuwkdzuVnqoeYfII+m16H1jXB99kMd08ulEs1p+z9BSGxTh/XIjpKqTUsFwCcEpxInjujZr84bfdrXaXAEPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qw64XaH4j2y/C66B9yPgRrbgIOri6i9IyHCrleZ9qsM=;
 b=MlncdiMQce0oDSC0S0UK0L814TT1wj8N2JbBqYsLR/WDemFiGa8Uq9qXBHTzR87zO2F+wgvAGVXtWkA7b047EyYPpUVdQpSg63nlMD1LthcfFVtbqqMuwF546paCWmP7A7W0naHxoS9bTNWn5EKbdISrWUTW9ZzZ3OEsrkoGpjii7QO4bevKOhJm25qTb1PEL0FVbfAEzNTrrTnjViNRI4MwFU/Z/JwAIJynPUzpmYR8F0XifUrdziDwbfPWE09kbPCf3ZQfR1sTJfZWzlAeGahnHwv4PAJEmN1E5yqOx6BbX3Q9ZyU0B9zgo3yFk5CyyFfabT4SBklxxWi4W+kpcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by CH2PR11MB4438.namprd11.prod.outlook.com (2603:10b6:610:4a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 19:14:16 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::fcb0:5d44:ef18:7b3c]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::fcb0:5d44:ef18:7b3c%5]) with mapi id 15.20.5123.018; Thu, 31 Mar 2022
 19:14:16 +0000
Message-ID: <44ef1183-c3f1-5ada-c127-710ec116e559@intel.com>
Date:   Thu, 31 Mar 2022 21:14:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: Bug 215715 - PCI device (iwlwifi) is not working due to PCI power
 state change issues
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>
CC:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ad13371f-2883-bcf2-a62c-78104bfd615c@leemhuis.info>
 <07541714-5d44-dd84-5ab2-a9ce91bba715@leemhuis.info>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <07541714-5d44-dd84-5ab2-a9ce91bba715@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR0802CA0045.eurprd08.prod.outlook.com
 (2603:10a6:4:a3::31) To SA1PR11MB5825.namprd11.prod.outlook.com
 (2603:10b6:806:234::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 963672f4-24fd-4fb2-7e0e-08da134aa65a
X-MS-TrafficTypeDiagnostic: CH2PR11MB4438:EE_
X-Microsoft-Antispam-PRVS: <CH2PR11MB44380707AB4F974B19C78911CBE19@CH2PR11MB4438.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQKBWmrHj6b3BBN732lBapNPpvILmFLCKcB1yQSQodtHNozeJ9eBc5/BvH/oxS2Qe0KsPS4EVfYgnCp5Bb84hqnIqxlmIGnAxoHJ49SeqHIM8Rl90398t6oMzJypHraIOCIFZ/JiY57Y6dabUHHwTq6tu2IsY3hNzCAGezs4WDoTwQWvmUBFFio68Dy8qpqpKNbXSMXWhq3nvThXFxZNyQDmqRNaINMHMFbfDTHX9nA30UGtLBv3OduMhhv4E6J1chnUUpNzTjB7upIIXhwh+i6f35F1CoUXl6sSfPMIcjGPZ1WUhkZFOyo5lGCk6pHHMee/b0CZR5K1vyor3BRTsCdVvP6sBl1zPDIHZ02jKULM5M332sEQvOiWLHFwd1gMTNb1Ax3G5KlZE3KjXJ3RufkWkRblC1VKvUppD4LbzVIyDKare659fuxh3AlRvI9wtEf65qIlCYdt8xSROf5XMBWbEz1dG+Cf3uGHBN5XHfk/oXl3xTru7oX8VH5pXxFrDSDI0nsP7nYDCWvbEGJKWzVit7viS+2momdeZ/dycx5qYcDITWeNXE64dQ13965aXNInJkZUvCezeB+KORxnKgDtA/oO2Fz+VJNdEQlZdrqxWi6yBQwgt6Ax1DUWhQT329zHvPrpbpYzVnF42D4wCkRqz2i3ROkQEX2YEBv1YIZlowWX4R2dWFMcC+9g7sufeHt5jdEDo2eE2qvbZ0kXcNgjS6WcUt49Sf0w9g13Lsi+Y/LlsUVt0/YNBgwtNeuUFs7m6K3gFfaWRjdGq33ig/E/0+TjZr/iuSaSE3W2paA+7mlgTgaCGdPPuzNM3MGCQl8ugdMdiZny8W3NgCHg/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(2906002)(86362001)(186003)(26005)(66946007)(6512007)(966005)(4326008)(6666004)(5660300002)(6486002)(8936002)(6506007)(66556008)(8676002)(66476007)(36916002)(54906003)(82960400001)(38100700002)(6916009)(31686004)(31696002)(36756003)(83380400001)(508600001)(2616005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlLaGNQZ3p4TThNckdQWXdNQUJtQm9TK0c3OWZnWm9nSXVUaXIwejM3ZXNu?=
 =?utf-8?B?aU9talJ1aTM2L1loeDhPc3dKWkJTb04rK05GOVFuTWp1OWhoNWQ4Q2o5M0Vz?=
 =?utf-8?B?WDFvbXk4RXhzVHdzcmJJOUxsQ2pua05ZZXp5dmRkQk54RVQrYlpsTlk2ZWZJ?=
 =?utf-8?B?OVB1TU9VSmh2a1R3bG9lRFYyVm02a3cwamt6L25oK3lQTE9YcW1wMmRnc3Nz?=
 =?utf-8?B?UjZJK1Q2Q1pxVzV6WGU4U1pRNnZ0MVNvckZYQ0IrRWVJUjFiZHY4MGtPSGZn?=
 =?utf-8?B?T3Fxc2d1dHNna3pYK252RjlkVEc0N0NsL1puU0hUa0FoVUZFQnJWaHIyWE5J?=
 =?utf-8?B?a29VZHhOTFY0YWtyOTlhQkRYQlQ4N1hHZUlKU3JiaXN4b25mZldEYXJHRTl1?=
 =?utf-8?B?cDYwQUlrWXU3bCtoMkIxb0krWTFXNnpDZ2dxSVRRR0txZ0dldVJhdTZxZUpW?=
 =?utf-8?B?MkhLTWFDYXluYUl5ZS9MVGs5Vm5OUEN1dDVhOFlKNE9oZU82azVUQUFSTWRn?=
 =?utf-8?B?QWdFK1B4cktOeFZnOThweXArZXlpb2ZSOWxDQ2o2ODBvSlVNN3ZqTG9RWm9Z?=
 =?utf-8?B?WC9CNm1iejVqVHk5MUR1RHpPdHVWUGFYK0Rxb2Q5YjhNYlNUcXRCQndraVhE?=
 =?utf-8?B?SCtTekp3MGhXZWxNVEJPTUJNMk9tMVF1czRpNGhYUlk2L1cxbFNYTHNXeWpN?=
 =?utf-8?B?K2VUWDFKbkpvMy9raWQwSHRwMFpiQk1tUEMrZUpjeUlaV0l5a2xjV2Fvd09C?=
 =?utf-8?B?eEhxa29MVUc2ckJJZnhaVXpMcG9SbnVSOFNpU1dmUU5MR1Z2R2trWSttZDA4?=
 =?utf-8?B?NGE2TWNENkVDa29wL3ZmZHFINmRzWkllK0RYVlA3MlEyTFBSQVlhMTdSVVNF?=
 =?utf-8?B?N0g4MWxKSFFJZ2p3dTBsUnY3WWFsbWJiaTU3Vzk0RktNWDgvWHl5b0NwZEFp?=
 =?utf-8?B?MG5xWmVhQ1M4VWJFVnpJbUhwR0crRjdjUmJmNyt4cDhieWVLbjFjdTRZN0Rp?=
 =?utf-8?B?K1Rkc3M4TGpkZnZVV1dhQUdLczJCWVpFUGFnY3ZCV1FRM2VYMWsyRjh3Mnpk?=
 =?utf-8?B?Mis2UHloVm1EeWR3Q3NTT0J2eWNKVmM2cXdzaXlrN3kwckxoa01KbVliYlNS?=
 =?utf-8?B?TmtDaEZTVTRyeDJwdXZuU2x3Qm9CeDA3SXpqYTZvbXk1Z2lQRjN1N2tDODAy?=
 =?utf-8?B?RVpiNHNwRDFUQlBkRXdFd00zSFpYMXpZaWRnenNlTmlha0JNWUhKeFhCbWNB?=
 =?utf-8?B?b2RLMWF4Nms0Ly9VQWRFWWY4SjhZVU1tZ291eUg4eVFqcytOK3FUd2JpT0hO?=
 =?utf-8?B?NTBuaXlxNldLR1VXMlJhOFZ2TUVwSUdLMmhySWdNVmRhcnZZQlpzM29abEMy?=
 =?utf-8?B?N0xmQkVzWE5lc25UaHhmcHRpSFhaL0lPM2NtRTZaRVBFZlRsSHEwTUhHZDYw?=
 =?utf-8?B?VmFqTW5FRFF0d2VTWGp4cTRuRHVGTG41dWNOSW0xVEQxT1lZQmZLTUhjMm9v?=
 =?utf-8?B?RmQwT1Zqd3E4Z3loQkxOL1kvRmxqdVpDMUY3K0w1STVXVXg5KzVqeHNIbjc4?=
 =?utf-8?B?SUFYTmk5WHJwZVhUYjB3ZWtXZHc5VFd3Rk9TRGZmcFNTZlYrY1hYVFFwMVJs?=
 =?utf-8?B?Ulh0L2E5a0lzOExMQUdPYi9iMFpnVTVwbWg0UjJsSVdjNzR4Q2RNcmtiRnUy?=
 =?utf-8?B?ODltYUxuYnUyWUdkazVNbVRRMWF5U2M0di9JclE1dE9Sd2Y1SkU0dTJCWng4?=
 =?utf-8?B?eXRIdzRqQWZTbk9yTTc4L3Y0YysvMHJtSFhUQXh1OVBoOS84YnNkcllpcUxz?=
 =?utf-8?B?MG1aazZ4WlY5LzlWaVJud0FCczNKekVDaEVuN29PSmtmOHl0WW9kNllSbjYx?=
 =?utf-8?B?UXJGSlpuUWViNjEyQTVWUmZUY1BTQnlESlh6MGpMb1lMVjllUVBmaEdDU3BH?=
 =?utf-8?B?TUFoNEQ5a2FVWDhMejVrNGtOWlhBK1RhMFFIUHMzci9tOWgvM2tyVGVIUnJR?=
 =?utf-8?B?U1VFOWR0QTNQamYyc1ZNbWllZjlSanFwUTNMMFAzQktCOERDY3RUWEZ3Mm5F?=
 =?utf-8?B?Tlg5VjNMZUJJTWNOKytWNzJrOXRIb01Ddzd3ay94RjlmUzlSWkh5RXVhLzN1?=
 =?utf-8?B?SFNEMTVobGJycmt2T3c1dVd1REJmcTZ6L0FBeU9vckF0MEhvZmEzY0F0NTBl?=
 =?utf-8?B?eDZhOVY3d1hlbjhacVF3TG9iQTE2WFk0b0ExM2h3UzYzcVJaeXFkQUpPZ250?=
 =?utf-8?B?YnhGQVc1Mm42V21wM2lRWnRreGQ3Nlp1Z2VrN21IZ091Y25JMVNPUnB6c3RC?=
 =?utf-8?B?amplVnBOMWM0SEZqMTZMYldjT0lvZUYzS0xLaitVaFlGeXV3WDcvaGl1YlQv?=
 =?utf-8?Q?3XnSuEksbbe6sRxg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 963672f4-24fd-4fb2-7e0e-08da134aa65a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 19:14:16.7833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbcHj75KInGi/CZP6h7HuLJHFJDv3orcYExjKVbhV4XeyOJJRunUAMclC36tYTud5dRWfxEN6yQZ9DWSV6JpUiMgiwuu11p7zC2hxJq0QMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4438
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2022 10:49 AM, Thorsten Leemhuis wrote:
> On 28.03.22 15:33, Thorsten Leemhuis wrote:
>> Hi, this is your Linux kernel regression tracker.
>>
>> Rafael, I noticed a regression report in bugzilla.kernel.org that afaics
>> nobody acted upon since it was reported about a week ago, that's why I
>> decided to forward it to the lists, maintainers, and the author of the
>> culprit. To quote from
>> https://bugzilla.kernel.org/show_bug.cgi?id=215715 :

This turns out to be a platform firmware issue exposed by the commit 
indicated as the "first bad one".

It is being addressed by adding a quirk for the affected platform.


>>>   Stefan Gottwald 2022-03-21 13:31:43 UTC
>>>
>>> Created attachment 300589 [details]
>>> dmesg output from error case
>>>
>>> We got a Elo AIO i2 device which most current BIOS where WiFi was working with Kernel 5.12.x but stopped working since Kernel 5.13.19 and newer (5.17.0-rc5).
>>>
>>> The kernel error message is:
>>>
>>> [    3.419766] iwlwifi 0000:01:00.0: can't change power state from D3cold to D0 (config space inaccessible)
>>> [    3.419781] iwlwifi 0000:01:00.0: can't change power state from D3cold to D0 (config space inaccessible)
>>> [    3.419975] iwlwifi 0000:01:00.0: HW_REV=0xFFFFFFFF, PCI issues?
>>> [    3.420911] iwlwifi: probe of 0000:01:00.0 failed with error -5
>>>
>>> The issue can be solved by adding the iwlwifi driver to the initramfs so it is loaded much earlier and seems to work.
>>>
>>> To narrow down the issue I did an git bisect between v5.13.18 and v5.13.19 mainline kernel version which got me to following commit which if reverted fix the issue on this device.
>>>
>>> Reverting commit d0660d8ab123ea471064f0828f290bec9593e16b : PCI: Use pci_update_current_state() in pci_enable_device_flags()
>> FWIW, that afaics is d0660d8ab123 ("PCI: Use pci_update_current_state()
>> in pci_enable_device_flags()") in mainline.
> Sorry, I made a (obvious) cut-n-paste error there: the stable commit
> mentioned by the reporter is 14858dcc3b35 ("PCI: Use
> pci_update_current_state() in pci_enable_device_flags()") in mainline.
>
> #regzbot introduced: 14858dcc3b35
>
>>> resolve the issue also in the newer kernels. Seems like the function platform_pci_get_power_state is always returning PCI_D3cold on this device also if this is not true.
>> Could somebody take a look into this? Or was this discussed somewhere
>> else already? Or even fixed?
>>
>> Anyway, to get this tracked:
>>
>> #regzbot introduced: d0660d8ab123ea471064f0828f290bec9593e16b
>> #regzbot from: Stefan Gottwald <gottwald@igel.com>
>> #regzbot title: pci/iwlwifi: wifi is not working due to PCI power state
>> change issues
>> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215715
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>
>> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
>> reports on my table. I can only look briefly into most of them and lack
>> knowledge about most of the areas they concern. I thus unfortunately
>> will sometimes get things wrong or miss something important. I hope
>> that's not the case here; if you think it is, don't hesitate to tell me
>> in a public reply, it's in everyone's interest to set the public record
>> straight.
>>

