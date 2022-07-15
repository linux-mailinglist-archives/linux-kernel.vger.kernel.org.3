Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34389575E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiGOI4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGOI4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:56:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEB2F2AE5;
        Fri, 15 Jul 2022 01:56:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F79C1474;
        Fri, 15 Jul 2022 01:56:46 -0700 (PDT)
Received: from [10.57.11.112] (unknown [10.57.11.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 428F43F792;
        Fri, 15 Jul 2022 01:56:43 -0700 (PDT)
Message-ID: <c334d692-9787-7591-54d7-f152ecbd559e@arm.com>
Date:   Fri, 15 Jul 2022 09:56:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 0/4] Energy Model power in micro-Watts and SCMI v3.1
 alignment
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com,
        viresh.kumar@linaro.org, dietmar.eggemann@arm.com, nm@ti.com,
        sboyd@kernel.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220707071555.10085-1-lukasz.luba@arm.com>
 <41c333e1-2545-f6be-2db2-9061297d0b9a@arm.com>
In-Reply-To: <41c333e1-2545-f6be-2db2-9061297d0b9a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

gentle ping.

On 7/7/22 11:46, Lukasz Luba wrote:
> Hi Rafael,
> 
> On 7/7/22 08:15, Lukasz Luba wrote:
>> Hi all,
>>
>> This is a patch set which changes Energy Model power values scale to
>> micro-Watts. It also upgrades the SCMI performance layer + scmi-cpufreq
>> driver to leverage the SCMI v3.1 spec and process micro-Watts power 
>> values
>> coming from FW. The higher precision in EM power field solves an issue
>> of a rounding error, which then can be misinterpreted as 'inefficient 
>> OPP'.
>> An example rounding issue calculation is present in patch 1/4 
>> description.
>>
>> Changes:
>> v2
>> - simplified 32bit checks for max number of CPUs preventing energy
>>    estimation overflow
>> - added Reviewed-by and ACKs
>> v1 [1]
>>
>> Regards,
>> Lukasz Luba
>>
>> [1] 
>> https://lore.kernel.org/lkml/20220622145802.13032-1-lukasz.luba@arm.com/
>>
>> Lukasz Luba (4):
>>    PM: EM: convert power field to micro-Watts precision and align drivers
>>    Documentation: EM: Switch to micro-Watts scale
>>    firmware: arm_scmi: Get detailed power scale from perf
>>    cpufreq: scmi: Support the power scale in micro-Watts in SCMI v3.1
>>
>>   Documentation/power/energy-model.rst  | 14 +++----
>>   drivers/cpufreq/mediatek-cpufreq-hw.c |  7 ++--
>>   drivers/cpufreq/scmi-cpufreq.c        | 15 +++++++-
>>   drivers/firmware/arm_scmi/perf.c      | 18 +++++----
>>   drivers/opp/of.c                      | 15 ++++----
>>   drivers/powercap/dtpm_cpu.c           |  5 +--
>>   drivers/thermal/cpufreq_cooling.c     | 13 ++++++-
>>   drivers/thermal/devfreq_cooling.c     | 19 ++++++++--
>>   include/linux/energy_model.h          | 54 +++++++++++++++++++--------
>>   include/linux/scmi_protocol.h         |  8 +++-
>>   kernel/power/energy_model.c           | 24 ++++++++----
>>   11 files changed, 132 insertions(+), 60 deletions(-)
>>
> 
> I got ACKs (and on Reviewed-by) for this patch set.
> Could you take this via your PM tree, please?

This patch set is on our roadmap and would be good if it could
go as v5.20 material.

There are Acks for these patch set. If you need some
help with this (like rebasing, etc), just ping me.

Could you take them, please?

Regards,
Lukasz
