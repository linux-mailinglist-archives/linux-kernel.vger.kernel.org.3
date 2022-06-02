Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA24D53C072
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbiFBVnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbiFBVnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:43:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3102DAAC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:43:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id er5so7879206edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 14:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGSI2I0W6obVN72SR94f17TgsNITtbd3TUyps87cem0=;
        b=I8AbK3106c0NrpQBVIg8yCXzXJPrksGELjkTUDJqqYSxzU9eZC8iQ/NMFM/geGRG67
         73F09t9HkHA/VKsA38Qhq4yt4s8Y5hjkDE5abmeqFTz7RgSZJick4aW5MxbxrGHkX0JB
         p1/OipPLgx9HSZ0DWFbl37ExGobwR46qdR7iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGSI2I0W6obVN72SR94f17TgsNITtbd3TUyps87cem0=;
        b=HTnh5ZInh8Y5jemsJeu/hhAL6ND12fXn7Gto5RGZAgoP+baP6MEoF1dDm8RkuaKpoD
         aRwZ5Pcjns1dx9FbTjvSdT4YQ0uz2FRS2iuR3z2s1TXYemTOH20AA6OluHrdTUeck3eN
         vrlg43ZdXKk180roYthIkW3xv9DXqCQ/HhIsv5+a2vBGRTAuXfsUe+oTt5u1C1Q5q2l0
         nyl87rDFsFI1+vrZx3yfIBAah1rLnoKM4vStYFzjgQW2TFUjagEMfbuHopXcO7nfLa9v
         NMS1OlxNSFLMgegcV7fW+oWQ7wIIQKf9nbQaqk3sIZ7bP+7LEHuiw4bCt34VB3eF4J36
         /cVA==
X-Gm-Message-State: AOAM531O35EDSpOr7A7gkWU4nLtd5w46ifXU5ke/zb3Hg1sT7QXy/bbW
        it637ZDk4gx//e4+cwD0DXMKGws0yfaEl+jJ
X-Google-Smtp-Source: ABdhPJytINCPB7yTyIr/Z2zTeJIdiJRpjzBbdYuul4hbmhKvK9czFCZjkG0IDwX5I3dWqV/FzId0jA==
X-Received: by 2002:aa7:cb8d:0:b0:42b:e414:8019 with SMTP id r13-20020aa7cb8d000000b0042be4148019mr7722439edt.151.1654206216312;
        Thu, 02 Jun 2022 14:43:36 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b0042dd022787esm2996431edb.6.2022.06.02.14.43.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 14:43:35 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id v4-20020a1cac04000000b00397001398c0so5409993wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 14:43:33 -0700 (PDT)
X-Received: by 2002:a05:600c:2e53:b0:397:4730:ee7a with SMTP id
 q19-20020a05600c2e5300b003974730ee7amr34358678wmf.118.1654206213425; Thu, 02
 Jun 2022 14:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220601094637.1200634-1-hsinyi@chromium.org> <20220601094637.1200634-4-hsinyi@chromium.org>
In-Reply-To: <20220601094637.1200634-4-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Jun 2022 14:43:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XnA80P7BoaAX6JD9Q4ggnk4g4M3wmJFEDNij3+10aL4g@mail.gmail.com>
Message-ID: <CAD=FV=XnA80P7BoaAX6JD9Q4ggnk4g4M3wmJFEDNij3+10aL4g@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] drm/panel: panel-edp: Implement .get_orientation callback
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 1, 2022 at 2:46 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> To return the orientation property to drm/kms driver.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 1732b4f56e38..a2133581a72d 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -609,6 +609,13 @@ static int panel_edp_get_timings(struct drm_panel *panel,
>         return p->desc->num_timings;
>  }
>
> +static enum drm_panel_orientation panel_edp_get_orientation(struct drm_panel *panel)
> +{
> +       struct panel_edp *p = to_panel_edp(panel);
> +
> +       return p->orientation;
> +}
> +
>  static int detected_panel_show(struct seq_file *s, void *data)
>  {
>         struct drm_panel *panel = s->private;
> @@ -637,6 +644,7 @@ static const struct drm_panel_funcs panel_edp_funcs = {
>         .prepare = panel_edp_prepare,
>         .enable = panel_edp_enable,
>         .get_modes = panel_edp_get_modes,
> +       .get_orientation = panel_edp_get_orientation,
>         .get_timings = panel_edp_get_timings,
>         .debugfs_init = panel_edp_debugfs_init,
>  };

I'm curious: should we be removing the old
drm_connector_set_panel_orientation() from panel_edp_get_modes()?
...or maybe you want to keep it for now because you're only adding
support to the mediatek driver and for other drivers the WARN_ON is
better than no orientation support at all?

Maybe you could put a comment next to the old
drm_connector_set_panel_orientation() saying that it's deprecated and
that drm drivers are expected to add a call to get_orientation()? Then
when people see the WARN_ON splat they'll quickly figure out how to
fix it. ...and eventually we can probably remove all the old calls
from get_modes() ?

-Doug
