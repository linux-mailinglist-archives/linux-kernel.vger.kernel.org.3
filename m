Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980BF5133B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346294AbiD1Mcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346291AbiD1Mcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:32:47 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E37DAF1DE;
        Thu, 28 Apr 2022 05:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651148973; x=1682684973;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gYMv6mhRM0NW8wmhbrz7A30S7YrVvPdbhJi1KdJ+nbs=;
  b=yEcBT6F1+xYnXKQ+G7xAVLglS7pdi5RnQW7Znoy2ahnCOP3WBNkYOtFn
   7uT0mDES9oSwOmGuiqszO08JFc0667yMiXKlpyqBAGVONC8cnu8uCEaeo
   XXKiVvUBM9+rzFULc3lmXtBL3Li6GyWbOvEme7IE/0qRQpSdfZJuwVVN0
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 28 Apr 2022 05:29:33 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 05:29:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 05:29:32 -0700
Received: from [10.50.42.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 05:29:28 -0700
Message-ID: <da3c667c-cec3-58d8-b06f-b4e79796a07b@quicinc.com>
Date:   Thu, 28 Apr 2022 17:59:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv12 7/9] asm-generic/io: Add logging support for MMIO
 accessors
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <arnd@arndb.de>, <catalin.marinas@arm.com>, <rostedt@goodmis.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>
References: <cover.1651139070.git.quic_saipraka@quicinc.com>
 <6673a2e73d3dd4c7aa01fee9b26cc4a52176ba7a.1651139070.git.quic_saipraka@quicinc.com>
 <YmpxxW5CZjMVrzF0@kroah.com>
 <6688ffa2-ec14-9126-1296-6180bab3e1d6@quicinc.com>
 <YmqCYZwHoRuKtFSN@kroah.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <YmqCYZwHoRuKtFSN@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/2022 5:32 PM, Greg KH wrote:
> On Thu, Apr 28, 2022 at 04:51:49PM +0530, Sai Prakash Ranjan wrote:
>> On 4/28/2022 4:21 PM, Greg KH wrote:
>>> On Thu, Apr 28, 2022 at 03:25:30PM +0530, Sai Prakash Ranjan wrote:
>>>> Add logging support for MMIO high level accessors such as read{b,w,l,q}
>>>> and their relaxed versions to aid in debugging unexpected crashes/hangs
>>>> caused by the corresponding MMIO operation.
>>>>
>>>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>>>> ---
>>>>    include/asm-generic/io.h | 82 ++++++++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 78 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
>>>> index 7ce93aaf69f8..99090722cb4b 100644
>>>> --- a/include/asm-generic/io.h
>>>> +++ b/include/asm-generic/io.h
>>>> @@ -10,6 +10,7 @@
>>>>    #include <asm/page.h> /* I/O is all done through memory accesses */
>>>>    #include <linux/string.h> /* for memset() and memcpy() */
>>>>    #include <linux/types.h>
>>>> +#include <linux/instruction_pointer.h>
>>>>    #ifdef CONFIG_GENERIC_IOMAP
>>>>    #include <asm-generic/iomap.h>
>>>> @@ -61,6 +62,35 @@
>>>>    #define __io_par(v)     __io_ar(v)
>>>>    #endif
>>>> +#if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TRACE_MMIO__))
>>> Shouldn't you document __DISABLE_TRACE_MMIO__ somewhere?  It's not even
>>> in the changelog.  Put a big comment above this for what is is for and
>>> how to use it.  Otherwise you will forget all about this in 6 months :)
>>>
>>> thanks,
>>>
>>> greg k-h
>> Didn't you ask me to split the patch to the one actually adding the flag and the one using it.
> Yes, and isn't this the commit that adds the flag?  Or was that on an
> earlier one that I missed?
>
> Ah, it's in patch 6/9
>
> But you should also document it here in the .h file, otherwise the only
> place it is described is in some random kvm Makefile that no one will
> ever notice :)
>
>

Sure it makes sense, will add it.

Thanks,
Sai
