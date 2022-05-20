Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C095E52F476
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 22:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353484AbiETUfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 16:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbiETUfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 16:35:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B6518C040
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:35:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c10so12201066edr.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/W5Amkj7ZY4RSpu5Emv9DEEKFEY7HPKddkjE1BLIVo=;
        b=A97QoE/yONP/9WLQzD+5uujl9gs6LncY7kXoqdZTcS8CvSag2jhDf5peXlijQFFM89
         7xxU/K8CVotJr/JrPHhf3V1IVK5i6qclaIg2lVvyrBzNyCzxgCe5fp56nccGtG2ce6QZ
         by/Khy+qBy6khUe1wfEiGwRSeC3+QOAgMnb+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/W5Amkj7ZY4RSpu5Emv9DEEKFEY7HPKddkjE1BLIVo=;
        b=nK1/XCgfoUOaLqsXC/BXp+rC4sCVqSRYgbEQH3dCjVyLoweWnq4VBY3HtmJnr5+E5K
         iEhIh6dQlkyuhbYf+P+BZVFKE4Zg7+zZSswlAyMV7b6PPLnkmHzczZN8zaczMlwV2n+X
         4tpEPb1XI8IIAqgq3zOL8w/7pDZebUvRW4URMrW+K5V99gvw3zmvmhItJPv1uikG4vYM
         649bd18DbWCqgM78H/55tTejt9CueFhTTzuoQfGQPG06kiDHD8FVS1wKN2/5fNISjOqL
         BqWARzKSseeT/Voqxfugwkz3KoDRgB08ohhEZbeJmWvFxkVa7gT8e8bRLEbQm07xmImk
         FK3Q==
X-Gm-Message-State: AOAM531/u47XO+w4Fmb+TQEtLJM1XOWYh6heqZzphJQWXiwTBggbmTbJ
        6CiFRImAHrBmOnDQNKDE62+wrKPmT6orL1sFQNg=
X-Google-Smtp-Source: ABdhPJxYy1IM7KLJAS1a2Cki7ZVHkqKItl2L6YO7+pW1CqZq9qGAnKRU/k38VXPnSL/yc6qdP7C5Rg==
X-Received: by 2002:a05:6402:1cc1:b0:413:2b12:fc49 with SMTP id ds1-20020a0564021cc100b004132b12fc49mr12716045edb.118.1653078909328;
        Fri, 20 May 2022 13:35:09 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id hs33-20020a1709073ea100b006feb71acbb3sm515961ejc.105.2022.05.20.13.35.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 13:35:08 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso7479109wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:35:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3d8c:b0:394:6097:9994 with SMTP id
 bi12-20020a05600c3d8c00b0039460979994mr10021915wmb.29.1653078454242; Fri, 20
 May 2022 13:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220510192944.2408515-1-dianders@chromium.org> <20220510122726.v3.1.Ia91f4849adfc5eb9da1eb37ba79aa65fb3c95a0f@changeid>
In-Reply-To: <20220510122726.v3.1.Ia91f4849adfc5eb9da1eb37ba79aa65fb3c95a0f@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 May 2022 13:27:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ui8c4EY3Yc8JaXfkhho0HxEiOVbHfA=Szt3U-KGe-4HA@mail.gmail.com>
Message-ID: <CAD=FV=Ui8c4EY3Yc8JaXfkhho0HxEiOVbHfA=Szt3U-KGe-4HA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/dp: Export symbol / kerneldoc fixes for DP AUX bus
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Robert Foss <robert.foss@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 10, 2022 at 12:30 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> While working on the DP AUX bus code I found a few small things that
> should be fixed. Namely the non-devm version of
> of_dp_aux_populate_ep_devices() was missing an export. There was also
> an extra blank line in a kerneldoc and a kerneldoc that incorrectly
> documented a return value. Fix these.
>
> Fixes: aeb33699fc2c ("drm: Introduce the DP AUX bus")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> None of these seem critical, so my plan is to land this in
> drm-misc-next and not drm-misc-fixes. This will avoid merge conflicts
> with future patches.
>
> Changes in v3:
> - Patch ("drm/dp: Export symbol / kerneldoc fixes...") split for v3.
>
>  drivers/gpu/drm/display/drm_dp_aux_bus.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

I landed this one in drm-misc-next:

39c28cdfb719 drm/dp: Export symbol / kerneldoc fixes for DP AUX bus

I chose "drm-misc-next" instead of a "fixes" branch because:
* It's not super urgent.
* I'm still hoping to get review for the other patches in this series
and it would be nice to avoid the conflicts when landing.

-Doug





>
> diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> index dccf3e2ea323..552f949cff59 100644
> --- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
> +++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> @@ -66,7 +66,6 @@ static int dp_aux_ep_probe(struct device *dev)
>   * @dev: The device to remove.
>   *
>   * Calls through to the endpoint driver remove.
> - *
>   */
>  static void dp_aux_ep_remove(struct device *dev)
>  {
> @@ -120,8 +119,6 @@ ATTRIBUTE_GROUPS(dp_aux_ep_dev);
>  /**
>   * dp_aux_ep_dev_release() - Free memory for the dp_aux_ep device
>   * @dev: The device to free.
> - *
> - * Return: 0 if no error or negative error code.
>   */
>  static void dp_aux_ep_dev_release(struct device *dev)
>  {
> @@ -256,6 +253,7 @@ int of_dp_aux_populate_ep_devices(struct drm_dp_aux *aux)
>
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(of_dp_aux_populate_ep_devices);
>
>  static void of_dp_aux_depopulate_ep_devices_void(void *data)
>  {
> --
> 2.36.0.550.gb090851708-goog
>
