Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5449F77E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbiA1Kjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:39:44 -0500
Received: from foss.arm.com ([217.140.110.172]:35540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbiA1Kjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:39:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB643113E;
        Fri, 28 Jan 2022 02:39:43 -0800 (PST)
Received: from [10.57.12.131] (unknown [10.57.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59F8E3F766;
        Fri, 28 Jan 2022 02:39:42 -0800 (PST)
Subject: Re: [PATCH v2 2/2] cpufreq: qcom-hw: Delay enabling throttle_irq
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20220128032554.155132-1-bjorn.andersson@linaro.org>
 <20220128032554.155132-2-bjorn.andersson@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <5433250b-ee51-06e0-3ef8-ab287a112611@arm.com>
Date:   Fri, 28 Jan 2022 10:39:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220128032554.155132-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/22 3:25 AM, Bjorn Andersson wrote:
> In the event that the SoC is under thermal pressure while booting it's
> possible for the dcvs notification to happen inbetween the cpufreq
> framework calling init and it actually updating the policy's
> related_cpus cpumask.
> 
> Prior to the introduction of the thermal pressure update helper an empty
> cpumask would simply result in the thermal pressure of no cpus being
> updated, but the new code will attempt to dereference an invalid per_cpu
> variable.

Just to confirm, is that per-cpu var the 'policy->related_cpus' in this
driver?

> 
> Avoid this problem by using the newly reintroduced "ready" callback, to
> postpone enabling the IRQ until the related_cpus cpumask is filled in.
> 
> Fixes: 0258cb19c77d ("cpufreq: qcom-cpufreq-hw: Use new thermal pressure update function")

You have 'Fixes' tagging here, which might be picked by the stable tree.
The code uses the reverted callback .ready(), which might be missing
there (since patch 1/2 doesn't have tagging). This patch looks like a
proper fix for the root cause.

Anyway, I'm going to send a patch, which adds a check for null cpumask
in the topology_update_thermal_pressure()
It was removed after the review comments:
https://lore.kernel.org/linux-pm/20211028054459.dve6s2my2tq7odem@vireshk-i7/

I'll also push that change for the stable tree.

Regards,
Lukasz
