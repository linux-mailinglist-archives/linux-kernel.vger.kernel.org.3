Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AF84A4AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379765AbiAaPdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379680AbiAaPdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:33:18 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398C4C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 07:33:18 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id p125so12563926pga.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 07:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cX5XYAJngFJIkj2tMMe8Nc34iEVYgEFYIFuQOpTXb2w=;
        b=SdxwxwtI9YLoBpUcmE8AxRvItfQWSWlS7uehIDO+jRhcow3zXSAEwYMsJN3NA8pMN7
         wsH13NbmKEOaif7xODnuexv5fybV+7VZVoFwa2S7bPcAP2UE8rZj7XBbQW8LHTcKlT/R
         oygb21l+VMBth2i7eWNRi2GvuHMFzSfMpxVmh6+XKo0NXpHDfX4UOTjHdQeZ0rcTnHBW
         j0e76DYs/bWa2SjSS35FpghJtuhtD9pBDu8BVbE0Qb4cwBXxCXIsMcwxQHxMPLYzVV/D
         pg3GNckAWEo8e6PLUue4kSm8dbyb0EG6Lktpkm+KL8ZbZ1pJ1ycIoRE/Xn6acRp3sove
         CD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cX5XYAJngFJIkj2tMMe8Nc34iEVYgEFYIFuQOpTXb2w=;
        b=5Ttgkq5k1XbZ/TIposlN2fyHa3Q1CmAdeAwsgUfR/HPTmlFGjDXoOeto7yMZZJXiyZ
         w047rOdzNzlG2Rv7mHC1gjIsPsDqHMzjcBpwXrtihw7/zR1m8aJ5QaPKPPzlT3Xyfus7
         C6viVLs+njXCqOHUsjR7EQTipyzlpS7aQNdsdw4qlXjBhWGJZoZFl/CQ4V6/dSIYkp7U
         bMrJMWBf8xBv9guYuPs5JyMZBExxcCYL1NFHMOCzCme4sjMSQ3U1/RRwklLyKTme5FSM
         7I1TPjwZ0uZap2DtuGAd417Uwg0GEUuOCs1FAD6XQBWpX64V4BTE8OKNMKc/eAL/FHOb
         2Dkg==
X-Gm-Message-State: AOAM530XEWoekTUyZkFasuUV+bIqcLfJcAwsHOsCS0jhrKCsBSDKfGvj
        SlwTEf74z1+WzgFSgR4fsquG+4SiTGWGOpGOAWW3Ng==
X-Google-Smtp-Source: ABdhPJxytOnJHsFkSdPNeJwRZFPhd92LCJImZFTLm2lwIOzkJoAcPVNOGM8FcsNI3RhXmy4nIjkITgpXDJvA+80soQY=
X-Received: by 2002:a63:610b:: with SMTP id v11mr17077460pgb.201.1643643197630;
 Mon, 31 Jan 2022 07:33:17 -0800 (PST)
MIME-Version: 1.0
References: <Ye21tlZKRRe2vUzR@pendragon.ideasonboard.com> <1643008835-73961-1-git-send-email-lyz_cs@pku.edu.cn>
 <YfHw8WwDpnRXO07G@pendragon.ideasonboard.com>
In-Reply-To: <YfHw8WwDpnRXO07G@pendragon.ideasonboard.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 31 Jan 2022 16:33:06 +0100
Message-ID: <CAG3jFysi4aWGVOJ_Z2PinXyC1dfFWbP2nY-3Om-=PwZ6zbWWUA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: Add missing pm_runtime_put_sync
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Yongzhi Liu <lyz_cs@pku.edu.cn>, a.hajda@samsung.com,
        narmstrong@baylibre.com, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 at 02:10, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Yongzhi,
>
> Thank you for the patch.
>
> On Sun, Jan 23, 2022 at 11:20:35PM -0800, Yongzhi Liu wrote:
> > pm_runtime_get_sync() will increase the rumtime PM counter
> > even when it returns an error. Thus a pairing decrement is needed
> > to prevent refcount leak. Fix this by replacing this API with
> > pm_runtime_resume_and_get(), which will not change the runtime
> > PM counter on error. Besides, a matching decrement is needed
> > on the error handling path to keep the counter balanced.
> >
> > Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > ---
> >  drivers/gpu/drm/bridge/nwl-dsi.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> > index 9282e61..30aacd9 100644
> > --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> > +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> > @@ -862,18 +862,19 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
> >       memcpy(&dsi->mode, adjusted_mode, sizeof(dsi->mode));
> >       drm_mode_debug_printmodeline(adjusted_mode);
> >
> > -     pm_runtime_get_sync(dev);
> > +     if (pm_runtime_resume_and_get(dev) < 0)
> > +             return;
> >
> >       if (clk_prepare_enable(dsi->lcdif_clk) < 0)
> > -             return;
> > +             goto runtime_put;
> >       if (clk_prepare_enable(dsi->core_clk) < 0)
> > -             return;
> > +             goto runtime_put;
> >
> >       /* Step 1 from DSI reset-out instructions */
> >       ret = reset_control_deassert(dsi->rst_pclk);
> >       if (ret < 0) {
> >               DRM_DEV_ERROR(dev, "Failed to deassert PCLK: %d\n", ret);
> > -             return;
> > +             goto runtime_put;
> >       }
> >
> >       /* Step 2 from DSI reset-out instructions */
> > @@ -883,13 +884,18 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
> >       ret = reset_control_deassert(dsi->rst_esc);
> >       if (ret < 0) {
> >               DRM_DEV_ERROR(dev, "Failed to deassert ESC: %d\n", ret);
> > -             return;
> > +             goto runtime_put;
> >       }
> >       ret = reset_control_deassert(dsi->rst_byte);
> >       if (ret < 0) {
> >               DRM_DEV_ERROR(dev, "Failed to deassert BYTE: %d\n", ret);
> > -             return;
> > +             goto runtime_put;
> >       }
> > +
> > +     return;
> > +
> > +runtime_put:
> > +     pm_runtime_put_sync(dev);
> >  }
> >
> >  static void

Applied to drm-misc-next.
