Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435EA4C1188
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbiBWLlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbiBWLlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:41:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E9CE9859C;
        Wed, 23 Feb 2022 03:40:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A643106F;
        Wed, 23 Feb 2022 03:40:37 -0800 (PST)
Received: from [10.57.9.184] (unknown [10.57.9.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2000C3F70D;
        Wed, 23 Feb 2022 03:40:34 -0800 (PST)
Message-ID: <5fb6d841-db47-2009-9c41-e45f51de47cc@arm.com>
Date:   Wed, 23 Feb 2022 11:40:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/2] Introduce 'advanced' Energy Model in DT
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, nm@ti.com, sboyd@kernel.org, mka@chromium.org,
        dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220222140746.12293-1-lukasz.luba@arm.com>
 <467a7de4-df84-8e9e-a26a-80449ca55950@linaro.org>
 <20220223104341.jh5hjcv6ugaexgoa@vireshk-i7>
 <94d3f2a3-4145-afdc-d810-61f2120df579@arm.com>
 <20220223112727.akprxqglyr7ostqh@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220223112727.akprxqglyr7ostqh@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/22 11:27, Viresh Kumar wrote:
> On 23-02-22, 11:22, Lukasz Luba wrote:
>> On 2/23/22 10:43, Viresh Kumar wrote:
>>> On 23-02-22, 10:52, Daniel Lezcano wrote:
>>>> why not extend the energy model to any kind of devices?
>>>
>>> FWIW, the OPP core supports a wide range of devices now, not just CPUs.
> 
> There are many other devices which still use Freq.
> 
>> Is that the "opp-level" thing which would allow that?
> 
> For power supplies/regulators, we don't have freq and they use level, right.
> 
> Also for interconnect we use bandwidth, in a similar way.
> 
>> I can see some DT files with regulators(?) using it e.g. [1].
>> It looks flexible, the opp-hz is not hard requirement,
>> the opp-level can be used instead IIUC.
> 
> Right.
> 

Looks good. It also doesn't collide with this patch set.

We could have an opp entry like:

	opp_1: opp-1 {
		opp-level = <1>;
		opp-microwatt = <200000>;
	};

Daniel would that design make sense to you?


If yes, we could discuss this further after this first
step for fixing GPU in merged. I would need to re-think
the EM em_perf_state and maybe the new ::level there.
