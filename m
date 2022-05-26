Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6F6534AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346402AbiEZHcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiEZHcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:32:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A90B95494;
        Thu, 26 May 2022 00:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfvsWvOewErEC9NbPzTxfxMOjV9lFOqT0/5q/CkoePYEuzRyTVENr6NfObfsD+YY1Gvw2o79OaqSFUda+I6YSTPVzzujY7JlP+GS0Y9ZRRcB1T0CXbY2dMgkSlPl7pfZzsPzOawqfXGmOVKlo1iGP75S4St2PIzTlIlMi89d8acNmOkNqgTvpn+EJ5OSpE7JcqKrm+QGHlSln98Ebpxp7lNDfYdi9zTbgE1JBBwb/jC8S9Hf2xh8VxW7WPD4hCMIuohJfFGvRIFaCaXtHgpeEKnMMpsXzWUieTeiZTTFStH5FdRGukZUMoFzgI+mWsw4/ZB5MPJ0NlUdsqw4oYmh9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffZkGgdfuXmmKFbuS4UauJ6QxG83Je8PYABo0wTLC2I=;
 b=nuZayhelJFxeewxTvMtXU7c4b2nMmGBL0+v3dlrZg6Nn8wAtkVsQiGotfLK6ZEIB5jlAeIJ6yKWS02vCFQDCwmaFXvB/QN8jIRsc1jXyxLUfBo9S6EKJWcHfVpDrq5bqo/yeD4Ai27GM+vS52At6H+O4N7h485Q9A9tZP5k/MbwCVhEvG/lL0tjEZcejrlXT3Q++zTzl7SpVB4da6RV+eTj10LULVdT5nss6gWMVrbrHo07qmaQJkD9qzHpwkmU57HvTxB2z2Dm4CNpayUAs3WNFer+Mv7dgjJOvX0pjqQQ+AkRlPsOWPCMZ1WkdOwere59suvbBFgLCOYo1GFWHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffZkGgdfuXmmKFbuS4UauJ6QxG83Je8PYABo0wTLC2I=;
 b=pARA6DylN5lsJrhsqV54UzEGJhO5GHq02r8Z3R+UWhO68E+0cO49r5TW2d9QCoNoSlGZmrA9P1hqSESt3u1sMQEr5fH2fWS4DHdViuJv2whqr61GF7wL23Vu9IV3+3da2mszwcTk54ij+euIZV2M7RB6phjxuL1jaUuZ1mGjRjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN6PR12MB1858.namprd12.prod.outlook.com (2603:10b6:404:fe::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.16; Thu, 26 May 2022 07:32:00 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 07:32:00 +0000
Date:   Thu, 26 May 2022 15:31:37 +0800
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
Subject: Re: [PATCH V8 0/4] Add unit test module for AMD P-State driver
Message-ID: <Yo8s2Tn0EKohq/k2@amd.com>
References: <20220526034725.1708916-1-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526034725.1708916-1-li.meng@amd.com>
X-ClientProxiedBy: HK2PR0401CA0018.apcprd04.prod.outlook.com
 (2603:1096:202:2::28) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53cf4949-fc38-4d1b-b674-08da3ee9d20c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1858:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB185857531E14F3F14801D135ECD99@BN6PR12MB1858.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVA1Ns6f4bsARHspsEBtVA/vG4zy5sW3/XieWORzCRIBmm0J8DmpRrVuV82s3QdNtMzgGJ2AxA9K9D94IgiZq9RCf7/Rd1Ya/oHwHlK5Z1DX5gdgfMtThCQL5eh3ZCTeK1LtjzXQSQKMK+5dKDVXKJfYF4Dss3mUwoM8KBm/LduZWtnX9etjgO1G7J2wyIbXSy1co4RlWuA8xkPL3JPU/KK+HeOIZZiMk1SFKYoUnoYi0+fmLwHzVd+sgnCSDi28rzdtCLg9BwBsLQuBR487xpLVAsumt1qfnNmphLE6ROZBt48lKd7HmqdHdZQnAVrYT1jDrJGiivFtqIizS9uykD52SpB1UJ8wYUaHVCexWdW3/FBSqBUyZEbG9Nf3UWi/z+FmmLa3kf4eFdVsvygvjkgXsoxzV/lo84qQB8AgqH1gNnluhmHN8yEGs/9R9nxQg+3kTQIhQYVfZH9pJedOfb/9KYj0Au4P5tCf6gn+bZiWqdHjS4j8+ZxFnQKGNc2+oewBIOyF73aArtLdPcdQ1v6fsXtDtllhZQfhiqA4yXRw7canqvHjP6Cs1oxNnWYwtzZJ4iyVrwxSb/WJA1TYtj43e8hzqek02seIN9rRi8pCE6o4xy9mBaMo3/dI8E8eNe+uAzj8LKvyj0KegcKiaqILvlVcIqgQVsvvbYS1/aP8YfRUrbN/YFmYImUai8wiXSEFi0bwEXV8CSX7Hb9LQkIW6/UXgrniYo/bCdxwUf/MKNjhVcneSjwrwVVaMnLvuSsRQbSIHJmSGikjTwcXpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(6506007)(36756003)(66476007)(4326008)(38100700002)(66556008)(66946007)(54906003)(316002)(2616005)(6666004)(37006003)(5660300002)(6636002)(8936002)(2906002)(6862004)(83380400001)(508600001)(186003)(26005)(6512007)(6486002)(86362001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tf8nOqNf9r25FVBq8C1z7qzRUb1bRwbTbSTU4FvSM3oDluMEEOETgQafnBLu?=
 =?us-ascii?Q?qKzzVKA+NsJgkmuS+2K+Zios8ugg9LBVilf/NxH7oDhlkqaV6vYh6+m/E8Qj?=
 =?us-ascii?Q?m8fgpGAgQW13lbf0wSvyHYa05jnapOEvKISDcR62GL35l6pLaEhTRKi6PxQo?=
 =?us-ascii?Q?WVdvAfpAqOz7mfjiaP4S2nAMg8aybaSdjIecCmqcSL/2QSelrybuJs9QP+EX?=
 =?us-ascii?Q?urugVMxzBoYCOcLg2PoTogtaOs7MeKkmw+jZq/RNhHBN1DIggzvSNefWZBe0?=
 =?us-ascii?Q?lxiziI0v/RjkFqhRsShUJ21f28+PRHrJeZ0do7lpqm5MNpT1F8RjAWq8HFFq?=
 =?us-ascii?Q?cHenPYhMUo1oyyYzT+emeCyz6Ft1qOTQHohyQ2uErdQMGK+HA6u1nRs2DxyZ?=
 =?us-ascii?Q?L3ifNR+MWLZ1yNyqQoBJAYc4Fw7vpHuBQB+VfNFi3e+2OV4PkXm5XbG7KhYl?=
 =?us-ascii?Q?gSKZuUVcr7sJbHWZYsAkCLmWpFZ9X11oCCn9Be/Ge8ok8OeqmtaWPF93mxqI?=
 =?us-ascii?Q?U1Yxc1YcE+LU4O5LNcrdDFGiOFv4/FPWhVFx6sbr1yU67EJONJtZm3pQJruJ?=
 =?us-ascii?Q?PaDsVD2RIlgIC5y1TescZ9zRP8T0DrNeNAZY7p/aKJUrWvSPuo1mXfEbcFEW?=
 =?us-ascii?Q?WGIJnTjvwO28NmANZEZkVxK2A+Sr6WZhxO2FG9RJ+HQQMGxns6M76++kxaoI?=
 =?us-ascii?Q?ojqRfkG1dcF4E/bpunk0yONnn05Ae0+phAMiozQceoRzzQvJ+2+fGN89zOBA?=
 =?us-ascii?Q?T3iLFhZY2EdlzjsNnSVfvtq/he0LMoWUAs8aPCmgSPziumOVneTyqIVn9S7D?=
 =?us-ascii?Q?y6yj+nwrqEhiOPbkBb4k7kGWGXOPcxHXkRl2tVI94NJyWK9xvUcjd8jW5bzm?=
 =?us-ascii?Q?6X0W1coqJn5P/lzo8MmYaJmxgeFKvcEwCyN150zTYzJcdqszp8Yrp7nCm7dx?=
 =?us-ascii?Q?zGupWm/AVzKvgUSvMWo2oO50Y5XrPedewudTzSuaeMuwF/0hqdIjimQB8KfY?=
 =?us-ascii?Q?G+ltJZGNeViAU1q11qcSIwPBgo2Wq6z9iYLFwM8GXAnsssDBTLkDZInuUtoh?=
 =?us-ascii?Q?bgJNFoahoLGOWS/Ab9kYIabaA+QIKo6HQSpOMLu75rRQNpiQZ/woqykjNhzt?=
 =?us-ascii?Q?+ca9bFq0rYKWJ0WSfxsRXRXOyXNKrNaF5FLxf3ndMRTexi4bcYqjBkWqWyvh?=
 =?us-ascii?Q?/EHS4gmWZDAhz7kjFC7F3XPGt9sd+9u3E19VQ9SO5253dCNy+x0jPHQNg1ap?=
 =?us-ascii?Q?/c++G4p71eNehJRbTJBN8GdNWfZDyNeVGExbhjvUa76HYgAUuXwqlRQkHgJb?=
 =?us-ascii?Q?RsAdQAlQWNp87TU0iZUIRED3h8mdhWGpBhbUGOoNpYukZPfVVHTNxxuSqC9N?=
 =?us-ascii?Q?179QB3QuZrGDfwPStJCvJ+ozUBhdLQ/9UIR4BFar0yUSMe02pxVVPy4TYc7q?=
 =?us-ascii?Q?XyJYVifq3YUOwqCOkNNEubmedTkdY4eigbj6wXlqR/69kvc6UWNZxZuQ8Fi2?=
 =?us-ascii?Q?qX5Ao6R+5Fo47zLiLsoqZ/tILvBIXhiPozFKgH6xp+wN6PtXeFjr7vmP3x5v?=
 =?us-ascii?Q?noP6GUNA0od0ixvzR9TlhdA0suRVZ1x09Llcu7zdtYON39C3pZ2Fq2VG+tFT?=
 =?us-ascii?Q?0I3iozz3kfYwRmyVYYo77ra/YQwwnQ3ylkU/r39cmU2omOJ3KSfdONZ1Wxay?=
 =?us-ascii?Q?0vuKevCiKy8wrcvyG2agVQAls5XCxV0nen0cYY1m776eNlHk+25RQfeU6mFz?=
 =?us-ascii?Q?cAN5ngotHQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cf4949-fc38-4d1b-b674-08da3ee9d20c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 07:32:00.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeYhKJ9DTek+KjzyfiPE4g8z1MFK5nMAgV5ZuhGdve1ZTtOc9w6xgtGsQHJbGC3jzVTbniuq/5NCvVUGxQOpvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_RED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These series look pretty good for me, thank you Jassmine!

Thanks,
Ray

On Thu, May 26, 2022 at 11:47:21AM +0800, Meng, Li (Jassmine) wrote:
> Hi all:
> 
> AMD P-State unit test(amd-pstate-ut) is a kernel module for testing
> the functions of amd-pstate driver.
> It could import as a module to launch some test tasks.
> 1) It can help all users to verify their processor support (SBIOS/
> Firmware or Hardware).
> 2) Kernel can have a basic function test to avoid the kernel regression
> during the update.
> 3) We can introduce more functional or performance tests to align the
> together, it will benefit power and performance scale optimization.
> 
> We upstream out AMD P-state driver into Linux kernel and use this unit
> test module to verify the required conditions and basic functions of
> amd-pstate before integration test.
> 
> We use test module in the kselftest frameworks to implement it.
> We create amd-pstate-ut module and tie it into kselftest.
> 
> For example: The test case aput_acpi_cpc is used to check whether the
> _CPC object is exist in SBIOS.
> The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is not
> existed at the detected processor, so it is a necessary condition.
> 
> At present, it only implements the basic framework and some simple test
> cases.
> 
> TODO : 1) we will add more test cases to improve the depth and coverage of
> the test. E.X. use the script to trigger the tbench, gitsource, kernbench,
> netperf, speedometer, and etc. testing and monitor the cpu frequency and
> performance goals change, power consumption at runtime. 
> 
> Please check the documentation amd-pstate.rst for details of the test steps.
> 
> See patch series in below git repo:
> V1: https://lore.kernel.org/linux-pm/20220323071502.2674156-1-li.meng@amd.com/
> V2: https://lore.kernel.org/lkml/20220413090510.4039589-1-li.meng@amd.com/
> V3: https://lore.kernel.org/lkml/20220421074152.599419-1-li.meng@amd.com/ 
> V4: https://lore.kernel.org/lkml/20220427135315.3447550-1-li.meng@amd.com/
> V5: https://lore.kernel.org/lkml/20220505022913.329259-1-li.meng@amd.com/ 
> V6: https://lore.kernel.org/lkml/20220519134737.359290-1-li.meng@amd.com/
> V7: https://lore.kernel.org/lkml/20220522115423.1147282-1-li.meng@amd.com/
> 
> Changes from V1 -> V2:
> - cpufreq: amd-pstate:
> - - add a trailing of amd-pstate.h to MAINTAINER AMD PSTATE DRIVER.
> - selftests: cpufreq:
> - - add a wrapper shell script for the amd_pstate_testmod module.
> - selftests: cpufreq:
> - - remove amd_pstate_testmod kernel module to
>   .../cpufreq/amd_pstate_testmod.
> - Documentation: amd-pstate:
> - - amd_pstate_testmod rst document is not provided at present.
> 
> Changes from V2 -> V3:
> - cpufreq: amd-pstate:
> - - adjust the order of add amd-pstate.h in MAINTAINERS.
> - selftests: cpufreq:
> - - remove the call of amd_pstate_testmod.sh from cpufreq Makefile to
>   main.sh.
> - selftests: cpufreq:
> - - add explain the goal or intention of the AMD P-State Unit Test
>   module.
> - - modify comments.
> - - use the checkpatch.pl to check my patches.
> - - add conditions judgment before formal test.
> - - delete some unnecessary test cases.
> - - modify test cases about perf and performance etc.
> 
> Changes from V3 -> V4:
> - selftests: amd-pstate:
> - - remove script and test module to tools/testing/selftests/amd-pstate/
> - - uniformly named amd-pstate-ut.
> - - check current architectures and cpufreq driver in amd-pstate-ut.sh
> - - delete codes about conditions in amd-pstate-ut.c 
> - Documentation: amd-pstate:
> - - add introduce document about amd-pstate unit test.
> 
> Changes from V4 -> V5:
> - selftests: amd-pstate:
> - - add print the current scaling_driver.
> - - add amd-pstate-ut.ko into TEST_GEN_FILES.
> - - move "insmod/rmmod amd-pstate-ut.ko" stuff into script amd_pstate_ut.sh
> - - add a check of read back from X86_FEATURE_CPPC in get_shared_mem().
> - Documentation: amd-pstate:
> - - delete the test step about insmod/rmmod amd-pstate-ut.ko
> 
> Changes from V5 -> V6:
> - cpufreq: amd-pstate:
> - - add amd-pstate-ut test codes to drivers/cpurfreq
> - - add the macro CONFIG_X86_AMD_PSTATE_UT
> - selftests: amd-pstate:
> - - delete amd-pstate-ut test codes from tools/testing/selftests/amd-pstate/
> 
> Changes from V6 -> V7:
> - cpufreq: amd-pstate:
> - - modify X86_AMD_PSTATE_UT dependencies and default value.
> - - modify a brief description of the amd-pstate-ut module.
> - - remove kselftest_module.h header include.
> - - modify shortform for AMD P-State unit test.
> - - add prefix for the names of test cases.
> - - in the file operation log, add the file path.
> - - add comments about the test cases.
> - - correct syntax errors.
> - selftests: amd-pstate:
> - - delete TEST_GEN_FILES$(TEST_GEN_FILES): $(HEADERS) form amd-pstate Makefile.
> - - simplify the judgment about ARCH.
> - - add the judgment about cpu vendor.
> - - modify the method about load the amd-pstate-ut module.
> - Documentation: amd-pstate:
> - - update the name of the test function.
> - - update kernel log about test result.
> 
> Changes from V7 -> V8:
> - cpufreq: amd-pstate:
> - - amend commit message.
> - - amend module description.
> - Documentation: amd-pstate:
> - - amend commit message.
> - - Remove the personal data.
> 
> Thanks,
> Jasmine
> 
> Meng Li (4):
>   cpufreq: amd-pstate: Expose struct amd_cpudata
>   cpufreq: amd-pstate: Add test module for amd-pstate driver
>   selftests: amd-pstate: Add test trigger for amd-pstate driver
>   Documentation: amd-pstate: Add unit test introduction
> 
>  Documentation/admin-guide/pm/amd-pstate.rst   |  76 +++++
>  MAINTAINERS                                   |   1 +
>  drivers/cpufreq/Kconfig.x86                   |   7 +
>  drivers/cpufreq/Makefile                      |   1 +
>  drivers/cpufreq/amd-pstate-ut.c               | 293 ++++++++++++++++++
>  drivers/cpufreq/amd-pstate.c                  |  60 +---
>  include/linux/amd-pstate.h                    |  77 +++++
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/amd-pstate/Makefile   |   9 +
>  .../selftests/amd-pstate/amd-pstate-ut.sh     |  55 ++++
>  tools/testing/selftests/amd-pstate/config     |   1 +
>  11 files changed, 522 insertions(+), 59 deletions(-)
>  create mode 100644 drivers/cpufreq/amd-pstate-ut.c
>  create mode 100644 include/linux/amd-pstate.h
>  create mode 100644 tools/testing/selftests/amd-pstate/Makefile
>  create mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
>  create mode 100644 tools/testing/selftests/amd-pstate/config
> 
> -- 
> 2.25.1
> 
