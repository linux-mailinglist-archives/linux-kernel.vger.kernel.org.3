Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B71D50F2EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344269AbiDZHuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343874AbiDZHuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:50:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70F95193F4;
        Tue, 26 Apr 2022 00:47:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AC2C23A;
        Tue, 26 Apr 2022 00:47:00 -0700 (PDT)
Received: from [10.57.12.108] (unknown [10.57.12.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC2743F73B;
        Tue, 26 Apr 2022 00:46:58 -0700 (PDT)
Message-ID: <f6bb20c6-38a0-57d6-8979-d14e445da623@arm.com>
Date:   Tue, 26 Apr 2022 08:46:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v3 0/5] Introduce Cpufreq Active Stats
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, amit.kachhap@gmail.com,
        linux-pm@vger.kernel.org
References: <20220406220809.22555-1-lukasz.luba@arm.com>
 <20220426031125.ozaxwecwvuby6wo3@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220426031125.ozaxwecwvuby6wo3@vireshk-i7>
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



On 4/26/22 04:11, Viresh Kumar wrote:
> On 06-04-22, 23:08, Lukasz Luba wrote:
>> Hi all,
>>
>> This is the 3rd version of patch set which tries to address issues which are
>> due to missing proper information about CPU performance in time.
>>
>> The issue description:
>> 1. "Cpufreq statistics cover the time when CPUs are in idle states, so they
>>     are not suitable for certain purposes, like thermal control." Rafael [2]
>> 2. Thermal governor Intelligent Power Allocation (IPA) has to estimate power,
>>     for the last period, e.g. 100ms, for each CPU in the Cluster, to grant new
>>     power and set max possible frequency. Currently in some cases it gets big
>>     error, when the frequency of CPU changed in the middle. It is due to the
>>     fact that IPA reads the current frequency for the CPU, not aware of all
>>     other frequencies which were actively (not in idle) used in the last 100ms.
>>
>> This code focuses on tracking the events of idle entry/exit for each CPU
>> and combine them with the frequency tracked statistics inside internal
>> statistics arrays (per-CPU). In the old cpufreq stats we have one shared
>> statistics array for the policy (all CPUs) and not take into account
>> periods when each CPU was in idle.
>>
>> Sometimes the IPA error between old estimation signal and reality is quite
>> big (>50%).
> 
> It would have been useful to show how the stats hierarchy looks in userspace
> now.
> 

I haven't modify your current cpufreq stats, they are still counting
total time (idle + running) for the given frequency. I think this is
still useful for some userspace tools. These new proposed stats don't
have such sysfs interface to read them. I don't know if userspace would
be interested in this information (the running only time). IIRC Android
uses bpf mechanisms to get this information to the userspace.
