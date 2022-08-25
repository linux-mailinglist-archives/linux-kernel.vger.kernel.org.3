Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7875A180B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242577AbiHYRhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiHYRg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:36:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D41B7742
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:36:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gb36so40900067ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MgkxpuDYNfRRBnVjGGx0IvVP/Y84NvnK9NI2soXdS2k=;
        b=XzKSN+zJd0x+L4aWMzauNurwUHFcSPiPCb1fGPFyN2vz+d/RoA+TjfrUTNw7mW7t/L
         8GEtg9rj7rAYC0VKF08igpQIBo5p3lYtT51A050uz6ZJOgzADOgKSyZI4hTiNusPnrJq
         klt0qWnCM70n39VrqtFAlGcV51De/6hBnxTdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MgkxpuDYNfRRBnVjGGx0IvVP/Y84NvnK9NI2soXdS2k=;
        b=z0ZHi2OVLlWVUThAdUWcj449fMF5LGs+aP9O0HsHMRi+1nvclVVFtsJOWi8TCWR85M
         AQl6ywfcijD4a4U9TPpg0DqQVKw8oFB6BZKrp2yNZmlOf/smzhbL7nCYZ+dsCAQ7o5mk
         sIbBv14ApL26h6Y3wp5JDfcU9BEqn0WYVZ+Ir6IUI3x5gES5tfbn/NG7dtogs4HakZW1
         PvYBYvBfIaU7JD9IsD/Stn3yxHfqim6o320iaTQGrjAZNZd1T63OuSoHR9VlC7ewb4jz
         //nIfq5UfqBnNc+uQykT/yWofjPBh8RBf7bfSD9c13BWfimpAHaPZFY9K0qTNjskEFDO
         bLfQ==
X-Gm-Message-State: ACgBeo3FC6UfvWJMQI+XvwFOSI8e1umYxgHpKBg1mZcWT7RSntNyrguP
        uV1B2MBpBW8SNpBVDescDU8Ta7fgR1AUniIW7y4=
X-Google-Smtp-Source: AA6agR5uUVp/qYTnLbwOOKOE1I/+QDJT4Wg8q/tth3XMERxuiajEz8RCeWhbdlWf3tjS5WAPyiVusA==
X-Received: by 2002:a17:906:cc55:b0:73d:c3c3:92c6 with SMTP id mm21-20020a170906cc5500b0073dc3c392c6mr3120993ejb.536.1661449016286;
        Thu, 25 Aug 2022 10:36:56 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id fb17-20020a1709073a1100b0072b32de7794sm2700005ejc.70.2022.08.25.10.36.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 10:36:54 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id a4so25554583wrq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:36:53 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr2914675wrr.583.1661449013445; Thu, 25
 Aug 2022 10:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220822180729.1.I8ac5abe3a4c1c6fd5c061686c6e883c22f69022c@changeid>
In-Reply-To: <20220822180729.1.I8ac5abe3a4c1c6fd5c061686c6e883c22f69022c@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Aug 2022 10:36:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W5X2XvvKT5tq+1ywJSmVB0TAHquGgn02uNmn4s-sqndg@mail.gmail.com>
Message-ID: <CAD=FV=W5X2XvvKT5tq+1ywJSmVB0TAHquGgn02uNmn4s-sqndg@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm: bridge: analogix/dp: add panel
 prepare/unprepare in suspend/resume time"
To:     Brian Norris <briannorris@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>, xuqiang36@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Zhang Zekun <zhangzekun11@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 22, 2022 at 6:08 PM Brian Norris <briannorris@chromium.org> wrote:
>
> This reverts commit 211f276ed3d96e964d2d1106a198c7f4a4b3f4c0.
>
> For quite some time, core DRM helpers already ensure that any relevant
> connectors/CRTCs/etc. are disabled, as well as their associated
> components (e.g., bridges) when suspending the system. Thus,
> analogix_dp_bridge_{enable,disable}() already get called, which in turn
> call drm_panel_{prepare,unprepare}(). This makes these drm_panel_*()
> calls redundant.
>
> Besides redundancy, there are a few problems with this handling:
>
> (1) drm_panel_{prepare,unprepare}() are *not* reference-counted APIs and
> are not in general designed to be handled by multiple callers --
> although some panel drivers have a coarse 'prepared' flag that mitigates
> some damage, at least. So at a minimum this is redundant and confusing,
> but in some cases, this could be actively harmful.
>
> (2) The error-handling is a bit non-standard. We ignored errors in
> suspend(), but handled errors in resume(). And recently, people noticed
> that the clk handling is unbalanced in error paths, and getting *that*
> right is not actually trivial, given the current way errors are mostly
> ignored.
>
> (3) In the particular way analogix_dp_{suspend,resume}() get used (e.g.,
> in rockchip_dp_*(), as a late/early callback), we don't necessarily have
> a proper PM relationship between the DP/bridge device and the panel
> device. So while the DP bridge gets resumed, the panel's parent device
> (e.g., platform_device) may still be suspended, and so any prepare()
> calls may fail.
>
> So remove the superfluous, possibly-harmful suspend()/resume() handling
> of panel state.
>
> Fixes: 211f276ed3d9 ("drm: bridge: analogix/dp: add panel prepare/unprepare in suspend/resume time")
> Link: https://lore.kernel.org/all/Yv2CPBD3Picg%2FgVe@google.com/
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 13 -------------
>  1 file changed, 13 deletions(-)

I thought it was strange that the patch being reverted had my
Tested-by, so I tracked that down at least. Looks like that's from:

https://lore.kernel.org/lkml/CAD=FV=XXESzA6n6MNEGH1Kbh7CeL8xWX8CifFLVf91+0JyFcJQ@mail.gmail.com/

...where I tested the whole stack of 17 patches together. That means
that my Tested-by was legit but it wasn't as if I tested that one
patch and confirmed that it was useful / needed.

Your argument here sounds right to me. The panel should get prepared
through the normal means (analogix_dp_bridge_pre_enable()) and
unprepared through normal means (analogix_dp_bridge_disable()). ...and
whenever the Analogix gets moved to "panel bridge" then that will move
to just being part of the bridge chain. Having these calls directly in
the suspend/resume seems weird/wrong.

So while I'm not an expert enough in the quirks of the Analogix DP
driver to say for certain that your revert won't cause any problems at
all, if problems come up they should probably be fixed in a way that
doesn't involve re-adding these direct calls to the suspend/resume
callbacks. Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Given that this is _not_ an area that I'm an expert in nor is it an
area where the consequences are super easy to analyze, I'm a little
hesitant to apply this to drm-misc-next myself. Ideally someone more
familiar with the driver would do it. However, if nobody steps up
after a few weeks and nobody has yelled about this patch, I'll apply
it.
