Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553DB59558D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiHPIrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiHPIrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:47:05 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD8214D04F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auUw6zvYtmLcuf1WEc6pzJQjfqj6hO49Mt6agEBXos0n7pK/DjC8OnbusvU9mqxoYGg5pbMtz4GVrnY4n5+tEwTQ+O32qK+mcH8PaB7p2dJIlXQ9SFm7ZgiRSa1Ze75XeFZw4U606/tedXKLP2FWkY/ZfaVZLeqAONBcpdHZQFk7NiOpE0bo1tswHbr7PPUqMZHVfOB6OCSyyKT64jodGi2dL/PzqtGBmdkKByux8u2N8XhIcIU/tFvj/w/SWfvSrG2aTRgL5f53nOxR5g6GorrrH3kUDTi1rJfsUtpO2KkpheoxEPhnpJYH3nXkF4/dK1jpkk1d/+I+2bAp/60xiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bkRJzxstlc/qEhHlPAZaz6PYS00IdVbY95NuTfamMo=;
 b=epBdok9ayCGGDmZXO8j34SYTph2DNtBBDq0j12n5CjrvLhu25Y0wDg3v6PByBTJJTnw2oqWnkSgqdEAax9ikPRa3zJMXrCWyXHfREImGSl2ibDWoHSU9TMb6LPkKf+nhBftxsfVaJthuCUZqj/Lj64SRbKKZc+oacVDxIdozxyJjysDoS2k74M1JWpMG0hWivNksb2DjPBEe4nyPbK9wuN8CLH8QOMnDEh85Me3PtDnTAA3smp/C7WQhRX9XQv/pZAERyM/3XrNgvDzNxMhHUu0Rq4bpeaorCPk20Wm1SxxtiLWcWTAFKl/ra7AIc15EBqRQSsQnNUzatunx5ynYUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bkRJzxstlc/qEhHlPAZaz6PYS00IdVbY95NuTfamMo=;
 b=mQFub2dCPdPUzd45aktdyfqDpSorJLh1GyQ/m/ZlcP+44TojG1dWx00V+O6PBvxzq3/fGY2oK7hhBfZV26NtrKtOqQyWapkmQUJcKyi2rQ0vV9Q6G8WN4A8VAjqgH4mV4UShYlNipzC5kuCGEXG+xkDki3Twmyh+vd5fhuIo8kI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 06:52:27 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::bc80:d6e7:d73f:d955]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::bc80:d6e7:d73f:d955%5]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 06:52:27 +0000
Message-ID: <b5d197b4-d27c-f3e4-ec62-dcf037a3ff76@amd.com>
Date:   Tue, 16 Aug 2022 12:20:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/13] ASoC: amd: add acp6.2 pdm platform driver
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Syed Saba kareem <Syed.SabaKareem@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, mario.limonciello@amd.com,
        Vijendar.Mukunda@amd.com
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
 <20220812120731.788052-6-Syed.SabaKareem@amd.com>
 <0cf33957-83aa-5baf-735e-835ab3db9956@linux.intel.com>
From:   Syed Saba Kareem <ssabakar@amd.com>
In-Reply-To: <0cf33957-83aa-5baf-735e-835ab3db9956@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::17) To MN2PR12MB3661.namprd12.prod.outlook.com
 (2603:10b6:208:169::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f3df79d-6446-4f13-0614-08da7f53e193
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LC0w9bIp1PQMiV03n8Tv2QIz1GvEUJH55S8s9L6I6Jhx66Nlmcj03sL8XPH/rfyyPoX5iViU25twjqZA58b4x7+MqfipcXu1npcL+uoK3t+AaD9w7TYXj9hLkopLheA33j8pkVRsNvXLV507O537lJPqA0OLTYPpPu0SWEhtPqbt9goSEzciDHisq1jifkcjjIlzq39RSMSTbekBMWa2D9IZbZuJ6W/3DMth1wCOyEz/mBki2AVvkEHnidllvAUlMsWJCCJ0tF+o01CkLwZ41XdXy3BzJus93NEoFWUWFcQGpvRq0r9L0EQFXilGdHUMDTPq4/cvl3+KXOETDKHuOsgiatnHZpbDThhpVdxzm2KxPjr9I3MlImb2mRq2MDz2ak1ZLx4GOtTDyiWzFovhqd00KzaK0Wmb8V12uShxEfH5Q1SUzmxGgBbmvf+XRd9gzmjc9QlZxf2okQhByr6SXQK3krnEXA44yo7iYGCE3OXbuBhSuCy6Er/620I+J3u4xpQ8E1FUHtTqdVulfneOgdhukeBrFSn3MW1jYVJFFIjF4tqcC88J3WKVy7p/ztUFVa7bWA7CtX9RPulodRtM1a3sdrfsqbqVXxXvG+fwOaHKOJVAu9MgT+8jC9xmhdH/lD6TdjWxQGNzPPzKy+lFqmbxZRRYQCtLFYG6Z3L9Ag+DFS9uUqeXviWNCVLcPuElcnL24hk1JD4FjL8I40OhxcZ1J7XrRZS07yZ3ADSDHdXgApM2yOyfgqpRs7HBD59g8hQGCUfVUJhpyUvj6oXWC/vF3Ujy9Hd2VD9qPcP0BUuMqegxN8zteHDE3IuejAqUHo3Jn0rbbrrYM2qjK9ry+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(54906003)(5660300002)(6506007)(53546011)(41300700001)(26005)(31696002)(6512007)(8936002)(66946007)(6486002)(66476007)(478600001)(110136005)(8676002)(316002)(66556008)(36756003)(2906002)(4326008)(2616005)(4744005)(31686004)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVE1L2Q2RVZuanV0YUUrODUyNGRJL1YvYkIwSVJnUUpYQ1lJL04zKzd0WkNI?=
 =?utf-8?B?NXRPTitXMS8zV21Ec3orTjA1UXZxOEpsR2NNaHJMNkxCazNyRWZJb3pkay96?=
 =?utf-8?B?bzVrZlR6dVZBMzZnczNpR2F4aW84WjNaMTF1TGkzR3JtZFlBdTBKK0ZjZ0Fi?=
 =?utf-8?B?MTVscEJEeC9oRjIzellaazZjSVFpbjRVc3U5ZWhTOHJ6dGRVOHlINFNlQWVW?=
 =?utf-8?B?eFZpZGplKzBNSkQ1U09GL0VIeHFZdlpGMWpESm5yYUlkSUNkL0FWNWJQSGxq?=
 =?utf-8?B?b0ZnWjQ3NG5COFJRWWxXdHpVVFIxd0cvbmFaUXdyQ3ZtOW1lM05IaTQvenY5?=
 =?utf-8?B?MkdlMUIyNmhZNUttM1NtNC9zMDNzcGNqeUdacENjZDEwZEdMVUVMN1RyQkFa?=
 =?utf-8?B?Vm9HWi85MmNqQVF3ZzlNS3Q3OUFEYUZBbUFlc3M3bjFrWWtKcUJPdWV4aWI5?=
 =?utf-8?B?UEw3RjN5U3B0UkZGNWJBWkxodnZoM0FEUFB1WHVXcmVHRkdNWW9XQkNXcHds?=
 =?utf-8?B?eVFIRXpkRlNPOFViN0tVcWRaSG5FaktXVWl1amszalNqRWpQaklDbS8xd1lB?=
 =?utf-8?B?MG9Ta0JMWW9wSkVOTjNSWXNObUxXUHAwNW8wc2pLbmwvdEVKZDdDZmRxZUkx?=
 =?utf-8?B?U1pIakhjaFJOUm5OUEhoYVBZTENLSFNpTERhbEJHd3FrNXNaa0pGU0hpNlBM?=
 =?utf-8?B?bFFVUHZxTWFuUVBSeUsxVy82R3FvbnQrdURDbm1iNUZBME1tb09XQXdtSUJW?=
 =?utf-8?B?RFp0eXUycFdXQzhuSzN4MDd2VGhhZ1Qyb1k1RDNEZ3lyenRvaVgzbWZ6TjZ3?=
 =?utf-8?B?ZnhVZHlPT3E1OXVXbnlITGpUWXphaThrNnBVSFdrSkpRaThma0J2TXJ0eXJk?=
 =?utf-8?B?SFJWUmVqSlBGeUR4Nmc0WjdEN0tuWmlZUmtUTjZxb2xoVXFuSitodHd2OUxy?=
 =?utf-8?B?YitvOWprU0dIZGpoSVdvdWlRVWpoSUJqYXBxQlZoaGFLRVlBTHl0SkFIdUxO?=
 =?utf-8?B?UzZUdTV3b01Tbk1zekx2TW14blRQcUg3d3oxQXZ3K0NpU0Jia3VNT1EwelB3?=
 =?utf-8?B?Wld4cERNMExMYXJhYlpFazVsZzRlY1hnVXBGTHV1K2U0eXU4Y2EvRkk2Tmlt?=
 =?utf-8?B?bFpISzlkakZSS0hDbHE1Tk1PWUNrQTVzdVhtSjJ1a2lCdUQ1SXdScy9LZm5y?=
 =?utf-8?B?UFZtdHBFT2FKREQ3WUV0SE9PcnBDOERWMk9rM3cxOFh2U3h2V0cwekZHWWRu?=
 =?utf-8?B?d2tER2NZZU0ralVXRCtmbXliMk5lRUl6bWNvSlJoYzZsSXcxRzZVM3cyVzJJ?=
 =?utf-8?B?N2V1K3B0TnBSUzJRbHcxb1FFZUtXczlob3VvZndTcUlZZTVWWTl5VWRkQWNi?=
 =?utf-8?B?dmwxdXhIb08xZVQ3WTNvc2ZoM29vVmNENmVkVDhEZERBSCthYWc3NUhCZzZ5?=
 =?utf-8?B?TElITGRJY0RPM044RXcrYWZPVktLR3BZVGlhMTA0S2EvZGN2U0daV0JxOUpC?=
 =?utf-8?B?SUFuMmNVb1FVNzdrOWhIK3k5RW5LS3lhTHVYaThhMjBxMEVyRURoaHdXRXpk?=
 =?utf-8?B?a2RrclFlbDY1VDFBUTBYOVV5Wjh1UEMwUkxTOFZzKzB4QVBITEpKbVYrUnR3?=
 =?utf-8?B?Ulp1MW1DNE8zRnRXNXFNeXc2a0xmQVZoQTJyemtycnVjU29rcU9LZUtPTGZJ?=
 =?utf-8?B?cDFuVFZPaDR4L2xDUGRDT1Z2ZzBoTUxIREltbmF6TzBJTVFNSUFET0NlQ3Z6?=
 =?utf-8?B?b0cyUmViYk4wcnZXWTJrVkZTS01qazZ1cEM0b2h2empSem9kcnQvaDJtd3hO?=
 =?utf-8?B?S1d3bnRGamQ3ME9PRWFiNVB0UmszeWQ3czdQVHhMd0VuNDVqUDF4OVlIcUtj?=
 =?utf-8?B?WXBtQnNIaW8xOXZETWJQV2RGZitjWFhtb05yNGlURjI1SHJZQmRQb0h6bXRu?=
 =?utf-8?B?U1AvZUVEQXJHV0VBUkI2Qk5iR2h4NEZ1cWNvWi94VlArbmQwNnhsc2FjMExL?=
 =?utf-8?B?UTcvOFpSU2hsTi9seGg3UkpJQVJLZUJJMjFuWC8vK3ZneWNSd3ZIOUQ5QlE1?=
 =?utf-8?B?b3pNUTVCMFZWVHQwb3NnOUZRcGxJS2lQZVpyMHdvTUoyMTM5ODJuM0o3ck9M?=
 =?utf-8?Q?qqyBjIDUaQ8ZhvWYr+LwBUWYn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3df79d-6446-4f13-0614-08da7f53e193
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 06:52:27.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kz9LQqDepusINUskWoOC9+8F1SyZkC2Zt5lxjKudhxkBS8ZmrQHeErzHE91gPGlB4ZxkVsYxJMbghNg3UtINGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/12/22 19:50, Amadeusz Sławiński wrote:
> [CAUTION: External Email]
>
> On 8/12/2022 2:07 PM, Syed Saba kareem wrote:
>> PDM platform driver binds to the platform device created by
>> ACP6.2 PCI device. PDM driver registers ALSA DMA and CPU DAI
>> components with ASoC framework.
>>
>> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
>> ---
>
> ...
>
>> +
>> +module_platform_driver(acp62_pdm_dma_driver);
>> +
>> +MODULE_AUTHOR("Syed.SabaKareem@amd.com");
>> +MODULE_DESCRIPTION("AMD PHEONIX PDM Driver");
>
> phoenix is usually written with "oe", so just making sure if above is
> not a typo?
>
It is a typo mistake will correct it.
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:" DRV_NAME);
>
