Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD8051B821
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244973AbiEEGpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbiEEGpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:45:32 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2061.outbound.protection.outlook.com [40.107.100.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575B64705B;
        Wed,  4 May 2022 23:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEWpSuFRRxDPUcg7cYTWlIeh5PfII0MQpr0lkqAfxR828pF88V4Hu3Nj57VRIaLf5dpzZCQuAktuQZjWPBQues4a0T1RiRgnweNEDaCc3Yx8kNalZ9KLbtc/ez7km4u7s9m6Z5ZvXD+isP2Fkwq0Tjs0vUXihqAl+hu5NJewqdOYLNTlSsK74+Jwtwz+r15GowtaaUHXtB6fFres4k0TdjZT5xuaPfeB1FpBdfIvUbyKBg77VK2TIIUBjHeGAoeWBrJnZc75CtUr89SwoKXxTWknozrHfWjwS/GTBxdN7DW/M0NSJJWb7/RcBq1qG5c6L8EHfPAftI1ezeSejy61BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tg7XLOAs2diLss8olFmgVUqDJL4jUIwI+0skqAcUH1k=;
 b=ZR+cqxMso2p2ZzIETLRXh7AST5jwdV4Cad4k7UmbQKgOLrDS3nwpSmWDc/LXew7AXpZGwmv3YBzUUtgNfGnPBONR1/ls5AcewJFI4ddWJTgNkHrtELgiSliY5NZHrAfSvhTeENA8RXmD0YRczULWNUoMWHelLcwE3Wvw+fmxu9j/Vcar9TCjauFJ+i21ef5Gu08tm2TtAJag4mBtML5nEyDJA3Te5HPV+YZUzJbDoVCVQcmVVpyIO8ujC1ejqNXo/PZlBZsHS1lo96vZAVktBLJxjog53ExZUpkWDyS6xFUsBrbaUf3ZQ7p5ocricBz0kseRdAuIYuCCQfjxx04dKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg7XLOAs2diLss8olFmgVUqDJL4jUIwI+0skqAcUH1k=;
 b=tPvfSdK7PTzWqkRxNS1YUWE+LBYjXJgm68LKuUJhUCuvaRrECNyqTeSfnnPmuf4TmhuRGsiFMyYoICY5rToMW0mFCABg2PC1WJrQGVgysojYxkJJQsc6YY3SfQ0QCyrH4WiPI+GH2vfCLCP9OzhY9bIJ4pxM2TpFUxA3at14yFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN6PR12MB1635.namprd12.prod.outlook.com (2603:10b6:405:3::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Thu, 5 May 2022 06:41:50 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d%7]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 06:41:50 +0000
Date:   Thu, 5 May 2022 14:41:27 +0800
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
Subject: Re: [PATCH V5 0/3] Add unit test module for AMD P-State driver
Message-ID: <YnNxlzRW2NGCx5dO@amd.com>
References: <20220505022913.329259-1-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505022913.329259-1-li.meng@amd.com>
X-ClientProxiedBy: HK2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:202:2e::29) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f234697e-04cf-43ab-6c2c-08da2e625554
X-MS-TrafficTypeDiagnostic: BN6PR12MB1635:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1635581981F707BFEA6E9905ECC29@BN6PR12MB1635.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gd/J5HHP+bQDRBWKwMXNB3h236yTznpvcGQVFE3hbnKoPH4ifu0M1eOVKIPk0NpWlchVgPZ8zwDtwSfbbWNBVZKDhdsKwQHWSGJLIqUIVlQlfw9C+gM/a2soQPq4wHyuDyGKxzzyWaik1AbRwjChAE5HHOLEadVFG8YTERe0oQW5TEo6pmGasLYi9fM6r85QR1MKDllKYGaEzGhGBFqvIHJhz9OjoKp/+GHzj1Q+hs8R6tRZoJ4VO+IeKq6Oi+15J2VDroJveQsOWV9e39+TA6xKcuiKFdniGCiJsQ1Z2ybg0W0bAlLkkwMDn8ZtHSMmYlbfeyreO07GN8k9JwCM9NLFVb+VDLtQdanHLnSgmLRamCA+3lHRmyf1EK0wLJ5+hxd/+fYoYGL0nupgco4mQzmobTUiV/rhUva/CJllq5sMXz0IRydkqTSoZ5L2GevlLYjm7pbZvIUgd8iCgnZNuj5TPDw2MLQxNPEmhluDsuPGTuy9n/rLwJ1o6U8VSMtMFXDuJdDABjxqQD40xaZdRauh73/xgPZQ4768TtGtxBsg+gmsrnhJ5YMVE6H/Z9p0UKLVGdpxoEEnCkglWT4GSuruWxjtECWwPr/EMdsDNFhQtpN4CQ8qDOzhGOfdsRm8v4T7XOmWI8iWOA2HO2XRMg5DJmnX/+0sS9l7FJwO9PcT6XzQng+yB3AIDO5XDyn15QS9Vu3YfMbCd9yAdkbtkjbKLX/vKxUcgYolmvMAIq/hwZTxZtoIhxpoBXKwcbTILVxTzrfLg9IlURe9I58Oxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(5660300002)(4326008)(8676002)(6862004)(66556008)(66946007)(316002)(66476007)(508600001)(54906003)(37006003)(8936002)(6636002)(6486002)(966005)(36756003)(2906002)(6512007)(86362001)(6506007)(26005)(38100700002)(6666004)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bvig89K5CBYqw3dVh0N0WmJ5cE7Ga7wWNemSWO921TckQ42lcm56UEq+J/Mk?=
 =?us-ascii?Q?vEakPdD4v5YQ7pdNjuIqagrtTVzSWopnMk/MziDBXub5G4ki23phPezrcujp?=
 =?us-ascii?Q?JD2u3CljUVji9KZ4Ed4/haxbXeo/5KVn72ZLpupd5L55gJt4I9xE8dEDFP9D?=
 =?us-ascii?Q?ZqgJAVujDgMyfmULbLRuUc5XYb1Iei6v9keZofsLm9opd6KRqUFSFlDRdRbD?=
 =?us-ascii?Q?J8+exqeZQKYp02ayWjVVYqEcEPfZWhXPhOmMD+TzHvITAQv950UeVxBKYzW0?=
 =?us-ascii?Q?GQzipZW0ODAP2iKVeDEj6pZPmLq6lqAFv67tcWlVND29sB+wuraHhkh2S8mn?=
 =?us-ascii?Q?HimN9IHt+mQtsg4xCN/Rhzs+eWbPPoYCXgTUFX/vGxkdVV4prZVMV/odC2fI?=
 =?us-ascii?Q?VhL9xVPCLv8pGrG0URQmTmdL21gvk/YOJX0ZzSXNxhJvq1JKrYCGEE/azwDN?=
 =?us-ascii?Q?MG8Grhffu1A1tdtouU5eJa4mNcIqRDDtIcuhk+D7InTrosSIHLyNDIm+xG+O?=
 =?us-ascii?Q?aJERV3B07l8qmhxSdum7BTk2MhanRcSfy3bF3QLubDB3AxbjnIkygeaF1EJJ?=
 =?us-ascii?Q?jyx/bTiT7/e/OjPovQTTZDbVSwJ+aTudZr5XUnt6C3Gm+HWzSdFawC14/MKs?=
 =?us-ascii?Q?DzjJCx933/txAWqoafI+cWeWGNgukd90YbnH2MCIUg3q3KVdzzpDhGuqVFso?=
 =?us-ascii?Q?dQcAJdEt9GB5aKXdlrRSKxKboS87iznjj6dQXYmQ7qE6pAaAGqFrt3xCCCHc?=
 =?us-ascii?Q?Q9zW1mZqKqFJCJDIJbc+BsTNAeYSf+IebD62pEXdWz/eaXcardYlzM3fYU/I?=
 =?us-ascii?Q?Z7LrLqRMAYDk0yXPK+vW3Ey3iStJYqinhC9omt8nAnd3gZSUSL04HalecKX4?=
 =?us-ascii?Q?EnVovRKqnOLK6t8JWks1hWA72HSgpcDREKnxeNmWeBXgMgU6A72wcdbz4yQk?=
 =?us-ascii?Q?gLDfTq8XDkoDDop9bA6jzNYT+KUHnVmb9Z0ZG55jt3z2J+ZUiOHvEAoRRYgA?=
 =?us-ascii?Q?VdJbjzCs9jrt5vVR2aS6Q6yk4a8mSBvZMvKD0lqVsdIelAqC9ikLquXLMKo3?=
 =?us-ascii?Q?RNtcLtvyA1er+tH6848hzlnoyEgYFBnZt/g90Ttvlq5SBwyCwz/1/3Rja5oF?=
 =?us-ascii?Q?JGulTmlbQqRDAPy8YauQr4Flm4kgAm+Lqn2BsGbugqotaY9R7fSEEG/ZGZvz?=
 =?us-ascii?Q?+0qluMEfuu13p4Fj5vOaA3sLrupLXINozQkSUmjKXxmKd2Bniq3KDrSvpqyU?=
 =?us-ascii?Q?OINavssxO70p0yvjoRVfT3ImPr2rQV/dJWETSlI/QyLBQph9ZlLDGwduqfHt?=
 =?us-ascii?Q?gxhleKEX0Wag/ZcjPZr/vaTFMv8rk4B+YWm2mqL4eSvazLZoMyxogvUttIfm?=
 =?us-ascii?Q?OWw+3grLFfEscI25E/p4yFXrir1/LMvnSowJVHXbSqvqx6k5BVHXboqzzmWI?=
 =?us-ascii?Q?cknEVTvAfKX7oVpMveS1qLsGu/k5ClzKswhaa8o8Geaz+/2m4AnRpNbv5/pF?=
 =?us-ascii?Q?he2jtbzCy+vAsownNpHgUf5HHsq/JviZTGNH1j1tN4wRD0ipb7Vul/0jP9k3?=
 =?us-ascii?Q?6yhKM1YXKEj59ODIO+nqcYPrLmoa2Syj4GxXoGPVnojrvYuWchZuWYP5v0kO?=
 =?us-ascii?Q?XnG4kpZyp5VU4udku2jDP52WKJ/qt/MxEws1Wo200NabIe/rFav5Qj8ybOj8?=
 =?us-ascii?Q?OjOAPj5rraJHMLzHOu6Lzo7OsFxGHS9oXrRzGZKOAbDnywlpukdpl1VtTuNZ?=
 =?us-ascii?Q?guY+lPx+mg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f234697e-04cf-43ab-6c2c-08da2e625554
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 06:41:50.1646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1K0w1QQ8+gymBMKeFcF3+ZXqZqNEtm0SIgg8+Wxix6/KcObMiY9HkpkMnb8wIXemUSKmlbkZbKpihRAbey6jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1635
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 10:29:10AM +0800, Meng, Li (Jassmine) wrote:
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
> the test.
> 
> Please check the documentation amd-pstate.rst for details of the test steps.
> 
> See patch series in below git repo:
> V1: https://lore.kernel.org/linux-pm/20220323071502.2674156-1-li.meng@amd.com/
> V2: https://lore.kernel.org/lkml/20220413090510.4039589-1-li.meng@amd.com/
> V3: https://lore.kernel.org/lkml/20220421074152.599419-1-li.meng@amd.com/ 
> V4: https://lore.kernel.org/lkml/20220427135315.3447550-1-li.meng@amd.com/
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
> Thanks,
> Jasmine
> 
> Meng Li (3):
>   cpufreq: amd-pstate: Expose struct amd_cpudata
>   selftests: amd-pstate: Add test module for amd-pstate driver
>   Documentation: amd-pstate: Add unit test introduction

Series are Acked-by: Huang Rui <ray.huang@amd.com>

Thanks Jassmine! Let's wait for Khan's review comments.

Best Regards,
Ray

> 
>  Documentation/admin-guide/pm/amd-pstate.rst   |  85 ++++++
>  MAINTAINERS                                   |   1 +
>  drivers/cpufreq/amd-pstate.c                  |  60 +---
>  include/linux/amd-pstate.h                    |  77 +++++
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/amd-pstate/Makefile   |  15 +
>  .../selftests/amd-pstate/amd-pstate-ut.sh     |  45 +++
>  .../amd-pstate/amd-pstate-ut/Makefile         |  20 ++
>  .../amd-pstate/amd-pstate-ut/amd-pstate-ut.c  | 278 ++++++++++++++++++
>  tools/testing/selftests/amd-pstate/config     |   1 +
>  10 files changed, 524 insertions(+), 59 deletions(-)
>  create mode 100644 include/linux/amd-pstate.h
>  create mode 100644 tools/testing/selftests/amd-pstate/Makefile
>  create mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
>  create mode 100644 tools/testing/selftests/amd-pstate/amd-pstate-ut/Makefile
>  create mode 100644 tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.c
>  create mode 100644 tools/testing/selftests/amd-pstate/config
> 
> -- 
> 2.25.1
> 
