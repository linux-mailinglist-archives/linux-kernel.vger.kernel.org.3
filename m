Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E074FFFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbiDMT6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiDMT6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:58:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C905D64D;
        Wed, 13 Apr 2022 12:56:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Msy4UDJe4DK+4mMHp7qo3tq+YKgyD1fQ7j6r8k/A0ReaCwUGiMaBH6KWTeBPjUklFoOZcIehYOQT2dmHBHhqMveXlZdswiynLWcCJ5axLBCdUsSpRObydyycmD2qztV89mtcBF1l1+nkD96qHODo5C0SG8BEzue9ahBAwndq8cbLNbLC3H3LOTIjpq1/yq0JBJOkWXNk1XvBCfWEmQBzkIz6wUGxYPY7MLOLgMM33CjEdZxCBq0p659ZRQ9F62jSN9c9pCk9pOQfK3Smyt1XriFKAB6jg1KmDiZqpSGRlWSxSOhD/tqDaE111zEuKEuqCKkLWLbGxc+7qPMYx6rHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdQr/51zBf73qwOg2uMuusQrGyU6k5n47k8UnzePFHQ=;
 b=MgQ7VHAFwuQTPa0rPR8R0+DDCsYoCE1sKcC3AIsqtsQQjNZVi4xN7WNvMM0jXspkrBDDE92NWGt+2nVzMdtcEvPt5cSTZDUctE3qaDZGBY2xZCWDV1lsiVzFx8/uOI+/rEoxu2ld+q3DFx5vmDkQdvqB/HgO5mg9JvJjqiBXodrr/2NxLfAbj8XIcoclUMnFke1ncoS6GyF93JpE8dzPKdMA30kBUS+fzfdSrmnXTjZcld81vzfPn7c1/6k4b5UEJD3lyftcWbK11PNd/LZITWJKoEwfzABWFQKTn8tIy28ZZehrQG4Mxn6OvphyPj4KLqNTZix69flpC+Uw1c2x2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdQr/51zBf73qwOg2uMuusQrGyU6k5n47k8UnzePFHQ=;
 b=TFvKYIwW4DIpUWQW0WssLCoVuNS1Ip7BH+WwzHV5A/zoMqhYoIX2UlrgInyuXCWnxGD+pWlPfZ44kOOZXrnfVQjlv5uhW16woplZtAiF1oeBUdaZqE3Rj5nuQ9IwI//eb/oo6bbJ+ixyvaEf3tBfnOkjg6eJRrDCmxKevUmLqqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by BL0PR12MB4674.namprd12.prod.outlook.com (2603:10b6:207:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 19:56:04 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c575:d06d:b1ba:c877]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c575:d06d:b1ba:c877%7]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 19:56:04 +0000
Message-ID: <1814f58c-1d26-1aa6-25cf-eb51261f8b9f@amd.com>
Date:   Wed, 13 Apr 2022 14:55:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] selftests: cpufreq: Add wapper script for test AMD
 P-State
Content-Language: en-US
To:     Meng Li <li.meng@amd.com>, Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org
Cc:     Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
References: <20220413090510.4039589-1-li.meng@amd.com>
 <20220413090510.4039589-3-li.meng@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20220413090510.4039589-3-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0421.namprd03.prod.outlook.com
 (2603:10b6:610:10e::26) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce581afa-0a69-45e0-714e-08da1d87a41f
X-MS-TrafficTypeDiagnostic: BL0PR12MB4674:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB467431CC1C012F755EF8FC35ECEC9@BL0PR12MB4674.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hdaa7jB+eSmSAQ3/wKpz2Lf1uV6SGAMUj3ONlmnBA+6unIhYd/QdCs53yDvdeTuZNFv6DaKyiyzE8aAKOtkRalkp/n/0Mum6idOizxyotdaTscNPs0+Gc49n53TTu93lY3Gms4RNbqpQP5HYbyEK0Iby1pCVRb5RlhiffOyeR+/GhTkl+qEyY+JbtlOFBIMcXwNNen886OckBofFb+En1aEtMGaF4geR0WtxC5uUN7D2NbGBwJnG6HIK92ZUgyJFZBd5JXxG5q6K7EncDU5eFT98F03iM/VyCKI2CrW5hC/t7oiQm8OneWQYftxOysE1i+vW6G5ffpPj6udruf/NqlcFz6CadCqERBJe0zL97cISJ3SRHsVk1pmMx1xQZAFNemy0W21YtbyBhIXFEj3E7GujsHOflTTdbDXHxND7j1NRHAsAjQdHdTnYgY7PGfvOYptflSbW599onnbrJCoTKZOR/baBqyL4Twdn3AyyYc+0Vta40llePCp7IEN8R3oCRPnMGaHUxPSBNwqm4RfG93piboH2+dnuEQr/tOtkHA9LKDqKyoWjmcTjATcATqVtJSII/5MHIqm8+DFfYSV8ykJC1HiCzUVZ4SKsMRZu8EfhQ3CUzD3jLK/yoaGD+affuDzoH06iUOgiOuhYtT6IqrUrYIBI1rw4s1Kq6xBYpj+Hbj0nfXNGd+WSTa0pki6f5HaKl90qkIph6owxLC5mBlMKvBFhuqqEUJx0rr2iT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(31696002)(83380400001)(8676002)(66556008)(66476007)(36756003)(2906002)(186003)(26005)(110136005)(316002)(6486002)(2616005)(54906003)(508600001)(31686004)(38100700002)(66946007)(8936002)(6666004)(5660300002)(6512007)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDdNOTcrQUtpcEQ5dzhSd2hDT0pVZEVKSEliNEgyWVl0RWlOekovY3VOZVB4?=
 =?utf-8?B?d1gwdnJqQWhtVWFLemdXRWhVYUZKeWFqS3RhVmpXdm1wREsvc0tLdllWNytx?=
 =?utf-8?B?VUxiK1hBQlNBcnhBdEFWYTI1WHJaNjhTU2hnVUZZWUlwdnBLbkVWMmpSdVR3?=
 =?utf-8?B?TW5JY0VKR2N3UDNraVN4eFoyVTk1eVZ6T3FUNi8zMFRoOElrK1ZiMVdjZUFW?=
 =?utf-8?B?cGNNY0xXc0xTU1AyZGJDY2xzNjVjUTMydWhqU1dBWk5mRW5aOUNPMmJPN3M2?=
 =?utf-8?B?WGxsTGt3RGEwVUdoR1RRMUxuczdGRWpEM3Z6OEx0ZE91aENCb1o3MEdWTEp2?=
 =?utf-8?B?dDNmajNNK3N6Zll5NmpPVE5hZHpzbDludGNSMHBTbURaMmwxTlFHdGY1ejNZ?=
 =?utf-8?B?RmY2VmpmWEIzQ1RVdFUvZThneWNjb1oyMVdWKzRGNUFick5SN3dJTklWNWNQ?=
 =?utf-8?B?dkF4RmlibVdlNWk2bHhjR0RTM3kwUnZnODVXRTlSaWgva0tiY1AvSXlweWVt?=
 =?utf-8?B?eTdOcS9uZVFsS3E4TEJmR2h6ZmFGNDI4eGpES3k1SjNhRmhzNmZwUWlGc3BE?=
 =?utf-8?B?WkJ4aHNRUTIvczExM083ai9TMVFyQ3Jkdmh4eGdiVXRCdkQ5eWNOZWxNdTdY?=
 =?utf-8?B?cmN4Q29aQ2xWczZSV0VoOVF0cWNQdWszUzhCSyt2NmZuOXBqMThLcWVSb0FO?=
 =?utf-8?B?SFM0d2dReEpOSUNjeXBXRWk0bXNYcVdzazVkUHlUS3FBNlV6NEFmQkJsZkM0?=
 =?utf-8?B?NWIrSE9jMlM1aG02b2RaZldBVTkvem9TeS9DT040VlUxREZuRllmdDM4aGpz?=
 =?utf-8?B?K0U3UXVYd3RKVzJ6OU1oaFpaME5aQUdNNE82c3NhakRFSzFlejl3VFBxeGhw?=
 =?utf-8?B?UThYN0NiN1V2ZGNQaU92NkVrcE85RWFIbklvQ3RyOVVnSWRQNjU0Tk05UFZE?=
 =?utf-8?B?TnVUZWhvN0RHSjUvOHJZWGQrUW0ySzg1TEg2MXhhY2R2YjRsNll4cnozeW1D?=
 =?utf-8?B?RGJBUnRidmYyK2pueDFrdFMzN3RsUW85VnZUOEY1aFRtV09TRGdpcy9wTVVx?=
 =?utf-8?B?THQ0R1lCMG9hTml3eGE0UGJVMFRSNHFneU1ScFpRbktpUE9jT3VaM0RCeFdT?=
 =?utf-8?B?QmN4OTFmMzVKTytaT2NTQ0JkSUk3eHdaS0VHdE5sbXZXYlFsQ2ppNUxKWDY4?=
 =?utf-8?B?YW5GdWpsNy9yQnVVTzV6eGlkei9WRkJ2bTFMYitjMUZmS3NGRnRHWVJOaTJS?=
 =?utf-8?B?QUhtRUFNYWRUaGVqUmhNMHFwdm5LY1Nyc2h2VGI2c1R0NlpYZEJQOXFFMFBn?=
 =?utf-8?B?My9CSlBvT25YbEV3VFFVaXpGWXVmcGI0ZUhQWnQ2OGVLdDZBT0dPMmFyU3hP?=
 =?utf-8?B?RHRuazMvVTRSTHRUSGZvRkpDWERQOUNSejJReTRhQmdhbk1xaHpXOGhJV284?=
 =?utf-8?B?aUhCOUZjZTZtRkpueC9nWmkrNkJ1c2d3VXhhVmRSdFluVEgwWE1DVWhwVHRu?=
 =?utf-8?B?SlVDN0QxZFdBZlBhTGYxcXM1TzdGYnBPSmUrRklsMWtVdWl2elp0S1lIenE0?=
 =?utf-8?B?Z3BQbll5eDFkOHp5WFR2SXBkVGhkbjVjK1V3NnYreHBpOER2dzRzMlJ2bmQ0?=
 =?utf-8?B?cDNYWUdYUEEwZURsUHJwRk85aWtMbCtVUW5GSEx3ZEI0QlY3SEEyYWc5LzFk?=
 =?utf-8?B?NE54QTVsTGFJS0owcFFEWlBaYzNjTWJON3NhRHFzTk5qWkRjWFNTYUhoRlZ3?=
 =?utf-8?B?NlNkOFdKWGY4UCs4ekhpdGsvWGxqYUV6RkpTSkUrUUtreUVOeHYwRkdkbElv?=
 =?utf-8?B?Y2tCTW5ad0w5WE55TUVPSklTYmh1MWpNMjNjQ25IMmFGeVZmdU9IblBZN2Qx?=
 =?utf-8?B?RHpFSnNEdjFBVXVxWGRTb2l6WENzb0JWZkd0b2xSUi9LT09BbnlVZkZFT0JY?=
 =?utf-8?B?WDQ3TWNubENoLy9lK2I0Qi9JeUc5Sm42YjlHR2UvRWE4ZDhyTDhSaVYwbFJP?=
 =?utf-8?B?bkpDWVJuZE85S2JxY0ZaZ0w1dFZtOWFRLzBPZGY1SjcycDd2MmxYd25EVW9J?=
 =?utf-8?B?R1N4bW9hU2MrREF0WHN4cGxzcjFTcTR1U1pBOTlrZWRxS1RvQ3NFcTBqT09M?=
 =?utf-8?B?YVFyVjY0Z1lyOW43ZEVnYlNIQ1YrQTR2S2RuaVFKbFJucXRmYmJ4emsyM3ps?=
 =?utf-8?B?NzBwcy84UnU4SHJvWnlTWUM0YzJPY3FRZFVnaVRvMGVzcDJFck4yRE82b1FV?=
 =?utf-8?B?VEZRQmVNQVdhN2Z1SlFGa2hUbWpMYnl4Z0MwUmhlMjZmNmRwUGpncENnNkxa?=
 =?utf-8?B?Z004L0pEdXdBNEl6NXlTN2JzSlVZMUxHeFhRNmpOSnBGdm1uYzlxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce581afa-0a69-45e0-714e-08da1d87a41f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 19:56:03.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRVBE0F+jA9mzlfBcZk/qkZ3na48eq0L73T3Lp5TM+h/wJ4Z7ZM9g7AJ8DUL/0RlVb9eCThBPjRugJ043hwcBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4674
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 04:05, Meng Li wrote:
> Adds a wrapper shell script for the amd_pstate_testmod module.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  tools/testing/selftests/cpufreq/Makefile              | 2 +-
>  tools/testing/selftests/cpufreq/amd_pstate_testmod.sh | 4 ++++
>  tools/testing/selftests/cpufreq/config                | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/cpufreq/amd_pstate_testmod.sh
> 
> diff --git a/tools/testing/selftests/cpufreq/Makefile b/tools/testing/selftests/cpufreq/Makefile
> index c86ca8342222..c32adc59a1f4 100644
> --- a/tools/testing/selftests/cpufreq/Makefile
> +++ b/tools/testing/selftests/cpufreq/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  all:
>  
> -TEST_PROGS := main.sh
> +TEST_PROGS := main.sh amd_pstate_testmod.sh

Instead of making the amd-pstate testing a separate test program, should this
be part of the main.sh testing program?

Perhaps adding a "driver" test function that can check for the amd-pstate driver
being in use and run the test module.

-Nathan

>  TEST_FILES := cpu.sh cpufreq.sh governor.sh module.sh special-tests.sh
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/cpufreq/amd_pstate_testmod.sh b/tools/testing/selftests/cpufreq/amd_pstate_testmod.sh
> new file mode 100755
> index 000000000000..5398ad568885
> --- /dev/null
> +++ b/tools/testing/selftests/cpufreq/amd_pstate_testmod.sh
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Tests the AMD P-State unit test infrastructure using amd_pstate_testmod kernel module.
> +$(dirname $0)/../kselftest/module.sh "amd_pstate_testmod" amd_pstate_testmod
> diff --git a/tools/testing/selftests/cpufreq/config b/tools/testing/selftests/cpufreq/config
> index 75e900793e8a..374a8adbb34c 100644
> --- a/tools/testing/selftests/cpufreq/config
> +++ b/tools/testing/selftests/cpufreq/config
> @@ -13,3 +13,4 @@ CONFIG_DEBUG_LOCK_ALLOC=y
>  CONFIG_PROVE_LOCKING=y
>  CONFIG_LOCKDEP=y
>  CONFIG_DEBUG_ATOMIC_SLEEP=y
> +CONFIG_AMD_PSTATE_TESTMOD=m
