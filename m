Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BC7578F86
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiGSBF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGSBF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:05:26 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3132E2DD5;
        Mon, 18 Jul 2022 18:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkcI/OrVQ4a4IJOnhCwGwvFW9D2lTeVWkBGT8JDWPVMiJ150AqNFR5UqGufXceKs0dmHjsSgdTkecvSHrMttT4ue2xM46mma2puJ+wLEa9QwXH4PMgU/RnD1632DYbXu5XyLFAapjIhN9n8MH6BZIzfNCKQZf6/kvbeYLK7kJWo/RBfQ8NLSIWS28FmwpY6vL+t83G1tyZlOFO4qsL1f91Onc8TBb581lCCbeWVi1zHoYDApgL6jE8LFLT2g3b03tYImsBcoDsNaKklUeNmq8UmxVh04g36sc7pUlL9NQG6ZnTUazKuMDoeAJywTz4P8uea1adVzaoHWCdl8tKjWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UncImfzFgy/hy07v4TQos3HZvOK+fMVry/IOU1uK1MY=;
 b=GbI9TJK1UWO868iiLdaXh0jYH1SX2fAskd5vCg1NAAK7kArbDnn9kHMMUUt5c4ycuGyQ27xX4TfZKBrdmKtp71sRG3mtlBMUfz1jsOOuCEAvFlBD8hA1RbB5tM5Ka+qKdYGzhHW7nBWLaBcu3ZxTzBAkyAXQa9iez/BGVdzR5WMunI+/NWPohhVHJ4AI6dOSrKKObX9wLOcEee9RUqVs05RFuzhHiidqnMFVLpGokuJs81nPmaIPDOT83J5N1QaSjhMS5uky8enK6L2gm5GsRVsq4TOb85lp+yj/ALd+678CUqq73clL8iaflo4WQLQNnfx0i39aOQCbJzmbWfKEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UncImfzFgy/hy07v4TQos3HZvOK+fMVry/IOU1uK1MY=;
 b=ysFaOxmA+cAtgQ5wznbsbp2dSNPVTOay5SKkq5Rld6bhgJnhfc3be/N12lG+2GnEYQ5qdI56B2SGKcxAx7UOcK0J5WlDWZQ7XuK5WF0iZ+tC9oQSaTqncRXpbgKGXItKJmWNb7thBLy0TtOBHrm0TrVyfGjjprl2olgrgc3bL+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN8PR12MB2850.namprd12.prod.outlook.com (2603:10b6:408:95::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.20; Tue, 19 Jul 2022 01:05:23 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 01:05:23 +0000
Date:   Tue, 19 Jul 2022 09:04:59 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 11/13] cpufreq: amd_pstate: update transition delay
 time to 1ms
Message-ID: <YtYDO+tXShYLKh2B@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
 <c1b46c68d521ff2c8ed49a6e8f5ad75ce51fb772.1657876961.git.Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1b46c68d521ff2c8ed49a6e8f5ad75ce51fb772.1657876961.git.Perry.Yuan@amd.com>
X-ClientProxiedBy: SG2PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::30) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9315b68-e2e8-4e9d-cd43-08da6922c1f9
X-MS-TrafficTypeDiagnostic: BN8PR12MB2850:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYzYWfIjvJN2xiWeXhJo7+sEO3SnhDabVYTD4t9WNdL3r2B6DJ2ABssc/25vJ4PQiJaazHjZI25ilVuUI/vPybZzrP2j826nEv7DrTkKMcVZG6DvfrRf3FaYEq5qAhGJxBJ1w/k9Q19hRwYK8PE9YnA6ksM88aWwzfANax6YzTNJUEWoJ6MHEHwvzBtFu6dPdwciFGWk+MJ0dRCHzocGJD13fQdbLu27AKdnsxzGAxGeQJAalr+dDMpsD2UXJbIPqA9ZeNdgCetZ+2xYWMcyZKAsuPs70+tv/sK8wfDXtifhyQYocZBLPzftAx3QIqya7MsFrL4eTcr/DMpFloF+KhxUzJhCLQ9AYo8uugSimWa7S0+k2pPG7jOlnfR+2wW0rkCGkk196REBhsCPmKsP7uoto72OSj+Y7SYZbHF4eDapAxbjNrsy3sOuRGnM9MzkxsnwzzvLdEbXM7a5AcnL3X/EgKFZUwQQSlrBcq1XqXlp3DsEZn5KiRArB68sKjN9DAbcuwxzW0AfyCdhmzBZuMu/mCXJsyJpYg17Cj+uC4/m7jf3qemz2vd0uLxYyZ5FMmOzOqF2ZT7DAB0tn3+MWUwYYKJ090xyKljNsy3EPKV6MeQKResNiou+WF80mvWhMy+LdZA+fvfvkM6EcfcDpj45UOA05WYMS4wvR7+t1CoNyGBHYLJvlq+F0bai2DjNyFBFj2WcXwuRzOFLwiqPl5RM0WhZ9h0zxkeQnkBFFR2vdh8sZhAa3pp9M/1w9P7Pqh4hm9DUpymolCwPY5Q5hg6wRq5iM4oianH0i/EESHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(4326008)(54906003)(37006003)(5660300002)(6636002)(66946007)(316002)(2906002)(66556008)(66476007)(6862004)(8936002)(15650500001)(8676002)(83380400001)(36756003)(38100700002)(86362001)(6666004)(41300700001)(26005)(186003)(6506007)(478600001)(2616005)(6486002)(6512007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/jImK9ohTeGFPniV0+nIOQ9jxmlgKiPcxHyjSwriMeD1agvLEKrGNfU3Pem6?=
 =?us-ascii?Q?EZF8xbfd8VVI2lfl8IIqUJZY3y6vvAeloZAQuU7GT3KXa/z7tawLcXhIGB0i?=
 =?us-ascii?Q?jkBiAYRHtWf21iic8APfTTFqwx0zAeDxkbiEd/BUeqTE2U8Dn0JgfbjIzvrT?=
 =?us-ascii?Q?A2+lTguEEqnOl9OMyf99ekOLcwo0Njy5n4LYVfh/xZ/BBGXJWOtePoZofeol?=
 =?us-ascii?Q?3dTeDVVpgvmElQaZYVtEGQcybv6m6lwVhOtXrZuIHX9wQAZ4LZzKnIGu/DHJ?=
 =?us-ascii?Q?xAgLR6RxvhZRsyh9B0msd0HQlamxj0a2XP8WA3PvPA0RLvoSXefOmnhiDtG1?=
 =?us-ascii?Q?9BYe7rSa4Vbiu6FYnwz2s2aGwJPHzFOt5fvDSHoavIKzHAf4Kz3MQuDFLlGK?=
 =?us-ascii?Q?vCPs00JEHMkH60FZHjr54b1eMkyv1Mrxli3KabkNWZIzn48uWpcYLXDu2kJ7?=
 =?us-ascii?Q?oKCI4K6yn7+zuzdLGgoC0MZJrcOID4emT+qR0L5xeNvf2ovwGHOY2KNMFPAZ?=
 =?us-ascii?Q?2OIkSL2ztGnJWxAaqLr5dstwbjoV4qjvqduUSGm2+UjVQhwn1sFarAgHZULe?=
 =?us-ascii?Q?nfT43LDgu2d1nF42CaRqwrSQZ0sD9V5kybwswTEQ9DFE4mcyIO1PzaUxGKTe?=
 =?us-ascii?Q?dvOK+SCqYSfAEfO3xouF1QeHx6FM0RL+HZEqpnclLwzS1EMg7JP7nYAprsHy?=
 =?us-ascii?Q?7ONyCT0xgDm8Npnm7XNdqVq9zwvU92gujgwFTShhqlLiMETqgoN7pGKfuRoB?=
 =?us-ascii?Q?52FRmvNi+M0xQpJmkC/8aJcm7ywkFBGYY0viWJzV7NKDgcttdKzplDn/pJJe?=
 =?us-ascii?Q?9PqvZzQmXyewDjp28kDhMS4jZ2gc5tu2iFBu8g9/HXoEA7bq9w60J3RfuvM8?=
 =?us-ascii?Q?9VGIWYTpZDzkGNH80RFujq3tXqPQVX81htc4+EV8coU1IsQ3Gin6PE+5HHOR?=
 =?us-ascii?Q?N5ROCA5S7gVloVUn463Ekf6m01zVavP2iJSanjBCr+LeEKKLyg76nPxlX+sd?=
 =?us-ascii?Q?iKM/vMJR3cGzg/KWisJ7aObsZiTvAQ4LVVlBLbREbYGNadQSFUcirngcQdPY?=
 =?us-ascii?Q?HENSp9HvNxq68QhOs1b7IT8ijhCBaIagQD4QNB3It4u6aVOGNQRE4SMm/QeI?=
 =?us-ascii?Q?Amz2PgxySclqeIqXDcKlbHa2+d0vyWJwJQ4H596VolpelrFc62JuXurkNzG3?=
 =?us-ascii?Q?2ncQgrPX5ROvyqM3kPZcV3Juquqh+/eP/IColAhszed4gRA7ITOB6KXHOOQ9?=
 =?us-ascii?Q?p0YJsdFWvTO7y+wBeywSwOg+E36292bL/w1el/LonzbTKMLNDyU0KOinrxbt?=
 =?us-ascii?Q?xaAg//fM5PuPG3qJAQddJpSMcQgeBO9yRYzjrEdkuGCviddPEpc/RG0zCtWx?=
 =?us-ascii?Q?INgiTL9KcmAJGJZ7MQF7Yvh0nFJlTblA11A05Khlh1ZYxa9byxUOjAmbyQrZ?=
 =?us-ascii?Q?u+SK8b3hdi45zCwsUpR+OmM5A12uTAxiC5Bd8A8BDmCBLSU+OGVnLqm2VYgE?=
 =?us-ascii?Q?+eC2XeCFzy8xdFSPBxba47NN1TicaIt7jooZKB7PgfLXhRB0n4iZacmCrCFJ?=
 =?us-ascii?Q?5G9XBy4E+RitOzfGAn7gdAAB45wfy9FbAmO5gcw2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9315b68-e2e8-4e9d-cd43-08da6922c1f9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 01:05:23.1618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uaz9naOviaG9TcOg5r40Ei6Nnd7vuiJ+YEQQ4CYemmVEMfOaWK7i1Onf6NUcdbFiBoYeip20LWjD+jegXuTrsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2850
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:04:30PM +0800, Yuan, Perry wrote:
> Update transition delay time to 1ms, in the AMD CPU autonomous mode and
> non-autonomous mode, CPPC firmware will decide frequency at 1ms timescale
> based on the workload utilization.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Su Jinzhou <Jinzhou.Su@amd.com>

Please squeeze this patch into patch 9. I don't really want to separate the
transition marco update as two patches.

Thanks,
Ray

> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 4f8600a36194..d3bc441b3923 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -42,7 +42,7 @@
>  #include "amd-pstate-trace.h"
>  
>  #define AMD_PSTATE_TRANSITION_LATENCY	20000
> -#define AMD_PSTATE_TRANSITION_DELAY	500
> +#define AMD_PSTATE_TRANSITION_DELAY	1000
>  
>  /*
>   * TODO: We need more time to fine tune processors with shared memory solution
> -- 
> 2.32.0
> 
