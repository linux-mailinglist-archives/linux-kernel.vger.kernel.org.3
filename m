Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1983522331
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348452AbiEJR6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242543AbiEJR6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:58:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560141D500E;
        Tue, 10 May 2022 10:54:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j15so24902327wrb.2;
        Tue, 10 May 2022 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9zGmm9uit0zU6DRJerw26Jq0jZ7fbTCvayuVnamTbg=;
        b=Yy56CxtjPXYg0OVqf6X+qbPbT81jQgPw0Bo9lYjbafxEM0GPl8owz74yPGYsHVy/4L
         Gp2FKcVpj6+54s7NcdQj3HhhNxWupuMqiC3M+HZcj6TQAsfRFp3YgjHBLSSBUqRWxYGQ
         OfFOv+hWuou1r7N+3HzB0KMqWgiVtntbDVorpxvP2LxZIWSCmHn6aZ+q/TKdu+PWb5Bw
         +vIq3IHQYrWiwpCDLPgnAwUN0rB1Gyw2XBJ9K5MJI77xaKskv2nohg48uj5htIJt7+vt
         XDTtR61ElJpvRPSsWvkUoednS5E/jXIE94UEjtVzAgCUyFuHa2a+4peYMe4Y5SiUvAEM
         f/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9zGmm9uit0zU6DRJerw26Jq0jZ7fbTCvayuVnamTbg=;
        b=S74qQqlk+nyAsl0DzXl+gktWKE2liLR7yxCBkBMlIrtFxx7EQvemaf0FNxRMm30xkG
         FgAG6j7EBesZHSdM8z9CG8wcUbu0yaOH7yfno5fokYBCl8v5084KQdaBkZpLn/5odbau
         JgwR9hhcRfYDbnx8nfty3X+HG0owwTH695b8UL0p2WJJm2IeEfNR38/nPB7a2MJ5Qa+v
         ZPKLn2JnEeZMJGbpB4PBYF2KtqJwUUQkMtUC/3QyKl22ixT1D3kEFaLVOoPaYDh2We/9
         czcfoMA0+2HztrVcQCfZa8TByxfX7p++BW7xzockwQu5SnK86Ls5c9FzlABHSAP3Xn0j
         k2tA==
X-Gm-Message-State: AOAM533552iYfuf9gWlfJD4pB+GXP9HMP969pDxeH56d8FNBQg6bTSy9
        McYrIyJl9210Xdi4pNWXiMPaijSZBXcmHLCS+vF63v6h4mk=
X-Google-Smtp-Source: ABdhPJxUOj0D4hmSiqlmpJsW55ag4yXAlIoU7BblU23/sAk+uYQv/CO0zFq4PTamntycgRV1qG5ks3rn8oHADeqwqFY=
X-Received: by 2002:a05:6000:1a87:b0:20c:687f:6d10 with SMTP id
 f7-20020a0560001a8700b0020c687f6d10mr19038895wry.574.1652205272712; Tue, 10
 May 2022 10:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220510165216.3577068-1-robdclark@gmail.com> <CAA8EJprS_Jk_Wowz-nK1nnYF1UUb-4SYUPhsF_qB4rL4GUPygA@mail.gmail.com>
In-Reply-To: <CAA8EJprS_Jk_Wowz-nK1nnYF1UUb-4SYUPhsF_qB4rL4GUPygA@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 10 May 2022 10:54:20 -0700
Message-ID: <CAF6AEGsFsCDQgaoSroqQFGS7c8=O-vVA2LxwkpWW1wUU+HF1tg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix fb plane offset calculation
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
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

On Tue, May 10, 2022 at 10:46 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 10 May 2022 at 19:52, Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The offset got dropped by accident.
> >
> > Fixes: d413e6f97134 ("drm/msm: Drop msm_gem_iova()")
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> > ---
> >  drivers/gpu/drm/msm/msm_fb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
> > index 362775ae50af..4269da268a4a 100644
> > --- a/drivers/gpu/drm/msm/msm_fb.c
> > +++ b/drivers/gpu/drm/msm/msm_fb.c
> > @@ -118,7 +118,7 @@ uint32_t msm_framebuffer_iova(struct drm_framebuffer *fb,
> >                 struct msm_gem_address_space *aspace, int plane)
> >  {
> >         struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
> > -       return msm_fb->iova[plane];
> > +       return msm_fb->iova[plane] + fb->offsets[plane];
>
> Nit: can we push fb->offsets handling into msm_framebuffer_prepare()
> instead? Then the msm_framebuffer_iova() would become trivial?

I'd briefly considered it, but ended up putting it here simply because
that is where the offset addition was prior to d413e6f97134.  Whether
that is a good reason or not, idk.  (Prior to d413e6f97134 it needed
to be here, now it doesn't)

BR,
-R

> >  }
> >
> >  struct drm_gem_object *msm_framebuffer_bo(struct drm_framebuffer *fb, int plane)
> > --
> > 2.35.1
> >
>
>
> --
> With best wishes
> Dmitry
