Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DA752BF8C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbiERQHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbiERQHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:07:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81748FD342
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652890050; x=1684426050;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Y0GbMfUFdRQfRbrEFpGg/zlDC25Q6CXjweDftejynw=;
  b=DW3kxtcT6mPzT7SbHYWDsdkrE7HeZvPu1TkTC4W8ZvWFS3wnSQwNE2iS
   mnj60g4FBH6TjuOXgAO+oXA1e1/8U3cc5MApliAVE/WSp7vkabDV8W4SV
   SIDaBi4iKZgMsc/bcJlrOBbaJS4XN/XMLuQyu6EqJcuTrNKRt3yzvki0e
   F3dqQiuYpOf/hrAoa3eAeI3nVIlUN7Oa8KcKGeUX8txjeTaWywiFTjhwR
   u9u030gcsOcF8O6E/w16cA/PLT3bVXATi0MSMhZr7DQftfHtZ+V9xi7qD
   /OTXFCMT+T0uu6o3FuU04N7tHnRgZoug9jBU3aBSJWJ5nYUku0W/G6yRC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="259315516"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="259315516"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 09:07:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="545537835"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2022 09:07:00 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 18 May 2022 09:07:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 18 May 2022 09:06:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 18 May 2022 09:06:59 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 18 May 2022 09:06:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqI/fnDpDuLCkRcqMBMRYs/dWOsjysosByRp72UVZOKtGdrPlE7CMAwWXVpnnk5ad2ZiJLZlCCcPNNb05p12s3nmiFDqcZVkZAftRTRI+Q9nFmBGSvf2aJsGD/JI3Bv01t1Lr2a3hgmw4CrGhl8xD1ldlkJ/j1ulql2KSD9rT3STQAU9x4k5gar5WPFd0K2r4AdYNBP/DQxuBk03TxCEN05y8l/pCRIv3dC1oJeZgZLv4EOxiTg+wodYxXvgK3BSy9nLHQdsxnyjFbNeDODJHD6Ws0trdpQmYMyoJLCRFIrWVMYRmkPmGgFoKwG6FRFdBKOCtQbn4lf76Doesk3Gow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twTd9mZrNQN9gQl390dr4OIsHRoRmAzF9ek0RAS777Y=;
 b=m6xva5SG4QIXNe0en/nfIKhfuQetN/Lqau+rBUp5mMJ71w5h2E0z1b+D8vdk2AuXURQGaPO+cl4gOWG26v1Gnul7CB7QvDkhH9DyQw5J2QLAHIukYgAz1G/GtRgEJ/ZyHme5BetgA6SHDWhEHwN6sdgeJceI60g2TNqN15amsq4QvAkBCWpu3Zy1PUDJ01ELr/NuXzERHY3aAZlwgcl/ecWLyaYbPaU2goy7rze/Dff2bwsufalVPKdsihD5o3tg5dXyt0Bkf4X7ykUGsonaqUghYrK3NvMe4wFg573EHLRg4xeofIZAuAQ/bJoqbthQ8YXhcBpgQmv5HiKnnB6eIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BY5PR11MB4226.namprd11.prod.outlook.com (2603:10b6:a03:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 16:06:51 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 16:06:51 +0000
Message-ID: <3cefbfff-1beb-bf16-f9b0-ebb526d70500@intel.com>
Date:   Wed, 18 May 2022 09:06:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH v4 13/21] x86/resctrl: Add per-rmid arch private storage
 for overflow and chunks
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Xin Hao" <xhao@linux.alibaba.com>, <xingxin.hx@openanolis.org>,
        <baolin.wang@linux.alibaba.com>
References: <20220412124419.30689-1-james.morse@arm.com>
 <20220412124419.30689-14-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220412124419.30689-14-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0115.namprd05.prod.outlook.com
 (2603:10b6:a03:334::30) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcba02fd-b365-417d-f556-08da38e86b84
X-MS-TrafficTypeDiagnostic: BY5PR11MB4226:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BY5PR11MB42260716B06985D4227D3B60F8D19@BY5PR11MB4226.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSsd9BLsD1CiNMM4RE/95BkM66FWh/a+ORM6cLf63E+cKztqzfK5Yn9QMl7vFu8Ww+9T8mh2b3SHbxwmEOmgo/BuK+PC4C5AF9Pw2VWtjz/PXA+21d6PkUJVNrRZ0yC4evXtlRm96dZtALcAKyhr7yN3WVh6BPa5I+sFN5IWqHbmm6Q4CYRGQiXLC4EAIy2HZNravW7YeRaCEh5nTciHsZEscPxvQ+sc7Jk5eJP2/8Nk1kumHmcC9ALozJq3TAn2soX+T1cvGyR/tWQ3MfutgLzyiexLwWkXFibETaBfvzXgxbUbiKFh5DDspKBoig6HRLpYMHNF3OeBfnqrQxwsCQmH/H9IRugyTvFkTtami2dIAVu1uwK1/RqrMswgWXQuuEmrKc1noIK+ndb55zsu7qY4dyB1DZZSvAjLCqjkXS8JlBMcY1Si1ir6Q9KQnzBNM4Hm/fHauC5xnVB+xG9ewuLFRIFDz8KDJBaGLptj3wuwAcFIGpdf5ygLLffbUNbBX80nDlN5BXPp6ozlvPilpf5hRSWh6qAxJuVcQ8BsjUpaNxHJs+7NP6eB1Ewzha8TrGTaPv2A+hIxFbmXit2A3m67ruMY3DTl7VfZaDtmMUUNf+iuaL4L9uAn3pX7k5DWypmPgwMZ6JCGWV99ttkQ4DbFKwQwmY0iXyQ6cm1aF0KpYqUjEsT/xoyMCcxOZxczWshN7wd4m5LIP1ARfHW/+Cw7U8p/6w809k/spy+6oRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(316002)(66946007)(66556008)(53546011)(186003)(38100700002)(2906002)(82960400001)(36756003)(66476007)(508600001)(54906003)(5660300002)(8936002)(7416002)(6506007)(31696002)(6512007)(26005)(86362001)(4326008)(8676002)(6486002)(6666004)(2616005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHQ4VXNPWE1iNTNLaFpPTUEvYWRaaU9wK283NUVVVGJZYTRFL0ZhTmlHL2Rv?=
 =?utf-8?B?V0IrMFl3eGtMeW9WSUdyQjAvTFV2cFNTODhZVlc3K0RqL1pIWTZQYVRMM3Y4?=
 =?utf-8?B?dG10dElEYTdvd1h4YlVNQkU2NElaaU8rR0diNXBEbU9TeTNCVEFXNW8yS0Nr?=
 =?utf-8?B?ajN6RmpEakQrdDY0RnllMFJnMSt4eHpUcDJWUUQwV3V5bWhvOVVOd0RSWkVi?=
 =?utf-8?B?VjgxM0ZYTkxYaVZ4RFM5MXltaDk4dTAxY25PNnJpaEpzMFhHeUJreXpPRWgx?=
 =?utf-8?B?cTZIcE1XWjVGZW5Pa3czNmcrT1Q4ZTk2M0xoRitXcXRoNjZkSmJBMEhLRDZO?=
 =?utf-8?B?eWN4SFgvS2ZraWluTnFRMmZ0MGhnT1BocTQ0Nyt5Sll4dXlFdWFzSkJkUTRz?=
 =?utf-8?B?REU3Nk1RZS9NL1JDSXdDZncwMFNIWUI4WUpwS3FjYTVUT2VCbGVLazBQS0lN?=
 =?utf-8?B?UlJ6QXlTaTRLa2tZbDhxVnJ4aVpXVnUyWW5BckY4cHRRRE1ZNitnTTcwNEk5?=
 =?utf-8?B?OVJ6dTJJNWxkU0ZNYTMrUzRYblRoSXVzQUk4VmZicUdGWENXS3lNOVpZd3BJ?=
 =?utf-8?B?VmNrMWkraHpNaENQL3pPSVVtdVlCN3NIYU1ubW0xbmFSM1c4TnlZMmYrSnBJ?=
 =?utf-8?B?ajdQRFhDWlc3d2Y5WmZESWFDR1ZOQW0wZVpqY3hicXg3ZDIySk9GK1ZSQnJz?=
 =?utf-8?B?ZlVnSnR6c09uVlJBbXc3N28xY0FRL2RhcDkvVVo3V2NVei9KMVlQR1pKWmQ4?=
 =?utf-8?B?QTNlM2V0TnA5Zjc5ZklxejgyaFFPZzVqZkRiMytld3RGQUtzeWVJT2V1SC9B?=
 =?utf-8?B?TWlHRU9OU2ZsZkQ1elhnZDFIVUJtN2V2QVVLaW5rOE5xeWdRR2lqY0dCYWk0?=
 =?utf-8?B?YmdXelU3c2pzR2ZOZGhHM2kyYXN2WGRNWm1SWFlYbUt6bWNqb2JNWFRqS2t3?=
 =?utf-8?B?WElHa3l4emtmY0lBU2dsR1NXeDRrYnR5Y0JBUGVDZUZJYnBhd1dFRXpITmsr?=
 =?utf-8?B?dldtWE1aVFdWUUtTcWJ6T2ttS0tUYnVWR0ZmY3QyUDBoei9ZOElSV3N6THdh?=
 =?utf-8?B?ekhtbkFFT25OaVZoblhxZFQ1Z1VKbDdsdmZTbUQ1cmVCM3JiRnZ6OXo3SEJj?=
 =?utf-8?B?VEwzMk9KV1V6bm5CR2YzWTEwU2FiVThteDB3TDJUeUhFWmJjSEwrUmdleVE0?=
 =?utf-8?B?R3RIWTMwc2I1TTBycWxXNlFjVGtQc05ualIzd3lib253ay92dE9YSFRpbGdi?=
 =?utf-8?B?cFF6SS9tN0hWVUllb3EzUm1SaVZDYm8rZmw1VFZYZjBaVHgzZ1hKYWJ1d1Zy?=
 =?utf-8?B?SElIWnQxYTNDNm9IZlg3VHQxUkIwdUh1U3U3VitWVEMvK2VKMHlpQU82NG1m?=
 =?utf-8?B?VURqWXpUSTcxZ0gydUdBTTNadVFaUlpOaTBYVW9QWEgrYjB3dXNraktTR3pQ?=
 =?utf-8?B?TFZxRFpleWhYZFd3K3lLSmVPS3NsdDBBbzA0ak8rSTErWTVKZC9lNHM0NUpB?=
 =?utf-8?B?ek1qVXRLTkpIblE2c0p2YUR4TWhUdzhJZ3lwZnlsNHkrWlVVZGZERTh4RHdI?=
 =?utf-8?B?MytUcU5odmNnZHJFS2sybFZndHZVZUdzaGhCaVRHQWNrTEUvUGlJb2pmcXMz?=
 =?utf-8?B?MzVaVXJGT2xOQ1FXUHVMWUhsaWJzeXB6N3ZQcTFCZTkzRXRReVpvS2FzSlQy?=
 =?utf-8?B?QkUyTlFFeTlSamJzemFNS2Y1djhzZHhOeEJ2Q1FLUWpIQUNvK05wWVZDK2RI?=
 =?utf-8?B?a3F1VnBJT0hWdENxZmVaODIxVndlQjVxelpFU3YrQ1hNRm0yUUlQZkluUHVU?=
 =?utf-8?B?WDg0WU1DNlZ6TGN3UUNoZ0cxSzFDdkdEOGlMUndlOHFPbEJ4b0JJUzN2Zmpn?=
 =?utf-8?B?MHBhczU3RTY3ZkJ3c0JCeW5EWG05MTVBM0VEazNMK0IvT3ZxVm9kVEFZM1FS?=
 =?utf-8?B?UUtlRXZCSmFqbWV4WVVOOEZ0L3gvM2U3cVFBNGR5UnpSNU4ydDJ6cG5icGF6?=
 =?utf-8?B?L1d5RXdtWkR3ODdKZnptTTNhNDBoM3RHYm5JVkZRTFVnVTV3WXNRWXRCcTdh?=
 =?utf-8?B?M05EVkhpejV1dTJiZnJOWFhKcVNxdlJydDV2ZWRDaEdZcjNyRUlZU0pMbXkw?=
 =?utf-8?B?ZXl1MGhVMlJkbkJaOU1PMENudkMwNFRNVkNNd0ZHNiswSG84ZEZVOS9lZ2RM?=
 =?utf-8?B?QU5VUUVBcURGZkVRa2pSK0FCeUtRMldKTG8veDg0aFNFYmsrZUg5WGRXcEdw?=
 =?utf-8?B?L1VvSjdwZGJEWWVEdHhFYnhjbjluMnJlVmRYNDJ5cFQ3RWQwSXRMVXFpSThN?=
 =?utf-8?B?OUp5ekdZT0pJOTkvSjZIdHV6UlFqa1I0a25kakJuQ0RIa3dkdXBOVXpUVVV0?=
 =?utf-8?Q?MwXQvd3YS/B6jlu4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcba02fd-b365-417d-f556-08da38e86b84
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 16:06:51.5821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kr0I6zCwpIxkd+9wIKuvOM7c01vHGPkR/qiojkYZIftqkutX0yUV4BxLZ0PGWOSlEoQquRIuMdj2fEkf0z2AYAgFerS2jRObl+SF9ZVr4QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4226
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/12/2022 5:44 AM, James Morse wrote:
> A renamed __rmid_read() is intended as the function that an
> architecture agnostic resctrl filesystem driver can use to
> read a value in bytes from a counter. Currently the function returns
> the MBM values in chunks directly from hardware. For bandwidth
> counters the resctrl filesystem uses this to calculate the number of
> bytes ever seen.
> 
> MPAM's scaling of counters can be changed at runtime, reducing the
> resolution but increasing the range. When this is changed the prev_msr
> values need to be converted by the architecture code.
> 
> Add an array for per-rmid private storage. The prev_msr and chunks
> values will move here to allow resctrl_arch_rmid_read() to always
> return the number of bytes read by this counter without assistance
> from the filesystem. The values are moved in later patches when
> the overflow and correction calls are moved into __rmid_read().
> 
> Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
> Tested-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ----
> Changes since v2:
>  * Capitalisation
>  * Use __rmid_read() as this patch is earlier in the series.
>  * kfree() one array in arch_domain_mbm_alloc() when allocating the other
>    fails, instead of relying on domain_free().
>  * Remove the documentation that domain_free() has to be called to cleanup
>    if this call fails.
> ---

Please ensure that this list of changes are always preceded by "---". In this
patch and patch 21/21 that uses "----" the list of changes ends up as part of
the changelog when using b4 to pick up patches.

Reinette
