Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F306756BE04
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbiGHQBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiGHQA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:00:58 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347C874DDE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657296057; x=1688832057;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qeVM7SLbPnJ5NrmCgidT7re+bw94f7vWzQ6gi7bdXdY=;
  b=SnHOGOw7+WVHH7g0rnfW4UDJuQYXFtO7L4XROlrzTZjOhRMcYjusObdY
   ytdiOXaGgniKCLmoSeyWJDzhzjvI9ZHZU7cLIR8w0rFpznYMfDm1no0rl
   EO0XVQXd8P3Kxepqyu0i2YtgjDoI+n7TxMPu72OPzcpo2HG1ww151Ti8V
   w=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Jul 2022 09:00:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 09:00:56 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Jul 2022 09:00:55 -0700
Received: from [10.111.160.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 8 Jul 2022
 09:00:53 -0700
Message-ID: <60252405-81f2-2465-bc20-5f91a9072031@quicinc.com>
Date:   Fri, 8 Jul 2022 09:00:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dsi: Set panel orientation when directly
 connected
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20220706191442.1150634-1-swboyd@chromium.org>
 <CAD=FV=UrYCwm2ByN_5EN3fq-ayMJNjmWfJ5sooRy51ZiCoMcjA@mail.gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAD=FV=UrYCwm2ByN_5EN3fq-ayMJNjmWfJ5sooRy51ZiCoMcjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/2022 8:25 AM, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jul 6, 2022 at 12:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
>>
>> Set the panel orientation in drm when the panel is directly connected,
>> i.e. we're not using an external bridge. The external bridge case is
>> already handled by the panel bridge code, so we only update the path we
>> take when the panel is directly connected/internal. This silences a
>> warning splat coming from __drm_mode_object_add() on Wormdingler boards.
>>
>> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
>> Cc: Douglas Anderson <dianders@chromium.org>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>
>> This relies on commit 5e41b01a7808 ("drm/panel: Add an API to allow drm
>> to set orientation from panel") which is in drm-misc
>>
>>   drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 ++
>>   1 file changed, 2 insertions(+)
> 
> I don't personally have objections to this, but (to my understanding)
> "the future" is that everyone should use panel_bridge. If we made the
> move to panel_bridge today then we wouldn't need to do this. In
> general I think panel_bridge would end up letting us delete a bunch of
> code...
> 
> See commit 4e5763f03e10 ("drm/bridge: ti-sn65dsi86: Wrap panel with
> panel-bridge") for when this was done by ti-sn65dsi86.
> 
> Then again, I spent a small amount of time looking into this and it's
> definitely non-trivial. Still likely worthwhile, but not worth
> blocking a tiny fix like this. It also should be fairly obvious that
> we should delete this when we switch to panel_bridge.

Right, from what I saw on IRC, panel_bridge is the way forward and 
dmitry did push a change to do that

https://patchwork.freedesktop.org/patch/492585/

But I think we can go ahead with this change because its simple enough.

Regarding the panel_bridge migration, I am going to start reviewing that 
as well.

> 
> Thus:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> I'll assume that we'll just snooze this commit until drm-misc-next
> merges into a tree that msm-next is based on, which will probably be
> the next -rc1. If desired and Acked I could land this in
> drm-misc-next, but it's probably not worth it?
