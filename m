Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34733462E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbhK3I3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:29:34 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:60948 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbhK3I3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638260773; x=1669796773;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zVu0VIYeabGf14oTWYiiIgBzl9m/qchapwvQbqjatQE=;
  b=qzPLnmMMo8s9BeggODC3mcPnJxM6P0dye0xD4HcUiFff3l4kTdZk3oo8
   2GMmhoB9Umuv97p4mOlnDxQxgE8ArVyEb5uobZ+U2VYbpr+5rk0L5b5jc
   iLLDMC5UWz5pFNGmAteDiTepYqpAAyTrwgSjpcFVR4b3XzFvFpbkliAq+
   M=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 30 Nov 2021 00:26:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 00:26:11 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 00:26:11 -0800
Received: from [10.216.48.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 30 Nov
 2021 00:26:07 -0800
Message-ID: <519ac97a-6bff-ee93-58c6-63559c3a6cb6@quicinc.com>
Date:   Tue, 30 Nov 2021 13:56:02 +0530
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
From:   Maulik Shah <quic_mkshah@quicinc.com>
In-Reply-To: <20211129134459.GC10105@dragon>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/29/2021 7:15 PM, Shawn Guo wrote:
>> This is not limited to suspend, you will need to notify RPM during deepest
>> cpu idle state entry as well, since MPM may be monitoring interrupts in that
>> case too.
> Yeah, I was trying to test this MPM driver with cpuidle, but failed to
> see the SoC get into vlow/vmin state from cpuidle.

In a few cases SoC can enter vmin/vlow from cpuidle one is from static 
screen on.

> Do you have any
> suggestion how I should test it properly?
Suspend resume (use "s2idle" and not "deep" mode on upstream kernel) is 
one good method, but you will have to make sure all drivers have removed 
votes on xo clock when entering suspend.
Also need to make sure other subsystem like modem is in power collaspe 
(look at the internal master stats driver to know if other subsystems 
entering to low power mode or not).

Thanks,
Maulik
