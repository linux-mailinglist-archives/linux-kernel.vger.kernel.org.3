Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A28F512D44
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245679AbiD1HsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbiD1HsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:48:23 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59D0237CE;
        Thu, 28 Apr 2022 00:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651131909; x=1682667909;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/YDX52+/j/A44N39TMxngrTWx9Wn1Ivl+//mFrTAagE=;
  b=b7npyMeSF0t/bUci2XNOTuSV8liiLwUo9J1+xPURfD76vGPsnbupdPrl
   fCZMK3zGra9LQ1T9ny5vOfIM1GtgczuCLG9IWGwL95I6KcHeC7pO9igGV
   qiJoFYykhDlX5nERw6yPoim44EDziQ6QmY22muESipe3hc9bkxKOw3Ooi
   I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Apr 2022 00:45:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 00:45:06 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 00:45:06 -0700
Received: from [10.50.42.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 00:45:03 -0700
Message-ID: <8b0ad0da-55ab-7b8b-e4a6-cd134567fb44@quicinc.com>
Date:   Thu, 28 Apr 2022 13:14:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv11 6/6] asm-generic/io: Add logging support for MMIO
 accessors
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <arnd@arndb.de>, <catalin.marinas@arm.com>, <rostedt@goodmis.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>
References: <cover.1645772606.git.quic_saipraka@quicinc.com>
 <3de35c9f4a3a070d197bab499acefc709a6f5336.1645772606.git.quic_saipraka@quicinc.com>
 <YmorayBozWWRlTpP@kroah.com>
 <96dc5e2e-5d88-52ce-c295-779603e668f2@quicinc.com>
 <YmpD3tIQK2iiqt46@kroah.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <YmpD3tIQK2iiqt46@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/2022 1:05 PM, Greg KH wrote:
> On Thu, Apr 28, 2022 at 12:59:13PM +0530, Sai Prakash Ranjan wrote:
>> On 4/28/2022 11:21 AM, Greg KH wrote:
>>> On Thu, Apr 28, 2022 at 09:00:13AM +0530, Sai Prakash Ranjan wrote:
>>>> Add logging support for MMIO high level accessors such as read{b,w,l,q}
>>>> and their relaxed versions to aid in debugging unexpected crashes/hangs
>>>> caused by the corresponding MMIO operation. Also add a generic flag
>>>> (__DISABLE_TRACE_MMIO__) which is used to disable MMIO tracing in nVHE KVM
>>>> and if required can be used to disable MMIO tracing for specific drivers.
>>> This "add a build flag to a Makefile to change how a driver operates"
>>> feels very wrong to me given that this is now a totally new way to
>>> control how a driver works at build time.  That's not anything we have
>>> done before for drivers and if added, is only going to create much added
>>> complexity.
>> Not exactly, there are already many such build flags being used currently across kernel.
>>
>> Example: "-D__KVM_NVHE_HYPERVISOR__, D__KVM_VHE_HYPERVISOR__,
> That's crazy KVM stuff, don't extrapoloate that to all kernel drivers
> please.

Ok :)

>> -D__NO_FORTIFY, -D__DISABLE_EXPORTS, -DDISABLE_BRANCH_PROFILING".
> Those are compiler flags that affect gcc, not kernel code functionality.
>
>> It gives us even more flexibility to disable feature for multiple files under a directory
>> rather than individually cluttering each file, look at "-D__KVM_NVHE_HYPERVISOR__"
>> for files under "arch/arm64/kvm/hyp/nvhe/".
> Again, crazy KVM stuff, do not want that for all drivers in the kernel.
>
>>> How about requiring that the #define be in the .c files, and not in the
>>> Makefile, as Makefile changes are much much harder to notice and review
>>> over time.
>> How is this cleaner, lets say we have many such drivers like all drivers under drivers/serial,
>> so we go and add #define for each of them? That looks more spread out than having all
>> such information under one file (Makefile).
> If you have to go and add this to each and every driver, that is a HUGE
> hint that this feature is not a good one and that no one should be using
> it in the first place, right?
>
> Again, this is a new way to modify driver functionality that is outside
> of the driver itself, which is not something that I would like to see
> added without a whole lot of discussion and planning.  To throw it in as
> part of a kvm change is not a nice way to hide such a thing.

Sure, will make the change as you suggested.

>> And I didn't understand how is it harder to track changes to makefile? Makefile is  part
>> of the driver directory and any changes to makefile is visible to the corresponding maintainers.
>> Do you mean something else?
> I mean that we review driver changes all the time, and code is
> self-contained and the functionality is only affected right now by
> Kconfig options, and what is in the .c files itself.  You are adding a
> new way to change functionality by adding a Makefile configuration
> option as well.  That is a major functional change for how we do our
> configuration logic in Linux.

Ah ok, you mean like that. Sure I don't have any strong opinion, so will move it
to the driver file.

>
>>> Also, I see that this "disable the trace" feature has already been asked
>>> for for 2 other drivers in the Android kernel tree, why not include
>>> those changes here as well?  That kind of shows that this new feature is
>>> limited in that driver authors are already wanting it disabled, even
>>> before it is accepted.
>> That can be done later on top of this series right? This series mainly deals with adding
>> initial support for such tracing, there could be numerous drivers who might or might
>> not want the feature which can be added onto later. We can't actually identify all
>> the driver requirements upfront. As an example, we have already used the flag to
>> disable tracing for nVHE KVM, so we know how to use the flag.
> Again, make it explicit in the driver file itself that it is doing this,
> not in the Makefile, and I will not have any objections.

Ok, for kernel drivers I will make the define at the top of the .c driver file and include
those 2 driver changes in the series.

>>> Because of that, who _will_ be using this feature?
>>>
>> Every driver except those two or few more, and it is not a bug or anything, they just want to disable it
>> to limit the logs in case of example UART driver since the reads/writes are very frequent in those cases
>> and the logs are not necessarily useful for them.
> I have a feeling that lots more drivers will want this disabled due to
> the noise it will cause.  The fact that we already have 2 requests to
> change this _before_ the code is even merged is proof of that.
>
> thanks,
>
> greg k-h

Thanks,
Sai
