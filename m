Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF9753308E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240390AbiEXSiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240384AbiEXSiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:38:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D72B5C35F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653417499; x=1684953499;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=kfK6OXCR7jWUt9GNpo3L5KOc22K57rT0JhZoLNVkZ9s=;
  b=jmEtG4gNoqocDG5r9ezMrM1HnhYaeJI/ffMfz9PGddJh8Eq1HB55Ve3W
   11KfTDBsZJjKqt6h2SSz+7jdGhpiLVXLjseTWhz98ZRpYU9X5/jElMChP
   E8Asd1WrvV9L9Na6AZ8IYcTwkaQebuSeGmSHhkec6gRFPXFhRMW4YSp2D
   945h+4YT/7Luy/yeHQLpK65qE2NFqoPrnlWrF+8ZvtbBSMy8lH8M+5nfM
   kWO745U5fC7+9cmEyN+Q+rang6Ghtt4IQgHVCZwkHaTATY6xTWAGBcA2F
   dIug9N4XE8DjOGhVqxZYhqlNnDrSVS4lhQKjzNmzhgSVVD/yUZfTCshTj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="261231428"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="261231428"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 11:38:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="608792557"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 24 May 2022 11:38:18 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 11:38:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 11:38:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 24 May 2022 11:38:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 24 May 2022 11:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0gnFpdOSz+f3NnSJi200yopxax9ZMMMbyc4gtqnysAjrvIOU0zcK5TlnWFjbfP5AYZmItvzkEihG1wRy02iFXnKTGFWCVWgRfEvlSlUZVVWIAilXPZBXYlz+2EtOvCN4Ds2/nChwuiBrl9//cax2TBcXDOLnr79xNHHu67ZjDnw7ve0XDz1DI+z9ahiGsXzvRI9k/lRNtc6T6BduJyZPzwZyUmrbS76ntnOrHN1mLkB/OuR0PjgAmYFwcPkW2FvUEVBtPQNphCui+Xaio8bMluMP+BEVmnjzrj44pNeuOuiruLRXcVYgXqaSDJRlMbPBRFzi9xCZkUIDYvg1UuyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5fp4wO6VLc2NQrvZ8pd3d0VAfRRRHGFNARx6KepIVE=;
 b=FZC22IpuI09NczyZ71uT8i7lbfG/T1yHqqm2fshvjTyrJR5uofAKWwfDvpZMOvkmmV3x6c7D7Zp+n9GFLlQOFAp3ID6WRMt3N0NJkIQ/6NOXsiiHMTL+BcuSuiRNExJGqpbI9F1m+0Pr8g4y5KxHqaXOhiR999jGvZK7rrUQsYctuYneiXmZ5qokXFWzVAg3HaT6SOurJ2D3X47sH3OIPc54ktAk/io/TbcyiQ4Zg5cjmvWx5do+sTKNm7WJ7p8nw5bQU4o+nIVMvkIJPMur0x3rCUa8g3PN8oboMenEGNRb4j1ntaOZXdGO/Vbun0mgd0SdHztrXmU2l3h6ecDPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM4PR11MB5374.namprd11.prod.outlook.com (2603:10b6:5:395::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 18:38:15 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 18:38:15 +0000
Message-ID: <a88900f6-da2f-d641-fb6d-7952b60cf200@intel.com>
Date:   Tue, 24 May 2022 11:38:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH] x86/resctrl: Fix to restore to original value when
 re-enabling hardware prefetch register
Content-Language: en-US
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>,
        <fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <20220518045517.2066518-1-tarumizu.kohei@fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220518045517.2066518-1-tarumizu.kohei@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::27) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2aab1f7-b9d2-485b-6a0b-08da3db49010
X-MS-TrafficTypeDiagnostic: DM4PR11MB5374:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM4PR11MB5374EA156F8BDCEA62E73901F8D79@DM4PR11MB5374.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79yFWmhFXJPkeQu1URP4AvhxrRkDJGR0s1tzNwIQLKI9TqIhCkEb8HOYqL+ZcGOpwF1ut4EPtdU5hpmDyFu5NV/MHAYAUYfBnT+rITSJhvPnznunnIbloq92oGrqW3LzlFLGDoCPzFya1/Gi8RRU4et5HYwO7SRz1k5Y2hM1e2xSDf1ripG8+iubSXKcteCgfSqfit6Ys4DFvgfQS9l9EAz1qJ8AIDt2hoKPoVyHvdvhMmryguRLg3TJZSHY+6uthfkkDkGVExQcTq323YWKs+K5VS/JMD7EwpC9TDo7NzabG9Wj/hO6PUkhchrsUb4n8LUjwLwZgrUvc1SfmS1Aj6XNBguUNJyMgaHXs1vK28zWxqaUY12PACQYNlCnXijzdP7W8xHDIJJdHkNKiGlZ8wU8nTi6fDBGVpKxpwwLZ4/JtVH3BDNxv+uEzP6ckvO7aU6THYHSIQexflFRUc2jrYsX5cy9o6GqaTyscg8zmEcLu2L1bmLauW14jstzzWmuYHUXP0aXRpnSHgguejlwydcYGXaLN2N+kLvY95g2k/GsnA1OrMb879dAEp7chwV5XhstZS0vqEdDwhR3YS3h7b771kGi8Pp9vI5eb5+r0f0oxQd7eUs3GeFFYJxQj0fwggqPkacnZLxWjhzs76HTkPfMunBWg1hUA+pRXtaJixhzUuDejUbRo9xwf++gP3mYtx/+QukHbgRsUNHzWiDFg9Tv5q5MXu0QCWpgj9XLQz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(508600001)(6666004)(82960400001)(2906002)(5660300002)(6486002)(4744005)(2616005)(38100700002)(44832011)(53546011)(316002)(26005)(66946007)(31696002)(66556008)(66476007)(8676002)(8936002)(6512007)(86362001)(31686004)(36756003)(6506007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXAxU3NRVHFEUldiTlR3VHFqa1I2a2ZWUjdVeU90NFl3bUluMjQwZ3RyYzdQ?=
 =?utf-8?B?QVV1YXRvZ0xqR013ZXl0QVVYVHpSSVdhNEJremVEOEdRdWNYN3l1dnpwUkov?=
 =?utf-8?B?WVVqR3lSWVl0OXk0Qk42N1A4ZDZFZEhwZ2dIdG1DVGk5aEY5MjcyUnU2RXF6?=
 =?utf-8?B?b1hhN1ZQcDJZekdjcjVEZW4zSDRZaURxTmMvb3ExaldWdkRneFJDVkwzcFZ0?=
 =?utf-8?B?YnZkc2ZTQ3ovYWEyNTc4cFJjUWJPTGk4bkhtcGZCeFFIdEN3ZkR2dWtIbzB0?=
 =?utf-8?B?c004bngyQkQzNWdTa1dacTNPL3FWdkRyWUxWWmEzUlgyd0FoYUg5eUdkNDBW?=
 =?utf-8?B?YkJocnd4VlhCbkJOWXkwd1ViVHE3SkZVbjBBYUZkK3o5eGJyN0tTblBvQ1Bn?=
 =?utf-8?B?SDZldlYwQUxtMUNacEErOHFyUDV3cEZaZkozTzgrNmdVeDgxazM1L2xJc0tr?=
 =?utf-8?B?c1MzY2Ivc2k5dURvK2Nnd0w4dzVWS2Zyc0t4azE0T1FuOVREQUo5NGwzMWJ0?=
 =?utf-8?B?TzduNzBYV0psbXQ5VzhHSjdYNC8wcHlTczdVMlhFeGFNL01pK2g1Smg1aC81?=
 =?utf-8?B?M05GRHhhRWRRV09WaW9GSUxNVTBCU2p3amhqY0V2Q2ZzUlhuR1RQU0l4WWt3?=
 =?utf-8?B?bndrTnFvMHU5S1NGVENna1dvRHhJQlNRVFVSVndFTWRaUjVSbFJvVDE3R0hY?=
 =?utf-8?B?cEczSzhmZ3krWThuQkxZU1AvM0ZHN3FGeW9MaGJ1c3RIVGdNY1dlVnFKTUlB?=
 =?utf-8?B?SFFJMlJwaDUyZ2F6STJUR2NhaFN1NFpaeUhqbFovOG9VSGlQWi9pelZ0UnMz?=
 =?utf-8?B?dkdwUmdQZjhEQnlQKys0eXVsYmRqT3U4VTdlNzl1ZU9SK0dsN0I1R0tUaDYr?=
 =?utf-8?B?Ry9CdURlZlEra05UYi9wU3J6Mmp2dS90U1RuY2VjWkthTFI0N1ZHUmxpcVpC?=
 =?utf-8?B?NFZDWWtzK1VTSERnMjhhazFEZ2JSZkg3YXgrdWsyY0VOcUN2dFhDSEpKY2VI?=
 =?utf-8?B?TTIxZXBDanBLdnRBTC9LeXN3RWdDMFlhMlFHWUVVSzhLVGdhY3BzTVNZbjlH?=
 =?utf-8?B?djZUamZvUjhZeTNRRXpIMnp3emJwd3ZSNzdzOTlpaTdEV0ZOZk5UU1NzQ0Zy?=
 =?utf-8?B?NjVsd1VzRFhaT0RMZXRvR0FwLzBvNWJNK2svM3NmbmVTNlFEdng1TUV0T0FZ?=
 =?utf-8?B?K3FKZ05rRHI1QXUvTlF3TlFnUFkyeitTQWM5azlYZkhOZkV4YnBDakpUMlhW?=
 =?utf-8?B?enZXYmRzckhEbHVBTXFudy9vZktMOWdFT2ZzdlMzZitQald5R2tIdlRZNjRK?=
 =?utf-8?B?ZkVzZnZiKzlEZ09DMTd4ZTNsQ2hPNHVQZXhoYlh4b1V3WnZKelpuTlBmcDRZ?=
 =?utf-8?B?bXU0bGxnVzQrM3k0OFJxU2pJQmVGekYxZlB0SEtwdmovVUdUM25ZK3NzbmYw?=
 =?utf-8?B?czFKaklQSHRtRFVRQkRtWlE4S0ZCdVpvc1RraStUNDZhQktSekp4dy9iYTdF?=
 =?utf-8?B?WWJxYTZ5ZFhSNm5VS3FWTWhkL2NJYndZVDMrUjUvdXRXOUZwSVBvMnV0Yk8z?=
 =?utf-8?B?NG40VTh1RnZFQTJxa1dQU25rRDVWTWRDY2IzYjlid0xoRTJCdWp2aU40WkNW?=
 =?utf-8?B?enRkNmNZa0VCVkJhd3UvZHVnU3ZzSTB0SjdnV1MvTGtKSGd5cGg2Tjh5T0Np?=
 =?utf-8?B?eFpKUU9qLzk5Q3FadFJ3TTlzNzNMUllmS01taGRjSUp6VmtMRHk5azUvSmpm?=
 =?utf-8?B?akx1a3MzcmEyQ0ZDZWZId1pMM0hTdlJHUU9WQ2x2TmxsSkMvMWdKQ1kvNWVS?=
 =?utf-8?B?bDJEdzFjOVI1UTJaTkcyd1JMZGthd2Yxa212bEVlSDA4YUNqM1JWcElBZXhh?=
 =?utf-8?B?YWl1Wmd1TmJSeWJhTkVNckhEb093cWpmUDVWZGdNNS8xWUV4L2FVSFRXMnhE?=
 =?utf-8?B?RXZ4L1ZKOUFXMEluM0ZTTWRkbnlQeW9nUElUYXMyNng0OHhmamFiaTI2ZUlL?=
 =?utf-8?B?LzBySXpGeDhrRnYxbzJvcXlNT2ZJdGlZYVhxOTA3Qlh5eWNFbENwbGJtQllu?=
 =?utf-8?B?SXBiM01oUTdORFFtY3N1cVdFc2xhdkxxNzdjSEJObC9CMXpmS0FPK295cHZj?=
 =?utf-8?B?SjV6QngzblJLSGNjMm96bVhCVEVYcGpGV3orUmJYRk1wUlRqWmVXWDJUZXJz?=
 =?utf-8?B?SURIZWtpQlIrbDdNU0U2RmFtVm93MVBKUkt3RVlMVWNMeG9IUC8vWEJ3R3JE?=
 =?utf-8?B?TWUxS3BwbWs2aHVqUk9QMmNxbHUvb3F4akJyeVRNV1JhMmxDOEFaSlNyRXB5?=
 =?utf-8?B?cmRCVXQvdTBxZlQyZm1BMEVwZCtjQmtTNUxGc0xBUkVvZjNlU0N2SlZvSFlW?=
 =?utf-8?Q?ce8EDVIHZ+WWv6eY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2aab1f7-b9d2-485b-6a0b-08da3db49010
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 18:38:15.3466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LMtCMU9NyrGvO6vmrUeUFzxYh6FDDx9R2Xh+YMlJpxVcj2ZcIjKP2SyFQnxV16RFx4/6Xq8WB/VAWBJdrL/7Hb0uP8F/JvpkmIktSiCIsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5374
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2022 9:55 PM, Kohei Tarumizu wrote:
> The current pseudo_lock.c code overwrites the value of the
> MSR_MISC_FEATURE_CONTROL to 0 even if the original value is not 0.
> Therefore, modify it to save and restore the original values.
> 
> Fixes: 018961ae5579 ("x86/intel_rdt: Pseudo-lock region creation/removal core")
> Fixes: 443810fe6160 ("x86/intel_rdt: Create debugfs files for pseudo-locking testing")
> Fixes: 8a2fc0e1bc0c ("x86/intel_rdt: More precise L2 hit/miss measurements")
> Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
> ---

Thank you very much for catching this.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
