Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8D2528AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343738AbiEPQfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244602AbiEPQfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:35:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0193B3D5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652718938; x=1684254938;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lyf7TN/774j/fqECY1VPlCyMN+2usB/WPnAsbeqc634=;
  b=dsXJdhTsgYUbB3Wqa7rcuHJlLBj6GQef0WmI7Go8JViq2EqtIUdH/1cl
   4SBYDcPD+kGtjaAkG8yRtT8dZSnSzthLeo6msYvkVhCp2bV9CNgk8SZHz
   s2iaomVxvNRtrFTmIF0AY5OL6hqapvG6Mf6yGt5K/MaxWmy9XF73YjpE0
   mgj1DuRT8q/XToWO0T41O42ZLgAcipmOQaSqjzrmNG1jqapIWH8wqykPO
   eaGnp62eeHB5Ean6gNmBR7bMU0KnQOBfKt/wPAFN50WiQSmAJ60diBBmz
   u9S7Ut3zDn/1DXku4l7n4qcOqoo/p4GKacPnJ2PSSas3dVBkHdlaYCe8p
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="250786050"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="250786050"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 09:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="555327673"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 16 May 2022 09:35:36 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 16 May 2022 09:35:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 16 May 2022 09:35:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 16 May 2022 09:35:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUKeBkDzzloqPDH/EHx0GdcaxX8BEUdn2axNLhmFjmVoqs36cIze6YPPw/pYXA3IsNZ4W7oBj4kuFllIb1NwP91JesggzUe6cdEaIN13qLu4pRrF4fbhEEWLLLLTimUXqQ1Jma+ZWKJDHnSynDFMwH+Pgjc0HZZ3wLJpgxVwA6o8B4qnpSnOuscCdTh/KBUQNYF8+DQqdqdbnsFw9T4zNbyacvpwzMegs4cnxzpq31NQB32UDHBtJuBDs2jy+4pndB+wAwaloL2tw459GDYRqyALsw6UV6odc5gYuwmDeNkWgYrED2yrJuUbRs3EP5Yvb0AjHDcnS4eRXpptyKaRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0r64FfztV6RxU+VQw9X5e+Th9xaPttY+EPasSfQIwXo=;
 b=NF+1JvFmhKInTvGJdVKx1g16iIuanQ4ScGQqbkqO05z/TFP5sJDNRBC1YtnIO5N2RpTCFhtqq6Lv7e7HId3FcmDRddaC51H+uJ1snAWFAs8WBElYcPPsknH3wQA3xe8tS3+/y0Mtd8WwHWbWG32HV2jrUujGPWHl1bExCmndFmaWFV3VjuTcR8eD9W36mAQnjN8sok316o/5NXQK42RGtSb6es1R8V6zWJsGUM/GNB3DMKf3/g0IF+jbQvRUvfnawClqYkMdajBLdpwkyMQnLTJo/QaxJHw+5dl/w3/ecXKEmuK+MN37UXJU6AvOB6wqt7ocBpnYJvBOISrdQjJ6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CY4PR11MB1749.namprd11.prod.outlook.com (2603:10b6:903:11f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 16:35:33 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 16:35:33 +0000
Message-ID: <ccbd2401-0de4-d4e1-2e41-92865113560d@intel.com>
Date:   Mon, 16 May 2022 09:35:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH] x86/resctrl: fix min_cbm_bits for AMD
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>,
        <linux-kernel@vger.kernel.org>
CC:     <fenghua.yu@intel.com>, <babu.moger@amd.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <20220516055055.2734840-1-eranian@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220516055055.2734840-1-eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::15) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0ed64cc-cddf-4d7d-8369-08da375a18f8
X-MS-TrafficTypeDiagnostic: CY4PR11MB1749:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB1749A64998994AB667A9D1DFF8CF9@CY4PR11MB1749.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OxrACpIjAygg98Hlph8/gp4mxiu3aWpjDXEi1Q3J3BnLzMp8laXMdIf+2Ohu4+9cPSR9esgWcRbi6G90hviFe6sfyDohFOGNeVRIfB3qzU59y4V24dXdA3gJFhX1esmMbaFMMli6YfwfA/ApYPzSn6MJtoigb2QKP2qF2YGdzZ6hmKfa7qoMkd5vzepo9OIU7Gzou9uKAcqZg+Tk03jc8EL+lDf6rpkFPV6R5juB7e9GQwEBxBcUyUDjqaaLFGZSH9a/E9MtL1PapKClmsQsDTwOuVVf3W0bmtoD+k03IK7lUVRgo7I3NR/qOSmZKOXEKJTemo0+il7RuYtyRZPV8rNpPwpbzgvo4dC7DYwPauJzbHCo5rBAnFivfbEQclwv5e7NExV0pmOgcDWBNjW0Nq5iZiizG8Sd5PVOrUqKPKREHHa3jVdni+2ldRg66Kfo/VO2H+qKg0jg9cNVEOwg5KxCggoLJo4lSQIi0F6/bLS+o48AxRsWJZB4AnhEWtKewkZIWu4voN6V9p2vcI2XdbDwL71UMySQsecI6/A6bdmwT4a6IB/L2lwQy9eyDSSN5SeF+e4xyE8/6h6JgcXmo447eGmlXhFIcvej2GDBsZv5cGWIu+GUP5o8FmqeUnZu5FrzcjcomQwjNeZtOqgCHc2+15rBYooj5RuGi6eaiZUUh8Hq5jJm+TLRHsjAsYfCKFmVqBu3eU0xgU7wSLj6yrk1UZuPDFMuT3WwmAiSj0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(82960400001)(83380400001)(38100700002)(36756003)(2616005)(53546011)(6512007)(26005)(4326008)(5660300002)(66476007)(8936002)(2906002)(44832011)(31686004)(86362001)(31696002)(6506007)(8676002)(66946007)(66556008)(6486002)(316002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEZUWTN6QUh3Z014S2RLTjFzYk1Sakl1eEVjSm5rNmJjVkdWRWtUVEpQSHVm?=
 =?utf-8?B?eUdXQkpSdkZnQW9nRkorTDZaeHBFM2lXcW5ZczdzUmJZdHRpVE1xRjlEYUtW?=
 =?utf-8?B?SEtYT05sOFFZNFhzNXpSYmRMcnF4MGQxZ1RORDNXbERBbUE5NlBCYVYySnJT?=
 =?utf-8?B?MEVRNmlvS1ZrTVQ3c2hSdWpWSGpNdnViWlE1amg1eTBRQTVjS1NBWDBQWjdo?=
 =?utf-8?B?WW0wU0dCRzM0Y28rSHhiYXRyeGJGZjdnSTExeWZDemdZK2h0cnlWcXBycjRs?=
 =?utf-8?B?YjZadjB2Z0pENTVKZTFQMHRKcW1BNFQwanhvK1d4aFZtNWlTQ0h3TUVmVmpy?=
 =?utf-8?B?OENkVk5mY0VmdjJ0Ti9QMk45eFZtd3U2NjdpT0pKU1RsWlp2UWYzdzVRQWYy?=
 =?utf-8?B?SWkraExDQ1Y2K3FhYU5ZQVFUZ1JVMmlDdkhyaGFrRGpDckRHbFRxWDM4bWI2?=
 =?utf-8?B?SnZOSlNEdThDcXNRdnVXM3p5Q0FEOU5aL2QxR1dMbEY4bzlZT2FJMVlsSmhl?=
 =?utf-8?B?TVB3NGxxS3FnYmg0S1VUS1NQaDQ2dTgvdXFBRW84WjhjRlhHNzZ5ZVZIYzgr?=
 =?utf-8?B?Qk1ZY1FzRkVjeEUrZStjZktuQkhuZEdBT2E5WW45WHJJcjN0ZkhRT0ptYys0?=
 =?utf-8?B?b2tzMHNMMEtHZGFQQlZRMjIxYjNPTnQwRXJ6Z2tIektXeDRVbXRpQm5hc0Z6?=
 =?utf-8?B?U2dkUXlTVHlCM1J1eXhYK0N1Z1BjZUJuWjU2RlBTMTEzY0luL0xKOVk3ZDN6?=
 =?utf-8?B?bURXUm9BZUpQTXlSZjNsRS9PcnhVdmJwM2hQbk45V0NCaWdSLzlvUDJZSmNI?=
 =?utf-8?B?anNyeUI0c3B3SGxRL2c4R05yY3VmQUM3dSs1UVR6aTYySGhpaXN2d3l3bjZm?=
 =?utf-8?B?TnJObWRKNDI5MjliUFFFSlhZR1ZMS2c1bDlvMUxFdW1jQzl3WFNISzA2a2Ji?=
 =?utf-8?B?Y2tUUmw4RytobkkvYWZ3ZDlNRTY3OVBtNE1oR3Bya0FJRDVFZUJHakVlYVVz?=
 =?utf-8?B?K1lZZGRXeVNKTFZNTnRxTUlsZHB6TWFXRExIdjhGS2svT2l0aFQ5SFRZOC9D?=
 =?utf-8?B?SmRDQmlpTE91bmpXSmNTQVVZSzBwMnN6V3BBZXk3M0Z0aHBjQ2lBazAzOVVk?=
 =?utf-8?B?S3JwOFF1WjVESiswTlBIc1haMkhIeXBUOVd4YzhURms3Wk0wcEFsNVlwdVdQ?=
 =?utf-8?B?VXg3NjNTMTRYREZVaWF0MWxJUCtiN2Vnbmg3MDlsTVZieEMxVGprRVFKZkQy?=
 =?utf-8?B?QkQ0U1JSQm1mS280Zjk1bVprYVNFNXJjQnlOMTRJREQ4Y1ZaL3lMSGxrOGd2?=
 =?utf-8?B?NEN3TllxYUFWai9VcjZzU3JoQjF3N0FiMnRmNytKLyt4Sk15cm1IYis2NjRS?=
 =?utf-8?B?cTBaSWd6RHpMUGFNelE1bXhMblhvNFpVdFdUNm5hYVlFMVY4RTVnOEdGQnFw?=
 =?utf-8?B?REtySThwZjU0Vm5pUmVLdTJhcFJhd1pQR1AvS1FRNnZPWVRxcW9kS3lXWmlu?=
 =?utf-8?B?YWZWaEhtNEwrTmpza2JkRkx4NHVpUWxqZXJKUkJ1WTFONFpFTThNR0ZHaTd0?=
 =?utf-8?B?Z2ZnVEtuV0tyN3lNQ3V6QkNUVGVxUkNQSElJY0s5ZCtsR3NlbnZMelJTOUdN?=
 =?utf-8?B?T3FheU1vNkg5cFMrTnlUalJBbUhyQzd5dXZ4L3F3ZERJZEV2QjVKbmI0ZXI0?=
 =?utf-8?B?UU9kZ0dnQ1hHUm82Q0Y1aVlNVkN6RkxkQytmcWdEV3RDVkZCWnJmZ3V2MVk2?=
 =?utf-8?B?d09oaDF1NDA2c0o0ZmtxZWtnTFM4Ry9yNThua3ZYZGJzRlJKWkI4c3NYVXhK?=
 =?utf-8?B?SzVpUm1XbGV4NXpINUNmZ3BlcnJxZlhQNS83MFF5UXNOUlM5RzNKNWp4bkZq?=
 =?utf-8?B?NXZxWEM1Rmtxc24wZjJYU2lrZTFUcFZxS01FSWt2Q1ZBYjR0TjZQOGQ4SHBB?=
 =?utf-8?B?a2dnSEphZkY2Qm5ySlF5NUJQY3FOckhNd2hHSTUxcWE5Y2lNTEM5ZEJUeVVC?=
 =?utf-8?B?cVV2YW5HbVBMdDVZby9EK1dUWUNMYWlFbW95NGxnNzZNMWYxMm1GT0Q3WkZ2?=
 =?utf-8?B?dzY2NWc5TkJGQncrZHNrb2hBcEc3cmZZZzFKR1lhUm5PSS8rYTk3d09Lam9X?=
 =?utf-8?B?dms4TlRSeDJmeTRqRS9DR3BVYTlLTEJzUjVzTUlPR1JDVm9XRUUyQytINzFM?=
 =?utf-8?B?Z25RVjNzcTFxUDdRVlhyUUZBalhETUNjR3JFK0RDSm9ka3hHTjFOdUt1NElh?=
 =?utf-8?B?V0dRYTFXY1NMMFVVR3BNT2t6NGN2QmFhR09uTit6NCtGeHNBdTlIcUk0azlh?=
 =?utf-8?B?SFRsSmRWNUw4Q2c4K2Eyekphb3A3dUxRWE5MUlBhZHU0SHZETUQ1c3NmSGtI?=
 =?utf-8?Q?qrRlc0ef76qhaFq4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ed64cc-cddf-4d7d-8369-08da375a18f8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 16:35:33.5307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: corRaY+SKMGaHjyM86zrDYUQihgIfBP/mCk82Y5rDwhvEkkoI1a6zD+6ByDjBo6gTvJJiasTnXRHfwBokoMiDusnnO0uac50ShtiQEGsYHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1749
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ x86 maintainers

Hi Stephane,

Thank you very much for catching this. While the fix is onto something
I would prefer the fix to be obvious and not a side effect of bit
checking in an empty bitmap.

When resubmitting, please ensure the subject starts with an uppercase letter.

Also, when resubmitting, could you please add x86@kernel.org? The resctrl
patches are routed upstream by the x86 architecture maintainers.

On 5/15/2022 10:50 PM, Stephane Eranian wrote:
> AMD supports cbm with no bits set as reflected in rdt_init_res_defs_amd() by:

Please watch the line lengths. Getting a pass from
scripts/checkpatch.pl would help.

> 
> 	r->cache.arch_has_empty_bitmaps = true;
> 

With the above the needed information is present. Changing min_cbm_bits
is not required.

> However given the unified code in cbm_validate(), checking for
> 
>     val == 0 && !arch_has_empty_bitmaps
> 
> is not enough because you also have in cbm_validate():
> 	if ((zero_bit - first_bit) < r->cache.min_cbm_bits)

You are correct, but that relies on checking of bits in a bitmap
where no bits are set so this fix relies on the failure cases of the earlier
find_first_bit() and find_next_zero_bit() to be used. I find that it
obscures the scenario being handled.

The code should be clear and to that end I think it would be simpler to
explicitly check that an empty bitmap is provided and not search
for bits at all when that is the case.

Something like this before the bit parsing starts:
	if (r->cache.arch_has_empty_bitmaps && val == 0)
		goto done;

	/* Skip bit parsing */

done:
	*data = val;
	return true;

> 
> Default value for if r->cache.min_cbm_bits = 1
> 
> Leading to:
> 
> $ cd /sys/fs/resctrl
> $ mkdir foo
> $ cd foo
> $ echo L3:0=0 > schemata
> -bash: echo: write error: Invalid argument
> 
> Patch initializes r->cache.min_cbm_bits to 0 for AMD.
> 

Seems like a Fixes tag is needed.
Fixes: 316e7f901f5a ("x86/resctrl: Add struct rdt_cache::arch_has_{sparse, empty}_bitmaps")

> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index bb1c3f5f60c8..14782361ebb7 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -897,6 +897,7 @@ static __init void rdt_init_res_defs_amd(void)
>  			r->cache.arch_has_sparse_bitmaps = true;
>  			r->cache.arch_has_empty_bitmaps = true;
>  			r->cache.arch_has_per_cpu_cfg = true;
> +			r->cache.min_cbm_bits = 0;
>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
>  			hw_res->msr_update = mba_wrmsr_amd;

Reinette
