Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC2F4EEAC0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344785AbiDAJzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244173AbiDAJzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:55:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9005045A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:53:51 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w21so2019167pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 02:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXRCPy6kZ1U55kW3/L29N2LaMZY83OqdS8sA1Zw35oA=;
        b=Iy5jo3ds2czZEHQCq5QfZphcqniK1eyOtLJ/HVzCsYUvuXTgVn1h58NLWofu4vwJS6
         DNZU83riPfc9OEjqmyhHk9YXaIiwMSU0YAkOZfy/p9FSZURuX59f+LjHYliW/Kwo7DIy
         1fI0htzBSYNVClUMdG5oeO3V/5t0o8IOuDY0inB72uCtv/T4VUedHmZkeRznocXc8Xo8
         Oil9pzaIdp+FUpJGfZoOMuRDFaPhxlClS6RYKbV+WxaAdouJsJSjr33tMYP1r89oLXAw
         uISnW6F2O58NMaBwKVCXXQoyiBrrNlZjYto1XEbi8fJwKW0mLT285VaSiNdg6Ti6EAr5
         R4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXRCPy6kZ1U55kW3/L29N2LaMZY83OqdS8sA1Zw35oA=;
        b=Q3b62hDVf/DhrUlZwrJUURgPEzCSiov+lgv6hsXQZ+rsFg8mg7d7jFit5GxgrVsIuX
         6LTIB/w1F7OGzx72eAnXLwCZvRPMscriFwCl7y8Kxuz/+dWS3NPHyay2B1wgA8V7k50o
         jDA3b2WID5np6wyghs5cW/lvaJ2cA4xEkG18jkAAlrrIfjO/4l4EM6uHlmrzKoAVOkgG
         eVdJuS1t/WKmui7j7o5scmoA/RZZ79HYTjaddNmj0gsu7/j0pKqTlTE1UDQgDqzek7CC
         0EmyeZDlhQWWu5TkagPm2QJI66XiyTcjoHLuDclocxCwOoidGrfypVIvn2fgIZLHsgSr
         D2nw==
X-Gm-Message-State: AOAM530m3/4QME/9OruP3VfcEbQJLOQ/dK0OZ2K4yfScaV548rYOSVJU
        G6MJVBOXBzBWnZ4Cef1F1ZZiusCyoIJF3ZVckvqk2TnUh7E=
X-Google-Smtp-Source: ABdhPJz8u3z3XfeUwNuVJQKS77kFNu8ObLRgS9bK4lFm7SIkzHMzygA/3PYqdU/R7H4SaHBcuvQlwFyGzFe4NP5LPwY=
X-Received: by 2002:a63:e20:0:b0:385:fe08:52f9 with SMTP id
 d32-20020a630e20000000b00385fe0852f9mr14458684pgl.99.1648806831267; Fri, 01
 Apr 2022 02:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220330120246.25580-1-xiam0nd.tong@gmail.com> <20220330120246.25580-4-xiam0nd.tong@gmail.com>
In-Reply-To: <20220330120246.25580-4-xiam0nd.tong@gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Fri, 1 Apr 2022 11:53:40 +0200
Message-ID: <CAMeQTsZnNy2ToRNTBisxVwBnj8Hsdz7+zdgcW=yr8C=zbAJZhA@mail.gmail.com>
Subject: Re: [PATCH 3/5] gma500: fix a missing break in psb_intel_crtc_mode_set
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
> list_for_each_entry() continues until the traversal is complete. It
> could result in multiple 'is_*' flags being set with true mistakely.
>
> To fix this, when found the entry, add a break after the switch
> statement.
>
> Fixes: 89c78134cc54d (" gma500: Add Poulsbo support")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>

This patch doesn't apply for me and needs to be rebased on top of
drm-misc-next or drm-tip.

On Poulsbo there should only be one encoder per crtc so this is only a
theoretical issue. But it is good practice to exit the loop early if
we can so the patch still makes sense.

Also, please use the correct subject prefix: drm/gma500: instead of
just gma500:.

Thanks
Patrik

> ---
>  drivers/gpu/drm/gma500/psb_intel_display.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm/gma500/psb_intel_display.c
> index 42d1a733e124..85fc61bf333a 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_display.c
> +++ b/drivers/gpu/drm/gma500/psb_intel_display.c
> @@ -134,6 +134,8 @@ static int psb_intel_crtc_mode_set(struct drm_crtc *crtc,
>                         is_tv = true;
>                         break;
>                 }
> +
> +               break;
>         }
>
>         refclk = 96000;
> --
> 2.17.1
>
