Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1931D56BD7A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbiGHP0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238710AbiGHP0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:26:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464343134D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:26:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id os14so8040265ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgYORBt3h5oNBznarFeGPU7nreEFffTVmMqBLDJdiu4=;
        b=DtmFdPpzZsHOuwOoYohjvI7a3T6485xiQKNorp7om5YF58QOgdZIm+69XDuFDPu6eT
         G0VKI4aJemTOakYgNYfi5goKPkr/OciMNayYQVZC/wYVDtjj4SxaE/DpjQ7w7Sglpy6j
         S9t6UDJqFztUm1k/IXK8WjVFIKnnN4cdaWiLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgYORBt3h5oNBznarFeGPU7nreEFffTVmMqBLDJdiu4=;
        b=XuNrnjKlQFLVfkEalr3lTybXI+IiruMb++PadIiuRfo2b6kAEyf9ZbhNh/GH5SmOf9
         FCuAS2qhkgN26wW88Hg1naTl5FoeEkt9thM6b4MZfAsgvTw2K3brUT8v0oXuj3Iyp2Kx
         gUz72oJRqOwLccXdRHk6eiRkDfwaXp03rYhDtSqMfYp+JTjC8QT4JnuTW/lnwwODRPsB
         8D9l+eiAEkrambgLGlXHAncmGaiOdvP7V6aPHDj0DMLQocq91kccUBy187sqXpAiRq6r
         daNebhMBulcDIV3b/sEETvsULqY6ijvpBa4bua1BjIlzZnniQ7GH+PnsRsYaE3CZhiPe
         /LEw==
X-Gm-Message-State: AJIora85oOSzXuVLZ35oRx81+ydPhWrGntYMR/20EvDd0bhgTCclGIpc
        lDUVfTAb8+ti7tY55NpDgbulWosEMx0img==
X-Google-Smtp-Source: AGRyM1sU9is3dKxvj+CKy+nw/Wq6sKkXwLhe1cLYZ8gth1mLRTl4JRbXr7xNObZ8p94wjwzPwZNiGg==
X-Received: by 2002:a17:907:c14:b0:726:9118:3326 with SMTP id ga20-20020a1709070c1400b0072691183326mr4171126ejc.68.1657293959593;
        Fri, 08 Jul 2022 08:25:59 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id kz15-20020a17090777cf00b0072af4af2f45sm4294743ejc.199.2022.07.08.08.25.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 08:25:58 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id b26so31041903wrc.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 08:25:58 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr3937186wrr.617.1657293957904; Fri, 08
 Jul 2022 08:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220706191442.1150634-1-swboyd@chromium.org>
In-Reply-To: <20220706191442.1150634-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 8 Jul 2022 08:25:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UrYCwm2ByN_5EN3fq-ayMJNjmWfJ5sooRy51ZiCoMcjA@mail.gmail.com>
Message-ID: <CAD=FV=UrYCwm2ByN_5EN3fq-ayMJNjmWfJ5sooRy51ZiCoMcjA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: Set panel orientation when directly connected
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 6, 2022 at 12:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Set the panel orientation in drm when the panel is directly connected,
> i.e. we're not using an external bridge. The external bridge case is
> already handled by the panel bridge code, so we only update the path we
> take when the panel is directly connected/internal. This silences a
> warning splat coming from __drm_mode_object_add() on Wormdingler boards.
>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> This relies on commit 5e41b01a7808 ("drm/panel: Add an API to allow drm
> to set orientation from panel") which is in drm-misc
>
>  drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 ++
>  1 file changed, 2 insertions(+)

I don't personally have objections to this, but (to my understanding)
"the future" is that everyone should use panel_bridge. If we made the
move to panel_bridge today then we wouldn't need to do this. In
general I think panel_bridge would end up letting us delete a bunch of
code...

See commit 4e5763f03e10 ("drm/bridge: ti-sn65dsi86: Wrap panel with
panel-bridge") for when this was done by ti-sn65dsi86.

Then again, I spent a small amount of time looking into this and it's
definitely non-trivial. Still likely worthwhile, but not worth
blocking a tiny fix like this. It also should be fairly obvious that
we should delete this when we switch to panel_bridge.

Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll assume that we'll just snooze this commit until drm-misc-next
merges into a tree that msm-next is based on, which will probably be
the next -rc1. If desired and Acked I could land this in
drm-misc-next, but it's probably not worth it?
