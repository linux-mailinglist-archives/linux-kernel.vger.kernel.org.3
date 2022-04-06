Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA354F6871
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiDFRsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239925AbiDFRrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:47:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A040A10BD22;
        Wed,  6 Apr 2022 09:23:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k23so4017714wrd.8;
        Wed, 06 Apr 2022 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J9a2BqBVokvTsgXQbtymYfO3sWscM/hLjb0STJ5+gfo=;
        b=ZLBha3ufL0jqhFoZzUzSgpHsnHd6DM/HSKIHl7RHPuuFY1C1cWUqC0PfmMqS7DfunJ
         Dky80ByJLgonPzNihsl2DXLyMlG2HbrxCQsQtCbp92JDX62+0uWXZ/XEN2OUXX5L8okT
         l+3ZdiwM34ISMZtglwh0Nr/0cU6YMcyjlAOt1fK307cGVY5BMZwtRE/R3iw6kGLLhlYm
         qSxsiaAwSPmtRYrHmrhSi3H7OUENgEptGKC9vdm2kyX8NrGkbQIIS+4IwvDduTDGpdoQ
         DigItKzsvp5rE9c8Y9TXEe0Y/CHcbfPrSzNP3deLbKRmbTIW88KJDJJTXX10Ss517V8d
         iw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9a2BqBVokvTsgXQbtymYfO3sWscM/hLjb0STJ5+gfo=;
        b=oBf/ACoukip41uS6lNYXOo2BPEWFvaLxYi0r2SAWFWgJtVE9YbQXNzYwPqR5ecavcD
         QgU146s6OLuZnEvHVrtszRhdsS4XtWICHGGnq9nJ0/ViHaaVflF1eYdXshEpyBieBJyo
         RIrIFs1AVmNSlvZXdzAjln/Rub23WudyG6WPVHh29dtdBcIMd8fJtlrdCT1zv/WWKXcH
         mAVHHlAou3G2Ks/vQSyanqvQcHQp1MopJGySOAKziKFchDPFeNea5P4cHuKXFd6RlBN1
         I0gaRBOcqk/+q/g4zinXn05YuUzhZfCWg8Ad2v+38lCBTwioYkdnV1Y0JQNcY3K5z9b0
         dFRw==
X-Gm-Message-State: AOAM533U5SsHMG7mi2ODs8/YJXkkw55LbUjJDAcz7GOsJ/P5nn1F0kT+
        Wbo4QlUraTQ5T/kW4+qptw2/M1gC2+xNbukimhpHVi1Y
X-Google-Smtp-Source: ABdhPJxXoRbU0Fimgs0YJrKVL8vfK3EP/15SjU89Ap7jwE5IFgghAQow9fzCF+kzSvUWRMEQeGazbnjQquNqIPBJoxo=
X-Received: by 2002:adf:9111:0:b0:206:c9b:ce0d with SMTP id
 j17-20020adf9111000000b002060c9bce0dmr7345582wrj.418.1649262207917; Wed, 06
 Apr 2022 09:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_F71D40EE9851737338A6289EC3A3942EFE09@qq.com>
In-Reply-To: <tencent_F71D40EE9851737338A6289EC3A3942EFE09@qq.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 6 Apr 2022 09:24:22 -0700
Message-ID: <CAF6AEGu+Sg79Sn=t=-3b9ZbDanN7KeSzUX+-rchd8SY+b+sUsg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/mdp5: check the return of kzalloc()
To:     xkernel.wang@foxmail.com
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Mar 24, 2022 at 1:37 AM <xkernel.wang@foxmail.com> wrote:
>
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to check it to
> prevent potential wrong memory access.
>
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> index c6b69af..5f914cc 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> @@ -90,15 +90,18 @@ static void mdp5_plane_reset(struct drm_plane *plane)
>                 __drm_atomic_helper_plane_destroy_state(plane->state);
>
>         kfree(to_mdp5_plane_state(plane->state));
> -       mdp5_state = kzalloc(sizeof(*mdp5_state), GFP_KERNEL);
> +       plane->state = NULL;

At this point, you could just:

    if (!mdp5_state)
       return;

BR,
-R

>
> -       if (plane->type == DRM_PLANE_TYPE_PRIMARY)
> -               mdp5_state->base.zpos = STAGE_BASE;
> -       else
> -               mdp5_state->base.zpos = STAGE0 + drm_plane_index(plane);
> -       mdp5_state->base.normalized_zpos = mdp5_state->base.zpos;
> +       mdp5_state = kzalloc(sizeof(*mdp5_state), GFP_KERNEL);
> +       if (mdp5_state) {
> +               if (plane->type == DRM_PLANE_TYPE_PRIMARY)
> +                       mdp5_state->base.zpos = STAGE_BASE;
> +               else
> +                       mdp5_state->base.zpos = STAGE0 + drm_plane_index(plane);
> +               mdp5_state->base.normalized_zpos = mdp5_state->base.zpos;
>
> -       __drm_atomic_helper_plane_reset(plane, &mdp5_state->base);
> +               __drm_atomic_helper_plane_reset(plane, &mdp5_state->base);
> +       }
>  }
>
>  static struct drm_plane_state *
> --
