Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB474A3EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiAaJAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:00:04 -0500
Received: from foss.arm.com ([217.140.110.172]:40708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231173AbiAaJAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:00:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B91FED1;
        Mon, 31 Jan 2022 00:59:59 -0800 (PST)
Received: from [10.57.9.236] (unknown [10.57.9.236])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4F443F73B;
        Mon, 31 Jan 2022 00:59:57 -0800 (PST)
Subject: Re: [PATCH v2 2/2] cpufreq: qcom-hw: Delay enabling throttle_irq
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20220128032554.155132-1-bjorn.andersson@linaro.org>
 <20220128032554.155132-2-bjorn.andersson@linaro.org>
 <5433250b-ee51-06e0-3ef8-ab287a112611@arm.com> <YfQ2WEiqV30PGNrt@ripper>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <64df8bc9-1c13-d9cf-3dba-d5e1cbf4c50a@arm.com>
Date:   Mon, 31 Jan 2022 08:59:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YfQ2WEiqV30PGNrt@ripper>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/22 6:30 PM, Bjorn Andersson wrote:
> On Fri 28 Jan 02:39 PST 2022, Lukasz Luba wrote:
> 
>>
>>
>> On 1/28/22 3:25 AM, Bjorn Andersson wrote:
>>> In the event that the SoC is under thermal pressure while booting it's
>>> possible for the dcvs notification to happen inbetween the cpufreq
>>> framework calling init and it actually updating the policy's
>>> related_cpus cpumask.
>>>
>>> Prior to the introduction of the thermal pressure update helper an empty
>>> cpumask would simply result in the thermal pressure of no cpus being
>>> updated, but the new code will attempt to dereference an invalid per_cpu
>>> variable.
>>
>> Just to confirm, is that per-cpu var the 'policy->related_cpus' in this
>> driver?
>>
> 
> Correct, we boot under thermal pressure, so the interrupt fires before
> we return from "init", which means that related_cpus is still 0.
> 
>>>
>>> Avoid this problem by using the newly reintroduced "ready" callback, to
>>> postpone enabling the IRQ until the related_cpus cpumask is filled in.
>>>
>>> Fixes: 0258cb19c77d ("cpufreq: qcom-cpufreq-hw: Use new thermal pressure update function")
>>
>> You have 'Fixes' tagging here, which might be picked by the stable tree.
>> The code uses the reverted callback .ready(), which might be missing
>> there (since patch 1/2 doesn't have tagging). This patch looks like a
>> proper fix for the root cause.
>>
> 
> Yes, the pair would need to be picked up.
> 
>> Anyway, I'm going to send a patch, which adds a check for null cpumask
>> in the topology_update_thermal_pressure()
>> It was removed after the review comments:
>> https://lore.kernel.org/linux-pm/20211028054459.dve6s2my2tq7odem@vireshk-i7/
>>
> 
> I attempted that in v1:
> https://lore.kernel.org/all/20220118185612.2067031-2-bjorn.andersson@linaro.org/
> 
> And while patch 1 is broken, I think Greg and Sudeep made it clear that
> they didn't want a condition to guard against the caller passing cpus of
> 0.

Thanks for the link, I missed that conversation.

> 
> That's why I in v2 reverted to postpone the thermal pressure IRQ until
> cpufreq is "ready".

Which is fixing the root cause, but involves this backporting
of the new API callback into stable.

Sorry to hear that you had to fight with this tricky mem fault.
There is a 'good' outcome from this: we know that the platform
instantly has thermal issues during boot.

Regards,
Lukasz
