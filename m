Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DACF4B0C48
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240839AbiBJLWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:22:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbiBJLWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:22:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC263F46;
        Thu, 10 Feb 2022 03:22:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77D27ED1;
        Thu, 10 Feb 2022 03:22:06 -0800 (PST)
Received: from [10.57.17.101] (unknown [10.57.17.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED6A03F73B;
        Thu, 10 Feb 2022 03:22:03 -0800 (PST)
Subject: Re: [PATCH v5 6/7] thermal: netlink: Add a new event to notify CPU
 capabilities change
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20220127193454.12814-1-ricardo.neri-calderon@linux.intel.com>
 <20220127193454.12814-7-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hbtmP6LHngWg0J47G2PwTxNwmjb=KMyz1zi1FM09cF8g@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ede29257-d356-9fc6-5f1a-c42721c0d072@arm.com>
Date:   Thu, 10 Feb 2022 11:22:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hbtmP6LHngWg0J47G2PwTxNwmjb=KMyz1zi1FM09cF8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/22 3:20 PM, Rafael J. Wysocki wrote:
> On Thu, Jan 27, 2022 at 8:33 PM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
>>
>> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>
>> Add a new netlink event to notify change in CPU capabilities in terms of
>> performance and efficiency.
>>
>> Firmware may change CPU capabilities as a result of thermal events in the
>> system or to account for changes in the TDP (thermal design power) level.
>>
>> This notification type will allow user space to avoid running workloads
>> on certain CPUs or proactively adjust power limits to avoid future events.
>>
>> The netlink message consists of a nested attribute
>> (THERMAL_GENL_ATTR_CPU_CAPABILITY) with three attributes:
>>
>>   * THERMAL_GENL_ATTR_CPU_CAPABILITY_ID (type u32):
>>     -- logical CPU number
>>   * THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE (type u32):
>>     -- Scaled performance from 0-1023
>>   * THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY (type u32):
>>     -- Scaled efficiency from 0-1023
>>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Aubrey Li <aubrey.li@linux.intel.com>
>> Cc: Lukasz Luba <lukasz.luba@arm.com>
>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
>> Reviewed-by: Len Brown <len.brown@intel.com>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Daniel, Lukasz, if you have any comments or concerns regarding this
> patch, please let me know.
> 

My apologies Rafael, I missed that email.

I've looked at the patches 6/7 and 7/7 and they look OK with the
scaling.
