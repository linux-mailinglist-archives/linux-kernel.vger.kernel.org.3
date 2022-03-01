Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2354C873F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiCAI7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiCAI7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:59:38 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C0829C9B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:58:58 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id h16so17659468iol.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zS+cnPhBtmmIHoXqElXnQsUButXiv0E0/DwMRuRFsLQ=;
        b=dKk4qQ7LWIzAJYcabanXSX62/bwBzGNkQbny257h4oA2F/V5kxaID5hYkQF3fxysnF
         fDNVbcXoWlfAllgEoc0Decg8CFEaGxd0KoJ9+f3/8j84KLWtIbRufWVUCaPW99S+J7+x
         VXIdjnvqxyqu7R4Sxe71///9HuXYiqFP/wf3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zS+cnPhBtmmIHoXqElXnQsUButXiv0E0/DwMRuRFsLQ=;
        b=w6MOzpqtAEZss4Y0fwXAU5YQ3o4dcRw43f8/84rOG6MViES3i4o6X6xKCDmHBB5vsc
         k+bGOFBx2YuqQkHOkin9+D6KNFFLrzho0nxLoBTzCcDnrFZysXCHyE68JmB7PyWaLVnM
         6O6rrUBcHGxetub4ogBJeA8U4wg3MwO4p6/MXIVKiMtVBTHiP8K11yDE9oVIYO/0qh30
         mUGkEMrVDI8ur9T/sNyVcjaJUTYiJBxmFwlGIBm1VxkEmOQeW83SXi1AEdfbxIyVzRHl
         4YyB+bDoIloVW6iViGoQcQBLG5mqU+dLB+NDxLfWwC+YEpFlSKsLmQ7HwEpgbyhrgUS1
         XXGA==
X-Gm-Message-State: AOAM533hksLqLa7Cb9+0ET3EPQIT6A+Bkn8t3D/oqZ4dgRpKL3Hf/Jwa
        GbLsHgL47Of8twATsdiKwW5I9zRxyQZC0D0VuelhuA==
X-Google-Smtp-Source: ABdhPJxOedb42cR7Env5tKd14Yn3MvdH7P0GclmaXB02RzkvPpMNJdAl5QWXrFoa5CaeeG8sh1JIhazy20hqvbbqSvU=
X-Received: by 2002:a05:6638:3f0a:b0:315:1190:ae9b with SMTP id
 ck10-20020a0566383f0a00b003151190ae9bmr21363237jab.210.1646125137609; Tue, 01
 Mar 2022 00:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20220217024418.3780171-1-xji@analogixsemi.com> <CAJMQK-gDHsH=F=d+9W1-jOqKx6kveUtRRSG03W6KDVat=BzZhg@mail.gmail.com>
In-Reply-To: <CAJMQK-gDHsH=F=d+9W1-jOqKx6kveUtRRSG03W6KDVat=BzZhg@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 1 Mar 2022 16:58:31 +0800
Message-ID: <CAJMQK-j6Nm4xt0oA9332+3AbqZ9YJuAR7EAK2BZnob2EkKLH1A@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Fix release wrong workqueue
To:     Xin Ji <xji@analogixsemi.com>
Cc:     andrzej.hajda@intel.com, Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        qwen@analogixsemi.com,
        Xin Ji <xji@analogix.corp-partner.google.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 11:02 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Thu, Feb 17, 2022 at 10:45 AM Xin Ji <xji@analogixsemi.com> wrote:
> >
> > From: Xin Ji <xji@analogix.corp-partner.google.com>
> >
> > If "hdcp_workqueue" exist, must release "hdcp_workqueue",
> > not "workqueue".
> >
> > Fixes: cd1637c7e480 ("drm/bridge: anx7625: add HDCP support")
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
> This fixes an issue that the driver will crash during unbind.
>
Hi Robert,

Kindly ping on this fix. Thanks.

> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 633618bafd75..9aab879a8851 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -2736,8 +2736,8 @@ static int anx7625_i2c_remove(struct i2c_client *client)
> >
> >         if (platform->hdcp_workqueue) {
> >                 cancel_delayed_work(&platform->hdcp_work);
> > -               flush_workqueue(platform->workqueue);
> > -               destroy_workqueue(platform->workqueue);
> > +               flush_workqueue(platform->hdcp_workqueue);
> > +               destroy_workqueue(platform->hdcp_workqueue);
> >         }
> >
> >         if (!platform->pdata.low_power_mode)
> > --
> > 2.25.1
> >
