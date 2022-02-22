Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743DC4C04D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbiBVWpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiBVWpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:45:32 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6591285BF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:45:06 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id b35so16561696ybi.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HadLybndSc4+83udfaFf6CPAEtJp2NdGL5J7rhdH6QI=;
        b=g2WRHS6wQdK3tXYzDPeyJLqMhw6ManzjpWTA2X6HQ5WyjR9VzujGnKgB5uu+Qx64Se
         rGHymFc5xxmNZIxevQ1UjDdKf417WYtyEyIyyrt+yjkW3nROZawRFM5w6y3dhHVSLFZR
         B3qHayA6j2OzWyupaCIRb+PS9IBuXmvGkaU2g7EqNQdRuQksvwISiD8FeTU9OHrqiLvw
         0WwtVy82DYJyIKtOj96IOVeOShNshiagT2cIwOEPcwi6G+wg5hxgfTBZz1B77Rc4uqMs
         zc6wCQ77J+u6w3qDB1pXCwAStZvr8qqj1oJvXat9Oc8asioowCLaPKKigK8K8pofIuZP
         t2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HadLybndSc4+83udfaFf6CPAEtJp2NdGL5J7rhdH6QI=;
        b=nUr5Q6i7vYRxH65eYAybieWWLNxcG1RKPukbwobiXPJfud2TOBaHBCSXiwejCla175
         xkUX/0C0sZl2LZ65a1C+juq32FED1h9IMMrEAnXsLRfLJ4LYxOixAUNKyyWyDHH2wBda
         I2xv9GKW6CzXxKM2QikmQjOhLv25nIr8IjWbynMpRpULEZ+Zio85773HnHos9K9s3cpE
         /ZInIJK6pbepikkYd2py2rF0Sy7jaNvk6YvrXt8QQM/i/e0k+yTDvI/UE8y+mwI7iPhi
         QdgukmSQxVjoXActBlLLK831ItLOreUJaEXiiY393vFoIkZQehrMKCuhYG5XvGBrwyE/
         0pNg==
X-Gm-Message-State: AOAM532QC+OJzjS0Os9nNpaFl7YZl7D6G88inZjQ9oycxP7zr6MK3hwS
        WIWtUAX+u2O01OFJhtZ/l+z8xf7cvLtLKSfxLzhdGQ==
X-Google-Smtp-Source: ABdhPJwXhQzLFapXj6GO5ms7h/KJI9VTpfh/O4OclZgrb8LhtsEGl7isKasno4HU0SgGHd/4gJMddJRV2PFl9WlJTz8=
X-Received: by 2002:a25:9108:0:b0:61e:329:700 with SMTP id v8-20020a259108000000b0061e03290700mr24730620ybl.369.1645569906080;
 Tue, 22 Feb 2022 14:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20220222141838.1.If784ba19e875e8ded4ec4931601ce6d255845245@changeid>
In-Reply-To: <20220222141838.1.If784ba19e875e8ded4ec4931601ce6d255845245@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Feb 2022 23:44:54 +0100
Message-ID: <CACRpkdbQ9U22afR74YiZs95qCm7dnLb2k4_nT3Le__hJPpDGUw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Properly undo autosuspend
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Brian Norris <briannorris@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 11:19 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> The PM Runtime docs say:
>   Drivers in ->remove() callback should undo the runtime PM changes done
>   in ->probe(). Usually this means calling pm_runtime_disable(),
>   pm_runtime_dont_use_autosuspend() etc.
>
> We weren't doing that for autosuspend. Let's do it.
>
> Fixes: 9bede63127c6 ("drm/bridge: ti-sn65dsi86: Use pm_runtime autosuspend")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Hm. I know a few places in drivers where I don't do this :/
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
