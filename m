Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B082577E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiGRJQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRJQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:16:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42631101CD;
        Mon, 18 Jul 2022 02:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkO/WT2bTOhHsSFCMtbyoUdQx/odDlUVV6TLTZFNTgxVAwyiGvgC2Jylg6X6kE/umUgHvyOPhU22xTd1oz/yB7t5aYHe9AEXBDsGOr2zPiT7v/Ng9WWJXNskKz1M9EBnWtoK97mfDv4rGqhY2MjhmI0DZpH0eXJjQYQgJ/6KL1orcFjfLMj54nCYjpSEpil3ePrDd2N95JWqtBkTlFIURqlylQUNTIymS6g5MMwggBy16XiZu8ygISAQXbGZoy+zgB/ooQiR8Z1AanakvLhPz0bn5OtTFVeKDXS8lndm2t4R7deNq2e+5W4Gxwf4fH74k6FK+PWWPJyWLABSi6GLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBTMfJS6CQkaCHMVukTuO+SANNic43xcHWWDpP80oNU=;
 b=grxOTH09Zud1/mq+gPI3ZYlPNEqZMT6Fow3L0dCEbKUCllMFn3raUY+3xZwjOB/JaKDMwjbUI5srBfxs77drwN09FtwrhnEOFJeiT7rBAXHNtBUmSB79dkLGkjiefx46dPr93j7G4fY7w89PrjaIlNFpWu84jG/r1dO+H6zUCcNmt8aCgNU1P/LiYlkXHK5zndivjOjHZIZo/jmjJtYqhioHGLs6D4oaeY358TBXwlRf9BqchHfqZieL2j7ird2H1criyfa08KYcdzp+oiZwkKpIzfLV73s9ijtDFBzw1QGz4EXVVX5ib8LHNMRwQKgZL0vm4D1Cn9lXOGlO4rEWlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBTMfJS6CQkaCHMVukTuO+SANNic43xcHWWDpP80oNU=;
 b=hkinSjWzGCcdv2TevqYS3aIBzIx3nBncDrum1ihqxiFgt2RC9P6x+8CJrqoHLSAclNaXL8orsiZJGlJbiB8VvZrv4nj0zuPdTifZ8zLaNzrM+YBlYjW/2NleuZHIHp3OUFv4reupIsrfhIk4Z7Ns0z9pX0t54koF0UD5jzuJh7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 PH7PR12MB6719.namprd12.prod.outlook.com (2603:10b6:510:1b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Mon, 18 Jul
 2022 09:16:34 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 09:16:33 +0000
Date:   Mon, 18 Jul 2022 17:16:09 +0800
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
Subject: Re: [PATCH V1 4/4] Documentation: amd-pstate: Add tbench and
 gitsource test introduction
Message-ID: <YtUk2YkYvHapgQXA@amd.com>
References: <20220706073622.672135-1-li.meng@amd.com>
 <20220706073622.672135-5-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706073622.672135-5-li.meng@amd.com>
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7320dae-cc7e-407b-9c44-08da689e3540
X-MS-TrafficTypeDiagnostic: PH7PR12MB6719:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfKAnjjLMpKzz++GEjZf8veFrQ67A41QDbUyopSDkfjqmzReuCv3LeJP3yZWO3oBilL39++OMquMTUiTYw613vkod+TqnushD7P8n5gkO9cRWnokS2rwlaz0MOb1mUMyJe0d5kf+KoIlZqKB2H30n7T8jq3Z/f5lK0Ybxs3ZHLdA2PQNJNCEZkSLK+0LuHgKFTV386GgvRA3jvF9UCZd4mI6TLOqnQb44Ezr/yALc+e/GQfbXkpPkHiECrpOkkpC9zASM9AmtVdEyREtRieTNZIoQEurqyFpP3eAtYRs4dCfLl5dBC5Fn5AG/ukDyw2YS+10y9wio3ISjgf/lwOTi6MnhWahzYRA0NyqgABpjOeGud4ud+4CK77rQ1W/AVHjDchj+0/ch+gToL5eLJwsTqKHoyqYmLrwi2v76t3oQvxr5sumzkiIozz7PyPO3Jrt39OaeMD/7I4Gv7wUDh6OuYR4rinD1jbYU/OazjF3IE/p08+PDdVFhLxPXtrDgfbjjRDVz7ZaUGTqoeTKRkU1pOhO1+qPX8aLnOxwO0YGyFxHR6ahvMitYzc/9gMXqRH53wFGteUh3Db7htHRoh1oxXU4o9Lwo2I8kycVWFTd+u4aSxpud/IKCU60AZbPSv1dDkU9xq5R7h3Q2b80HeNE8VJjRwxprykjwqRtNfgV/kTISqUmkcVIdRAgMVhgWudF+NMj3qqutvVa1gzVclLGndV9QrqVE1kMlphRJhDbD4SVDqlAe7TGhh8A7WbaIXv34vGaQ+4/lzqlnhEP/rKTuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(2616005)(186003)(41300700001)(83380400001)(6666004)(6486002)(478600001)(6512007)(2906002)(26005)(86362001)(5660300002)(66476007)(8676002)(66556008)(66946007)(4326008)(40140700001)(8936002)(6862004)(38100700002)(6636002)(37006003)(54906003)(316002)(36756003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xzpWHyoYMbR8cnHESZ8kbCbx8RE1b5gGPKVN8um/icyMa2njiB+2j24mBtIV?=
 =?us-ascii?Q?JBRdqNvoaUR5ZtuPdUZspTU5IhXehsoGtpO1udWrq5hwnIJijawuISaYi2sr?=
 =?us-ascii?Q?1Ss4CtfMp+c70mGAORCkjr9lBldJ40ImDGJ4A+x2/cbMuoGKc/STVa5LmSAA?=
 =?us-ascii?Q?w73RaJC1kEUS/fcWewhErVBlt6VDBVSALP99Xfgdsulj+47kTyKmKX7irc1G?=
 =?us-ascii?Q?p3CRkVTMk6kliSmXv+4FhGxeCw6Sswi+o8pCx+eA845gMEFk8/lHMuXf2Mi5?=
 =?us-ascii?Q?jOAB1ZwSKstBySDhuK8nacWptLu1nlkSey24ubBBomQY8xxYgBbaj/5n3oe1?=
 =?us-ascii?Q?6odcMJUbj7ZwY24IGYgWTOjMNg927UUMnV7ISZ5EsSQhjSNKiMNB43/ZnjI4?=
 =?us-ascii?Q?TPYHPHx0z3T6my7KkPIWJAvW+dKP1NqcSyj+n5s3OMSDYN3N3/v0cAVQ0NGd?=
 =?us-ascii?Q?DYZbTt8lzdbXP4E1fWJuqzI1HRtgDpzbyMbJ5f5giwGZiTKUqn9xmBgudpt/?=
 =?us-ascii?Q?z5nQPj5rbXxlJhv95DYIGkrba9TCh3noRhebblJKyAR2eQlo+Xq3lSqxfZha?=
 =?us-ascii?Q?rlgfrXVQfrLkcbb2avuYYALYbbDSlLofeIrSK2xbvLeOQ+MMIq8eCW4A5+H/?=
 =?us-ascii?Q?3U9m2WJPcUuxM4Ctns9gFD5BccXdJ0BIPwkQAedRfEXS7leGWa/ROZbXWjR8?=
 =?us-ascii?Q?75YMHVFzr0n+aF9656E6bIxj0xHJnJ5f5bxXThB24IXVzFrH4cF9beGHiPRI?=
 =?us-ascii?Q?TZx92J2ka2xsRhjuQeBx9v6+qg1PwYA5EOVdv5BulaGisLuIqXJx11apSEpn?=
 =?us-ascii?Q?T/4Dy8tkkYSh55KJF9QslsEU3l/NMYRMrGiqowvOrS7HlM2X04CvBWdhwl+B?=
 =?us-ascii?Q?yUBJo6Yua1yxXW9U9Md91afABoRv5EEfOp4+eVt+fvRms3TnVcph0HYKDmRC?=
 =?us-ascii?Q?wbjopUB9xe8bAxeNnb9pHFerQJQUMpda8wrZ2NzQAoFln58eg2Iy6i16KmED?=
 =?us-ascii?Q?iDe5oMve9d1A6qQB74nQoN17SGw20NMGmoit8E8ntKH5KrrkuHDUOTaLGmc1?=
 =?us-ascii?Q?ke5fqN/tUybjsOYfKYuTTlFV/TWpzXV+nJMrCnGNSxPhzQf9gCu56Flk8p3R?=
 =?us-ascii?Q?8gAfm4D+Y3tKBwxfn+KHm9JZxF4vepbVrqtlPon/thCTEILdSq+RHyNl0BIB?=
 =?us-ascii?Q?XddswvkeyGfcIwpu3HOdSIPrnNI/fJB/jLOy4ggw3nTarjINA6dX6i+E1BOe?=
 =?us-ascii?Q?Usvi6T6dejnztpdBKgXO7BqkCB8DgTVTP7VX1LcjSbAVsrXrRXOv9xDZ63tV?=
 =?us-ascii?Q?FAYhAZHp3Z2+qB5KwhiJSCXx0LGCL0uCU8ntjD34ICzoUYoSFKGAVBRK7ZCd?=
 =?us-ascii?Q?81hE7FhdMgS4slda9H0xWysmMInJDdSjCQFpEd3fks5tAreBm5Nu+Dewwsti?=
 =?us-ascii?Q?95+nbMLsnr83fC4Yakdpr6nm/25VwKgsuQSpfbJcQMZwLUKmeNHq5HF0g9cb?=
 =?us-ascii?Q?NN8bd37emppnFXFlKbMGPY0Rp5pVhD+J3dkEYG09NwRxaHF/F04F+bZvBkMV?=
 =?us-ascii?Q?C9ug/7sRFIHjc0/DlcrS3iYtCnBjjaNzYalFrGuU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7320dae-cc7e-407b-9c44-08da689e3540
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 09:16:33.7956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oIQCMODwd88SWFUD8xXQWyJ8jzLfoclL5Wnbn3OzJT+sG1zE+aqKPT2arp2E1azAC4DDXz5HMEwE/8pco7mpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:36:22PM +0800, Meng, Li (Jassmine) wrote:
> Introduce tbench and gitsource test cases design and implementation.
> Monitor cpus changes about performance and power consumption etc.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 124 +++++++++++++++++---
>  1 file changed, 106 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 8f3d30c5a0d8..48fb488e000e 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -409,37 +409,53 @@ Unit Tests for amd-pstate
>  
>  1. Test case decriptions
>  
> +    1). basic tests
> +
> +        Test prerequisite and basic functions for the ``amd-pstate`` driver.
> +
>          +---------+--------------------------------+------------------------------------------------------------------------------------+
>          | Index   | Functions                      | Description                                                                        |
>          +=========+================================+====================================================================================+
> -        | 0       | amd_pstate_ut_acpi_cpc_valid   || Check whether the _CPC object is present in SBIOS.                                |
> +        | 1       | amd_pstate_ut_acpi_cpc_valid   || Check whether the _CPC object is present in SBIOS.                                |
>          |         |                                ||                                                                                   |
>          |         |                                || The detail refer to `Processor Support <processor_support_>`_.                    |
>          +---------+--------------------------------+------------------------------------------------------------------------------------+
> -        | 1       | amd_pstate_ut_check_enabled    || Check whether AMD P-State is enabled.                                             |
> +        | 2       | amd_pstate_ut_check_enabled    || Check whether AMD P-State is enabled.                                             |
>          |         |                                ||                                                                                   |
>          |         |                                || AMD P-States and ACPI hardware P-States always can be supported in one processor. |
>          |         |                                | But AMD P-States has the higher priority and if it is enabled with                 |
>          |         |                                | :c:macro:`MSR_AMD_CPPC_ENABLE` or ``cppc_set_enable``, it will respond to the      |
>          |         |                                | request from AMD P-States.                                                         |
>          +---------+--------------------------------+------------------------------------------------------------------------------------+
> -        | 2       | amd_pstate_ut_check_perf       || Check if the each performance values are reasonable.                              |
> +        | 3       | amd_pstate_ut_check_perf       || Check if the each performance values are reasonable.                              |
>          |         |                                || highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0.           |
>          +---------+--------------------------------+------------------------------------------------------------------------------------+
> -        | 3       | amd_pstate_ut_check_freq       || Check if the each frequency values and max freq when set support boost mode       |
> +        | 4       | amd_pstate_ut_check_freq       || Check if the each frequency values and max freq when set support boost mode       |
>          |         |                                | are reasonable.                                                                    |
>          |         |                                || max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0                   |
>          |         |                                || If boost is not active but supported, this maximum frequency will be larger than  |
>          |         |                                | the one in ``cpuinfo``.                                                            |
>          +---------+--------------------------------+------------------------------------------------------------------------------------+
>  
> +    2). Tbench test
> +
> +        Testing and monitor the cpu changes when running tbench benchmark under the specified governor.

Test and monior ...

> +        These changes include desire performance, frequency, load, performance, energy etc.
> +        The specified governor is ondemand or schedutil.
> +
> +    3). Gitsource test
> +
> +        Testing and monitor the cpu changes when running gitsource benchmark under the specified governor.
> +        These changes include desire performance, frequency, load, time, energy etc.
> +        The specified governor is ondemand or schedutil.

Test and monior ...

> +
>  #. How to execute the tests
>  
>     We use test module in the kselftest frameworks to implement it.
>     We create amd-pstate-ut module and tie it into kselftest.(for
>     details refer to Linux Kernel Selftests [4]_).
>  
> -    1. Build
> +    a. Build

Why do you update the 1 -> a here?

>  
>          + open the :c:macro:`CONFIG_X86_AMD_PSTATE` configuration option.
>          + set the :c:macro:`CONFIG_X86_AMD_PSTATE_UT` configuration option to M.
> @@ -449,23 +465,95 @@ Unit Tests for amd-pstate
>              $ cd linux
>              $ make -C tools/testing/selftests
>  
> +        + make perf ::
> +
> +            $ cd tools/perf/
> +            $ make
> +
> +
>      #. Installation & Steps ::
>  
>          $ make -C tools/testing/selftests install INSTALL_PATH=~/kselftest
> +        $ cp tools/perf/perf ~/kselftest/amd-pstate/
>          $ sudo ./kselftest/run_kselftest.sh -c amd-pstate
> -        TAP version 13
> -        1..1
> -        # selftests: amd-pstate: amd-pstate-ut.sh
> -        # amd-pstate-ut: ok
> -        ok 1 selftests: amd-pstate: amd-pstate-ut.sh
> -
> -    #. Results ::
> -
> -         $ dmesg | grep "amd_pstate_ut" | tee log.txt
> -         [12977.570663] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
> -         [12977.570673] amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
> -         [12977.571207] amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
> -         [12977.571212] amd_pstate_ut: 4    amd_pstate_ut_check_freq      success!
> +
> +    #. Specified test case ::
> +
> +        $ cd ~/kselftest/amd-pstate
> +        $ sudo ./run.sh -t basic
> +        $ sudo ./run.sh -t tbench
> +        $ sudo ./run.sh -t gitsource
> +        $ ./run.sh --help
> +        ./run.sh: illegal option -- -
> +        Usage: ./run.sh [OPTION...]
> +        [-h <help>]
> +        [-o <output-file-for-dump>]
> +        [-t <all:       All testing,
> +        basic:     Basic testing,
> +        tbench:    Test tbench,
> +        gitsource: Test gitsource.>]
> +        [-i <tbench time limit>]
> +        [-p <tbench process number>]
> +        [-l <loop times for tbench/gitsource]
> +        [-n <amd tracer interval]
> +
> +    4). Results

4) -> #.?

We would like to align all the number format in the paragraph like below:

1.
   1)
   2)
   3)
2.
   1)
   2)
...

Thanks,
Ray

> +
> +        + basic
> +
> +         When you finish test, you will get the following log info ::
> +
> +          $ dmesg | grep "amd_pstate_ut" | tee log.txt
> +          [12977.570663] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
> +          [12977.570673] amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
> +          [12977.571207] amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
> +          [12977.571212] amd_pstate_ut: 4    amd_pstate_ut_check_freq      success!
> +
> +        + tbench
> +
> +         When you finish test, you will get selftest.tbench.csv and selftest.tbench.result files form amd-pstate.
> +         Open selftest.tbench.csv :
> +
> +         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
> +         + Governor  | Round   | Des-perf | Freq    | Load     | Performance(MB/s) | Energy(Joules) | PPW(MB/J) |
> +         +===========+=========+==========+=========+==========+===================+================+===========+
> +         + ondemand  | 1       | 203.244  | 3.2225  | 87.5064  | 35368.2           | 6626.1         | 101.4164  |
> +         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
> +         + ondemand  | 2       | 205.861  | 3.24948 | 88.9281  | 34795.7           | 6547.06        | 100.9794  |
> +         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
> +         + ondemand  | Average | 204.553  | 3.23599 | 88.2173  | 35081.9           | 6586.58        | 101.1991  |
> +         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
> +         +           |         |          |         |          |                   |                |           |
> +         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
> +         + schedutil | 1       | 253.735  | 3.26755 | 96.6481  | 34653.9           | 6622.85        | 99.4170   |
> +         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
> +         + schedutil | 2       | 254.654  | 3.44086 | 92.3564  | 31707.8           | 6573.67        | 91.6456   |
> +         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
> +         + schedutil | Average | 254.195  | 3.3542  | 94.5023  | 33180.8           | 6598.26        | 95.5456   |
> +         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
> +
> +        + gitsource
> +
> +         When you finish test, you will get selftest.gitsource.csv and selftest.gitsource.result files form amd-pstate.
> +         Open selftest.gitsource.csv :
> +
> +         +-----------+---------+----------+----------+----------+----------+----------------+----------+
> +         + Governor  | Round   | Des-perf | Freq     | Load     | Times(s) | Energy(Joules) | PPW(s/J) |
> +         +===========+=========+==========+==========+==========+==========+================+==========+
> +         + ondemand  | 1       | 29.7305  | 1.13025  | 8.49585  | 341.61   | 6811.02        | 0.0501   |
> +         +-----------+---------+----------+----------+----------+----------+----------------+----------+
> +         + ondemand  | 2       | 28.0523  | 1.33848  | 8.16496  | 339.21   | 6999.84        | 0.0484   |
> +         +-----------+---------+----------+----------+----------+----------+----------------+----------+
> +         + ondemand  | Average | 28.8914  | 1.23436  | 8.33041  | 340.41   | 6905.43        | 0.0492   |
> +         +-----------+---------+----------+----------+----------+----------+----------------+----------+
> +         +           |         |          |          |          |          |                |          |
> +         +-----------+---------+----------+----------+----------+----------+----------------+----------+
> +         + schedutil | 1       | 29.6971  | 0.834149 | 9.57879  | 278.15   | 5992.26        | 0.0464   |
> +         +-----------+---------+----------+----------+----------+----------+----------------+----------+
> +         + schedutil | 2       | 31.6573  | 0.99686  | 8.60513  | 280.28   | 5772.59        | 0.0485   |
> +         +-----------+---------+----------+----------+----------+----------+----------------+----------+
> +         + schedutil | Average | 30.6772  | 0.915504 | 9.09196  | 279.215  | 5882.43        | 0.0474   |
> +         +-----------+---------+----------+----------+----------+----------+----------------+----------+
>  
>  Reference
>  ===========
> -- 
> 2.25.1
> 
