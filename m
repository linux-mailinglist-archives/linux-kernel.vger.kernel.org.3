Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAFA4EA124
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245693AbiC1UKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbiC1UKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:10:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A8F23BF0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648498138; x=1680034138;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HFpybh3ZWuKyDzDJOFIxPqzdbIjuaoLtXTopbH0P/1I=;
  b=MOgZwVBASQ+O+BxdFr1opBUE44a8yunitocUUmYg8ikanY8A6n5JjGV5
   QoxJRnI06kQukdArW8FJGWP/DbyL15kP5gFwsJv6GLAG2X6EYJ4bqTziz
   nLY46kCCRieTjAnD6jKblj+17sjASuErp9DMXt35sFORBXMtKZ2p4vDDD
   z56Di3m3+sFMpg929pq98Po1YiFKpxRYW5IumpiGtIZXqTT2zT9AyVmvW
   odGAWw4/Ft1t1enc7iNwcD8SU2IMNpwuAoMLHShMw4sGkzDjfeH2MUBPf
   rrfyQHMuxFjyW5/6uNVikRYiRuUrG3Cpl2byOj0fJ9bQHdkpr9DeA79Hm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239026451"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="239026451"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 13:08:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="649192577"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2022 13:08:57 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 13:08:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 28 Mar 2022 13:08:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 28 Mar 2022 13:08:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHFI7vPDHZzFs48/ZEJPAWKK235HFIehs5hfF/t0jPkbZ0/7LxLmHakaxd53wv048phr9u8R/XCTsD2taE1PD0vm37soTgu1MMdGoI9f3c8BsClfPltBTIWeiZmaNxeNbAM2Q1eIIAjFmH4UdofzbS47Q3ub55N+gPdFniQjBR+hOXp7OMAI5o0Jy93NTMvIXrmCvrD4idePGGFl1Y463al4ODVXNqesMUXWDe21y7+bFIbY7mp0ZYTsyFTw4BpHsV/qVzAgLRS/xWbxTtTswMoO0u1BEzpWkoDwNtOaX0HjIeK2VSkcKpfco/lINdpD/cPLCW/uDMggDV2oj0Tdkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFpybh3ZWuKyDzDJOFIxPqzdbIjuaoLtXTopbH0P/1I=;
 b=QBuF4PAk2CCbtRUFrYjpXs2kpknK/aQMMgrRcmPc4WChM6FWc6sgF4saV5kbWX177gzc4xyfqEgw+CFAUQyyJKVPeTC8kdUQ8/v6juSRYjlAFHt93hNXq/m+3cmoTuvvReev1ZM3tyOF6lRvmpAnCsKGEqjzZ3w4Px8Vbn4QyPSvTj2pH0DpCYPvnHfrdIOXLPXN2DGSYdb5ekYydl4QB5DjvmKM42P5ckIHAF0nDs12poQyaULrdAK1Lzif3UKl+bOMrX1q86v5nBemOAplZAtJAqjf+Ijt7kMvb6zykDadpI2hEzCj4QsU8+KUUMtwoe9b4QnDO0e2ILlWqo6Zrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by BL1PR11MB5543.namprd11.prod.outlook.com (2603:10b6:208:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 20:08:54 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::c94c:fd5d:2e7f:251d]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::c94c:fd5d:2e7f:251d%12]) with mapi id 15.20.5102.023; Mon, 28 Mar
 2022 20:08:54 +0000
Message-ID: <83f24772-3fa5-c775-a3a5-77d57731d56e@intel.com>
Date:   Mon, 28 Mar 2022 14:08:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [RESEND PATCH v1 1/8] firmware_loader: Clear data and size in
 fw_free_paged_buf
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, <mcgrof@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgoncalv@redhat.com>, <yilun.xu@intel.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>, <basheer.ahmed.muddebihal@intel.com>,
        <tianfei.zhang@intel.com>
References: <20220323233331.155121-1-russell.h.weight@intel.com>
 <20220323233331.155121-2-russell.h.weight@intel.com>
 <5ec3e671-53aa-b8cc-1360-c454f3db277d@redhat.com>
 <2bd89743-78b8-0e1a-bbda-10d2fedb863f@intel.com>
 <16f93247-3af2-e9cb-b7f6-c8305fa1db33@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <16f93247-3af2-e9cb-b7f6-c8305fa1db33@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:303:b4::14) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cdc641a-ada3-4c68-1406-08da10f6c8b0
X-MS-TrafficTypeDiagnostic: BL1PR11MB5543:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL1PR11MB55431DB6C2B2817822243ACCC51D9@BL1PR11MB5543.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFiQChB6bpWyvlQVZQB/4Y+c/4fBz90ZeI0S3H7EIy5xOA5s0UN518DQ7KEkAQAfJXpOz5BBny1Tc3UZ6B8Zb7qbaZqXAs2Tj2MFSizVWK+eOXaZwrY7A8linKWDXmQAH2ZlvuOjOH1SaDFz5jMdOth0H5BFgS4rThOtz+oWs8cno3chZq2+0GBaiuEdnYIderFCHqABcjsGNdSWMVqR/bXaTNetx2bbEriE5owfS9KvCb3NwUOIcKFdonjFJqRg2DGY2xmZ0Fb5DbsoMo01MDZcLP0hiDEy53Tz5zHUGtZUVXkhafV12Uj1fsolMtpLqM7w4DLvnvR8qkxjojeUvcpVMrug54MqFmCPNc8Xo7YxuNYsSfQI7jDIkFQR1ANHuyEgzJMlSeiLTicCahqIx+2HiGB5ZR8qcMAFZw7NHQBdllzGdT/qYeq7LS2HtPhItuZpdQL9QBwUxnk/5M6NtUyee9ama8bKbu8YyPzml5qXM/7quKxL35qqxPqPHs5upnK0PIlD+3TCJIKPXg5hNlNsjL0YhAjKouStiorBPnSzj7JylVTIB1DIcBqHUAgkpGnyFNnZvwDDBFojAH7DviBH1tnmsjNUxtE8r/JzR1UDgaf4eSrEFtYuV9/G6wqKsf6dHr4BF0s+VjcxzomvmBGdRz8HRn1DoL45iN3Mj9r5fLys5Dr2p133OJ1Pyw4gd52SE5GDxnZkB/g1/F1j0g+40hy4fjeyZH7VgdWwDJMOsnw1Ue+oI7pExmbtSD0xmjkUVJTWRNpF61rMxsLZMTV8c4QkRTtIR7C8jaxvE2d04Rs41aw4B7rNEmUsIk+vEQ+AYi4EkSfbIE+kckIflrAo1HA/r0urFpJeUALwlSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(316002)(83380400001)(6506007)(4326008)(66556008)(66476007)(66946007)(36756003)(8676002)(31686004)(107886003)(6486002)(31696002)(53546011)(6512007)(86362001)(5660300002)(38100700002)(8936002)(966005)(82960400001)(6666004)(508600001)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1NSdFZ0R0U5TFIrNFhYME9vc0ZheFJHSkNacnhodXhJYzR2bFh5eDMvaXZ5?=
 =?utf-8?B?dlBtcWJQYWxwcFJrajhQTjlTZDM0MU5ET2NuV2R0bXpVU09uVU9QOWk4NG5J?=
 =?utf-8?B?OEJJYzFnQUhIMUJEVnhXbHVFY1lxNnZPSm1VcHQ2ZUN6dmJvNnNGZWFBcXlH?=
 =?utf-8?B?Z2RZM1VkaFgwNEZDaDkraStsNVVhS24va2RVZFlmUHB5ZXgzbXlUMGQ1Sm5k?=
 =?utf-8?B?bzJiNzd1Mkt0cm41VEFVNXRvaTcwd3BuU2NjT0xTSGhLWkd2L3dTWjBDZXQ0?=
 =?utf-8?B?aHM1YVc2RWk0aHpwV3BKaGw3Nk52RHNYNmxpTU5kMEpVR2R5TS92QUVRbGpW?=
 =?utf-8?B?b0ZxbEgwZzVZbGpNRlVRMkNWS0cxMTc3OVo1RSt4S2N3eXJsNklvS0N0QVR6?=
 =?utf-8?B?SXVBOTNJQlQ2bUFUZ1N3Y0d6RGJRQldiOTlkV0Y4NTk4ay9jODY0T3RkYW5S?=
 =?utf-8?B?c2hXM1Q2bnhNZ0MzQ2p3WDl5NmdsM3llSnF4bHQrUk9idlZMZlZ2eHl2c0Rv?=
 =?utf-8?B?cXgyVjcwQk1iMnR1RzUxMXQvdVBXdFZlSkJGbG1GU3ZUNm4vTHNFODQ4NmUw?=
 =?utf-8?B?RitTZUFsNit1ekw1dWhKL2pPaDJiN0ZKYUhQb0ZtbXhZOWlKSmx6VE5VLzFG?=
 =?utf-8?B?ekRER2tOSnlnc2RpYTRIY3R0VytOR3lYU1plVkt0enI0OEduK0dVUytJNEt2?=
 =?utf-8?B?TUpXWWJlTzc3RUhFa0xyQ1h4cTM1KzJzV3JQWjZIVkgzVFJMUXltVkZoeXR0?=
 =?utf-8?B?MUdpakVITTBNNW5URStLYW5DUzA0N1N1YzAzeWc2Rjg2K3N0R1lBRDhUZ0Ft?=
 =?utf-8?B?MytuMlRlVmY3enJYK2NHNm1EekVONjNPQldpbmdMQmZ2OGg4SnBaR0EwK2ZE?=
 =?utf-8?B?Nkc5QVJ2c0NlekhxUlBkK3h0bUtGT2lPMGVCWTNsNzQvdU1FZFF6WmR6RTdh?=
 =?utf-8?B?YS85bXZVZDVtWTBxN2JuTmdmYVhnMlQvRlIwYk1sNkl6cWhaNnkxeDJEdnRI?=
 =?utf-8?B?cVNKRWY0NHpBZlFQd0VIbWJuVXRFZXhaYzdvOGpGR2h5akRyaEg5UjRJQUJY?=
 =?utf-8?B?SzZ6WTVxRlJvUVpLTC8weldyVGRaMVVzVXUzd0NFejhUQUFoYnJJb3FqVnFD?=
 =?utf-8?B?SWpGazYxNys0L3dpeXNTdEVsWnF0dy8yVVJMM1VnOWZiR2xXU3ZHUjNVME9n?=
 =?utf-8?B?cEtUUzMzUmc1TjdEV09Ia043TVkvNjQrU2ptMEszanNBRUZpaG05WjRVSE1p?=
 =?utf-8?B?Sm9ya3JjeWtwSURqOVN6YUhtRHppQkt6YjNsRVo3Q0lxVExLbThqaFhZbXJm?=
 =?utf-8?B?TU1ZeUxVbFlDTUZibHhSMHYzcjdyQkp1T00rRGdTY1NYM2E1ZitjSXRFUE1p?=
 =?utf-8?B?VjhMWng3bit4cGZsVGtMNkZSRDUxMW1FTzN6ZUgrMktrVzhFQXFzUWR3OThR?=
 =?utf-8?B?cHdBMHYxdnEzenVDQy9GSGkxejZmeVc3YjNUV3k2T3hDbmRjQ2FsZjlwbjFt?=
 =?utf-8?B?bXBNZ0FEVlRZSi9FajNFRHVzV3hOTzJoRFVrSm45aE9yR2FhZ3VudFBvZkZI?=
 =?utf-8?B?Vkhza2VsYlk4ZFluajRZN3F4L3lmQjVaOWJQcEkzK1ZjMGlTUm9ZZXJiSklR?=
 =?utf-8?B?TGcxMWNQQ3VDVmY1cnoxSnplUEJ2b0VDbzErRWdrRVpUSlNKUjg1MzlBRjMz?=
 =?utf-8?B?STljeGoxeElCbjZPUXN2R3FOTjF5UUlDeXdUMmxVRURSS2ZBSG5rdEwrN002?=
 =?utf-8?B?WDhraXEwZzUzWkJyRm9BOXBDOFcxK0V1QldYaUliUnRQb0tnUWMreFZOUktT?=
 =?utf-8?B?UTFQSmtyU1MyYjJwOHFCSWhoZ2FyNElEVlFWQlphbTZlbXI1OTMvSHVLWXhN?=
 =?utf-8?B?NFNSYzROTGhEUUxPMCtIOFc3WXZ2OWVodE9MVk84cG1MU1NCeEN5L0hqRHhQ?=
 =?utf-8?B?WWJ6UFI2TkJVekJoaWdqeW5HUHZ6eUd0NGdma0VxUnBZRzI0cWFCMnpmVmJq?=
 =?utf-8?B?ZXJZS0VwOUhHaW12Y1R3KzBuQlRuWlZJNWpwZSt6QUR0ZE1Xc2kxZ3ovcHVO?=
 =?utf-8?B?WFJZN2xLNmNtWlNCRVJqMXBRcTR4cmVzeWZLL3NsQnNRM1VTbm9XRzJ4NjJ5?=
 =?utf-8?B?K2pORWFGTXBHQm1hZURKTFpRMDc0VTYzNkhkK1FLOXBpNS8wZ002YzBSSlFG?=
 =?utf-8?B?UVZIbkdJQmlnWjdzdGtWK3JqazBBM0NCV2VqdHlFY2h2dUlZS2pydkNZQnhH?=
 =?utf-8?B?Y21NZnFoT3BqWG43T1JtMmZsRXZEUVI3a0xoNU53WXluR1JaYzNTbE5BYi8x?=
 =?utf-8?B?SjhEVG8vQmlYYTZCT0JhUDQ2N2d5R2NUaW8wYmQxdWtkemtpRWRobDNJRnln?=
 =?utf-8?Q?n9B/9K8jxLS9iXkk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdc641a-ada3-4c68-1406-08da10f6c8b0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 20:08:54.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtImnm25fgzVfq5ecOg5tf44+MXzj3xtW6mRkqmmyVFtmwvzCypgLhI8cw1Xw189bZZmDQIyEB1n9o01CzCcMx5QXumVPtBLnym97oSwOms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5543
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/22 11:52, Tom Rix wrote:
>
> On 3/28/22 11:09 AM, Russ Weight wrote:
>> Hi Tom,
>>
>> On 3/28/22 06:27, Tom Rix wrote:
>>> On 3/23/22 4:33 PM, Russ Weight wrote:
>>>> The fw_free_paged_buf() function resets the paged buffer information in
>>>> the fw_priv data structure. Additionally, clear the data and size members
>>>> of fw_priv in order to facilitate the reuse of fw_priv. This is being
>>>> done in preparation for enabling userspace to initiate multiple firmware
>>>> uploads using this sysfs interface.
>>>>
>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>> ---
>>>> v1:
>>>>     - No change from RFC patch
>>>> ---
>>>>    drivers/base/firmware_loader/main.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
>>>> index 94d1789a233e..2cc11d93753a 100644
>>>> --- a/drivers/base/firmware_loader/main.c
>>>> +++ b/drivers/base/firmware_loader/main.c
>>>> @@ -253,6 +253,8 @@ void fw_free_paged_buf(struct fw_priv *fw_priv)
>>> Why isn't a vfree needed or realloc done?
>
> I am looking at the use of this function in __free_fw_priv
>
>       if (fw_is_paged_buf(fw_priv))
>           fw_free_paged_buf(fw_priv);
>       else if (!fw_priv->allocated_size)
>           vfree(fw_priv->data);
>
> Where it seems like there is another way to set data, so it needs another way to unset.
>
> The vfree here looks suspect because the pointer comes in from request_firmware_info_buf with a hope that it was allocated by vmalloc.

There are places in the code where, if fw_priv->data is set, it is assumed that it
was allocated by the caller. In the sysfs-upload path, vmalloc is never used - only
paged buffers.

As I have revisited the code to answer your questions, I see that in the firmware
fallback path, after it checks for (!fw_priv->data), it sets "fw_priv->is_paged_buf = true".
I realize now that I should be setting "fw_priv->is_paged_buf = true" in firmware_upload_register(). I'll make that change and rebase on 5.18-rc1 when it is
available.

Thanks for the comments!

- Russ
>
> Tom
>
>> The free and realloc support was present prior to my changes. The page
>> buffer support was designed such that if a firmware write was cancelled, the
>> existing fw_priv structure could be re-used for another write in the context
>> of the same firmware upload. However, there was no prior case for completing
>> a write and then reusing the fw_priv structure for subsequent firmware writes;
>> fw_priv previously had a one-time use. The changes I have made are to enable
>> the re-use of the fw_priv structure.
>>
>> Initially, fw_priv->data is NULL. The "realloc" functionality happens during
>> the write of the data binary attribute here:
>>
>> https://github.com/torvalds/linux/blob/ae085d7f9365de7da27ab5c0d16b12d51ea7fca9/drivers/base/firmware_loader/fallback.c#L426
>>
>> The fw_priv->data pointer remains NULL until all data is written and the
>> user writes '0' to the loading attribute. The fw_priv->data pointer is set in
>> fw_map_paged_buf() which is called here:
>>
>> https://github.com/torvalds/linux/blob/ae085d7f9365de7da27ab5c0d16b12d51ea7fca9/drivers/base/firmware_loader/fallback.c#L274
>>
>> In the unmodified code, the fw_priv->data pointer is never cleared. My changes
>> reset the pointer to NULL after the memory is released so that the fw_priv can
>> be resused.
>>
>> The new firmware-upload happens in the context of a kernel worker thread and the work
>> function is fw_upload_main(). At the end of fw_upload_main(), fw_free_paged_buf()
>> is called to do the free. This is the function that is being modified by the lines
>> below. This function calls "__free_page(fw_priv->pages[i])" in a loop to free the
>> memory pages. It also calls "vunmap(fw_priv->data)" to free the virtual mapping.
>> You can see the unmodified implementation of this function here:
>>
>> https://github.com/torvalds/linux/blob/ae085d7f9365de7da27ab5c0d16b12d51ea7fca9/drivers/base/firmware_loader/main.c#L241
>>
>> - Russ
>>
>>> Tom
>>>
>>>>        fw_priv->pages = NULL;
>>>>        fw_priv->page_array_size = 0;
>>>>        fw_priv->nr_pages = 0;
>>>> +    fw_priv->data = NULL;
>>>> +    fw_priv->size = 0;
>>>>    }
>>>>      int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed)
>

