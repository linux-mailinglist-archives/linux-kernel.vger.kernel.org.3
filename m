Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8563A462EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbhK3I5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:57:51 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:36429 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239866AbhK3I5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638262471; x=1669798471;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b6zv9kZJc11gN8pWj7yPsaq2KZS1Lo+SslBFVfJXTa8=;
  b=BXWB+/77d4n4Nsm5pzs7FAW8LuvJzc2pQ/laXcEV2NG2SP1S0Xjy6cxn
   NByCt+sICHeJUxcmrJ/YG7PHBcPyk3AVrI/3FuzNQI7d/c0u5v3A5Sm8L
   +Vhfy43Mb+JZRoyt5EeO9GUIegLO1elHRKg0XzCbVm5a8Vqaj7T69NPI8
   4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Nov 2021 00:54:30 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 00:54:30 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 00:54:30 -0800
Received: from [10.216.48.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 30 Nov
 2021 00:54:26 -0800
Message-ID: <e0bb6bbf-60a2-aaeb-1a3d-c174c030f8c7@quicinc.com>
Date:   Tue, 30 Nov 2021 14:24:21 +0530
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
 <20211126093529.31661-3-shawn.guo@linaro.org> <87czmmbu8k.wl-maz@kernel.org>
 <20211129133308.GB10105@dragon> <87pmqjm1c8.wl-maz@kernel.org>
 <20211130023151.GD10105@dragon>
 <2e821841-a921-3fda-9ee6-3d5127653033@quicinc.com>
 <20211130083143.GF10105@dragon>
From:   Maulik Shah <quic_mkshah@quicinc.com>
In-Reply-To: <20211130083143.GF10105@dragon>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/30/2021 2:01 PM, Shawn Guo wrote:
>>     This can be converted to read poll_timeout(). This was introduced in
>>     place of wmb() to make sure writes are completed.
> Hmm, in this case, writel() will just do the right thing, as it wraps
> wmb() there.  Or am I missing something?
>
> Shawn
#define writel(v,c)             ({ __iowmb(); writel_relaxed((v),(c)); })

writel() does not do wmb() after writel_relaxed(), it does before.

we need to make sure write is propagated, so wmb() or read  back with 
timeout need to be kept after writel() is done.

Thanks,
Maulik

