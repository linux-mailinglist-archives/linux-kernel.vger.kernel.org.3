Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEA65115A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiD0Kuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiD0KuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:50:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3225E36CE00
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:21:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F5D2143D;
        Wed, 27 Apr 2022 02:21:47 -0700 (PDT)
Received: from [10.57.7.196] (unknown [10.57.7.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06DFB3F5A1;
        Wed, 27 Apr 2022 02:21:45 -0700 (PDT)
Message-ID: <c24afde6-9f78-155e-c3ec-629e4e832005@arm.com>
Date:   Wed, 27 Apr 2022 10:21:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4] arch_topology: Trace the update thermal pressure
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        rafael@kernel.org, rostedt@goodmis.org, mingo@redhat.com
References: <20220427080806.1906-1-lukasz.luba@arm.com>
 <YmkK32iEJ6bVyoMU@kroah.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <YmkK32iEJ6bVyoMU@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/22 10:20, Greg KH wrote:
> On Wed, Apr 27, 2022 at 09:08:06AM +0100, Lukasz Luba wrote:
>> Add trace event to capture the moment of the call for updating the thermal
>> pressure value. It's helpful to investigate how often those events occur
>> in a system dealing with throttling. This trace event is needed since the
>> old 'cdev_update' might not be used by some drivers.
>>
>> The old 'cdev_update' trace event only provides a cooling state
>> value: [0, n]. That state value then needs additional tools to translate
>> it: state -> freq -> capacity -> thermal pressure. This new trace event
>> just stores proper thermal pressure value in the trace buffer, no need
>> for additional logic. This is helpful for cooperation when someone can
>> simply sends to the list the trace buffer output from the platform (no
>> need from additional information from other subsystems).
>>
>> There are also platforms which due to some design reasons don't use
>> cooling devices and thus don't trigger old 'cdev_update' trace event.
>> They are also important and measuring latency for the thermal signal
>> raising/decaying characteristics is in scope. This new trace event
>> would cover them as well.
>>
>> We already have a trace point 'pelt_thermal_tp' which after a change to
>> trace event can be paired with this new 'thermal_pressure_update' and
>> derive more insight what is going on in the system under thermal pressure
>> (and why).
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Much better, thanks.  I'll wait for Sudeep's comments/review before
> taking it into my tree.
> 
> greg k-h

Thank you Greg!
