Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C8954CC04
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244812AbiFOO7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242891AbiFOO7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:59:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3489C101C9;
        Wed, 15 Jun 2022 07:59:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id i81-20020a1c3b54000000b0039c76434147so1312622wma.1;
        Wed, 15 Jun 2022 07:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fopigGhBHUvToQDW8C96mevEAHmyd9RwH6T3VHGQno=;
        b=aMm4UMWGVLS0PAt7bgDYcLdhm/CszdAgtdVdM0VB45miYsgwGwV09ga2eYkF4zV8yE
         kUtl2fvYUcU7gIGTYYEkTyc6kdkn+RFFKlGwxZoASle2G2i0bcCNksb6K0Kc73gmP5qU
         G1J8w5fZywh60Dj2gtTk22jbwzc1IhxKa5YXcVEdViPzZrOrJYAJu3ojR7mrJWPmlND2
         2Z8qcYC60RFp6XpiM4BGr+2XVXKD1E7lHXhSAFHKx9eHClHe+2Un2u1GC2EzxzP1SIz4
         Vw0e6Y3MBvEM+wL9S7jigJAfH3hZYTDU/M5Ys9NHbpq1jLpR21o0Agibudjy8rVbRB5P
         ttjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fopigGhBHUvToQDW8C96mevEAHmyd9RwH6T3VHGQno=;
        b=AuNE7RmAzoU8Lw+WUN2rGqFLnHOvONFIQ2Cby88ZMTKvVn9z14s8EYUAK9LuPi5/Qj
         LoPMCNyQ2PTKJbdkfKWOhi3t99N5EZWYhSQxSDhEUOTfcdp7WAg0D8yLJjB8DzE+coVr
         j1jEzKq9cFbuQ6/mfXIibWlZPLVoK/FQK40VqFmeO+0OLPwOUJ9QOGQEIPmAo9clhZ+c
         tl/eokvq6ybwo1C/EBSYojqpBpGuSk+qS/5LhO9zqsB57x6cg+LCyZT/TJzWvMnsoMaK
         NHdSiPNUuqo+5guizgwWZ9YyUa2lcDfuJLp6nEAxNZglHZVrEY7XnwZgyZqr8k8nlmJs
         I5yQ==
X-Gm-Message-State: AOAM53083Y9txYq3TusVOlK3nRpV1jublYyEmSZuvjx1w+RvjrQLciG4
        Rj0R8PhT/hNue8/sgi1bc+0uE5GiAq8EwlJxG80=
X-Google-Smtp-Source: ABdhPJwOdzB0phMq92UxkYkA4A0DK81tSFVTV8Pe3y2MmItWnkJUarOsTTIAMYPDNE2/mS2V7lGTfJqzy/ONnv84lkk=
X-Received: by 2002:a05:600c:4f96:b0:39c:951e:66b7 with SMTP id
 n22-20020a05600c4f9600b0039c951e66b7mr10636359wmq.84.1655305179680; Wed, 15
 Jun 2022 07:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220610172055.2337977-1-robdclark@gmail.com> <42e52572-726b-d94d-6523-7b42dbeecff1@kali.org>
In-Reply-To: <42e52572-726b-d94d-6523-7b42dbeecff1@kali.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 15 Jun 2022 07:59:44 -0700
Message-ID: <CAF6AEGuTw3fMaNbvkt9z3EWqjND2R3nrRu+PP=GVQjx+TW0N9w@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gem: Drop early returns in close/purge vma
To:     Steev Klimaszewski <steev@kali.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 11:16 AM Steev Klimaszewski <steev@kali.org> wrote:
>
> Hi Rob,
>
> On 6/10/22 12:20 PM, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Keep the warn, but drop the early return.  If we do manage to hit this
> > sort of issue, skipping the cleanup just makes things worse (dangling
> > drm_mm_nodes when the msm_gem_vma is freed, etc).  Whereas the worst
> > that happens if we tear down a mapping the GPU is accessing is that we
> > get GPU iova faults, but otherwise the world keeps spinning.
> >

forgot this initially:

Reported-by: Steev Klimaszewski <steev@kali.org>

> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/msm_gem_vma.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
> > index 3c1dc9241831..c471aebcdbab 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> > @@ -62,8 +62,7 @@ void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
> >       unsigned size = vma->node.size;
> >
> >       /* Print a message if we try to purge a vma in use */
> > -     if (GEM_WARN_ON(msm_gem_vma_inuse(vma)))
> > -             return;
> > +     GEM_WARN_ON(msm_gem_vma_inuse(vma));
> >
> >       /* Don't do anything if the memory isn't mapped */
> >       if (!vma->mapped)
> > @@ -128,8 +127,7 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
> >   void msm_gem_close_vma(struct msm_gem_address_space *aspace,
> >               struct msm_gem_vma *vma)
> >   {
> > -     if (GEM_WARN_ON(msm_gem_vma_inuse(vma) || vma->mapped))
> > -             return;
> > +     GEM_WARN_ON(msm_gem_vma_inuse(vma) || vma->mapped);
> >
> >       spin_lock(&aspace->lock);
> >       if (vma->iova)
>
> I've seen the splat on the Lenovo Yoga C630 here, and have tested this
> patch, and as described, the splat still happens, but the system is
> still able to be used.
>
> Tested-by: Steev Klimaszewski <steev@kali.org>
>
