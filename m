Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF88850ECC0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbiDYXpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiDYXpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:45:50 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1AAC8490
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:42:43 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i3-20020a056830010300b00605468119c3so11903980otp.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=K4FutLiPYIeP/HOxIs4qYHrWa4LrVjZXyTDuVMwAdkE=;
        b=ZilM88c+fnY6fhL+dsclBFXXrJZ2HAsNMGm+Np/+Mt+Oc9B8TPZAw7q2viTTA6ak7B
         yoPgBTRydMcwU9nqmb2RwnJ6/9Ab+iVUtgpDZMQnsf8c60ouFHjhpnnlMa5L2jaUEi7S
         mNECsZCv8EsiAIE7sqJFlw+mv3p73HVE1KFXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=K4FutLiPYIeP/HOxIs4qYHrWa4LrVjZXyTDuVMwAdkE=;
        b=Aggyz8ZKUXrOvAhk9bG8Ng9/FFAMP1HqP6mZHp/UPWuK4Ia1xd0lAmblEeQ8GO9h5f
         zAkkCckGo+y10PKAWtVf3P8AAs5YvCyMeoMHeBCCDnZ80kgqRJSJfqxNdaqCvUps03Wm
         d8vT2axQRSBs3aL0PFKQMwDdpSqt8eD/PfAr5sQDPO1129sff1RF12Un6riGt/Tmtv57
         UW9A801j+aWemBuRDrljosstl/A8BRfleDSjzB2NmulqrXg0P8/yg7ykVOvx9tOaXM3W
         FxACnjPtARlIqxObytU6wGRHaEJqHsr50eGzxbESuFAtSwBu/oIam/0iFEuvzfQz3EXs
         FkPA==
X-Gm-Message-State: AOAM532wA/ooFLsDkNCn/ev6t1Jj25tvdJ0B1RJWYTdlutcl3JEKTtBx
        rpl6U86zlFxHXLZ0i8XNXvaS4eHnps1CUiuIWkT4jg==
X-Google-Smtp-Source: ABdhPJzjMENQDYBD08IVFVW0/QWyMQfeTI6EyQhCyi/4NXFypeigA/5BTebt0pYawZnga1Nb8BVc8Zivs55QAsnebDU=
X-Received: by 2002:a9d:b85:0:b0:5cb:3eeb:d188 with SMTP id
 5-20020a9d0b85000000b005cb3eebd188mr7434111oth.77.1650930163239; Mon, 25 Apr
 2022 16:42:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Apr 2022 16:42:42 -0700
MIME-Version: 1.0
In-Reply-To: <1650924663-24892-3-git-send-email-quic_khsieh@quicinc.com>
References: <1650924663-24892-1-git-send-email-quic_khsieh@quicinc.com> <1650924663-24892-3-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 25 Apr 2022 16:42:42 -0700
Message-ID: <CAE-0n5356Mf8AyW4ytNjuz95P5+T0fAD+EZ9p3Zkqp7hgpsYKw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/msm/dp: do not stop transmitting phy test
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-04-25 15:11:03)
> At normal operation, transmit phy test pattern has to be terminated before
> DP controller switch to video ready state. However during phy compliance
> testing, transmit phy test pattern should not be terminated until end of
> compliance test which usually indicated by unplugged interrupt.

And what does the patch do to fix it? We need more details in the commit
text. I think it should continue with:

Only stop sending the train pattern in dp_ctrl_on_stream() if we're not
doing compliance testing. We also no longer reset 'p_level' and
'v_level' because XYZ and it's OK/better to retrain the link after
enabling the stream clks because XYZ.

>
> Fixes: 64e190e720a7 ("drm/msm/dp: DisplayPort PHY compliance tests fixup")

Should be

Fixes: 6625e2637d93 ("drm/msm/dp: DisplayPort PHY compliance tests fixup")

> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 193cc1a..f99e173 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1699,8 +1699,6 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
>                 ctrl->link->link_params.rate,
>                 ctrl->link->link_params.num_lanes, ctrl->dp_ctrl.pixel_rate);
>
> -       ctrl->link->phy_params.p_level = 0;
> -       ctrl->link->phy_params.v_level = 0;

Why is this removed? Can you mention in the commit text why we don't
need to zero it out anymore?

>
>         rc = dp_ctrl_enable_mainlink_clocks(ctrl);
>         if (rc)
> @@ -1822,12 +1820,6 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
>                 }
>         }
>
> -       if (!dp_ctrl_channel_eq_ok(ctrl))
> -               dp_ctrl_link_retrain(ctrl);
> -
> -       /* stop txing train pattern to end link training */
> -       dp_ctrl_clear_training_pattern(ctrl);
> -
>         ret = dp_ctrl_enable_stream_clocks(ctrl);
>         if (ret) {
>                 DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
> @@ -1839,6 +1831,13 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
>                 return 0;
>         }
>
> +       if (!dp_ctrl_channel_eq_ok(ctrl)) {
> +               dp_ctrl_link_retrain(ctrl);
> +       }

Braces not needed. Please remove.

> +
> +       /* stop txing train pattern to end link training */
> +       dp_ctrl_clear_training_pattern(ctrl);
> +
