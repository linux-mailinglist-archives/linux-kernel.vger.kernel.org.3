Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208214BABF7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 22:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343613AbiBQVo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 16:44:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244859AbiBQVoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:44:24 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643C9E7AE6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:44:08 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id n6so10942985qvk.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6R8qn+rbL8OvPipxuVgINO0b1lTKNrdKLs//Tzx1/Vg=;
        b=OUIGVb3AgkfYqWJ/jpUcEbfG8cQNrWOf8W2dm9Aqt3J2zie173GvWoJ6AE1eFBXLC+
         BSrfwVz9fk/DeGoOPMaaLOco12vCxmYrdThUp0Oa9hS/3sFO6UnQIqVcOO4F2xKxh+PS
         KxCRQL7yuVFQ8uZvzWDrWsR0S/qmvs3ZYwPY2d2PLEzOwj61ELQhYX+B1P1CQWUgQ3AI
         ZxF2302qHhiCMNBL+mmWhLle2wsG0oQerm4BN3OG3PPiqrNpxvWA/AyXeef6nJeL8ksP
         FrqLcsYjKGcHLtKtfpcvyAxnuIyMEMepLLNdQ1yYlz2Ado2t2Fueu8AP/0v5WbaBpg5o
         +kWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6R8qn+rbL8OvPipxuVgINO0b1lTKNrdKLs//Tzx1/Vg=;
        b=EwV/4jrEphrjSXQbGImeIlbzo6NAtizJ/Y0J3rmHfdu+526YQUSxLwA84fNIWmrAAd
         NwCkLiDlD68oWULtme/WDt/uI6Yj39OC+T0ugDZYvbOIlzTQdn3yUU7viskobJiNJubj
         NP0tpCvLN+7baQTAsk5l3uj6wTAAxA3vapRrZfKKfVaQzCdApCmc4CAgKWMmeh5JLgFU
         eR8CInKyKQviMS8nR4WOPDeC+wBokIZ6b7/ZdV7nMZvmolJsOKdSpW+NrTMGBgsaNn1T
         /OgJj97YAGQPjjqVXG51OgxKWoOIYGPhTQxIbHgeiijm0+ExXF6tRbfnwo1JdDvCAFGt
         F/ug==
X-Gm-Message-State: AOAM531T9a1jOp7l1tYRoVhVwoBq7YzYqaDuDYy89Q3h2YzbuI3oaSVW
        SKULn2Oja038Dkv2Ccs8CxPc6aABUdJV34mmuXXa+g==
X-Google-Smtp-Source: ABdhPJy1qvJVD1rgLNeWV3GUhnlxwMyxzExFz2q3A1g24QsHgiswLGR3hNBpdmvyvE2dyuEWTwWn6PzdWBJHOiiKd4Y=
X-Received: by 2002:ac8:584c:0:b0:2dd:89dc:8000 with SMTP id
 h12-20020ac8584c000000b002dd89dc8000mr1907274qth.370.1645134247505; Thu, 17
 Feb 2022 13:44:07 -0800 (PST)
MIME-Version: 1.0
References: <1645133788-5057-1-git-send-email-quic_khsieh@quicinc.com> <1645133788-5057-2-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1645133788-5057-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 18 Feb 2022 00:43:56 +0300
Message-ID: <CAA8EJpqu2VsYkACe+FL+Z0J=j7Pp-w69_YNyBWn_7Ah1GoW23Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] drm/msm/dpu: adjust display_v_end for eDP and DP
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        bjorn.andersson@linaro.org, quic_abhinavk@quicinc.com,
        quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 at 00:36, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> The =E2=80=9CDP timing=E2=80=9D requires the active region to be defined =
in the
> bottom-right corner of the frame dimensions which is different
> with DSI. Therefore both display_h_end and display_v_end need
> to be adjusted accordingly. However current implementation has
> only display_h_end adjusted.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Fixes: fc3a69ec68d3 ("drm/msm/dpu: intf timing path for displayport")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_hw_intf.c
> index 116e2b5..284f561 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -148,6 +148,7 @@ static void dpu_hw_intf_setup_timing_engine(struct dp=
u_hw_intf *ctx,
>                 active_v_end =3D active_v_start + (p->yres * hsync_period=
) - 1;
>
>                 display_v_start +=3D p->hsync_pulse_width + p->h_back_por=
ch;
> +               display_v_end   -=3D p->h_front_porch;
>
>                 active_hctl =3D (active_h_end << 16) | active_h_start;
>                 display_hctl =3D active_hctl;
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum=
,
> a Linux Foundation Collaborative Project
>


--=20
With best wishes
Dmitry
