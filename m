Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D7950BF03
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiDVRvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiDVRvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:51:07 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BECBD3DA8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:48:04 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p21so9361421ioj.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JoNEMwEY3MQ8vzFXRDkOZw8gxqmKwXjN5mbJRRwLX0w=;
        b=KmtWojAdZUhMFV9R/W1BGuLUyM0ML3L24J1FKDtUAX2tw4E7a0kSfWnX/lOUGwh2mW
         wiY1NmFcHV42qMYBBKYb6FcKZY+5LDVw90xNfuHcpht4tqdhkKCfKCAdXg4MDAbDAbzg
         6SA71UoNIpdAEUybYLzbbjHLpZZ7OczoFDiQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JoNEMwEY3MQ8vzFXRDkOZw8gxqmKwXjN5mbJRRwLX0w=;
        b=CN7NFfWAaXJYVjfXdim5i/dRF5XpCu7pMstggCaBpf3+ZWa9K8sTqIADxMWzKzv6c4
         AjSwai+Gi0YBoeW5CVErgc5HQiyBu0K4I7IlGlRjnkrvM6Y9pb0ru8y3uf0c7iL08RGv
         fSHg+b8i1AHzNGTCnlwTKa2O55s9RwOdDsyfjSAAUYGyXG8YXK4no7ZCSQkhNdCyT4af
         dJtTYe//WUEYadnZhiaDrcb155xWRRCewS6y+3ZX9jXXilURRzJ8yvdcniVD43cOb5q8
         GQ1+7UjYaiAs6QtfxJd7xpDvwc0O9MwMEL3vDmwwVMsRnWtpuTDZgq94Z5D5b3wMt7GE
         f+pA==
X-Gm-Message-State: AOAM533DFSUa79VFh9AD13xb/vIJGh0HKWgCPKUg53G/SJBDng/AsQZs
        YOnoqcarWFvn4ah6YaLEiYrb1A==
X-Google-Smtp-Source: ABdhPJxnkm+6tx9Lai6U9bVgmdOgqJw+KJpo/yqc5zRBjvvD2GA3f0oAaDa5qShk2w9tbHPuPhB63g==
X-Received: by 2002:a05:6602:2c4e:b0:657:4115:d9e4 with SMTP id x14-20020a0566022c4e00b006574115d9e4mr2483769iov.91.1650649555239;
        Fri, 22 Apr 2022 10:45:55 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id n23-20020a6b8b17000000b00649a2634725sm897407iod.17.2022.04.22.10.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:45:54 -0700 (PDT)
Subject: Re: [PATCH V3 0/3] Add unit test module for AMD P-State driver
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
References: <20220421074152.599419-1-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <41103b29-f711-4c1d-fa9b-46e67fb98d0f@linuxfoundation.org>
Date:   Fri, 22 Apr 2022 11:45:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220421074152.599419-1-li.meng@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 1:41 AM, Meng Li wrote:
> Hi all:
> 
> AMD P-State unit test(amd_pstate_testmod) is a kernel module for testing
> the functions of amd-pstate driver.
> It could import as a module to launch some test tasks.
> 1) It can help all users to verify their processor support (SBIOS/Firmware
> or Hardware).
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
> We create amd_pstate_testmod module and tie it into kselftest.
> 
> For example: The test case aput_acpi_cpc is used to check whether the
> _CPC object is exist in SBIOS.
> The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is not
> existed at the detected processor, so it is a necessary condition.
> 
> At present, it only implements the basic framework and some simple test
> cases.
> 
> TODO : 1) we will add a rst document.

Please include document in this series and describe how the test can be run.
It is not clear to me how use should go about running this test especially
since the script depends on a test module which will need to be compiled
and loaded.

I would like to see clear details in the document on the steps involved in
running the test.

> 2) we will add more test cases to improve the depth and coverage of
> the test.
> 
thanks,
-- Shuah
