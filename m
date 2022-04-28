Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3EE512C42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244750AbiD1HJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiD1HJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:09:16 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782FD7CB03;
        Thu, 28 Apr 2022 00:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651129561; x=1682665561;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KV3xSjx5IORH3nBw259kA2U6vXkqu4AbHZhtuFZNwhY=;
  b=vi8bvwbPWIWkzIr1DwDGamI7KLO/B1X2wWsTUwoPRrx6MNg0Djaz17mC
   XZSk5+2jEkvwSfJ54+A8tTKfC2QSmmfnV9Jf2Y13z2Hvz2JG5G+9hm+jb
   HxFRPD2RqF9d3H20NWjftzB/I1kAprbqJHZfahkkQOlhM+BooDlSLgedR
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 28 Apr 2022 00:06:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 00:06:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 00:06:00 -0700
Received: from [10.50.42.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 00:05:57 -0700
Message-ID: <cbf3c7e4-a8c8-51d1-f245-cfbcbccc6a51@quicinc.com>
Date:   Thu, 28 Apr 2022 12:35:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv6] tty: hvc: dcc: Bind driver to CPU core0 for reads and
 writes
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20220310032636.7286-1-quic_saipraka@quicinc.com>
 <YlkPvnBYzJo9aeZ2@kroah.com>
 <cad739da-75af-8d2f-4107-72c657b9acab@quicinc.com>
 <Ymo7ODt+bToCf5Y2@kroah.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <Ymo7ODt+bToCf5Y2@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/2022 12:29 PM, Greg Kroah-Hartman wrote:
> On Thu, Apr 28, 2022 at 10:04:34AM +0530, Sai Prakash Ranjan wrote:
>> Hi Greg,
>>
>> On 4/15/2022 11:55 AM, Greg Kroah-Hartman wrote:
>>> On Thu, Mar 10, 2022 at 08:56:36AM +0530, Sai Prakash Ranjan wrote:
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
>>>>
>>>> Selecting this option will enable code that serializes all console
>>>> input and output to core 0. The DCC driver will create input and
>>>> output FIFOs that all cores will use. Reads and writes from/to DCC
>>>> are handled by a workqueue that runs only core 0.
>>>>
>>>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>>>> Acked-by: Adam Wallis <awallis@codeaurora.org>
>>>> Signed-off-by: Timur Tabi <timur@codeaurora.org>
>>>> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
>>>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>>>> ---
>>>>
>>>> Changes in v6:
>>>>    * Disable CPU hotplug when CONFIG_HVC_DCC_SERIALIZE_SMP=y.
>>>>
>>>> Changes in v5:
>>>>    * Use get_cpu() and put_cpu() for CPU id check in preemptible context.
>>>>    * Revert back to build time Kconfig.
>>>>    * Remove unnecessary hotplug locks, they result in sleeping in atomic context bugs.
>>>>    * Add a comment for the spinlock.
>>>>
>>>> Changes in v4:
>>>>    * Use module parameter for runtime choice of enabling this feature.
>>>>    * Use hotplug locks to avoid race between cpu online check and work schedule.
>>>>    * Remove ifdefs and move to common ops.
>>>>    * Remove unnecessary check for this configuration.
>>>>    * Use macros for buf size instead of magic numbers.
>>>>    * v3 - https://lore.kernel.org/lkml/20211213141013.21464-1-quic_saipraka@quicinc.com/
>>>>
>>>> Changes in v3:
>>>>    * Handle case where core0 is not online.
>>>>
>>>> Changes in v2:
>>>>    * Checkpatch warning fixes.
>>>>    * Use of IS_ENABLED macros instead of ifdefs.
>>>>
>>>> ---
>>>>    drivers/tty/hvc/Kconfig   |  20 +++++
>>>>    drivers/tty/hvc/hvc_dcc.c | 175 +++++++++++++++++++++++++++++++++++++-
>>>>    2 files changed, 192 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
>>>> index 8d60e0ff67b4..62560cd0c04d 100644
>>>> --- a/drivers/tty/hvc/Kconfig
>>>> +++ b/drivers/tty/hvc/Kconfig
>>>> @@ -87,6 +87,26 @@ config HVC_DCC
>>>>    	  driver. This console is used through a JTAG only on ARM. If you don't have
>>>>    	  a JTAG then you probably don't want this option.
>>>> +config HVC_DCC_SERIALIZE_SMP
>>>> +	bool "Use DCC only on CPU core 0"
>>>> +	depends on SMP && HVC_DCC
>>>> +	help
>>>> +	  Some debuggers, such as Trace32 from Lauterbach GmbH, do not handle
>>>> +	  reads/writes from/to DCC on more than one CPU core. Each core has its
>>>> +	  own DCC device registers, so when a CPU core reads or writes from/to
>>>> +	  DCC, it only accesses its own DCC device. Since kernel code can run on
>>>> +	  any CPU core, every time the kernel wants to write to the console, it
>>>> +	  might write to a different DCC.
>>>> +
>>>> +	  In SMP mode, Trace32 creates multiple windows, and each window shows
>>>> +	  the DCC output only from that core's DCC. The result is that console
>>>> +	  output is either lost or scattered across windows.
>>> Why are we documenting, and supporting, a closed source userspace tool
>>> with kernel changes?  Does this advertisement deserve to be in the
>>> kernel source tree?
>> Ok, I will remove the comment.
>>
>>> And why can't they just fix their tool if this is such a big issue?  Why
>>> does this only affect this one platform and not all other smp systems?
>> Hmm, this has been discussed in all the past versions of this series and still we
>> are at the same question :) I will write a small summary below which will cover
>> mostly relevant discussions we discussed till now and then I can point to it
>> whenever this question is asked again.
> No, it needs to go into the changelog text so that we know what we are
> reviewing and considering when you submit it.  Never refer back to some
> old conversation, how are we supposed to remember that?

True given the amount of patches you handle. I will be explicit and add more details in the next
version.

> So this all seems to be debugging-only code, and this config option
> should NEVER be turned on for a real system.  That makes much more
> sense, and is something that I don't recall anyone saying before.

Ah my bad, I thought it was known thing given the DCC driver was already
present.

> So make this very very explicit, both in the changelog, and in the
> Kconfig text, AND when the driver loads have it spit out a huge message
> in the kernel log saying that this is for debugging only and that no one
> should see this on a normal running system.  We have examples of other
> Kconfig options that do this at runtime, copy what they do so it's
> painfully obvious.  Like what is in clk_debug_init().

Sure, I will make these changes and post.

Thanks,
Sai
