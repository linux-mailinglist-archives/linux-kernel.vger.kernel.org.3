Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32487513021
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbiD1JXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345676AbiD1JSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:18:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E70D2AA;
        Thu, 28 Apr 2022 02:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uh8d+fSpOHd6/d2QtsMgInllc86WLgbb/1aGmOXnvu1XgdDn/LS7hRUP8Knz4CHL2CDJJ6WNH7q8kIcX4aUSQqGCylOnc1lF3pc68yCZITZ32HvLmRth1ha0/gSjcnD+0Z4Zn6CDGnSWj1MIw6ICkyLh116P8UJHTWfHV8hq/lHRGo7WhGxDID0T2RWFLjLj3O5wOvC7ybYyZ2Fl/6yOeNCIKXrqkhUc5ekDy7C52ttD9vTqXPaSEMiEy+Ct88NUmNY2mTllsnjjg60OB+/z19k2A2yU4A+1/8dDdjgLxnJJCkC2ABvzIObcG0/BkGzQtzVCKaQucWhQodhUgMZnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKMF9XR97oEXuT6MPfV4p9Lbj9PEXB7l3XwdlvSsrAg=;
 b=CVb2QKRizwCggbTBMdpF5oVmW+vlyJJG91xpEpMwdkSWEXm9p1A9mR/YXU3VwGHpj8EUjf82r48gDAy35XZ2cksm2np2MKhRDcvA5pi1hmdHHh/wQx9esqfsxcT3qAb4VkCkEO1MSHsAOcKBUPJT0AYo++AscKn/4z/Uv40HRaX8bj1Vmgi4/Qv+sYT2kU9UNjjkMraxynWWuzDhaSyruBccpNp0LekeuVPXu81O4WOb7xcBUQ26laqVWEAoJBHvS09R0+scWw7DNO7FyB/EcnhX91gkwsUqg+N5GynTmMwkOY2UgyPusKY9xf5tVQXSrTcP65VuIOFpz0bwhVL5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKMF9XR97oEXuT6MPfV4p9Lbj9PEXB7l3XwdlvSsrAg=;
 b=Jmri7O5hIGNorG96EO/ewoD26f0pNB3OuJK77hqa1sHi+5P9QfbJWjsk9y8czNmtTNBHayERtD5qQS5KJsmSYR3WhFmAqxaaKyOor8KodCmXHe3S3UukCDjAQ5WHt5BpjV87jHRaXPBAgpyzuofd7xtrOo2TDWIEPPxted9IIjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM5PR1201MB2472.namprd12.prod.outlook.com (2603:10b6:3:e1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Thu, 28 Apr 2022 09:15:00 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d%7]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 09:15:00 +0000
Date:   Thu, 28 Apr 2022 17:14:37 +0800
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
Subject: Re: [PATCH V4 3/3] Documentation: amd-pstate: Add unit test
 introduction
Message-ID: <Ympa/YusPdnYhfRH@amd.com>
References: <20220427135315.3447550-1-li.meng@amd.com>
 <20220427135315.3447550-4-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427135315.3447550-4-li.meng@amd.com>
X-ClientProxiedBy: HK2PR0401CA0020.apcprd04.prod.outlook.com
 (2603:1096:202:2::30) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a4e0027-17a1-4918-6668-08da28f79259
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2472:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2472C6EEBF4DD7A2FA2D77E7ECFD9@DM5PR1201MB2472.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbB2qJz3Pf5Axe+sPgqMSg0o2R9VW3Gv1U4m7zCFnFIa931xbsLQCSdCvKVdeOj6IOBCoXVQT4sTGjQf5P8We/95u+kFVUQfvkH9J6WS7amjgzmBbaYZFiCEHacKqvp1H7aNo4rENxDFmC57fz1K8tzLR7CddfFTluRe3u1y39Wx2KlW/CIXaPVN37KuKLBruH1qWhPM+M29rT9i0+BUsPO7RGPPdYk4lKoAPZeaRAs0+/WWS2Q8vkPLPEgz3rAr7xs3bX1tRRyKFnl9EhZufSFe0MzpgPO8SVOZpsY5Akp2p/QasFPXUqQ4GSyH39m98wCgcchZESGRlv2BQa0l4BS5duEt/7k9ZvET23pTpwN+3p6SrRa+q3ZT4r9OT1vSjxVWkJoLR46/uMIcisnfYK4urh6uagzwTNyMJ9qzYLlhCrqB4z/gWcDFJmTyssAZaWV9UyMgykNXvnahiO2HjuwGmMchFVfaSrASCQ72Xyk/gJVTOoYTGLlXNYVrLdAviu7yx/HGCj29RX1J3FhPTCkZ1QZPbH/uIUR7znGJ+5wa2RbQovjVgR4LhxvoDDanegyG6xuzygV2Q2tLl6z5k5e3qjNnuQI6LGHdtoDdepFmGFyK/Gy/qgwWbBb/+IzlsU4zmJvHMb6qVNRM+U9slooCTzxcpEW8yEhpipCeTNiCFXGQeA+qc1JoJr0EdUlHWQ2VE9ozOoKHRU+59gdevA9juq9vvECgYEyFdHjrd1ocUvV0ji0ADjNFV83J1t2CXHDEUDt1K0NnU973gQuMog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6666004)(38100700002)(186003)(86362001)(8936002)(54906003)(5660300002)(6486002)(6636002)(83380400001)(966005)(37006003)(6506007)(508600001)(2906002)(8676002)(6862004)(26005)(6512007)(4326008)(36756003)(66946007)(66476007)(2616005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cGXfx0hFVFN6/CBnsvpZw0HPCblc3ap+lGWd4l3VX4xvzvOIHBxEKUmvc/Hk?=
 =?us-ascii?Q?0SrWiyM0vpsp72q/5YLZKhHqYhWkMtE6u3DJSE8orkwYaPcD0otfbX1+zosh?=
 =?us-ascii?Q?ONGhS3bJZB4mIuImERLAxZKPKQwpl8SIX9CAvempaMCQmqJ8R1XBRCgnfSU4?=
 =?us-ascii?Q?z6dMoZsKgGXOFCibzL97Mo5BxedZhpphK5UEyEyvh62qTbA2oAvdXzxJCPb7?=
 =?us-ascii?Q?tJ0LS1h+tEccbBHfVNj4DwLXCKTNnjnTFg/bnNm2vPUhFGjHv0byTQ6KYEAM?=
 =?us-ascii?Q?06lcICZudzpy5fRq1cUkB6d+RMl3LY1WBeaiHcNt6u3lRsujLxrNRuRKUBir?=
 =?us-ascii?Q?RYTiR85IsyTT3bKDv14LYEp8JY+ZjwaixWE2N/InQEhx2s3sQkw23bMQ3HSi?=
 =?us-ascii?Q?689v8fefMfHX//Ov3sPxs0qMijiibZlo1y75y+kYal9cjZfN5+FL6QENBKJf?=
 =?us-ascii?Q?HJG8UVUEg30IQ93dMZJQ5gHtgpwbxI/vjCbJfjZ24gYBlkqUF7jF7CgSfQQw?=
 =?us-ascii?Q?dttS7xqy86ZOlr4U+tsKdCayxbBGhk5BE4GAkwAnXr68UYnKWYT64KY6Myt9?=
 =?us-ascii?Q?Yd1trCy1tpcEdBiQAp9tZwNyILUz0/OLXmB2+7BcXTnazXYwwDWX8/cBP64Y?=
 =?us-ascii?Q?c2G8zpbVPqPLqXqfYOxtttwu41cAtCOJ2DlQ8bT3Y5RH7F6HW8kxxTFm7Hde?=
 =?us-ascii?Q?hdJbBrekEOT3U9QwbYMPAeuzmUFBE5ryoDne13aCn4F8jwYAm6lmdT2kGLMW?=
 =?us-ascii?Q?47uESEoiTMOAVcTZReEa6Fp1o9/j9WoXIkrJ06FXcsCSB9ZNUKq2taqrWkbh?=
 =?us-ascii?Q?401D3QEJpMkxs+dhHvvRb5FY2Wp8srkesMU5cPaJkEDg1rCacf5ms6+UyylN?=
 =?us-ascii?Q?QYTv9waUMv5Af6vdbJ+eg/amyrPfYsNYexdIylfZhLP5wzsYOjw1KTP46xlj?=
 =?us-ascii?Q?0X0QPiv2n53jgB+LwRDLGaV4T/6G/EzBpbX31QwQpvpU14Yy47TCBscHXWC1?=
 =?us-ascii?Q?PLuNFS7dl+xmpRRqnQxuv/nUB29iBt5Sy3VjVd58O19C/DB+y9C0xhxDstuC?=
 =?us-ascii?Q?L0HNMLL5EGsfD0hcEVYtJ3LWz+WYvtepn/v0Vmdk0YeJdJwjav3HaEy5DYW4?=
 =?us-ascii?Q?KfV426ekG3esP57HFyMjaPNGxYry3cce9GwDC3tSEZRRYpLnl3ZSx0+x+Zmh?=
 =?us-ascii?Q?VOaM2MS5mRYaGWlqTbs7Je4NH2KF2glYbUNvkva+OYs8Pjr9G8Q9Pjy7jZuP?=
 =?us-ascii?Q?D5gaLo5TP5lBGWSjZiJ5TG0MRKI257xbDLTVaLOfiymA0/A8Lr59qLa2Xkuq?=
 =?us-ascii?Q?wj2dPciBpxO7GQ6XsLP1RSZggaS1v3uypDh/BUSYabvmPL15M1np04T4BjvX?=
 =?us-ascii?Q?ZLhx3zlwq+2wZH/ct4rUd8OBEQYEYRwysnDYdMzcO0W6RNO33KeCWyB9qZTp?=
 =?us-ascii?Q?ujEnV2NmsgluHQLXKCl4ZmtfOyevu1oJTOgAvo1qNDjF5YKqQU/6euFe3iFB?=
 =?us-ascii?Q?KQ0LDQjWmgu6YvrBAID2fbhpriOXL+Q/TQfAmeBDWatoCY6e8GKvqm3LOD1J?=
 =?us-ascii?Q?crVsAwPA3s+uWs7aM2uOOGsdJVDHM/z+v6Xf0ipjWM4UZMluc7oLartfPwLs?=
 =?us-ascii?Q?I0BCBQmQ+/1MMfsy/gs9om+Jk1mcXFxh65srmaK4+vzroKh7JDT8R7TApLdH?=
 =?us-ascii?Q?oyBxBVwMOQuUtGqS+ENTwYa8NDyELq+IDakysMRDY7ZO3QigibMcQPP7jjSp?=
 =?us-ascii?Q?XCPMbRkcmw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4e0027-17a1-4918-6668-08da28f79259
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 09:15:00.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7k0GbCtgcUfio3MObHUj1XDAAD3kXgSsJRCrnTOab6427IunviZgXI1j8nHxbH608p57jfISVS4TybAnk0BbHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2472
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:53:15PM +0800, Meng, Li (Jassmine) wrote:
> Introduce the AMD P-State unit test module design and implementation.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 87 +++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 83b58eb4ab4d..395b8b5c680c 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -182,6 +182,7 @@ to the ``struct sugov_cpu`` that the utilization update belongs to.
>  Then, ``amd-pstate`` updates the desired performance according to the CPU
>  scheduler assigned.
>  
> +.. _processor_support:
>  
>  Processor Support
>  =======================
> @@ -282,6 +283,8 @@ efficiency frequency management method on AMD processors.
>  Kernel Module Options for ``amd-pstate``
>  =========================================
>  
> +.. _shared_mem:
> +
>  ``shared_mem``
>  Use a module param (shared_mem) to enable related processors manually with
>  **amd_pstate.shared_mem=1**.
> @@ -393,6 +396,87 @@ about part of the output. ::
>   CPU_005     712          116384        39        49        166       0.7565  9645075 2214891 38431470  25.1   11.646       469         2.496         kworker/5:0-40
>   CPU_006     712          116408        39        49        166       0.6769  8950227 1839034 37192089  24.06  11.272       470         2.496         kworker/6:0-1264
>  
> +Unit Tests for amd-pstate
> +-------------------------
> +
> +``amd-pstate-ut`` is a test module for testing the ``amd-pstate`` driver.
> +
> + * It can help all users to verify their processor support (SBIOS/Firmware or Hardware).
> +
> + * Kernel can have a basic function test to avoid the kernel regression during the update.
> +
> + * We can introduce more functional or performance tests to align the result together, it will benefit power and performance scale optimization.
> +
> +1. Test case decriptions
> +
> +        +---------+--------------------------------+------------------------------------------------------------------------------------+
> +        | Index   | Functions                      | Description                                                                        |
> +        +=========+================================+====================================================================================+
> +        | 0       | aput_acpi_cpc                  || Check whether the _CPC object is present in SBIOS.                                |
> +        |         |                                ||                                                                                   |
> +        |         |                                || The detail refer to `Processor Support <processor_support_>`_.                    |
> +        +---------+--------------------------------+------------------------------------------------------------------------------------+
> +        | 1       | aput_check_enabled             || Check whether AMD P-State is enabled.                                             |
> +        |         |                                ||                                                                                   |
> +        |         |                                || AMD P-States and ACPI hardware P-States always can be supported in one processor. |
> +        |         |                                | But AMD P-States has the higher priority and if it is enabled with                 |
> +        |         |                                | :c:macro:`MSR_AMD_CPPC_ENABLE` or ``cppc_set_enable``, it will respond to the      |
> +        |         |                                | request from AMD P-States.                                                         |
> +        +---------+--------------------------------+------------------------------------------------------------------------------------+
> +        | 2       | aput_check_perf                || Check if the each performance values are reasonable.                              |
> +        |         |                                || highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0.           |
> +        +---------+--------------------------------+------------------------------------------------------------------------------------+
> +        | 3       | aput_check_freq                || Check if the each frequency values and max freq when set support boost mode       |
> +        |         |                                | are reasonable.                                                                    |
> +        |         |                                || max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0                   |
> +        |         |                                || If boost is not active but supported, this maximum frequency will be larger than  |
> +        |         |                                | the one in ``cpuinfo``.                                                            |
> +        +---------+--------------------------------+------------------------------------------------------------------------------------+
> +
> +#. How to execute the tests
> +
> +   We use test module in the kselftest frameworks to implement it.
> +   We create amd-pstate-ut module and tie it into kselftest.(for
> +   details refer to Linux Kernel Selftests [4]_).
> +
> +    1. Build ::
> +
> +        jasminemeng@jasmine-meng:~/amd-brahma$ cd linux
> +        jasminemeng@jasmine-meng:~/amd-brahma/linux$ make modules M=tools/testing/selftests/amd-pstate/amd-pstate-ut
> +          CC [M]  tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.o
> +          MODPOST tools/testing/selftests/amd-pstate/amd-pstate-ut/Module.symvers
> +          CC [M]  tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.mod.o
> +          LD [M]  tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.ko
> +          BTF [M] tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.ko
> +        jasminemeng@jasmine-meng:~/amd-brahma/linux$ make -C tools/testing/selftests
> +
> +    #. Installation & Steps ::
> +
> +        jasmine@jasmine-MayanDAP-RMB:~/amd-brahma/linux$ make -C tools/testing/selftests install INSTALL_PATH=~/kselftest
> +        jasmine@jasmine-MayanDAP-RMB:~$ sudo cp amd-pstate-ut.ko /lib/modules/5.18.0-rc2+/

We should not mention a specfic kernel version "5.18.0-rc2+" here.

> +        jasmine@jasmine-MayanDAP-RMB:~$ sudo depmod
> +        jasmine@jasmine-MayanDAP-RMB:~$ sudo ./kselftest/run_kselftest.sh -c amd-pstate

"Can we move "insmod/rmmod amd-pstate-ut.ko" stuff into script amd_pstate_ut.sh?

Thanks,
Ray

> +        TAP version 13
> +        1..1
> +        # selftests: amd-pstate: amd-pstate-ut.sh
> +        # amd-pstate-ut: ok
> +        ok 1 selftests: amd-pstate: amd-pstate-ut.sh
> +
> +    #. Results ::
> +
> +         jasmine@jasmine-MayanDAP-RMB:~$ dmesg | grep "amd-pstate-ut" | tee log.txt
> +         [76697.480217] amd-pstate-ut: loaded.
> +         [76697.480222] amd-pstate-ut: ****** Begin 1             acpi_cpc_valid          ******
> +         [76697.480227] amd-pstate-ut: ****** End   1             acpi_cpc_valid          ******
> +         [76697.480228] amd-pstate-ut: ****** Begin 2             check_enabled           ******
> +         [76697.480253] amd-pstate-ut: ****** End   2             check_enabled           ******
> +         [76697.480255] amd-pstate-ut: ****** Begin 3             check_perf              ******
> +         [76697.480554] amd-pstate-ut: ****** End   3             check_perf              ******
> +         [76697.480556] amd-pstate-ut: ****** Begin 4             check_freq              ******
> +         [76697.480558] amd-pstate-ut: ****** End   4             check_freq              ******
> +         [76697.480559] amd-pstate-ut: all 4 tests passed
> +         [76697.482507] amd-pstate-ut: unloaded.
> +
>  
>  Reference
>  ===========
> @@ -405,3 +489,6 @@ Reference
>  
>  .. [3] Processor Programming Reference (PPR) for AMD Family 19h Model 51h, Revision A1 Processors
>         https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
> +
> +.. [4] Linux Kernel Selftests,
> +       https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
> -- 
> 2.25.1
> 
