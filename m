Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920525130E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbiD1KI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbiD1KHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:07:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61FD433AF;
        Thu, 28 Apr 2022 02:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRQgQUc/nH3j36lJp1XRAz9w0e63vII4SyTdQx0pD/ADEZOX1lc1eiYmgbX2vn61KfgIFily1KoU4eOB4ysAvV8wnmu/3G6F66k03K5p/c8Fs640AfaXuaesE7/8RHOmqIVUWf701608Bvp1fShNZE4N0K+2KrTX5h5POlXWAAUlPms4x1j6QCuzdUTM/p9cQKdbeI4eGXFFDgFcOyuze2YYilAcJQjGfA5oyx6YRH6Z4IJUgS4Imk5tfLFNpI2vvefRKAwjkEIS2H1NaeCFuMHC403TGfVfu4MOWTb6T0uMeZETDpvCdEDWw91/1+szICiD9fiqmM0hf03cHghD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eB4i7TNYv/8ZUz8zpU1+gg5Pyfh6U42A6PxtxXU0WJU=;
 b=i9st3D4rGyW6j50Q4p5g67jx0NLMDD72p3a4bgAAwjg0O5tPVn/jtdW/6HOsxD6xSIV9OoX2CKJr6V7yBe3telF2Sxu9NbggyzxkBBNoD2GP4T8klw/k7FnQgasGdIejS2GymVO4e5aAQ9aQUWCQgwSsx+c5KqTr0NpHTUzMvfBCW+UsiDQtEqFmYeO5ItmZK5bEldy6YeuWmh2k37hdNsowBVAqbPfiWZFBSlXH6fIO1z542LWiH5gt7BIG27UiNHp0Ow8/Mzbx/VHSjTV2jKN1wZL9WAuXc5mjjyqRjEXF6fsYyzukDC8Qb+gx+96cV7YohZCcDJjFskjbhlyxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eB4i7TNYv/8ZUz8zpU1+gg5Pyfh6U42A6PxtxXU0WJU=;
 b=QDU9lWWwFaYxNYUHAh42gg0lS13owpM5eETajvcOwXSqHXyLZZk2Uc9/1X1djL2Dmr8IxLPF2LlrF/kMaG9EAAtVg5EcFKTizRnr6EDe/aBV7WKfjz6c9jegIlaxhd7CdVhzAh3Wloi2ylIetVywtyfvq3iosHnyxxC6+NdDOII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BYAPR12MB4600.namprd12.prod.outlook.com (2603:10b6:a03:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 09:55:57 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d%7]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 09:55:57 +0000
Date:   Thu, 28 Apr 2022 17:55:33 +0800
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
Subject: Re: [PATCH V4 2/3] selftests: amd-pstate: Add test module for
 amd-pstate driver
Message-ID: <YmpklU0zeqIJBptX@amd.com>
References: <20220427135315.3447550-1-li.meng@amd.com>
 <20220427135315.3447550-3-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427135315.3447550-3-li.meng@amd.com>
X-ClientProxiedBy: HK2PR02CA0164.apcprd02.prod.outlook.com
 (2603:1096:201:1f::24) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc25f45d-d0e4-4229-286f-08da28fd4a69
X-MS-TrafficTypeDiagnostic: BYAPR12MB4600:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB460045D522A9857D47F9620FECFD9@BYAPR12MB4600.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fnoop//gDu737eXnMViq8Tresjzi0ZnewCNrdwaq0aikZXPdLWgjdFJaw5Cz1CEWCsWKggYzGGv5TwL3uKlSDFX/xklTnUa7S66/I3j3zvTFXv4uUkNNKOLELpP+sSVo7dGkWC8QdWgMJnnFgx8nwmMdXtaZ/8iZ8hrp22cB9W5ypFV4Zz9FQNL+Qd5370mD55ZahE1clQ9bQ2llwccFrmmpru/ZAjXoCNfeH7FJdWgN2fkyoh8uL7jfK5V3/82KslT6RsB8K+zhGyntLnRyEnt0wfcgabW+lTg2k+39gR8ZsH2GfD+EFsndYEQFchpAG0gJEPR0uj67PEUBh9P2UtECO1QZo++ACyzRrSiBWYf8Wes0nmt5WWaVD3LbZeyDCGRiLfSiu+UK2X3RJ7rTG7G/JPwB2EJR16QZqEnBSO5jzyGLc/7FZjhbSsBYFQ8sDNKAHrgoJQTQzCP0F7mMw+gQdAbZj8vWDohqVpW3oMyWvPYyy8Mo5J0m0te2mIx+3f4yyzygieZjy9dQ5dtsuFOXMvczcuWLDD4QemMimr6/MWZ0LUc9z+XthiQ7CnE10lrwYiR3dlwQTWMAGPtMtbDZUiOz/aQW2lXA76mf1YeZPSHwTxWSrVxHhjUFdr0ikuGYXZao5qvj8PdGJSPcag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6636002)(2906002)(6486002)(30864003)(38100700002)(508600001)(8676002)(6862004)(4326008)(66476007)(66556008)(37006003)(54906003)(66946007)(8936002)(316002)(86362001)(5660300002)(26005)(6512007)(83380400001)(2616005)(36756003)(186003)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?crVpPpN/FnV6jm+rhc9w7cIDS61ffb78gnRyXrx2LNStWzhKwIpzRylmN9N4?=
 =?us-ascii?Q?Mdikf0FUutODUoaWJkQgbCUziyzbzvBuLXNdWCeIcCp+W9sKZuHHGAJ60+pZ?=
 =?us-ascii?Q?59enbeaoxoDOAPjGOWdsG/d1PgJa2e1XONFgY4R1TuzhVGnccqaxf/jQXxeH?=
 =?us-ascii?Q?xoMlHi+FotC355fchMsKhQPCGy2m8eoWmAGsLd3LvHUrBFA5DACR4ECr5Jq6?=
 =?us-ascii?Q?GYTvyAIO4yY7mAPsjxczzRDak71MxrCb+C5gtjO3KNnuSYFoVg59YSeydMnz?=
 =?us-ascii?Q?D3D07q6G/+JQcXRMAzqe9+TNscUsNSlJvDjUXEvTfGzfdEl5RYmd9a1vUcLU?=
 =?us-ascii?Q?P/25UdgBW40RGYuoegHwRJfFyeF/bSLMw6g+9QFMV1xd0dNWxmotAYzqwxtQ?=
 =?us-ascii?Q?2PdW8jcRXaQmCcv0S/btbRhjFk4KT2gJ+YzS0CcAx5VfhxlHDhvjRn5jTqtz?=
 =?us-ascii?Q?w7XN/viJtwIjI2XXKglUjwjuRHksbr2hXoa1E0XFknWUrXovUk4xaq75r+P1?=
 =?us-ascii?Q?FMi+MqzJk3bRQREUx/27L9jiAFmdcEErhE06yYhNaMJ4xp0EzrrNjcgaeA3O?=
 =?us-ascii?Q?Mp0pzuWR/Vw+AsaLzV48+vg6UsxQw8wwZiJbb2uIBOz7yv+BXdBGzoRIzLbh?=
 =?us-ascii?Q?DuRCu49PjgncABzje361OW2Z0UBBb47RPRlXMPZt3jPYqFYlpVrPaJbfTPHn?=
 =?us-ascii?Q?s39zu8z6X6/U+HBhUX3dqvQgVNM9qu4A4Hkjl+ajizF5rjKoXToakn0nfs/2?=
 =?us-ascii?Q?/HDqpO2FaEQcA6IPhh2xjLUYnEHN6VGZRJmAItcsjVuw2pXjfGsNus9vRZaZ?=
 =?us-ascii?Q?WFK9jg0W01dWPrB0HEttv2xZG12nrxhrbZzgv3I/jEcLo8qRS5ltf5xcTiGv?=
 =?us-ascii?Q?kERtyc2NgsHGxL7Twho3tj2GgYC8B8zI9Hv1uc/TUYqFZfvRlZN1EHkKPmUO?=
 =?us-ascii?Q?Q2Qa9k52pm5mL1wW1TQcQLOg9oeCZgexrBJfp6i9lvsm8Yak7kcLn1QdKPYH?=
 =?us-ascii?Q?KB3M02o/2RfHZupKQvaAaPuK3u5hgkLmksGjmS83C9Vbxern1R4B/Cohu49j?=
 =?us-ascii?Q?qrrUHVv+mixaw2NjsPDKYrQQXjnuAzFKIhx8OEzjNhQ8fRGPctM1jiMIoWLv?=
 =?us-ascii?Q?guLA7McPxeQwdRoXV2HojTo0L8QWIv+fQrXf4uc0gvqNuE2gtTV/OTvLjqOg?=
 =?us-ascii?Q?2nH8K3vB96LNCmtW/8AUclYaCAY4tIpnPOElqPIG8QDxU3Xbe4S6z8ovZXEi?=
 =?us-ascii?Q?56napAPAn4hBlT3WqFKwPaiZbNajZViy0GCyDEq9HNO0CK3lzjCrYsolVtvG?=
 =?us-ascii?Q?A05TAKIbLim+wT30U1vuBJeCfwi9cWN55N1RmVxCxN4+m8Xs/pJ8k3O4FCLS?=
 =?us-ascii?Q?XRD3fkT3v5R+Iq7yFJkesMgs/yfOXoPdFvdJ1kqbk/QDmrIV1FSUtYTdsZ16?=
 =?us-ascii?Q?R5xBG6kHolk+7USwS6Fep1GMjdm2E9ivnVSTIPpvOpp6ljmnKNWPAihQjJ0c?=
 =?us-ascii?Q?43bMQFjtZLFvYw8mRRplC57VngOhINx4RdAxXo4rzdVi/GZvWyD62Z8SfaOi?=
 =?us-ascii?Q?nKjeNI7RieiTyjT4N9BqgkEKBrIVrlYo8YN7gztF8/1RT0XM2OOImHUMe2nK?=
 =?us-ascii?Q?Cj3CDRcNlXM8Ga9nXgDeeT3M9oQ5m2eKhMQ7sKYpGxOQY3iNUo3O2rSx6T9y?=
 =?us-ascii?Q?mra8GiviC7FiT8r9s+b3DGAjY9lBDLbkKYTRjIy1PTciQlalcANOe4ncSR70?=
 =?us-ascii?Q?RGf9zcZvcA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc25f45d-d0e4-4229-286f-08da28fd4a69
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 09:55:57.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8Rr8Ag8ie3h1wEHc86223oZmYTJ9XhL46eFyllaZJrhIaiMEqn5/4OvJHzSFR7Mq9pS9i43s8EKveS1XAltZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:53:14PM +0800, Meng, Li (Jassmine) wrote:
> Add amd-pstate-ut module, which is conceptually out-of-tree module
> and provides ways for selftests/amd-pstate driver to test various
> kernel module-related functionality. This module will be expected by
> some of selftests to be present and loaded.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/amd-pstate/Makefile   |   9 +
>  .../selftests/amd-pstate/amd-pstate-ut.sh     |  27 ++
>  .../amd-pstate/amd-pstate-ut/Makefile         |  20 ++
>  .../amd-pstate/amd-pstate-ut/amd-pstate-ut.c  | 275 ++++++++++++++++++
>  tools/testing/selftests/amd-pstate/config     |   1 +
>  6 files changed, 333 insertions(+)
>  create mode 100644 tools/testing/selftests/amd-pstate/Makefile
>  create mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
>  create mode 100644 tools/testing/selftests/amd-pstate/amd-pstate-ut/Makefile
>  create mode 100644 tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.c
>  create mode 100644 tools/testing/selftests/amd-pstate/config
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 2319ec87f53d..975c13368286 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  TARGETS += alsa
> +TARGETS += amd-pstate
>  TARGETS += arm64
>  TARGETS += bpf
>  TARGETS += breakpoints
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> new file mode 100644
> index 000000000000..199867f44b32
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Makefile for amd-pstate/ function selftests
> +
> +# No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
> +all:
> +
> +TEST_PROGS := amd-pstate-ut.sh
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> new file mode 100755
> index 000000000000..9e787ead6b14
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# amd-pstate-ut is a test module for testing the amd-pstate driver.
> +# (1) It can help all users to verify their processor support
> +# (SBIOS/Firmware or Hardware).
> +# (2) Kernel can have a basic function test to avoid the kernel
> +# regression during the update.
> +# (3) We can introduce more functional or performance tests to align
> +# the result together, it will benefit power and performance scale optimization.
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
> +	echo "$0 # Skipped: Test can only run on x86 architectures."
> +	exit $ksft_skip
> +fi
> +
> +scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
> +
> +if [ "$scaling_driver" != "amd-pstate" ]; then
> +	echo "$0 # Skipped: Test can only run on amd-pstate driver."

Maybe it's better to print the current scaling_driver which is running
here.

> +	exit $ksft_skip
> +fi
> +

Can we add load the amd-pstate-ut test module in the script?

> +$(dirname $0)/../kselftest/module.sh "amd-pstate-ut" amd-pstate-ut
> diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut/Makefile b/tools/testing/selftests/amd-pstate/amd-pstate-ut/Makefile
> new file mode 100644
> index 000000000000..16e09c64369a
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/amd-pstate-ut/Makefile
> @@ -0,0 +1,20 @@
> +AMD_PSTATE_UT_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
> +KDIR ?= $(abspath $(AMD_PSATE_UT_DIR)/../../../../..)
> +
> +ifeq ($(V),1)
> +Q =
> +else
> +Q = @
> +endif
> +
> +MODULES = amd-pstate-ut.ko
> +
> +obj-m += amd-pstate-ut.o
> +CFLAGS_amd-pstate-ut.o = -I$(src)
> +
> +all:
> +	+$(Q)make -C $(KDIR) M=$(AMD_PSTATE_UT_DIR) modules
> +
> +clean:
> +	+$(Q)make -C $(KDIR) M=$(AMD_PSTATE_UT_DIR) clean
> +
> diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.c b/tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.c
> new file mode 100644
> index 000000000000..ec7b5c984879
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-1.0-or-later
> +/*
> + * AMD Processor P-state Frequency Driver Unit Test
> + *
> + * Copyright (C) 2022 Advanced Micro Devices, Inc. All Rights Reserved.
> + *
> + * Author: Meng Li <li.meng@amd.com>
> + *
> + * The AMD P-State Unit Test is a test module for testing the amd-pstate
> + * driver. 1) It can help all users to verify their processor support
> + * (SBIOS/Firmware or Hardware). 2) Kernel can have a basic function
> + * test to avoid the kernel regression during the update. 3) We can
> + * introduce more functional or performance tests to align the result
> + * together, it will benefit power and performance scale optimization.
> + *
> + * At present, it only implements the basic framework and some simple
> + * test cases. Next, 1) we will add a rst document. 2) we will add more
> + * test cases to improve the depth and coverage of the test.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include "../../kselftest_module.h"
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/fs.h>
> +#include <linux/amd-pstate.h>
> +
> +#include <acpi/cppc_acpi.h>
> +
> +/*
> + * Abbreviations:
> + * aput: used as a shortform for AMD P-State unit test.
> + * It helps to keep variable names smaller, simpler
> + */
> +
> +KSTM_MODULE_GLOBALS();
> +
> +/*
> + * Kernel module for testing the AMD P-State unit test
> + */
> +enum aput_result {
> +	APUT_RESULT_PASS,
> +	APUT_RESULT_FAIL,
> +	MAX_APUT_RESULT,
> +};
> +
> +struct aput_struct {
> +	const char *name;
> +	void (*func)(u32 index);
> +	enum aput_result result;
> +};
> +
> +static void aput_acpi_cpc(u32 index);
> +static void aput_check_enabled(u32 index);
> +static void aput_check_perf(u32 index);
> +static void aput_check_freq(u32 index);
> +
> +static struct aput_struct aput_cases[] = {
> +	{"acpi_cpc_valid",   aput_acpi_cpc         },
> +	{"check_enabled",    aput_check_enabled    },
> +	{"check_perf",       aput_check_perf       },
> +	{"check_freq",       aput_check_freq       }
> +};
> +
> +static bool get_shared_mem(void)
> +{
> +	bool result = false;
> +	char buf[5] = {0};
> +	struct file *filp = NULL;
> +	loff_t pos = 0;
> +	ssize_t ret;
> +
> +	filp = filp_open("/sys/module/amd_pstate/parameters/shared_mem", FMODE_PREAD, 0);

We need to add a check of read back from X86_FEATURE_CPPC in case somebody
set the "shared_mem" parameter on full MSR processors.

Others look good for me, thanks Li!

Thanks,
Ray

> +	if (IS_ERR(filp))
> +		pr_err("%s Open param file fail!\n", __func__);
> +	else {
> +		ret = kernel_read(filp, &buf, sizeof(buf), &pos);
> +		if (ret < 0)
> +			pr_err("%s ret=%ld unable to read from param file!\n", __func__, ret);
> +		filp_close(filp, NULL);
> +	}
> +
> +	if ('Y' == *buf)
> +		result = true;
> +
> +	return result;
> +}
> +
> +static void aput_acpi_cpc(u32 index)
> +{
> +	if (acpi_cpc_valid())
> +		aput_cases[index].result = APUT_RESULT_PASS;
> +	else
> +		aput_cases[index].result = APUT_RESULT_FAIL;
> +}
> +
> +static void aput_pstate_enable(u32 index)
> +{
> +	int ret = 0;
> +	u64 cppc_enable = 0;
> +
> +	ret = rdmsrl_safe(MSR_AMD_CPPC_ENABLE, &cppc_enable);
> +	if (ret) {
> +		aput_cases[index].result = APUT_RESULT_FAIL;
> +		pr_err("%s rdmsrl_safe MSR_AMD_CPPC_ENABLE ret=%d is error!\n", __func__, ret);
> +		return;
> +	}
> +	if (cppc_enable)
> +		aput_cases[index].result = APUT_RESULT_PASS;
> +	else
> +		aput_cases[index].result = APUT_RESULT_FAIL;
> +}
> +
> +/*
> + *Check if enabled amd pstate
> + */
> +static void aput_check_enabled(u32 index)
> +{
> +	if (get_shared_mem())
> +		aput_cases[index].result = APUT_RESULT_PASS;
> +	else
> +		aput_pstate_enable(index);
> +}
> +
> +/*
> + * Check if the each performance values are reasonable.
> + * highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0
> + */
> +static void aput_check_perf(u32 index)
> +{
> +	int cpu = 0, ret = 0;
> +	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
> +	u64 cap1 = 0;
> +	struct cppc_perf_caps cppc_perf;
> +	struct cpufreq_policy *policy = NULL;
> +	struct amd_cpudata *cpudata = NULL;
> +
> +	highest_perf = amd_get_highest_perf();
> +
> +	for_each_possible_cpu(cpu) {
> +		policy = cpufreq_cpu_get(cpu);
> +		if (!policy)
> +			break;
> +		cpudata = policy->driver_data;
> +
> +		if (get_shared_mem()) {
> +			ret = cppc_get_perf_caps(cpu, &cppc_perf);
> +			if (ret) {
> +				aput_cases[index].result = APUT_RESULT_FAIL;
> +				pr_err("%s cppc_get_perf_caps ret=%d is error!\n", __func__, ret);
> +				return;
> +			}
> +
> +			nominal_perf = cppc_perf.nominal_perf;
> +			lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
> +			lowest_perf = cppc_perf.lowest_perf;
> +		} else {
> +			ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
> +			if (ret) {
> +				aput_cases[index].result = APUT_RESULT_FAIL;
> +				pr_err("%s read CPPC_CAP1 ret=%d is error!\n", __func__, ret);
> +				return;
> +			}
> +
> +			nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
> +			lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
> +			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
> +		}
> +
> +		if ((highest_perf != READ_ONCE(cpudata->highest_perf)) ||
> +			(nominal_perf != READ_ONCE(cpudata->nominal_perf)) ||
> +			(lowest_nonlinear_perf != READ_ONCE(cpudata->lowest_nonlinear_perf)) ||
> +			(lowest_perf != READ_ONCE(cpudata->lowest_perf))) {
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d highest=%d %d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d are not equal!\n",
> +				__func__, cpu, highest_perf, cpudata->highest_perf,
> +				nominal_perf, cpudata->nominal_perf,
> +				lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
> +				lowest_perf, cpudata->lowest_perf);
> +			return;
> +		}
> +
> +		if (!((highest_perf >= nominal_perf) &&
> +			(nominal_perf > lowest_nonlinear_perf) &&
> +			(lowest_nonlinear_perf > lowest_perf) &&
> +			(lowest_perf > 0))) {
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d highest=%d nominal=%d lowest_nonlinear=%d lowest=%d have error!\n",
> +				__func__, cpu, highest_perf, nominal_perf,
> +				lowest_nonlinear_perf, lowest_perf);
> +			return;
> +		}
> +	}
> +
> +	aput_cases[index].result = APUT_RESULT_PASS;
> +}
> +
> +/*
> + * Check if the each frequency values are reasonable.
> + * max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0
> + * check max freq when set support boost mode.
> + */
> +static void aput_check_freq(u32 index)
> +{
> +	int cpu = 0;
> +	struct cpufreq_policy *policy = NULL;
> +	struct amd_cpudata *cpudata = NULL;
> +
> +	for_each_possible_cpu(cpu) {
> +		policy = cpufreq_cpu_get(cpu);
> +		if (!policy)
> +			break;
> +		cpudata = policy->driver_data;
> +
> +		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
> +			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> +			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
> +			(cpudata->min_freq > 0))) {
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d max=%d nominal=%d lowest_nonlinear=%d min=%d have error!\n",
> +				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
> +				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
> +			return;
> +		}
> +
> +		if (cpudata->min_freq != policy->min) {
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d cpudata_min_freq=%d policy_min=%d have error!\n",
> +				__func__, cpu, cpudata->min_freq, policy->min);
> +			return;
> +		}
> +
> +		if (cpudata->boost_supported) {
> +			if ((policy->max == cpudata->max_freq) ||
> +					(policy->max == cpudata->nominal_freq))
> +				aput_cases[index].result = APUT_RESULT_PASS;
> +			else {
> +				aput_cases[index].result = APUT_RESULT_FAIL;
> +				pr_err("%s cpu%d policy_max=%d cpu_max=%d cpu_nominal=%d have error!\n",
> +					__func__, cpu, policy->max, cpudata->max_freq,
> +					cpudata->nominal_freq);
> +				return;
> +			}
> +		} else {
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d not support boost!\n", __func__, cpu);
> +			return;
> +		}
> +	}
> +}
> +
> +static void aput_do_test_case(void)
> +{
> +	u32 i = 0, arr_size = ARRAY_SIZE(aput_cases);
> +
> +	for (i = 0; i < arr_size; i++) {
> +		pr_info("****** Begin %-5d\t %-20s\t ******\n", i+1, aput_cases[i].name);
> +		aput_cases[i].func(i);
> +		KSTM_CHECK_ZERO(aput_cases[i].result);
> +		pr_info("****** End   %-5d\t %-20s\t ******\n", i+1, aput_cases[i].name);
> +	}
> +}
> +
> +static void __init selftest(void)
> +{
> +	aput_do_test_case();
> +}
> +
> +KSTM_MODULE_LOADERS(amd_pstate_ut);
> +MODULE_AUTHOR("Meng Li <li.meng@amd.com>");
> +MODULE_DESCRIPTION("Unit test for AMD P-state driver");
> +MODULE_LICENSE("GPL");
> diff --git a/tools/testing/selftests/amd-pstate/config b/tools/testing/selftests/amd-pstate/config
> new file mode 100644
> index 000000000000..f43103c9adc4
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/config
> @@ -0,0 +1 @@
> +CONFIG_X86_AMD_PSTATE_UT=m
> -- 
> 2.25.1
> 
