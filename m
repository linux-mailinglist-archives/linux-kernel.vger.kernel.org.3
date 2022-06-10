Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD818546EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 23:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350659AbiFJVEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 17:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348020AbiFJVEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:04:45 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0985624BDB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:04:44 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id v143so646148oie.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=6BSSJ/rWsXUBg5MMoeJBHI5sh4Vg+Gf+Lk7kJ6t8nrM=;
        b=ldlk36TEpLb8bKM9kbq6yMC+kG1oiGHmPqVQxcVdRKo79hJxr7pqzJPr/BfNqZZJlT
         XSswpqq4c+gHIsrn8uVopdU6inApeuSxfIzbubd0SWZLVr1Q/SD6zdImR0WiqMGuATFR
         8QB4g9Dvv645HlH5d+XtOqkStx++qXkKgy4II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=6BSSJ/rWsXUBg5MMoeJBHI5sh4Vg+Gf+Lk7kJ6t8nrM=;
        b=w6QQNzvMYCoRMXwjUMOZq+UN6Q0AzrAN9WFqXSKOUw64FpZJehmwLuFEo/wMnUcH5j
         w4dvTp4yIuANloiAn6idWi/FqqEQbE/3WvdRDV4hzspQS+pjuW8JstetI19mlIQ0P9zg
         W9qWZHRvioUI2YBGoel0XkbKypMNOGrWjR6J9GmWUUZBjFkba9y/+ngaC7iFtR42p2fc
         fzgyHhEp2Vphi9XzYfI/EC7TW4zbRODPurIFf3hIHD7tgFpmJlZaqvF4dZ+vHQDbp2h3
         I9MRhoJFMnrnDr+L2CwwGa5N78KA791/iFJeWZ8owyvec6Y6cu69Z8bV+PpyK5kiZZix
         sMXg==
X-Gm-Message-State: AOAM530R1b6MrYPDpacGPOl4DfJRHDgrhgwVYiI8UFD1RySZc46xuEXu
        vFPkVTWDXfkJiZmdRnaEmDs4coIJqZR2yCd/o22Qxg==
X-Google-Smtp-Source: ABdhPJzGn0kc0KitEDzC39ApVuo0Gabefuaw+3AKA6iKU3xzQfk8aDXBAJ2dQY9eYenZKctLFWTXf3x1wQcbiYQgVe8=
X-Received: by 2002:a05:6808:1703:b0:32e:851e:7f81 with SMTP id
 bc3-20020a056808170300b0032e851e7f81mr924613oib.63.1654895083399; Fri, 10 Jun
 2022 14:04:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Jun 2022 14:04:42 -0700
MIME-Version: 1.0
In-Reply-To: <1653687133-32331-1-git-send-email-quic_khsieh@quicinc.com>
References: <1653687133-32331-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 10 Jun 2022 14:04:42 -0700
Message-ID: <CAE-0n519jUEQK565OFVevvyoF49rgTazf4McjKmDS8mfDrWwyQ@mail.gmail.com>
Subject: Re: [PATCH v4] drm/msm/dp: force link training for display resolution change
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-05-27 14:32:13)
> During display resolution changes display have to be disabled first
> followed by display enabling with new resolution. Display disable
> will turn off both pixel clock and main link clock so that main link
> have to be re trained during display enable to have new video stream

s/re/re-/

> flow again. At current implementation, display enable function manually
> kicks up irq_hpd_handle which will read panel link status and start link
> training if link status is not in sync state. However, there is rare
> case that a particular panel links status keep staying in sync for
> some period of time after main link had been shut down previously at
> display disabled. Main link retraining will not be executed by
> irq_hdp_handle() if the link status read from pane shows it is in

s/pane/panel/

> sync state. If this was happen, then video stream of newer display
> resolution will fail to be transmitted to panel due to main link is
> not in sync between host and panel. This patch force main link always
> be retrained during display enable procedure to prevent this rare
> failed case from happening. Also this implementation are more
> efficient than manual kicking off irq_hpd_handle function.

The description makes it sound like the link status is not updated,
sometimes. Isn't that the real issue here? Not that link training needs
to be done again (which it always does apparently), but that disabling
the display doesn't wait for the link to go down. Or disabling the link
is causing some sort of glitch on the sink causing it to report the
status as OK when it really isn't.

>
> Changes in v2:
> -- set force_link_train flag on DP only (is_edp == false)
>
> Changes in v3:
> -- revise commit  text
> -- add Fixes tag
>
> Changes in v4:
> -- revise commit  text
>
> Fixes: 62671d2ef24b ("drm/msm/dp: fixes wrong connection state caused by failure of link train")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index c388323..370348d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1688,10 +1689,14 @@ void dp_bridge_enable(struct drm_bridge *drm_bridge)
>
>         state =  dp_display->hpd_state;
>
> -       if (state == ST_DISPLAY_OFF)
> +       if (state == ST_DISPLAY_OFF) {
>                 dp_display_host_phy_init(dp_display);
>
> -       dp_display_enable(dp_display, 0);
> +               if (!dp->is_edp)

Does this assume eDP has one resolution? I don't understand why eDP is
special here, especially if eDP has more than one resolution available
it seems like we would want to retrain the link regardless.

> +                       force_link_train = true;
> +       }
> +
> +       dp_display_enable(dp_display, force_link_train);
>
>         rc = dp_display_post_enable(dp);
>         if (rc) {
