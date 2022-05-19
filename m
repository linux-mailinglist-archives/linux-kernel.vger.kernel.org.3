Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA96C52DDF8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbiESTun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiESTul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:50:41 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46217F134E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:50:40 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e3so6836020ios.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=80hccpo9jht5r4qiVCPTMS3bJPZP6KLkPvpQ3s/DEvM=;
        b=T5+2BwEMNrFuDfdKOsd5NyrIqe2ZJDSEfiHtwpdH3YrcMB95Z+DzZRv5ifb8tyJ+og
         0mQta3DUpQflbSbdWmXtrKMgVNLezTY8p4tZgJi1hGOdqj6D2A1shRPLcFATPEe3oFWq
         arBs8uEHwpev8FlDANCnQ9vYEUYrGCFHG2Qck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=80hccpo9jht5r4qiVCPTMS3bJPZP6KLkPvpQ3s/DEvM=;
        b=7eAL4e9Pm8MsJaqIaPgX+yeTjXTb0bOomNU1x8X6kopYm4L4PMO695FyYsKSAMa3tf
         rUQOSDA/KHsFhzBGk4XPoqN3yVoExqEmaN04wssiEX8k8J+tVB5kfxT+3WgnvAWilPkG
         ecnFjSa4zgkrV+zDk7L4maz8qmsVKTkLI0Iz7qqqOYU+9sb92YcmLdVNX0+LV3szeiju
         jNAtMovyK0J1G88OsEM1Wj3wl6s8Icf7Hr5adwThNlWcEhk4wN12Xxsr+iNdKwGQws73
         VtU44aR0ac5EXjMfWzi+S5HB6IAGRK14C0P3cb/udmPawM7sb/P7pCtFrwZR2QJlhhTS
         zAbg==
X-Gm-Message-State: AOAM5334lFRE7llOpZgmaVSKSmIRopSOk+7OoyHB/L2tOs4jHMb1VIOW
        vH2AhFK8uF0/QKQmfvSxkBvhPQ==
X-Google-Smtp-Source: ABdhPJxUt2twkEXW0cKwjBs3QoU9j98+GPX5jtQEhA08kyb8XoQSwoAvVYnYGNRsLYJCM6kglSFOWQ==
X-Received: by 2002:a05:6602:2d8d:b0:649:f82b:c877 with SMTP id k13-20020a0566022d8d00b00649f82bc877mr3307330iow.66.1652989839674;
        Thu, 19 May 2022 12:50:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m7-20020a056638408700b0032b3a78176esm140575jam.50.2022.05.19.12.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 12:50:39 -0700 (PDT)
Subject: Re: [PATCH V6 3/4] selftests: amd-pstate: Add test trigger for
 amd-pstate driver
To:     Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220519134737.359290-1-li.meng@amd.com>
 <20220519134737.359290-4-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <aff0bd75-6c50-09bb-9c8f-20f2ef19ab98@linuxfoundation.org>
Date:   Thu, 19 May 2022 13:50:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220519134737.359290-4-li.meng@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 7:47 AM, Meng Li wrote:
> Add amd-pstate test trigger in kselftest, it will load/unload
> amd-pstate-ut module to test some cases etc.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>   tools/testing/selftests/Makefile              |  1 +
>   tools/testing/selftests/amd-pstate/Makefile   |  8 +++++
>   .../selftests/amd-pstate/amd-pstate-ut.sh     | 34 +++++++++++++++++++
>   tools/testing/selftests/amd-pstate/config     |  1 +
>   4 files changed, 44 insertions(+)
>   create mode 100644 tools/testing/selftests/amd-pstate/Makefile
>   create mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
>   create mode 100644 tools/testing/selftests/amd-pstate/config
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 2319ec87f53d..975c13368286 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   TARGETS += alsa
> +TARGETS += amd-pstate
>   TARGETS += arm64
>   TARGETS += bpf
>   TARGETS += breakpoints
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> new file mode 100644
> index 000000000000..e1432112fb70
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Makefile for amd-pstate/ function selftests
> +
> +TEST_PROGS := amd-pstate-ut.sh
> +
> +include ../lib.mk
> +
> +$(TEST_GEN_FILES): $(HEADERS)

Do you still need this?

> diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> new file mode 100755
> index 000000000000..970f7a76c7d5
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> @@ -0,0 +1,34 @@
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

This can be simpler - see prctl/Makefile or other tests that do arch
checks. Also does this test run on non-amd x86_64 systems?

> +	echo "$0 # Skipped: Test can only run on x86 architectures."

All x86 or x86_64 AMD systems? Does this run on Intel systems?

> +	exit $ksft_skip
> +fi
> +
> +msg="Skip all tests:"
> +if [ ! -w /dev ]; then
> +    echo $msg please run this as root >&2
> +    exit $ksft_skip
> +fi
> +
> +scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
> +
> +if [ "$scaling_driver" != "amd-pstate" ]; then
> +	echo "$0 # Skipped: Test can only run on amd-pstate driver."
> +	echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
> +	exit $ksft_skip
> +fi
> +
> +$(dirname $0)/../kselftest/module.sh "amd-pstate-ut" amd-pstate-ut

What does this do?

Has this script been updated after moving the module to drivers/cpufreq?
Also doesn't this script need to to load the amd_pstate_ut module?

Please take a look at user/test_user_copy.sh for example on modprobe
checks and appropriate test exit codes

> diff --git a/tools/testing/selftests/amd-pstate/config b/tools/testing/selftests/amd-pstate/config
> new file mode 100644
> index 000000000000..f43103c9adc4
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/config
> @@ -0,0 +1 @@
> +CONFIG_X86_AMD_PSTATE_UT=m
> 

thanks,
-- Shuah
