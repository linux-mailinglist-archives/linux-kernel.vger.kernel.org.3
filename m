Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B57491026
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbiAQSQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:16:28 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:27464 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229657AbiAQSQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642443387; x=1673979387;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TpYuMc5hSqWA0JqIB9lyXBpDOxH/KsfeWVy/QmBxyLk=;
  b=u26QxwcC3NN3ofaBsyQmeL7lsso718chgmlC4RZKGMlS9I28vBpuOo+p
   Rbfn6NRDtAZ+MWYTbeoO1RlrqMnE1mFJL1je01jgaCZLtgQZNqX+z3DDp
   fUalkHiuOZlnTC6Q8iaQ4Dy9HpDVCZI7AkLBfUaugyUVR9gV3hbR6R9Bu
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Jan 2022 10:16:27 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:16:26 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 17 Jan 2022 10:16:25 -0800
Received: from [10.110.8.118] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 17 Jan
 2022 10:16:24 -0800
Message-ID: <337655e4-db0c-e748-43bc-fd166c9f2577@quicinc.com>
Date:   Mon, 17 Jan 2022 10:16:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v17 1/4] drm/msm/dp: do not initialize phy until plugin
 interrupt received
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dmitry.baryshkov@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <aravindh@codeaurora.org>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1642208315-9136-1-git-send-email-quic_khsieh@quicinc.com>
 <1642208315-9136-2-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52KfpfnxsC5SKvR9zWWONmh2oyD3cS9L-8-J1RHHzKSdQ@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n52KfpfnxsC5SKvR9zWWONmh2oyD3cS9L-8-J1RHHzKSdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/14/2022 5:13 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-01-14 16:58:32)
>> @@ -1363,14 +1368,14 @@ static int dp_pm_suspend(struct device *dev)
>>                  if (dp_power_clk_status(dp->power, DP_CTRL_PM))
>>                          dp_ctrl_off_link_stream(dp->ctrl);
>>
>> +               dp_display_host_phy_exit(dp);
>> +
>> +               /* host_init will be called at pm_resume */
>>                  dp_display_host_deinit(dp);
>>          }
> I thought we determined that core_initialized was always true here, so
> the if condition is redundant. Furthermore, removing that check allows
> us to entirely remove the core_initialized variable from the code.

my mistake. Will remove the condition check.

However, I would like to keep code_initialized for debugging purpose.

Otherwise, we will shot in the dark if customer report bug.

