Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865CF4EEA68
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbiDAJaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbiDAJaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:30:20 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06E1103D96
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:28:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id t2so2095677pfj.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 02:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8RKpTKiU1sA+7C2AXK6LSzJS1T3BxhshmU+w3cvHKQE=;
        b=hbGgPbq6pQGw/A55t8ZmzRWISJG+M6aJtIcqQtKX5min6lmTgeuXmjBJeqe9nF+MEe
         h7ItB0pjbqm/2Pa6/vx2ng7HguhrxxwdVqa/GLFFWZzwSWKP/KzfL5nIFqWBXXPP2qOq
         430aI6WerwZw7bEE3lBbQF5gQrnlzS/iGSnXcT4qE04dvslp1d3fAQ30vKWQ58r4EVm7
         BnzU5/b2L7nBnkG59Iv7scs7dsfqZGvVWGr3tNJoqKHWjj5SMKwA5DHMpyTFo92pcWHw
         t8G5QzTZSvYl5GjxTQ6WeodkZbfbvit+lui3HXSFbD1g7WPKkHqgnl2sgrbpvWHGzWZz
         txGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8RKpTKiU1sA+7C2AXK6LSzJS1T3BxhshmU+w3cvHKQE=;
        b=Fr8uB7ALUOxN4v2dFqo75GKbvRp2a7d9SKtzKPImPN4okuZJz23afCAaZC6sw0HQ5B
         93Q3fHmNakDmVZAjkFmutEptsHWt0rRLZnYkBh0cAbXYghmQFWi56Qfw4rRIXX6bD8nq
         XJNlH5LsdGTwoDeK8RQS3kRzek5tYSazqhH5Gj3OZjX084AhmyINRbe+/cjRUJtW8b6r
         JnCteEpeDFma7LkJu883JkJb2t1ycoO3skTn+Xx1UAfWPiCTpVolgQKArVPOK4ruEjgl
         AfcVvqt8qxk2ybtw1iSAcLGAECFicq0IGAe2xdKj3DAvLtVZLWE/iK/mKacSW3fHBu9X
         pURA==
X-Gm-Message-State: AOAM531fbF7A9pyE3B52LDH7hYDa/bMpdM6j0LBTzmUnHhP8PSBg7Z4m
        N/s7dO3smaqr96+dObGuADpOUvuYYiyCSj76q14=
X-Google-Smtp-Source: ABdhPJyHPYoEK2lUGZ2g9xEATWdlsalFZ6pHObcpGc3pFWALJ9ZXzC91NvqVV80Rlfcz4xqlRvdwzmoB+xhHjMov5WE=
X-Received: by 2002:a05:6a00:c85:b0:4fa:f806:10f5 with SMTP id
 a5-20020a056a000c8500b004faf80610f5mr9890996pfv.43.1648805311158; Fri, 01 Apr
 2022 02:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220330120246.25580-1-xiam0nd.tong@gmail.com> <20220330120246.25580-3-xiam0nd.tong@gmail.com>
In-Reply-To: <20220330120246.25580-3-xiam0nd.tong@gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Fri, 1 Apr 2022 11:28:19 +0200
Message-ID: <CAMeQTsbZ4u=3pzu5p-4tt+kAiwmL2m+ZrCfzzv1vCMFeDAbDhQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] gma500: fix a missing break in cdv_intel_crtc_mode_set
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
> could lead to a invalid reference to 'ddi_select' after the loop, and
> could lead to multiple 'is_*' flags being set with true mistakely, too.
>
> The invalid reference to 'ddi_select' is here:
>         cdv_dpll_set_clock_cdv(dev, crtc, &clock, is_lvds, ddi_select);
>
> To fix this, when found the entry, add a break after the switch statement.
>
> Fixes: d66760962d75 ("gma500: Program the DPLL lane based on the selected digitial port")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>

Hi, this one is also already fixed in:

commit b1a7d0ddb169774c3db5afe9e64124daea7fdd9f
Author: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Tue Mar 22 14:17:38 2022 +0100

    drm/gma500: Make use of the drm connector iterator

> ---
>  drivers/gpu/drm/gma500/cdv_intel_display.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_display.c b/drivers/gpu/drm/gma500/cdv_intel_display.c
> index 94ebc48a4349..3e93019b17cb 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_display.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_display.c
> @@ -616,6 +616,8 @@ static int cdv_intel_crtc_mode_set(struct drm_crtc *crtc,
>                         DRM_ERROR("invalid output type.\n");
>                         return 0;
>                 }
> +
> +               break;
>         }
>
>         if (dev_priv->dplla_96mhz)
> --
> 2.17.1
>
