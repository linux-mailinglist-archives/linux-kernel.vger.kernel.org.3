Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A4E48DE56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 20:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiAMTry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 14:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiAMTrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 14:47:53 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B180C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 11:47:53 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso7502960otf.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 11:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=LveOCAOmqB/h+YVzSFKmHbwc26AOHfpIvWRnUMitU1c=;
        b=kVEP29epgvvIK6dun2PAdR68NYQ3/uzqBwFqt5+xXQE56p7Idpymv7GY5NGJ3pttS8
         C1bw9YyQ0g+LShcqDw9WRWWa5rf1pmLBdIFJ14M9Rs36rgalrhCmzJZLu+IY14hcAsV/
         Ea1na8Sg5YF8BWGQLrpgTqpbmHKSavW2aG3q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=LveOCAOmqB/h+YVzSFKmHbwc26AOHfpIvWRnUMitU1c=;
        b=juLYdf0tGnN9DtW1ua3sxakTtlchGFy+30phpRy4kNRkvzgm9OLUR7EqvCAD1FA7Zm
         Z9uTKA9/AClx12eG8vJp544Ci3RnFwo32Jp33kLDZe8BtHkJWABfIJ1Osv0deo2QgR4i
         2nBFYamWpzduvrxjLImtwSIyuxnT1VPNiQfSh0TtwpoDuviejjB7sGH+bi5Z7IJfOOgJ
         Q63Me5TXTDzjfz41r8zlXneO5UTt8N7Dq/LUtyQIYSsGzb/iFWykPJAy0VXp1XA5MYJX
         9w+RyfaUapAJv3Lv9vrhU+KTVrq33pn+1o0Cy5VcVR5ZGK7npoPPPzcldsy5QaCuQmS4
         xymg==
X-Gm-Message-State: AOAM533ahhAaS8puzK3Pg6EpwGNWATIWufzjLr4tnvzR6ZMWHkESyxtP
        8Eh28JfTRqDpvscKel/BFeABK37KEU0SXvS7X3chZQ==
X-Google-Smtp-Source: ABdhPJxRQB/uv0ujnf5NZkqZ46QWuW2o3HqwoQ+L6pFQvnd2vuIjHOpP+nH1s1VZt5t3QaBJW5HC+uJuKc9fC2MlXQg=
X-Received: by 2002:a9d:7451:: with SMTP id p17mr4148931otk.159.1642103272468;
 Thu, 13 Jan 2022 11:47:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Jan 2022 11:47:52 -0800
MIME-Version: 1.0
In-Reply-To: <338ae657-e8ed-e620-0aa7-4ad05df18ad1@quicinc.com>
References: <1641926606-1012-1-git-send-email-quic_khsieh@quicinc.com>
 <1641926606-1012-2-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n53hrPYR3ThwxM_+fzyRSB+6W1drFymW5n_RKmg_gf8z-w@mail.gmail.com>
 <84ee17f9-2597-86b6-1517-2358d443f65b@quicinc.com> <CAE-0n5134H0puMicozjdfTY+zXVUZyrebjv7Hto3EWcQAELO4A@mail.gmail.com>
 <338ae657-e8ed-e620-0aa7-4ad05df18ad1@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 13 Jan 2022 11:47:51 -0800
Message-ID: <CAE-0n51QbJHnOses5sF6xECR0gRZB1Fbi1KqoLG+61ZWH9BtOA@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] drm/msm/dp: do not initialize phy until plugin
 interrupt received
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-01-13 09:51:42)
>
> On 1/12/2022 8:13 PM, Stephen Boyd wrote:
> >>>> -       if (dp->usbpd->orientation == ORIENTATION_CC2)
> >>>> -               flip = true;
> >>>> +       dp_power_init(dp->power, false);
> >>>> +       dp_ctrl_reset_irq_ctrl(dp->ctrl, true);
> >>>> +
> >>>> +       /*
> >>>> +        * eDP is the embedded primary display and has its own phy
> >>>> +        * initialize phy immediately
> >>> Question still stands why we can't wait for hpd high from the eDP panel.
> >>> Also, I think "has its own phy" means that it's not part of a combo
> >>> USB+DP phy? Can you please clarify?
> >>>
> >>>> +        */
> >>>> +       if (dp->dp_display.connector_type == DRM_MODE_CONNECTOR_eDP)
> >>>> +               dp_display_host_phy_init(dp);
> >>>>
> >>>> -       dp_power_init(dp->power, flip);
> >>>> -       dp_ctrl_host_init(dp->ctrl, flip, reset);
> >>>>           dp_aux_init(dp->aux);
> >>>>           dp->core_initialized = true;
> >>>>    }
> >>>> @@ -1306,20 +1330,23 @@ static int dp_pm_resume(struct device *dev)
> >>>>           dp->hpd_state = ST_DISCONNECTED;
> >>>>
> >>>>           /* turn on dp ctrl/phy */
> >>>> -       dp_display_host_init(dp, true);
> >>>> +       dp_display_host_init(dp);
> >>>>
> >>>>           dp_catalog_ctrl_hpd_config(dp->catalog);
> >>>>
> >>>> -       /*
> >>>> -        * set sink to normal operation mode -- D0
> >>>> -        * before dpcd read
> >>>> -        */
> >>>> -       dp_link_psm_config(dp->link, &dp->panel->link_info, false);
> >>>>
> >>>>           if (dp_catalog_link_is_connected(dp->catalog)) {
> >>>> +               /*
> >>>> +                * set sink to normal operation mode -- D0
> >>>> +                * before dpcd read
> >>>> +                */
> >>>> +               dp_display_host_phy_init(dp);
> >>>> +               dp_link_psm_config(dp->link, &dp->panel->link_info, false);
> >>>>                   sink_count = drm_dp_read_sink_count(dp->aux);
> >>>>                   if (sink_count < 0)
> >>>>                           sink_count = 0;
> >>>> +
> >>>> +               dp_display_host_phy_exit(dp);
> >>> Why is the phy exited on resume when the link is still connected? Is
> >>> this supposed to be done only when the sink_count is 0? And how does
> >>> this interact with eDP where the phy is initialized by the call to
> >>> dp_display_host_init() earlier in this function.
> >>>
> >>>>           }
> >>>>
> >>>>           dp->link->sink_count = sink_count;
> > Any response to the above two comments?

??
