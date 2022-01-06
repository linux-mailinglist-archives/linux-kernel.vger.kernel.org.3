Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7CC4866A3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240421AbiAFPUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:20:11 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:63968 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240393AbiAFPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641482410; x=1673018410;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VdhC7mh1p8Y8MIPqArIrmPlsIZq0Rjq9uAm2FjmLFsw=;
  b=GXuVoPMnTTPrrvzgbxe8Z1Rgf7HgXuN9mqz9Nr4AE5dvG4CHf3c3fiC3
   Lkmlljv6KcIJUFzOCTFAusgQn9uyEspluMzmXrMJNiOaY084lzJw/t4XJ
   ReVcwvrnf94Ys7bG72203ykgBq2No/l2/KllOGs0zjjrr5a3olFRYVWam
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Jan 2022 07:20:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 07:20:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 6 Jan 2022 07:20:09 -0800
Received: from [10.50.52.105] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 6 Jan 2022
 07:20:04 -0800
Message-ID: <705c280b-bced-476d-8e21-1a5afbf3d2f3@quicinc.com>
Date:   Thu, 6 Jan 2022 20:50:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V6 0/7] Add driver support for Data Capture and Compare
 Engine(DCC) for SM8150,SC7280,SC7180,SDM845
Content-Language: en-CA
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, <vkoul@kernel.org>
References: <cover.1628617260.git.schowdhu@codeaurora.org>
 <396edd95-4f38-6830-99da-11e73d62a0cf@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <396edd95-4f38-6830-99da-11e73d62a0cf@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/16/2021 9:18 PM, Thara Gopinath wrote:
>
>
> On 8/10/21 1:54 PM, Souradeep Chowdhury wrote:
>> DCC(Data Capture and Compare) is a DMA engine designed for debugging 
>> purposes.In case of a system
>> crash or manual software triggers by the user the DCC hardware stores 
>> the value at the register
>> addresses which can be used for debugging purposes.The DCC driver 
>> provides the user with sysfs
>> interface to configure the register addresses.The options that the 
>> DCC hardware provides include
>> reading from registers,writing to registers,first reading and then 
>> writing to registers and looping
>> through the values of the same register.
>>
>> In certain cases a register write needs to be executed for accessing 
>> the rest of the registers,
>> also the user might want to record the changing values of a register 
>> with time for which he has the
>> option to use the loop feature.
>
> Hello Souradeep,
>
> First of all, I think this is very a useful feature to have. I have 
> some generic design related queries/comments on driver and the 
> interface exposed to the user space. Also, I do not understand the h/w 
> well here, so feel free to correct me if I am wrong.
>
> 1. Linked list looks like a very internal feature to the h/w. It 
> really is not an info that user should be aware of. I tried reading 
> the code a bit. IUC, every time a s/w trigger is issued the configs in 
> all the enabled linked lists are executed. The final ram dump that you 
> get from /dev/dcc_sram is a dump of contents from all the enabled 
> list? Is this understanding correct ? And we are talking of at-most 4 
> linked list?
> If yes, I think it might be better to have a folder per linked list 
> with config, config_write etc. Also if possible it will be better to 
> dump the results to a file in the specific folder instead of reading 
> from /dev/dcc_sram.
> If no, there is no real need for user to know the linked list, right? 
> Choosing of linked list can be done by kernel driver in this case with 
> no input needed from user.
>
> 2. Now to the sysfs interface itself, I know lot of thought has gone 
> into sysfs vs debugfs considerations. But, have you considered using 
> netlink interface instead of sysfs. Netlink interface is used for 
> asynchronous communication between kernel and user space. In case of 
> DCC, the communication appears to be asynchronous, where in user asks 
> the kernel to capture some info and kernel can indicate back to user 
> when the info is captured. Also the entire mess surrounding echoing 
> addr / value / offset repeatedly into a sysfs entry can be avoided 
> using netlink interface.
>
Hello Thara,

Thanks for your review comments. Following are some points from my end


1) Each linked list represent a particular block of memory in DCC_SRAM 
which is preserved for that particular list. That is why offset 
calculation is done on the driver based on the linked list chosen by the 
user.

     This choice needs to be made by the user since the number for the 
linked list chosen is specific to the registers used to debug a 
particular component.  Also we are giving the user flexibility to 
configure multiple

     linked lists at one go so that even if we don't have a separate 
folder for it , the dumps are collected as a separate list of registers. 
Also there are certain curr_list values which may be supported by the dcc

     hardware but may not be accessible to the user and so the choice 
cannot be made arbitrarily from the driver.


2) From opensource, I can see that Netlink has been used in most of the 
cases where we need to notify stats to the user by taking the advantage 
of asynchronous communication. In this case, that requirement is not

     there since it is mostly one way communication from user to kernel. 
Also since this is used for debugging purposes perhaps sysfs adds more 
reliability than Netlink. In case of Netlink we have the additional

      overhead of dealing with socket calls. Let me know otherwise.


Thanks,

Souradeep





