Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91D24A91F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244259AbiBDBVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:21:34 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:40583 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiBDBVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643937693; x=1675473693;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NjOxcV6FjcA6sssPspvL3F/DJ1XcRqKZt9Sxgb5UYUU=;
  b=mf6cLVmv1xOTdBtczwUxIalvmyJXFg0CHfwusjXhWrG1AIdzAAHMWTf9
   unWY2Xjjc1uEjNd5R8DoiXlC4dfwa3ZJdizE8DAieZMqMbFQz5TQ55WQ5
   vGtC4sgBcfLMSk8Qr8y5Dy0cYcSDASjQBi4sutbMPU8ApCX6P1ZWszDir
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 03 Feb 2022 17:21:33 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 17:21:33 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 17:21:32 -0800
Received: from [10.110.74.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 3 Feb 2022
 17:21:32 -0800
Message-ID: <92a2ce30-5bdf-d6a0-cb97-f375411eab16@quicinc.com>
Date:   Thu, 3 Feb 2022 17:21:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/4] input: misc: pm8941-pwrkey: add software key press
 debouncing support
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <skakit@codeaurora.org>
References: <20220203010804.20883-2-quic_amelende@quicinc.com>
 <20220203010804.20883-4-quic_amelende@quicinc.com>
 <CAE-0n51WVcbvgRrbi84JWDYAciXrz0LyHHym2VLXhiz_hoX7sg@mail.gmail.com>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <CAE-0n51WVcbvgRrbi84JWDYAciXrz0LyHHym2VLXhiz_hoX7sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2022 1:20 PM, Stephen Boyd wrote:
> Quoting Anjelique Melendez (2022-02-02 17:08:07)
>> From: David Collins <collinsd@codeaurora.org>
>>
>> On certain PMICs, an unexpected assertion of KPDPWR_DEB (the
>> positive logic hardware debounced power key signal) may be seen
>> during the falling edge of KPDPWR_N (i.e. a power key press) when
>> it occurs close to the rising edge of SLEEP_CLK.  This then
>> triggers a spurious KPDPWR interrupt.
>>
>> Handle this issue by adding software debouncing support to ignore
>> key events that occur within the hardware debounce delay after the
>> most recent key release event.
>>
>> Signed-off-by: David Collins <collinsd@codeaurora.org>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
> 
> Is there a Fixes tag that should be here? Is it a new problem with newer
> PMICs?

There is no Fixes tag since this is a workaround for a HW bug. Yes, this is a relatively new problem
with the past few PMICs. Starting with PM8450, we need this workaround in pm8941-pwrkey
since we are no longer using an older downstream driver that had an equivalent work around.
