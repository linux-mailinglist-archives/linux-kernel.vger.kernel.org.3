Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F26578F32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiGSAXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiGSAX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:23:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CC9371BD;
        Mon, 18 Jul 2022 17:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPwaPJv5foHDpmqcI04dUJtS2XbzYCIBePLTdGAq/Rw87KIX939kip2c45oHTh+pV91jqQDCt7eADB4Y7EPfjnP35ma6bPUTq61ebjuDnhzoToUEtwRvHMKCCL6Qnq4X20B0/KsoCZc32B99B0YAm17iTX1D0xV+ICV/J0gcxS/YcEghc2BvQPQBuUVytw2qAqDzchzoZzb4swjn+5Iuv+8ArLzxE0vZ+OLJT1LFBLPx2lpiw8D+PzQh9NY45qpUAI77RypU3kSB0qeU1NVQ3VEVMwcAVDJm4XKVkzts0tVR2Vc0vvPV2QX9bGKWMp/MiMaQPu9C3a2JUVpWEzIHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WapaohomjbtDkxIXtupnSrSOt0oCeV+bUJRvsELcuFw=;
 b=Z90A+gvJivirEPm+ZONWymaL8LNPHmbyfBTJfC2fbYxTAWOE/DR92b3P66HsgBdABRwahfp0eQ6ECOKObzogMAerC7AKFRbofqhquX1xzwg+z545gcgH6pDRWvKolo+Vkyaq0G9sryX/UVHQgZmFCdZ7fyUiQRbKS5+1uumayV9g6L5T+YFgmmWqUTqCBn9HDlb3f+w8zotqQEp29kN1bv17Xr/11RYYIxFvDy6WFq8ttwgIHQ74sGxzBlwzysEeRG3yL0XO42D4cm2NNBVPdnl6mIKoP0RLribznPchwvrUnyK/+8uU7V1JNLv7G8VBk/AXRaCLI/nLyamlUpzqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WapaohomjbtDkxIXtupnSrSOt0oCeV+bUJRvsELcuFw=;
 b=jHePeS1VY7VhC02snL7Tgn7fUleZ3gwUb4gi2pVMh9XQYH4C41YqLv7gzk2zSCp6ZN+XOZ7eYnPdOxaE9HSUcA+OQ/txZwpg7DhULWB4HUqBYaQbuAaxRZ34SIhoX4Goi8n3w7CWqUo0SOxySKScB68B7bGgh2khVcx44XapXlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN7PR12MB2755.namprd12.prod.outlook.com (2603:10b6:408:32::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Tue, 19 Jul 2022 00:23:24 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 00:23:23 +0000
Date:   Tue, 19 Jul 2022 08:22:59 +0800
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
Subject: Re: [PATCH V1 3/4] selftests: amd-pstate: Trigger gitsource
 benchmark and test cpus
Message-ID: <YtX5Y2jnVCf0uW1+@amd.com>
References: <20220706073622.672135-1-li.meng@amd.com>
 <20220706073622.672135-4-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706073622.672135-4-li.meng@amd.com>
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d973f335-dc1d-4a94-d252-08da691ce40d
X-MS-TrafficTypeDiagnostic: BN7PR12MB2755:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Q5ZY1wg5xwbb11WfKOZSWr3UW6N5zMa2loiv++vyn3ZhFJNJYr9UtA2z+GgB1hW7dpU/e200j3DZgwcI0zSPx/q4+xO2GFWUygo/W/o56ME/m9uzChBCyNlUer5QRSSQSm5z4ugVEDKOuAu8GdW4Ptv8NMEeZ4GGBoEXqBjVrlEeCH3JSGeFfBHNlz7YnueWZrk6w1YGcbMHKO/wyETXeoCf8wtkg8zG37dYBB79t4cvsMqrVDB/GwbFjv/5/XZ5dZnadyPXeH+f2qCbL49E9YeAZxhBlEFhXPrld58JJXX3J/qa1zcE5gj97tjCAnr5dI9k3KE0dNXPQcmFWBczkztwavGJe8HDNUXskB4R+aJecfp7dicJ4eBZy4MornFnbIxfeMGl8Y62t12HsZOupWOYk3er3Ni6rJfQlYdCS03DP3WGDf5Au47ZW7jx98QepkR0Y4CjUiDMrB6ao5VGqzaai7q6BTDUs1fGKWXLU3lDEon8vZLT2XJWTSyuuEi/wCpRevkENeWE34W7JPneTnThwsfR64ATVX2nsv+4bzcCO5h6NX+m9NwaY2RU81cRKKuC+fp+256vmOVJchHR+ysjDLfnsqVh9/Vy9mFPln5tBB9z0BjyHF2DLKis0f/HD++pSz8tbgkQnqN/IdjcnML1uxVrZz7fpjO0aYjv+Nrev+Bv5bv83YxWbX+oWw3d2xEBe0/ik09b+ibiVrMvGFWtCQV/Q2tSZDahrojuWt1m+cVxDVTL/ryhRCVNxV4NosoAAl5zSKBtDnHksJnTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(6862004)(478600001)(8936002)(66476007)(66946007)(4326008)(86362001)(66556008)(8676002)(6636002)(316002)(37006003)(54906003)(5660300002)(6486002)(36756003)(30864003)(6506007)(2906002)(26005)(6512007)(41300700001)(6666004)(38100700002)(186003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b1XhBlR3wk6pqVqBX6QWdUebelnNUeGjhH1tHSpG6/U6yL8/P2y4YV+H0ud6?=
 =?us-ascii?Q?XgrZdvzviFx7HetVo9eaZWA/IMEuGTIWjRfgRieYYS2Fvtxc2BWoWXIP9zTP?=
 =?us-ascii?Q?+zQOs2Y4f3wv6etz9eQ70ov4DB8chyYRMPWdBnJ17Pk0uxv0mNCn+iY4lHM0?=
 =?us-ascii?Q?5mDg/NH/C2fpch/j5pMcQIcAQ0LIjg+Ds8T2VBk1Whh+rfrAcOcghswN9LKs?=
 =?us-ascii?Q?PvWvOVVfaRdrSrAxMpcQy4Q8E+BtvHp128W3uDXQssL8FYUFYvrWqX87KReJ?=
 =?us-ascii?Q?IAMkB26KjR4PmZRw8hone25aaZeQzFO9BZ/kET1J4/PFloH1DSpnV6xl8wYt?=
 =?us-ascii?Q?ILWDP+MEXSmhWSaln0/00rP0CeYK1Must9t8pkJgbxr85sdBN3aKWkBb+AGT?=
 =?us-ascii?Q?YG1UYoPL349PMOlO2MW5K1I6zp8iOOkQIkzS04zq8RneoRxPv2oiSETRp9JC?=
 =?us-ascii?Q?BXQYZF1avUMipUryAn9O+dBszhuL2Pe99BkBWKdJ0ae1ylm6zjC4kZwpxUfV?=
 =?us-ascii?Q?PcmxZA9TxDzL6KIbIg0c8z1AicCGs0bQqs3V2NGEEukQgfouCNDOnBozbskO?=
 =?us-ascii?Q?HvK1SVt3qc0Nde92EZGfrHrWj6d33ghX64pJpOx4Q3XDB8zoXFgSGu/MHIVK?=
 =?us-ascii?Q?UPXRAEbddAqukxb76u/v2efci9mx7McbH5uX0WoWZW+QEfP39/+BP1uJ9mgi?=
 =?us-ascii?Q?vlUidGqdqWYRydtHkXODFD1fzvVOc2VcWlH6RJVoIkd1y30rUasa+tDGaqX/?=
 =?us-ascii?Q?NLmcs034SpdvxQ9jVTC4i8v0UZ7VCLNaMhslB7Mfd1dSqpTOXB5yDH5GaytB?=
 =?us-ascii?Q?nxj45xq+qoQxrsZH6xMgr8piZqzLsNo8QddeprCpM3frwrWG5Gfe/BYOeLNX?=
 =?us-ascii?Q?ER7pqsDdBMtzvIeusWSRhIOUfrkJmMoz2cyT1EZOJzNDy44Pdspfj+Lxhnmc?=
 =?us-ascii?Q?Wz77yV8fnLUSiz1nTY6ySMZU3sTOvYhPg7nDeiFapprXRRUOmxGyCEvTpqjM?=
 =?us-ascii?Q?0KYw1uQ5hZ6WL3Gzd3/kqgVWixo7K4GgOS+XmNARVTb1bVB5XIr1ZmwNR0qj?=
 =?us-ascii?Q?MWFi/0qpBTt44ntyyTTBDuT9NvU8/3RuwmQZiUQfymobTWm2ugpFWPUub0jW?=
 =?us-ascii?Q?DDmoab7M1qIKw4GlmTuYBmdHwAGqnvIZqFpyPsOESGViqk4Y+U3rnGimFBzM?=
 =?us-ascii?Q?WL7iFDkqNCMxCfFKKdH9qkE9nXVqBIbsMBWMMRSITHnqqM3ObadkTb2M1qmp?=
 =?us-ascii?Q?bSZhE2vKQYOcmV6HX2EgY9IzX1gE0PUle/e4FrTo4JiiW0cqbLAHYuaA3oAc?=
 =?us-ascii?Q?qkMe9SxebmD+st9kwYKQMF9v8mU7pgms8mG9/TdjCERQWwwwbjMIy3ecZY2+?=
 =?us-ascii?Q?Iu7KcfFj3fJeEfD2Xipzg9LyF6+dgZvkxxOrgHLxe4nWJRKY8SZtqozwls7S?=
 =?us-ascii?Q?tqx4bAG58qmYvrhhpHgAQnwIU8Go9HG7Trf6hZXjgOq9vztG5Imyx9KW8/Td?=
 =?us-ascii?Q?xYBzHHYPrj1qOOE1Zh4bRrh/f7e551LA2cZvQpTOLx/Nj+ElZW6Zqr7zLQ72?=
 =?us-ascii?Q?H673QMjnQ0xsgFeStOurkRk5+2avCYVZo0dBtTU9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d973f335-dc1d-4a94-d252-08da691ce40d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 00:23:23.5270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gS7ioB80O0FG9LXkJLo04kDBcwXtxR2i1EqSbMm+FGE2ykvkXcJwfQghRLEHeQJpSvHy9EhJdqcuqXOiU33UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2755
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:36:21PM +0800, Meng, Li (Jassmine) wrote:
> Add gitsource.sh trigger the gitsource testing and monitor the cpu desire
> performance, frequency, load, power consumption and throughput etc.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  tools/testing/selftests/amd-pstate/Makefile   |   2 +-
>  .../testing/selftests/amd-pstate/gitsource.sh | 176 ++++++++++++++++++
>  tools/testing/selftests/amd-pstate/main.sh    |  21 ++-
>  3 files changed, 195 insertions(+), 4 deletions(-)
>  create mode 100755 tools/testing/selftests/amd-pstate/gitsource.sh
> 
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index e2fb03381a32..c536b9303858 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -13,6 +13,6 @@ TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
>  endif
>  
>  TEST_PROGS := run.sh
> -TEST_FILES := main.sh basic.sh tbench.sh
> +TEST_FILES := main.sh basic.sh tbench.sh gitsource.sh
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
> new file mode 100755
> index 000000000000..0631a4839f5d
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/gitsource.sh
> @@ -0,0 +1,176 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Testing and monitor the cpu frequency and performance when
> +# this script trigger gitsource test.
> +
> +# protect against multiple inclusion
> +if [ $FILE_GITSOURCE ]; then
> +	return 0
> +else
> +	FILE_GITSOURCE=DONE
> +fi
> +
> +git_name="git-2.15.1"
> +git_tar="$git_name.tar.gz"
> +gitsource_url="https://github.com/git/git/archive/refs/tags/v2.15.1.tar.gz"
> +gitsource_governors=("ondemand" "schedutil")
> +
> +# $1: governor, $2: round, $3: des-perf, $4: freq, $5: load, $6: time $7: energy, $8: PPW
> +store_csv_gitsource()
> +{
> +	echo "$1, $2, $3, $4, $5, $6, $7, $8" | tee -a $OUTFILE_GIT.csv > /dev/null 2>&1
> +}
> +
> +empty_line_csv_gitsource()
> +{
> +	echo "" | tee -a $OUTFILE_GIT.csv > /dev/null 2>&1
> +}
> +
> +pre_clear_gitsource()
> +{
> +	rm -rf results/tracer-gitsource*
> +}
> +
> +post_clear_gitsource()
> +{
> +	rm -rf results/tracer-gitsource*
> +	rm -rf $OUTFILE_GIT*.log
> +}
> +
> +install_gitsource()
> +{
> +	if [ ! -d $git_name ]; then
> +		printf "Download gitsource, please wait a moment ...\n\n"
> +		wget -O $git_tar $gitsource_url > /dev/null 2>&1
> +
> +		printf "Tar gitsource ...\n\n"
> +		tar -xzf $git_tar
> +	fi
> +}
> +
> +# $1: governor, $2: loop
> +run_gitsource()
> +{
> +	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
> +	./amd_pstate_trace.py -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1
> +
> +	printf "Make and test gitsource for $1 #$2 make_cpus: $MAKE_CPUS\n"
> +	cd $git_name
> +	./../perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o ../$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > ../$OUTFILE_GIT-perf-$1-$2.log 2>&1
> +	cd ..
> +
> +	for job in `jobs -p`
> +	do
> +		echo "Waiting for job id $job"
> +		wait $job
> +	done
> +}
> +
> +# $1: governor, $2: loop
> +parse_gitsource()
> +{
> +	awk '{print $5}' results/tracer-gitsource-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_GIT-des-perf-$1-$2.log
> +	avg_des_perf=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_GIT-des-perf-$1-$2.log)
> +	printf "Gitsource-$1-#$2 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_GIT.result
> +
> +	awk '{print $7}' results/tracer-gitsource-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_GIT-freq-$1-$2.log
> +	avg_freq=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_GIT-freq-$1-$2.log)
> +	printf "Gitsource-$1-#$2 avg freq: $avg_freq\n" | tee -a $OUTFILE_GIT.result
> +
> +	awk '{print $11}' results/tracer-gitsource-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_GIT-load-$1-$2.log
> +	avg_load=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_GIT-load-$1-$2.log)
> +	printf "Gitsource-$1-#$2 avg load: $avg_load\n" | tee -a $OUTFILE_GIT.result
> +
> +	grep user $OUTFILE_GIT.time-gitsource-$1-$2.log | awk '{print $1}' | sed -e 's/user//' > $OUTFILE_GIT-time-$1-$2.log
> +	time_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-time-$1-$2.log)
> +	printf "Gitsource-$1-#$2 user time(s): $time_sum\n" | tee -a $OUTFILE_GIT.result
> +
> +	grep Joules $OUTFILE_GIT-perf-$1-$2.log | awk '{print $4}' > $OUTFILE_GIT-energy-$1-$2.log
> +	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-energy-$1-$2.log)
> +	printf "Gitsource-$1-#$2 power consumption(J): $en_sum\n" | tee -a $OUTFILE_GIT.result
> +
> +	ppw=`echo "scale=4;$time_sum/$en_sum" | bc | awk '{printf "%.4f", $0}'`
> +	printf "Gitsource-$1-#$2 PPW(s/J): $ppw\n" | tee -a $OUTFILE_GIT.result
> +	printf "\n" | tee -a $OUTFILE_GIT.result
> +
> +	store_csv_gitsource $1 $2 $avg_des_perf $avg_freq $avg_load $time_sum $en_sum $ppw
> +}
> +
> +# $1: governor:w
> +
> +loop_gitsource()
> +{
> +	printf "\nGitsource total test times is $LOOP_TIMES for $1\n\n"
> +	for i in `seq 1 $LOOP_TIMES`
> +	do
> +		run_gitsource $1 $i
> +		parse_gitsource $1 $i
> +	done
> +}
> +
> +# $1: governor
> +gather_gitsource()
> +{
> +	printf "Gitsource test result for $1 (loops:$LOOP_TIMES)" | tee -a $OUTFILE_GIT.result
> +	printf "\n--------------------------------------------------\n" | tee -a $OUTFILE_GIT.result
> +
> +	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "avg des perf:" | awk '{print $NF}' > $OUTFILE_GIT-des-perf-$1.log
> +	avg_des_perf=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-des-perf-$1.log)
> +	printf "Gitsource-$1 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_GIT.result
> +
> +	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "avg freq:" | awk '{print $NF}' > $OUTFILE_GIT-freq-$1.log
> +	avg_freq=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-freq-$1.log)
> +	printf "Gitsource-$1 avg freq: $avg_freq\n" | tee -a $OUTFILE_GIT.result
> +
> +	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "avg load:" | awk '{print $NF}' > $OUTFILE_GIT-load-$1.log
> +	avg_load=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-load-$1.log)
> +	printf "Gitsource-$1 avg load: $avg_load\n" | tee -a $OUTFILE_GIT.result
> +
> +	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "user time(s):" | awk '{print $NF}' > $OUTFILE_GIT-time-$1.log
> +	time_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-time-$1.log)
> +	printf "Gitsource-$1 total user time(s): $time_sum\n" | tee -a $OUTFILE_GIT.result
> +
> +	avg_time=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-time-$1.log)
> +	printf "Gitsource-$1 avg user times(s): $avg_time\n" | tee -a $OUTFILE_GIT.result
> +
> +	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "power consumption(J):" | awk '{print $NF}' > $OUTFILE_GIT-energy-$1.log
> +	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-energy-$1.log)
> +	printf "Gitsource-$1 total power consumption(J): $en_sum\n" | tee -a $OUTFILE_GIT.result
> +
> +	avg_en=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-energy-$1.log)
> +	printf "Gitsource-$1 avg power consumption(J): $avg_en\n" | tee -a $OUTFILE_GIT.result
> +
> +	ppw=`echo "scale=4;$avg_time/$avg_en" | bc | awk '{printf "%.4f", $0}'`
> +	printf "Gitsource-$1 PPW(s/J): $ppw\n" | tee -a $OUTFILE_GIT.result
> +	printf "\n" | tee -a $OUTFILE_GIT.result

The same commment that last patch, we would better have a decription for
formula to caculate the performance per watt data here.

> +
> +	store_csv_gitsource $1 "Average" $avg_des_perf $avg_freq $avg_load $avg_time $avg_en $ppw
> +	empty_line_csv_gitsource
> +}
> +
> +amd_pstate_gitsource()
> +{
> +	printf "\n---------------------------------------------\n"
> +	printf "*** Running AMD P-state gitsource         ***"
> +	printf "\n---------------------------------------------\n"
> +
> +	pre_clear_gitsource
> +
> +	install_gitsource
> +
> +	store_csv_gitsource "Governor" "Round" "Des-perf" "Freq" "Load" "Time(s)" "Energy(Joules)" "PPW(s/J)"

Clarify the full name of PPW.

> +
> +	for_each_policy backup_governor
> +
> +	for governor in ${gitsource_governors[*]} ; do
> +		printf "\nSpecified governor is $governor\n\n"
> +		for_each_policy switch_governor $governor
> +		loop_gitsource $governor
> +		gather_gitsource $governor
> +	done
> +
> +	restore_governor
> +
> +	post_clear_gitsource
> +}
> diff --git a/tools/testing/selftests/amd-pstate/main.sh b/tools/testing/selftests/amd-pstate/main.sh
> index ae71fe62e3b0..69bf8ea371a5 100755
> --- a/tools/testing/selftests/amd-pstate/main.sh
> +++ b/tools/testing/selftests/amd-pstate/main.sh
> @@ -10,6 +10,7 @@ fi
>  
>  source basic.sh
>  source tbench.sh
> +source gitsource.sh
>  
>  # amd-pstate-ut only run on x86/x86_64 AMD systems.
>  ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
> @@ -18,6 +19,7 @@ VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
>  FUNC=all
>  OUTFILE=selftest
>  OUTFILE_TBENCH="$OUTFILE.tbench"
> +OUTFILE_GIT="$OUTFILE.gitsource"
>  
>  SYSFS=
>  CPUROOT=
> @@ -126,6 +128,9 @@ amd_pstate_all()
>  
>  	# tbench
>  	amd_pstate_tbench
> +
> +	# gitsource
> +	amd_pstate_gitsource
>  }
>  
>  helpme()
> @@ -135,7 +140,8 @@ helpme()
>  	[-o <output-file-for-dump>]
>  	[-c <all: All testing,
>  	     basic: Basic testing,
> -	     tbench: Tbench testing.>]
> +	     tbench: Tbench testing,
> +	     gitsource: Gitsource testing.>]
>  	[-t <tbench time limit>]
>  	[-p <tbench process number>]
>  	[-l <loop times for tbench]

Can we add an option to draw the chart of each times of performance and
energy/power data? It's absolutely better than raw table.

Thanks,
Ray

> @@ -153,7 +159,7 @@ parse_arguments()
>  				helpme
>  				;;
>  
> -			c) # --func_type (Function to perform: basic, tbench (default: all))
> +			c) # --func_type (Function to perform: basic, tbench, gitsource (default: all))
>  				FUNC=$OPTARG
>  				;;
>  
> @@ -169,7 +175,7 @@ parse_arguments()
>  				PROCESS_NUM=$OPTARG
>  				;;
>  
> -			l) # --tbench-loop-times
> +			l) # --tbench/gitsource-loop-times
>  				LOOP_TIMES=$OPTARG
>  				;;
>  
> @@ -259,6 +265,10 @@ do_test()
>  		amd_pstate_tbench
>  		;;
>  
> +		"gitsource")
> +		amd_pstate_gitsource
> +		;;
> +
>  		*)
>  		echo "Invalid [-f] function type"
>  		helpme
> @@ -283,6 +293,11 @@ pre_clear_dumps()
>  		rm -rf $OUTFILE_TBENCH*
>  		;;
>  
> +		"gitsource")
> +		rm -rf $OUTFILE.log
> +		rm -rf $OUTFILE.backup_governor.log
> +		rm -rf $OUTFILE_GIT*
> +		;;
>  	esac
>  }
>  
> -- 
> 2.25.1
> 
