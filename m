Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DE1535440
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbiEZUIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiEZUIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:08:13 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5900C0381
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:08:12 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id q184so4603700ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91qa2V3ADLkVZ93Ejl4u/cWja6JFjs7BLRXshFe5jJU=;
        b=yp1JaNWo4BgiZLOAe9Ihy2/d/xZc+8TE1uwEwXii0dvjY7Y/DrwgAoxXI7YRF18Hds
         VaOVF/Kb59Q34eYLiQwzUv//B1PDfBtXhfp57HNtXmOlFr0n4tJsUCZnydx0+far551T
         ynAsAn/h62i8bnXHl0ZD3IfRgcC4eTMMfzwSLlFDSNJEu6e8cbsTvDZkFEOVwo1wdzPW
         kqrsI2m13WR/FFckcIc9MKl95kNHwIs1t5/qhk077rgSUfbesvJEVVTyDgyvlK2rZN/J
         YWy89TD07BAVCS5UAW/GbFNVpAsJBrhPLi8fw4YZbIz7/S0ThGNJywbEktsF+c7up1Ui
         5hMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91qa2V3ADLkVZ93Ejl4u/cWja6JFjs7BLRXshFe5jJU=;
        b=t76IgmvQh6Ba65skKhdoFMoB7hEuJpAxhfQtQSCIzp8+w/1UCBInEZs3qgvd3BAykn
         hB2vxRFakf3XCq4ZRJTJTkL9rd5mu5NvAMCcsWqZvPx7YD0/nGXSdTs48Gwrexvs2Cgs
         MLxOXty4Ob6BZ9B+Wy+VOGPw/Euxhh+p3Q12slw2pn6b9iUaY7gBX6VxTP9zUYfZUD5z
         gPsHRgb1OTmYjZpCQJlRZinQeCa5hUdBQYrG+tOz5fKZJ/ApLuTcZ8duB9fQ4RBoaCwX
         A/4fhssthzHd0P80PZdePBhElte5fyLLN738tKMDEbiFnqql6xtS36Sf6sVzbXYEHFIH
         URlg==
X-Gm-Message-State: AOAM532qWu9uEM0QwdvS6nv7N81oPWaoc6D5mJRimBxzk9CLp9TdOv2q
        S0z9B9Hf+c3m+vagYJ0QhuH6iYzsmjQv7YO++MU9ZQ==
X-Google-Smtp-Source: ABdhPJxW1KNzu0HAhdfeemIAiUAhc/ZiQ1/1QtGNgn22Gl7C2oKqOUbL9SvfnLyiD2fJCfw6Cx2mlZrP2o8bp1rpp9E=
X-Received: by 2002:a05:6902:704:b0:64d:f270:22b0 with SMTP id
 k4-20020a056902070400b0064df27022b0mr36943301ybt.626.1653595692147; Thu, 26
 May 2022 13:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220506123246.21788-1-yuehaibing@huawei.com> <CACRpkdZUwfVNZyS6RgcupJ+TRUZVM+1_3ABj_-f_3+v+wNE6mg@mail.gmail.com>
 <CACRpkdaKrk+cj9Yvpe3kmR1iJFczi-yckHiKeLGu9F=hRFiU9w@mail.gmail.com> <CAA8EJpq7_V7mZbN+G5fZdK0a4kTcxROAd_bGJtQ5mhzdYr6pNQ@mail.gmail.com>
In-Reply-To: <CAA8EJpq7_V7mZbN+G5fZdK0a4kTcxROAd_bGJtQ5mhzdYr6pNQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 May 2022 22:08:00 +0200
Message-ID: <CACRpkdYATkP2ONCxHq6+XsWM8949tXxd5r=OKM36dgwWp3Sxgg@mail.gmail.com>
Subject: Re: [PATCH v2 -next] drm/display: Fix build error without CONFIG_OF
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, airlied@linux.ie,
        daniel@ffwll.ch, tzimmermann@suse.de, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 3:36 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
> On Mon, 23 May 2022 at 15:55, Linus Walleij <linus.walleij@linaro.org> wrote:

> > Nope, failed:
> >
> > $ dim push-branch drm-misc-next
> > dim: ac890b9eeb9b ("drm/display: Fix build error without CONFIG_OF"):
> > Fixes: SHA1 in not pointing at an ancestor:
> > dim:     f5d01644921b ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus support")
> > dim: ERROR: issues in commits detected, aborting
> >
> > I don't know what to do with this, sorry. The other committers are maybe better
> > with this kind of situations. I think it is designed to stop me from
> > shooting myself
> > in the foot.
>
> Linus, can we get an ack from you (or anybody else from DRM core) to
> merge it through drm/msm tree?

Acked-by: Linus Walleij <linus.walleij@linaro.org>

> After a second thought, I think the patch contains wrong Fixes tag. It
> should be:
>
> Fixes: 1e0f66420b13 ("drm/display: Introduce a DRM display-helper module")
>
> With that in place would we be able to merge it through drm-misc? Does
> it needs to be resubmitted?

But it doesn't apply to drm-misc... that's my problem :/

Yours,
Linus Walleij
