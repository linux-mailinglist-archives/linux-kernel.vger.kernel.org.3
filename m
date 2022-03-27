Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CE74E8786
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 13:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiC0L60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 07:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiC0L6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 07:58:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6295192A1;
        Sun, 27 Mar 2022 04:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiEuXVYCUyzBk7ZxAFQgpSyDFyFW+Sqg4tFW52nyw04CWxprBj2PIZZbedFwzxghiC3Z2sZciXWMNRJwaxqvoAjPWi/6OBm5ucFlw0WJR6oG4Q3RL78bdSvrA07ibZXVAOXK0ZqH8NOaMPzXIjKnJ/vXurYUIz5eTWoPq+IVDx85+WY+PvNxwU6sB67mHAnvEa9/eIOLpQavv0StObzodu9fs1/dFlZ64Bf3wB12iTs4Lh6YtLPdXLUCUe8v8CsN46ZAUag4sz0dfyLxQqlTeu2bulL0XvRvSU+Y15/iBV+Lwq3onlln4jS3gLVfN9zOFiHCE0z1HKw6jVuxJT6ewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYXOIecXueE7qDJjgwfYVi4Rda7AsxYMNwKLpfrUJ2g=;
 b=gc2u/eGHe6N/sYU5gBGTv2JEI+3mA6LCQeMf0fCdCZHIPK6VpEMQdKNM8C9hgeu1BeJaiYjS6AehtLPFNrKFAg2B9yw38dwMev5bq1GunTtXtTIPKxlJFQBiodY4CluaoLhSbxzoKP+tryRlfoIYf5gdJfxScu6EkY9zXbVqlr4MoQbfvx8vzLWPscsdnPHkUDMe6H3sDRGMoECwvnZBihHYVwbmP5QPlqcdGOjOyhLwE0t5wVpjUxQ32n344sRzUHXo1xrbANlwyClmg7+x15BahcevB0RTbE6Unsi5r8ZXRM1yYdbz3p5iU67J0tioj2qAHqyCaH7pSEX6NZijEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYXOIecXueE7qDJjgwfYVi4Rda7AsxYMNwKLpfrUJ2g=;
 b=jtNl2mMlZ5D65GetibxM3SextA3BfT2Luew7AVfVebwTflLiv4QkWOi47xhHxeowIbxSZCsB64WMg1hP8a8dy8BObyF8gdRnvE5VMwa3ijwT/c0TLfKzBMCJL/Q2ij5RryJOgM9IV18oI7cOH5z+wwepOjg+9mHx9kWHcsEzmOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Sun, 27 Mar
 2022 11:56:43 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90%6]) with mapi id 15.20.5102.022; Sun, 27 Mar 2022
 11:56:43 +0000
Date:   Sun, 27 Mar 2022 19:56:23 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Improve usability for amd-pstate
Message-ID: <YkBQ548oCbCqd6lE@amd.com>
References: <20220325054228.5247-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325054228.5247-1-mario.limonciello@amd.com>
X-ClientProxiedBy: HK2PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:202:2::19) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7cc6b5c-45dc-4826-87c0-08da0fe8dc91
X-MS-TrafficTypeDiagnostic: BN9PR12MB5258:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB52582A5B09E74AC5EF9A498CEC1C9@BN9PR12MB5258.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKh8EV7GUcQ2tKzTYdKehQn9xuBgNH4wvEy4zk9ztXMVd2H9YGVs0GyUIVpRdLMjdoXjD+B61nU9d+/CzYzKKcKzXbmGqIeIvUjevVWuD+jBgTTdBaE7SSzDu6681jC+vN7Oo3RPc2IQaYwSnoRdby4UKHfHtCO9aS3oE8VzHNRN1z/MaEROxhAScS35AO5e8dTDEeXzM2JDi06Vvdd9XqJMqWcpxPZsDUHA/roUZUj8YNIJHznQk17C9F6JkVLU7yZLCQX/Nw1ZjkCiMbusWMy7O9iDl6scBEGk2P8tJpTAgtY/iqSk9LVCbVe0qk2csGwAeOTRNotP6ETbepsOhhHFdoEIdodMlhEEOjhfaFytx9bLod8mQJW+WOsnsu5xg51mmZ2mei1zyR1BSThnEhU1CsN/UorsekoP9XAyhOq9I5BQw+tYy1OobXAPcLYcwCh50IDyVXDrTS+CaAYFEGfjFXMFaXnt4WMHRrtHLrg9IQ3oV7VVpgYZcjMTduX+u9EZRSLVa+4IJwDjxbovqsrFG2q6ewnxtbrkwdiOA4VfS7KZSAMyeQS7kZt+Wv2G9wnxPaJyrWB+dNpZ6BcRQp3s0jSxEdEea5wmiwzKQB8NE6cdr82AmN7fcNBb9jLo+fLaT0zgi/lJ7pg4NXKZsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(54906003)(6666004)(4326008)(66476007)(316002)(86362001)(37006003)(6636002)(2616005)(6862004)(5660300002)(8676002)(66946007)(66556008)(8936002)(508600001)(6486002)(186003)(26005)(83380400001)(2906002)(36756003)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHwTbLpbEmJZka8G5hQolAb6pkvs3uk3mGXHMkGX44E//mMFqdY5KDVNzFwm?=
 =?us-ascii?Q?P7wUyNRiU6HaaRVYAMSYthGyO3jEoDEXZ5NCcSI2QHsZ7H/y7uE/A8LR7foP?=
 =?us-ascii?Q?4y6WtRXsdv73/yKVQeAcOKH4KyRM3NvRYRK1P4h1scPn1jdltdDpquiUy7LN?=
 =?us-ascii?Q?jDHLUFWPPi8mr839VSwFL44anfwVnLgWz1JQhcjleEtAhlpGRksUO7aDR2US?=
 =?us-ascii?Q?HNq9sx2m9FkyQoua27gLqvRqQJlj+44cUaXKUiJEPt2AvGh6pTl4sj33hxdy?=
 =?us-ascii?Q?uXgUVs/JH+mJFeCeWoMYpwTBdMVULJVXvJl+VXnFXdkXf75fH9IWnaPZYiTn?=
 =?us-ascii?Q?WIW3fABZvqr74Q1vOC77zD9rtpVn7hbszDJFxnpMXVNbmf4RlfSQMCkWCXaY?=
 =?us-ascii?Q?EKxIstk6hGJkGLfAaa4DRBaU19nfplXzH/4b1QEInSRZuRmbWOhdOrJISZm7?=
 =?us-ascii?Q?GtuLqmiqXq8Ebu17SeJ8xc2NScPkyrFG3ljxVqEJKT55UtsRzsz0w7VmqHSc?=
 =?us-ascii?Q?+mW2vJbf4yG+JhlfmGfM8644rBZVaxgIEwShD93SIHE1L4vI3Bye4jSVbhfc?=
 =?us-ascii?Q?5UT6qfZKpnlhtql1ZZ1W71zCmcrY95HEkDjlhu1W6fxotGgLNbIck0TlUSco?=
 =?us-ascii?Q?cViakJVL/fqeMo2HjN59FXkRDUsb0xG8DpZHOR1fnpkwj9YkQuv3jZAf8+g1?=
 =?us-ascii?Q?tbNFrMGEdfo4l1NHzuKzNlbZcdjcXUu9f9UhNe8brvrG0Fvk/vtxSiz90qkx?=
 =?us-ascii?Q?1CEh1ZM/c1ncm1FdFb7FsQ3GVptUaK3e2SbQHTifXt3W89Tuwz3FEVSAg1Vu?=
 =?us-ascii?Q?HPWP/Q2ehnQr5AC+ahudgFUy0+6TPsWgw2XmPZFN+BRwgnBRuA+HsMJ7j7KV?=
 =?us-ascii?Q?SdDYmYBuKRNOhh5pwTVlDmgw2CsXQFgBu8ZxjhQOJK0u/qIqjkdRMnbW2Wnv?=
 =?us-ascii?Q?CkO6veH2xntDoPh9zFyiDdAN387INmy8v3SrzoMd1p4JEizK8VyPaosMSYC2?=
 =?us-ascii?Q?/5J8xgLTT4fSf/NSCxwEG12R0yCtthH4sZ9wIa0V8xhsxI7+1AL6L57bXYSJ?=
 =?us-ascii?Q?ALZtXQ+1oJeLWUNq4SboawjaozU9Oh5XOJFZZGdqVkTSgVwoqqYFM2yzTOHD?=
 =?us-ascii?Q?fuMoCZx37HuxRSdv0++E/7dzB5jtsVYysm0aIhCZzNMcwxDrfAmnic8Hq8uX?=
 =?us-ascii?Q?ikhUyck2ZWukSp6KESNHtfR5UuQ/Rdftp8Vjm4gDIUxvTDol8Gu05h2ZMVf1?=
 =?us-ascii?Q?tmTaFeTMwdzZCFwbUqSu+l46yifZ7T4r0dSvg8Elh1+UY/hzKEE8EHRsyIne?=
 =?us-ascii?Q?cmVA57KrDNx1BLQ/olHcfucK6cc+CU+HmtxkMHGsRMQLh1BDr8aF8bpHi/HR?=
 =?us-ascii?Q?GlTA/NrJRL3I2v/cNf6A8rRA6Ji2+KUila4futREBEpiSIuFQBpUpOCqv9/y?=
 =?us-ascii?Q?JThWPtc0uvytyYVdIorHnUDvg9rfaRSSKN1wLji7fZs4ewXB3/9rIPyvXkx5?=
 =?us-ascii?Q?4cO7B7/6YkB9U+/Jjhzfbn8Q4ogZwAwlS9RtdALU4p1ysKEZL+a+Bsg7J0i3?=
 =?us-ascii?Q?JNibMR/0czTmceSwMt3Vdh6qfAQFP/2EFwNMMC217qimCVYPRz8g0rMiQiQ5?=
 =?us-ascii?Q?jKPdG4uTfY+un6r+IlLJykMMCYafXqG6bkqv4hKxFJmpCCYy5z2u0wZPWyov?=
 =?us-ascii?Q?mLtMnUcxKLrF/V0W874FUM3X4zfGZCkGQLcAiFkc0ZoBnhjE1Ql+Pd9gT53D?=
 =?us-ascii?Q?0sfe2LEACA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cc6b5c-45dc-4826-87c0-08da0fe8dc91
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 11:56:43.5575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bN4TIYKJIwGcVNfIuaVZdfIj+saQh+aSQgdXVzjWjIdkFJ/FGDdD/v8q0Q82ytsf/8T4bMiD2S4tlijeYqlOlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5258
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:42:25PM +0800, Limonciello, Mario wrote:
> There has recently been some news coverage about `amd-pstate` being in
> 5.17, but this news also mentioned that it's a bit difficult to use.
> 
> You need to either block init calls, or compile the module into the kernel
> to force it to take precedence over acpi-cpufreq.
> 
> This series aims to improve the usability of amd-pstate so that distros
> can compile as a module, but users can still use it (relatively) easily.
> 
> A new module parameter is included that will force amd-pstate to take
> precedence and a module table to let it load automatically on such systems.
> 
> With the patches in this series a user can make a file
> /etc/modprobe.d/amd-pstate.conf:
> 
> options amd-pstate replace=1

Actually, because the amd-pstate is fairly new for current distos, we can
modify /etc/modules-load.d/modules.conf to add one line "amd_pstate" to
inform the system this module should be loaded at boot time.

But your method also looks fine for me as well, the amd-pstate can force to
replace the acpi-cpufreq. I am not sure whether anyone objects to this way.

Thanks,
Ray

> 
> Then upon the next reboot amd-pstate should load automatically even if
> acpi-cpufreq was included on the system.
> Mario Limonciello (3):
>   cpufreq: Allow passing NULL as the argument for unregistering a driver
>   cpufreq: amd-pstate: Allow replacing existing cpufreq drivers when
>     loaded
>   cpufreq: amd-pstate: Add a module device table
> 
>  drivers/cpufreq/amd-pstate.c | 19 ++++++++++++++++---
>  drivers/cpufreq/cpufreq.c    |  4 ++--
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> -- 
> 2.34.1
> 
