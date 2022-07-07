Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6FF56AD5D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiGGVVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbiGGVVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:21:22 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921D832045
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 14:21:21 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id s128so10130298oie.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=XuQp9w2Vs1aOFFH2QgkEWHPslvL9Ld8qwnD4BupNY0w=;
        b=SXzFCD6PiakxSAJDlRX45oXMcaTKoAYue/mlyleZo0TLGj9D1x5FZiOFOc1bW5MMxm
         zMeQR1uETxWfCgYwRwvbM/aZQlHNFz3jwfNhmuBK0Tl46qx6avBJt0Vj5QJf9fSg63nT
         Laq+DqlvwhqfjZOD9GmtHldsC/NJuFdb8LnFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=XuQp9w2Vs1aOFFH2QgkEWHPslvL9Ld8qwnD4BupNY0w=;
        b=ufuwprg35wLJfxY5bp0xfpGpKR1/0JKF5RcktcznPrcxWr8dC3M4tXyt/aXSn9eRz/
         kwPxpDFv89rpYMt8f617rmHOyX5t/bYvgH6bbYO+BA2CCnow5hy6EBhGY9bvnNBujdM3
         9Mv+6LcIr6I+2W/6bHqPOLlRdMaB3WnXSfX4+8SddqO+h2g3UnkrPcJiVhf2r/wnG/QT
         IqyKQko1KyjTWdMRY/B0CnaUISV2HNLqsEUQk250KGW6QJqTgzcazTukHru9tMDs365X
         vKuErXFk+t/VjATcNlIWxOO3vqOLXS2aaY44xwD8TrYzKckp02BiyWnqcpFkmYFN6E3m
         RVeA==
X-Gm-Message-State: AJIora/QNgalle5MmF2Typve1qV6cfVOoX46jLqMcymnablpQ9zWbZJG
        Jml/SiCKcfkJI7y2K7aBPU6So+M0EFz+h+4wktj61Q==
X-Google-Smtp-Source: AGRyM1u86hlfujAKJCwkQGNNNhGQ5OK4EZsg7vgXL8Rcuq1ObSFJPCM5Km3thPxlp2kWX7YX6S9fOpbX+fbPsKGN5IA=
X-Received: by 2002:a05:6808:171c:b0:334:9342:63ef with SMTP id
 bc28-20020a056808171c00b00334934263efmr4885oib.63.1657228880881; Thu, 07 Jul
 2022 14:21:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Jul 2022 14:21:20 -0700
MIME-Version: 1.0
In-Reply-To: <40b6a28c-0237-55d7-2f5d-1c571f27e7d6@quicinc.com>
References: <20220706191442.1150634-1-swboyd@chromium.org> <40b6a28c-0237-55d7-2f5d-1c571f27e7d6@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 7 Jul 2022 14:21:20 -0700
Message-ID: <CAE-0n51KOMLP4XJHw2CPNikzfhY0xdjeCScYwvCZ7gAYJM+8Fw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: Set panel orientation when directly connected
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
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

Quoting Abhinav Kumar (2022-07-07 14:11:08)
>
>
> On 7/6/2022 12:14 PM, Stephen Boyd wrote:
> > Set the panel orientation in drm when the panel is directly connected,
> > i.e. we're not using an external bridge. The external bridge case is
> > already handled by the panel bridge code, so we only update the path we
> > take when the panel is directly connected/internal. This silences a
> > warning splat coming from __drm_mode_object_add() on Wormdingler boards.
> >
> > Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >
> > This relies on commit 5e41b01a7808 ("drm/panel: Add an API to allow drm
> > to set orientation from panel") which is in drm-misc
> >
> >   drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > index cb84d185d73a..9333f7095acd 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > @@ -268,6 +268,8 @@ static int msm_dsi_manager_panel_init(struct drm_connector *conn, u8 id)
> >               return PTR_ERR(panel);
> >       }
> >
> > +     drm_connector_set_orientation_from_panel(conn, panel);
> > +
>
> This should be moved below the !panel check since you are passing panel
> as one of the params.

drm_connector_set_orientation_from_panel() checks for a NULL panel
pointer and sets to UNKNOWN. If I moved this below the !panel check then
I'd have to split that condition for !IS_BONDED_DSI() which was more
diff.

>
> I looked up the doc and it says that for unknown(default cases) this is
> a no-op so I think this change is fine otherwise.
>
> "It is allowed to call this function with a panel_orientation of
> DRM_MODE_PANEL_ORIENTATION_UNKNOWN, in which case it is a no-op."

Ok, so you're fine with this patch?

>
>
> >       if (!panel || !IS_BONDED_DSI())
> >               goto out;
> >
> >
> > base-commit: 15b9ca1641f0c3cd74885280331e9172c62a125e
