Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18B457C9CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiGULgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiGULgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:36:45 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E379B31DF4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:36:44 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id h18so914877qvr.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BEc2q0Ntqmu+9tKVZvoMBHZ3yF5u0x+IBXq0oc1TSOo=;
        b=bqXzpQi/ikfdMfe3U+F+lyzJgtkWHvoBhK2GpVED6KlSzicYAfUihqBkMNaUt++7pD
         iIGwWlFUBRr56LbK5NBlUT9jcUbXcX9DmE/S7Luef/y5myQ+qM4JPUDsuieDqD+2ral3
         ZKgWZa62NI/lFWKO9wBbMMi20Dm1B6JuzaxcxVPFeEBwiQ2iqN3/iYqICw4D5FhI7DCa
         Fj1j/ao8BFpO6t09cZdD/wCJYU5SttVXgbIjMb6q7H4HLSXWmKLdq0UbOzq4GGxdL+xw
         KuGoDgO40vkMERpb09aENa5UWGw4qP4LivOYMOg1RXibADF1AwIDknFpIa0iGcO+M+Y1
         R33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEc2q0Ntqmu+9tKVZvoMBHZ3yF5u0x+IBXq0oc1TSOo=;
        b=UsoDu4lKQ497aALron8ILr0L+0hxomtOCQhSY7/IGXN331WZVSFdP9cbPOJwuoFGxk
         IlkF2a48rXTD1xPfnx4oOSR7g1d5uDWmbt4VLEJqvaOqPTQ6PhfTInRWkshI788FaF3d
         7ZEg46yThxfi51MLWpKdiFku6WGLf2ksuibcPZJdGKMIrc6E4Ba3AhXKGV7Wxsd/g900
         L1XVxud9xw5LoE2hclpGSnl/57zBDMvlZgvXcOXF/TbU75ALiFSJ4qcY+0bAEncQ7gRs
         IK5QAF1JRq7mki4UX1TBVZLcpgPSMGfK3agOxCi7Yjz6eOrVmT8VXk+kuMpAU45wdsf/
         EiOw==
X-Gm-Message-State: AJIora8qKIR9Mr53neeSDUjuczffhGviLM2NsFze2FB95VABnA5m/oDC
        gtM/rWZSMqDFC4yQm4VozAjZ6SlgnWZy5R0HT1xniuiKe35O3A==
X-Google-Smtp-Source: AGRyM1taaRRQqbb0thbIJjG2DjVe/FwkH8G89JhUW39J+IlppORh67jMBG6VtyWefuqqEq5lu2z7724SADMqpHkIFWw=
X-Received: by 2002:a05:6214:2a84:b0:473:2958:2b02 with SMTP id
 jr4-20020a0562142a8400b0047329582b02mr33742565qvb.122.1658403404031; Thu, 21
 Jul 2022 04:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220720155445.RFC.1.I2999ac2d08643f0c2f3fe916cca86f8c832c8142@changeid>
In-Reply-To: <20220720155445.RFC.1.I2999ac2d08643f0c2f3fe916cca86f8c832c8142@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 21 Jul 2022 14:36:32 +0300
Message-ID: <CAA8EJpombZYHKXKd=rLte0pUaXjep0t7+H-uz_sFTuJwjH3y9A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] drm/panel-edp: Allow overriding the eDP EDID
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
        sam@ravnborg.org, robdclark@gmail.com, linus.walleij@linaro.org,
        thierry.reding@gmail.com, bjorn.andersson@linaro.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 at 01:55, Douglas Anderson <dianders@chromium.org> wrote:
>
> I found that writing to `/sys/kernel/debug/dri/*/eDP*/edid_override`
> wasn't working for me. I could see the new EDID take effect in
> `/sys/class/drm/card*-eDP*/edid` but userspace wasn't seeing it..
>
> The problem was that panel-edp was caching the EDID that it read and
> using that over and over again.
>
> Let's change panel-edp to look at the EDID that's stored in the
> connector. This is still a cache, which is important since this
> function is called multiple times and readin the EDID is slow, but
> this property is automatically updated by drm_get_edid() (which reads
> the EDID) and also updated when writing the edid_override in debugfs.
>
> Fixes: 63358e24ee79 ("drm/panel: panel-simple: Cache the EDID as long as we retain power")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

A different proposal for you to consider:
Change drm_get_edid/drm_do_get_edid to return int rather than struct
edid, while caching the EDID in the connector. Or maybe add a new API
drm_read_edid() and make drm_get_edid() deprecated in favour of it.
The goal should be to let all drivers use connector-cached EDID rather
than getting  the EDID, parsing it and kfree()ing it immediately
afterwards.
Most probably we should be able to move
drm_connector_update_edid_property() into drm_do_get_edid() and drop
it from the rest of the code. This might require additional thought
about locking, to ensure that nobody pulls the cached edid out from
under our feet.

Extra "bonus" points to consider:
- Maybe it's time to add get_edid() to the drm_panel interface, teach
panel_bridge about it and let drm_bridge_connector handle all the
details?

So, while this looks like a longer path, I think it's worth checking
that we can refactor this piece of code.

> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 3626469c4cc2..12241c1e32f7 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -226,8 +226,6 @@ struct panel_edp {
>
>         const struct edp_panel_entry *detected_panel;
>
> -       struct edid *edid;
> -
>         struct drm_display_mode override_mode;
>
>         enum drm_panel_orientation orientation;
> @@ -580,11 +578,19 @@ static int panel_edp_get_modes(struct drm_panel *panel,
>         if (p->ddc) {
>                 pm_runtime_get_sync(panel->dev);
>
> -               if (!p->edid)
> -                       p->edid = drm_get_edid(connector, p->ddc);
> +               if (!connector->edid_blob_ptr) {
> +                       /*
> +                        * We read the EDID and then immediately free it,
> +                        * relying on the side effect of drm_get_edid() to store
> +                        * a copy in connector->edid_blob_ptr. We always use
> +                        * the copy cached in the connector since that allows
> +                        * the edid_override to work.
> +                        */
> +                       kfree(drm_get_edid(connector, p->ddc));
> +               }
>
> -               if (p->edid)
> -                       num += drm_add_edid_modes(connector, p->edid);
> +               if (connector->edid_blob_ptr)
> +                       num += drm_add_edid_modes(connector, connector->edid_blob_ptr->data);
>
>                 pm_runtime_mark_last_busy(panel->dev);
>                 pm_runtime_put_autosuspend(panel->dev);
> @@ -926,9 +932,6 @@ static int panel_edp_remove(struct device *dev)
>         if (panel->ddc && (!panel->aux || panel->ddc != &panel->aux->ddc))
>                 put_device(&panel->ddc->dev);
>
> -       kfree(panel->edid);
> -       panel->edid = NULL;
> -
>         return 0;
>  }
>
> --
> 2.37.0.170.g444d1eabd0-goog
>


--
With best wishes
Dmitry
