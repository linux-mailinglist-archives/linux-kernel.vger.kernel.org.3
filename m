Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A305577FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiGRKey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiGRKew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:34:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1063E1C933;
        Mon, 18 Jul 2022 03:34:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwTpX54weD13ciKpXGRJpFN69l6WsHPyhbb+uuvLBlUsfszJ/4jxR79lT2Ev4YkqAJrrRYgpLNOS4SW0RrRq3Yiin7iiiteOO4kfdz7h2YgGdY1jbCPncu3Z1ogW4lXpUkwyrCY2d9ZNMOVrTplJAq493Au2W8RqH2Sh39N68fvahqNavonWPP+4t7JOw/rT5k8B6XMYtXbGvfo7EF+Fg6ZnI0lF95N4f2Fbfs/HddUXgHp6388FGvd56DqEID7QswVySgKB0bRIHgL3oVc0DYScYW8MH32sIKG4PxchnfIrNsSkmh73d3lRKiVfdape5uFA1hDrkzjPr2gBe7GGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1ODnj4EwTNkDWTnmVyUcGJkRuiVgU965Pk9GJNRyb0=;
 b=a/4DuDmRcrWy99CS1djLw63om3BCNIy778gRwQIA0KPWDbNPKbq2N3yNo0vHSLqA/HE6UWH7w23UNSBpzOf/k5pMkDviVauYkrzw5/hNkZPGfcWVp0KcsLALS466akmG0IorSwIKkdZERjqDwQBcX570BAvUK7+F2DuS6Xa6dKujf8eJD6he6a6ov9mlKWNATQ3xWJVpS/Pw2W9pL5TNDEZ+uJGiDdb6GJLA3H4HWsLQqDMEugKC/W4ubNUzFbpHk6TF+GLaJ+aAflCc2dbKLCr9P7sdOyepq3a49UWtYg/ZuTv29zwk5a+XNnWyzYsMZobKOeZG3bSTWOAB7paykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1ODnj4EwTNkDWTnmVyUcGJkRuiVgU965Pk9GJNRyb0=;
 b=fI9MGOqQNMLANizOT1ELiBFj2qKa0XsT3VyP/toT2FFfNuslnZ4cg2Le3e+vkrTulLWbeBJun8P3148fXc61XFKkIlM64Zmt33IZXJLAPApHKgkFGcRq6D93j/8uxlkyLPRXFFS9RK5ArLApr5mm/sDg1d/zTOChjqPWR/UNl2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Mon, 18 Jul 2022 10:34:47 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 10:34:47 +0000
Date:   Mon, 18 Jul 2022 18:34:23 +0800
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
Subject: Re: [PATCH V1 1/4] selftests: amd-pstate: Modify amd-pstate-ut.sh to
 basic.sh.
Message-ID: <YtU3L3yhfB/12k/i@amd.com>
References: <20220706073622.672135-1-li.meng@amd.com>
 <20220706073622.672135-2-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706073622.672135-2-li.meng@amd.com>
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b06b770-a3e6-4562-e23f-08da68a922f7
X-MS-TrafficTypeDiagnostic: CH2PR12MB4858:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XUSmzmodCNkHMUEOe3Dz8iOjrj9uggkLeU80c3SUwFXcjYJA0Oe8A913y2UMClDMtkXeYjZdhqSVGNhjLVIymRj4g0IKZQ6hbxjtlF40+bbu/iEHaC4jC3pbdfdxgrrOB38p9CjdH0Y98LQJPww9216H0XSkSr6RT3+UI5CN1RtzP/sMOA78eOmn8kjt0X7d5iVRDw5gflPmpyG3yJE3OnjQIEFfBZce341LjZ7EKoIXCjnH1UjlQGvmlfSu8aQRugm2jQ1PCOl2MxtvFRvhuENgs7CBc8Z9K7C8L1NHfnKAuPfxNVqgjs4mTSGnhf7I/i6MpP1wTfykeOzJl8OgPlagrO6eeEGOatYK7yualmhOzdhDi09uKu7yfineSACIqTh+sxPDWn9R1QLhsVhUfEPnQ+fJGf2ffHlc/JHHBQVFuWemdhXcY2a85NteaovCtzrbPkdX9cbCjPcHl43daR0IyeNp/IX2RQ1ftknBShAxDbTfPHfcYc60mYbO6hj6LwKmqAWEnJ5Uyq7YCLttccjx7o48sYUWQdKmOFtRTOxf9L3kTT97sfGbYMo9l8afTSKyualDCcfyC+nH5/ZiwhY3P5CLO2OgPwPHp4SPUdFvRe0TFKEvrd899/IA414FqlddzR6cBDDtITP/S++O8MOXRD/vpVSLIAyWq0+00CQH53pUuwUP4NasTv7hRN/+DiaK1q5qBK1vimEE17tgABbkHaiJKJpkvHXwtXEJ8I7RMX/d2Ie+tH56U5zh7PVtoOn5MZUxga+a0V/UnOY2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(5660300002)(36756003)(8936002)(6862004)(2906002)(54906003)(6636002)(86362001)(4326008)(66476007)(66556008)(8676002)(37006003)(316002)(478600001)(6512007)(41300700001)(6506007)(83380400001)(38100700002)(6486002)(26005)(2616005)(186003)(6666004)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lxA/TC3v+g8HbsDAQxcGs88qQdwWExOeCQ68xvDlyhjApBa9yRY65v/ihn6Y?=
 =?us-ascii?Q?WLtgDfQEqy8zhaSUDGzPtdAmyfRvjrXEcjcuqhKTkg+3eYmJ+E1/0lfQdabT?=
 =?us-ascii?Q?x5pMSYvBbtU3pNxwScUYERP+JGBLTZOCAQh0CP1EV6JtUKdT0LsrDHFMkgO8?=
 =?us-ascii?Q?aneC2w7IuoF0k2hb5TNERIIIAETIXop3h2j8cwtPa/VRxOZ/ZMPqebLRCuaO?=
 =?us-ascii?Q?QGQLY/L5yGN5dFC59dQXnLd0qbqgreC69xw9AdemnQFffMspSMBFxO3aBDV8?=
 =?us-ascii?Q?SFaKy+hh+TVbHIr9m9e4XdNoH3knJHeBv6go1tkyh6J9IlAhpSWum2WrM+Xt?=
 =?us-ascii?Q?qch9ibnBT69w49CIo55u3/SnzXw/oogUwbcabqgfUGa0Bg4mrgpSe5AH75qr?=
 =?us-ascii?Q?y04UrOVMW2hzNV2cdwkaf/tq6eUj2N2H96nLXKg7wGSDOSNJA/eVdcVlR7NP?=
 =?us-ascii?Q?bRHSxuORQ0jrJhjNxS8bqx48ixdBG0GMXhvcYLlXpvlN/XOmSRDdZ8Id2kOV?=
 =?us-ascii?Q?3gkrUOpL41xetPy9Srq+CqCi0YuMQHU9YceV21rFb7lWmZiw4UnxjsCEAOBH?=
 =?us-ascii?Q?XvMTBYkr3TNopzSejNOpvUI/9zT6V3rloZgTIhdGBJt0XmsR4Yp2H9ogA8MV?=
 =?us-ascii?Q?wHRZZ5R/i4gKAAew7CIoA1fSuld6S1Nz0stT9GTbVfKaebsYdxb2o+K0ZB7g?=
 =?us-ascii?Q?2hEARZCL+W6QSyzEu6kMR0rBU8NhC9uAQi7XBKJ1GnSa9SC/0+aS41PzkGCz?=
 =?us-ascii?Q?YYCLJBt6LPVJ3wACktV776kbKB4X124DohKG8Fp/eO5digkbu+HNLHkEEHdD?=
 =?us-ascii?Q?BbDroWpM5dxxtgYEyTY4qmofkABfflOAcSg/XnIi7Kuw3yMr2BmFZzpoLbVK?=
 =?us-ascii?Q?JJClcqSydsF0P99S9yBiUr+yM9RvdT0+pqD1ULc335oVDW1nz/xzG+yOGcFx?=
 =?us-ascii?Q?I7H+fke2lLHuyWwlG9cHi2/WcRqTxkqh2/fu+LlvuS0ijz5tsP1KnVi8fVgM?=
 =?us-ascii?Q?kp1g8ijM5rkxdqGmAa3I75YjNHP0Wg+CZB7PCm0JNvcWdPz5715D9+vRhyRz?=
 =?us-ascii?Q?wats98t+Dti2V9kR/+hR+WcNEmPYZAdwVFuRnv9hzN9RvzAPYmThDhZZSKRn?=
 =?us-ascii?Q?XmyI/Dq2pJmU66PgJUh1tByE6dchiRcQ048rr0PYTRtJgyxI7S4OJQMUr6fT?=
 =?us-ascii?Q?PODiW18mCvAtA4Ledky03YqgdZzIxFE6w+x3aTEAudlqwfQbswbpDlgnzuRD?=
 =?us-ascii?Q?rsv1NYqptN/X7SjB6DY2LKKFBGT7rNYF0Xrds1iY1oZgvN5gX4V2zCSjKLOl?=
 =?us-ascii?Q?T4ZI9nTD2mI2ksgEkemAcstn+Hf27IxESwEWUVg/wqQfRNKus3NquBIM9CQ5?=
 =?us-ascii?Q?Swl6Nq5Nnb0iwp7IdyYVBiBMoI2Awblz3XPWQRqEQLdxEo3Du+d0/CwrSaER?=
 =?us-ascii?Q?/KgXTR0wpnXZjk+6v7d+v7+V2eWHBfIMbtUsMj16jlCPrSe6txlUK/Un8tiY?=
 =?us-ascii?Q?z2R+/QRcaM5KuJ9JXuZluJMAYDLXgwWjhkgUmrvQR4c51yf7a5L5YCZb5KcK?=
 =?us-ascii?Q?BD5a04ArlrU7GVY6BU+s8ayhpLgWr/2Pix9FnUT4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b06b770-a3e6-4562-e23f-08da68a922f7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 10:34:47.4747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAAViDZhdLFrpbYibpY/FLfw+w/A/9/9SKwaW7LDuUP+QO/D3y8jgGq4yEbDda3rwNYd8TxYyJhn0+OM9Kt66w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:36:19PM +0800, Meng, Li (Jassmine) wrote:
> Modify amd-pstate-ut.sh to basic.sh.
> The purpose of this modification is to facilitate the subsequent
> addition of gitsource, tbench and other tests.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>

Since amd-pstate-ut.sh is separated by three scripts below, could you
please describe how to use them in the commit log?

Thanks,
Ray

> ---
>  tools/testing/selftests/amd-pstate/Makefile   |   3 +-
>  .../selftests/amd-pstate/amd-pstate-ut.sh     |  55 --------
>  tools/testing/selftests/amd-pstate/basic.sh   |  38 +++++
>  tools/testing/selftests/amd-pstate/main.sh    | 131 ++++++++++++++++++
>  tools/testing/selftests/amd-pstate/run.sh     |  15 ++
>  5 files changed, 186 insertions(+), 56 deletions(-)
>  delete mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
>  create mode 100755 tools/testing/selftests/amd-pstate/basic.sh
>  create mode 100755 tools/testing/selftests/amd-pstate/main.sh
>  create mode 100755 tools/testing/selftests/amd-pstate/run.sh
> 
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index 199867f44b32..167ab51ec290 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -4,6 +4,7 @@
>  # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
>  all:
>  
> -TEST_PROGS := amd-pstate-ut.sh
> +TEST_PROGS := run.sh
> +TEST_FILES := main.sh basic.sh
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> deleted file mode 100755
> index 273364650285..000000000000
> --- a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -# amd-pstate-ut is a test module for testing the amd-pstate driver.
> -# It can only run on x86 architectures and current cpufreq driver
> -# must be amd-pstate.
> -# (1) It can help all users to verify their processor support
> -# (SBIOS/Firmware or Hardware).
> -# (2) Kernel can have a basic function test to avoid the kernel
> -# regression during the update.
> -# (3) We can introduce more functional or performance tests to align
> -# the result together, it will benefit power and performance scale optimization.
> -
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4
> -
> -# amd-pstate-ut only run on x86/x86_64 AMD systems.
> -ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
> -VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
> -
> -if ! echo "$ARCH" | grep -q x86; then
> -	echo "$0 # Skipped: Test can only run on x86 architectures."
> -	exit $ksft_skip
> -fi
> -
> -if ! echo "$VENDOR" | grep -iq amd; then
> -	echo "$0 # Skipped: Test can only run on AMD CPU."
> -	echo "$0 # Current cpu vendor is $VENDOR."
> -	exit $ksft_skip
> -fi
> -
> -scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
> -if [ "$scaling_driver" != "amd-pstate" ]; then
> -	echo "$0 # Skipped: Test can only run on amd-pstate driver."
> -	echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
> -	exit $ksft_skip
> -fi
> -
> -msg="Skip all tests:"
> -if [ ! -w /dev ]; then
> -    echo $msg please run this as root >&2
> -    exit $ksft_skip
> -fi
> -
> -if ! /sbin/modprobe -q -n amd-pstate-ut; then
> -	echo "amd-pstate-ut: module amd-pstate-ut is not found [SKIP]"
> -	exit $ksft_skip
> -fi
> -if /sbin/modprobe -q amd-pstate-ut; then
> -	/sbin/modprobe -q -r amd-pstate-ut
> -	echo "amd-pstate-ut: ok"
> -else
> -	echo "amd-pstate-ut: [FAIL]"
> -	exit 1
> -fi
> diff --git a/tools/testing/selftests/amd-pstate/basic.sh b/tools/testing/selftests/amd-pstate/basic.sh
> new file mode 100755
> index 000000000000..e4c43193e4a3
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/basic.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# amd-pstate-ut is a test module for testing the amd-pstate driver.
> +# It can only run on x86 architectures and current cpufreq driver
> +# must be amd-pstate.
> +# (1) It can help all users to verify their processor support
> +# (SBIOS/Firmware or Hardware).
> +# (2) Kernel can have a basic function test to avoid the kernel
> +# regression during the update.
> +# (3) We can introduce more functional or performance tests to align
> +# the result together, it will benefit power and performance scale optimization.
> +
> +# protect against multiple inclusion
> +if [ $FILE_BASIC ]; then
> +	return 0
> +else
> +	FILE_BASIC=DONE
> +fi
> +
> +amd_pstate_basic()
> +{
> +	printf "\n---------------------------------------------\n"
> +	printf "*** Running AMD P-state ut                ***"
> +	printf "\n---------------------------------------------\n"
> +
> +	if ! /sbin/modprobe -q -n amd-pstate-ut; then
> +		echo "amd-pstate-ut: module amd-pstate-ut is not found [SKIP]"
> +		exit $ksft_skip
> +	fi
> +	if /sbin/modprobe -q amd-pstate-ut; then
> +		/sbin/modprobe -q -r amd-pstate-ut
> +		echo "amd-pstate-basic: ok"
> +	else
> +		echo "amd-pstate-basic: [FAIL]"
> +		exit 1
> +	fi
> +}
> diff --git a/tools/testing/selftests/amd-pstate/main.sh b/tools/testing/selftests/amd-pstate/main.sh
> new file mode 100755
> index 000000000000..1c28b5d7b4c5
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/main.sh
> @@ -0,0 +1,131 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# protect against multiple inclusion
> +if [ $FILE_MAIN ]; then
> +	return 0
> +else
> +	FILE_MAIN=DONE
> +fi
> +
> +source basic.sh
> +
> +# amd-pstate-ut only run on x86/x86_64 AMD systems.
> +ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
> +VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
> +
> +FUNC=all
> +OUTFILE=selftest
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +# All amd-pstate tests
> +amd_pstate_all()
> +{
> +	printf "\n=============================================\n"
> +	printf "***** Running AMD P-state Sanity Tests  *****\n"
> +	printf "=============================================\n\n"
> +
> +	# unit test for amd-pstate kernel driver
> +	amd_pstate_basic
> +}
> +
> +helpme()
> +{
> +	printf "Usage: $0 [OPTION...]
> +	[-h <help>]
> +	[-o <output-file-for-dump>]
> +	[-c <all: All testing,
> +	     basic: Basic testing.>]
> +	\n"
> +	exit 2
> +}
> +
> +parse_arguments()
> +{
> +	while getopts ho:c: arg
> +	do
> +		case $arg in
> +			h) # --help
> +				helpme
> +				;;
> +
> +			c) # --func_type (Function to perform: basic (default: all))
> +				FUNC=$OPTARG
> +				;;
> +
> +			o) # --output-file (Output file to store dumps)
> +				OUTFILE=$OPTARG
> +				;;
> +
> +			\?)
> +				helpme
> +				;;
> +		esac
> +	done
> +}
> +
> +prerequisite()
> +{
> +	if ! echo "$ARCH" | grep -q x86; then
> +		echo "$0 # Skipped: Test can only run on x86 architectures."
> +		exit $ksft_skip
> +	fi
> +
> +	if ! echo "$VENDOR" | grep -iq amd; then
> +		echo "$0 # Skipped: Test can only run on AMD CPU."
> +		echo "$0 # Current cpu vendor is $VENDOR."
> +		exit $ksft_skip
> +	fi
> +
> +	scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
> +	if [ "$scaling_driver" != "amd-pstate" ]; then
> +		echo "$0 # Skipped: Test can only run on amd-pstate driver."
> +		echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
> +		exit $ksft_skip
> +	fi
> +
> +	msg="Skip all tests:"
> +	if [ ! -w /dev ]; then
> +		echo $msg please run this as root >&2
> +		exit $ksft_skip
> +	fi
> +}
> +
> +do_test()
> +{
> +	case "$FUNC" in
> +		"all")
> +		amd_pstate_all
> +		;;
> +
> +		"basic")
> +		amd_pstate_basic
> +		;;
> +
> +		*)
> +		echo "Invalid [-f] function type"
> +		helpme
> +		;;
> +	esac
> +}
> +
> +# clear dumps
> +pre_clear_dumps()
> +{
> +	case "$FUNC" in
> +		"all")
> +		rm -rf $OUTFILE*
> +		;;
> +
> +		"basic")
> +		;;
> +
> +	esac
> +}
> +
> +post_clear_dumps()
> +{
> +	rm -rf $OUTFILE.log
> +}
> diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
> new file mode 100755
> index 000000000000..247e80bfee44
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/run.sh
> @@ -0,0 +1,15 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +source main.sh
> +
> +# Parse arguments
> +parse_arguments $@
> +
> +# Make sure all requirements are met
> +prerequisite
> +
> +# Run requested functions
> +pre_clear_dumps
> +do_test | tee -a $OUTFILE.log
> +post_clear_dumps
> -- 
> 2.25.1
> 
