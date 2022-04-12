Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AB74FD4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiDLHax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 03:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351840AbiDLHNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:13:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C5C117E1D;
        Mon, 11 Apr 2022 23:53:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC5691570;
        Mon, 11 Apr 2022 23:53:23 -0700 (PDT)
Received: from [10.57.11.184] (unknown [10.57.11.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 137983F73B;
        Mon, 11 Apr 2022 23:53:20 -0700 (PDT)
Message-ID: <55d4a19d-15d4-4d15-8430-8a8ed8149497@arm.com>
Date:   Tue, 12 Apr 2022 07:53:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RESEND][PATCH 0/8] Introduce support for artificial Energy Model
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     rafael@kernel.org
Cc:     dietmar.eggemann@arm.com, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, viresh.kumar@linaro.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mka@chromium.org, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, cristian.marussi@arm.com,
        sudeep.holla@arm.com, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org
References: <20220321095729.20655-1-lukasz.luba@arm.com>
 <76230a1c-73b8-c471-c62e-3ec9b33461a6@arm.com>
In-Reply-To: <76230a1c-73b8-c471-c62e-3ec9b33461a6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

gentle ping. If you need some help with this maintenance,
we can help.

Regards,
Lukasz

On 4/4/22 13:35, Lukasz Luba wrote:
> Hi Rafael,
> 
> 
> The patch set has been on LKML for quite a while and got one ACK,
> for the code touching something outside the EM (thermal cooling).
> 
> AFAICS there is no interest and objections from others for this code.
> 
> Therefore, I have a question:
> What would be be process to have merge this code?
> (We had internally a few reviews of this code)
> 
> On 3/21/22 09:57, Lukasz Luba wrote:
>> Hi all,
>>
>> This patch set adds new callback and support for artificial Energy 
>> Model (EM).
>> The new EMs have artificially generated performance states.
>> Such EMs can be created from lean information sources, such
>> as the relative energy efficiency between CPUs. The ACPI based
>> platforms provide this information
>> (ACPI 6.4, s5.2.12.14 'GIC CPU Interface (GICC) Structure'
>> 'Processor Power efficiency Class' field).
>>
>> Artificial EMs might require to directly provide the 'cost' of
>> the generated performance state. This patch set adds a new callback
>> .get_cost() for this. The EM framework does not force any model
>> or formula, it's up to the platform code.
>>
>> Artificial EMs aim to leverage the Energy Aware Scheduler
>> (EAS). Other frameworks relying on performance states
>> information (i.e. IPA/DTPM) must be informed of the
>> EM type and might be prevented from using it. This patch
>> sets also does this by introducing a new flag:
>> EM_PERF_DOMAIN_ARTIFICIAL.
>>
>> The patch set is based on current linux-next, where some
>> changes to OPP & EM are queuing.
>>
>> The patch set also contains (patch 7/8 and patch 8/8) logic which 
>> prevents
>> two EM's client frameworks from using this new EM type. Some other 
>> approach,
>> using 'milli-watts', has been proposed and discussed, but refused [1].
>> This new flag is more precised and should not leave space for
>> wrong interpretation.
>>
>> Shortly after this patch set you will see a patch set implementing the
>> platform code and registering this new EM.
>>
> 
> 
> No one from Arm is an official maintainer of the EM code.
> 
> Regards,
> Lukasz
