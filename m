Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77082524097
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349037AbiEKXNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242847AbiEKXNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:13:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E02169E13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:13:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i19so6844602eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JgHIHZYfktFFhDix9ARk1W3agCJ5RlUjVdUHKQCQqAE=;
        b=gygLmm76slBdVa2keLfFJYY7zR9gVLTrQN7Qeoxr8clFf1VZSLKxHawplwV3c1cvML
         3F2nc0icCJFSso3TejBkbD4mveFcMg9/XBRM8VeOaUhHfU6oraKEtgeiiRmY9Y3d2Ofe
         0e16IW4wgnUJtqxOljWBH6MhiRPRrpKM9eB3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgHIHZYfktFFhDix9ARk1W3agCJ5RlUjVdUHKQCQqAE=;
        b=YyyoTw/Bo7MePvAxupO55w5rjyzPyx8scMwLolLHXqYg2f6PE3yQ7Q0ma8Dwc0hg5H
         EbnXnLZNWPxUd+a/qwtmhKuAwEE/Jnv4v3U7dixkwAKp9Cw6/XgRM2TciHDh0BgdVZ37
         LDSvQQ21LwKHdlnNnVGHTVFU0CCBf4ufCyRyuXocWzByCTbZgg53cAA3WoDulR00Q1HC
         m2p1hKAs6W14r8u1yvFiw8Q6UvaezF9cNatpaFj42L56Iy2Fj7vDQXAIA2/XLnLfttW5
         NFmnZFGZV8b2b/2W4pX32XImUFVUCdw1gll97POGVC5zf3cNCsUeJCU2jeHuwKK6pQyg
         7uYQ==
X-Gm-Message-State: AOAM5330tOqAVVjJMuSD9C7R/Ogfi/vgF1olgMsX5ILjz/byQm6pNal3
        /e0nk0ekyrSaRB7S3G4bPgcRkwkH3z9LjWOa
X-Google-Smtp-Source: ABdhPJzrMUo0ZNPGaAaIE35bg7lPphR/gTHrKK+rmMMVgld27lubMBLT6dW9jIykWhPGlb8+RzPmSg==
X-Received: by 2002:a17:906:c114:b0:6f5:db6f:71a1 with SMTP id do20-20020a170906c11400b006f5db6f71a1mr24057339ejc.338.1652310809911;
        Wed, 11 May 2022 16:13:29 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id p3-20020a50c943000000b00425d6c76494sm1749067edh.1.2022.05.11.16.13.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 16:13:28 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso4103880wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:13:28 -0700 (PDT)
X-Received: by 2002:a7b:c7c2:0:b0:394:18b:4220 with SMTP id
 z2-20020a7bc7c2000000b00394018b4220mr7173683wmk.118.1652310807772; Wed, 11
 May 2022 16:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160720.1.Ia196e35ad985059e77b038a41662faae9e26f411@changeid>
In-Reply-To: <20220511160720.1.Ia196e35ad985059e77b038a41662faae9e26f411@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 May 2022 16:13:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XA6GKjdvc1YNh7v0SHSMCzgBtx453AKPjxbWWkTW5N1Q@mail.gmail.com>
Message-ID: <CAD=FV=XA6GKjdvc1YNh7v0SHSMCzgBtx453AKPjxbWWkTW5N1Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "FROMGIT: drm/msm/dsi: move DSI host powerup to
 modeset time"
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matt Turner <msturner@google.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 11, 2022 at 4:07 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> This reverts commit c7e4a2a72e696aa6aed2c8b651279f491bb096fe.
>
> The patch causes sc7180 Chromebooks that use the parade-ps8640 bridge
> chip to fail to turn the display back on after it turns off.
>
> Let's revert to get these devices back to a working state. It seems
> like the DSI powerup problem is somewhat common and probably we should
> land something more general like Dave Stevenson's series [1] that
> would give more flexibility.
>
> [1] https://lore.kernel.org/r/cover.1646406653.git.dave.stevenson@raspberrypi.com
>
> Fixes: c7e4a2a72e69 ("FROMGIT: drm/msm/dsi: move DSI host powerup to modeset time")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/msm/dsi/dsi_manager.c | 43 ++++++++-------------------
>  1 file changed, 12 insertions(+), 31 deletions(-)

Well, that's embarrassing. I clearly reverted the wrong copy of this
patch. Sorry. v2 coming right up.
