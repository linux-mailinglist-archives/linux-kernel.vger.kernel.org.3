Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D3049E1E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbiA0MEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:04:40 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:34607 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229801AbiA0MEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643285078; x=1674821078;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cbLtG9S0apSKXDgLsmDQqYOu7OF8s8mlw8/V1naHBm4=;
  b=AN1ondylSgQNGS6KumAbTv+WD3ARiw5CI1qMy9JfVvxcxncTjzsxreZC
   U4CPJtuyCaBQj16ZbSYQwSEV62rRXhG+ussL7IrrJZF89phN34Aw+LBH0
   9WCwC6ECcxu8liDwfiLksXuFFKSxpuI0BmyJWAYEO/vsEyRLhX9yNK+XR
   c=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jan 2022 04:04:38 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 04:04:36 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 04:04:34 -0800
Received: from [10.50.37.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 27 Jan
 2022 04:04:27 -0800
Message-ID: <f4804aba-0863-08f4-9362-7f0cc681285d@quicinc.com>
Date:   Thu, 27 Jan 2022 17:34:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 3/6] soc: qcom: eud: Add driver support for Embedded
 USB Debugger(EUD)
Content-Language: en-CA
To:     Greg KH <greg@kroah.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>
References: <cover.1642768837.git.quic_schowdhu@quicinc.com>
 <7ccee5ae484e6917f5838c8abde368680ec63d05.1642768837.git.quic_schowdhu@quicinc.com>
 <YfEUmuglZluWwsg2@kroah.com>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <YfEUmuglZluWwsg2@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/26/2022 3:00 PM, Greg KH wrote:
> On Fri, Jan 21, 2022 at 07:23:48PM +0530, Souradeep Chowdhury wrote:
>> Add support for control peripheral of EUD (Embedded USB Debugger) to
>> listen to events such as USB attach/detach, pet EUD to indicate software
>> is functional.Reusing the platform device kobj, sysfs entry 'enable' is
>> created to enable or disable EUD.
>>
>> To enable the eud the following needs to be done
>> echo 1 > /sys/bus/platform/.../enable
>>
>> To disable eud, following is the command
>> echo 0 > /sys/bus/platform/.../enable
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   Documentation/ABI/testing/sysfs-driver-eud |   9 ++
>>   drivers/soc/qcom/Kconfig                   |  10 ++
>>   drivers/soc/qcom/Makefile                  |   1 +
>>   drivers/soc/qcom/qcom_eud.c                | 250 +++++++++++++++++++++++++++++
> This should go under drivers/usb/ as it's creating a USB generic
> user/kernel api that all future devices of this type must follow.
Ack. Will move this to drivers/usb.
>
> thanks,
>
> greg k-h
