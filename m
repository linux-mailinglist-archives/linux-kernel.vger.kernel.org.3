Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9683A4D553E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243342AbiCJXXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344275AbiCJXW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:22:56 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A46BC42BD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:21:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x5so8888230edd.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PRoRNGVXeBqETfXyFZpgopVazVuZfI/uR73/ovgOFQY=;
        b=L+XUhuaJEipGfKdRYP0YvnmyWyW5lJGOgrzwPa/o+u54QQq4AWVLuHZIvZC0accbpV
         /aSkWVCNDX5cWh2Oc/bP8q8fVsVfvhNyxEAA0ntZB5Npfw7O7eGWb8juxgdRF+bhNvrz
         4Qyf1P6BcBPB2zHBxj/u0XbE8pSOhuWI0rq/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PRoRNGVXeBqETfXyFZpgopVazVuZfI/uR73/ovgOFQY=;
        b=fg3uDPhWO/f1BkLelCcpUkPrjBQiZqyqcq3+5tsp+FlcYpVhe9YzC+caWmsbfk+N+v
         G3bL2NPkflLHzfim5qg8kUHrqBtGettdl+ZgRM/kaCAItIchX9WCgGLOpRN4RmL7iYe8
         H4OzwqmGcmJTxvK80L1ZpimyPceR/B8RKFQUJEDfbz8wsFLUgJzAqdRfZoIJbj/UMZun
         K6jYEuxZ0ts9wwFnMjXQHyvtwBsXP7QuBNPIy4r8of47TTRpxnrDB5mHt3wDd/XUMQOL
         asTWjB+HwaPfBP6SBl42V1di5lZkbfQhWfuOhgSDat9fiRWUPnIyUtP969iTi2VsAiNI
         hIhQ==
X-Gm-Message-State: AOAM532+1TvnoX6tW+r5rly7ZYgbKZuMr+1sw0zQAeLMUcYq/qwnF0yF
        x6tnxKMXjF5Mg6LYUtJI9zp7+arTLJbnqip2deE=
X-Google-Smtp-Source: ABdhPJxwX1M9majm/JPJ69z4mzk6rl1PLxlUkIn3loQDkhrWpho3d/FQTOzsuBr2wRoZLxIT0UDAeg==
X-Received: by 2002:a50:d097:0:b0:415:cec5:3b31 with SMTP id v23-20020a50d097000000b00415cec53b31mr6558695edd.377.1646954512616;
        Thu, 10 Mar 2022 15:21:52 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id l5-20020a170906644500b006ce6b73ffd2sm2299480ejn.84.2022.03.10.15.21.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 15:21:52 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so4394098wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:21:51 -0800 (PST)
X-Received: by 2002:a7b:c042:0:b0:389:7336:158b with SMTP id
 u2-20020a7bc042000000b003897336158bmr5478597wmc.15.1646954511190; Thu, 10 Mar
 2022 15:21:51 -0800 (PST)
MIME-Version: 1.0
References: <20220310152227.2122960-1-kieran.bingham+renesas@ideasonboard.com>
In-Reply-To: <20220310152227.2122960-1-kieran.bingham+renesas@ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Mar 2022 15:21:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U3fLvixpJfGxzmJd89+yVEDgbNYPsfJtq92QObUxw=3A@mail.gmail.com>
Message-ID: <CAD=FV=U3fLvixpJfGxzmJd89+yVEDgbNYPsfJtq92QObUxw=3A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] drm/bridge: ti-sn65dsi86: Support non-eDP
 DisplayPort connectors
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 10, 2022 at 7:22 AM Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
>
> Implement support for non eDP connectors on the TI-SN65DSI86 bridge, and
> provide IRQ based hotplug detect to identify when the connector is
> present.
>
> no-hpd is extended to be the default behaviour for non DisplayPort
> connectors.
>
> This series is based upon Sam Ravnborgs and Rob Clarks series [0] to
> support DRM_BRIDGE_STATE_OPS and NO_CONNECTOR support on the SN65DSI86,
> however some extra modifications have been made on the top of Sam's
> series to fix compile breakage and the NO_CONNECTOR support.

This confused me a little bit. As far as I know Rob's series is
abandoned and he's not working on it. I assume that Sam will
eventually re-post his series, but it had unsolved problems and the
bpp solution he had totally didn't work because nobody was setting
"output_bus_cfg.format" [1]. Did you solve that? ...or you're just
going to let your patches sit there and hope that Sam will solve the
problem and re-post his series?

I'll admit I didn't go through your git tree to figure out if you
solved it some way. If you did, I would have assumed you'd have
re-posted his patches in your series w/ the solution...

[1] https://lore.kernel.org/r/CAD=FV=WW6HWLOD9AzTpjwva9UHY=AR+LABEWqJQznz6Nbb4sOw@mail.gmail.com/

-Doug
