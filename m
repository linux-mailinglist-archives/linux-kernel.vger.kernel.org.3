Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E1D461E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378892AbhK2Sf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379249AbhK2Sdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:33:44 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04397C07E5DD
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 06:53:34 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id a24so14748865qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 06:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hn4uHzzXEL4XF0CRL/cS9ChzrG9K87GFKA8uXMw8t0k=;
        b=vHRvgTxtX+sbegx1uyrAIlIt4uZKXXm01PsXOPBDb1cXPpJJ2uOTWhWQg587/VRUEB
         obnRUEdx50OGGafRjtfk2WeIsVnZawk229iM2T6xHWPPx61tQ83tMjhxpBj87hOE9vcY
         00TyQmMnBIc5hkrqw4317zg9MVoKNagLtJfdYVbjZo2qjN3rTReKSsYLmZrBH+Y5ApqP
         MYidC9XYcRy+Wcnp/xhU4ilWv6QzSjJRwWy0IvvpYkPW03gLysK5DklCZbNIsEDskpH1
         pT82wuajzXTEdBUwQ9XSqw04R5Xro/zIE2O4HJ33Jb0fbo8aZFr/+6kQ2WLFcNFRjZop
         3hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hn4uHzzXEL4XF0CRL/cS9ChzrG9K87GFKA8uXMw8t0k=;
        b=EuV97k2CPPBlnji3+TZty438EtDkYyv3hAQgKG2nEXazS8hoBUOEwYgx/BJTBAa3xO
         RdWFKfAPPRshs92EUVITcKsWWbToR/Nr0oruVCny/ZfaLyUTMbOJUMzoRWDY0fHfWKFD
         xkqOmqeyXB7FjREyEj9sGII173DNbPu0CBIT3NzOElCm1fttGv1SkhJg5nOkgolkx4xf
         i9WHZTcrx71HaYEcrQK+yl4tatesbicb2yaBe/6Q/9F/SiHQ9GlqcN45eeUuhQNjfk5F
         2FrCa+Sjy0uv7pXgHfofIbXJzkzEWkcllk6F+xUucz3bO0VOSy6PVQidfDOoGo8M0Fop
         ONmg==
X-Gm-Message-State: AOAM532Ueyqin2LSntpV7lrOvZXNKe9nb4MHtxQ7jjTMhaOjfKJVXt6a
        ZcS0wbNOCIPVZBAPLqNOInXVf8DO2DQr5HMMbUJu/A==
X-Google-Smtp-Source: ABdhPJyoVmUy66O70GfGuYULckvsoe/mpPrhEXqoDSh9CDg5qbsrpElvsn3TaG7NdymMDxWxIxUQS9PRmx0YV5Ktr7I=
X-Received: by 2002:a05:6214:176f:: with SMTP id et15mr30520228qvb.115.1638197613119;
 Mon, 29 Nov 2021 06:53:33 -0800 (PST)
MIME-Version: 1.0
References: <20211125150947.354076-1-angelogioacchino.delregno@collabora.com>
 <bf1540f1-4a9f-a9d6-d487-929107c487fd@linaro.org> <9a0158ae-a3b1-21b2-1ba3-82d4901eb873@collabora.com>
In-Reply-To: <9a0158ae-a3b1-21b2-1ba3-82d4901eb873@collabora.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 29 Nov 2021 17:53:22 +0300
Message-ID: <CAA8EJpq1Lmpe8v5OLuEHBJd8Ehid+Jpyzs42BURVmn4B-=yWJA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Initialize MDSS irq domain at probe time
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, maxime@cerno.tech, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        jami.kettunen@somainline.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 29 Nov 2021 at 17:15, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 29/11/21 03:20, Dmitry Baryshkov ha scritto:
> > Hi,
> >
> > On 25/11/2021 18:09, AngeloGioacchino Del Regno wrote:
> >> Since commit 8f59ee9a570c ("drm/msm/dsi: Adjust probe order"), the
> >> DSI host gets initialized earlier, but this caused unability to probe
> >> the entire stack of components because they all depend on interrupts
> >> coming from the main `mdss` node (mdp5, or dpu1).
> >>
> >> To fix this issue, also anticipate probing mdp5 or dpu1 by initializing
> >> them at msm_pdev_probe() time: this will make sure that we add the
> >> required interrupt controller mapping before dsi and/or other components
> >> try to initialize, finally satisfying the dependency.
> >>
> >> While at it, also change the allocation of msm_drm_private to use the
> >> devm variant of kzalloc().
> >>
> >> Fixes: 8f59ee9a570c ("drm/msm/dsi: Adjust probe order")
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >
> > I have been thinking about this. I do not feel that this is the correct approach.
> > Currently DRM device exists only when all components are bound. If any of the
> > subdevices is removed, corresponding component is delteted (and thus all components
> > are unbound), the DRM device is taken down. This results in the state cleanup,
> > userspace notifications, etc.
> >
> > With your changes, DRM device will continue to exist even after one of subdevices
> > is removed. This is not an expected behaviour, since subdrivers do not perform full
> > cleanup, delegating that to DRM device takedown.
> >
> > I suppose that proper solution would be to split msm_drv.c into into:
> > - generic components & drm code to be called from mdp4/mdp5/dpu driver (making
> > mdp4, mdp5 or dpu1 the components master)
> >
> > - bare mdss driver, taking care only about IRQs, OF devices population - calling
> > proper mdss_init/mdss_destroy functions. Most probably we can drop this part
> > altogether and just make md5_mdss.c/dpu_mdss.c proper platform drivers.
> >
>
>
> Hmm... getting a better look on how things are structured... yes, I mostly agree
> with you, though I'm not sure about making MDP{4,5}/DPU1 the component master; that
> would result in a major change in drm-msm, which may be "a bit too much".
>
> Don't misunderstand me here, please, major changes are fine - but I feel urgency
> to get this bug solved ASAP (since drm-msm is currently broken at least for drm
> bridges) and, if we do anything major, that would require a very careful slow
> review process that will leave this driver broken for a lot of time.

Yep. I wanted to hear your and Rob's opinion, that's why I did not
rush into implementing it.
I still think this is the way to go in the long term. What I really
liked in your patchset was untying the knot between component binds
returning EPROBE_DEFER and mdss subdevices being in place. This solved
the "dsi host registration" infinite loop for me.

>
> I actually tried something else that "simplifies" the former approach, so here's
> my proposal:
> * we introduce {mdp5,dpu}_mdss_early_init(struct device, struct msm_drm_private)
> * allocate only msm_drm_private in msm_pdev_probe, leaving the drm_dev_alloc call
>    into msm_drm_init(), so that the drm_dev_put() stays in msm_drm_uninit()
> * pass msm_drm_private as drvdata instead of drm_device
> * change all the drvdata users to get drm_device from priv->dev, instead of getting
>    msm_drm_private from drm_device->dev_private (like many other drm drivers are
>    currently doing)

This sounds in a way that it should work. I'm looking forward to
seeing (and testing) your patches.

>
> This way, we keep the current flow of creating the DRM device at msm_drm_init time
> and tearing it down at msm_drm_unbind time, solving the issue that you are
> describing.
>
> If you're okay with this kind of approach, I have two patches here that are 95%
> ready, can finish them off and send briefly.
>
> Though, something else must be noted here... in the last mail where I'm pasting
> a crash that happens when running 'rmmod panel_edp ti_sn65dsi86', I have implied
> that this is happening due to the patch that I've sent: after some more research,
> I'm not convinced anymore that this is a consequence of that. That crash may not
> be related to my fix at all, but to something else (perhaps also related to commit
> 8f59ee9a570c, the one that we're fixing here).
>
> Of course, that crash still happens even with the approach that I've just proposed.
>
>
> Looking forward for your opinion!
>
> Cheers,
> - Angelo



-- 
With best wishes
Dmitry
