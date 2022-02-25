Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F8D4C3E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbiBYGEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiBYGEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:04:00 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D7B180D24;
        Thu, 24 Feb 2022 22:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645769007; x=1677305007;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W5bXva93FwDdyCNuRXEqMTOJ+YHy71awVGh7/5U1QpU=;
  b=gZMAeaTNV3Cv96/fd65LHvUgI/k3DkoS1AuY+vGNTicmOKCGfNEToKbx
   U/k5Wmj8fzXY4lQU5KcLmFj/yL96kC+bDTJKJrSJzBsJv7FBm0K3hmWA0
   B1P8cQnBTUVn9Dnc9OWpv8aPsZZFiLSfWwuYXqBxm2cZbiFu0ADb+J+vU
   o=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 24 Feb 2022 22:03:27 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 22:03:26 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 24 Feb 2022 22:03:26 -0800
Received: from [10.50.41.45] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 24 Feb
 2022 22:03:23 -0800
Message-ID: <e4299485-5e20-9254-0c2b-b30be274dd89@quicinc.com>
Date:   Fri, 25 Feb 2022 11:33:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv4] tty: hvc: dcc: Bind driver to CPU core0 for reads and
 writes
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220210135632.24638-1-quic_saipraka@quicinc.com>
 <YgpyMRTo5wVMhUPl@FVFF77S0Q05N>
 <f8ab050f-117b-2c8e-71b8-dbfa38d24c03@quicinc.com>
 <YhPaGB2xdf6EhEvs@kroah.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <YhPaGB2xdf6EhEvs@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/21/2022 11:59 PM, Greg Kroah-Hartman wrote:
> On Tue, Feb 15, 2022 at 09:33:23AM +0530, Sai Prakash Ranjan wrote:
>> Hi Mark,
>>
>> On 2/14/2022 8:46 PM, Mark Rutland wrote:
>>> Hi,
>>>
>>> On Thu, Feb 10, 2022 at 07:26:32PM +0530, Sai Prakash Ranjan wrote:
>>>> From: Shanker Donthineni <shankerd@codeaurora.org>
>>>>
>>>> Some debuggers, such as Trace32 from Lauterbach GmbH, do not handle
>>>> reads/writes from/to DCC on secondary cores. Each core has its
>>>> own DCC device registers, so when a core reads or writes from/to DCC,
>>>> it only accesses its own DCC device. Since kernel code can run on
>>>> any core, every time the kernel wants to write to the console, it
>>>> might write to a different DCC.
>>>>
>>>> In SMP mode, Trace32 creates multiple windows, and each window shows
>>>> the DCC output only from that core's DCC. The result is that console
>>>> output is either lost or scattered across windows.
>>> This has been the Linux behaviour since the dawn of time, so why is this not
>>> considered to be a bug in the tools? Why can't Lauterbach add an option to
>>> treat the cores as one?
>> More like a feature request than a bug? And why would tools add such a
>> feature when
>> it is the kernel which runs in SMP mode? Shouldn't kernel be the one having
>> such a feature
>> because there would be number of such tools with the same issue and we can't
>> send a feature
>> request to all those tool vendors to add this feature right. Instead adding
>> this in the kernel would
>> avoid all these centrally at one place.
> Please fix this in userspace.

Please see below queries and let me know how do you handle them.

>
>>> Importantly, with hotplug we *cannot* guarantee that all messages will go to
>>> the same CPU anyway, since that could be offlined (even if it is CPU 0), so in
>>> general we cann't provide a guarantee here.
>> Right that is true, in case of CPU hotplug this would be pretty much broken
>> if CPU0 is offlined.
>> We use these during initial bringup stage of SoCs when we don't have debug
>> UART console up and running
>> and at the time we don't much care for testing out hotplugging the CPUs and
>> let alone trying out
>> to offline CPU0 which we use and shoot our own foot :)
>>
>> Given this is mostly a debug feature, we don't mind if this doesn't
>> guarantee to work in hotplug scenario.
> We do not get to choose this type of thing.  Either it will work
> properly, or not.  Offlineing cpu 0 happens with power management
> situations, right?  Especially with big/little systems, if CPU0 was a
> big one, you would remove it while only the little ones were running.

AFAIK on arm64, offlining CPU0 is possible via CPU device sysfs node but we aren't discussing about
manual offlining right? Because in that case a lot of code would need to be protected against a lot of
undesired effects like what if someone manually triggers sysrq panic (echo c > /proc/sysrq-trigger),
what protects us from it? Hopefully we are not talking about manual triggers.

Now about PM situations in arm64, correct me if I am wrong but I don't see CPU0(boot cpu) being offlined
in case of suspend to idle(which just puts CPUs into deep idle state and no offlining), suspend to ram or
suspend to disk.

In suspend to ram, I see only non-boot CPUs being offlined in suspend and brought back after resume.
See below snapshot of suspend to ram(mem) on my 8 CPU arm64 based board.

[312598.137531] Disabling non-boot CPUs ...
[312598.148144] psci: CPU1 killed (polled 1 ms)
[312598.159869] psci: CPU2 killed (polled 1 ms)
[312598.173832] psci: CPU3 killed (polled 1 ms)
[312598.187163] psci: CPU4 killed (polled 1 ms)
[312598.198006] psci: CPU5 killed (polled 1 ms)
[312598.208013] psci: CPU6 killed (polled 1 ms)
[312598.221245] psci: CPU7 killed (polled 1 ms)
[312598.237688] Enabling non-boot CPUs ...
[312598.245217] CPU1 is up
[312598.251017] CPU2 is up
[312598.257171] CPU3 is up
[312598.263882] CPU4 is up
[312598.271030] CPU5 is up
[312598.285948] CPU6 is up
[312598.291120] CPU7 is up

In case of suspend to disk, I believe its the same. I don't have any board which supports suspend to disk
or hibernation but looking at the code (kernel/power/hibernate.c -> pm_sleep_disable_secondary_cpus()),
it just disables non-boot cpus.

I hope I have covered your doubts regarding CPU PM and hotplug scenarios here?

Now coming to another reason which I mentioned before about this feature being used for early
SoC bringups, it is so early in the bringup stage that we don't even have any bootloaders/bootchain
involved which handles CPU PM states, meaning PSCI handlers for suspend and resume are not even
present at the time and we just have kernel loading directly from RAM. I mean at that stage we don't
even have a working debug UART which is why we use DCC and PM support is usually far away at that
stage.

> I still feel this should all be handled in userspace.

How would userspace take care of this problem with CPU hotplug? We can't open 100s of CPU T32 (JTAG tool)
windows, attach each of them and open DCC terminals initially so that userspace tool would be able to somehow
automagically migrate the messages on to different CPU when the current CPU goes offline? How would that work?

> Especially given the problems that this patch is having with being
> tested properly :(
>
> thanks,
>
> greg k-h

Hmm, I did test this version and reported the bug myself and posted a new version. As you know, these debug
configs (lock) are not present in default defconfig, so it went unnoticed, but have now enabled them for all the
future revisions of the patch.

Thanks,
Sai
