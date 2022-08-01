Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32085871C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiHATvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiHATvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:51:46 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEF164F4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:51:45 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r186so10573752pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 12:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=dR+H5DgsvjR0QyoFiNRqr/JAWUNMcgGPEXzXe3YKbRY=;
        b=frSpdh45TuWu76mH63xtZhu7CKbri0Km2IeQIRrVyVdYGmmS/ux+7aZbiKWjZ47O34
         PxW8ihbAKVey3f0r4za/SoQUooQWS+nlNhMISmQ4jgGb0J8cBki8IMHXX5gMosVXLTos
         6aRJht3EYpupBGHYLNa/Aw15GxcIKbSI+zcy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=dR+H5DgsvjR0QyoFiNRqr/JAWUNMcgGPEXzXe3YKbRY=;
        b=uvDCv2kk5uT4o+43lyqL9ddAXL/1dFmJGmoWcarLlxtZJLv2McuZHKaUWvV6hWzUYw
         SQEkHMle7xyEYrzrOPn+Yh2lnJxhY6AlFWv4HbT1jvQmj0EiwYIEf7VX1zWoVBT8CRLZ
         7aRoJSBM4nvpd5pLJmT2OBW3OyMRbx2bQcwsniSp6syIOZN6JR12hNS0tD9JqGvx5SLv
         Je/GtMoRFD8/CXw+sjZ1Lak9XbvR4RsrDD7w5B/dUjwIl5SSUcpSjSbvfsCPjKe3fB5r
         jXvVH8woKpX6vy6/L9aOyDPlqJyNhDo3XlvBPaBw/6MuyEzXzb78vk/JCQikEynZKtJr
         /bEQ==
X-Gm-Message-State: ACgBeo0omsgusFNo6HHPNitxk+BIhkq0kmQl+xfxbelVe8OOgHIq1/Zj
        1KajQP3fVdycTVU5rPtqIXXCBdtsCA/yCHlwPD3LKQ==
X-Google-Smtp-Source: AA6agR7eEiNpUei/D65W3dNWbRG0jraq9q/sZnjn4XfAwaG4cKYsywGUC3qy52/E5Sr9ysCurayirlNiUC5RNtqh5MA=
X-Received: by 2002:a05:6a00:2341:b0:52c:e2eb:cc70 with SMTP id
 j1-20020a056a00234100b0052ce2ebcc70mr14917077pfj.32.1659383504589; Mon, 01
 Aug 2022 12:51:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Aug 2022 12:51:43 -0700
MIME-Version: 1.0
In-Reply-To: <1659382970-17477-1-git-send-email-quic_khsieh@quicinc.com>
References: <1659382970-17477-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 1 Aug 2022 12:51:43 -0700
Message-ID: <CAE-0n52=zJ0ScrknAhsvJQc5hXP7+TGaoa4gnaVzsT26bQL_Uw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: delete DP_RECOVERED_CLOCK_OUT_EN to fix tps4
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-08-01 12:42:50)
> Data Symbols scrambled is required for tps4 at link training 2.
> Therefore SCRAMBLING_DISABLE bit should not be set for tps4 to
> work.
> RECOVERED_CLOCK_OUT_EN is for enable simple EYE test for jitter
> measurement with minimal equipment for embedded applications purpose
> and is not required to be set during normal operation.
> Current implementation always have RECOVERED_CLOCK_OUT_EN bit set
> which cause SCRAMBLING_DISABLE bit wrongly set at tps4 which prevent
> tps4 from working.
> This patch delete setting RECOVERED_CLOCK_OUT_EN to fix SCRAMBLING_DISABLE
> be wrongly set at tps4.
>
> Fixes: 956653250b21 ("drm/msm/dp: add support of tps4 (training pattern 4) for HBR3")
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index ab6aa13..013ca02 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1214,7 +1214,7 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
>         if (ret)
>                 return ret;
>
> -       dp_ctrl_train_pattern_set(ctrl, pattern | DP_RECOVERED_CLOCK_OUT_EN);
> +       dp_ctrl_train_pattern_set(ctrl, pattern);

This line is from the first patch introducing this driver. Even if this
is fixing tps4 support, it sounds like the bit should never have been
enabled in the first place. Why isn't the fixes tag targeted at the
first commit? Does it hurt to apply it without commit 956653250b21?
