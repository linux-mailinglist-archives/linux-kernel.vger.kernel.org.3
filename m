Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D844BF4E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiBVJkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiBVJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:40:11 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDE0156C78
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 01:39:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjxE1NXyBltoTyx0wyn7xZ+D+lMwyMj8OurHaxw7NftS3VBm6ABFhVVR7fiRdtAoaTqlGC4PgP4zVILERvfkd7iZq/ngfbu8WNeEcq1fswgmsPnsH0xyiXW1eAdQsl/XelfRJdVDeuPRPcoLJ3DIj8xJM5wlXD4mNnaPxU5ICblaVciXTouFG6uCmfSCUj45xDB6UD0cqI87yjAZlNesD5z2dZm9t7RI+7k6FmBMDdoWWd5QDZLNeP5WXRyNTiYV00tf3lx6WyHbF/HnSBZ1QKtAQuGPhpREHoGz9LzfVFlGkUSSZeEpTa0VxvoZOxpz4RZ53aTZy7MBcWdUOCnXwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9PvmjasKtlY57rVHjwTg6fhXfdedauPr5dsuzAlzqQ=;
 b=DlTk9W8YkBT9nHgFr5xsR8xG1U2R6cuXMhfwEe28BbrVifEIVpF/ES83GlRrCkOPHxD+UzkroqtJOws7nFj2wCqJcKA+7zAyJFJ4SWcKxNCfPbpa2T/F7dWJkyWZpZe2T5zYIQ0/IyXGpT4A/6qAQrVjHn1b0P5I4uSF3kYuq2NSczFiq1rqKWqtPupbsdtWL70L077JjHFxKONTMyd0jA0MBqgdXqQbCt1bhLcoEKkhqhJyggQzzAq5kpJuUmIGMv/MRZxYDu8v2L2/YlU9Jt5iKD0g4Rgu18rKX1gQgFFkt+pTulQx74LThphSXhhSGqoE5Rb/QKxXVhs4nW4Svg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9PvmjasKtlY57rVHjwTg6fhXfdedauPr5dsuzAlzqQ=;
 b=Wgh2YsB2luxkt6aNlz8QoLnkWOOdLKaIDFxqd4zhoQnIheQYx37u8Fi+xRwVtbgD/ingHTVSvPMM8kOQOD5lcdRtrWwjkAwwCKKCTqEdhR3dq0uOIhfciLBgoGArzWYDNrsATThbwRGS00XAt/YGT/ngoSiGIxmigECSKoLjRaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM6PR12MB2793.namprd12.prod.outlook.com (2603:10b6:5:4f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Tue, 22 Feb
 2022 09:39:43 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432%2]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 09:39:43 +0000
Message-ID: <fad35024-32c6-21bb-17b2-9fd7e6c781f3@amd.com>
Date:   Tue, 22 Feb 2022 15:09:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
References: <20220217055408.28151-1-kprateek.nayak@amd.com>
 <20220217100523.GV3366@techsingularity.net>
 <a57dbac2-1b8e-ea5c-8b6c-3a97ac186ad9@amd.com>
 <20220217131512.GW3366@techsingularity.net>
 <fed30e08-e6a3-4c20-175e-50b3af02af3e@amd.com>
 <20220222084535.GB4423@techsingularity.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220222084535.GB4423@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::12) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb11ebb2-1af9-4f35-6b05-08d9f5e74107
X-MS-TrafficTypeDiagnostic: DM6PR12MB2793:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB27933A06983B6F9B5426970A983B9@DM6PR12MB2793.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDRdbm/MCkyDLgHMWwUbb8q+x2Ehoo5suhAK4pwQFAZl+MKjFqKCaJppvWO89xTHxr7VTu8HvutQa/2ZRc3mNaaY0qtaIvGLGP+UMd4rZbi2a0+3bY1+cWcU+7H+GUL9Rdrza4i9X3Yo1xxOPP6EUW9ZuYL1JI4zXwy0wzsAHA7LgH5Jn7RIiuoPXPxx0lsNq4CNdzV+9YHzsvRxh9v8dm0eaBlaESndIdA7ft1jIuHC6UjS/Wd0Pyj4cYd3aPvdI7xQsmA0qTbH9BknGfGttVHnp5y2jXWvXOj5RIFEfwSCMC8Yn1K3HCcfyoxZG7GKSSuPQnhKh3gyvhXfVJWIrVW9wAC8k797da0MdnNFGexXBJfbDdupP/gkUIJQdYETbDbCyjnsteGKO8hHHvqkHMRGnLxKtZJIp2Q3FyxRwtzLfZpKrIgJJJZxCxUO3Tpsz/XeyDur2C9P8GvcRaJfAT2QEb1gZH5VHERqC3Vuy2x6NRGr2S/aXF+yhVz7MSCEclBhZ8qasOyvoPecVqALOEosajePBaUpV2JsKS0EjnWnp9ub5FNRwbWbQDX0S/XbABs7jmEl7zWISAO9WSvcPjitK30ZdHr5FC/uM/OdsM4LwVDQ9cOI+r3iagcoi420DbMHHTkYspdNhE1+lekmvuowyTbCmz4dUDqZrgsIyKWKvYBIVDhfLTFXT2JfruCxKNT64BMNSNwo73CE5m/S+Z1TGRvYX1WxILx6E3HcM5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(6506007)(6916009)(2906002)(7416002)(53546011)(6666004)(31686004)(8936002)(36756003)(5660300002)(6486002)(2616005)(8676002)(4326008)(66946007)(66556008)(26005)(66476007)(38100700002)(6512007)(31696002)(316002)(86362001)(186003)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmxPc1g0N2VLOExVL294RXZvZkRyU1JLL3pObHVmZUYzbWFGYjlEOTNUcW1u?=
 =?utf-8?B?TTdLY0dBaTQvd1h0dndLdW9QSXNoNkErc0cxdjV2eTNkdnpiM05pQ042L09a?=
 =?utf-8?B?NmxoRlRFRlhnM1dWNFRPWTRSWHlsZEZVeEw0MktUZ0dWYWh1WXZsR3RHZi9z?=
 =?utf-8?B?bm5ZSWFNbktmYnBNeWZtbm80cGtTWDE0MSt5QzFpeitScngrTXZkTFM0Vysx?=
 =?utf-8?B?ejBtM0w0YlBOdFRJSGt0QTYvSE1yaWloRFF4R1M5Z28zZkNVc2dnWk1pTG8x?=
 =?utf-8?B?dDU4VTU5c2J6L245a0VMZVlhTXV6Z0plM1NZV0NNT2dQenJpRFVpOUYwZDUy?=
 =?utf-8?B?M1pUaFRHeWc0Z1J0UFQ4VjVER0VjVTI5bUg4TVFvMFFYMXVSVzRqcmkvZzlC?=
 =?utf-8?B?MjJjcXBGUWpBcVhmRlNGSjBBUWZ2Rkk5VHlmUi9aSEtIbmM4V2NhWWRrbzZJ?=
 =?utf-8?B?VVA5S2NMaHo1OS9VQWxnZ0FEdmFESGxuVUNFdUdUSFR3RkxXS3ZnSVRZVVNB?=
 =?utf-8?B?Z3ZHeUFUUHVnSktnTXoyUk5OVlB0cVZtQXhwZWxDZ0ltN2ViSm0xRkJhcWJ6?=
 =?utf-8?B?WWZjdzJ2NnY0RDJVNWNFVnJrQk1iUUczSHFhV2Z5Y0U0b01QWUN3Q3d2eTln?=
 =?utf-8?B?eU5za04xa1ZEbnFhMGtuRWtYdm9lUzJla3RDU3RmNnRlQldYVlJnK3ExUzVa?=
 =?utf-8?B?VW5mS29yWkhlejhtSE43c3NQZG1kdFc1enZTeDllWTNIczNaVU11T0JEVDhz?=
 =?utf-8?B?TGJGL0xoYThEdnExQ0xRMWw5SmJIZmdrMDFjVnk4UjdiL2MwaDhwUjlDYXJU?=
 =?utf-8?B?UElyUGhZL0NXZ2lSZGQ1RHI4eXc3N1pFT2xvdWpheEI1VmgyTmlmUExEZXNM?=
 =?utf-8?B?NXUvL0ROdmMvT2lnazZHcEkzNUhFeEVkbjJMUHExMnIwd2dubWhkR3R2eGxr?=
 =?utf-8?B?WUVwY2N6VWdoZjZ2M2p4NmZqVVVvcHhSOHUrUW1JcEVYdkRvWXc4UHE3dEd6?=
 =?utf-8?B?cGpBbmpBaW1qbld5SXBvT21NN0V0TnlBdm1OeGcrWndVaVFubnZRc05xaHBR?=
 =?utf-8?B?MkdXUlNHWWwzczRTQTlDK3pXYmc4d3Y1MlFSakUrUXQ1Q1h2SzBBVWRQTjd2?=
 =?utf-8?B?SktHWlRlenV3dll3SVRtd3VRMFRYSFhxeGFtVnFJUjdtQUtydGRtbno5dmow?=
 =?utf-8?B?RGdJMTRQVXVPTkhUQVJpdy9pNnEwdktvVG01bzAwRG5QYnZIeGZMcjhrVE14?=
 =?utf-8?B?dTkvL21xQ2FoT3VQN3RmTi9VY25id3BWcWNjU3NnQ3MyWnE3aTRTS0Q0L2xm?=
 =?utf-8?B?c1RWMkorTzVvSHdvL1BTUGgzZzBHdTRHQjFmd1cyeDJ1V2d3U0h5Y016YVdK?=
 =?utf-8?B?MVNBRUhYVFR6djZUdW1wK0pBbUNTcGhLZjl4bXJSNytCZnZGNXM0QnJrOWdh?=
 =?utf-8?B?WCtmMEY5cDFYeUZWdktxNmhzbjdReDdGTzc2akxYbU1wM0NHODA4OGM0Umxo?=
 =?utf-8?B?MXp4K1ZqeVlLV3BuUlBFU0J1RTlueDRmbjVWaDZkU2s0eVJNZmRtSk1JSXJ6?=
 =?utf-8?B?NFQ5enczNzhnamJ6cjFzTzdkQlpNNnpvUjcyL3ZHMU5kcTJXMHNtWkxoalMw?=
 =?utf-8?B?QTRtMEhCanA4OGY1TWRSdUJuclRySlBUZC9ZZVljUFphbU1uYm9WQ3FLb0hS?=
 =?utf-8?B?MjA4YnVieGxONnhXNDh6MnRZdTl3eFhOMVNGSGRRcnpmMnIxQ2kyMzU5K3Yw?=
 =?utf-8?B?cnVZOVhUQ01PZ29TT1hnaGJnUGtyMzVzVllCbHZpRUdianNFenpHTzlIalcy?=
 =?utf-8?B?M1JBSDEwQU5mTFp2V2M2QnFSTHlFdGVUKzJ0aTdPWUthWE9BbTZYSzVsNEV6?=
 =?utf-8?B?ZnZ0M0pqekFrM3hCa1Z3SGRScHpzSkZTM2FjS0NINGRoUm9uOTFJSlVlQ2E2?=
 =?utf-8?B?QXh3eUg1b05WRWNhSURXL3VwcytRSWhUb1RYME1SS1JLa0o5dkpXY0M2OW5o?=
 =?utf-8?B?MHNEOE5ER3ZrVFl4dmwvNnFucERTbzc5S0tCNWU0QVhwcWhhUzljU3kzbGdS?=
 =?utf-8?B?WDFTYXJTaDR2WEJzQTg2U3FsU3Uvc2wxWXZHRlM1MXJoSm1TUkg0TzI5Ti9S?=
 =?utf-8?B?dnh3V2QzRzNXSFhId0xST0xKSExQZEQyeVFpMzlGUVJURGV5MG85eFlhRVRj?=
 =?utf-8?Q?U2Qe03fHDxAjm7N7yxVfG1s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb11ebb2-1af9-4f35-6b05-08d9f5e74107
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 09:39:43.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SL/4/tCpEJ8/tDI4tGQZ2J/JFFN1lgS9mwswWlXCJ2kautwOqS27Ah3/L6O4K7REYjLT5IVC0VRAvffGije85g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2793
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

On 2/22/2022 2:15 PM, Mel Gorman wrote:
> [..snip..]
>> Following are the results from testing:
>>
>> - Un-affined runs:
>>   Command: stress-ng -t 30s --exec <Worker>
>>
>>   Kernel versions:
>>   - balance-wake - This patch
>>   - branch - This patch + Mel's suggested branch
>>   - branch-unlikely - This patch + Mel's suggested branch + unlikely
>>
>>   Result format: Amean in ns [Co-eff of Var] (% Improvement)
>>
>>   Workers balance-wake            	  branch          		  branch-unlikely
>>   1       18613.20 [0.01] (0.00 pct)      18348.00 [0.04] (1.42 pct)      18299.20 [0.02] (1.69 pct)
>>   2       18634.40 [0.03] (0.00 pct)      18163.80 [0.04] (2.53 pct)      19037.80 [0.05] (-2.16 pct)
>>   4       20997.40 [0.02] (0.00 pct)      20980.80 [0.02] (0.08 pct)      21527.40 [0.02] (-2.52 pct)
>>   8       20890.20 [0.01] (0.00 pct)      19714.60 [0.07] (5.63 pct)      20021.40 [0.05] (4.16 pct)
>>   16      21200.20 [0.02] (0.00 pct)      20564.40 [0.00] (3.00 pct)      20676.00 [0.01] (2.47 pct)
>>   32      21301.80 [0.02] (0.00 pct)      20767.40 [0.02] (2.51 pct)      20945.00 [0.01] (1.67 pct)
>>   64      22772.40 [0.01] (0.00 pct)      22505.00 [0.01] (1.17 pct)      22629.40 [0.00] (0.63 pct)
>>   128     25843.00 [0.01] (0.00 pct)      25124.80 [0.00] (2.78 pct)      25377.40 [0.00] (1.80 pct)
>>   256     18691.00 [0.02] (0.00 pct)      19086.40 [0.05] (-2.12 pct)     18013.00 [0.04] (3.63 pct)
>>   512     19658.40 [0.03] (0.00 pct)      19568.80 [0.01] (0.46 pct)      18972.00 [0.02] (3.49 pct)
>>   1024    19126.80 [0.04] (0.00 pct)      18762.80 [0.02] (1.90 pct)      18878.20 [0.04] (1.30 pct)
>>
> Co-eff of variance looks low but for the lower counts before the machine
> is saturated (>=256?) it does not look like it helps and if anything,
> it hurts.  A branch mispredict profile might reveal more but I doubt
> it's worth the effort at this point.
The positive percentage here represents improvement i.e., the time
between the events sched_process_fork and sched_wakeup_new has come
down in most cases after adding the branch.
Same is applicable for results below.
>> - Affined runs:
>>   Command: taskset -c 0-254 stress-ng -t 30s --exec <Worker>
>>
>>   Kernel versions:
>>   - balance-wake-affine - This patch + affined run
>>   - branch-affine - This patch + Mel's suggested branch + affined run
>>   - branch-unlikely-affine - This patch + Mel's suggested branch + unlikely + affined run
>>
>>   Result format: Amean in ns [Co-eff of Var] (% Improvement)
>>
>>   Workers balance-wake-affine             branch-affine           	  branch-unlikely-affine
>>   1       18515.00 [0.01] (0.00 pct)      18538.00 [0.02] (-0.12 pct)     18568.40 [0.01] (-0.29 pct)
>>   2       17882.80 [0.01] (0.00 pct)      19627.80 [0.09] (-9.76 pct)     18790.40 [0.01] (-5.08 pct)
>>   4       21204.20 [0.01] (0.00 pct)      21410.60 [0.04] (-0.97 pct)     21715.20 [0.03] (-2.41 pct)
>>   8       20840.20 [0.01] (0.00 pct)      19684.60 [0.07] (5.55 pct)      21074.20 [0.02] (-1.12 pct)
>>   16      21115.20 [0.02] (0.00 pct)      20823.00 [0.01] (1.38 pct)      20719.80 [0.00] (1.87 pct)
>>   32      21159.00 [0.02] (0.00 pct)      21371.20 [0.01] (-1.00 pct)     21253.20 [0.01] (-0.45 pct)
>>   64      22768.20 [0.01] (0.00 pct)      22816.80 [0.00] (-0.21 pct)     22662.00 [0.00] (0.47 pct)
>>   128     25671.80 [0.00] (0.00 pct)      25528.20 [0.00] (0.56 pct)      25404.00 [0.00] (1.04 pct)
>>   256     27209.00 [0.01] (0.00 pct)      26751.00 [0.01] (1.68 pct)      26733.20 [0.00] (1.75 pct)
>>   512     20241.00 [0.03] (0.00 pct)      19378.60 [0.03] (4.26 pct)      19671.40 [0.00] (2.81 pct)
>>   1024    19380.80 [0.05] (0.00 pct)      18940.40 [0.02] (2.27 pct)      19071.80 [0.00] (1.59 pct)
> Same here, the cpumask check obviously hurts but it does not look like
> the unlikely helps.
I agree. unlikely doesn't show consistent results.
>> With or without the unlikely, adding the check before doing the
>> cpumask operation benefits most cases of un-affined tasks.
>>
> I think repost the patch with the num_online_cpus check added in. Yes,
> it hurts a bit for the pure fork case when the cpus_ptr is contrained by
> a scheduler policy but at least it makes sense.
I'll post the V5 soon with the check as you suggested.
--
Thanks and Regards,
Prateek
