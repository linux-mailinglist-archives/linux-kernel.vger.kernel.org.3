Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93736462F39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbhK3JH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:07:56 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:12475 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbhK3JHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638263077; x=1669799077;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gvaOcKUQSIay1v6BMMG/EuN5leviREwFkT32VtwvM38=;
  b=EfkxbGrdoUh5c2jwCViLLksosRSeZThGS01dnSUDkhyfamolZgMkQdDP
   j9xcJU83kQXFMc4ZBjNR7tCY4rvVXvAznQqcn4sE4Z8PGOlwSeb9mes/l
   RG+gdeZZqSstDaLyy6qAN3ffLHmuu0uV/R6iIdNfA66O3IYZb2nkHYAY7
   A=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 30 Nov 2021 01:04:36 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 01:04:36 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 01:04:35 -0800
Received: from [10.216.48.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 30 Nov
 2021 01:04:31 -0800
Message-ID: <e7a70e7d-c9b6-c10d-23c8-dd5ca74cc4dd@quicinc.com>
Date:   Tue, 30 Nov 2021 14:34:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 2/2] irqchip: Add Qualcomm MPM controller driver
To:     Shawn Guo <shawn.guo@linaro.org>
CC:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211126093529.31661-1-shawn.guo@linaro.org>
 <20211126093529.31661-3-shawn.guo@linaro.org>
 <56a5820e-9cd7-aa49-7ce8-9547f355986e@quicinc.com>
 <20211129134459.GC10105@dragon>
 <519ac97a-6bff-ee93-58c6-63559c3a6cb6@quicinc.com>
 <20211130084445.GG10105@dragon>
From:   Maulik Shah <quic_mkshah@quicinc.com>
In-Reply-To: <20211130084445.GG10105@dragon>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/30/2021 2:14 PM, Shawn Guo wrote:
> On Tue, Nov 30, 2021 at 01:56:02PM +0530, Maulik Shah wrote:
>> Hi,
>>
>> On 11/29/2021 7:15 PM, Shawn Guo wrote:
>>>> This is not limited to suspend, you will need to notify RPM during deepest
>>>> cpu idle state entry as well, since MPM may be monitoring interrupts in that
>>>> case too.
>>> Yeah, I was trying to test this MPM driver with cpuidle, but failed to
>>> see the SoC get into vlow/vmin state from cpuidle.
>> In a few cases SoC can enter vmin/vlow from cpuidle one is from static
>> screen on.
>>
>>> Do you have any
>>> suggestion how I should test it properly?
>> Suspend resume (use "s2idle" and not "deep" mode on upstream kernel) is one
>> good method, but you will have to make sure all drivers have removed votes
>> on xo clock when entering suspend.
>> Also need to make sure other subsystem like modem is in power collaspe (look
>> at the internal master stats driver to know if other subsystems entering to
>> low power mode or not).
> I have already been able to trigger a vmin sleep with s2idle by doing:
>
>   $ echo mem > /sys/power/state
>
> My question is how I can get a vmin sleep in idle case, so that MPM
> driver can be tested in both suspend and idle context.
>
> Shawn

In a few cases SoC can enter vmin/vlow from cpuidle one is from static screen on.
you can turn on display and set display off timeout to maximum (30 minutes) in android phone and then just leave the device idle for few minutes

another possible way (if display is not present) is to take some wake_lock (write something to /sys/power/wake_lock) and disconnect USB and leave the device idle for few minutes.
since taking wake_lock device will not enter suspend, cpuidle can make SoC enter deepest mode like vmin (if all other conditions like other subsystem sleeping and votes on xo clock removed, etc met).

Thanks,
Maulik

