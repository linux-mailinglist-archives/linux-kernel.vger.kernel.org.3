Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D572578F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiGSAPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbiGSAPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:15:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1980D90;
        Mon, 18 Jul 2022 17:15:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdvY6BgzWreBDsWNgOVKxIoygMXD0oavmmhn4aQ+wDrFR5L6GL77n6GpU0UuO7h9Zeclk4Um7nR9wS3anuQ4LepnZbRhhm5rm3u9Ap5d3sO1deWFmloOx5/mWbqNaBvCya2TVB6QUgL4m4F3xPQTUFgUAFLGrTvoMOITXqzA4rwVG2mt2N+lDda2lXuQHWAL46ju1CSDb/c38J7HXUeaiRT7lyNqtC8jB0Cb6Jou7w98VQcVX3Nwu0zZn5QgmLTH57hJVbxf/ihNIxibwSaRntS7YJ7Yd2p764q92syy3YNv2KNM1zLChWoP+6xN1AGW0BliMSFsQLya/FqqVMOIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOQRYzu8ifpEcLgJ8QpjcKo4gsf+ysebYvkl+gMwcz0=;
 b=EjVOocug0FZEC8Gy7j8ipSHau8snCSW1G/e0NCrsr79bYGf4P2Gft/4nmp/PPMXoBgyq6o0G6CG9vOO3VIzRxEYQzpE+079xt5e6xkshkA/gf7X26xjlSeh2IhdeM4V5GZ6UalDgm6e5HgMnKiIXzt6o8rETHZQd9PutmCQwvvRykVxrwhdbGStHMCAVDYQzLGkngiQxCtlLvLaqwtGfMyKWy/zH7bUWLlYr1+V4VlgVEDkqTcSktX7Nfj6rWKKegjm7Rr/cqDq/h3aJ5BRQ+QWum4+98HPJ/X62LHkPRGaHKJPYa0qhF+F8CRnLNSP2bIJQpu3vZDg1MRP9nApc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOQRYzu8ifpEcLgJ8QpjcKo4gsf+ysebYvkl+gMwcz0=;
 b=2qVPyrAUGb3Aq3RjrBvr1FFrOSszj7lQxnsi3rlTnGR1FAIwJm32tMShpo73Q0UihE+BsAmZZzYisYfTknTl7w/9sWiu72Lb6gSM9WCG9wRt/vXh1h23VSeZv5b1HVMmrA+bJbM3ypiujDX2Y/rfktxjwMPNl7dvajYMmmp9mW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SN1PR12MB2464.namprd12.prod.outlook.com (2603:10b6:802:24::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.21; Tue, 19 Jul 2022 00:15:30 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 00:15:30 +0000
Date:   Tue, 19 Jul 2022 08:15:06 +0800
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
Subject: Re: [PATCH V1 2/4] selftests: amd-pstate: Trigger tbench benchmark
 and test cpus
Message-ID: <YtX3irO1Vf+I20S2@amd.com>
References: <20220706073622.672135-1-li.meng@amd.com>
 <20220706073622.672135-3-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706073622.672135-3-li.meng@amd.com>
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13554b3e-b2ce-41f7-9acf-08da691bc9e3
X-MS-TrafficTypeDiagnostic: SN1PR12MB2464:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SeTv5JKaSD5Q3jmkePLZ2I/Cwq7l9dIZ67rS29TboM7yQ5Ts3wBQz04NAw9uH+IXTOkajQFu9CG8VvHD7Z+OyzD5MeqT4raXRaW6PMYzC3v7RCx7HB9oXgWel2dt6rQjT8CquSV5wxy7NpIQUVp4BqZpjlfvSO2wO6E1DMMzy15KxPajkFQPFSP0EDhFzOxN8bAhFG8C3TQ3N+N3Nx7F41lvKdjXcUEPwJqhOvJisDdEt2ow7XIcMsO5OSr6PUnY0a/LSuc23N4jJXBFCPjdsgJBHvJmLWsw7keCrC0aj3U29SOdSRWfN4QIqV8ib9isLPtYk4wZfQAXAFQ31rY3ux9Bp11sh9phIovxs+1kUXRoutjmkfVzgRHfeTU2x/vxA3wAk1zRRW/2L1ZNyJjlyKkD0f657p/Bpso+fkZqB9UHo/MbyPl7OizMB4ZfIZdgM4hhMmQzPEbOq2AfLu+TdLCGXXeIZLPS6C6bpZHxzqqvCN6GQPSfOfarAE8X1qYWDeWbVn3GJtBxshpSgqdfrVYm+8y/9//TvQaozoSE8BRyy4E0skRU4mfmcP25Ld3dzevcItfm4/xQ9ESa7jKepx87gZeB6Z3ZPamoO2XrIybOye6baBmxwVEsQMT3YeYzXeIid2Qr0Mk0Aik+bItyq+MTPAYhI6juAGidDTpHM1c2H/SjRWet6uR48XRWk9A/8yIYsbmVAzD6cTQy/0dxD76+1srzTJwX++R+Cc756k3h0yENqYa28PdOthPr8qUh6/degokBWb08F8z7v+gFO5yvaQDnsPWmnb57SJxP5rLt4sDFrAMslivaaBH5ZDI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(83380400001)(6512007)(30864003)(26005)(66476007)(186003)(2906002)(6666004)(41300700001)(478600001)(6506007)(86362001)(6486002)(5660300002)(2616005)(8936002)(6862004)(38100700002)(6636002)(54906003)(316002)(37006003)(66946007)(8676002)(4326008)(36756003)(66556008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZNcA/dow4ZO519Y8DezSfDI1d2TVKh60Rc+MVDE/T+OUjj/Ev962NrmyL9YE?=
 =?us-ascii?Q?FzwRy6SfxMZsbMf970tWkaeOc7Tq4DxAs8TQ7lKgb1baLsjNKoOTmJIJ4QlL?=
 =?us-ascii?Q?EGDXoRiTj2zwarGENf7bL37sujJHjMdKf10mgotK9Fzj+fHdphOdlsqhAmB3?=
 =?us-ascii?Q?T5jYJg+pt0OSCm7hZ84XSg60/o1stbBmQr++Z9C7rZJDiiMNAigdow0FEHLT?=
 =?us-ascii?Q?aij/XENuzEn4EWx6tdPSUl0sApCNxhSpWXwbBwG0JfIvHg2HHN7oIN4/DhgA?=
 =?us-ascii?Q?8QHDWI8IfvqmMA5+TxMn/pN5l0SLkdB4SJ939PAGoQFcCF9Lqt/jb9lUlU1F?=
 =?us-ascii?Q?DctPVmFmK9ZdfK7wkgnuQHvjxz7CLlyFNARQmS92ufJjiri+Nv55FNW6Ygp1?=
 =?us-ascii?Q?A9V9F3tWdkCFD+aUTqL8vq8CrAAoJg2s3jLEEzBEngd8ieAxQ6HzuuAj4u41?=
 =?us-ascii?Q?/mcOrJJ+n0Oycwb8QbbtMPgd0r6LMElLKasNL7IQZrfqDl19rNHisfpBlnrQ?=
 =?us-ascii?Q?J7RsPmeLmfY5F/z25cyhQ+qq291nn1mqJVpPfypjFWgrLQgCYvEzJfNHjdcz?=
 =?us-ascii?Q?HBv0Q98nTGQM482yb/IBWmNvti/X5hkIWPN8UjtZJAdU3PG/fHtdRiUCNl9j?=
 =?us-ascii?Q?883LV1qHJec7WyqihBNzPlJklnmJFwrlBCJ8DRyezur0Qd38ZXHNx6SFH1EU?=
 =?us-ascii?Q?2zohmFxQ7PTvN0WnykoMZt1PHlN2VzrTAcw5gzwFuBPgc3h9cnzTM9/3z4SB?=
 =?us-ascii?Q?Y/MU+vqzLb2Q0oqpG6pwZs9lMn6K+cueJURRXeWGRwXpnuClIMr4bfjf17iZ?=
 =?us-ascii?Q?zrWqlAy5mm3YytJcg6m0MM5jHQUdfgVH9hJmD/l2XJCI4GkzWba2aJx6PXI0?=
 =?us-ascii?Q?GF6Xo+RUcfrs6Aip1s/PRd3l/BiCFC80eYBCfW03DgRKvFfuilPmH2saJ3VN?=
 =?us-ascii?Q?6sV65kJlzDedNhvsp7PK48d/HDfKgelUUtEKC1O3Bi9sw6trpS/dXXKDSU+9?=
 =?us-ascii?Q?L8ySmt4uvho6RRggyoWimejIC4HYZniK/gZrNbeGRMPtU9hn/uHavNwaS89n?=
 =?us-ascii?Q?x6q5rmRrJ7MmLNR/Pt8M08762TuGOApg8RaodWGbRZ1QakGyqx5kW138GROo?=
 =?us-ascii?Q?qiKtjnZfw5KM6qAupexi/3iUmzqO3o6JXjU0vD5k53DYp/Y4/zuiOqa3tGH+?=
 =?us-ascii?Q?7w2SaQ3dP3BrA9Nfb8ijodrQ2uNlKa+b19Eql3+rRFtCF7J3FjlgFVCy9rZk?=
 =?us-ascii?Q?EENIlCnVAnubATXYLtfRp1CbnBVPUoxslIwHhWqWMqotPST6Qbp7QGWys0o0?=
 =?us-ascii?Q?udBhDQvPmhPyYVFwYtH2wRzcnqzgQes0n3nb+Cu4V/tv2/Pc4Pc5Rsj3o9sW?=
 =?us-ascii?Q?PHSS/+c9+NBylNIYVoTzRN1XxcamXeeC2dXp/w5HD//gT7mLSwsMLi5zE7v3?=
 =?us-ascii?Q?b5i5w4eBCGpRtzyrMLE96hx2W590kSpk2u70urIP7ZzBhDI24Doz+xpstznb?=
 =?us-ascii?Q?71WExwO17VLi864nhmwufL6T3vo/eMQk3/Qgj4jiLZa1yMst+NGqOKqWlGeX?=
 =?us-ascii?Q?ljbGiyPsZ79u45CulO570loFVyBx2VjOrwTzbeKR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13554b3e-b2ce-41f7-9acf-08da691bc9e3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 00:15:30.1641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVWFzR9RzkJjEOb9qDznwW7prqZCt8QUwddm9YXuJillm3cp2p9fbVOkiTNB3u0b8aGU8KTGv55OOdoxl54/Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2464
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:36:20PM +0800, Meng, Li (Jassmine) wrote:
> Add tbench.sh trigger the tbench testing and monitor the cpu desire
> performance, frequency, load, power consumption and throughput etc.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  tools/testing/selftests/amd-pstate/Makefile  |  10 +-
>  tools/testing/selftests/amd-pstate/main.sh   | 168 ++++++++++++++++-
>  tools/testing/selftests/amd-pstate/tbench.sh | 187 +++++++++++++++++++
>  3 files changed, 361 insertions(+), 4 deletions(-)
>  create mode 100755 tools/testing/selftests/amd-pstate/tbench.sh
> 
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index 167ab51ec290..e2fb03381a32 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -4,7 +4,15 @@
>  # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
>  all:
>  
> +uname_M := $(shell uname -m 2>/dev/null || echo not)
> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> +
> +ifeq (x86,$(ARCH))
> +TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> +TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +endif
> +
>  TEST_PROGS := run.sh
> -TEST_FILES := main.sh basic.sh
> +TEST_FILES := main.sh basic.sh tbench.sh
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/amd-pstate/main.sh b/tools/testing/selftests/amd-pstate/main.sh
> index 1c28b5d7b4c5..ae71fe62e3b0 100755
> --- a/tools/testing/selftests/amd-pstate/main.sh
> +++ b/tools/testing/selftests/amd-pstate/main.sh
> @@ -9,6 +9,7 @@ else
>  fi
>  
>  source basic.sh
> +source tbench.sh
>  
>  # amd-pstate-ut only run on x86/x86_64 AMD systems.
>  ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
> @@ -16,10 +17,95 @@ VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
>  
>  FUNC=all
>  OUTFILE=selftest
> +OUTFILE_TBENCH="$OUTFILE.tbench"
> +
> +SYSFS=
> +CPUROOT=
> +CPUFREQROOT=
> +MAKE_CPUS=
> +
> +TIME_LIMIT=100
> +PROCESS_NUM=128
> +LOOP_TIMES=3
> +TRACER_INTERVAL=10
>  
>  # Kselftest framework requirement - SKIP code is 4.
>  ksft_skip=4
>  
> +# Counts CPUs with cpufreq directories
> +count_cpus()
> +{
> +	count=0;
> +
> +	for cpu in `ls $CPUROOT | grep "cpu[0-9].*"`; do
> +		if [ -d $CPUROOT/$cpu/cpufreq ]; then
> +			let count=count+1;
> +		fi
> +	done
> +
> +	echo $count;
> +}
> +
> +# $1: policy
> +find_current_governor()
> +{
> +	cat $CPUFREQROOT/$1/scaling_governor
> +}
> +
> +# $1: policy
> +backup_governor()
> +{
> +	local cur_gov=$(find_current_governor $1)
> +
> +	printf "Governor backup done for $1: $cur_gov\n"
> +	echo "$1 $cur_gov" >> $OUTFILE.backup_governor.log
> +}
> +
> +restore_governor()
> +{
> +	i=0;
> +
> +	policies=$(awk '{print $1}' $OUTFILE.backup_governor.log)
> +	for policy in $policies; do
> +		let i++;
> +		governor=$(sed -n ''$i'p' $OUTFILE.backup_governor.log | awk '{print $2}')
> +
> +		# switch governor
> +		_switch_governor $policy $governor
> +		printf "Governor restored for $policy to $governor\n"
> +	done
> +}
> +
> +# $1: policy, $2: governor
> +_switch_governor()
> +{
> +	echo $2 > $CPUFREQROOT/$1/scaling_governor
> +}
> +
> +for_each_policy()
> +{
> +	policies=$(ls $CPUFREQROOT| grep "policy[0-9].*")
> +	for policy in $policies; do
> +		$@ $policy
> +	done
> +}
> +
> +# $1: governor, $2: policy
> +switch_governor()
> +{
> +	local filepath=$CPUFREQROOT/$2/scaling_available_governors
> +
> +	# Exit if cpu isn't managed by cpufreq core
> +	if [ ! -f $filepath ]; then
> +		return;
> +	fi
> +
> +	# switch governor
> +	_switch_governor $2 $1
> +
> +	printf "Switched governor for $2 to $1\n"
> +}
> +
>  # All amd-pstate tests
>  amd_pstate_all()
>  {
> @@ -27,8 +113,19 @@ amd_pstate_all()
>  	printf "***** Running AMD P-state Sanity Tests  *****\n"
>  	printf "=============================================\n\n"
>  
> +	count=$(count_cpus)
> +	if [ $count = 0 ]; then
> +		printf "No cpu is managed by cpufreq core, exiting\n"
> +		exit;
> +	else
> +		printf "AMD P-state manages: $count CPUs\n"
> +	fi
> +
>  	# unit test for amd-pstate kernel driver
>  	amd_pstate_basic
> +
> +	# tbench
> +	amd_pstate_tbench
>  }
>  
>  helpme()
> @@ -37,21 +134,26 @@ helpme()
>  	[-h <help>]
>  	[-o <output-file-for-dump>]
>  	[-c <all: All testing,
> -	     basic: Basic testing.>]
> +	     basic: Basic testing,
> +	     tbench: Tbench testing.>]
> +	[-t <tbench time limit>]
> +	[-p <tbench process number>]
> +	[-l <loop times for tbench]
> +	[-i <amd tracer interval]
>  	\n"
>  	exit 2
>  }
>  
>  parse_arguments()
>  {
> -	while getopts ho:c: arg
> +	while getopts ho:c:t:p:l:i: arg
>  	do
>  		case $arg in
>  			h) # --help
>  				helpme
>  				;;
>  
> -			c) # --func_type (Function to perform: basic (default: all))
> +			c) # --func_type (Function to perform: basic, tbench (default: all))
>  				FUNC=$OPTARG
>  				;;
>  
> @@ -59,6 +161,21 @@ parse_arguments()
>  				OUTFILE=$OPTARG
>  				;;
>  
> +			t) # --tbench-time-limit
> +				TIME_LIMIT=$OPTARG
> +				;;
> +
> +			p) # --tbench-process-number
> +				PROCESS_NUM=$OPTARG
> +				;;
> +
> +			l) # --tbench-loop-times
> +				LOOP_TIMES=$OPTARG
> +				;;
> +
> +			i) # --amd-tracer-interval
> +				TRACER_INTERVAL=$OPTARG
> +				;;
>  			\?)
>  				helpme
>  				;;
> @@ -91,10 +208,44 @@ prerequisite()
>  		echo $msg please run this as root >&2
>  		exit $ksft_skip
>  	fi
> +
> +	if [ ! -f perf ] ; then
> +		echo $msg please build perf under directory tools/perf and copy it to directory amd-pstate. >&2
> +		exit $ksft_skip
> +	fi
> +
> +	SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
> +
> +	if [ ! -d "$SYSFS" ]; then
> +		echo $msg sysfs is not mounted >&2
> +		exit 2
> +	fi
> +
> +	CPUROOT=$SYSFS/devices/system/cpu
> +	CPUFREQROOT="$CPUROOT/cpufreq"
> +
> +	if ! ls $CPUROOT/cpu* > /dev/null 2>&1; then
> +		echo $msg cpus not available in sysfs >&2
> +		exit 2
> +	fi
> +
> +	if ! ls $CPUROOT/cpufreq > /dev/null 2>&1; then
> +		echo $msg cpufreq directory not available in sysfs >&2
> +		exit 2
> +	fi
>  }
>  
>  do_test()
>  {
> +	# Check if CPUs are managed by cpufreq or not
> +	count=$(count_cpus)
> +	MAKE_CPUS=$((count*2))
> +
> +	if [ $count = 0 ]; then
> +		echo "No cpu is managed by cpufreq core, exiting"
> +		exit 2;
> +	fi
> +
>  	case "$FUNC" in
>  		"all")
>  		amd_pstate_all
> @@ -104,6 +255,10 @@ do_test()
>  		amd_pstate_basic
>  		;;
>  
> +		"tbench")
> +		amd_pstate_tbench
> +		;;
> +
>  		*)
>  		echo "Invalid [-f] function type"
>  		helpme
> @@ -122,10 +277,17 @@ pre_clear_dumps()
>  		"basic")
>  		;;
>  
> +		"tbench")
> +		rm -rf $OUTFILE.log
> +		rm -rf $OUTFILE.backup_governor.log
> +		rm -rf $OUTFILE_TBENCH*
> +		;;
> +
>  	esac
>  }
>  
>  post_clear_dumps()
>  {
>  	rm -rf $OUTFILE.log
> +	rm -rf $OUTFILE.backup_governor.log
>  }
> diff --git a/tools/testing/selftests/amd-pstate/tbench.sh b/tools/testing/selftests/amd-pstate/tbench.sh
> new file mode 100755
> index 000000000000..0320300971ce
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/tbench.sh
> @@ -0,0 +1,187 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Testing and monitor the cpu frequency and performance when
> +# this script trigger tbench test.
> +
> +# protect against multiple inclusion
> +if [ $FILE_TBENCH ]; then
> +	return 0
> +else
> +	FILE_TBENCH=DONE
> +fi
> +
> +tbench_name="dbench-4.0"
> +tbench_tar="$tbench_name.tar.gz"
> +tbench_url="https://ftp.samba.org/pub/pub/tridge/dbench/dbench-4.0.tar.gz"
> +tbench_governors=("ondemand" "schedutil")
> +
> +# $1: governor, $2: round, $3: des-perf, $4: freq, $5: load, $6: performance, $7: energy, $8: PPW
> +store_csv_tbench()
> +{
> +	echo "$1, $2, $3, $4, $5, $6, $7, $8" | tee -a $OUTFILE_TBENCH.csv > /dev/null 2>&1
> +}
> +
> +empty_line_csv_tbench()
> +{
> +	echo "" | tee -a $OUTFILE_TBENCH.csv > /dev/null 2>&1
> +}
> +
> +pre_clear_tbench()
> +{
> +	rm -rf results/tracer-tbench*
> +}
> +
> +post_clear_tbench()
> +{
> +	rm -rf results/tracer-tbench*
> +	rm -rf $OUTFILE_TBENCH*.log
> +}
> +
> +install_tbench()
> +{
> +	if [ ! -d $tbench_name ]; then
> +		printf "Download tbench, please wait a moment ...\n\n"
> +		wget -O $tbench_tar $tbench_url > /dev/null 2>&1
> +
> +		printf "Tar tbench ...\n\n"
> +		tar -xzf $tbench_tar
> +
> +		printf "Compile and install tbench ...\n\n"
> +		cd $tbench_name
> +		./autogen.sh
> +		./configure > /dev/null 2>&1
> +		make > /dev/null 2>&1
> +		make install > /dev/null 2>&1
> +		cd ..
> +	fi
> +}
> +
> +# $1: governor, $2: loop
> +run_tbench()
> +{
> +	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
> +	./amd_pstate_trace.py -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
> +
> +	printf "Test tbench for $1 #$2 time_limit: $TIME_LIMIT procs_num: $PROCESS_NUM\n"
> +	cd $tbench_name
> +	./tbench_srv > /dev/null 2>&1 &
> +	./../perf stat -a --per-socket -I 1000 -e power/energy-pkg/ ./tbench -t $TIME_LIMIT $PROCESS_NUM > ../$OUTFILE_TBENCH-perf-$1-$2.log 2>&1
> +	cd ..
> +
> +	pid=`pidof tbench_srv`
> +	kill $pid
> +
> +	for job in `jobs -p`
> +	do
> +		echo "Waiting for job id $job"
> +		wait $job
> +	done
> +}
> +
> +# $1: governor, $2: loop
> +parse_tbench()
> +{
> +	awk '{print $5}' results/tracer-tbench-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_TBENCH-des-perf-$1-$2.log
> +	avg_des_perf=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_TBENCH-des-perf-$1-$2.log)
> +	printf "Tbench-$1-#$2 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	awk '{print $7}' results/tracer-tbench-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_TBENCH-freq-$1-$2.log
> +	avg_freq=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_TBENCH-freq-$1-$2.log)
> +	printf "Tbench-$1-#$2 avg freq: $avg_freq\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	awk '{print $11}' results/tracer-tbench-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_TBENCH-load-$1-$2.log
> +	avg_load=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_TBENCH-load-$1-$2.log)
> +	printf "Tbench-$1-#$2 avg load: $avg_load\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	grep Throughput $OUTFILE_TBENCH-perf-$1-$2.log | awk '{print $2}' > $OUTFILE_TBENCH-throughput-$1-$2.log
> +	tp_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-throughput-$1-$2.log)
> +	printf "Tbench-$1-#$2 throughput(MB/s): $tp_sum\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	grep Joules $OUTFILE_TBENCH-perf-$1-$2.log | awk '{print $4}' > $OUTFILE_TBENCH-energy-$1-$2.log
> +	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-energy-$1-$2.log)
> +	printf "Tbench-$1-#$2 power consumption(J): $en_sum\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	ppw=`echo "scale=4;($TIME_LIMIT-1)*$tp_sum/$en_sum" | bc | awk '{printf "%.4f", $0}'`
> +	printf "Tbench-$1-#$2 PPW(MB/J): $ppw\n" | tee -a $OUTFILE_TBENCH.result
> +	printf "\n" | tee -a $OUTFILE_TBENCH.result

Please clarify PPW = performance per watt here.

> +
> +	store_csv_tbench $1 $2 $avg_des_perf $avg_freq $avg_load $tp_sum $en_sum $ppw
> +}
> +
> +# $1: governor
> +loop_tbench()
> +{
> +	printf "\nTbench total test times is $LOOP_TIMES for $1\n\n"
> +	for i in `seq 1 $LOOP_TIMES`
> +	do
> +		run_tbench $1 $i
> +		parse_tbench $1 $i
> +	done
> +}
> +
> +# $1: governor
> +gather_tbench()
> +{
> +	printf "Tbench test result for $1 (loops:$LOOP_TIMES)" | tee -a $OUTFILE_TBENCH.result
> +	printf "\n--------------------------------------------------\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "avg des perf:" | awk '{print $NF}' > $OUTFILE_TBENCH-des-perf-$1.log
> +	avg_des_perf=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-des-perf-$1.log)
> +	printf "Tbench-$1 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "avg freq:" | awk '{print $NF}' > $OUTFILE_TBENCH-freq-$1.log
> +	avg_freq=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-freq-$1.log)
> +	printf "Tbench-$1 avg freq: $avg_freq\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "avg load:" | awk '{print $NF}' > $OUTFILE_TBENCH-load-$1.log
> +	avg_load=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-load-$1.log)
> +	printf "Tbench-$1 avg load: $avg_load\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "throughput(MB/s):" | awk '{print $NF}' > $OUTFILE_TBENCH-throughput-$1.log
> +	tp_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-throughput-$1.log)
> +	printf "Tbench-$1 total throughput(MB/s): $tp_sum\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	avg_tp=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-throughput-$1.log)
> +	printf "Tbench-$1 avg throughput(MB/s): $avg_tp\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "power consumption(J):" | awk '{print $NF}' > $OUTFILE_TBENCH-energy-$1.log
> +	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-energy-$1.log)
> +	printf "Tbench-$1 total power consumption(J): $en_sum\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	avg_en=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-energy-$1.log)
> +	printf "Tbench-$1 avg power consumption(J): $avg_en\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	ppw=`echo "scale=4;($TIME_LIMIT-1)*$avg_tp/$avg_en" | bc | awk '{printf "%.4f", $0}'`
> +	printf "Tbench-$1 PPW(MB/J): $ppw\n" | tee -a $OUTFILE_TBENCH.result
> +	printf "\n" | tee -a $OUTFILE_TBENCH.result

It's better to add commment here to describe the formula that how to caculate the performance per watt (PPW) result for the tbench tests.

> +
> +	store_csv_tbench $1 "Average" $avg_des_perf $avg_freq $avg_load $avg_tp $avg_en $ppw
> +	empty_line_csv_tbench
> +}
> +
> +amd_pstate_tbench()
> +{
> +	printf "\n---------------------------------------------\n"
> +	printf "*** Running AMD P-state tbench            ***"
> +	printf "\n---------------------------------------------\n"
> +
> +	pre_clear_tbench
> +
> +	install_tbench
> +
> +	store_csv_tbench "Governor" "Round" "Des-perf" "Freq" "Load" "Performance(MB/s)" "Energy(Joules)" "PPW(MB/J)"

The same comment here above, we would better to have abbreviation
desciption for PPW in the result.

Thanks,
Ray

> +
> +	for_each_policy backup_governor
> +
> +	for governor in ${tbench_governors[*]} ; do
> +		printf "\nSpecified governor is $governor\n\n"
> +		for_each_policy switch_governor $governor
> +		loop_tbench $governor
> +		gather_tbench $governor
> +	done
> +
> +	restore_governor
> +
> +	post_clear_tbench
> +}
> -- 
> 2.25.1
> 
