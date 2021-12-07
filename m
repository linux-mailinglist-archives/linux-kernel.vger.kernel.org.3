Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4D546C4B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbhLGUiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhLGUit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:38:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3843CC061574;
        Tue,  7 Dec 2021 12:35:18 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x6so752892edr.5;
        Tue, 07 Dec 2021 12:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0MRZw23Xhwm034MxzUFYS0W2vmCiMWc2hTeEkBiheS4=;
        b=qfF0MYJkiFXO0yo8SQ6znn/oJgn6KSwPAP1iLWoYgqaPKBLjWS9aapuVGD44/aNRYw
         HS/lIJtTah7IN96FwxnpoMyotra7uHkqE5yzsXlWyN859sEjJDUGw7jv2F3deGJqDxJV
         0xG+aaSTkYAJJDvgcDGa/xpemTN7XfUe1H+CfpMm2mh7D14qhEAb89vDYvSN7Zu01WGd
         8r/JjuhQcJyPAY+LsixYEfL8sPtE0aGdnpGOKASxjqnTuE+L0fgnzUKBOP9pYWAYuhiM
         sks2/N1Q8BYbfSrkMfDWpm8xrZv0F/wM2KoMTapr+QpV1syjcTNpJC8ityaOJ/6/RrUN
         /Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0MRZw23Xhwm034MxzUFYS0W2vmCiMWc2hTeEkBiheS4=;
        b=jemINQCtmR6cndabfHqvA/LKAC8wwa23sQMJ40cXPpPMBYc0xF7h3eizTNZub1VaQq
         hSBIqvRHkn/3vlPQgL6a2FOPg4rf8kChDjjzEQjOIKbHBfFNY76tSQbm2dLL2cFlyaty
         3+VuTsOkjjS3JpxbCCCvIZ9fhfUd+uGINxA8FtecN1jCQ64VzxxmYiQq/iZ3psdMhWPy
         oNPjQCCYca2QRQU3+09G3cMPD3EjNYX/0xafM5bOkdFJEbGxX6tcSxQZqU2lwZLJms1E
         9X3hkhIPXLAgglEptEKW2LTehyfdVoLNXtDtk09LrWUcZsYSXwSym5MjZ+ciE2gdrpV2
         fpcQ==
X-Gm-Message-State: AOAM532+MFaquqgp/1kMcEiB95vIYOUwi7hLymdp4Tb2v2DXB9uYEX0n
        wb8UttizIkoljgaG1cPLcFA=
X-Google-Smtp-Source: ABdhPJx0SWF3W7Bhi3m6edkmD8uWCMeg8DC63JJDJOK2Np1eJ3slwzM5ocsXKmQHaTR4xNbZbvQOcQ==
X-Received: by 2002:a17:907:7896:: with SMTP id ku22mr2068285ejc.410.1638909316846;
        Tue, 07 Dec 2021 12:35:16 -0800 (PST)
Received: from jernej-laptop.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id og14sm320822ejc.107.2021.12.07.12.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:35:16 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Clark <robdclark@gmail.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/bridge: sn65dsi86: defer if there is no dsi host
Date:   Tue, 07 Dec 2021 21:35:15 +0100
Message-ID: <2606289.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <CAD=FV=X81r4eBPYz_v6vju8bpUJX+HWS1vUuO+oC0AJUWsnCRg@mail.gmail.com>
References: <20211207200906.609673-1-robdclark@gmail.com> <CAD=FV=X81r4eBPYz_v6vju8bpUJX+HWS1vUuO+oC0AJUWsnCRg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 07. december 2021 ob 21:26:50 CET je Doug Anderson napisal(a):
> Hi,
> 
> On Tue, Dec 7, 2021 at 12:03 PM Rob Clark <robdclark@gmail.com> wrote:
> > From: Rob Clark <robdclark@chromium.org>
> > 
> > Otherwise we don't get another shot at it if the bridge probes before
> > the dsi host is registered.  It seems like this is what *most* (but not
> > all) of the other bridges do.
> > 
> > It looks like this was missed in the conversion to attach dsi host at
> > probe time.
> > 
> > Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our DSI
> > device at probe") Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> > 
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > b/drivers/gpu/drm/bridge/ti-sn65dsi86.c index 02b490671f8f..3684e12fbac3
> > 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -716,7 +716,7 @@ static int ti_sn_attach_host(struct ti_sn65dsi86
> > *pdata)> 
> >         host = of_find_mipi_dsi_host_by_node(pdata->host_node);
> >         if (!host) {
> >         
> >                 DRM_ERROR("failed to find dsi host\n");
> > 
> > -               return -ENODEV;
> > +               return -EPROBE_DEFER;
> 
> Can you delete the DRM_ERROR line?

or use dev_err_probe()

Best regards,
Jernej



