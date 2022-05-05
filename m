Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9CE51BFF6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359554AbiEEM5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiEEM5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:57:39 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DF56216;
        Thu,  5 May 2022 05:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651755239; x=1683291239;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HwR97P478iK45CdIdkPRinoYCx69pi/2Zftw98mI8mM=;
  b=imP2wIuGUHJ3ctlzZ5BXmOGMs7TBlx69JUuLW3II3Nc+oYRhOH0YO2xY
   JFkeeB6auDCCbCj4a7GTN2HYedaX4nCKsmsYJI2aEioxqM23lrJQ4Lr/d
   U2QgjGHwGqGSzD/7tGPkMoFelepVCv7eC1wFi+Ca5vb6R+E78ArGtfXpF
   A=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 May 2022 05:53:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 05:53:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 05:53:57 -0700
Received: from [10.79.142.210] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 5 May 2022
 05:53:53 -0700
Message-ID: <0997f2bc-e8ce-24cc-da90-0ecd3201350c@quicinc.com>
Date:   Thu, 5 May 2022 18:23:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V7 2/7] soc: qcom: dcc:Add driver support for Data Capture
 and Compare unit(DCC)
Content-Language: en-CA
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Alex Elder" <elder@ieee.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@codeaurora.org>,
        <vkoul@kernel.org>
References: <cover.1646285069.git.quic_schowdhu@quicinc.com>
 <bc8504bdaf24d98762e2dbad7d084ca247380f06.1646285069.git.quic_schowdhu@quicinc.com>
 <YnFuXYEXxLQkak24@builder.lan>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <YnFuXYEXxLQkak24@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/3/2022 11:33 PM, Bjorn Andersson wrote:
> On Thu 03 Mar 00:27 CST 2022, Souradeep Chowdhury wrote:
>
>> The DCC is a DMA Engine designed to capture and store data
>> during system crash or software triggers. The DCC operates
>> based on user inputs via the sysfs interface. The user gives
>> addresses as inputs and these addresses are stored in the
>> dcc sram. In case of a system crash or a manual software
>> trigger by the user through the debugfs interface,
>> the dcc captures and stores the values at these addresses.
>> This patch contains the driver which has all the methods
>> pertaining to the debugfs interface, auxiliary functions to
>> support all the four fundamental operations of dcc namely
>> read, write, read/modify/write and loop. The probe method
>> here instantiates all the resources necessary for dcc to
>> operate mainly the dedicated dcc sram where it stores the
>> values. The DCC driver can be used for debugging purposes
>> without going for a reboot since it can perform software
>> triggers as well based on user inputs.
>>
>> Also added the documentation for debugfs entries and explained
>> the functionalities of each debugfs file that has been created
>> for dcc.
>>
>> The following is the justification of using debugfs interface
>> over the other alternatives like sysfs/ioctls
>>
>> i) As can be seen from the debugfs attribute descriptions,
>> some of the debugfs attribute files here contains multiple
>> arguments which needs to be accepted from the user. This goes
>> against the design style of sysfs.
>>
>> ii) The user input patterns have been made simple and convenient
>> in this case with the use of debugfs interface as user doesn't
>> need to shuffle between different files to execute one instruction
>> as was the case on using other alternatives.
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   Documentation/ABI/testing/debugfs-driver-dcc |  124 +++
>>   drivers/soc/qcom/Kconfig                     |    8 +
>>   drivers/soc/qcom/Makefile                    |    1 +
>>   drivers/soc/qcom/dcc.c                       | 1465 ++++++++++++++++++++++++++
>>   4 files changed, 1598 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/debugfs-driver-dcc
>>   create mode 100644 drivers/soc/qcom/dcc.c
>>
>> diff --git a/Documentation/ABI/testing/debugfs-driver-dcc b/Documentation/ABI/testing/debugfs-driver-dcc
>> new file mode 100644
>> index 0000000..70029ab
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-driver-dcc
>> @@ -0,0 +1,124 @@
>> +What:          /sys/kernel/debug/dcc/.../trigger
>> +Date:          March 2022
>> +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This is the debugfs interface for manual software
>> +		triggers. The user can simply enter a 1 against
>> +		the debugfs file and enable a manual trigger.
>> +		Example:
>> +		echo  1 > /sys/kernel/debug/dcc/.../trigger
>> +
>> +What:          /sys/kernel/debug/dcc/.../enable
>> +Date:          March 2022
>> +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This debugfs interface is used for enabling the
>> +		the dcc hardware. On enabling the dcc, all the
>> +		addresses entered by the user is written into
>> +		dcc sram which is read by the dcc hardware on
>> +		manual or crash induced triggers.
>> +		Example:
>> +		echo  0 > /sys/bus/platform/devices/.../enable
>> +		(disable dcc)
>> +		echo  1 > /sys/bus/platform/devices/.../enable
>> +		(enable dcc)
>> +
>> +What:          /sys/kernel/debug/dcc/.../config_read
> As mentioned last time, I don't like this interface of having 6 files
> that the user can write to in order to append items in the currently
> selected linked list.
>
> Why can't this be a single "config" which takes a multiline string of
> operations? (Bonus point for supporting appending to the list).
>
>
> This would also serve as a natural place to dump the linked list back to
> the user for inspection.

Following is the justification of having multiple files in debugfs

1-> Since there are fundamentally 4 instructions for DCC, 
Read,Write,Read and then Write and Loop,having separate debugfs files 
for the same makes it

        convenient for the user to use this tool and also to 
document.This also is consistent with the design principles of debugfs 
as it supports logical segregation

        of Debugfs files based on the user instructions.

2-> We are maintaining a common linkedlist inside the driver and it can 
be viewed by the user through the "config_read" debugfs file. Will be 
adding this to the

        documentation as well.

Let me know your thoughts regarding the above.

>> +Date:          March 2022
>> +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This stores the addresses of the registers which
>> +		needs to be read in case of a hardware crash or
>> +		manual software triggers. The address entered here
>> +		are considered under read type instruction.
>> +		Example:
>> +		echo <1> <2> <3> >/sys/kernel/debug/dcc/../config_read
>> +		1->Address to be considered for reading the value.
>> +		2->The word count of the addresses, read n words
>> +		   starting from address <1>.
>> +		3->Can be a 1 or 0 which indicates if it is apb or ahb
>> +		bus respectively.
>> +
>> +What:          /sys/kernel/debug/dcc/.../config_write
>> +Date:          March 2022
>> +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This file allows user to write a value to the register
>> +		address given as argument. The reason for this feature
>> +		of dcc is that for accessing certain registers it is
>> +		necessary to set some bits of some other register.
>> +		Example:
>> +		echo <1> <2> <3> > /sys/bus/platform/devices/.../config_write
>> +		1->Address to be considered for writing the value.
>> +		2->The value that needs to be written at the location.
>> +		3->Can be a 1 or 0 which indicates if it is apb or ahb
>> +		bus respectively.
>> +
>> +What:          /sys/kernel/debug/dcc/.../config_reset
>> +Date:          March 2022
>> +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This file is used to reset the configuration of
>> +		a dcc driver to the default configuration. This
>> +		means that all the previous addresses stored in
>> +		the driver gets removed and user needs to enter
>> +		the address values from the start.
>> +		Example:
>> +		echo  1 > /sys/bus/platform/devices/.../config_reset
>> +
>> +What:          /sys/kernel/debug/dcc/.../config_loop
>> +Date:		March 2022
>> +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This file is used to enter the loop type addresses for
>> +		dcc. DCC hardware provides feature to loop among multiple
>> +		addresses. For debugging purposes register values need to
>> +		be captured repeatedly in a loop. On giving the loop count
>> +		as n, the value at address will be captured n times in a
>> +		loop. At most 8 loop addresses can be configured at once.
>> +		Example:
>> +		echo <1> <2> <3> > /sys/kernel/debug/dcc/../config_loop
>> +		1->The loop count, the number of times the value of the
>> +		   addresses will be captured.
>> +		2->The address count, total number of addresses to be
>> +		   entered in this instruction.
>> +		3->The series of addresses to be entered separated by a
>> +		   space like <addr1> <addr2>... and so on.
>> +
>> +What:          /sys/kernel/debug/dcc/.../config_read_write
>> +Date:          March 2022
>> +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This file is used to read the value of the register
>> +		and then write the value given as an argument to the
>> +		register address. The address argument should be given
>> +		of the form <addr> <mask> <value>.For debugging purposes
>> +		sometimes we need to first read from a register and then
>> +		set some values to the register.
>> +		Example:
>> +		echo <1> <2> <3> > /sys/kernel/debug/dcc/.../config_read_write
>> +		1->The address which needs to be considered for read then write.
>> +		2->The value that needs to be written on the address.
>> +		3->The mask of the value to be written.
>> +
>> +What:		/sys/kernel/debug/dcc/.../ready
>> +Date:		March 2022
>> +Contact	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This file is used to check the status of the dcc
>> +		hardware if it's ready to take the inputs. A 0
>> +		here indicates dcc is in a ready condition.
>> +		Example:
>> +		cat /sys/kernel/debug/dcc/.../ready
>> +
>> +What:		/sys/kernel/debug/dcc/.../curr_list
> I still don't like the idea of having a single set of files to interface
> with all N lists. I think you should discover how many lists you have
> and create N directories of files, each on operating on a given list.

As explained before there cannot be different files based on lists as 
the number of lists to be used

varies across platforms where DCC is used. Also we are giving the user 
the flexibility to configure

multiple lists at one go whereas the dumps are collected in the form of 
separate lists that are

configured by the user.

>
>> +Date:		March 2022
>> +Contact:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This attribute is used to enter the linklist to be
>> +		used while appending addresses. The range of values
>> +		for this is advertised either by a register or is
>> +		predefined. Max value for this can be till 8.
>> +		Example:
>> +		echo 0 > /sys/kernel/debug/dcc/...curr_list
>> +
> Regards,
> Bjorn
