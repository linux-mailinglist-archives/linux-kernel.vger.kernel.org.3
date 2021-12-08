Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0C546CE52
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244523AbhLHHZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:25:28 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:45838 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240199AbhLHHZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638948116; x=1670484116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XiDhpDSCpksEc3gur7+h1bHxNvPYUsOTifvpixcJeds=;
  b=Pj2xHeYP9ZuonoIJkrGdgDxIkC0PrIQEqn0nQtCdFJZofSsCSFw8QUCk
   zUdZT3poXtXV4ShVZDs/pocgLPChTGwHqJD0KRMJNTKXPoBsnFdk9IfmB
   v98O8cvvryZlRhHjZGnxlRWG7gNZPkUcTuJOf+1JNl7tYYx//ofCMMIWE
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Dec 2021 23:21:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 23:21:55 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 23:21:55 -0800
Received: from [10.50.61.189] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 7 Dec 2021
 23:21:52 -0800
Message-ID: <9d1d80cf-977b-561c-faae-6e2487d1247b@quicinc.com>
Date:   Wed, 8 Dec 2021 12:51:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [RESEND PATCHv2] tty: hvc: dcc: Bind driver to core0 for reads
 and writes
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_eberman@quicinc.com>,
        <quic_tsoni@quicinc.com>
References: <20211208063847.27174-1-quic_saipraka@quicinc.com>
 <YbBX+cLRhJ5T+hBq@kroah.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <YbBX+cLRhJ5T+hBq@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/2021 12:30 PM, Greg Kroah-Hartman wrote:
> On Wed, Dec 08, 2021 at 12:08:47PM +0530, Sai Prakash Ranjan wrote:
>> From: Shanker Donthineni <shankerd@codeaurora.org>
>>
>> Some debuggers, such as Trace32 from Lauterbach GmbH, do not handle
>> reads/writes from/to DCC on secondary cores. Each core has its
>> own DCC device registers, so when a core reads or writes from/to DCC,
>> it only accesses its own DCC device. Since kernel code can run on
>> any core, every time the kernel wants to write to the console, it
>> might write to a different DCC.
>>
>> In SMP mode, Trace32 creates multiple windows, and each window shows
>> the DCC output only from that core's DCC. The result is that console
>> output is either lost or scattered across windows.
>>
>> Selecting this option will enable code that serializes all console
>> input and output to core 0. The DCC driver will create input and
>> output FIFOs that all cores will use. Reads and writes from/to DCC
>> are handled by a workqueue that runs only core 0.
>>
>> Link: https://lore.kernel.org/lkml/1435344756-20901-1-git-send-email-timur@codeaurora.org/
>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>> Acked-by: Adam Wallis <awallis@codeaurora.org>
>> Signed-off-by: Timur Tabi <timur@codeaurora.org>
>> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>> ---
>>
>> Resending this v2 since earlier one had a typo in the variable type.
>>
>> Changes in v2:
>>   * Checkpatch warning fixes.
>>   * Use of IS_ENABLED macros instead of ifdefs.
>>
>> I also thought of making it depends on !HOTPLUG_CPU since it is broken
>> in case core0 is hotplugged off, but apparently HOTPLUG_CPU kconfig
>> has weird dependency issues, i.e., gets selected by CONFIG_PM and others.
>> So it will be almost like this feature won't be selectable at all if
>> I add !HOTPLUG_CPU kconfig dependency. Also HVC_DCC is a debug feature
>> where we need Trace32 like tools to access DCC windows in which case
>> these shortcomings can be expected since manual intervention is required
>> anyways for attaching a core to Trace32, so it won't matter much.
> But your code will break on systems when cpu 0 goes away, so this isn't
> going to work well at all.  Please make this work for any cpu or handle
> the case when the cpu it is running on goes away.

It breaks as in we won't see the kernel logs in the userspace tools like 
Trace32 when CPU0 goes
off, it isn't any different from detaching cores from Trace32 manually. 
There is no way to auto migrate
to other CPU in such tools, you have to manually attach core to 
corresponding CPUs anyways.
How do you suppose we write code in kernel such that it auto migrate in 
such external tools?
Even if I did migrate to other CPU in kernel handling the hotplug case, 
it doesn't change anything,

I can try to handle the !HOTPLUG_CPU, i.e., untangle Kconfig mess 
although its out of scope if you
insist, might need some time to get through Kconfig things sorted.

> Also, this REALLY looks like you are trying to fix the kernel for a
> crazy userspace program.  Why not fix the userspace program instead?
> Isn't that easier and then that way it will work for any kernel version?

This isn't a bug fix but mostly a feature where we wouldn't want to open 
multiple windows to see the logs.
Would you do the same thing for your usual uart console? i.e., open all 
the 8 console (for 8 cpus) or 100s in
case of 100s of CPU cores and look through each of them? I think no, so 
similarly anyone wouldn't want to
open 8/100 windows of Trace32 or other userspace application which 
provides DCC functionality while debugging,
it's not good at all.

Also such feature requests do not go through for such tools, also there 
isn't a requirement for them since DCC is per
core which is what they implement, its the **kernel which runs SMP** 
which needs to handle this so it makes it easier
for the user to look at **kernel logs**, not Trace32 logs.

Also what would you do for other applications like Trace32? Send this 
feature request to all those tools out there?
How would that work?

Thanks,
Sai
