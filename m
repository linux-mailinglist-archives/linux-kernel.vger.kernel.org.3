Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD58D53EE50
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiFFTGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiFFTGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:06:31 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF7410544
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:06:30 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-f2e0a41009so20297998fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=6MJn5zOFXH+nWMLAd2/1FRGMn9RFPXr7yGq/vNuS/UQ=;
        b=RrDmHLneHhzEqgs+avpAIqmSmppTbvcPYikg5GtlhI4zj6YLM5PeQdvjIKm2LPaPVk
         siI6Gc87siSylXHmHcyi1wSxGVzUSl5n1RmgILW+hi2JodCl4iV/B+ESsfafQBHWTdL1
         2phByD2xPheRa7+S+FDGacySTsKu0YaYz1B5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=6MJn5zOFXH+nWMLAd2/1FRGMn9RFPXr7yGq/vNuS/UQ=;
        b=Q75bAKybxZTM5qgx4ui7cvYYhEc2nhuysLEvqD8sFq32w2Hh8zSHuvwebNK0ez/Bhv
         CY96pdCULs3niXSn2b7UROU3HZNVIG1E9nEoMEfu10b4EXjH99KrDL1jPxSXu/+2ju39
         nfFMxUGekXhE97smOhPYhQWkvERPTIDHmy7KxLLDqsjC6fqvKDCsAeWhvoaOXwU9GAsS
         fqUVoLo67iW8SxgspfEkkVEFjTVssZSD3QPbxDHSUVr2RFDCbVBv+qkMpxIW2gsHuxnT
         /0cJnYIyAtSrZbFsdYDGYHHScDlNAk9IF0+6qPfmY+fq/KTUS0DS2bAT5cLejTcu3wAW
         9IHQ==
X-Gm-Message-State: AOAM531mtByzaJXXgOHZqpN//PSfgQ+9EkgqAOFnySlrZTODfNcbMYSi
        xTHoBTXezXWRuVgf9Dwgyk6br0veCF1R/E8WDm/MdA==
X-Google-Smtp-Source: ABdhPJwZghG/x2b/qz0erem1Frm0KKmZ2Jh/gPhQA7lPaNFJWoTR0HNboBvnJkV/j1y3j4iPrsscIBz2ag23cFHg/Io=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr14654864oao.63.1654542390129; Mon, 06
 Jun 2022 12:06:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jun 2022 12:06:29 -0700
MIME-Version: 1.0
In-Reply-To: <20220606152431.1889185-2-hsinyi@chromium.org>
References: <20220606152431.1889185-1-hsinyi@chromium.org> <20220606152431.1889185-2-hsinyi@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 6 Jun 2022 12:06:29 -0700
Message-ID: <CAE-0n52mzczUdtwUgfdNOC_V7kBGhzFWHRT=QHDoH4kN+yCMGA@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] drm/panel: Add an API drm_panel_get_orientation()
 to return panel orientation
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hsin-Yi Wang (2022-06-06 08:24:24)
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index f634371c717a..e12056cfeca8 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -223,6 +223,15 @@ int drm_panel_get_modes(struct drm_panel *panel,
>  }
>  EXPORT_SYMBOL(drm_panel_get_modes);
>
> +enum drm_panel_orientation drm_panel_get_orientation(struct drm_panel *panel)

Should 'panel' be marked const to indicate that it can't be modified?

> +{
> +       if (panel && panel->funcs && panel->funcs->get_orientation)
> +               return panel->funcs->get_orientation(panel);
