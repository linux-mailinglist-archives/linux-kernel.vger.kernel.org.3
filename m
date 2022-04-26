Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A177C50F1D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343679AbiDZHNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiDZHNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:13:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 458151403F;
        Tue, 26 Apr 2022 00:10:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5E3723A;
        Tue, 26 Apr 2022 00:10:36 -0700 (PDT)
Received: from [192.168.1.11] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F3BF3F73B;
        Tue, 26 Apr 2022 00:10:32 -0700 (PDT)
Message-ID: <6765104a-761c-4586-502c-2b98ee6016a1@arm.com>
Date:   Tue, 26 Apr 2022 09:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/2] Enable EAS for CPPC/ACPI based systems
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, maz@kernel.org,
        daniel.lezcano@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20220425123819.137735-1-pierre.gondois@arm.com>
 <20220426030810.wj7mdhjhzs2s6y7h@vireshk-i7>
 <20220426063739.6ljxtr6hpz7tber5@vireshk-i7>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20220426063739.6ljxtr6hpz7tber5@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Viresh,
The 2 patches are relying on Lukasz' patch-set at:
https://lkml.org/lkml/2022/3/21/282
The serie was accepted by Rafael (cf. https://lkml.org/lkml/2022/4/13/701) and
is currently in linux-next. More specifically, the missing patch causing the
build failure is: 'PM: EM: Add .get_cost() callback'

 From what I see, the branch cpufreq/arm/linux-next (from your repo) that was
used in the CI is based on v5.18-rc1 and doesn't have Lukasz' patches. Should
we wait for the patches to be in a rc version, or is there a process for this
kind of case ?

Regards,
Pierre



On 4/26/22 08:37, Viresh Kumar wrote:
> On 26-04-22, 08:38, Viresh Kumar wrote:
>> On 25-04-22, 14:38, Pierre Gondois wrote:
>>> v3:
>>> - Remove efficiency_class_populated variable. [Viresh]
>>> - Remove patch "cpufreq: CPPC: Add cppc_cpufreq_search_cpu_data"
>>>    and access cpu_data through policy->driver_data. [Viresh]
>>> - arm64 code only acked by Catalin [Catalin]
>>
>> Applied. Thanks.
> 
> Removed, build failures:
> 
> https://gitlab.com/vireshk/pmko/-/jobs/2375905218
> 
> Log: https://builds.tuxbuild.com/28Jos1GBXfT5Cl3HoBKKwmM8Ddk/build.log
> 
> /builds/linux/drivers/cpufreq/cppc_cpufreq.c: In function 'cppc_cpufreq_register_em':
> 368/builds/linux/drivers/cpufreq/cppc_cpufreq.c:593:3: error: implicit declaration of function 'EM_ADV_DATA_CB'; did you mean 'EM_DATA_CB'? [-Werror=implicit-function-declaration]
> 369  593 |   EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
> 370      |   ^~~~~~~~~~~~~~
> 371      |   EM_DATA_CB
> 372/builds/linux/drivers/cpufreq/cppc_cpufreq.c:593:3: error: invalid initializer
> 373cc1: some warnings being treated as errors
> 374
> 
