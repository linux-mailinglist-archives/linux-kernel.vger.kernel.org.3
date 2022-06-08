Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3768C543E46
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiFHVKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbiFHVKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:10:12 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2227423A3D8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:10:12 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q11so14330483oih.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 14:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=2AFwAFesfJ4813UotVRGN6T66bp496uOfNq86ymBnjA=;
        b=Gu0/kTCh4WF7PyZCMnOHmzT3iAFEwlVhUJhGNoJdNbZE6+tFQJicbmp10gzqauCk3y
         uHU+cJKTumIz0V8SpZCt5rBDD67LC2pT0/sLmt2RrKXKqacIOnXxceFW5JJq6XwxD/w7
         ue3hBYKlmbApXuK/gPZqvA1rLO8yj8JGgGeOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=2AFwAFesfJ4813UotVRGN6T66bp496uOfNq86ymBnjA=;
        b=i0lJjAjMci9msvwj9jsIdNvVUdqI/770VLMvnOg81bLgTevVLBe8+19p/EwgnPrVEk
         wPBgsvM/asPuzhfA77kqwMjsSlJRUsnUYJ7PZqmA9gGEBs6qv5kthEjCHJo8Lc43+66h
         vegvpYccS5v7TtOGtRG2QPAVWwRMsdZd9QUnlxRzo9cl2mLCg66QsZ49qi7PXShkg4tG
         lS3qki/X0+uAL8zLxP3TT38/m4jfDSXA8LupO46vCaKA7eRL04/8uRbkGU5xoLt/CIbg
         qvj6m0cCxL5xyk+RAoHWrq0wQPEg5KNAaUm+0eI8DdoazVVnr8C7tin+HUoPkXSP05CO
         yeAw==
X-Gm-Message-State: AOAM5336lnTReAEmvVsUYx1v2DQ2TN7rUP2KGhtWmZ7Tc2Iew/lKWWXp
        7f2ZR/6DNXB6Zm3en7+YAvFegvYYlexDR+8mqJIWcg==
X-Google-Smtp-Source: ABdhPJxKEq+tHe/ctYG0XvwejZ/+4vC0XmkKWJtg4R6rUo3ggfFWaBqCfsX9oHlenFRTIHyh+lWXxP75QwiRkBs4cLA=
X-Received: by 2002:a05:6808:1703:b0:32e:851e:7f81 with SMTP id
 bc3-20020a056808170300b0032e851e7f81mr3590005oib.63.1654722611424; Wed, 08
 Jun 2022 14:10:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jun 2022 14:10:11 -0700
MIME-Version: 1.0
In-Reply-To: <20220608094816.2898692-3-hsinyi@chromium.org>
References: <20220608094816.2898692-1-hsinyi@chromium.org> <20220608094816.2898692-3-hsinyi@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 8 Jun 2022 14:10:10 -0700
Message-ID: <CAE-0n533NL8j2Fy8pe0yY4hdvF5pxxj8i9v=csqXx+S-1hM53w@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] drm/panel: boe-tv101wum-nl6: Implement
 .get_orientation callback
To:     Douglas Anderson <dianders@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
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

Quoting Hsin-Yi Wang (2022-06-08 02:48:10)
> To return the orientation property to drm/kms driver.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
