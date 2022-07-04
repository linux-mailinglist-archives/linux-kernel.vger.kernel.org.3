Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F1565175
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiGDJ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiGDJ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:56:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA909DEC9;
        Mon,  4 Jul 2022 02:56:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFB4A23A;
        Mon,  4 Jul 2022 02:56:12 -0700 (PDT)
Received: from [10.57.41.108] (unknown [10.57.41.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F2E63F792;
        Mon,  4 Jul 2022 02:56:08 -0700 (PDT)
Message-ID: <a9ab7982-b235-ef5f-2c1b-ecbc421552d1@arm.com>
Date:   Mon, 4 Jul 2022 11:55:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/4] cpufreq: qcom-hw: LMH irq/hotplug interractions
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Dietmar.Eggemann@arm.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20220615144321.262773-1-pierre.gondois@arm.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20220615144321.262773-1-pierre.gondois@arm.com>
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

Hello,
I saw that:
https://lore.kernel.org/all/20220617064421.l4vshytmqtittzee@vireshk-i7/

was applied, so this patch-set would need to be rebased. Please let me
know if you think it requires modifications before it gets rebased,

Regards,
Pierre

On 6/15/22 16:43, Pierre Gondois wrote:
> This patch-set provides fixes for the qcom-cpufreq-hw driver regarding
> LMH irqs configurations and (un)plugging CPUs.
> commit ffd6cc92ab9c ("arm64: dts: qcom: sm8250: add description of dcvsh interrupts")
> enables DCVS (Dynamic Clock and Voltage Scaling) for sm8250 chips
> (so rb5 included). As no LMH (Limits Management Hardware) interrupts
> were seen, the firmware used for testing should not be able support
> them.
> 
> The patch-set was tested on a rb5 with an old firmware version:
> UEFI Ver    : 5.0.210817.BOOT.XF.3.2-00354-SM8250-1
> Build Info  : 64b Aug 17 2021 23:35:39
> 
> This patch-set should still contain relevant modifications regarding
> LMH interrupts and CPU hotplug. Still, it would be good to test
> it on a platform which actually uses LMH interrupts.
> 
> LMH irqs can be identified with:
>    cat /proc/interrupts | grep "dcvsh\-irq"
> and their configuration can be seen at:
>    /proc/irqs/XXX/*
> 
> Pierre Gondois (4):
>    cpufreq: qcom-hw: Reset cancel_throttle when policy is re-enabled
>    cpufreq: qcom-hw: Disable LMH irq when disabling policy
>    cpufreq: qcom-hw: Remove deprecated irq_set_affinity_hint() call
>    cpufreq: Change order of online() CB and policy->cpus modification
> 
>   drivers/cpufreq/cpufreq.c         |  6 +++---
>   drivers/cpufreq/qcom-cpufreq-hw.c | 16 ++++++++++++----
>   2 files changed, 15 insertions(+), 7 deletions(-)
> 
