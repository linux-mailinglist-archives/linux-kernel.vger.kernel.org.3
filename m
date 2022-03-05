Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494BB4CE181
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 01:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiCEA1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 19:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiCEA1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 19:27:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A87D5DFD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 16:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646439984; x=1677975984;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yGGBG07RVMLw6OgKH2LunB0ymcTBB6gPIE6OO2FqY1c=;
  b=XeeyjAG0bWO+GLe+u58km23FbMzTcCk6MtiHCjtmxuTEWK6QLpJg5pvN
   i/8WaqikjVHK+OC9Hmc6p2QzuZkuCmmp6GIDIwCxx8HsVSoScF+ufYsIA
   WdTCLqh8jUsmY1PoG8npKhkSVycRlEGbwXJAe42s9Qxd2fD8gh1XgOa5e
   sUKF882+WkQMtfbfBV8hnD4lj4JSMzEeyvMpviHXqsa3u3no2AVaa0Kvp
   b7CL5GRd71hZVAUKMlkm1MIpLN2iiCR1dV34Jl2RU1u7EqWjqs2ueYL+F
   erH6VIHq9qGg9ggEyGctBiFM0X15kna6PbZx5xgGE0Diem9TJ0WWZcAK1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="340523052"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="340523052"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 16:26:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="512039692"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 04 Mar 2022 16:26:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 16:26:23 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 16:26:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 4 Mar 2022 16:26:22 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 4 Mar 2022 16:26:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iosrePu6MCv3682ADeduFVfMG/BYQ9yZff0+wsvbw5y7/POANRlof1hAuvV2KUPNEZ5mHzGkaObbLOhjhfp2fu05KiQf/otKa1/xPZ+qvchtCaC3So7XP9Df//hN7jXkTLoGfA2an+IIigPyxhWqdBN4ZO9SObRRh5pqOFU2Yp/UqzYkHMcyjccQ5lUtJPF2TJZODdcXUlBLUzZ8XoQqy5hczE2pUqJhVju3CCzcjteWCvPqnUbf2qZXWy5TnjpM1RAuc3BcPL5rRagRWYDBAj89RlpUXiDe30TZOp/hbCBlQJmkv3PuHYfEXHsC4AGnPHJ/7z+9ES4JOsr3bXIpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91ycGKMl95szRqdkQX5uP6BNAj5wUoRT/0BWye7Fg0U=;
 b=HUcXdmsLSl780jD441/R9lM8lQM2r/xZfp2Sg+rO2fzfI8YA5fP/u+Y92kVZJKQHBk2aOwobw1XkT7heU9x/mH6RrQUiv27dJ9mk8h6kFh2KdLmbv2eqKbxJzMqk3gzErMR7aUbcgkd6LeNNTZutanEXTHGJ4saE1Z/1qcnE1SejVSJEtr+yRVtHZYkGCwNzqwfNe8RA12WYJs9+9eaAxA5/6NG4unGxLyy4xpaORrDzNHy67jI8RGiaz6sSUKDYTi265A7UuX+GwMMtLaEO83gxQ6ZC9EForHNIuDW+wNA6ixgW+QP74zVs7NFpkQNA+f4/zQiDkbfohpHWX89QsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB2034.namprd11.prod.outlook.com (2603:10b6:404:43::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sat, 5 Mar
 2022 00:26:20 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.017; Sat, 5 Mar 2022
 00:26:19 +0000
Message-ID: <40eae910-29fb-4875-c26c-ee901bb49a83@intel.com>
Date:   Fri, 4 Mar 2022 16:26:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH v3 07/21] x86/resctrl: Create mba_sc configuration in the
 rdt_domain
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20220217182110.7176-1-james.morse@arm.com>
 <20220217182110.7176-8-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220217182110.7176-8-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:300:ae::24) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79e6be53-4d16-46f1-2b7d-08d9fe3ec4be
X-MS-TrafficTypeDiagnostic: BN6PR11MB2034:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB20343D6768969CC9A4748852F8069@BN6PR11MB2034.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sV/HfjBKks/vzyPU6rTBdbefAi5abxEIPfk2Ei3hcnCiJjOeVVFAnPmeCasBhvbk0Ka9oHMfBBFr7p9ptO4Nvs9/gs+CxxWoS7ujTlwkNiUig7VgEDTEgZRjMMjvctUpnO2oLgyMhY1wtw+dxbNKFFVHffTB4sPjtEqBdYxjZWq8Cr7uANMbyeskMaBV3jtOtBo4sui2R0eNdZrwfIF0vT9dLSyYwi9jG0xJBlax4a8Plqth/nq6U39IBN/0mh5WM1uBjCHLK2V9MiYQMm0yFiASAXzwZ5b7SrIepvmyxNsau+5xRnKmXWff1MhM4p/eQND4c6eLRFSdCZbkNQOkDd/60UU8ypx0kxJ9yOctQvIKWvRS5tje+ufiyTfSXorhpk5qYcLzKY4zFsybkwwMEQkfPU2KYMB4JEuuv12xaxoOlRxejEV46Qoy86Ynxa7UFy3MxMiNP2qAPobypcMs5zoOJXDu4Uk7mKfUUAxt9c84M0Vh76t/PcSMGFDzmFVC/7TlGDPCBYLslWEdV/BKm5bgCLcKfSNIlgtjZ3gfNGQHS0sVLlz4RVgTokwqsGGM2FQPy1qp6OHjAerZf3xaK2Z70C49Ah6Iq91Qxciu5Ipj2hcLtOAgA2pfhzzDJeng2KuxAtmek7ZNGAnBqh2MzV5s+NAp6bmnGRKoupstLwlx5+MZ5FR0mHLAxLWzicG1iTqXgSaym4mzdmjs3jRzt7hTF9+YqtFjLFd+YXOpSr5WCqWY83WhBFRIZdCtZpv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(82960400001)(6666004)(31686004)(83380400001)(86362001)(4326008)(8676002)(31696002)(66476007)(66946007)(2616005)(66556008)(36756003)(44832011)(2906002)(7416002)(26005)(186003)(5660300002)(6506007)(53546011)(38100700002)(508600001)(8936002)(6512007)(6486002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXdlVmVTYmpNSUhKeEdWMkJCOXR4N0tTYThxREZQYzVPU0l2K2dNcGtDL2hk?=
 =?utf-8?B?Q0pkRFBtZ2FlSjVlVFc3UmtjM2VEZmY1clI4VFI0dk5TdUFvRXZoVjlsSVZT?=
 =?utf-8?B?RlhkL09DbUh4aFdlLyt1RkdXTER4M29iRVdKL3RpMkUyTEE2V2crOCs4eWUz?=
 =?utf-8?B?cWV2VDVYRkpDRGsvOGx6OTdnMXFQdWl2dnlUaEZ6eWVtUlNNRnRrSlVIN1lH?=
 =?utf-8?B?N1d6WnNXRDQyNjZkcHNKc0FDTGdWdTNLS2RGU2pqOWV4UWl0VEs2cTJFbXJ3?=
 =?utf-8?B?ZWN4K3ZISno2N2Z4ZmwxeHVPMW0xL2xmN2NSbFdYdGl0czNPS2I1YzVYQUFE?=
 =?utf-8?B?WGMycTBYV3JkV1A3bnc5SUR1eGU2ZXJta0NVeWpOR1FBTGgzVUg2clY0RHh5?=
 =?utf-8?B?dlFjTlNLMTlTeFlObE1IV2puT0I2R2pSWG0zSlk5UHM3bUU2aDZ6YWVtY0xn?=
 =?utf-8?B?RXJ1MkZ0UDdUbjN5ZThrWE1NbVVhY3k1WUVaeHlvdWtucm85WWhxZEw2ODBM?=
 =?utf-8?B?VU1rcWZxTjV6S3dwVW9uL1V2SkhNTCtDSWtpQnhxakltTzhDUUFqREYwZm5o?=
 =?utf-8?B?UWxLbzh1WjhuQTRmNnM2QmRqajRlQWZBUlA1Qlo0aWxORU91UC9XRFdBaE8y?=
 =?utf-8?B?a2NKQ1Ard3NLNjFaaVgxUTV1bmswR25vYmE4K0pJYTRyVlpBcFp4c2NINHZN?=
 =?utf-8?B?dGtBL2hIZDZycGEyMmtTR1ZiZnBYdFF3b3RkVVczRVJtNzhtWXphNTU3TS9T?=
 =?utf-8?B?NzVXeGsrL2Ewd0YzNWZreDQrZys3a3Byc0EweGtiREd5Q0pVOFF4bGVELzlG?=
 =?utf-8?B?Y3k2WHppMEsxMmQ0cjNjZFBOOXhKODBaZUloNDF4c0F4ZHBHcnJxQXZZVVN1?=
 =?utf-8?B?NDJVRXVQamxPakI3VGYzb1oxUUo1Ris4RTFsdk1jVis5eDJrOUsyMGk3OEhs?=
 =?utf-8?B?OXIwRkZFTGlod1M0dlgraldpZWFTWldjL0kvcU96TGd0ZDljWXVxT1pJSnVv?=
 =?utf-8?B?NUNLcFFIZ1cvTkxvMi9KVkpwU0dKMHRTcVFtRHk1YktJRVJ1RjhydHJXYkc4?=
 =?utf-8?B?REY4WjBvNlJKNmR4T3FoYXNRT1NlU2RaZ010ZFhUQXVlR2g1V2NGMGxDbGdX?=
 =?utf-8?B?VENrNDRwaHZKV2hHb2g2dzNOVjVTZ0ZQTUVqMHltWGRVQk1KRFF0K1FzYTBT?=
 =?utf-8?B?UFdGM0xTYmI0MkJCUEQwbVRBQWg4Lzd0U0Rpa1ZJbVZkSTQ3ZEppeVUyYUx5?=
 =?utf-8?B?NnZ2Y1NEZ3R6eXY0WHV0T2dYUmdsKzFtZFJoRWx6RmZIZ2llTTE2Q2dScFp4?=
 =?utf-8?B?UHQzWGFUM3I2czIvWXQ2WGd2NXNQZW1UV20zUUh0Ykg4VmJKcm1ZUlp6ck9X?=
 =?utf-8?B?emFzcGVUZFBBWDdQdW9Hd21xWG54WVc3c1VETTJ6MDRGOTdkZUlPY0c5NTJC?=
 =?utf-8?B?Q3Y1RmRJSGhVZUhpNDQ3YkJRejBITmVHdElKZFRSdklSaThzT2ZiYnhTaHV1?=
 =?utf-8?B?NnN4UUFTdmFmbjJHZzgwcmEwMDdrY0V3QWZNc3A5NXJYZlhNR1hNNVA4R3N3?=
 =?utf-8?B?UHo5OHYwWk1NUkVTS0lSZjk0UVFKZFlVN1laOUg3Zk9jUHdjU29uWW92STd1?=
 =?utf-8?B?bTBNV0pkZjdoUEV3eFF5di9NQzVLeDlwL0c4ZzJsVU1TNUlOOS8zK3dyOThh?=
 =?utf-8?B?SzRZbDhjZGc1RTVoeFBmbE52anYwRFp5QlpvVmJ4c2t0NVdHdU0zdFJ4OGNm?=
 =?utf-8?B?a2RhTzhGSkdWOElLRjE3Z09MbGtQekxlUGxTMkVzZWhJT3FBRjBzZUNROHBP?=
 =?utf-8?B?YTY3SnZEbURLZ0xuL3JIbWpPQXFTbEJ0RjFBcWlVTG0wQit5Ri9YMGFEWHh5?=
 =?utf-8?B?bU0wTHRLNzYzNGJRUjFOM2YzOXgwSnRhYUd3ZjhnckNhMDUwbE8wVllBZDU0?=
 =?utf-8?B?eCtwQWtFbTgwZzVETWZBT2NPVWNPY2JPTGQ1MjFCa3JKaTk1RTRtRE1PRXpq?=
 =?utf-8?B?THJzc0VKeG9ETlh0R1dhUGpHMHdDZVNLTmJlNDhraklBUWJDaENEaUVBNzFt?=
 =?utf-8?B?YXdjTTJERjRERTZkZXlaWW9XVjc2bUhvaTBtNlcvZEtaSllYajVxVlk2Sk50?=
 =?utf-8?B?ZjRZMjg0Z25VOFNCcHVwVFFIZFc4dU1VbmR1WFFJT1dPVzF1RWNITE9XTlor?=
 =?utf-8?B?RlZDK0ZYMHFVSnpFVWpJeUplcktkaXo5WTVNUW01bXZqQndUOXc2WVlFcTZz?=
 =?utf-8?Q?oGAIuGWqGTvd1dLdmV13ROFPrT3R6LbEROdHUBAwr4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e6be53-4d16-46f1-2b7d-08d9fe3ec4be
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 00:26:19.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xvmaqcw6GbSSlx2jomZoX7y/FHPl9HcIKdAtm2/6CNT+MoJHhAnRmvIu7dj/ZjgIBUmoWZh/DkHaVkPntsj7D7JlxvZuLHqHJVnigIfgZCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2034
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2/17/2022 10:20 AM, James Morse wrote:
> To support resctrl's MBA software controller, the architecture must provide
> a second configuration array to hold the mbps_val[] from user-space.
> 
> This complicates the interface between the architecture specific code and
> the filesystem portions of resctrl that will move to /fs/, to allow
> multiple architectures to support resctrl.
> 
> Make the filesystem parts of resctrl create an array for the mba_sc
> values when is_mba_sc() is set to true. The software controller
> can be changed to use this, allowing the architecture code to only
> consider the values configured in hardware.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>  * Split patch in two, the liftime parts are a separate patch.
>  * Added reset in set_mba_sc() now that we can't depend on the lifetime.
>  * Initialise ret in mba_sc_allocate(),
>  * Made mbps_val allocation/freeing symmetric for cpuhp calls.
>  * Removed reference to squashed-out struct.
>  * Preserved kerneldoc for mbps_val.
> 
> Changes since v1:
>  * Added missing error handling to mba_sc_domain_allocate() in
>    domain_setup_mon_state()
>  * Added comment about mba_sc_domain_allocate() races
>  * Squashed out struct resctrl_mba_sc
>  * Moved mount time alloc/free calls to set_mba_sc().
>  * Removed mount check in resctrl_offline_domain()
>  * Reword commit message
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 -
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 41 ++++++++++++++++++++++++++
>  include/linux/resctrl.h                |  7 +++++
>  3 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index e12b55f815bf..a7e2cbce29d5 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -36,7 +36,6 @@
>  #define MBM_OVERFLOW_INTERVAL		1000
>  #define MAX_MBA_BW			100u
>  #define MBA_IS_LINEAR			0x4
> -#define MBA_MAX_MBPS			U32_MAX
>  #define MAX_MBA_BW_AMD			0x800
>  #define MBM_CNTR_WIDTH_OFFSET_AMD	20
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 794a84ba9097..e4313f907eb6 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1889,6 +1889,30 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
>  		l3_qos_cfg_update(&hw_res->cdp_enabled);
>  }
>  
> +static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	u32 num_closid = resctrl_arch_get_num_closid(r);
> +	int cpu = cpumask_any(&d->cpu_mask);
> +	int i;
> +
> +	d->mbps_val = kcalloc_node(num_closid, sizeof(*d->mbps_val),
> +				   GFP_KERNEL, cpu_to_node(cpu));
> +	if (!d->mbps_val)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_closid; i++)
> +		d->mbps_val[i] = MBA_MAX_MBPS;
> +
> +	return 0;
> +}
> +
> +static void mba_sc_domain_destroy(struct rdt_resource *r,
> +				  struct rdt_domain *d)
> +{
> +	kfree(d->mbps_val);
> +	d->mbps_val = NULL;
> +}
> +


...

> @@ -3263,6 +3295,9 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>  		cancel_delayed_work(&d->cqm_limbo);
>  	}
>  
> +	if (is_mba_sc(r))
> +		mba_sc_domain_destroy(r, d);
> +
>  	domain_destroy_mon_state(d);
>  }
>  
> @@ -3309,6 +3344,12 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	if (err)
>  		return err;
>  
> +	err = mba_sc_domain_allocate(r, d);
> +	if (err) {
> +		domain_destroy_mon_state(d);
> +		return err;
> +	}
> +

Thank you for making this all symmetrical. It seems as though the new
array is always created but only destroyed when is_mba_sc() is true.
Is this correct?

Reinette
