Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C70467787
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380856AbhLCMlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380865AbhLCMlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:41:12 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B474C06174A;
        Fri,  3 Dec 2021 04:37:48 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id z7so6132191lfi.11;
        Fri, 03 Dec 2021 04:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fizL/hy9yXJ6JRH7+VgywLalW2LftVVfT2yuS4CxqNU=;
        b=Y93nYHfixS2aqgzp9oqGpRkvTO+vKZ4sA0hcu5TPnaZI5RnNWEwu0TRtjRSiTp3N43
         y3sybZOyU0c4RuLFBYOtIVujQ6q+g1AarOxI/e2E99DFUmFyYTruPj9ZO+/50q7As89+
         /chQdxlA2myIMM5/fKQEoH9dwsiZGeI8lNSQmQ9d8dPA0EQW2qU+6mtZ29UpnT0NUId3
         Qop+XVlzktCSRe7/V/vkIQrH2oGm7gK/EzdWJLr1vkd0630LfzxPDK+IIgFCCuFeHmGh
         r75Qpk9fZkv9OSU5R5w83y/9JJ71ZLkp222biZtVlUaxHlWdIJBUX33pMA+A8wWFU68d
         dVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fizL/hy9yXJ6JRH7+VgywLalW2LftVVfT2yuS4CxqNU=;
        b=t+OpioMpH41QbfCgWD8u/HKanCdn/2MIA3p+xrdUvW5I7Q8oJyvCiFXjXb5AfesG05
         pJAcFXqZg6mqYXzEExPq1UJ0TGIAfToAddlnvlBjDgqqTFL9lqFLF1lKqhPpg1p1+jPs
         6Pd+yhZi0CQ/VYCO+tXDa3HOH+bANjyjBp9MrRN7OUNV1ewRrIMGio+g/Tf/DOLhwvZI
         PB+GhIJDphjDaZuqpn22hXaBmGCS40LHmkeDf++fadbQKEB4Lm1ZThRAFZJ+fNZzwfdf
         93vctzbJugGNMwieJwQLlTtopgl6ADzfUyuFqLQOLHMQLJ6VTD3Ic7AM4RVNV0G0Poph
         VaaQ==
X-Gm-Message-State: AOAM532FWI3m8L0zTJL68FR4P82iJShc4BvBSZPUsfGp4aakTo8ZZ/Xy
        YlOGA7uionkxZvxLUPkxwMpi7ZUDbMOHbZGVIF8=
X-Google-Smtp-Source: ABdhPJzUKtVqoTURMIvGt/wtjNsdrTX42pOkbo6NYV/K+6YXQkmbh3wUuinmxAvR0u4XkEaN1KbnoPgiV3eCzhKThp4=
X-Received: by 2002:a05:6512:3a93:: with SMTP id q19mr17615388lfu.105.1638535066362;
 Fri, 03 Dec 2021 04:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20211025093418.20545-1-kevin3.tang@gmail.com> <20211025093418.20545-7-kevin3.tang@gmail.com>
 <20211203103841.vkl3sjsbaohsviou@houat>
In-Reply-To: <20211203103841.vkl3sjsbaohsviou@houat>
From:   Kevin Tang <kevin3.tang@gmail.com>
Date:   Fri, 3 Dec 2021 20:34:50 +0800
Message-ID: <CAFPSGXbWv94vShNAQ9xfkDZRKgZTdjRzH9i60ak1NYaPW-OKgA@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] drm/sprd: add Unisoc's drm mipi dsi&dphy driver
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     maarten.lankhorst@linux.intel.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, pony1.wu@gmail.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B412=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=BA=94 18:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Oct 25, 2021 at 05:34:18PM +0800, Kevin Tang wrote:
> > @@ -618,9 +619,25 @@ static void sprd_crtc_mode_set_nofb(struct drm_crt=
c *crtc)
> >  {
> >       struct sprd_dpu *dpu =3D to_sprd_crtc(crtc);
> >       struct drm_display_mode *mode =3D &crtc->state->adjusted_mode;
> > +     struct drm_encoder *encoder;
> > +     struct mipi_dsi_device *slave;
> > +     struct sprd_dsi *dsi;
> >
> >       drm_display_mode_to_videomode(mode, &dpu->ctx.vm);
> >
> > +     drm_for_each_encoder(encoder, crtc->dev) {
> > +             if (encoder->crtc !=3D crtc)
> > +                     continue;
>
> encoder->crtc is deprecated. You should be using
> encoder->drm_for_each_encoder_mask, using the encoder_mask in
> encoder->drm_crtc_state.

Use drm_for_each_encoder_mask to replace drm_for_each_encoder? like this:
drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask) {
    dsi =3D encoder_to_dsi(encoder);
    slave =3D dsi->slave;

    if (slave->mode_flags & MIPI_DSI_MODE_VIDEO)
        dpu->ctx.if_type =3D SPRD_DPU_IF_DPI;
    else
         dpu->ctx.if_type =3D SPRD_DPU_IF_EDPI;
}

>
> > +static int sprd_dsi_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct sprd_dsi *dsi;
> > +
> > +     dsi =3D devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
> > +     if (!dsi)
> > +             return -ENOMEM;
> > +
> > +     dev_set_drvdata(dev, dsi);
> > +
> > +     dsi->host.ops =3D &sprd_dsi_host_ops;
> > +     dsi->host.dev =3D dev;
> > +     mipi_dsi_host_register(&dsi->host);
> > +
> > +     return component_add(&pdev->dev, &dsi_component_ops);
>
> component_add must be run in the mipi_dsi_host.attach hook.
Got it, will be fixed on patch v8.
>
> Maxime
