Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A31576B95
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 06:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiGPENl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 00:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiGPENi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 00:13:38 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3F23719A;
        Fri, 15 Jul 2022 21:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657944815; x=1689480815;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9SlA60LqRPWaHVi9Kb6IIB6MVQAG5blEyQBdXFBEvj0=;
  b=Mx8O7o4jZd/+INjsVkfxvRSZ/k/bO0uHvGlvLujFfJErpPIuUHbj/XEV
   9eaeRvYyAFCcORxXynQCnkU5i4OkLUYNp/YcuYvx5oxr2y/7QT6nqTQN5
   B3fgIW7QLqpeHMbgkJRaJSTnvcksQ1PUaJq4+hFu1ecEj262Yp1e/tl0L
   Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Jul 2022 21:13:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 21:13:34 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Jul 2022 21:13:34 -0700
Received: from [10.216.24.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 15 Jul
 2022 21:13:30 -0700
Message-ID: <0093ce1a-51fd-0f02-27dd-9067d7c67569@quicinc.com>
Date:   Sat, 16 Jul 2022 09:43:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] usb: dwc3: qcom: Defer dwc3-qcom probe if dwc3 isn't
 probed properly
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
References: <1657891312-21748-1-git-send-email-quic_kriskura@quicinc.com>
 <YtHRFcol5uslEel1@google.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <YtHRFcol5uslEel1@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/16/2022 2:11 AM, Matthias Kaehlcke wrote:
> On Fri, Jul 15, 2022 at 06:51:52PM +0530, Krishna Kurapati wrote:
>
>> Subject: usb: dwc3: qcom: Defer dwc3-qcom probe if dwc3 isn't probed properly
> nit: "isn't probed properly" sounds like a bug or HW issue. In case
> you re-spin maybe change it to "hasn't probed yet" or similar.
>
>> On SC7180 devices, it is observed that dwc3 probing is deferred
>> because device_links_check_suppliers() finds that '88e3000.phy'
>> isn't ready yet.
>>
>> As a part of its probe call, dwc3-qcom driver checks if dwc3 core
>> is wakeup capable or not. If the dwc3 core is wakeup capable, driver
>> configures dwc-qcom's power domain to be always ON. Also it configures
>> dp/dm interrupts accordingly to support wakeup from system suspend.
>>
>> More info regarding the same can be found at:
>> commit d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller status")
>> commit 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
>>
>> In the event, dwc3 probe gets deferred and is processed after dwc3-qcom
>> probe, driver ends up reading the wakeup capability of dwc3 core as false
>> leading to instability in suspend/resume path.
>>
>> To avoid this scenario, ensure dwc3_probe is successful by checking
>> if appropriate driver is assigned to it or not after the of_platform_populate
>> call. If it isn't then defer dwc3-qcom probe as well.
>>
>> Fixes: 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system suspend")
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reported-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>
> Please make sure to add reviewers of previous versions or other folks you
> would like to review your patches in cc. I found v2 accidentally while
> looking for something else.
Hi Mathias,
     Sure, Thanks for the review.
