Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03228512CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245194AbiD1Hck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiD1Hcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:32:36 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7BC9AE72;
        Thu, 28 Apr 2022 00:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651130962; x=1682666962;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s0aUg2HE9PFZadcLahl2VUbpekkIPi6XLmEP0rOe9L8=;
  b=V+uY8ZCHcTN9aVj6Tz0lQLpWb6meb5KyNPCsqx4SbWf3CIvN9f5tETVn
   SLg7WRKFNu+Jg1IkRAFY+8wTsDRybx5Sip7fvxkfemUvviPmEvPWBJh8M
   eQzMIG4ulV6oYdyp+3vcMruMaojlStVt09mDVq7hk+VQft7xyMINLfnMY
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Apr 2022 00:29:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 00:29:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 00:29:20 -0700
Received: from [10.50.42.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 00:29:17 -0700
Message-ID: <96dc5e2e-5d88-52ce-c295-779603e668f2@quicinc.com>
Date:   Thu, 28 Apr 2022 12:59:13 +0530
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
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <YmorayBozWWRlTpP@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/2022 11:21 AM, Greg KH wrote:
> On Thu, Apr 28, 2022 at 09:00:13AM +0530, Sai Prakash Ranjan wrote:
>> Add logging support for MMIO high level accessors such as read{b,w,l,q}
>> and their relaxed versions to aid in debugging unexpected crashes/hangs
>> caused by the corresponding MMIO operation. Also add a generic flag
>> (__DISABLE_TRACE_MMIO__) which is used to disable MMIO tracing in nVHE KVM
>> and if required can be used to disable MMIO tracing for specific drivers.
> This "add a build flag to a Makefile to change how a driver operates"
> feels very wrong to me given that this is now a totally new way to
> control how a driver works at build time.  That's not anything we have
> done before for drivers and if added, is only going to create much added
> complexity.

Not exactly, there are already many such build flags being used currently across kernel.

Example: "-D__KVM_NVHE_HYPERVISOR__, D__KVM_VHE_HYPERVISOR__,
-D__NO_FORTIFY, -D__DISABLE_EXPORTS, -DDISABLE_BRANCH_PROFILING".

It gives us even more flexibility to disable feature for multiple files under a directory
rather than individually cluttering each file, look at "-D__KVM_NVHE_HYPERVISOR__"
for files under "arch/arm64/kvm/hyp/nvhe/".

> How about requiring that the #define be in the .c files, and not in the
> Makefile, as Makefile changes are much much harder to notice and review
> over time.

How is this cleaner, lets say we have many such drivers like all drivers under drivers/serial,
so we go and add #define for each of them? That looks more spread out than having all
such information under one file (Makefile).

And I didn't understand how is it harder to track changes to makefile? Makefile is  part
of the driver directory and any changes to makefile is visible to the corresponding maintainers.
Do you mean something else?

>
> Also, I see that this "disable the trace" feature has already been asked
> for for 2 other drivers in the Android kernel tree, why not include
> those changes here as well?  That kind of shows that this new feature is
> limited in that driver authors are already wanting it disabled, even
> before it is accepted.

That can be done later on top of this series right? This series mainly deals with adding
initial support for such tracing, there could be numerous drivers who might or might
not want the feature which can be added onto later. We can't actually identify all
the driver requirements upfront. As an example, we have already used the flag to
disable tracing for nVHE KVM, so we know how to use the flag.

> Because of that, who _will_ be using this feature?
>

Every driver except those two or few more, and it is not a bug or anything, they just want to disable it
to limit the logs in case of example UART driver since the reads/writes are very frequent in those cases
and the logs are not necessarily useful for them.

Thanks,
Sai
