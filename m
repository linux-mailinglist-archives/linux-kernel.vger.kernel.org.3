Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0FE53C37D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 06:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiFCEBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 00:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiFCEBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 00:01:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C34F31DC0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 21:01:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id rq11so13623065ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 21:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8bVxKeCs+luEXxpnTLIbgpg19GNEZEh9tmWHWEe4S4=;
        b=fD7kHLPGCLB6BwqWqEUYpaRcFdRj6SfBXhNT8BN4I9zVIbzLaLp78HxuCGvWRZQMTi
         uyG/1hzIApR7fvPr0IySLfmaArCFTCp8JebyXa3+LDLDErePMizdjtRfFzLMYQpXcFiQ
         DZ2TCHIo3llis01Zupghoa06ycO+92zWx1r+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8bVxKeCs+luEXxpnTLIbgpg19GNEZEh9tmWHWEe4S4=;
        b=TshGQ8kv6154XzSb/FMsDmJUsZrSA+DW65A4LvzKTo4uKA/GWFMLKb1nZmNfkOmf9z
         flQQD1vssBMUh02SsXXk9nId8r9IbvxJQO5F0j5gn7FJDrtrSbCj3uomJrqw/xtyNGxi
         1T6p74t2Tzz6Wka+I+TF8uGb54x5YbmZlD4o/BVV3VvmTN3lnVSOk8Lp5dhUGRRCZrQb
         NOsm+AbV+ygqTaL5h0IhM8xWcvj2unO83n8PQfeiAStVptfkutYd2gj08zD+QRqbuuTW
         WVQRPInkVddbCnyyW5ZGIhcHf7OY4R1Ksc9ZQPakzu/zLH2nQWNQrBhkVg7n/+STAwBy
         QYwA==
X-Gm-Message-State: AOAM5317WiJzqYyD+HnLHbClOkNmqqN8QpY7Dy5K9a6CQ1ghDThMov+Z
        /7Vrj8NY9Fs7N/nzLM6bGKk+xyoqkzQy6k1jLRHIEw==
X-Google-Smtp-Source: ABdhPJyw/i2NBojqg3RSMKZ6XZsX0ph8P35ta717/u7cXFNMwFYFBna4UYDnpqAg0IP9EfLOD4BvkdnYqa5fefRVriI=
X-Received: by 2002:a17:907:2ce2:b0:6ff:30e2:25c3 with SMTP id
 hz2-20020a1709072ce200b006ff30e225c3mr6928613ejc.494.1654228892918; Thu, 02
 Jun 2022 21:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220601094637.1200634-1-hsinyi@chromium.org> <20220601094637.1200634-4-hsinyi@chromium.org>
 <CAD=FV=XnA80P7BoaAX6JD9Q4ggnk4g4M3wmJFEDNij3+10aL4g@mail.gmail.com>
In-Reply-To: <CAD=FV=XnA80P7BoaAX6JD9Q4ggnk4g4M3wmJFEDNij3+10aL4g@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 3 Jun 2022 12:01:06 +0800
Message-ID: <CAJMQK-g7CdR8sgVssGGYPCaeGz3dKwqsWBnCRCdMvsh1Mtph6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] drm/panel: panel-edp: Implement .get_orientation callback
To:     Doug Anderson <dianders@chromium.org>
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

On Fri, Jun 3, 2022 at 5:51 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Jun 1, 2022 at 2:46 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > To return the orientation property to drm/kms driver.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> > index 1732b4f56e38..a2133581a72d 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -609,6 +609,13 @@ static int panel_edp_get_timings(struct drm_panel *panel,
> >         return p->desc->num_timings;
> >  }
> >
> > +static enum drm_panel_orientation panel_edp_get_orientation(struct drm_panel *panel)
> > +{
> > +       struct panel_edp *p = to_panel_edp(panel);
> > +
> > +       return p->orientation;
> > +}
> > +
> >  static int detected_panel_show(struct seq_file *s, void *data)
> >  {
> >         struct drm_panel *panel = s->private;
> > @@ -637,6 +644,7 @@ static const struct drm_panel_funcs panel_edp_funcs = {
> >         .prepare = panel_edp_prepare,
> >         .enable = panel_edp_enable,
> >         .get_modes = panel_edp_get_modes,
> > +       .get_orientation = panel_edp_get_orientation,
> >         .get_timings = panel_edp_get_timings,
> >         .debugfs_init = panel_edp_debugfs_init,
> >  };
>
> I'm curious: should we be removing the old
> drm_connector_set_panel_orientation() from panel_edp_get_modes()?
> ...or maybe you want to keep it for now because you're only adding
> support to the mediatek driver and for other drivers the WARN_ON is
> better than no orientation support at all?

Right, for the drm/kms drivers that calls
drm_connector_set_panel_orientation(), the
drm_connector_set_panel_orientation() called in panels is no-op, but
others they still need this to be called in the panel.
>
> Maybe you could put a comment next to the old
> drm_connector_set_panel_orientation() saying that it's deprecated and
> that drm drivers are expected to add a call to get_orientation()? Then
> when people see the WARN_ON splat they'll quickly figure out how to
> fix it. ...and eventually we can probably remove all the old calls
> from get_modes() ?
Sure, sounds good to me. I will add this.

>
> -Doug
