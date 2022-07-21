Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A36C57D2F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiGUSCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiGUSCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:02:45 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA578C58A;
        Thu, 21 Jul 2022 11:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKCrn1mdMQOILKu1+AEKW2GllMK1irEPLrLUnTPhGK3QqGt1BRKbJoKyFpdzxPfP1BpHEIQtnls4CRb/22t2mKWckpJY/jr6wpeZPlXU+pV7wlUUlThUDGfLU/WBYDUseiw1P+Rp6N5xXMir5HwB8vORtnJrtPfUEw2x/op6alypnVYtHNGJRgiK5yJM6yFaV8A5iQAyqxQGs8DUE30oWWuuByz0dEGkTFQGF0ySMxAnueR5LsVIq9YaH1cE5O874fwr8q9NK5hr064kwRSX1yMBaQrhJA1oBEFoNYSG5MQWBPW3J1MEehVBvkpvDn03gSddaMKZ/NfOrRCSBFZS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VHHl5B1yqPPhvFtNG1mUB3JEhHt21VEODUNP5PrM/g=;
 b=PZC0tsqajL91qR1WsuW/2iwh4kBJGAsT6muIhWRlnwOxI+8LW0eUbGmGTWnjiWaq8vAZBv6RgsWzPndZ9/Zi6f0uZTXe/RpEClYF4t8HkSw6nJ2wBNIjIarV3lOzxvNI2MvOqXKQZ+m7YhwFFwCjFGnQ07ATKOIpSfNg2HuErWrBrDzSq3VAqv25E7Vv4XviSKkrbfuADwMN9go5+pxzmOD4Hy2njqIGWABha7zCbNNWscKZmGjj51ZuoamyCXBjb3wT4DQldBXceNvl0tBgJpF9SQ94Tbe/xOt8Dx/rtyUSdQhK+etWAPFNYTK70H2+Wj4TQpzG6j6aHHDKxyhbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VHHl5B1yqPPhvFtNG1mUB3JEhHt21VEODUNP5PrM/g=;
 b=gaQGv9sTPI62ibnJMGUSwOhkUvHPYYZzX9ludzGW/8V+nxoCz9WW8kkQM1Akmtn1RowBiXUqvokpEj/U6MMxBSsc+WPRGqgYKac7SaOLeG1aJ9TkfOemWyGYOadt+KHtCj2LNQgHof4DdHSIoaqn5M2IcLKxtDX3ubmOK4h1M/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 18:02:34 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::41ae:b861:f98a:3e39]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::41ae:b861:f98a:3e39%4]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 18:02:34 +0000
Message-ID: <eb9c07d4-e6db-34e6-bcbb-e8efc30042de@amd.com>
Date:   Thu, 21 Jul 2022 13:02:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1 1/4] selftests: amd-pstate: Modify amd-pstate-ut.sh to
 basic.sh.
Content-Language: en-US
To:     Meng Li <li.meng@amd.com>, Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
References: <20220706073622.672135-1-li.meng@amd.com>
 <20220706073622.672135-2-li.meng@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20220706073622.672135-2-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:208:160::26) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7189f5d-953f-4df0-de0e-08da6b433033
X-MS-TrafficTypeDiagnostic: MW3PR12MB4521:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2tU73JJzuB99NdowSoS7ChEjOpB8O+hhtNbiHrT/xn6Ak4DV4W1O2EZ4N74ohZOoBcK0PtJq6YxkXGWzaUnnxf4sZ0XxoF/XQ8IROPNV1iUs/7rqEyhkw1A9t3SfotW7e4PUu6q4sj3IK72s/W9/lH9+ZtTCC3Jh44QtRcYRhi2GAeHerJFacTqkim0AsmbcpTp/f7y/HSoZNSl0Q0yg6Iun4QjEkhHK6Dsz+F4UJ4SxluFgn6wim2mSwSEOm68jZTOCR8N8gCRGej+rmVeEX/6IpbglwR+gvWT6e00v7lhuylz/kA56VuLfpLoQjdujMjOm+HpKbQqxk6aSojMo0A7vLKGOQIqJ9/HXJd9KYQ4PSj3F7cB+15DPTWwqFU42oER2YKYhRvcPVxcmPrSSGFwsVgdNwj/a9UBnD2KSnzvOb5+JE3AUtVvAzMBJM3oivAN6d3gQCOpwZVRoKfI5r7nn0OYQMnWQPruoDfLyTtxhtAbUwGTG7I6qUHlXy57Goy/a0frr1/8THpIir0sEICTWzOjJ9+QbSGsBMb7Wa/Wxo5Ic1DZC9B7s3vGFXxVR81Mn2PMsEx4OXqNLOvu8exAH5YxQQUDWwEzWyjeFQ71mxvwH96qs4PZ/iqczaS3b9H3U+DvUZ6pven+1BCAXSFpNJJGMCa0nCw93u4shPCSbCKPSmxhDR2RpcisvMBSWwZscPfGzLG1oGXk/aIltwPrJ7dPdWYy1bGjB6nznhSySv/R6xheR4ex9Qg80CrUzDSxF6VdNo6cupK+10zQu2q4XDEM0yHIkk5INqWcJJE2WhbkbtnUbAnB45QMx8e9vWkvaWH8yXpIxtG3lRWhlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(66476007)(66556008)(2616005)(6506007)(5660300002)(66946007)(8936002)(4326008)(6666004)(8676002)(41300700001)(38100700002)(26005)(6512007)(53546011)(2906002)(316002)(110136005)(54906003)(31696002)(186003)(83380400001)(6486002)(31686004)(36756003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXEzWURITFdkc2lvMmVwM1hSdjVLR3dOQU9GV3NmLzVHYkFRYzNkNXVVZElv?=
 =?utf-8?B?MTBXajc2QTQ4QXkrdk8yeWtTVTJMRkNrNWFKZTFFTzIwY0llaEF6b3Q0UWRG?=
 =?utf-8?B?NCszcHE1YnBmd3dscU5YTUZJdnF1QmRZOE9MZ2dQK2dOdFV2OXR1WUhDL3NB?=
 =?utf-8?B?QU1LTUdjMTN1ay9xRW1hNVR0SkdpdFdveWZpVG9GODVQN2ZHakpORmFpdFhh?=
 =?utf-8?B?N3F1MXFjRTlqOW0wQy9hNERmZk5IbEowVzFqSWxwREljOGpodk91UytZSnZ6?=
 =?utf-8?B?eFJrU3B2K0dxVkY5Y3hwOVZ6aW9hOG84MzFhUWczeXZRUjk5RVlQcHo4WUlZ?=
 =?utf-8?B?aGFlM0ZabDd3UDN2cnllU0phZSt4Sm13Q2xVZU1mSURaaStuM0lOdlVCYVFL?=
 =?utf-8?B?QzI4QldMNUhHcFV5aVZSUU04ZVlLeERLTGdabnI2NE5BdE4rbTJiVzdrcHlS?=
 =?utf-8?B?cHY5TU1EZU1WUWo4U2tqT2hIN1JJY1FZbm5ydjB2eE56THNRcnZ1YUJjUURz?=
 =?utf-8?B?VW5HYVNHR1ZUQnJtYjlSMTNqaVdPN0NIVGJEeVFnd3VWNE93eHdXU2Nkb1Fr?=
 =?utf-8?B?anByQzJ3QSszcGxuOVcza0d5ZmhnS2ZIYmRreEZQblA2RExaZC9icTNxNWNq?=
 =?utf-8?B?MDR2bFg2WFJ6Ty9EMjJSY1YrUnhaMEdJVnhYZDB0Vm5EMFhkQXArRVlUTkhH?=
 =?utf-8?B?Wk0vZ2l6cUFvWm9QaXpMTkNJNE1SeEpwQThYNDl3YUdaU0t5eXhqSkxyTzIr?=
 =?utf-8?B?anZJT3kxNHlKZXM5QUpmNnpGYXpZNEdDK2NIMm81MjVUY1YrOVBDV2kvUkR0?=
 =?utf-8?B?amxJODJmaWlBd2xiY0FLdWJ6NVNLbklaVGlzZHhncVk1V3pZcUdBOU1BWHE1?=
 =?utf-8?B?dit3Sitaa1k5ZHpua05VZEJnalFmZTVxc2ZpVjNZOVNFQXlHcTZvbVIvMWRi?=
 =?utf-8?B?eTBtVG5Nc2N0c0ZJMEQ4M0xMWUNHTmVqNzRCSE1pa2NoUmJuYlFpLzVWU3FN?=
 =?utf-8?B?b1NFTUNydlZsT0VybW03N3FqY1RaYlZpVm5aMENiZGU1akp0TlUvdXlsZnJX?=
 =?utf-8?B?azh3cXl3R1dqMVY1Q0sxOTN4b21tSWpsVkhhRlluR3BVUDZyS0I4Zm81bXJs?=
 =?utf-8?B?ZS9QTEh6TGNkRERBSVFYMXlQUWV2Z2d3SmI1d3E3WHdya0xVTEZZUWpnS3JJ?=
 =?utf-8?B?SmVYQ1FuRGtWWEtiR2hhcStnQW9sYVlsZE1xSHVVZ01GV3NuSFpCc1l4ZmFk?=
 =?utf-8?B?bFVJL0VGZUNzY29jeTFab2g4RTBMdVgzL1k5dkFyRWRYYVpCdUI2eVhIUytl?=
 =?utf-8?B?N2w0RlNaT1RPMS9YaWM2b05iQ3IwVk9HRjdaQ2hSVUt5K1hJYnAxWGFyMTBv?=
 =?utf-8?B?em15YmVpY1IxVU1ENFJzTU8vcno5MG4yQVJKdHF0bGpOeGU2eHdHR0RTdFdI?=
 =?utf-8?B?TUFxS3dPMXYwak9ucnZsVGZ2dldPRWJ1ODJ1WkpENThUTWoyOFJDZVd6Tjdh?=
 =?utf-8?B?SEpXa1l0ZlBMM09qMG1mSGZJdHpSRU12M0RXMTIzRWhTNXlvYjdneTBSZDlQ?=
 =?utf-8?B?dFR3Y1VYVHZDOURvYlZxQWU2VWZ5Z2ZoVUtETEhFZU1HWVZSYm9oNEU3amdX?=
 =?utf-8?B?NkdRTEhsVVFyOGRaUU9WdEZuUXlRZ2ZITkpkdzJ2OWZiMkczQ1RudDZ0Zis4?=
 =?utf-8?B?OUtQMGNldUh4NzNMTkhxam9DWWtwNnJUcE9Bb1ZaL0ZNYTJTR0g2K1ViUkFC?=
 =?utf-8?B?SzN1bng3aHhwSXlNaEFjTENOVDFpeHo5dmdpVDJqbkdWZkdOVzZzS3VFbjhW?=
 =?utf-8?B?cjNSeC9EMldIazRscUx3eDFGbmF3RzN3L0tpNThwU3lKMk1oVGNqblpGbXIv?=
 =?utf-8?B?ekRPVDdkaE1HQ0dFSWJjYjFaeWlhc29ZQU02SEtaREVPd1o4VFBVQXhLeDV2?=
 =?utf-8?B?dEpUSmhNY2NRYXZYd3l3aERpdkpMTzc3bG5uZWwxNUZtNUJhdUNwR0RBdnBH?=
 =?utf-8?B?SXZuUE5qMG5YL2ZYTEM5azQ0V2pza1JqVUJrSHhIU3RGUGlCS2RsVXpnT29o?=
 =?utf-8?B?VnM4RWtyMWw0d2t5VGNOTWN6UG5lZ0FOVFlvYXFDYndkcVl6RUgvbThYMUpS?=
 =?utf-8?Q?1BxxhTHHyFVuLcSQEONEjD+Lc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7189f5d-953f-4df0-de0e-08da6b433033
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 18:02:34.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sd5meW1uBfy2u5jr5XdA8kVXtr3R+BWTvr1pXfpCdQnpgiOU+Qo+bFAukTctoVGxxtaRXhsilcDtHWOmWqeshw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/22 02:36, Meng Li wrote:
> Modify amd-pstate-ut.sh to basic.sh.
> The purpose of this modification is to facilitate the subsequent
> addition of gitsource, tbench and other tests.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
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

Small nit. You have two different indentation styles for your case statements, do_test
and pre_clear_dumps vs parse_arguments. Would be nice to stick to a single style.

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

run.sh seems like it's just a wrapper for main.sh, can these two files be merged into a single file?

-Nathan
