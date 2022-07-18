Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99917577A74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiGRFfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGRFfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:35:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B2EE003;
        Sun, 17 Jul 2022 22:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVPfkP38N9BKql8nWA8BDxnYNpyNWrYxFb0TOpO8VvwQwph5BQqxSGQBc7WPgzmCfkwAlhkaujRmEP2OPSLP/hwhQitnhczn+0mhuSvw4uoR42A0e8k+XsKW6Ubvc5E2f1OHxHIg+pNy35G3sqCe6GriJ+Am58Ars0YbsL/8M+NrBewuB7RxTJKMiWfUpShqoYveTvMe1CgOilnNOVGAqb5IcCktrf5TUSkvL6C1LuGvZcwSJSP3xaE8Xfc5b5qcuo3GVRmO299KzkZD2mofFKFyvZMp02F7kwkllFTdvIj1n+Mqx44sE/ip08xmP2SkGQcw1hF9wplsxIDZWvHc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDjlqeT3ScY6SSqvdQiH7ZWoFWkq8ua4MPLr5IAGmqY=;
 b=gY16Zv8ozjSHBBtGSRAjExRsU1TTe+KNNcUCA0iTfLemlyENrRXrPNpFGAVcf/r+KOk1SGEbLAqwkcgGOdQwsYuEO6FlL/jKcwCCMSUpO7Lnp/DV8bxvac0cY40PG4Abpl3Ra2OzU6wxmJeQaH4qcO9iPHHGjJPUMjDJa/p1d+72TPmCX4RkUAMNeYB16eernUH0Kg5Sv7Bv/Soq1Z4/IUWmWsrEfbkqoR3yUluAtilNrg7V33OCjUxhrQwQhmTFcp6zpeMCGY9Hqc7vQie08R883UAE3EB375Y6bEHwNlNvmq8oG2pUwY6U0D88lbkBTG8j9+xEcrI5N6XWfZbtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDjlqeT3ScY6SSqvdQiH7ZWoFWkq8ua4MPLr5IAGmqY=;
 b=An5OpWNxRB2vyCGtlj0xvOZz9LQx6OxDD9VleXYvpblO8n5xC7Dnb4mRKtAJ5MT9a2tkBPkhWY8lRDRGsnvbqQow7YSfLjZc7sxt6RUpPamyy6vvPpkTpZcd2l5XX4mRocVsZcuOaGimBB0mhN3W+L8P0oyUtzlZuzC0g3iaXmSkebmTLmgIdgqgK+ZELYAKuxd1aIDwNxtRugUQ6xAnN9Rjb/qKYEtjF2F3NBAFO0JSQdC0cpG2GqnqRaeH/pRKazwpoUVoEuIAAuE2HaHlxHOuT02x1MjfG0XVUbrB69CuVrwXi7HaIj3oHHkHuEtTy6w2AUxWJdacozm9kZrP/w==
Received: from BN0PR03CA0041.namprd03.prod.outlook.com (2603:10b6:408:e7::16)
 by BN8PR12MB4786.namprd12.prod.outlook.com (2603:10b6:408:a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 05:35:13 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::71) by BN0PR03CA0041.outlook.office365.com
 (2603:10b6:408:e7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Mon, 18 Jul 2022 05:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Mon, 18 Jul 2022 05:35:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 18 Jul
 2022 05:35:12 +0000
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 17 Jul
 2022 22:35:09 -0700
Message-ID: <f4dc33b6-4023-1ac3-9365-c51175375bc7@nvidia.com>
Date:   Mon, 18 Jul 2022 11:05:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] cpufreq: tegra194: Staticize struct tegra_cpufreq_soc
 instances
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>
CC:     <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel test robot <lkp@intel.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>
References: <5c1a9b405d96848f2dac9aefcef121ad178872f4.1658109927.git.viresh.kumar@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <5c1a9b405d96848f2dac9aefcef121ad178872f4.1658109927.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14f03849-5ed0-4439-d798-08da687f498e
X-MS-TrafficTypeDiagnostic: BN8PR12MB4786:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATVPfHb5j6KGS73ksa2h7e4AdpO3AuoTyCErSJxR//LWZO5GltAoaCkY71J7uwAdbYD7l4tQoDqrMi4oBmGJ3saXzHFmp9/mArvLBaWV9eO3IXyK9kChQqo9aHhPD1xfvQs9rLCQWfNvd5lEU6P3nJBnolAclqkLbgg1xk6V5qTm79FzXQJSOoPZLum5rwzp91P8wciIn7/sV+DJNxOdWjRO0eVDf2hNqx5qlaSOtzhkr5F9jtoUxdz3vG42Dg0zThHAmiXLjmokImG6iQ9hzteHGbb658lsGzisRg28EiFviXrMHvGL85Xqt2hqSjCSnX3v/iT4My93199x5tIKHvXHhY4fMuDQThPyjHSBylEeJioYFZK037ikfinxzzpinCk1hCzkczn6knbpp1QQgMD7szfmhT67AXzloFQkWFGjczzWibxbBlv5/QrmGc3OKvJ7Wpaqf+VBpMiiq5iM37CWXM+4c8YUxT/cc/a+6oy8OdVfJI+iKI8npCqiHHNqcGqKhT3rjGs5bb4FDUbDj843QaX/Ye6xT9M4AGkWIBua8JV60hmbmnnZDgRB6BMknMStvOLE3KAIcTVl1KsIksmc5rIsECLtPo100dX8HXpb1vbUySpn9DWBBggXz7faqH4r9E89TWlfiqzyv9N48v1bcSe5KrWtsCNJdyzZkBbPOY/HC8aUhLZWYb8yJSOzUp2hrXCjMn6H8sVHP5ZeOu7k+tJ4/gAYDgmxi61EDJKNowR3m6I61UBXPRvVN1O9vrV4O47QO4CcdMLnanNDXYjrh6DcvVZ4OwZiXbkFl4PtNKgLsBCZnxNDasH0C8JSl/sC1l3cFYb3hcuk2MZaCO1rPRja+6mOe+BJDagASSP39I9swWqLi5jRqb6bNRpO
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(40470700004)(478600001)(31696002)(40460700003)(82310400005)(26005)(8936002)(70206006)(86362001)(40480700001)(70586007)(36860700001)(53546011)(4326008)(41300700001)(6666004)(81166007)(83380400001)(2616005)(5660300002)(8676002)(426003)(47076005)(54906003)(186003)(107886003)(82740400003)(6636002)(2906002)(31686004)(16526019)(316002)(36756003)(16576012)(110136005)(336012)(356005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 05:35:12.8861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f03849-5ed0-4439-d798-08da687f498e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4786
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/07/22 07:35, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> Fix sparse warnings by marking these structures static.
> 
> Fixes: 273bc890a2a8 ("cpufreq: tegra194: Add support for Tegra234")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>

> ---
>   drivers/cpufreq/tegra194-cpufreq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> index 2a6a98764a8c..1216046cf4c2 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -162,7 +162,7 @@ static struct tegra_cpufreq_ops tegra234_cpufreq_ops = {
>          .set_cpu_ndiv = tegra234_set_cpu_ndiv,
>   };
> 
> -const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
> +static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
>          .ops = &tegra234_cpufreq_ops,
>          .actmon_cntr_base = 0x9000,
>          .maxcpus_per_cluster = 4,
> @@ -430,7 +430,7 @@ static struct tegra_cpufreq_ops tegra194_cpufreq_ops = {
>          .set_cpu_ndiv = tegra194_set_cpu_ndiv,
>   };
> 
> -const struct tegra_cpufreq_soc tegra194_cpufreq_soc = {
> +static const struct tegra_cpufreq_soc tegra194_cpufreq_soc = {
>          .ops = &tegra194_cpufreq_ops,
>          .maxcpus_per_cluster = 2,
>   };
> --
> 2.31.1.272.g89b43f80a514
> 
