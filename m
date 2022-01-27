Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB30349EE62
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbiA0XCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237773AbiA0XCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:02:03 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55851C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:02:03 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id z7so3889654ilb.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/udoNmOdToKZ46JixRPRrkFS07mcQhi4GHZVYYVEkbc=;
        b=JbObllQ61T/iGnBUjULS9/tBm7bjFLR+cUslbw4rxf/RHEdNUXRLGNH1OQE1R1MAzC
         q7UY5vIIWqOJtz0a0PAM3vf4YwRtuLNO46PyqyWtRRoy64vBGofSZnluxWLr+h+usGJh
         KSuk+fFej0loknxj937nOtODaRaL5x5T4VVIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/udoNmOdToKZ46JixRPRrkFS07mcQhi4GHZVYYVEkbc=;
        b=0fue62JDoDUyUxVidkLgPBdlVm75Tzwl7TGdY4lb1U9dIFE8epdWpqQsmZIPPFGgWj
         Bm6SfmTRYL4De8JwCe8DS0r040Ge/CqKqBcx/zA0blcH+k7sPE4PM5Sxl9OJbh/nWbVV
         MyEIcv63d5vKLNVHfpxLbGn4RffcHlB3kCzvUfbEC2irRDsUhTAIWKQ95mBD81Q2kZh1
         IcanEvkLg/dG4/uq7sio8jDfD/WPSE6TD8Dkx7BvckYEt3xEOKcLOnoDS17kWsMmCuUM
         TsuK3YwAXKcqgbYv+62YQhtAK8QYfc6UK54rJJLgM98Qv+RyowS5Bn9NLnYTx42SEoaM
         CS2w==
X-Gm-Message-State: AOAM531u8zcdWTcJDSGX++EVnBBiA/0eJZdOAXCieAccva/zVLNs2bUM
        hnNHQg2NoqaUen3LW9KoeJvskQ==
X-Google-Smtp-Source: ABdhPJw7snTnsDnp2NSxNMlJZgf+Ks8g/n0IOMPOVZLcnCw/cpfCGHXpCKnBGD88sSz5Dq3YV4zEVA==
X-Received: by 2002:a05:6e02:188c:: with SMTP id o12mr4196131ilu.95.1643324522750;
        Thu, 27 Jan 2022 15:02:02 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:fcdb:3423:ed25:a583? ([2601:282:8200:4c:fcdb:3423:ed25:a583])
        by smtp.gmail.com with ESMTPSA id m4sm12666632iln.48.2022.01.27.15.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:02:02 -0800 (PST)
Subject: Re: [PATCH 2/5] kselftest: Fix vdso_test_time to pass on skips
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126102723.23300-1-cristian.marussi@arm.com>
 <20220126102723.23300-3-cristian.marussi@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3603bae9-d292-8c67-331f-18fe54586355@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 16:02:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220126102723.23300-3-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 3:27 AM, Cristian Marussi wrote:
> When a vDSO symbol is not found, all the testcases in vdso_test_abi usually
> report a SKIP, which, in turn, is reported back to Kselftest as a PASS.
> 
> Testcase vdso_test_time, instead, reporting a SKIP, causes the whole set of
> tests within vdso_test_abi to be considered FAIL when symbol is not found.
> 
> Fix it reporting a PASS when vdso_test_time cannot find the vdso symbol.
> 
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Seen as a failure on both a JUNO and a Dragonboard on both recent and old
> kernels/testruns:
> 
> root@deb-buster-arm64:~# /opt/ksft/vDSO/vdso_test_abi
> [vDSO kselftest] VDSO_VERSION: LINUX_2.6.39
> The time is 1637922136.675304
> The time is 1637922136.675361000
> The resolution is 0 1
> clock_id: CLOCK_REALTIME [PASS]
> The time is 1927.760604900
> The resolution is 0 1
> clock_id: CLOCK_BOOTTIME [PASS]
> The time is 1637922136.675649700
> The resolution is 0 1
> clock_id: CLOCK_TAI [PASS]
> The time is 1637922136.672000000
> The resolution is 0 4000000
> clock_id: CLOCK_REALTIME_COARSE [PASS]
> The time is 1927.761005600
> The resolution is 0 1
> clock_id: CLOCK_MONOTONIC [PASS]
> The time is 1927.761132780
> The resolution is 0 1
> clock_id: CLOCK_MONOTONIC_RAW [PASS]
> The time is 1927.757093740
> The resolution is 0 4000000
> clock_id: CLOCK_MONOTONIC_COARSE [PASS]
> Could not find __kernel_time              <<< This caused a FAIL as a whole
> root@deb-buster-arm64:~# echo $?
> 1
> 
> e.g.: https://lkft.validation.linaro.org/scheduler/job/2192570#L27778
> ---
>   tools/testing/selftests/vDSO/vdso_test_abi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
> index 3d603f1394af..7dcc66d1cecf 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_abi.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
> @@ -90,8 +90,9 @@ static int vdso_test_time(void)
>   		(vdso_time_t)vdso_sym(version, name[2]);
>   
>   	if (!vdso_time) {
> +		/* Skip if symbol not found: consider skipped tests as passed */
>   		printf("Could not find %s\n", name[2]);
> -		return KSFT_SKIP;
> +		return KSFT_PASS;

Skip is a the right option here. Pass indicates that the functionality
has been tested and it passed. There is a clear message that says that
the symbol isn't found

thanks,
-- Shuah
