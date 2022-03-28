Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E0E4E9BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241321AbiC1QLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiC1QLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:11:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A60517CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:10:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m30so21129472wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lmxys5+Wm1X5K164q9rotePcIiSk9Jnpw6aPoksjE+E=;
        b=q7LjVQ60wDaxmmoVNtb1VxmBmp3QNIdbDpNKeKKXmwuDS5jsJ7c6eIxl7oZJHd/8m+
         g+6gr41IFG77dq2fTNBgv0wPw34ZFFldyAPdmkBinok4TPayBF30FzEb5rCB5BqgKErG
         ziF2Pm47Yz7R5npswNYveWZFnmOS73K8zup+OQX53F9zYndeEojpA9/eeOCfS61NEwda
         sVBjmDPMk94Z1Csds269tlIy0CcHiRRQ9EcFNlR6P1zewBE1q0lSemzU1vXBFCMnqJZh
         lEKQBroD3qKru+9vo0WRXsKXNFKVEwLvUiX5lQTo9GXM1hJvWnpeXoEOHnRy5mVSekn3
         qgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lmxys5+Wm1X5K164q9rotePcIiSk9Jnpw6aPoksjE+E=;
        b=plW+dqXnQTUiwT2tG9u7jf12191sAlfgTDqb4r16/isFRHll87hpNYbqPe/nikWjab
         YbDCjAkhgVdaiMth/3r08Em4Ew1Fy3G4+GthuZaP1rMTcb0jwzYkxBE8ErjNt872C9t3
         K0kpTpQHakU3SyNBnOOcr5P26iDFDE6aUmX9GQUHbdBDEzcYcHISHqs1NAw7W9Ks3wEZ
         KxvL3czMcoHuGD/xS/JtORR78oYq5K6RtEGGfKlfs2ojCDtRsy9S41w40FlTbgvwtD3K
         QkpcZo2b6x20Ckb9rjPBQmNOJXqoqdhtd+z2FZkcXwLmcgUq8Jlcz+9PGItl/RK5QTwR
         zsfQ==
X-Gm-Message-State: AOAM532sx2TlcXigSVfTxnSGN0rvBOOhg2E7KftTeHTagTCTLel9r3mP
        mD+6CorAEnIgoQzafeYmiy0=
X-Google-Smtp-Source: ABdhPJxbkE68MgSxDKzSZwONLoQMtBodDeWbFWAyDuRI/XDf2qLm+5nFhZNdxRTyj4xo6V9DrMjj2g==
X-Received: by 2002:a05:6000:1d8b:b0:203:df82:ff8d with SMTP id bk11-20020a0560001d8b00b00203df82ff8dmr25085878wrb.623.1648483806600;
        Mon, 28 Mar 2022 09:10:06 -0700 (PDT)
Received: from elementary ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id y13-20020adffa4d000000b00203e3ca2701sm17431178wrr.45.2022.03.28.09.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 09:10:06 -0700 (PDT)
Date:   Mon, 28 Mar 2022 18:10:04 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Liu Ying <victor.liu@oss.nxp.com>, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, p.zabel@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: nwl-dsi: switch to devm_drm_of_get_bridge
Message-ID: <20220328161004.GA9156@elementary>
References: <20220317175852.799432-1-jose.exposito89@gmail.com>
 <4bd97d512e95845d7dd5a44d7713c59832676ada.camel@oss.nxp.com>
 <CAG3jFysp1xas4eVcRh5rysbgrhLAEJvsfYjHU=gHDT_JECaEUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG3jFysp1xas4eVcRh5rysbgrhLAEJvsfYjHU=gHDT_JECaEUg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 03:24:05PM +0200, Robert Foss wrote:
> On Fri, 18 Mar 2022 at 10:25, Liu Ying <victor.liu@oss.nxp.com> wrote:
> >
> > On Thu, 2022-03-17 at 18:58 +0100, José Expósito wrote:
> > > The function "drm_of_find_panel_or_bridge" has been deprecated in
> > > favor of "devm_drm_of_get_bridge".
> > >
> > > Switch to the new function and reduce boilerplate.
> > >
> > > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > >
> > > ---
> > >
> > > v2: (Thanks to Liu Ying)
> > >
> > >  - Rebase on top of drm-misc-next
> > >  - Remove drm_of_panel_bridge_remove
> > > ---
> > >  drivers/gpu/drm/bridge/nwl-dsi.c | 23 ++++-------------------
> > >  1 file changed, 4 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c
> > > b/drivers/gpu/drm/bridge/nwl-dsi.c
> > > index e34fb09b90b9..de62e3fc6a59 100644
> > > --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> > > +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> > > @@ -912,19 +912,11 @@ static int nwl_dsi_bridge_attach(struct
> > > drm_bridge *bridge,
> > >  {
> > >       struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> > >       struct drm_bridge *panel_bridge;
> > > -     struct drm_panel *panel;
> > > -     int ret;
> > > -
> > > -     ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0,
> > > &panel,
> > > -                                       &panel_bridge);
> > > -     if (ret)
> > > -             return ret;
> > >
> > > -     if (panel) {
> > > -             panel_bridge = drm_panel_bridge_add(panel);
> > > -             if (IS_ERR(panel_bridge))
> > > -                     return PTR_ERR(panel_bridge);
> > > -     }
> > > +     panel_bridge = devm_drm_of_get_bridge(dsi->dev, dsi->dev-
> > > >of_node,
> > > +                                           1, 0);
> > > +     if (IS_ERR(panel_bridge))
> > > +             return PTR_ERR(panel_bridge);
> > >
> > >       if (!panel_bridge)
> > >               return -EPROBE_DEFER;
> >
> > I don't think panel_bridge can be NULL here, so this check can be
> > removed.  However, even if this patch is not applied, the check is not
> > necessary.  I think it can be removed with a separate patch.
> 
> José, do you mind clearing up if this check is needed, and then
> spinning a v3 removing this snippet if it is needed?
> 
> Rob.

Hi Robert,

I think that as Liu pointed out, the "panel_bridge" variable can not
be NULL. However, as I don't have access to the required hardware to
test it, I'd prefer to keep the patch as it is, i.e., a refactor that
does not change the previous behaviour, rather than introducing an
untested change.

Jose
