Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0920501E05
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243797AbiDNWJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346949AbiDNWJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:09:00 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3422ADD76;
        Thu, 14 Apr 2022 15:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649973992; x=1681509992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xVp5TAphqYTgZpbaJdav7ZSflN0pUeu1cQ9O+2F3xb8=;
  b=ObhgheizD7sxrohog/qMBJIQtApS5bhqgEqmYf8quzWWGYpTO3ae8Vbw
   xy/1mJ3Uk0jHz+ipXxe+ZVx1SGzd910ex6n+9HfvhAV3qoC5QZgktQF0A
   8CpE+SWBDjHsaYYCvtIhyLfbmKqIU/bgntLmcv5oi6lbEe1tSuTw2xIe8
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 14 Apr 2022 15:06:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 15:06:31 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 15:06:30 -0700
Received: from [10.110.19.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Apr
 2022 15:06:29 -0700
Message-ID: <2039ef97-4fdb-bffe-1e02-18ae79c18be4@quicinc.com>
Date:   Thu, 14 Apr 2022 15:06:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/msm/dp: enhance both connect and disconnect
 pending_timeout handle
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1649280493-4393-1-git-send-email-quic_khsieh@quicinc.com>
 <625ce8a0-4e25-5513-5599-c1cdebf5a3a5@linaro.org>
 <09fd563f-4a2c-f670-51c2-0e5ff023816d@quicinc.com>
 <CAA8EJpqzucFGf8ndDi2LZqtKiOt_w=_h1oPAUNVCdmUyh_3+zA@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAA8EJpqzucFGf8ndDi2LZqtKiOt_w=_h1oPAUNVCdmUyh_3+zA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/8/2022 4:59 PM, Dmitry Baryshkov wrote:
> On Fri, 8 Apr 2022 at 23:30, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>>
>> On 4/8/2022 5:27 AM, Dmitry Baryshkov wrote:
>>> On 07/04/2022 00:28, Kuogee Hsieh wrote:
>>>> dp_hpd_plug_handle() is responsible for setting up main link and send
>>>> uevent to notify user space framework to start video stream. Similarly,
>>>> dp_hdp_unplug_handle is responsible to send uevent to notify user space
>>>> framework to stop video stream and then tear down main link.
>>>> However there are rare cases, such as in the middle of system
>>>> suspending,
>>>> that uevent could not be delivered to user space framework. Therefore
>>>> some kind of recover mechanism armed by timer need to be in place in the
>>>> case of user space framework does not respond to uevent.
>>> Hmm, how does userpsace 'respond' to the uevent? The driver should
>>> send hotplug notifications to userspace, but it must not expect any
>>> particular reaction. The userspace might be as simple, as fbdev
>>> emulation, but the driver still should function correctly.
>> yes, driver is function correctly by setting up main link. but it does
>> not know which resolution to display.
>>
>> It send hotplug notification through uevent to framework after main link
>> is ready.
>>
>> Framework  is responsible to set up MDP timing engine to start video stream.
>>
>>
>> However it does not know which
> It's of no concern to the driver. It is completely the userspace
> problem. After resuming, it should reread available video output
> properties. The display could have been changed while the system is
> suspended.
>  From your description I still do not understand why you need the
> 'recovery' mechanism.

I mean "recovery" means  dp driver may leave stay at link ready 
mistakenly after dongle unplugged due to missing framework action to 
tear down main link so that next dongle plug in will not work.

Currently it was armed with timeout function and it will fired if 
framework did not call msm_dp_display_disable() after 5 second.

Anyway, we think this approach is not good. therefore it is replaced 
with  below patch.

drm/msm/dp: tear down main link at unplug handle immediately


