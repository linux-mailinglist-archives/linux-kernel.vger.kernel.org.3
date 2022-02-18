Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B98D4BBDC1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiBRQoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:44:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiBRQoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:44:34 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225D82B2C51
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:44:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjnKPlFjCijtBLzbqMmaz4H+UKq/vQKdEuGe4djUYQiLDj7MCI76FxRd7DePfQNism9wgykn5r/ybuyeK6vddypQpK8e81kBAG/ICBeTc7Jil5gEQNb/jRg9uyTZcIWbN3IgBznc9lDOnrAqP+gRtGnaF/kSHkEH9J7w4bj0mUm5NEz3fiSlmFwsYxxpdDCtPKipUQYIUdalNCiuN5ns/04wFzeed6Pdq51TZmHCNFstui/ZsYcllSJVUFOC1/ntJ4l0y4ucbytdXUXRL0yxC9aARgTotbxypVIECMhbMlA5NtzWL9KxLiPZcad02atJwJBmt/Y0eVYILJRGzKX86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MslRGygXUxw4eUY6DZAMYVVa1QO86/VajVINhMn5Ds=;
 b=i6yYKMq8Q8ZhZIxHAzvjfb7lagxYh/Dw1a1m2tOmywuAbZsirz9hOLQBMrFsRxugk/kDtUop4epA3lrhlfpNCAKkQaDz4sp39EDXUx3mMIN1+h3To5E7mdDb4eJuQmEQ2NWfBLyXHeDMmv1GI6LWUALbWaUtdT/B1g0bLRqvIkxnGXjN5MWQ1iMvyof3kMj1JhUxF1unArPsJpW90WTTjrM0kg57ICtwn6PPOnIXKkV4WIQp4AsAHt4w3eDlxN4oWEE62v/j25PEa+FbnQx09kynAcMU0S4wVFCznvW4iVaHSCxiScEVGO9Stt1tC2tQMhCao8TOqwrdn7f2KPmwWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MslRGygXUxw4eUY6DZAMYVVa1QO86/VajVINhMn5Ds=;
 b=2wqnw13uA1kl7PTptGi7XPn5x1IRCwf3YwgdchI4pb3lX7fKOKGKn3T5UX7IukbiR6EX0s7WSR+HBwbpdgqD1B7F8Ns2dhYyDAmJFmgnDyEHcedwtXQC7RWYwc5IzbeHvQBugVw40Rc9pB5ua5q6N+NOSBesGrwTxN1zbXHncv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BN9PR12MB5210.namprd12.prod.outlook.com (2603:10b6:408:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 16:44:14 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432%2]) with mapi id 15.20.4975.017; Fri, 18 Feb 2022
 16:44:14 +0000
Message-ID: <c1cce9f7-6501-b561-325d-126fa075e520@amd.com>
Date:   Fri, 18 Feb 2022 22:14:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [tip:sched/core 27/28] kernel/sched/topology.c:2284:39: sparse:
 sparse: incorrect type in assignment (different address spaces)
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <202202170853.9vofgC3O-lkp@intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <202202170853.9vofgC3O-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::28) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20f9cd47-84fd-4528-c2d6-08d9f2fde532
X-MS-TrafficTypeDiagnostic: BN9PR12MB5210:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB52109FF908E4334215D5299298379@BN9PR12MB5210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lqrKZmivnaYRlY/VfHxz1HcjSRjtutfx1sN424+rfgEVeHkGY9QNIZR21jFfj7vxYT99SPYMzGcnFqj9r2si110RN3TRZoyjFerUI0dNHYrSxQybgUcEdQqQot9IrgGx1y633Eha4tb+RlxheERCm7soccqDp9Idzkpvcc8UEGszp5tXHBz3EVWvSc/dhFFcLiEGYi6v6SROHHDPFoE7SKaMg7twn5ZAk6+z9f8KiWKMYk6FALNUH/yIok9Ddyd5Rtu4lFPzcML+pX7YwfcoV88MCtwx6a2ns6IHBsPSsuESU6cBQI2INanSTtSGohqWlqpWCppfMstm5NXigrrfReQ5vobcQ7Px8gfj6yvUSqUy4wo1AAjPXlPJdSf/Je9c5GkJTZDIqxo44RUWi9NYlu0vrqckDCnfwcguhbLL80SbhU/blgLy+PCpzRt0KIUi6vqc4JjfLURPs73/ULH1K8GTObvJi/hEPbSMoeiO8SX3d+L6gdhh8WsYGaFEQtBBhXT7Z2oUnsoPpek19NvbrwfyHYNN3yHImVtrWJTkOXZFnyLpYbClp3dSFLzrsjV1UpLFByfT+sx88cdivFxz7lvTCwldOCoEv/t6A2Pg86AMUkAUDI6/EiPN+u8x6UkdJDL57Uj6JYGp+iYS6OWl+XWGATHiVMxBvbfPdTfVsPhnCIFpCJyLlsBGWaxXpjfYFCFWiKT26EMg7UueJYtHsswDGJEcKWXjTRDvN4jlsyqt2s3M4MjAn35jGfQdr+DQJ8o7NVLLlu9f7UQGZo4QJoTzjdfd0HwGNjR86HSS8IIMCisUAJUrdd5Xu2iBVb+PGAD3O6gZuR5uTE7GzLxmVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(186003)(5660300002)(6512007)(4744005)(66476007)(66946007)(66556008)(2616005)(8676002)(4326008)(966005)(6486002)(54906003)(6916009)(26005)(6666004)(53546011)(36756003)(38100700002)(508600001)(6506007)(2906002)(316002)(83380400001)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk5jaisySWR1K0JrNFpUN0F3RGRlbHJlQ2p1SlRqSHlLN0FtUTRFMGtQT2t5?=
 =?utf-8?B?QUxDQjdmdVNSdCtEWG5OUkVobTZFS0tlaitxRWMzRFJSanNrbzRyOU9JTUxm?=
 =?utf-8?B?M2tWcEd5YXFPRjNPajM4MUFyUjlYZG1yMUtqNWRQMm5PWmM4VklrczVpOExE?=
 =?utf-8?B?d1pXNmN1WlFIS2xrSXZISXhOZTIvcUM2Rzh3dEl0TVdUUlNhejlGR0p4RVZX?=
 =?utf-8?B?YjE2aEVDcUl0bXk0ZWNFeGxic0EvREk3cmpHZFZKVnIwcFV3L2owdkYrcXdT?=
 =?utf-8?B?eTF3R3JUc3FpZDJkUjFjdUpQQmtUNTUycHhHamN6ZDJVWVRJZU5XUnlTMVJv?=
 =?utf-8?B?Z3JrUk5ZdUZXNU9ublA5N0ViMzZwWUtnMUFxQ0duVlcrMSs2TllUdlVCTnM0?=
 =?utf-8?B?ajliZ2tJeDE2NDNJcE5yK3dzcmxxQXFWUTFhTnoxWmFXVHc0UUNTbzBTOGNv?=
 =?utf-8?B?ZTBsS2IxTWtIdE5vRWR3a09vdzlQSkd0RFhUWmtybGFyN0ZucnVzOGdETnB4?=
 =?utf-8?B?a3hNOHU4OHp6RTJON3lPREhwamNpK0F0bm5UZWZKY0tQT05JdHV6WVU1V3h2?=
 =?utf-8?B?NHB6QzIxSXRnTTJkVDYvNU9CWmhEbWpieUYyK0tJaVBnUkgxV3B5Tms3L2ZU?=
 =?utf-8?B?U2JZLzJjNnFNTEVUY21WaFl5MFo0Vk9SRjUwSXdPSzUxdWRFbzlJcWxrWWw4?=
 =?utf-8?B?RlluMjFGNUM1ajE4OHBKWVMvUXNYQWF5QWVEL2tkQ1psTVJRY1VGUURxa1hq?=
 =?utf-8?B?cXA3T0xTT1ppQ3hrb0p6M3RkcmlMQmN1YVZ6akhqeTNiSDZuWW00NkdHQXJH?=
 =?utf-8?B?K0piT05GVVNLQXozOURHZGk4OWREZzh4bHRXRVFkMmJtYVFFN2E3S0hmd2ND?=
 =?utf-8?B?emY5WStUc1pjelQreUpVMjJ3eUZTN1VqRXNlQWJ6OElvOHI4bGVveFVCYUo4?=
 =?utf-8?B?UENWbm1jTXcwT2QrY0dDdjA1LzI5dCtvMHBXM1NUbVBEdkJDUDBQN3dXSmVo?=
 =?utf-8?B?djllRlR4M29RYjRqKy9aSm51RkR3TjF5RE1PaTd5SURZOW9LOVV1WGRQOWdS?=
 =?utf-8?B?cHRGODN1QnZRUUZuNmN5VVljNlo3Nlk2Rzg5UVJWNVpqK2pncGVUVlNUZkQ4?=
 =?utf-8?B?cjVPMTRnTmtkOG5iRDdGd21yald0bW9mUkN2M1QxK1VzNzNSUjVWTmh5cEsr?=
 =?utf-8?B?VS9JQ3Z2VFNiZ1hBdFpMWWFKNXZDV0NZYVM4OGxnNHhoLzAxTWk2OFpuVkRG?=
 =?utf-8?B?cEZHdExXNUtUcGRSMTBORmIzakpOS1M2YUhuMmVvSmNpbUtBOVFvWGpPd05h?=
 =?utf-8?B?Znlyd2dEMXFKZmprb0YwWk5scGVpVzZuam44b3hzUlBFaHowOE9tSnJYeGcy?=
 =?utf-8?B?ZGlwUVB3RjVKeHpOSEpXVkpzb1pCV08yUk1rcjRjZERuUkdTWEhNekV3RWUz?=
 =?utf-8?B?bmpES2cxeUw3MFl4VDhjeGpOeUZWNWY4OGlWazFoMDZXVlJtSWkxTDM1Vjhp?=
 =?utf-8?B?bFpjLytSQVJoOUVkRjNZb25NUWlVUVExdjIyQXR4aEFHdUpXVHc0NzVSUktT?=
 =?utf-8?B?bmZvUFoxNGRKYUVyS29kei9YTmVuaFllS0VKU3p0ZytqdEptbHhTcTFIR0Y1?=
 =?utf-8?B?SWlOQ2ltVXdVbVJSelFEWXJlWXBGRnJkMmZyTE5wVStRZUZaMWUwWDAxcmtE?=
 =?utf-8?B?c0pFODZCVzVmY081S3ZJdHRCd1hFbTNIV3dEbFJBQkFNd1hXODkvUlJBYzYw?=
 =?utf-8?B?NWtSdFliMGpZTVRJd3Zsa0ZJdzRWTUtqZWdRYXF5Y2JBelp2SXBPelhrSitz?=
 =?utf-8?B?R2VNWUl5V0ZQTkUyQTk2d0thV2o0SmdDemZ2VHVIUUlFbWVGVllpWGRjVXpi?=
 =?utf-8?B?Q2ZiMnZBZ0h5OVI5NDdPeGNmV3pMdnlBZkFMMFQzSWF0enY1OXlNUnhXbENH?=
 =?utf-8?B?Y1NkTmZ4K2svS0RVYTFPNFQxdkhVcldUT3N4Ymh5MTVjcXhwRXdWV0NmK040?=
 =?utf-8?B?UENCZHdjNjBpa1YwWVQwU1lMTjdBRDN3SFRDbjQ4cUpQRURvYW9IRFZWWjA4?=
 =?utf-8?B?ZDZNRHd4cldER0I1eGptTks2ZElkZzRDVEJZK3NwOFFnaUg3bkJvNUFlWjFH?=
 =?utf-8?B?a1g0RWhUdWRIaVVtZE9kSDZ3SjFLZ3k5Q3NQKzl1ZlFRK25qc204TGExZHoy?=
 =?utf-8?Q?AI47BFpKIHzy3FI0qFgEE+o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f9cd47-84fd-4528-c2d6-08d9f2fde532
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:44:13.8873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxN85q2W/mHanHvWp8LxfoXzofsQiOumNo/bpq2CD46TdXWJ2YySbc/n11tnxWogED2lgCKyadTrRpWJTdy3zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,

On 2/17/2022 6:28 AM, kernel test robot wrote:
> [..snip..]
>   2282					/* Set span based on the first NUMA domain. */
>   2283					top = sd;
>> 2284					top_p = top->parent;
>   2285					while (top_p && !(top_p->flags & SD_NUMA)) {
>> 2286						top = top->parent;
>   2287						top_p = top->parent;
>   2288					}
>   2289					imb_span = top_p ? top_p->span_weight : sd->span_weight;

I was looking into this sparse warning when I noticed
that the variable "top" is actually redundant - "sd"
and "top_p" can suffice for the computation "top" is
involved in. I've created a patch to fix this warning
and remove the redundant variable top while at it.
https://lore.kernel.org/lkml/20220218162743.1134-1-kprateek.nayak@amd.com/
--
Thanks and Regards,
Prateek
