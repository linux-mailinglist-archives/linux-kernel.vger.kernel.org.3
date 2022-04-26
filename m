Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224865100A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351685AbiDZOoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351183AbiDZOn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:43:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 821E613F14;
        Tue, 26 Apr 2022 07:40:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A68923A;
        Tue, 26 Apr 2022 07:40:48 -0700 (PDT)
Received: from [10.57.12.108] (unknown [10.57.12.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B78D63F73B;
        Tue, 26 Apr 2022 07:40:46 -0700 (PDT)
Message-ID: <0bc7e213-ecb5-10f5-4c5a-b809252dac22@arm.com>
Date:   Tue, 26 Apr 2022 15:40:45 +0100
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
 <f6bb20c6-38a0-57d6-8979-d14e445da623@arm.com>
 <20220426075402.qjpato6sqy2kes4x@vireshk-i7>
 <9eac86b6-0221-0f62-ac4f-f9e3b1613422@arm.com>
 <20220426080210.hvzrsa4kmxesn6dv@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220426080210.hvzrsa4kmxesn6dv@vireshk-i7>
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



On 4/26/22 09:02, Viresh Kumar wrote:
> On 26-04-22, 08:59, Lukasz Luba wrote:
>> :) but I didn't dare to make it sysfs. I don't know if anything in
>> user-space would be interested (apart from my test scripts).
> 
> Sure, I was talking about hierarchy in debugfs only. Will be useful if
> you can show how it looks and what all data is exposed.
> 

I've created a new way for sharing such thing. Please check the rendered
notebook at [1]. You can find raw output of that debugfs at cell 9 or
in cell 11 as a dictionary. The residency is in ns. You can also find a
diff from two snapshots for all cpus at cell 16. We randomly use Little
cpus: 0,3,4,5.

At the bottom you can find plots for all cpus, their active residency at
frequencies. Cpu1 and cpu2 are big, cpu2 has been hotplug out so there
is an empty plot (which is good).

BTW, if you are interested in comparison of different input power
estimation mechanism, you can find them here [2]. There are 4 different
power signals. One is real from Juno power/energy meters the rest
is SW estimations of avg power for the 100ms period. As you can see
there in cell 25 plot, the new proposal in this patch set is better
that two previous one used in mainline. The last plot shows real
power signal and the new avg signal. The plot is interactive and
supports 'Box Zoom' on the right (scroll to right to see that toolbox).

Regards,
Lukasz

[1] 
https://nbviewer.org/github/lukaszluba-arm/lisa/blob/public_tests/ipa_input_power-debugfs.ipynb
[2] 
https://nbviewer.org/github/lukaszluba-arm/lisa/blob/public_tests/ipa_input_power.ipynb
