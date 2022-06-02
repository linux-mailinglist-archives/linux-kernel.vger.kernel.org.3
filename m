Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B125353B5D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiFBJQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiFBJQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:16:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B18912612;
        Thu,  2 Jun 2022 02:16:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A39781063;
        Thu,  2 Jun 2022 02:16:27 -0700 (PDT)
Received: from [10.57.38.114] (unknown [10.57.38.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 309D93F766;
        Thu,  2 Jun 2022 02:16:26 -0700 (PDT)
Message-ID: <eada018c-b857-7946-ae4b-2532e6866a45@arm.com>
Date:   Thu, 2 Jun 2022 10:16:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] thermal/sysfs: Remove cooling device sysfs statistics
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, quic_manafm@quicinc.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Todd Kjos <tkjos@google.com>
References: <20220601151441.9128-1-daniel.lezcano@linaro.org>
 <20220601151441.9128-3-daniel.lezcano@linaro.org>
 <be8395e3-98d7-7a8f-7153-c491b22d4463@arm.com>
 <cb35e356-bc90-2a67-6983-1a4c3a0ea62d@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <cb35e356-bc90-2a67-6983-1a4c3a0ea62d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/22 09:37, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> [Adding Todd]
> 
> On 01/06/2022 17:33, Lukasz Luba wrote:
>> Hi Daniel,
>>
>>
>> On 6/1/22 16:14, Daniel Lezcano wrote:
>>> The statistics are for debugging purpose and belong to debugfs rather
>>> than sysfs. As the previous changes introduced the same statistics in
>>> debugfs, those in sysfs are no longer needed and can be removed.
>>
>> I just want to let you know that in current Android kernels we cannot
>> even compile the kernel with CONFIG_DEBUG_FS.
> 
> Right, it makes sense. Precisely, with the sysfs stats they are always 
> compiled in for the Android kernel and is a problem for low memory 
> systems. While debugfs can fulfill its purpose in the developement and 
> will be removed in production systems.

True.

> 
>> I have this pain with
>> Energy Model there... Some vendors might see useful info via this
>> sysfs interface in bring-up of the SoC.
> 
> Well alternatively, information can be extracted from procfs in the 
> device-tree description.
> 
> What prevents to add energy information in sysfs now that the energy 
> model is per device ?

Probably nothing, but we need strong need. I have proposed this
a few times internally, but this must have a requirement.
If a user-space tool would ask for it, then I could send a patch
exposing the sysfs. So far we have only one user-space tool, which
suffers the missing debugfs EM dir: LISA (but we are working on a
workaround for it).
If you have a tool or plan to have such, which uses EM, please let
me know. I'm gathering the requirements.

> 
>> I don't know if there are user-space tools tracking this
>> information via sysfs. We probably should check that.
>>
>> I agree that these statistics look more like debug info, rather than
>> something useful for control.
>>
>> Furthermore, we have trace events for the cooling state changes, which
>> should be good enough for bring-up and experiments.
>>
>> I don't have strong preferences here. I tend to agree to remove this
>> interface if there are no user-space tools using it.
> 
> I agree userspace can also get information about the transition but the 
> goal of the debugfs is also add information about thermal internals like 
> average temperature at mitigation time, min and max, timings, etc ...
> 
> 

I see, it makes sense. Let's see if Todd and Android folks don't
use this thermal sysfs stats, so we could remove them.
