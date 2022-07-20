Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4715257BF52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 22:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiGTUqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 16:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGTUqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:46:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE762A708
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:46:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bk26so27760797wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yual+k0S39VkU2OsIy3nk2KtEx0KbJ5iYiilefMKUWk=;
        b=YX6HSpa8BFZGx9SFYAxxWa4VQZ6IhL2rt2/qeAzyorvrTkpAKTZOzR82GpNU5EWI/G
         MIH4tZbmTXwIV0Fqygekyy98+JQfEqOpH83XBp5CDlejy5JZzgRIwugncB1fMyurEEkf
         ghaEhrrD0URXHoWoDEa25+VE9zL5N643hCPhm8ngQPnW4+lWD+ZUGkXRZWMWde9SHshD
         ICkzMLrXvzCp0Sly+wJMCF84wmFIWcV4UubIfh5z2wLKnjSCZezdUlZUvHMaFwKnQjLK
         g5Kb6SBTGnU+jBGJQN+7CU9JoYdR4E61x9orT4A957oUKd+SRGDvnOa2xXj8LQeBrfAg
         L8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yual+k0S39VkU2OsIy3nk2KtEx0KbJ5iYiilefMKUWk=;
        b=JmNoRiqAiCwKZaZSWE1w1sIUxv5zrN9EGpsc7iawf4VrgPl9+ENBjN6jx8xd+iW5tE
         ZkTgLCCfYq0ywqZIMBnLPDoUF12KGig+rwQAZzybaNzfC2WWrZc8uReGwaZ/ZvbHXEr+
         uyLq+pI020i0AJXyK7fxs/kouKHqbDdV/1MTB8VuvW7J0jSj7rqC1ysVU5b4JfhZOnu/
         aYn9SwCXtxRA4EG6C25kO1QNJAsKCODSqtqDSaX9k1PEL9l8CVRTLYd4ccDQ9SOCujvq
         F8E7F/18mRav9n+1X9p+/07Hs9OLdjhdW13ZM5x75/NK1uMuJaPmlDRq6HYj8SNr6TEF
         76rg==
X-Gm-Message-State: AJIora+wyO0OoyEy78f38DKQHvKkJ88C2eX6T7G3J4CPMphxZHPE/lkY
        q8vwpOQ4Wbg2tOSwgdItyYLMyGt+D6EG/T50daCVc7ev
X-Google-Smtp-Source: AGRyM1tc+GHmhBMH4z23k38O3VsoI83iv8iT9CVz2a5wXrMvi8H++V0L9SkFW/C/gj+OeExTpBds1T3N7UWHN154Owo=
X-Received: by 2002:adf:e187:0:b0:21d:64c6:74f0 with SMTP id
 az7-20020adfe187000000b0021d64c674f0mr31131852wrb.221.1658349990406; Wed, 20
 Jul 2022 13:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220706191442.1150634-1-swboyd@chromium.org> <CAD=FV=UrYCwm2ByN_5EN3fq-ayMJNjmWfJ5sooRy51ZiCoMcjA@mail.gmail.com>
In-Reply-To: <CAD=FV=UrYCwm2ByN_5EN3fq-ayMJNjmWfJ5sooRy51ZiCoMcjA@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 20 Jul 2022 13:46:52 -0700
Message-ID: <CAF6AEGt_J6f1T+-6KtyCrUJrY2fh7Sz10L1AV1FSe8hueGREtQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: Set panel orientation when directly connected
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 8:25 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Jul 6, 2022 at 12:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
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
> >  drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> I don't personally have objections to this, but (to my understanding)
> "the future" is that everyone should use panel_bridge. If we made the
> move to panel_bridge today then we wouldn't need to do this. In
> general I think panel_bridge would end up letting us delete a bunch of
> code...
>
> See commit 4e5763f03e10 ("drm/bridge: ti-sn65dsi86: Wrap panel with
> panel-bridge") for when this was done by ti-sn65dsi86.
>
> Then again, I spent a small amount of time looking into this and it's
> definitely non-trivial. Still likely worthwhile, but not worth
> blocking a tiny fix like this. It also should be fairly obvious that
> we should delete this when we switch to panel_bridge.
>
> Thus:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I'll assume that we'll just snooze this commit until drm-misc-next
> merges into a tree that msm-next is based on, which will probably be
> the next -rc1. If desired and Acked I could land this in
> drm-misc-next, but it's probably not worth it?

if you want to land this patch via drm-misc, which might be the
easier/faster route, then:

Acked-by: Rob Clark <robdclark@gmail.com>

BR,
-R
