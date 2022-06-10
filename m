Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18CA546DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347929AbiFJTzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350506AbiFJTzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:55:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B589AB4B5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:55:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h23so44326166ejj.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=un+lSY3X7YxGwu/r7FDzIT1K5N2rDGm8eR6DAEKLWI8=;
        b=DTlJwrChV2ZxnBi9qNxUeHN+3nWNEObwhsUb7nrqwBjXjLYiSjfFg+U9eGFcvcYlzq
         oNTo53JdL8b6SdBk9IPuQtHKcfbJ/6qqgYGbbFIBL6pirvKXwQnjv5ecGP93pZul8GOV
         obKLA5Vj2oTreta7PXAzkR5F854ZpZ34W/nLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=un+lSY3X7YxGwu/r7FDzIT1K5N2rDGm8eR6DAEKLWI8=;
        b=2mfLmZtQHctK71ZR1DK4+4z5SQ8+s10O12dB0FIwxRvyrGhuLk6R1sA+A7IfvnD2Kp
         dHHr9E8sCm7iJ3UfG/yR4+hxPTG8+Jn6MERKV9fCivvTiYcH7YxMfzUPnnPGS73kPUwP
         u6vhhiE+nK729j3NFguPZDmusgQzO3YG2tMu0emgCPHEkMGdU0YeFQ3dvMnOVAuzusor
         9XEfK1N2i61L+D994FzKUE4K8qUFDYbqPaheo9a2R4Zl4HSJsuWTFAE3UGDopuQimLPL
         xwL7Tm+3joOCkYP4AbXnVQc6uyT1vJ82znPrGWVpMea1Rl3YzYPumUccfaqOTOUS7i23
         4Lnw==
X-Gm-Message-State: AOAM530R7/NXYg2tmjST/Mjx+nY9YZeuFclq0mlq3wCuGBu6PaXAZiVc
        Xh6tAluNB5MKCRD+SxPUWEYoUr40uGWuSztL
X-Google-Smtp-Source: ABdhPJxsOk0sBS0nkg+CcJ+k8fK+3gVVB22bMHR1gcxyB3NG3bxXxpdFIAyUEh6VnJOk06WYVZJYcQ==
X-Received: by 2002:a17:906:6a23:b0:711:ea9b:89ba with SMTP id qw35-20020a1709066a2300b00711ea9b89bamr16350932ejc.740.1654890946956;
        Fri, 10 Jun 2022 12:55:46 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id r18-20020a1709064d1200b007121295f08csm2197913eju.219.2022.06.10.12.55.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 12:55:46 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id o16so4093849wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:55:45 -0700 (PDT)
X-Received: by 2002:a5d:68d2:0:b0:210:31cc:64a6 with SMTP id
 p18-20020a5d68d2000000b0021031cc64a6mr44505394wrw.679.1654890945353; Fri, 10
 Jun 2022 12:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220609072722.3488207-1-hsinyi@chromium.org> <20220609072722.3488207-9-hsinyi@chromium.org>
In-Reply-To: <20220609072722.3488207-9-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Jun 2022 12:55:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+9+a2EdkpvEneUfcCS=nr34+aGa_ZjvhidF_vfSiLzg@mail.gmail.com>
Message-ID: <CAD=FV=X+9+a2EdkpvEneUfcCS=nr34+aGa_ZjvhidF_vfSiLzg@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] drm: Config orientation property if panel provides it
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 9, 2022 at 12:28 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Panel orientation property should be set before drm_dev_register().
> Some drm driver calls drm_dev_register() in .bind(). However, most
> panels sets orientation property relatively late, mostly in .get_modes()
> callback, since this is when they are able to get the connector and
> binds the orientation property to it, though the value should be known
> when the panel is probed.
>
> In drm_bridge_connector_init(), if a bridge is a panel bridge, use it to
> set the connector's panel orientation property.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v6->v7: remove redundant check and fix config issue.
> ---
>  drivers/gpu/drm/bridge/panel.c         | 34 ++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_bridge_connector.c |  8 +++++-
>  include/drm/drm_bridge.h               | 14 +++++++++++
>  3 files changed, 55 insertions(+), 1 deletion(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
