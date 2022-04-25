Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E603250EC89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiDYXVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237578AbiDYXU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:20:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A241B781
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650928674; x=1682464674;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=NsfmpBpnjXWdlYc2Hs+/yraJK+RP/S48CnqDHmpCjAI=;
  b=H9sl8FKqHfLBpDMw9pq+WfLJw6oUlQm1dW8P4LOicjnrI5vQFkgWrd8l
   Sr86nlOrXIgoEJX4yP2ToDU1FABFW+pqTRgmibyn9q2z3V32oZHm9EwQq
   80cHh6dQc0AeTY9RrN2GR9Ph6QQ0Ptt+UlFKGPljwCHoiwZwUor5kOfl+
   qOc/DkEvwd0cdSbJOQoTf1A1q90sAJHTbpEhGV2nwt90upI64QBKXZivl
   Ns9HW4dPseDBvnlKUcZvvFw5jlpR6UYuKnu3da0retdH7nBeXbsDiBsxt
   me+Hi1H6P1q9AdjfanpMq63ukAUlBJ5dgPB26puZEJaRY5O4MvcDnA0Av
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="351834460"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="351834460"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 16:17:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="729961184"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2022 16:17:53 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 16:17:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 16:17:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 16:17:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 16:17:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKe9U/n9w7NMj0ovzh+rr46H9c7m9VdQV1iuDJ3YSSCFKq9gUdr1+UBLDaF/tDDA0mMRFTo9LmrZEtjhkyYwCGWHw3giSsmBOopiChcAMNv4PhQ5xl/IPkeWResrlOgk/G2i9MFMsoNxmimmojmN7yIYuNGPJ9w+i4cjePWg9dUmg6IStQFJ7SXlALF5PizHFnfo2t3I3iJEx6E64nDLJ7x+uk7ILSBdNL272oygqGoz/98uA/b3NMvXXhfEGIKYOpHcYRCbfBfj0xIrXyL9W/FIhSs6mEKxotxBwLD5Atw3H9D6nCRDu3Rz2txHVZfSz+2xqGJTKYPzMtB+JtbfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DbLF3aFDikfQe0NAqE4PSReBd7Y15LHwjK+H4pIDJ8=;
 b=lY7jzGYvzX+hFOhrgsMDJl090d1SNr1rIhGz70lQoLWYhZfC1gw8vBKOhJcPWlFtC/ULUcjUsuQa7zkwEXCbAcScqizxuXTxUEUf6xiRLbFRPe7jRuTkEiLkkRQw3NpomfbhlOatmaffLSbcHGGKd9vZK4QR6IsFlkQE/vfJBqz6+gx1e8d3lz0ZeN1rf7ebRvFLltYM8aXsF7Ks7qEynnQrsIOaGO5IsfSTNsOQhoVYi1vg5dPaE/1LYG93qKUmPvQQyFdvVnBvMAFbgDj2G16iqrx9QrXz1POAhM+91M3lIymgKgdMCYvdAkRGboO1PVMsbmqaPz6UdXnHIGrnBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BYAPR11MB2565.namprd11.prod.outlook.com (2603:10b6:a02:c9::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 23:17:50 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 23:17:50 +0000
Message-ID: <d1998eb4-296f-f1ac-8deb-1b6d4fbdc1fa@intel.com>
Date:   Mon, 25 Apr 2022 16:17:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH v3 6/9] x86: resctrl: pseudo_lock: Fix to restore to
 original value when re-enabling hardware prefetch register
Content-Language: en-US
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fenghua.yu@intel.com>
References: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
 <20220420030223.689259-7-tarumizu.kohei@fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220420030223.689259-7-tarumizu.kohei@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fa38883-b90a-48c1-7637-08da2711d118
X-MS-TrafficTypeDiagnostic: BYAPR11MB2565:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB25653279F1367BAF49F0EA54F8F89@BYAPR11MB2565.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Gt+0/9Iqvgayxbw58TW2ajIFsEJ8fLsMZLHWhjfXGOZtAFP8iQTwGYQg0NwIFTZAWFjArByM0u8ymfYO8fF+EpsYJfIJxNqX/McqdoxuLMOKtz4FIYdokldxlfADXbtljHuLJAfzIqrwVanSL9MO+/kPNGm6GtcReq43i/m0ctpPpXjYpSnBa0DWOvysl5/WlSVLSrjCqGC6+MK2rKXybDuRaO8GRcTnUYK53wNSd1X8+F/Lqzi5EdMuygb1gy/fkn7bdOOXg0oX7hqyWToYxyYrXAu8WNzRhQChrGcRDMBh0bK05weu1deVH6bc2DRpj7InTlzFhN4oVG2we7tbR8i1sXwkQOfFh/6zHK6GeHfyF1RNHxMNq8Ov1npAJACb8Jpf6w2W0+LEYQs//HPMu64to2SjsTfwbzYNSfDvmuI1hxCxxNf4f1plFWAzukCj9t2/7uber3cTCINaFqjOKTuoVygW9Rc8k3jqeWnLEWfkrkzTWI02if49AHPOxJUt/GuVx83uyjr5pcbpukSAFmFKVYxfrdfzctn5ZDPrMED/5Go3s1W/4UepcR5iSo/Lh7AKYcDpKBgTcf0nXOu5GQGXw41NhKFKhO2kr/2Hwg+m4U5gAK3ovxt+ylt/MbSoGsy9VnPNJ2d50kFhBOMV6VR/NbsdhwMzzqYLiLPI64jRDBUzNzCX0p5SPrPShYprsN8DkLvp8V4W322qoaf8emQvE2kITes4lClyvkqdVcm5IAmfwGRiNZ2G2l9Z48CXneRDBxAWrJJZRlDGSI9gerficMdyKqlQy1874/9Bx3pBqDFPPdX1N49SyaIqtHrIGW5z6pW9qNIL/2X+BQ3wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6636002)(186003)(2616005)(66556008)(66476007)(5660300002)(6666004)(6506007)(36756003)(6512007)(53546011)(26005)(31686004)(316002)(83380400001)(8676002)(66946007)(921005)(44832011)(8936002)(7416002)(508600001)(2906002)(38100700002)(966005)(31696002)(86362001)(82960400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlZQWlp6WVhpWHhUcDlEV010T0Zob3JSRVVKL2ttTW9xcHZkYytvSG82bE13?=
 =?utf-8?B?aitXY2c2eC9FVGc0R3R5bFlhNDV2QTdRdzg4aVN0V2RKZGhhUndwQXFCc3dN?=
 =?utf-8?B?WG52SmxIMnpDUWI4TkpRNFpEMnhGb2kyQWgyenl0Qnh6S2lmYVVqWExnSDFw?=
 =?utf-8?B?d24zYkw0SVZobHJnUjdrcEgxbHF6S29qbm1NNk9YdllQQ0RsMXEycTVUd1U2?=
 =?utf-8?B?OHI2bmw4T3E5amFxQ2l6NVEwMjdqbnBpY0NDNldBdVRkdkp4eExqYkNsVk0z?=
 =?utf-8?B?T3ZnWERVTHdycDA0L1NWNFlyNUw4czlZbU1teUhpc29SOVZhVW5WUXZYR1l2?=
 =?utf-8?B?bUYvMkxLM282eHRmMm9PYnpmbFpsY3k5bjFrZmxEU1U4V0FHT0hNSmZkLzVr?=
 =?utf-8?B?VTRaM2E4MGxPZ3MvRW9UYyt4aTJXSnpCQmpFQ3pPaC93b0JMNkUwVW5PN1cv?=
 =?utf-8?B?WTZUakNtdUJBZEE1QWxBZWM4SWhIVUpjMk82VXBRb1lDZlplc3hrOTFyajNm?=
 =?utf-8?B?TnJwTGRIYk95UnpYemp3ejlMZStNRDlwR0JEL2dCSDRZODd5RXR3cVlOQUdP?=
 =?utf-8?B?RmtqUG1oWFVVc3RSWHFuZW9NWFZWOEtxcVE2dGV6QUtqSUxuVXZrcGh0NFJ4?=
 =?utf-8?B?b2dycDI0Zk9RSDVSaTB4UWNDR3ovUmljZzA3NUZIditxL3VoaGhTeXM2OVh1?=
 =?utf-8?B?azllSHNjQUQyZFMrRGM1UUR3VXlseTdwN2V5Nk1GbU1RMUxTSEdxQ0c1TDQ1?=
 =?utf-8?B?QzMxMUtuZU1lWmlYMXlsNlJkbXhNcGNiYjR3azc4ajAybEYzRWVjeFB0SHk5?=
 =?utf-8?B?djNmUGdkaDhXMGM4Si9Kb2U1RkRqcWN3OS9HcHdwSXAvN3lwMUxEWjNWUytZ?=
 =?utf-8?B?RmJsa0ZlV3F1MnFzYlRTTitKNWJLU2srRGFJR0VyL0phVXA5SXhlSFVLSEhl?=
 =?utf-8?B?Y1BqMjRUdzZqZFgwV2NDT2pOVzJoM3Z2eXd4Mk9RdmVZVmhaMkkxV1VjeWlE?=
 =?utf-8?B?VVpFdXNDRUwvdlZ0cmpXRFNFclNHdGRFNkRXYVAwK0J4OWErQ2NvbW42c3h2?=
 =?utf-8?B?anU1c2FENjRxNXJCckIxT2hvTjdSZXJXUDVnczRvVDFxOXpYL0NhWHFKMmhU?=
 =?utf-8?B?MHcrTEhnUW8xYlM4bUsxS1dyb0ZoSVM4alRqYWZrUUdYWlkxZTdZS1hzeUR5?=
 =?utf-8?B?WEY5UG5lLzZVU3JpQWlOblZVU3JBWVN0UldXR3g4MXVCT2xSSUd5Z3U0cTZM?=
 =?utf-8?B?b04ycXY1cUVoVEdyTGVNdk1ZWTgwOGJxeG1aT0V0amFHcWdvOWR2OVZ1WWVM?=
 =?utf-8?B?R0w1WGtXS2ZveWZxRmx3QkNNZ2YvOXU1VmVtK214MlFvcW8vZVpRcU5nRUR5?=
 =?utf-8?B?emdDNTB2NndpRGlwR0NIaG5VZW1RSzlPVlRvVTlieENuQ2tZZ0o0UzdPSkR5?=
 =?utf-8?B?YlppRjRvVm44YW9OU04zREw2a2N0a2M2RUoyVWpvVTN4QWVLbVRsNWVvUDZY?=
 =?utf-8?B?eUFEUytRYnBiNGZ1ZTlmWUZ3QU52ODlYTGplVi9WTldiQ1FReTlBRHMzVmpw?=
 =?utf-8?B?VVdpUmNGUVAzcTNwRlg2M09TQjJTYWF5OUJacTc1TmNKdDJyQTgrNmxjT0pr?=
 =?utf-8?B?ZTFrYzlndW5lcnY2MkZ0NndzTG50cGFtN2ZoSjg5OTRPMVI1RlJmZVg4VE1w?=
 =?utf-8?B?ZGprb1pUa0JBYkt1ZmVuQ3c1WFVoanFqU09TWmtKamVEMFhZV1ZUVlNXZXhD?=
 =?utf-8?B?dXdWTjFIbnRXbHY2K2VjMTBuekNaRnhFd3h2UTBxa2p1YW1HeHlFSWdJbGNq?=
 =?utf-8?B?L2JwTjNJQ2ZzaU5aeHNxeHpud3BVU2J4emllMDlyUlo2RlZYbnNwaGlOSEd5?=
 =?utf-8?B?MnJsTXlrcW52MWNPdUV5TnF5ck1BenhvbnVUcE9VY3Vqa1p2YTROSFc2emt1?=
 =?utf-8?B?c1ZPWGkwWWY0M2g2N2p0bXo4V0QvN29xSEErVmZxSDRQenBFSWFwWEhIa0VD?=
 =?utf-8?B?K2QvQXRHZEh6VVlsb1RvanFTZVZTUDdnSmpCTXpJaW5ZeHpBOE1rRXlRcjFv?=
 =?utf-8?B?dStXV1dsbThpTmVFekxDYUI0T2trVjVaSEVoU0s5TkRvN1RUc2QwWHhUVlpI?=
 =?utf-8?B?clF2NjhOUmM3TmxCRmthQmRZcy93cWNlY2pTMUIwblZzQjlEL0FUUkwwS25l?=
 =?utf-8?B?Y1JVbTJxdDMyZ2VLQ016ZEtsWDh6bnU0YVgwaHhRVDV4blFSRFMySkZuWHZP?=
 =?utf-8?B?aStFM2diQmdBQkEwcVFDelQ4VGlNN09jd3FvbWt3WTNPcnZlRnU2QTBudE5L?=
 =?utf-8?B?V1oxYUQwb3FjOVlZZnlaRllZK3F3WFRLQmpoVXdlL1BEMkZJUUs1NXZVNWky?=
 =?utf-8?Q?CL+HyVSorJ0SWmnM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa38883-b90a-48c1-7637-08da2711d118
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 23:17:50.4970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEjIIwXDd9eL/Oia5+8QB8GYRIDvEklWbFqH377ep3B4S1TOO+xgbHI+19NrUEqX+UBA953ELDK2B1S/Qd+4C4ECnt4CUgQrnrGwNDDqVCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2565
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kohei,

Thank you very much for catching this issue. This fix is not specific to
or required by the driver you are creating in this series so you could also
extract this patch and submit it separately as a fix to resctrl.

When you do resubmit there are a few style related points that I highlight here,
the fix itself looks good.

For the subject, please use "x86/resctrl:" prefix in the subject. 

On 4/19/2022 8:02 PM, Kohei Tarumizu wrote:
> The current pseudo_lock.c code overwrittes the value of the

overwrittes -> overwrites

> MSR_MISC_FEATURE_CONTROL to 0 even if the original value is not 0.
> Therefore, modify it to save and restore the original values.
> 

This needs a Fixes tag. A few patches are impacted by this fix:
 
Fixes: 018961ae5579 ("x86/intel_rdt: Pseudo-lock region creation/removal core")
Fixes: 443810fe6160 ("x86/intel_rdt: Create debugfs files for pseudo-locking testing")
Fixes: 8a2fc0e1bc0c ("x86/intel_rdt: More precise L2 hit/miss measurements")

> Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
> ---
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index db813f819ad6..2d713c20f55f 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -420,6 +420,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
>  	struct pseudo_lock_region *plr = rdtgrp->plr;
>  	u32 rmid_p, closid_p;
>  	unsigned long i;
> +	u64 saved_msr;
>  #ifdef CONFIG_KASAN
>  	/*
>  	 * The registers used for local register variables are also used
> @@ -463,6 +464,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
>  	 * the buffer and evict pseudo-locked memory read earlier from the
>  	 * cache.
>  	 */
> +	saved_msr = __rdmsr(MSR_MISC_FEATURE_CONTROL);
>  	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
>  	closid_p = this_cpu_read(pqr_state.cur_closid);
>  	rmid_p = this_cpu_read(pqr_state.cur_rmid);
> @@ -514,7 +516,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
>  	__wrmsr(IA32_PQR_ASSOC, rmid_p, closid_p);
>  
>  	/* Re-enable the hardware prefetcher(s) */
> -	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
> +	wrmsrl(MSR_MISC_FEATURE_CONTROL, saved_msr);
>  	local_irq_enable();
>  
>  	plr->thread_done = 1;
> @@ -873,12 +875,14 @@ static int measure_cycles_lat_fn(void *_plr)
>  	struct pseudo_lock_region *plr = _plr;
>  	unsigned long i;
>  	u64 start, end;
> +	u32 saved_low, saved_high;
>  	void *mem_r;

Please do follow the current style of using "reverse fir tree order".
More information in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst#n587

>  
>  	local_irq_disable();
>  	/*
>  	 * Disable hardware prefetchers.
>  	 */
> +	rdmsr(MSR_MISC_FEATURE_CONTROL, saved_low, saved_high);
>  	wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
>  	mem_r = READ_ONCE(plr->kmem);
>  	/*
> @@ -895,7 +899,7 @@ static int measure_cycles_lat_fn(void *_plr)
>  		end = rdtsc_ordered();
>  		trace_pseudo_lock_mem_latency((u32)(end - start));
>  	}
> -	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
> +	wrmsr(MSR_MISC_FEATURE_CONTROL, saved_low, saved_high);
>  	local_irq_enable();
>  	plr->thread_done = 1;
>  	wake_up_interruptible(&plr->lock_thread_wq);
> @@ -945,6 +949,7 @@ static int measure_residency_fn(struct perf_event_attr *miss_attr,
>  	unsigned long i;
>  	void *mem_r;
>  	u64 tmp;
> +	u32 saved_low, saved_high;

Same as above.

>  
>  	miss_event = perf_event_create_kernel_counter(miss_attr, plr->cpu,
>  						      NULL, NULL, NULL);
> @@ -973,6 +978,7 @@ static int measure_residency_fn(struct perf_event_attr *miss_attr,
>  	/*
>  	 * Disable hardware prefetchers.
>  	 */
> +	rdmsr(MSR_MISC_FEATURE_CONTROL, saved_low, saved_high);
>  	wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
>  
>  	/* Initialize rest of local variables */
> @@ -1031,7 +1037,7 @@ static int measure_residency_fn(struct perf_event_attr *miss_attr,
>  	 */
>  	rmb();
>  	/* Re-enable hardware prefetchers */
> -	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
> +	wrmsr(MSR_MISC_FEATURE_CONTROL, saved_low, saved_high);
>  	local_irq_enable();
>  out_hit:
>  	perf_event_release_kernel(hit_event);

Thank you very much.

Reinette
