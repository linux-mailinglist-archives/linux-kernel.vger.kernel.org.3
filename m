Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215F74879D4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 16:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348123AbiAGPn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 10:43:27 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:39679 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230323AbiAGPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641570206; x=1673106206;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1bKTnpdPDCKCFfh2M//kBRLpjp/9Xjx7Og/VHfiyWnA=;
  b=DJdz/Nox2/BXixf0fqh6z4Pi2nhdGUKo0t7iRbjtcV49hOt9Cdmx8cDw
   HR27kO0Gzo69443vUfu+x7+qsHtwUY9N2+fRrbwoqmbSiy000cK99/RXO
   lfoPwVrHl0oDClEyfRqbRn0YY4Fm0FLuK4g8mYl4zghSjiyRHoYB887wc
   M=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Jan 2022 07:43:25 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 07:43:25 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 7 Jan 2022 07:43:24 -0800
Received: from [10.50.27.236] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 7 Jan 2022
 07:43:19 -0800
Message-ID: <84d36c7f-d75e-61f9-7670-c651cc50d083@quicinc.com>
Date:   Fri, 7 Jan 2022 21:13:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V6 0/7] Add driver support for Data Capture and Compare
 Engine(DCC) for SM8150,SC7280,SC7180,SDM845
Content-Language: en-CA
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, <vkoul@kernel.org>
References: <cover.1628617260.git.schowdhu@codeaurora.org>
 <396edd95-4f38-6830-99da-11e73d62a0cf@linaro.org>
 <705c280b-bced-476d-8e21-1a5afbf3d2f3@quicinc.com> <YdeDtlmPRQx3FU9i@ripper>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <YdeDtlmPRQx3FU9i@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/2022 5:35 AM, Bjorn Andersson wrote:
> On Thu 06 Jan 07:20 PST 2022, Souradeep Chowdhury wrote:
>
>> On 12/16/2021 9:18 PM, Thara Gopinath wrote:
>>>
>>> On 8/10/21 1:54 PM, Souradeep Chowdhury wrote:
>>>> DCC(Data Capture and Compare) is a DMA engine designed for debugging
>>>> purposes.In case of a system
>>>> crash or manual software triggers by the user the DCC hardware
>>>> stores the value at the register
>>>> addresses which can be used for debugging purposes.The DCC driver
>>>> provides the user with sysfs
>>>> interface to configure the register addresses.The options that the
>>>> DCC hardware provides include
>>>> reading from registers,writing to registers,first reading and then
>>>> writing to registers and looping
>>>> through the values of the same register.
>>>>
>>>> In certain cases a register write needs to be executed for accessing
>>>> the rest of the registers,
>>>> also the user might want to record the changing values of a register
>>>> with time for which he has the
>>>> option to use the loop feature.
>>> Hello Souradeep,
>>>
>>> First of all, I think this is very a useful feature to have. I have some
>>> generic design related queries/comments on driver and the interface
>>> exposed to the user space. Also, I do not understand the h/w well here,
>>> so feel free to correct me if I am wrong.
>>>
>>> 1. Linked list looks like a very internal feature to the h/w. It really
>>> is not an info that user should be aware of. I tried reading the code a
>>> bit. IUC, every time a s/w trigger is issued the configs in all the
>>> enabled linked lists are executed. The final ram dump that you get from
>>> /dev/dcc_sram is a dump of contents from all the enabled list? Is this
>>> understanding correct ? And we are talking of at-most 4 linked list?
>>> If yes, I think it might be better to have a folder per linked list with
>>> config, config_write etc. Also if possible it will be better to dump the
>>> results to a file in the specific folder instead of reading from
>>> /dev/dcc_sram.
>>> If no, there is no real need for user to know the linked list, right?
>>> Choosing of linked list can be done by kernel driver in this case with
>>> no input needed from user.
>>>
>>> 2. Now to the sysfs interface itself, I know lot of thought has gone
>>> into sysfs vs debugfs considerations. But, have you considered using
>>> netlink interface instead of sysfs. Netlink interface is used for
>>> asynchronous communication between kernel and user space. In case of
>>> DCC, the communication appears to be asynchronous, where in user asks
>>> the kernel to capture some info and kernel can indicate back to user
>>> when the info is captured. Also the entire mess surrounding echoing addr
>>> / value / offset repeatedly into a sysfs entry can be avoided using
>>> netlink interface.
>>>
>> Hello Thara,
>>
>> Thanks for your review comments. Following are some points from my end
>>
>>
>> 1) Each linked list represent a particular block of memory in DCC_SRAM which
>> is preserved for that particular list. That is why offset calculation is
>> done on the driver based on the linked list chosen by the user.
>>
>>      This choice needs to be made by the user since the number for the linked
>> list chosen is specific to the registers used to debug a particular
>> component.  Also we are giving the user flexibility to configure multiple
>>
>>      linked lists at one go so that even if we don't have a separate folder
>> for it , the dumps are collected as a separate list of registers. Also there
>> are certain curr_list values which may be supported by the dcc
>>
>>      hardware but may not be accessible to the user and so the choice cannot
>> be made arbitrarily from the driver.
>>
> But in the end, as you write out the SRAM content, is there really any
> linked lists? Afaict it's just a sequence of operations/commands. The
> linked list part seems to be your data structure of choice to keep track
> of these operations in the driver before flushing them out.

That is correct, the linked list defined in the driver is for storing 
the addresses sequentially in DCC_SRAM and is just an internal

data structure of the driver. However, there is also a "list" from DCC 
hardware perspective. The following driver code shows how

a list is initiated with the beginning and end sram offset so that DCC 
hardware can treat it as a separate list of addresses and dump

the values separately.

               /* 1. Take ownership of the list */
                 dcc_writel(drvdata, BIT(0), DCC_LL_LOCK(list));

                 /* 2. Program linked-list in the SRAM */
                 ram_cfg_base = drvdata->ram_cfg;
                 ret = __dcc_ll_cfg(drvdata, list);
                 if (ret) {
                         dcc_writel(drvdata, 0, DCC_LL_LOCK(list));
                         goto err;
                 }

                 /* 3. program DCC_RAM_CFG reg */
                 dcc_writel(drvdata, ram_cfg_base +
                         drvdata->ram_offset/4, DCC_LL_BASE(list));
                 dcc_writel(drvdata, drvdata->ram_start +
                         drvdata->ram_offset/4, DCC_FD_BASE(list));
                 dcc_writel(drvdata, 0xFFF, DCC_LL_TIMEOUT(list));

                 /* 4. Clears interrupt status register */
                 dcc_writel(drvdata, 0, DCC_LL_INT_ENABLE(list));
                 dcc_writel(drvdata, (BIT(0) | BIT(1) | BIT(2)),
                                         DCC_LL_INT_STATUS(list));

                 drvdata->enable[list] = true;

So when user enters multiple lists, the DCC hardware will process it as 
separate group of register values.

>
> Regards,
> Bjorn
>
>> 2) From opensource, I can see that Netlink has been used in most of the
>> cases where we need to notify stats to the user by taking the advantage of
>> asynchronous communication. In this case, that requirement is not
>>
>>      there since it is mostly one way communication from user to kernel. Also
>> since this is used for debugging purposes perhaps sysfs adds more
>> reliability than Netlink. In case of Netlink we have the additional
>>
>>       overhead of dealing with socket calls. Let me know otherwise.
>>
>>
>> Thanks,
>>
>> Souradeep
>>
>>
>>
>>
>>
