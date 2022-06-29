Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2961355FC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiF2JuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiF2Jti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:49:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5C933D1F4;
        Wed, 29 Jun 2022 02:49:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C684F152B;
        Wed, 29 Jun 2022 02:49:37 -0700 (PDT)
Received: from [192.168.33.8] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C25B3F792;
        Wed, 29 Jun 2022 02:49:35 -0700 (PDT)
Message-ID: <be793e51-0d89-7afd-e122-ec929a1130e9@arm.com>
Date:   Wed, 29 Jun 2022 10:49:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/4] Energy Model power in micro-Watts and SCMI v3.1
 alignment
Content-Language: en-US
To:     linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com, nm@ti.com, sboyd@kernel.org,
        sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220622145802.13032-1-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220622145802.13032-1-lukasz.luba@arm.com>
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

Hi guys,

Are there any objections to these patches?


On 6/22/22 15:57, Lukasz Luba wrote:
> Hi all,
> 
> This is a patch set which changes Energy Model power values scale to
> micro-Watts. It also upgrades the SCMI performance layer + scmi-cpufreq
> driver to leverage the SCMI v3.1 spec and process micro-Watts power values
> coming from FW. The higher precision in EM power field solves an issue
> of a rounding error, which then can be misinterpreted as 'inefficient OPP'.
> An example rounding issue calculation is present in patch 1/4 description.
> 
> Regards,
> Lukasz Luba
> 
> Lukasz Luba (4):
>    PM: EM: convert power field to micro-Watts precision and align drivers
>    Documentation: EM: Switch to micro-Watts scale
>    firmware: arm_scmi: Get detailed power scale from perf
>    cpufreq: scmi: Support the power scale in micro-Watts in SCMI v3.1
> 
>   Documentation/power/energy-model.rst  | 14 +++---
>   drivers/cpufreq/mediatek-cpufreq-hw.c |  7 +--
>   drivers/cpufreq/scmi-cpufreq.c        | 15 ++++++-
>   drivers/firmware/arm_scmi/perf.c      | 18 +++++---
>   drivers/opp/of.c                      | 15 ++++---
>   drivers/powercap/dtpm_cpu.c           |  5 +--
>   drivers/thermal/cpufreq_cooling.c     | 13 +++++-
>   drivers/thermal/devfreq_cooling.c     | 19 ++++++--
>   include/linux/energy_model.h          | 63 ++++++++++++++++++++-------
>   include/linux/scmi_protocol.h         |  8 +++-
>   kernel/power/energy_model.c           | 31 ++++++++-----
>   11 files changed, 146 insertions(+), 62 deletions(-)
> 


I would like to move forward with the micro-Watts in
the Energy Model. We have feedback from our partners
that this is a limitation. Also, as you can see
this uW is part of the new SCMI spec, which we
have support on our roadmap.

Regards,
Lukasz
