Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E654A9445
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 08:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348274AbiBDHEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 02:04:16 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:43954 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347683AbiBDHEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643958253; x=1675494253;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SXVd4S8bE3teYbIWM81qv90z0xH1B1evYSMVHt82/K0=;
  b=OMGsRCrEUS6b4rzewT/cr4xeZnPV7EXcx1EiKAIcTEomf/6yIoLTroxB
   uXe5H4tBOQ4+LV5XaVPVWT+9gBLE2JenPyjKHIgnK2mx4p3a4N+guGBt+
   8TFZFgbOJiCE53NDLzfdecPHkrcdFI/LSS99YljQZcbzpRMMQiDF6tKmX
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Feb 2022 23:04:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 23:04:13 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 23:04:12 -0800
Received: from [10.50.21.95] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 3 Feb 2022
 23:04:07 -0800
Message-ID: <c9c1bcb8-74d6-9049-f4ab-e3fdb8a0ae5e@quicinc.com>
Date:   Fri, 4 Feb 2022 12:33:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V5 3/6] usb: common: eud: Add driver support for Embedded
 USB Debugger(EUD)
Content-Language: en-CA
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>
References: <cover.1643880577.git.quic_schowdhu@quicinc.com>
 <8dab5fd0df59e057793ac0f2264be31f561b07c3.1643880577.git.quic_schowdhu@quicinc.com>
 <Yfu5Aq7U6ZT1KzcJ@kroah.com>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <Yfu5Aq7U6ZT1KzcJ@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/3/2022 4:44 PM, Greg KH wrote:
> On Thu, Feb 03, 2022 at 04:04:32PM +0530, Souradeep Chowdhury wrote:
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
>>   drivers/usb/common/Kconfig                 |  10 ++
>>   drivers/usb/common/Makefile                |   1 +
>>   drivers/usb/common/qcom_eud.c              | 251 +++++++++++++++++++++++++++++
> This really should be drivers/usb/misc/ right?  No other code uses
> anything from this driver which is what "common" is for.
Ack
>
> thanks,
>
> greg k-h
