Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923DD4E794D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377014AbiCYQw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348043AbiCYQwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:52:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26829E43A3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:50:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bi12so16570924ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94PEXMIFvyyJQFPubb1Xaa+0LbyxHkePHlhp9zj/Z+g=;
        b=SjSMuLWWBMRDZCZAYqkZjt8DVD1lMxcnTQ0pRcoYE6pc5KA03fRjaO+NG5JnARI9G0
         FdIxBtqN2SuWVe3DEw0nVislGa6FeRILBe77MlmD72/jA9e8G3JD5rKHwo6BJ0bvdI0A
         HSMzQ+1ZTMcraGaMFyqLA5koHqo6CEQtOaaRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94PEXMIFvyyJQFPubb1Xaa+0LbyxHkePHlhp9zj/Z+g=;
        b=5g4oQGsl+gAH92zB2Mm/aUZHYCBCcQbOf47UOZWqzqGnTLuAYUs64eb0vWKee4vj55
         wMSRamwT8W0fpP+Hi6/pPNnZb3D0GJA1tUNH35TUD0HsOx9zdr5kwDZZVA2siB8Uoeii
         uiKvj8oXg93MaWmduT6F0jEXbwRV5XITOe8zGY6STqWDdeyfrRX3Y/CHrvj/J3qtA+GZ
         FTV6E+iKLPihUg2Nv/UCbdrbzZecv5k0url+Lo0hRoCJYVgDRojJDW62VmuPtH2953eF
         9V9UwIuziag/krVflC/XQdvkaZYWOVxag2QKksoaoUDxT4oL76I7RjZeCLcUY6nOKZkd
         RWsg==
X-Gm-Message-State: AOAM533P8Xxnfwu81CRANLWLVfKnavtrQMYRx9M2ASj/sUztPLBYeCPt
        YodR1/Fgj2zJ14rcHBL31peAIe+eNlTbNgwqPA4=
X-Google-Smtp-Source: ABdhPJz9usoF+oPi+AwWbMps8TM43STudVkIavyZ4DbrjkPuiMyqw/ApsGTJhN86+c2vCor1R869jg==
X-Received: by 2002:a17:907:d28:b0:6e0:996c:7e53 with SMTP id gn40-20020a1709070d2800b006e0996c7e53mr5529429ejc.658.1648227049404;
        Fri, 25 Mar 2022 09:50:49 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id bd12-20020a056402206c00b00418c9bf71cbsm3025510edb.68.2022.03.25.09.50.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 09:50:49 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so2888563wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:50:48 -0700 (PDT)
X-Received: by 2002:a05:600c:3c8a:b0:389:cf43:eaf6 with SMTP id
 bg10-20020a05600c3c8a00b00389cf43eaf6mr10706474wmb.199.1648226737471; Fri, 25
 Mar 2022 09:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <1647452154-16361-1-git-send-email-quic_sbillaka@quicinc.com>
 <1647452154-16361-6-git-send-email-quic_sbillaka@quicinc.com>
 <CAE-0n50dmA0ETgNvaBGs+XmGu+r=6RbfbmnHqXAFqUBGjVGDvg@mail.gmail.com> <MW4PR02MB718688EF42698851322BBF6DE11A9@MW4PR02MB7186.namprd02.prod.outlook.com>
In-Reply-To: <MW4PR02MB718688EF42698851322BBF6DE11A9@MW4PR02MB7186.namprd02.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 25 Mar 2022 09:45:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X7yHoC=7Fj24AjkGwgKvTL6qYfW+yPRstF5j6qt1Lw_Q@mail.gmail.com>
Message-ID: <CAD=FV=X7yHoC=7Fj24AjkGwgKvTL6qYfW+yPRstF5j6qt1Lw_Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] drm/msm/dp: Add eDP support via aux_bus
To:     "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        quic_vproddut <quic_vproddut@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 25, 2022 at 7:11 AM Sankeerth Billakanti (QUIC)
<quic_sbillaka@quicinc.com> wrote:
>
> > > @@ -114,10 +114,12 @@ struct drm_bridge *dp_bridge_init(struct
> > msm_dp *dp_display, struct drm_device *
> > >         bridge->funcs = &dp_bridge_ops;
> > >         bridge->type = dp_display->connector_type;
> > >
> > > -       bridge->ops =
> > > -               DRM_BRIDGE_OP_DETECT |
> > > -               DRM_BRIDGE_OP_HPD |
> > > -               DRM_BRIDGE_OP_MODES;
> > > +       if (bridge->type == DRM_MODE_CONNECTOR_DisplayPort) {
> >
> > Why can't eDP have bridge ops that are the same?
> >
>
> eDP needs to be reported as always connected. Whichever bridge is setting these ops flags should provide the ops.
> The farthest bridge from the encoder with the ops flag set should implement the ops.
> drm_bridge_connector_detect  reports always connected for eDP. So, we don't need DRM_BRIDGE_OP_DETECT
> eDP panel bridge will add DRM_BRIDGE_OP_MODES in drm_panel_bridge_add_typed and will call panel_edp_get_modes.
> As we are not supporting HPD for EDP, we are not setting the HPD ops flag.

Right. It's Expected that eDP and DP would have different ops. If we
define "detect" and "HPD" as whether the display is _physically_
connected, not the status of the poorly-named eDP "HPD" pin, then eDP
is _supposed_ to be considered always connected and thus would never
support DETECT / HPD.

...and right that the panel is expected to handle the modes.

This matches how things have been progressing in Laurent's patches
(taken over by Kieran) to add full DP support to sn65dsi86. For
instance:

https://lore.kernel.org/r/20220317131250.1481275-3-kieran.bingham+renesas@ideasonboard.com/
https://lore.kernel.org/r/20220317131250.1481275-4-kieran.bingham+renesas@ideasonboard.com/

-Doug
