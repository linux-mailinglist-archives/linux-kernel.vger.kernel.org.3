Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF1D51049E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353212AbiDZQyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353414AbiDZQxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:53:07 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9D33EBAD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:48:18 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e93ff05b23so6856839fac.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/9+L1bD8GO2iPBuObOEB4z68+3Sfat/RrLBb6eqV/V0=;
        b=lBNxBWbqO16PHPt92QnCVAsCamewM9w4IaIYrjQ91P552kBF3MdXxI9WUasA3xmWci
         4obO3GuaBMZohB1TIXIpTSrJPacqX5UD2iuNGuhaywB3Qr5WRl7kZv+3u3eO42Ah80lQ
         agbut9Qlme7epMpw97SYKKYViOO4LplkQKPfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/9+L1bD8GO2iPBuObOEB4z68+3Sfat/RrLBb6eqV/V0=;
        b=Vc6BaSmWxwsbTey42d5aYORo0b7EYtXCUXBUIayj2vtn6q0iJn4ShdXoeKDDFzwueH
         dlcPkUhNgdBBpxqZ/KHKaWlEBzD3gkN8oegdu1aGHFtMx5sk6LMgY4Anw+z+TbskanB4
         P2rbwPUyQEWTAxUodFvkUcbb0wW6pLyd7/1x+wqhqcfhgPwwjVchlnswVAPk+ZNKvNIQ
         2MorP2VkAzTtjQjVgppGmD4bX1MaIJCsb1gQ6Z7wtGXM2x+nRt+y8FnrFLjkiITxn7DK
         Vbh6Cylql4V+m6gS3ms4moxrn4WNlcsNFO8Qrx6RcK8tPGu3RsvjBRWgpGDeuq3wDGqA
         TupA==
X-Gm-Message-State: AOAM531I9tv+igFQld7rxy+78ikHxGNQGjse2BuwEupILK/sa6dX/jwH
        AldqObgogFbSsVYEmZ7AcKZZBQ53U2vrtGFHLtq+1w==
X-Google-Smtp-Source: ABdhPJxKHFjbu3FrMhvJFwVaDlybrC6id9HpmZhkaJInJh5R8/wMLvQcBeQHVCW+y3mQUUlmP+wKOuJqFWvO6XBDj0U=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr9917250oao.63.1650991697400; Tue, 26
 Apr 2022 09:48:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 Apr 2022 09:48:16 -0700
MIME-Version: 1.0
In-Reply-To: <1650932213-19162-3-git-send-email-quic_khsieh@quicinc.com>
References: <1650932213-19162-1-git-send-email-quic_khsieh@quicinc.com> <1650932213-19162-3-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 26 Apr 2022 09:48:16 -0700
Message-ID: <CAE-0n53NJ68H4DD6uE5p2Dhmb9QxGOVXenhdG2=A2_T6Fp520g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/msm/dp: do not stop transmitting phy test
 pattern during DP phy compliance test
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-04-25 17:16:53)
> At normal operation, transmit phy test pattern has to be terminated before
> DP controller switch to video ready state. However during phy compliance
> testing, transmit phy test pattern should not be terminated until end of
> compliance test which usually indicated by unplugged interrupt.
>
> Only stop sending the train pattern in dp_ctrl_on_stream() if we're not
> doing compliance testing. We also no longer reset 'p_level' and
> 'v_level' within dp_ctrl_on_link() due to both 'p_level' and 'v_level'
> are acquired from link status at previous dpcd read and we like to use
> those level to start link training.
>
> Changes in v2:
> -- add more details commit text
> -- correct Fixes
>
> Fixes: 2e0adc765d88 ("drm/msm/dp: do not end dp link training until video is ready")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

One comment.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 193cc1a..f99e173 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1839,6 +1831,13 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
>                 return 0;
>         }
>
> +       if (!dp_ctrl_channel_eq_ok(ctrl)) {
> +               dp_ctrl_link_retrain(ctrl);
> +       }

Drop unnecessary braces.
