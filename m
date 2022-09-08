Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87EF5B17D2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIHI4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiIHI4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:56:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4A69D116
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662627361; x=1694163361;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iVM4r3JXIVyVfhY+8bliYeDskUhXoyZJ7/EuEp5mw1w=;
  b=HIuP6ZTCQ2p5Em3wBivPYUloV0Bv80Tu+XFJZSAe25NkVqiJd8uRlBFa
   RHQHiCqVKMejuuyGPKD+d0NlJ8xZ/+C8Be3hfzZsGuAT8UBHK1gE611Z8
   C6onIblvtRkhx9hSgvimOxRYLeCXWzw3onpp5rdBU5ufCpnkil9oC4LDC
   tPwi5xw9hbRXlIccxzFg9g8/B0KwA77+1bwpez2cEQnvUQPeg3aYJGBw0
   uI4GaHMNxMCqlRxyVL1MvFtYNOdJP67sNQUtWYzynWRbuDeqluPknHPIh
   WCW6B5GmqnOK2QI5Qg0MJE1DojuhmnznNsKWFQRc3NB+nqDEyX+yd3H0O
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="323307160"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="323307160"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 01:56:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="565864629"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 08 Sep 2022 01:56:00 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 01:56:00 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 01:55:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 01:55:59 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 01:55:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdep7XwMcLr2xfXm2by4OlMG651iI+jDidHWgLiGdGWCerDSVOvAKZ9z3z3VpJAyO92m6DMMPZNXKE2vRIgu5JtcXboL4g5SVArir5zxm+JrNQ0+hflgWIDzy8duq8fqUHEx5n38fllMldg0+Boy5H0O0Bi2eivAm++ADS0gy/+v1mmLbtXJJT8kperfrH/VlzUq+mrafftBp9Tq4A1MEdaI3r9DLMjQqdKIlPNl2N66Yyy26660vLs3ZSaWqp0TNXaEpuQBrr5dGsWLZC1piEiRkgX2sLR+4j5nD93CFf8UmTTPFj0VkC4K1R1cF7a7v16Tcnt8+JHfj03GpQ3zKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn1s0ipLHD7ShP8dbEjHkopp6CLP5G/g68+ry5bTG2k=;
 b=ObUsnedR9Bte5ygIu65+wfRZYLlHgaHbAzBqdPXsXuQ9WJMOvvHYAd/9TcAbnN+LAxqgKZlFv4aq2QzuwCxHnhNBW3J5szAxtgW42+eZzEdVHY4eK9J+1h/5zEg4SYrXyRO0eaDnPy11N1IlpO5YleeLqjZstxnbOt1R60dQhTytAm5O0i/ivNuOTMAEDi3HhjXLjwCN4oWGh/v2ePN98/cBLXumLBo8QEz0QdJ9TzlD+JzI77KNFFcFxMntqRH3nLSfy11RbT+dgl3j06mIstuhBDObEszvVxNXO7M96DkGy3tpfJStOBbn0W9fW0f3grY5PrcbowdPEtc68VGM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BN6PR1101MB2241.namprd11.prod.outlook.com (2603:10b6:405:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 08:55:57 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8845:e130:6f6e:ac66]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8845:e130:6f6e:ac66%5]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 08:55:56 +0000
Message-ID: <0214b84c-71fe-2133-b69d-1e39a19cc468@intel.com>
Date:   Thu, 8 Sep 2022 16:55:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [LKP] Re: d4252071b9:
 fxmark.ssd_ext4_no_jnl_DWTL_54_directio.works/sec -26.5% regression
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>
CC:     Mikulas Patocka <mpatocka@redhat.com>, <lkp@lists.01.org>,
        <lkp@intel.com>, Matthew Wilcox <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <regressions@lists.linux.dev>
References: <Yw8L7HTZ/dE2/o9C@xsang-OptiPlex-9020>
 <CAHk-=wgG=mttS-m2OLcnsTwia2roHR2b-DxXXG-tbDH8_cUNiA@mail.gmail.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAHk-=wgG=mttS-m2OLcnsTwia2roHR2b-DxXXG-tbDH8_cUNiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0169.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::25) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d45ea3bd-ada1-407a-848a-08da9177f15f
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2241:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EcLoTm4NrigDi8fv+HHrDJD6aOqJyHD60R4lYJ53qa/aASzDoXUC6R88G3nrv6Arz5+ECL+MljOa8gnnuVrtpM/dvlSHYY4dgCjyKT3dBofmWbowkjKNudZlQv2ppxVrrz4rUpqkBxfwBchBsh5YBBqvDHiE87K0f1Smx8R5CYWCqMiZGa8OZEmxxnSuii5rAZUcNJT/9rbYuMd4qCG8fS/8FaFcXYYSzBWrUTmGz89ciaCcq8UNcbXaIiM2uI1A/no6f8u4UWrQ9TfU49l+xP5zXGyTxz5SBm+DWbiNcJiGhLBxYnimyRRlc11kBUUjHDLhBa6ygjPqqG6xzTzCVzZf+jsbt+uH/AqqxfKA5kOjZHpyWfa5BnvAIHE2xgNbacyxp3gXU7f8GWwt8pLlknQ6K3s3XepnYO3b08ScEJdK+GM7DZAav1IKxvSZMkLNhhswQumXiaYb0wCUTaddohYjHBSVMgjaEtjhIidVX7Igcjh1YcgBbJ9ff/uuVTIqiXUh3egX5bAWzyYNDLXnjP+WCgKxAdXFb8M/6zRwKxm/1paSDcqGxTyvOYsTJZCJmfFeDuyYEH9uN9ss26Jsm1eUBW8SAUnOpZZT2V6tMl/X/3Hekq9d73SPD/sokah6mn9nEwOW8WVhFZ8A8+A2eVKJQNLwsm37KUox2t9kYhylH2/C1uvA7NuiTT1LgvnWKCWbKGtJKHimp9hli/SJWygT0GTsZqSeM6KZ5cs9BV+bbVwrjcqoWWjEI0+heX6imnxFi9Y35+nQHGlisc2i3b7+C4tDagyqXFN4CJ1JP7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39860400002)(366004)(376002)(346002)(2616005)(5660300002)(8936002)(186003)(2906002)(86362001)(41300700001)(110136005)(31686004)(6506007)(53546011)(6512007)(6666004)(31696002)(26005)(36756003)(478600001)(83380400001)(6486002)(66556008)(4326008)(8676002)(316002)(66946007)(66476007)(54906003)(6636002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3N3VGVIVTBCVGd5cmFBWmR1U2pHSDlRSVV4SlFMRG1SYlA2blBwNTNKVzRw?=
 =?utf-8?B?TlpPa0ZkWDhrYWRoMU9PM056elNrMXJHK2xQTm9vZjlGdWl5RmVWUzBVeE1x?=
 =?utf-8?B?Tjh5cWZrbVZ3eWMvMFdVQXZ1MUUvYUp3MXE0Z3ZHV0lsb240S09WVWFOM0Y5?=
 =?utf-8?B?WktSNHdkYkFDNEpSbEF0dHk3NTZPcnlNblVkVnhZaEdiMTJheEs1NjNTeW9l?=
 =?utf-8?B?cWdsNkpGZTFac2tnd0pJQTdHTTFGdnFBd0VVU01YUHNUZEMvZFkrbFlLN29a?=
 =?utf-8?B?R0QyNkluenhZVURRM1pJYXFkcGxMemZNVkJmY2JlZHl5d3lEWEl2K3BwUHlY?=
 =?utf-8?B?NXNwaUZKOVpvblBkN2p2NnhQckt4L2gwSjEyQmpiN0xmY2s0d0cyUlBOd0Ny?=
 =?utf-8?B?Z3E4QnhxOFBtYVZvRGYzQ3lXZkU1WVIyd1NBVEh5YWdNaS9DWGtreHhkbjBE?=
 =?utf-8?B?Q2F6bHQwYTRPME5sek8yZjdlNUtpUTIvTXhJVWxLaGhFVEFYQXE2NXAvU3o0?=
 =?utf-8?B?L0IwVXg1Q0IxVG1kTmZGeFVxa1RpNGFmbDB0MmlNYVZST0E2Y05tdkkrREJy?=
 =?utf-8?B?akNJaWVyR2hEajdQOUpYYlNMZFY1bkR6dzA0SnRQK3BaMThtOEI4Vjl1d1RG?=
 =?utf-8?B?aSt5dzdVdmZETGxScjA0TEc3cTBQdkd4S1hGeUVUWnNqVHpsYXVLRTU1QU51?=
 =?utf-8?B?QTR3T3dwcENMaFlYSTZ3STNHSXc3bzY0UEdBNTZHVmM0NVB4Mlh0WU9kMi9s?=
 =?utf-8?B?dmRCcGRkcVpGNkI0YS9LMGFaMHZRelhweHhLbnVYdytBMHp1UVQxaDNMd0wr?=
 =?utf-8?B?bmIxUFJuOVVJLzR5TGhvNU4zb01WMmlERWxnSTRpWVdFZlhJNjJoV3pkeW14?=
 =?utf-8?B?eWUrdnRPWERrT1d1UVN5S0swNkdqeTNOR0E4NzFNaVE0Q3JYaG5PeUxTQjdv?=
 =?utf-8?B?bFFnZjlnTkNqeWpBTjlEellpRUIrUWlYcnVWOVdoSTZsMTQ4aEFjaFNidUtH?=
 =?utf-8?B?ejlQeXl4TTBBMTlFZ1NhNXBUTnMrNm9SMlMvaS9IakhVaXJONTl0em9YTExv?=
 =?utf-8?B?SmlsUDZiN3pjQkZhNFRLaWpNU0doR1ZHeDExRlBJVjBoQVZlSWhaSlQ5anpJ?=
 =?utf-8?B?cTlST1h5cGVlaHd5SlExMXY5bUQyMXNTQ050UWpOeDFNeVpiYkVrcGxEejZT?=
 =?utf-8?B?MmFRM3kyaE54WTZRRUQyTVRrNnBqcGlwN1VRd2FwRks2SUNsN0hkWmxUQ2NJ?=
 =?utf-8?B?NW9RNVV1SjFITGQrQ3lUa3hCNHU1TnAwRjFEQzNzTDR1cTE1R2FTL3NESGVJ?=
 =?utf-8?B?akE3eWR5WDhML094UGF5U3YzbUxsYnNrTElqeEt0dEk4Mi9kWG1ZSE01amtS?=
 =?utf-8?B?Skt0eC93SjhrMXRKWXNMVlVSOTF1d2hvVUdWd1JMWWhnRDA2Sy9ZOFVQU3Vt?=
 =?utf-8?B?QjZ4NlZjK3dXV1V4VXFIWVBQTWMxdFNpaE1ZbWZzZDd5M2FOM1QrVWd0WmFB?=
 =?utf-8?B?Vko2Y1IxbDZhWm5IM2NDT011NzdYcWM0bU8rR2tRRXpCMHNUY2ZGeldPTTkz?=
 =?utf-8?B?Y0tTRGdxS1BRdjdtajhRNExVUzFEditmYkwwbmpqd283cEVsS3ZpenAvZ2Vl?=
 =?utf-8?B?SGhYS1VxdXFSY1BJaWtKcGJwVlFOTXR6dHZXNmFiSjJPa0RTSlFoV2NoSjFH?=
 =?utf-8?B?dGFVbXpORktVcThBeXZuaEFqSDdaM0RsMDI3Rk9RQktjL0xTOE9QT296L2J1?=
 =?utf-8?B?bTRkZFVWS25ENDYvYlNSWWRCZ1dNZGhPVGs1bEZCZmc4b2JmTzBYWmcySEla?=
 =?utf-8?B?WU1LTGxnM05SZU5rTE5HT1NsODBpTTBGVnF4bW9PemtPNFh1bVAweHNrUDVU?=
 =?utf-8?B?dEc1SU5QUjJRb3BWOVlXRzJZbng1NllwSHBWdGFPQk10OXJTcVlNdkJ0eTlV?=
 =?utf-8?B?V3hlQlBaY3U2Ymw4Z0M4MktPV1lCVWJTNms4MEloUHB5NSs4VHdtSk44NEN3?=
 =?utf-8?B?UklzSHErMVJxRHQ5VEJRd05vTy9qeHdjYUVCeGY3ek9Ca095c1JrSUZWaGpE?=
 =?utf-8?B?WUsvcDNHeE9RcCtqREgzaXlZT0UwbG5NNWsrNVduRnJMKy8rekNXak9yaWNt?=
 =?utf-8?Q?pft6bGiw1cHnEVxEAKWbvfc/t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d45ea3bd-ada1-407a-848a-08da9177f15f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 08:55:56.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBl8MCfgjL4tsSRDkfORIz+AWZV9BKMLT0HDtIQw1bqW1qM8kd5KFcVxXCNB1cZ5Wc0nJyoS+Ko+g9UiOJANrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2241
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 9/1/2022 12:46 AM, Linus Torvalds wrote:
> So I think we can just do this:
> 
>   --- a/include/linux/buffer_head.h
>   +++ b/include/linux/buffer_head.h
>   @@ -137,12 +137,14 @@ BUFFER_FNS(Defer_Completion, defer_completion)
> 
>    static __always_inline void set_buffer_uptodate(struct buffer_head *bh)
>    {
>   -     /*
>   -      * make it consistent with folio_mark_uptodate
>   -      * pairs with smp_load_acquire in buffer_uptodate
>   -      */
>   -     smp_mb__before_atomic();
>   -     set_bit(BH_Uptodate, &bh->b_state);
>   +     if (!test_bit(BH_Uptodate, &bh->b_state)) {
>   +             /*
>   +              * make it consistent with folio_mark_uptodate
>   +              * pairs with smp_load_acquire in buffer_uptodate
>   +              */
>   +             smp_mb__before_atomic();
>   +             set_bit(BH_Uptodate, &bh->b_state);
>   +     }
>    }
> 
>    static __always_inline void clear_buffer_uptodate(struct buffer_head *bh)
> 
> and re-introduce the original code (maybe extend that comment to talk
> about this "only first up-to-date matters".
Test result:

commit:
  e394ff83bbca1c72427b1feb5c6b9d4dad832f01  -> parent of bad commit
  d4252071b97d2027d246f6a82cbee4d52f618b47  -> bad commit
  6812880b7af46dc2a78ad2069e5279adcbfd5133  -> The fixing patch commit

e394ff83bbca1c72 d4252071b97d2027d246f6a82cb 6812880b7af46dc2a78ad2069e5
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      0.01 ±  3%     +30.7%       0.01 ±  4%      -2.5%       0.01 ±  3%  fxmark.ssd_ext4_no_jnl_DWTL_18_directio.secs
      0.14 ±  3%     +29.3%       0.18 ±  5%      -4.9%       0.13 ±  6%  fxmark.ssd_ext4_no_jnl_DWTL_18_directio.sys_sec
     20.21 ±  4%     +16.6%      23.58            -7.7%      18.66 ±  5%  fxmark.ssd_ext4_no_jnl_DWTL_18_directio.sys_util
   3377886 ±  3%     -23.4%    2586083 ±  4%      +2.6%    3466796 ±  3%  fxmark.ssd_ext4_no_jnl_DWTL_18_directio.works/sec

      0.06           +15.9%       0.07 ±  2%      +2.7%       0.06        fxmark.ssd_ext4_no_jnl_DWTL_2_directio.real_sec
      0.03           +24.9%       0.04 ±  3%      +3.4%       0.03        fxmark.ssd_ext4_no_jnl_DWTL_2_directio.secs
      0.07           +23.8%       0.09 ±  5%      -4.8%       0.07 ±  7%  fxmark.ssd_ext4_no_jnl_DWTL_2_directio.sys_sec
     55.34 ±  3%      +7.1%      59.26 ±  3%      -7.3%      51.28 ±  7%  fxmark.ssd_ext4_no_jnl_DWTL_2_directio.sys_util
    738881           -19.9%     592194 ±  3%      -3.3%     714200        fxmark.ssd_ext4_no_jnl_DWTL_2_directio.works/sec

     38.31 ±  3%     -20.0%      30.64 ±  9%     -15.8%      32.27 ±  8%  fxmark.ssd_ext4_no_jnl_DWTL_4_directio.idle_util
      0.02           +30.0%       0.03 ±  5%      +4.6%       0.02        fxmark.ssd_ext4_no_jnl_DWTL_4_directio.secs
      0.08 ±  5%     +32.0%       0.11           +16.0%       0.10 ± 12%  fxmark.ssd_ext4_no_jnl_DWTL_4_directio.sys_sec
     41.65 ±  2%     +22.1%      50.86 ±  4%      +6.7%      44.43 ±  7%  fxmark.ssd_ext4_no_jnl_DWTL_4_directio.sys_util
   1163070           -22.9%     896752 ±  5%      -4.4%    1111656        fxmark.ssd_ext4_no_jnl_DWTL_4_directio.works/sec

      1.32 ± 18%     -16.6%       1.10 ± 22%     -22.0%       1.03 ±  3%  fxmark.ssd_ext4_no_jnl_DWTL_54_directio.irq_util
      0.00 ±  2%     +25.1%       0.01 ±  8%      -1.2%       0.00 ±  4%  fxmark.ssd_ext4_no_jnl_DWTL_54_directio.secs
      0.24 ±  3%     +37.5%       0.33 ±  4%     +16.7%       0.28 ±  2%  fxmark.ssd_ext4_no_jnl_DWTL_54_directio.sys_sec
     11.85 ±  4%     +30.8%      15.50 ±  4%     +21.7%      14.41 ±  6%  fxmark.ssd_ext4_no_jnl_DWTL_54_directio.sys_util
   5031984 ±  2%     -19.5%    4049295 ±  8%      +1.3%    5099506 ±  4%  fxmark.ssd_ext4_no_jnl_DWTL_54_directio.works/sec

      0.00 ±  3%     +37.5%       0.01 ± 11%     +13.8%       0.00 ±  9%  fxmark.ssd_ext4_no_jnl_DWTL_72_directio.secs
      0.33 ±  9%     +29.0%       0.43 ±  8%     +12.0%       0.37 ±  8%  fxmark.ssd_ext4_no_jnl_DWTL_72_directio.sys_sec
     12.11 ± 10%     +21.9%      14.76 ±  6%     +12.5%      13.63 ±  7%  fxmark.ssd_ext4_no_jnl_DWTL_72_directio.sys_util
   5533529 ±  4%     -26.3%    4078851 ± 12%     -11.5%    4896500 ±  8%  fxmark.ssd_ext4_no_jnl_DWTL_72_directio.works/sec

The test result looks good (only test with 72 process doesn't restore to same level as 
original result).

You may notice the test with 36 process are not showed here. It is because of the lkp
script problem and we are working on it.

Checked the test result of 36 process manually:
  e394ff83bbca1c72: avg = 4267358.820936666  -> the parent of bad commit
  d4252071b97d2027: avg = 3821149.8479718883 -> the bad commit
  6812880b7af46dc2: avg = 4724775.219265333  -> the fixing patch commit
It looks good also.

> 
> HOWEVER.
> 
> I'd love to hear if you have a clear profile change, and to see
> exactly which set_buffer_uptodate() is *so* important. Honestly, I
> didn't expect the buffer head functions to even really matter much any
> more, with pretty much all IO being about the page cache..

Unfortunately, the valid profile data was not captured yet. We will keep
working on it and share out once we get the valid profile data. Thanks.


Regards
Yin, Fengwei

