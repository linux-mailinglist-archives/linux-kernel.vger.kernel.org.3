Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B3E511A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbiD0Ntk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbiD0Nti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:49:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DCB3F612B;
        Wed, 27 Apr 2022 06:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekxEvebL915jy8p7zu9BdP+M4jEAA2VvLJgwD1m9AC4K8sC1R+S6/sHJhi6JSOI+7uL2o+Tup9W3GAxXxLitiUGY9YbEbwbL01D7aZOhVCnJd7tD8fGgP+4E/aQpWEOBrkgoz3xF5F8EqqnS1qsf5MLPij/n3HgcFdyTrM9GQviXp7WLYek0VFdY7Kxk8CsHrz/2FFNNcl6/x1YOyP485UBdv2kIOqLbjodq1j0Vq5FhOirp8kNshqks7KOXI++EmmGezsZgfLvB9sjQswwPodYQ1wB1wHGzg1imUHChDrIOlTA58cue9vFOF0CRLUVGgxynomy9PJeqAuAAkNdCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehpH7z2On3MURSoy428Rz18zbU/Tk+W5qPjpWpAI04g=;
 b=IddxUfriISzncfFjQh1bBjKe4thi9+O+q5NGP+8F/J8fjBNA0sBwuiVt+tFqjqWh4sFf5ZECNz6yM+jzDgUikj4mM9FVVYHl8ttlhovj9YtAdhfXJ4au/M2ftAGPuhtyeDlPsq6KqiLDQNNODuu2wjlUReu1RQWyMffjC7Hkv3C8BhnnFIQbAywbxyAfKthNPikI77lbkwdbTopepzYqzRBUFf4ihd1BTKbGwKmhaTs1I/Jivg4jh1MK7S9KIm6BDiMJJDI7s4yLVN+cQYxW43IFKDNVxRjr7vETY+rEiH3HduEaOGRSyCM86T0YjajvyaCDeMYGDcb+mTXyCEJcXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehpH7z2On3MURSoy428Rz18zbU/Tk+W5qPjpWpAI04g=;
 b=n3o4kqzkRUtiC22qsgVV+Zm2l8LT2ktReXIheFmktfTcJgLXCY8BcKeYNtK2YlXfdxuBvmgasXLMNnmBMJfxBfz9mJfX6pxykGBLa9ITdiNXDo5BkTQ6ezJRj5+ZhLMF6oQRrNOcQXPIXzk1Nm8XjMvpnI3u/Go9bIjL7iONKTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MN2PR12MB3998.namprd12.prod.outlook.com (2603:10b6:208:16d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Wed, 27 Apr
 2022 13:46:22 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d%7]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 13:46:22 +0000
Date:   Wed, 27 Apr 2022 21:46:01 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] cpufreq: amd-pstate: Only show shared memory
 solution message once
Message-ID: <YmlJGQavHNOVjzQF@amd.com>
References: <20220414164801.1051-1-mario.limonciello@amd.com>
 <20220414164801.1051-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414164801.1051-3-mario.limonciello@amd.com>
X-ClientProxiedBy: HK2PR0302CA0023.apcprd03.prod.outlook.com
 (2603:1096:202::33) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6202fa4f-e483-4624-e786-08da28545090
X-MS-TrafficTypeDiagnostic: MN2PR12MB3998:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB399854AEF00834C0A745036EECFA9@MN2PR12MB3998.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SgxqsjCFJbJUDgJjrn+SCjOI9fYzY5p18hnnj/qG4RXRJCGnYt8dd2sI4ZWr5JCZ7ohN8uC+2FaZjvW08u3k5LkN5UyRkjuRCSyHcEKXjPJ6/GN6EekXSj+HRUWG/TXpsQ2ChSEoKxeiM4IfkrK3Il1nJEvtLfrmmiF4WkCxDX7bCxHXBIOtOZfyVhYRKUuwnMrYs8pCBAJ2BInF5bOf/CjQ1Ut4ADMrI2qQi7xc7uiZaN/1ZNvLeYA+MUUC0Kh72y6R2WM01Xx9wLPCSimj6pWCbyX7lxqQTOLgkqtFDi1vWeZSPnLThPApyD3nCxoGiYD7A0RjFYPuvjD43jdI+85JLDKfVvRLhmC+L9q0YXuXL2uZ+58Fy78UZ3aGbYy9ySn9BNnghYvdAG+8k9wzR+a/oJqmBEYwkbYX3MDiHMEIl0GCcYxm0g63Rsgf616EroWvg20sZi7fTa3zWVHUUryeZMKSbttLWoRw6e1c9sN/5CzF/nlDLGw3eZDGnOswSEuu4xANv5ppAnPuVRecBlFYSR+1q25I30yN6ik0lRDOjVDRY3/kt7cSiHgK3MHQerUPJ+g+nAx+qRWTFMgluYZJIugJaQmXHHmFPDllPozm2WJV636Z4FDX0VGzC9jARkXlsL+7AdOzlFDm/tFErQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(186003)(54906003)(508600001)(8676002)(66946007)(66476007)(6862004)(66556008)(4326008)(86362001)(36756003)(15650500001)(2906002)(8936002)(2616005)(26005)(5660300002)(37006003)(83380400001)(6666004)(6636002)(316002)(6512007)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6VxpQ3uvELgMfD13Yy1BM1yDMdTjIgv+Gr7gw8jbM1UAfx1tgmJJfcgHVkRn?=
 =?us-ascii?Q?RsT3uh+ZCF4z1oELMSd6/Xli0TP0mq2fFFj9WbCu+S63DXoaW8xCtYJXK2NW?=
 =?us-ascii?Q?OJaaS5c9YlCnVRlKgSNoK4Zc6X9FeiJNDUFj5tEwKAN68jZgbp+MW758U3on?=
 =?us-ascii?Q?keuFEkxT8e4LYiuujiluDFtiWvKTFjDOdDad2SADG5H7nNWXj8XfIkJRFZIg?=
 =?us-ascii?Q?ytgNkC7plgyy6xa/MXWDLrc+3eZS2hDTI9bKaQaK/PeKiehFsajQkOZz5Vj7?=
 =?us-ascii?Q?jDTO2oRHENETfP8z7h3a/MpFL9JeY0KHRSfsMiCQ9BY7RSyFXpGW7U1g5j+5?=
 =?us-ascii?Q?HnYAYxst7tXSboGtsrODsFafmDBTsvXlpSm1i0t5OpAh6XIwndkTosR1C422?=
 =?us-ascii?Q?g7RvIjXgzfmWiHZQQzJWkkBOUeSJgD+2EOYSVzkbizHukG4JS0sBdvaQgsrv?=
 =?us-ascii?Q?unte9/l23LSz8wqWxEGIggyUaN0al0G3BRMzGaUvCDx1/yCMkZgCRPxGb3ao?=
 =?us-ascii?Q?3BcC0nusWvZCUm+OCy4gnj/hl3sv4CUgKFBD1iOxTniKOE47kM+L6GVK+iwk?=
 =?us-ascii?Q?JRQHaCj5VxzYcyVJU3s9Du7VWicuFylDF/xvhGicU/8p6anAU0CsCsWlUVUc?=
 =?us-ascii?Q?LeJWq67mpK7N928n35HV1NRd6xf/eGLcFeq4r71ohuwdFPvquzQEqLEkWQph?=
 =?us-ascii?Q?jY0TKDMyfzf2AB0eh6EFUsmZ/Z9zT0P9yGBycmYWnarivNAc5ENrQmvYoO7k?=
 =?us-ascii?Q?o322ebP+V4Kvk1amKUZu/r8109TUD3HbjNeaesUFoTZuQQGYMJgsDysQShdA?=
 =?us-ascii?Q?SEAF83SPwWUEYn+QF4odIu2Vib9+7E+GlTtqCrywWz21W9vir57YjKnyRFWv?=
 =?us-ascii?Q?SUseBXvXi6+/D8HeL53uqEKKZ1BqioR0CGNxhAfnwPRrtt4uC+YbJhAFF/lC?=
 =?us-ascii?Q?8FXydgAvWsTTZIKOII40Ed76JuP+gaF+b++GImDz5GRQCASdwqrKxxG1tQjj?=
 =?us-ascii?Q?aDRHYSPYf2qWlSNZP3mvWOMfmj4LrDa+nDB2J9ja8SXrF7830ZXjfkz1AVXo?=
 =?us-ascii?Q?DF6kgj6UpFdiBYx9I6GA+lc7SqPnZmYFtyrmcrnzbmOihesWOeEAezlV5KqZ?=
 =?us-ascii?Q?xJOw1ntnKmN5McsYw8eBBZSlL31y3CjXsUACmoWUnRL0jyrT0Oi04vI9mZUa?=
 =?us-ascii?Q?urS6i9fVH+h4pYl6EHbSMH/5ABVOBYBVFoBzFbpo2hPVQzHuT/qggQYPp29O?=
 =?us-ascii?Q?vo4lty5Go8ILlrza1paciPVM5/DktTGTCyMSXdGsqTGGVOBQmvvCC1CgQ7zB?=
 =?us-ascii?Q?c77GRZFdWZGr/wiNbp1M7xc9EhawLLm+fm0E52Rgiyw2y3xUUAzQ6CqjvSvT?=
 =?us-ascii?Q?GTcA6GXt13b8/VSfaXSTHWMC+2f6kIggAtnOmjiNI3cRtpSqFJDhbA3kEnlC?=
 =?us-ascii?Q?uFjIh1fUvyFc3zMXsaMrkh/7Uy36Pve2Z8WbLAIPf1AVAfcdAK1JOC2fcK1H?=
 =?us-ascii?Q?cFlZ4f551+VDtPz0IYg9NwnnzFoTS+dzOpJZALhKorvDgh+f/T6WcB4/rHmI?=
 =?us-ascii?Q?rvNWoZJBtuq4RcjsKx+rGqYFcCq8eTVizah6JPn+FTBlSOPnlSWMnkmW0qnh?=
 =?us-ascii?Q?4c+Ire1sGFV/nRAIZB9T/BEx5hwG3rH0uf67rjOwSg43fbSGpOyBerFaaJsV?=
 =?us-ascii?Q?Wn8MaV2RExIRLPuWZ18WovHGN9vWQvCrDPWibB/okgiXRFveTK37nKH3C+Bz?=
 =?us-ascii?Q?0LwRn0Mo8A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6202fa4f-e483-4624-e786-08da28545090
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 13:46:22.4602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hk8GmxMvVRULVFMshwc/Elx3iAAA0TogEBazTmlZGg4yfrdIb73pXQ2M1Ea0YM6k+NmNm1ojbl3YAqZWZjX47A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3998
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 12:47:57AM +0800, Limonciello, Mario wrote:
> A message is emitted to let users know they can enable shared memory,
> but it shows on all CPUs.
> 
> As this parameter is system-wide not CPU specific, it doesn't make
> sense to show 8+ times.  Modify it to print only once.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
> v2->v3:
>  * New patch
> 
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 7be38bc6a673..ecd1fd5e5b5a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -666,7 +666,7 @@ static int __init amd_pstate_init(void)
>  		static_call_update(amd_pstate_init_perf, cppc_init_perf);
>  		static_call_update(amd_pstate_update_perf, cppc_update_perf);
>  	} else {
> -		pr_info("This processor supports shared memory solution, you can enable it with amd_pstate.shared_mem=1\n");
> +		pr_info_once("A processor on this system supports the shared memory solution, you can enable it with amd_pstate.shared_mem=1\n");
>  		return -ENODEV;
>  	}
>  
> -- 
> 2.34.1
> 
