Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCA050F1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbiDZHE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343619AbiDZHEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:04:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B92C60A8A;
        Tue, 26 Apr 2022 00:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOJkNwMg1bleGV7TRZwp8vmlEcUIpgqI7wQdx7ssdNFyUw3gaEl6RIc5wlOj2Jl+epgFSIEsLZQpaBF30Eks/n85X4uIuGr44+ObPkvOZ1AdeJ70fEFX8WQ8fvky2K5MhPKp201pa9oGxhlRjoTP2NNHE91CFPCh0p/setSuOc4SFjcONDnCN9wxVE5nGOJh4dezyKNOCnbT0AVtFxfF/mXcedPevhHfX/kwGUFq7LjLPF6JPCv2nXnKkaQuxvVVJlJnRdfmhSxLdl+QiEP9nD6OER6H7NtukL5k5w0m6LXIGXesHVyyw9AhNVDPPohgyJ+LJvKr7AH3+UWMlXxvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9EUEhjJbwRAD4f1j7zZIzdMR+/+9F/Ims+gnfgZfJs=;
 b=kGX+iBKjkn8Cjuutm/kQukWLangvGG/9A21ulSnrmh9CLeQWJfi0e0FrBIaw/lJWUjBqbIeH7qTzOXf+WjuP6qtEugNozTEHd8GZ4f/wCnQE5XphT0y720QPt5J2WDycmJopppx/ELPz7BU4j2VsE9l527mEmL7xE3JRwRyrvPQjDkgw17jIRQouTA/s4KxuiKzTxkWmo1WVb2zrI6hTqapldunGpUvJjmIhui7+FWe4qEjvfcWZuo7BpimY16fQAgWUTgSfAcjDplMtdO8QPbHBZN8z+AX1bT7vhGAKM1p2kebY1P5a0DkSYqw1cZ1c4XnRgSeqRjxp6lU48yVh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9EUEhjJbwRAD4f1j7zZIzdMR+/+9F/Ims+gnfgZfJs=;
 b=iC+urcJNGhZSrA0k9L1sr8JN0j8P5d4FOzhE21oG7BO1QJx4NnBzdvIGki18ZdeoovKha0gtSa2YugI7L/gZGeQP54xZgSIB90BPA/Hl0FVIed5H+O8mddsKhfBpPyWOrGLfzIVhLxQdJ2BUDW4IralFgRbo6/dL0iTSGCFZOLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 by MW2PR12MB2475.namprd12.prod.outlook.com (2603:10b6:907:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 07:00:38 +0000
Received: from MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::6807:1261:8f60:2449]) by MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::6807:1261:8f60:2449%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 07:00:37 +0000
Message-ID: <aeef8926-f2f9-fe3d-5e91-f3c3e84d4420@amd.com>
Date:   Tue, 26 Apr 2022 12:30:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 0/6] perf/amd: Zen4 IBS extensions support
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, irogers@google.com, yao.jin@linux.intel.com,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com, rrichter@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
 <20220425203222.GN2731@worktop.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20220425203222.GN2731@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::34) To MN2PR12MB3053.namprd12.prod.outlook.com
 (2603:10b6:208:c7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4e380dd-5db0-4c84-0fd7-08da2752776a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2475:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2475B6FF97EC60F48B42F6E2E0FB9@MW2PR12MB2475.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xL9E/2/uZ/FDAF6mzibs2RLw//JCSWlTixybT4qZvtWRSGc9aSX/K4+OSZ4Dp+OrVWlJoj5f6hsyGPxoJCEc8akfux/itdeQ+52b1ARHbFerhxbo8hIOwq/OqqIsqknVmb1fETdsaYidfTfwKLcf8/2ZofkKUY2SDIYCgyoDyYGEg/Izxs/XV2vWYMZwuJWdCCY/lUMHU7DGin6FcpvBlQoGU+e+1BP6qS9yO+S/4ftuyvlgA7TuNEmFJkrdCxz5mtmmSUJ4g8WEF5L2XdZhho/2a7ouyw+7OYQlzql+dCYf2nXPReYRFEAnVj4+9aLRbqYLAhGtkRn14QPolA4dm7mh/zFYTQKL92wczEuxT/Zyf2dgr8gZFNRcvhk9cBR5xWRVpYhn2uvt8g6HHas2QvGjw41U1N3G5bvh5gCqq2De9uX+ithqo8JNz19NHFby4c9FpGMdzC9X+qELUn8jashnUWHYKxYHvRSBDUZZsEhRMSLtaLDlNhftkDmIiB+rVrY7nTylMd3ShEIkkgQpRJQnumJq+8oTGIsynFlKT7JSbOx+FM2c43RzWD9G6UI18XN5yXYTBzuzL9SJrhV9dgIH0N4bFGPyL3XzqogdghzuKKdQxSkiM3jnoxfXQ0Hd7mj+5rFurh/eif0TafOeeW0BXB+c/JnAWVWbPKeMAy/OJELthGklg0IVIObYHNtF+OU220dvvdtmiioiPH64OryhbRkYPm8lmACpjfa5sUOzq5RSUFxDRVZUhYNmIli5zVRd/+ht01dXH/yzfyhHy5hjd5KU3jO8yACsIw408vlObHkeXWaYkd4JxoIThACB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3053.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38100700002)(508600001)(53546011)(86362001)(6506007)(8936002)(6486002)(5660300002)(7416002)(31686004)(4744005)(44832011)(2906002)(2616005)(6916009)(26005)(66476007)(4326008)(31696002)(8676002)(66556008)(66946007)(6512007)(6666004)(316002)(966005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXRJLzJGVE1WVkQwOUMxdDI4NFkxWk5PWFlHLzg0b1liVTRQdjU4NzJTWXg4?=
 =?utf-8?B?cDBTT0o0aDlMUHQxNnJBVTUrR3hITGxYUE1QNllGVlQyaXJSYmtzY1k2RXdx?=
 =?utf-8?B?Qi9mTlVJaWMvVEtRWEZGMUh5TFcvaG0rZlc0TFNwTVJ4MlVUSm16Vm1jZEZl?=
 =?utf-8?B?aTMyL0piTnp6VHcyQnBZT2NjRXcvaEVMTnZhZ3U4UkI3RUlKTXd0R0ROc0lD?=
 =?utf-8?B?L0I5ZE56NWxpbnlTSGpKWDczamZZZHBTUlQ3Yy9yUkFvT3poT1R0MDk0RE5i?=
 =?utf-8?B?aUl6YW84MWhSRVdYYVdJUmlFWTJkRFBrbjZGZzZaNGgzRE1Ua08yTXRrV0x0?=
 =?utf-8?B?NnQrWnJwcWlmSlNka0wwUFZVaytrTk1vczRpcnh2SmRlZ2dwM29MaVJIOWxC?=
 =?utf-8?B?V3VYMFpiUGhRZjc5TU5hNW5vSXJOenVDMm12STZndmJ5NnlDVk0ydENBZ1B0?=
 =?utf-8?B?dDZBZ29hZmZTbnNuMU5BWnNrOTNqaHRLQTBsUUlxWHJMYVBhRkNZRUp6cjBW?=
 =?utf-8?B?YjZCSGdyekFmVlR1UnVNSFZNUUdGeHhoT1ZxaW1CQUZzcE1WQnpNUFE1dWNi?=
 =?utf-8?B?MmNodmhGenBMOG1GVjl6c1FTb2dFNHlkZnA2K1YxSkk2ZHloeWNRZU9aL3Zo?=
 =?utf-8?B?azdqdmNXNHV5akpCUElKTXVUeFhrbmxkUktGKyt5VnNpU1BURUhHbndwZW90?=
 =?utf-8?B?WEFNdnlRbjd0bU41dGprd0lwOU1qczlpOURGdXZYNUtwRVgzY2o2aUpLZHFG?=
 =?utf-8?B?ZjY3c0hOVWpiSThuelNNRVNCVVczYXlyVGtERjVSYldhSTBhQUoxMXZVNkRq?=
 =?utf-8?B?QjBWSFZIY042SEVkM2VKOUNTVUJTbm5tSS9lM2FYeG1XdlMxSnpkS0hTY0JP?=
 =?utf-8?B?bnU4M0FEaWxianloWi9WYVVDN1Q2WUpUUVdKbkdmYjl0WDc2a3BrazljTEtv?=
 =?utf-8?B?cTBnSCtZS285RVhRb0d4d0k0MTY0WlpoTGpkYkwvZmVnZFltTVplclJVV3VT?=
 =?utf-8?B?eVFGMlhtZk5IUit6RzhqaUZEUWVNY0l0M1VPRnBtQUh6c05YWm5jK01tRWZL?=
 =?utf-8?B?a2RtNXJYZU5SMDBoT0Y2cVE1WXRybWprcEoyaUVlSnc3SHpIWWE0bDVpb0c2?=
 =?utf-8?B?bnU3MXNSZFFJNjdKa1cveWJPeFQwOHMweS9vcnNiYnRPNmRCdHlNTzVMZnh3?=
 =?utf-8?B?SEViRDl2NnBRSW1xTEx4V0RzNENEVEl5NUVGWncycTVDR2gzeTU4dTk1bTBR?=
 =?utf-8?B?emJFaHp2K09BL3JuUWpYSElKNGMyUFRmb2xCcC82eWNFemVnNkYwaElpajQv?=
 =?utf-8?B?c2x5WExIbFdKdlpSVHMvVG8wOU4xVVpjT0FjZXVjOG9yMXdnZzBBY25LRzVu?=
 =?utf-8?B?dDJEYVIxVHV2VnZvMU9OWmFZdGpxdHFieVpFQzVFR3UwOVJrVWNuYmxYWlJI?=
 =?utf-8?B?T0dvTkxVQ3lvVFQvbnpNU3dRUitVSW1UWkNjQ3BiMnNyZEdXYzA3MUI0bGtR?=
 =?utf-8?B?T0FBYlJMTmgzQ1B5bHpQZmpzMHJncU5WRXFzUGFkQ2FLbk9vTWNhSEpabnFL?=
 =?utf-8?B?eWRVQ3JrdjNjTUMxQ05MQ2Q3ZDAxeTE3YmM0NU9GRU00ZzJQYy85YTVQMUJ1?=
 =?utf-8?B?NmJEQVFJalZBNTcwQkhOL0w4UDR6N2tKVUR3NXpGRkxzdzRQa2c5NTlDeCsr?=
 =?utf-8?B?WGloaytYeERaSmkxT2xJelhFUVV1TXIrU2F1UjM1WWhEYjhlQ0pPa0E2Mnd4?=
 =?utf-8?B?Q2VIdkRJaVd2REhMMnhNTFdKNHdXdGhudFlOYTVvQVpnSkltSHltdWlJZjVR?=
 =?utf-8?B?Z09aMVNWcExRR2E3YlhERERuaE9INmx1WkQ4ODlPWm1QRDg1bTRKSzNVRmZD?=
 =?utf-8?B?dlNqVWppN3l5aDFvYWxJVkxTRHFIUlFNc1BzVEFYcmJsOVZxSk5RZFlPSUxn?=
 =?utf-8?B?YUhVT2JXSnliMy9YeWs3NUVTanJsTmtTS3dqU2dyREZRMGp5VCtxWHU0MlJh?=
 =?utf-8?B?SzVoaDZDVmZ3ZHZDbnFMbWdNelhaZW1jYVJVdlQ0bEJVKzg2Ny9RcVBwTTNN?=
 =?utf-8?B?dkIwWGVRbjJFeWYzSlY1ejIxOHpYOU5QaWdGQ2VuMDNCRzl4Q2xNM2lVbkQ0?=
 =?utf-8?B?L1pGeTg4b2lIRjlSdElKM3BhS2YvclpLUEdEbXVVUE44ckpBM1NXeHVZU0xo?=
 =?utf-8?B?bEh1aG1aVEN6bG0rblp2M3RYN3l0NjV4S2JxVTNmV0lQK1dWd240REZaclZL?=
 =?utf-8?B?ZVAyZ0hlRHVSM3VTSE5HYUduNnlaQUxyOGhIdm1HOUdsVE1BRldjUEMreEF5?=
 =?utf-8?B?Y2VVeE9ZRXhZaWVNbU1sRHVnRWQxQjRDUGVvQjVFdWJNWjZoci9Edz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e380dd-5db0-4c84-0fd7-08da2752776a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3053.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 07:00:37.5743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiarQLW/tIfynPhMtGzW1pPgy+VoMLrHNEQW/nCd+VFEmIN2lOwMjgnkGn/v8xCmrAZ/ttiDURFCviIqHLKpfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2475
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26-Apr-22 2:02 AM, Peter Zijlstra wrote:
> On Mon, Apr 25, 2022 at 10:13:17AM +0530, Ravi Bangoria wrote:
>> IBS support has been enhanced with two new features in upcoming uarch:
>> 1. DataSrc extension and 2. L3 Miss Filtering capability. Both are
>> indicated by CPUID_Fn8000001B_EAX bit 11.
> 
> Hi Ravi, could you perhaps also look at fixing this existing IBS
> problem?
> 
>   https://lkml.kernel.org/r/YlVPpVC8chepOdzJ@hirez.programming.kicks-ass.net

Sure. Will do.

Thanks.
