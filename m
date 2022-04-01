Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7554EEB08
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbiDAKMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiDAKMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:12:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8B218EE99
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:10:59 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c15-20020a17090a8d0f00b001c9c81d9648so2087202pjo.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7vUviIqjagA800+Kfi0dOW+YwFLrbsBNlctvy9tVv7U=;
        b=W+mLW/+G5TCFCm8phJQTLqsU1G+jYZcSAuGIyNiP4vmyj1z2hWptUMeTeomzOsGpZb
         rjt4CwUXHo/T15YP09eGJhZtTPgkAlLzuPBjYmMcTk8ENK862rbA/kcMnJBLPlJ6OdGf
         rZ4aP2Zcxg/qArrSrc7E12SIh6d+B715a78/W9wysAMoRHSfj42A/Osgv2GX67TQQJ8b
         vSSd/8/CeHXMUw5x0cXic+cbSIfTDGny0+7aF8iu65d5RBIXjO7hjIYOZJRyuLVOhp+T
         rHTKL/5V5vYjiQys+sRlJIJjFJ00fNcD5Dm2byGiv8LyPbR+e6YCczyR0tI5hHNWc3IO
         zUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7vUviIqjagA800+Kfi0dOW+YwFLrbsBNlctvy9tVv7U=;
        b=ZePknkEnHYKqlL/C2Kt0LfQarRuKj3j5eDME6xZsr4QZkLfQ9Vb61X0RjV+rTENcl7
         Fl82SdxXnXp7GHC0Xgkj/qNfq2nhRkF96pqqh6AciFBSDEDkCxexK4siewvpLNBmKQSP
         HVDZ2biZT/Hg0CPxl9VfctMB842eSLo3txlwSvBCybF8yDZIg1cmP8zGebcqhm5FO/lv
         yAClCB31HB/9IBYAFSuaQoTu6BcCMi5hS/jX/3D4MqFO/21PbxlIxeiTJIXk6a21KH/N
         5R/JRUnG3lrdwAGwBg6a0ys8xWp+l2m4Bw/aVmLpf6PhQNakqvV+hKhVfbTDani5qy3u
         /p/A==
X-Gm-Message-State: AOAM532ftw8tVoeoLI0P9iw/EYufuFighfKZIiJEtKoHKi8LIUPOKgmC
        QpfCDNcdnzygTdx1yMGqedn8QOjd450ZsdJTg6+xU3k2
X-Google-Smtp-Source: ABdhPJwGgXT66OAkRhojQj+TZttJ0jww9Zm57oWFkDEbSio/I5VriQ+zEmVbBvLUt1a8OfJ/3Oq2tgRKgvjYi4LMICk=
X-Received: by 2002:a17:90b:3850:b0:1c6:572e:f39a with SMTP id
 nl16-20020a17090b385000b001c6572ef39amr11010201pjb.233.1648807859421; Fri, 01
 Apr 2022 03:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220330120246.25580-1-xiam0nd.tong@gmail.com> <20220330120246.25580-6-xiam0nd.tong@gmail.com>
In-Reply-To: <20220330120246.25580-6-xiam0nd.tong@gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Fri, 1 Apr 2022 12:10:48 +0200
Message-ID: <CAMeQTsYcyk9vRO6OaBi-KsptBzJ1Jh-2bOa0UW1+F+JUnDwH=g@mail.gmail.com>
Subject: Re: [PATCH 5/5] gma500: fix a missing break in psb_driver_load
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Zhao Yakui <yakui.zhao@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, Mar 30, 2022 at 2:03 PM Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
>
> Instead of exiting the loop as expected when an entry is found, the
> list_for_each_entry() continues until the traversal is complete. To
> avoid potential executing 'ret = gma_backlight_init(dev);' repeatly,
> add a break after the switch statement.
>
> Fixes: 5c49fd3aa0ab0 ("gma500: Add the core DRM files and headers")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>

This is incorrect. If we always break on the first iteration we will
only run gma_backlight_init() if the first connector is LVDS or MIPI.
This might not be the case and gma_backlight_init() will never run.
The other loops you have been looking at have an "if (xxx != yyy)
continue;" statement at the top which skips all the unwanted entries
but this loop does not.

> ---
>  drivers/gpu/drm/gma500/psb_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
> index 65cf1c79dd7c..d65a68811bf7 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -398,6 +398,8 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
>                         ret = gma_backlight_init(dev);
>                         break;
>                 }
> +
> +               break;
>         }
>
>         if (ret)
> --
> 2.17.1
>
