Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E125B1202
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiIHBTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiIHBTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:19:04 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC3C6E81;
        Wed,  7 Sep 2022 18:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KudICnE6s9dH4Qq+PT3TZy0FvT8LG+aSOUjHvZ1dLF2oJtTpSbEtJV2qKCiRRQnSsjU5vBjDkpz7xc6hjmk9uAu7bskM/yHIT2ODw3P/G54zcs2V09nZsuOzmKMlzhkhtgOcwYYp6qlM91BEUzAxUZMtBzxsptq8HNkFsBOfM0+alEbTrLoM3Uwx8xiC4Ws7JyuXR6GNLXI32gUE4YNifvygaG24BG8tLyrwO0Y+seF4TSZVk5wQlY9MNRzwVFgfKvPwTgE/C5h+7vsRKmlsFnJJkAOm9TSixWmDzJywyF4ZwW1BDfkP8gnMrWvdaNANFMLKLQzKSxHoXtZXMFijIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enUXsuUhrE/rBGpll2oqZpboG7EgCeZ2xmjzV2JlB10=;
 b=OLOVBHId6yhV9+X27pqbkAOG6iOsdawf+vrwJ8JQHfu//4XXtgxzbEBYNYUzkOEiuPNcqexVJs/dEiQsGBbozWNMzPL4b8XUE5dqj/MB5z+jC0tV2nMGY65JquYmmXXKBlGkOIU3Evfcjl3oJ50mVeSx3qgvWgxqdjv605FfB6QFZdTncu7yBYAROrYo9fhZfeBPwzoRQCw0b9GOkjSVoqv3S7jnyWOK8S/F2kfuMTYoiAfmPVlflxv8xymLGZJ4TcQ5iMi2949hOiZbh7DSHWDST3rmEzUD4wwq8o/eao6dIpWBqJYMItpPxnaou0Fy/pmk7M9Rr3lVJlW/CifN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enUXsuUhrE/rBGpll2oqZpboG7EgCeZ2xmjzV2JlB10=;
 b=UgEM0fUlzVvzz91rRhUYqdkRb/DCqbByXIW4L+NCL6lK+83eYRAYRzMauy3q87O1AxISgewyLlzaGJ9q9MGFI/94i5xrdMFu54B9NXf7kuL6eM8pSSuqIv07Lkvrl41bmvQjD1hdMqu5hBMnV+DZoqDuYhgp4lsHjLtdWbPcCMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Thu, 8 Sep
 2022 01:18:57 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::cfb:b63:3255:646c]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::cfb:b63:3255:646c%5]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 01:18:57 +0000
Date:   Thu, 8 Sep 2022 09:18:32 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] cpufreq: amd-pstate: Add explanation for
 X86_AMD_PSTATE_UT
Message-ID: <YxlC6F8NVeY1Gv27@amd.com>
References: <20220908002821.1648880-1-li.meng@amd.com>
 <20220908002821.1648880-2-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908002821.1648880-2-li.meng@amd.com>
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28f86d69-ae2a-4ff4-e28d-08da91381a82
X-MS-TrafficTypeDiagnostic: SN7PR12MB7154:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MECkzI4IOo5zWMzfRcQDui01VLvc0uq8OAf6ciX0rK8AW+WSkosNkZ/Qr7DxdLMTlETZLSLZ37A+LUU5RP9J0cMtIinEmuBSFS4triFmWamxuC8Xeld7PJIF/kE/bHbGC5n3/kycZ/JcwDiYBFK6/urXQYhXS9w8FfrwIRME37SkuIG4HQbTj291Xtugcc00a17GkyGg4BZ9ghN3BSwUnpI6W2NkoC7m7J6QQeTQMMzmpXurIIOyyNvL761H40cGDurqQEZTzB13/94l4A1EfHG+RfRSJX6KJ++Mm6fkfg+V5pE5GCQ70/4O/2bt3dtTqJnhuhxC9VJ7cYyliysYepHUeqsGMamaBl06UTSn6nFSSe8oLoufR655NuuHzOE8tgDtrHzGef3dxr5egP9v4GnHPFd42Q18B2NxYpT3IeIyVdYN6RjvrOgHtlMgbt2Meik77JrZ4MuoMOdZZWuwctohnmEAzVmHMOj+Tl76a7/Q8LHc5K1mD/A1ST+OqTLq2kQ7NqMXFcjSl4sjCyqyp2GqAq4XtdM/AerpRjQ/L4/kCPx2QCvaHVe4PDoUSibsbUdNTrQ4SNHwXR4jTGmnqzg4quIMx6t5a/i5I+CMjJMniOa6s+p3L5VZeGEoRMAZhcwVrpsUQKU+bFHdFPJ1o+d4tLxpGj4XitnGEJgcJA3uQtHnubZl0L8zT/2flDtcGRaaMVAyffL7520SBzvlbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(6862004)(2906002)(66946007)(66476007)(8676002)(66556008)(37006003)(4326008)(6636002)(86362001)(36756003)(54906003)(8936002)(316002)(6512007)(38100700002)(6666004)(41300700001)(5660300002)(2616005)(26005)(6506007)(186003)(478600001)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2RZaE/A4DmvS2J1PHCfmGifdSGLZjYc4wyrFU6pxET2FnCtFDmjo3d0NQx+X?=
 =?us-ascii?Q?uPs2UVjGdr5iIbW5A/5/Br8WKo8KJheoWrtMiSiN5sNmfG62j3XzlkfG2puE?=
 =?us-ascii?Q?Mb2+Ga71oB47Q/8tQlW2Ki8iIb55WJhT2O4QPFRrT6MTkI8K+POY11/4DowI?=
 =?us-ascii?Q?CeEzrOTXw9+g0s+YY9mdUb6Uz236WxfRKBEOYLx+Pi+YhMg6BipS4uxLVcr+?=
 =?us-ascii?Q?8R/aOrhnstvsZwl5tMNzV3tddlJwmYMKA5ru2QX5zbREaxnavSRbrBK7PoiF?=
 =?us-ascii?Q?pgBbXBY52+fLNudZBfI723oKUDBvCYDP4VMZdgJshqpYaSBmYtAKo+ddHh2g?=
 =?us-ascii?Q?yPvk68pcraYS5ZEoaTjW4GNd6ALUdtSw5tFK6MK+gPYBhatlw+dcnMjLEaEd?=
 =?us-ascii?Q?n/Yh/6L9/z+s0z6lbGSIyUmRCeVV96iDaEEn6eybExt13A3sZEnfPJevnSoi?=
 =?us-ascii?Q?v0APy9s9ajAtvs+1h0pxABsbIHcwbyUrxeO3JGJtKFHYbI7KYjxGgirpbX1D?=
 =?us-ascii?Q?STp7fF/Ue4VIZ5IzJCDcqorwbwKkuRa5yTmylyykAywY1/dba+CXV9Lk6+Jr?=
 =?us-ascii?Q?zTAU/3TI/WbcmFkLMryXN2rqG/RNiN9btvSttAsiEGZPABHwIT0Kdd9qyN7k?=
 =?us-ascii?Q?JSV583R938orBJ3n9yfWfVVrtbvcp3tA6J3VfPbfbswYedYvCVwEbFbIHAlD?=
 =?us-ascii?Q?mfTur8at/ihw61dali1GieMdVo84EYAIBdK5LjXkDskAT79xPUXlTB45UnMn?=
 =?us-ascii?Q?QSJdp8CBROIE88A7XiNsUAOu4LtaV/xPQhViftDTkpXJzqWjy0NZ98E2c06D?=
 =?us-ascii?Q?3/d+KfAzqf0SmLGfwOGjfxvsQ5xB2bb4c4/ynr5FDGDeUaUs5EoA6gAznB+H?=
 =?us-ascii?Q?kQLLyZUxNWIxKoqwo2BEjv19bMnB4AE3NbqEHMrW/3f/C54LwHYp8ielkOra?=
 =?us-ascii?Q?239XZafGaEI4s77S1l21FnERFLbdCwJa4+0o4vSbPdrQVARh9huJf8XPfOOz?=
 =?us-ascii?Q?r3IMx7oyC+BI0AgHUQW0iFzvh3s40stiv9KqAqEbFG1j790j9RNYielIxTB5?=
 =?us-ascii?Q?FF3vB4B93MAp4YJHnk7XP7axMpJDuEydIivdAH1qN0e8+MFLwwlPSge1PMYC?=
 =?us-ascii?Q?+sf+csasiFXb1kPx7XPf32cvKA1ufe1S/i5Qqhqf853P4HiI/mgSF5d0jFw3?=
 =?us-ascii?Q?fPTUimZfJtXu0QtzgsFrG8xJeMcOPdK8EgWCa4lT9MmzKokHP30IAghWql6o?=
 =?us-ascii?Q?YQdy2LzvB3wpf/OAygl3YT2luruDWkxC/QoBS1pyhYQPmr5GWnYMYihh5JHh?=
 =?us-ascii?Q?AN2ecmvkktSfbv7xAOiW59otKj7Rfsoj7b3wroAKZI8lylZpfxjJufm5tpi3?=
 =?us-ascii?Q?XWHwu/mNmIfCTlKSLq1kr6qKu09y4rIxS9Axnm/2LMh+yZh/lJ80ISp/wzbq?=
 =?us-ascii?Q?Fz9n1R7e+8v9qw3CXe8HLWYw9x/hNXH98BNbOzX+XPgjjKsyws82W1tQGCZh?=
 =?us-ascii?Q?Bj7CWM1JgdAQOdZblxARymetmie7f3ltAidlGE1zTcDZvFzaH96uMcLZE6ye?=
 =?us-ascii?Q?m4yRt1aNmReZkbr1e95BnVQzP4oGYe3DkCqrQLVx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f86d69-ae2a-4ff4-e28d-08da91381a82
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 01:18:57.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7b65kxLAZ/nHBFIc/msKVe3CarnAZolvgS9QE92JKCGZmEjy3r1xvbpDVhBqU1Lc6u9g56p4o4Xrbpg3aR2nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 08:28:21AM +0800, Meng, Li (Jassmine) wrote:
> This kernel module is used for testing. It's safe to say M here.
> It can also be built-in without X86_AMD_PSTATE enabled.
> Currently, only tests for amd-pstate are supported. If X86_AMD_PSTATE
> is set disabled, it can tell the users test can only run on amd-pstate
> driver, please set X86_AMD_PSTATE enabled.
> In the future, comparison tests will be added. It can set amd-pstate
> disabled and set acpi-cpufreq enabled to run test cases, then compare
> the test results.
> 
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Meng Li <li.meng@amd.com>

Patch looks very good for me. Please feel free to add

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/Kconfig.x86                         | 8 ++++++++
>  tools/testing/selftests/amd-pstate/amd-pstate-ut.sh | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index fdd819069d72..310779b07daf 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -58,6 +58,14 @@ config X86_AMD_PSTATE_UT
>  	help
>  	  This kernel module is used for testing. It's safe to say M here.
>  
> +	  It can also be built-in without X86_AMD_PSTATE enabled.
> +	  Currently, only tests for amd-pstate are supported. If X86_AMD_PSTATE
> +	  is set disabled, it can tell the users test can only run on amd-pstate
> +	  driver, please set X86_AMD_PSTATE enabled.
> +	  In the future, comparison tests will be added. It can set amd-pstate
> +	  disabled and set acpi-cpufreq enabled to run test cases, then compare
> +	  the test results.
> +
>  config X86_ACPI_CPUFREQ
>  	tristate "ACPI Processor P-States driver"
>  	depends on ACPI_PROCESSOR
> diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> index 273364650285..f8e82d91ffcf 100755
> --- a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> +++ b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> @@ -32,6 +32,7 @@ fi
>  scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
>  if [ "$scaling_driver" != "amd-pstate" ]; then
>  	echo "$0 # Skipped: Test can only run on amd-pstate driver."
> +	echo "$0 # Please set X86_AMD_PSTATE enabled."
>  	echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
>  	exit $ksft_skip
>  fi
> -- 
> 2.34.1
> 
