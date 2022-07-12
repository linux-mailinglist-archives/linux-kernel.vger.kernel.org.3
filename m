Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8BA57168A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbiGLKHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiGLKHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:07:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED360AAB3E;
        Tue, 12 Jul 2022 03:07:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7D5D1516;
        Tue, 12 Jul 2022 03:07:14 -0700 (PDT)
Received: from [192.168.33.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58EA83F792;
        Tue, 12 Jul 2022 03:07:13 -0700 (PDT)
Message-ID: <20e4ffb8-905a-92e2-8ea2-6116e8031dac@arm.com>
Date:   Tue, 12 Jul 2022 11:07:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] cpufreq: schedutil: Move max CPU capacity to sugov_policy
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org
References: <20220711124229.16516-1-lukasz.luba@arm.com>
 <20220712084137.pb24lolhuk2yln4e@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220712084137.pb24lolhuk2yln4e@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/22 09:41, Viresh Kumar wrote:
> On 11-07-22, 13:42, Lukasz Luba wrote:
>> There is no need to keep the max CPU capacity in the per_cpu instance.
>> Furthermore, there is no need to check and update that variable
>> (sg_cpu->max) everytime in the frequency change request, which is part
>> of hot path. Instead use struct sugov_policy to store that information.
>> Initialize the max CPU capacity during the setup and start callback.
>> We can do that since all CPUs in the same frequency domain have the same
>> max capacity (capacity setup and thermal pressure are based on that).
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   kernel/sched/cpufreq_schedutil.c | 30 +++++++++++++++---------------
>>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> I tried to check all possible combinations on how this can break, but
> couldn't find one. I had to check that as this code is there since
> ages and none of us thought of it, which was surprising.

I thought the same.

> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Thanks for the ACK!
