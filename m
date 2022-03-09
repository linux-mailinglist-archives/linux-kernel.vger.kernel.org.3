Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832194D2FF6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiCINdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiCINdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:33:15 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3FA17AEC8;
        Wed,  9 Mar 2022 05:32:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZxFUOPgNPnBQ/thVcUr2bxFdb/VPUA6IlXraDqDDQyD5J1Xw4qi6anCPkzq9IkITmxqe6CNhraDgwg7a5ayUEJC9l3wINmMrtOiKDipte4P/5OlbWFLRmmQm4bQCWai4uzjYJODwaH4kg94YRnJeK3Q8zVPxjPvci3evl3cS01UnojlGHrdwrIoCVFgZ/ub81hMgmBEZ3dix7Op7ECOOMMeYUyBoZmHzESxiPlEeBjVFqoNW5EaBBjlmvd43rb1i+0XWxO6jLSKyidpaklPx67HHOOSanAr2tmA02YOE80pJFr+3/EXIxYh/vxEGx+acz9u5N6NzItZ/jZ9d2D2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KppiXheMaONa7wiu7LZvIuS32dv35Je6JJWHfCIEg2k=;
 b=MjbjTTXairoyLpX3G5uMd79puTJUyzepI512xHYSFiLxfVe+UlxpeCXrWs2hShOXfOLI8kn3bYATHsTM7D+o+vwzqPH103gMfjlgCu8Ab665tmmVqnd2v+hL3crLN8T4sT9htXXIAYYclUuILErhebZv/qMUz9WMDb76OtrLCb9TWmcu3rtx7ShF6ECjjD9N6OlQvDZnEf6BXrttSWaXhyk2xyp2oLdqCZK2RTSTmIUcOTpigMI4wincBY//XKT7L/yoAbjUJILNe8wvUTinf08RAOT/kHZaCQyvlihFjFph3LKMsdmMTnHZkVmhhElVZmper2jSvaldFsELtEU6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KppiXheMaONa7wiu7LZvIuS32dv35Je6JJWHfCIEg2k=;
 b=kcZCqrTuT8szK0WaHMEFhyEFFSV+pg3hD6gvA2rcOgR1mLRWTEY+6KnSWya9edSL9Sm8UbRRtgbs/dGVi4AkaUMg13Iei2Xf/tNPGRHEtB0FybWGMRl1deQ6iFWwXULYunDbHChFUBhtLhEJ9aRXr3jKZ48mU5T2NbgJHSlpWO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BYAPR12MB3477.namprd12.prod.outlook.com (2603:10b6:a03:ac::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Wed, 9 Mar 2022 13:32:13 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 13:32:13 +0000
Date:   Wed, 9 Mar 2022 21:31:49 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "dsmythies@telus.net" <dsmythies@telus.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "todd.e.brandt@linux.intel.com" <todd.e.brandt@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Subject: Re: [PATCH v3 0/4] Add tracer tool for AMD P-State driver
Message-ID: <YiisRXfrIco8hnXf@amd.com>
References: <20220309012351.616826-1-Jinzhou.Su@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309012351.616826-1-Jinzhou.Su@amd.com>
X-ClientProxiedBy: HK2PR04CA0076.apcprd04.prod.outlook.com
 (2603:1096:202:15::20) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19295b82-3a74-4eca-cd08-08da01d1382f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3477:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB34776697E67DCE981B18107FEC0A9@BYAPR12MB3477.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EkDEmIjeZNc8X4PtrMOmHvzb1x77ue6oexxnqBnzp3GN9W4QSol4jtMJ6OckKkOxlg4kI6ZUelRPDLwPaKpz5InETiAMiCUOGii6q92YXlgujKn96KUpWwoue3/9jTkKKgrpowvHYkKtlbXYDaMk39KQqvJXqJvXuxi8F6zThIOCA6Q+DhxWwCc5v7tQB9ggoLxjAmGRKXD/ys+U4SMAwviXfE5b6bAipTzlE+GjzqwxHgFCu+6ka1fvNulgcMMR2zBev7JyayBZUTQNPTawLPorUYKBnqqYDfXjvSuqpdLDaksB9M6dYitTDWhn+UXBdrUc4dS7cQbhAD3Z82OyPp8hcdOPECHOXNJuLsyPfrl9Mi4iCu+yQTHj5R/0+rbsi7EN3/dzKDSCUtcyaiNWVqcX0vaz0jHN4YH5fNWkKtzVqaXdf35GPkSN2nfir3A6JvLWijBFgtVz32n4E1WZpTnliKbx7YztiY0xeNFZ0kLV+hpFt9Prgi4N7Ol/C3Dyexw3ceTjOJV5Ta81EFUrtR3+/3bzhzlibvYORvQfdUyhzjAmqzA4FKTIYiKug3KUKmdcviUQGRkHA8Nge7qvbEibTHIezJNEnNqLUSU+nbXuiqcNvvRsmuype7Es3sZFp9WxfAzPUaa8ujc6FTb79A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(38100700002)(6512007)(66946007)(6636002)(36756003)(6506007)(186003)(26005)(6666004)(86362001)(83380400001)(6486002)(54906003)(5660300002)(6862004)(8676002)(37006003)(8936002)(2906002)(2616005)(316002)(508600001)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qJaXoAjDN/zScncmZjh0fkkWBzde5OfJuw/SKXq7YwB/KviSREyV8KoKr2z7?=
 =?us-ascii?Q?pPF4ykbbkqnzMTqCswXrz7Q4t+Qr452HM/Y/hbEZ3Ut5HXH2YTwNrhL0IhhM?=
 =?us-ascii?Q?yX/71Af1VP7j8+u+/RhuW2Gs7VQr/hJ8Rjz8ytHDjSqjxmTz4Vvwh9hVsQj6?=
 =?us-ascii?Q?7pCwcpEqTBX/LBkTzVyUhgRnmz9do/C5JYTKSw8ahdR9j3Re+9nr+ihnX7re?=
 =?us-ascii?Q?xB3w1ND9NGvaCbOrzOeBq+NhupVJ8TptJXsKZyoVh+5fx+8hE4UMkLraCIJq?=
 =?us-ascii?Q?2NqlccipaSvN4m5DgKF8W9As2BoilYXrAEn9iHu9yHNB9e5Qc7dHXernrUks?=
 =?us-ascii?Q?P4Fb3QPxopaPYSideIoibjBySXL/dE+AgkExV7ZnyMJkg9PZM/hN1Eb6f3eg?=
 =?us-ascii?Q?UHyoAS8c29WKl9Fnod8RnrqNvoPxcFcQn1RF3RyWbRn5y1Ky0z+y6VTASgaX?=
 =?us-ascii?Q?UMIgz3CqjePcSfPpz0Y/W26dZD6usWIGxKY9p9JQHbrY+m9yki6ZgdjPyPpx?=
 =?us-ascii?Q?OuIdwUg1BYgUOcXOkf1KrhPiPs8GE0cd4mRh2y3/FONkiMHYxA1RdJTRsw2o?=
 =?us-ascii?Q?v9W7HT0dRGZ8YwvIktGz3BbMglnEs5oUuyic53VZmY9TXFV0V9OO9TIU2xPh?=
 =?us-ascii?Q?Tn0Fq4B6SHzPJPGcD6QLaGPuDPvOZdW051hL6/O+CrZXgveSIrBE2WneyaL0?=
 =?us-ascii?Q?zoVBLlYgyHX4sTDJ1chjp4t6B3Jmvg/66xsU6iqJkZZ6FCRTM232W59E/+rL?=
 =?us-ascii?Q?cJ5ZC3w1pcFAHYuzuU3k0RJ7zSOYai7uAHZ66FY53RR2/2+jOEgPJkhKVJpp?=
 =?us-ascii?Q?bOO8X6DXVV15TqNNOc7o//LB1i7lMn5lcOEZNCbb+ALR3THSYVF/hwb26LTy?=
 =?us-ascii?Q?DA8bBmqCn6ZsDHuYuIGyd905fL9EXNSVQ/IHQ8Uu6AZfoQYEwsxSa19by2V8?=
 =?us-ascii?Q?OP8qj61kv53U6cbC8wqk+iUj9lLyoUFf3tRHMvvizu+NBuXWTt+zmJL7nHdx?=
 =?us-ascii?Q?R4UQoQI8WentrAvgrnN//3bsTAURq0h9H+K7NlnZuIxERfXAGcDQsjnImY/7?=
 =?us-ascii?Q?biP2kZPFAO2gmQXn0DvSUkW7DPDACIhHa3YwMg2IhWRlTBMIkByxSWxqiBWw?=
 =?us-ascii?Q?NLRLnuIJV4aEJJeeoFVqqwnBxMm5MSayFTyUc7OkQjTTuXDKF+Um5JwnV06Y?=
 =?us-ascii?Q?z6rV3jLUYXYgoJsI04ATwpi/RphRYEgDCMcoCHw6LieWRksKI0Ajr3+XYkOI?=
 =?us-ascii?Q?QbXENi2EwlSi4uZpycCNe9femkBg0WN4aQ42x01Wc5r0dhpidVdOnTDIGLmT?=
 =?us-ascii?Q?60Y+VpgmyfvsPVIvsIOom0UQq/XZD0HUpXc6EG2lG55ELVuVGLed4iEaY0E5?=
 =?us-ascii?Q?etIZBxZhMXMZLZ3DTUBbPNIxSFiZPEIe3i0XkGWOXY0cCfSjW8Hw7KhS7o6x?=
 =?us-ascii?Q?hbf9Dlmm4I5a9kDUfgWNFYnKBaQVAILAdZw53JY98FA9U3b7c8/NiRjbhMHp?=
 =?us-ascii?Q?H0fX30u7dAiQtxP9MsqV0Cq1VZyhoPYZIpefTNOHK1utTcegH9OF0/rLQNXV?=
 =?us-ascii?Q?nhbxVaWHMbJCuGS4lA1L/JsWybaIK5fpB0Xaq0JsoSB/3vEy/+aPj8zqzN/P?=
 =?us-ascii?Q?+mD/Wc4KMHTUU056mMNXJoQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19295b82-3a74-4eca-cd08-08da01d1382f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 13:32:13.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Tq9bpNb82o3Cni65VbA4Onzg6LE1OYYObq1P9MaXdiC//5TN0MjUOvkowQ8YaK2kJj7YIEYrJ9KsC/jyaTzOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 09:23:47AM +0800, Su, Jinzhou (Joe) wrote:
> Hello,
> 
> intel_pstate_tracer is a useful tool to analyze the performance of
> intel_pstate driver. We upstream out AMD P-state driver into Linux
> kernel recently and like to use similar tool to tune the performance
> of the driver.
> 
> I modified intel_pstate_tracer.py then it could import as a module to
> analyze AMD P-State trace event. Other trace event also can benifit from
> this change once they need this tool.
> 
> intel_pstate_tracer could be used as the same way as before and the
> original functionality isn't broken.
> 
> Changes from V2->V3
> 
> -fix typo in amd-pstate RST
> 
> Changes from V1->V2
> 
> -Add tracer documentation in amd-pstate RST
> 
> -fix typo in amd_pstate_trace.py
> 
> -add "Co-developed-by" in patch 1/4
> 
> Thanks,
> Joe
> 
> Jinzhou Su (4):
>   cpufreq: amd-pstate: Add more tracepoint for AMD P-State module
>   tools/power/x86/intel_pstate_tracer: make tracer as a module
>   tools/power/x86/amd_pstate_tracer: Add tracer tool for AMD P-state
>   Documentation: amd-pstate: add tracer tool introduction

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> 
>  Documentation/admin-guide/pm/amd-pstate.rst   |  26 ++
>  MAINTAINERS                                   |   1 +
>  drivers/cpufreq/amd-pstate-trace.h            |  22 +-
>  drivers/cpufreq/amd-pstate.c                  |  59 ++-
>  .../x86/amd_pstate_tracer/amd_pstate_trace.py | 354 ++++++++++++++++++
>  .../intel_pstate_tracer.py                    | 260 +++++++------
>  6 files changed, 588 insertions(+), 134 deletions(-)
>  create mode 100755 tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> 
> -- 
> 2.27.0
> 
