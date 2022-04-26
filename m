Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE02510B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355380AbiDZVYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346507AbiDZVY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:24:29 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661EF14C3F0;
        Tue, 26 Apr 2022 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651008081; x=1682544081;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7l9C4gQ0vxbIfaHRcIWmjzTFC2VNgKKoipVIzF1dwfw=;
  b=ym5+oSf7ukNwkEhU2vXcNxDCPbS932hFMuHSU1wkfpuKJBVtd42L+hx/
   tVX8bKH4fXd5vIYKIcwKd+P+bUi9sZnfx8EHZQRogqHnORO+XqO07QAnf
   CSzKtcxKnRNm03U/SP3ZGkxflpUQrZSB/uOrXm1PUpSLvom6eg3BShIVV
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Apr 2022 14:21:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:21:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 14:21:20 -0700
Received: from [10.111.160.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Apr
 2022 14:21:18 -0700
Message-ID: <61d98a8a-1c0f-346a-1e66-2e647d2f3088@quicinc.com>
Date:   Tue, 26 Apr 2022 14:21:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PATCH] drm/edid: drm_add_modes_noedid() should set lowest
 resolution as preferred
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
CC:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>
References: <20220426132121.RFC.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
 <a21a6ad5-5ed3-6207-8af7-655d19197041@quicinc.com>
 <CAD=FV=XOWfz39imimoijNM14dUJNiwr8_aqPFCR=LmgH7yYzQQ@mail.gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAD=FV=XOWfz39imimoijNM14dUJNiwr8_aqPFCR=LmgH7yYzQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/2022 1:52 PM, Doug Anderson wrote:
> Hi,
> 
> On Tue, Apr 26, 2022 at 1:46 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>> On 4/26/2022 1:21 PM, Douglas Anderson wrote:
>>> If we're unable to read the EDID for a display because it's corrupt /
>>> bogus / invalid then we'll add a set of standard modes for the
>>> display. When userspace looks at these modes it doesn't really have a
>>> good concept for which mode to pick and it'll likely pick the highest
>>> resolution one by default. That's probably not ideal because the modes
>>> were purely guesses on the part of the Linux kernel.
>>>
>>> Let's instead set 640x480 as the "preferred" mode when we have no EDID.
>>>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>
>> drm_dmt_modes array is sorted but you are also relying on this check to
>> eliminate the non-60fps modes
>>
>> 5611            if (drm_mode_vrefresh(ptr) > 61)
>> 5612                    continue;
>>
>> I am not sure why we filter out the modes > 61 vrefresh.
>>
>> If that check will remain this is okay.
>>
>> If its not, its not reliable that the first mode will be 640x480@60
> 
> I suspect that the check will remain. I guess I could try to do
> something fancier if people want, but I'd be interested in _what_
> fancier thing I should do if so. Do we want the rule to remain that we
> always prefer 640x480, or do we want to prefer the lowest resolution?
> ...do we want to prefer 60 Hz or the lowest refresh rate? Do we do
> this only for DP (which explicitly calls out 640x480 @60Hz as the best
> failsafe) or for everything?
> 
> For now, the way it's coded up seems reasonable (to me). It's the
> lowest resolution _and_ it's 640x480 just because of the current
> values of the table. I suspect that extra lower resolution failsafe
> modes won't be added, but we can always change the rules here if/when
> they are.
> 
> -Doug

Alright, agreed. The way the API is today, I dont see anything getting 
broken with this.

So typically, as per spec, when a preferred mode is not set by the sink, 
the first entry becomes the preferred mode.

This also aligns with that expectation.

So FWIW,

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

We will test this one also out with our equipment, then give tested-by tags.

Thanks

Abhinav

