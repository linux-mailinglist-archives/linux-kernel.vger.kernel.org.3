Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBD64F5C12
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243716AbiDFLTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242518AbiDFLSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:18:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7351B47CD1F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:40:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s2so1741092pfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 00:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1QYq8NuVe9FN1D3vwLDp5oNe5+OPIXHbOpbj0ZnKIIo=;
        b=I0WUDB/A3XT+HHA+8xdWDIxHNPYG1oNh9YCaF3Z6OGT7ASDzbHM55p2/UUQDrZEgQa
         EMani0C9pII6a6RDj7NeJT9y/yuOtT/8kLbCKQHHwGqfbiAF073eLiaBiHjtaVfN0x5q
         bNvRDkc9MUhQb1nl+7JnuQZvAJU/fjiPy3ZEgPk2QaQg8cEPBfcT9k5yWjJ3imKGPJrR
         yFL50pYQzWgkfTIm4DEN5nVsrvoTtqwKJhAgODeDLyCdd2zzb/o5bLgbK89e2IdVjnnT
         HLIAI1TtCXYJMp7K8PxT8KQhoRtzpDtreaYfYLMEbhuMxg3Jq0K2MffRYK+F4ZCWNV7i
         eZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1QYq8NuVe9FN1D3vwLDp5oNe5+OPIXHbOpbj0ZnKIIo=;
        b=44HDAYuZOLvmZbQvyTvH5Gt47bUjrvKGYgzgzIdAEOUBnQEjfsdn2cprw/L7mcm9HB
         yQOOwkgZElCxHJD5IuZGLN8VbKrQ7DLyc4j+EaAU5Z2k5uwfAV6efcEZ+ILO3o+e1Tao
         5JHhH+QZ4CdJJzwXcnQvOkcMZyVHMzrFgqweVODt0qFu/IeTXCbxZ7JAQEbIQ9P5sobm
         PiLkQejZ9Z34nfR+OinsJPl8ICLoBLId6Gk68hrXoVSes+RCaET5lNLQELm10zXd6Y4p
         AMzx5vNDdUKhg0gAIceLEEqd78eNzFu3ICmKto8XmFzAKYJZJ/iHMGp+KsDX9jjOK1l1
         FVNg==
X-Gm-Message-State: AOAM530dzRlbp7fq+A5+rnlMYe9Nddov4U9NU/AHA1moSOCIQmjXHMds
        KShzciEX4q+pfhROu6arYDi0FuJvHQ9EdOsk6s0=
X-Google-Smtp-Source: ABdhPJyCF7VtDld/Bk1zsR0RI1ioU48r8W3y5GNMOO89Tl7mj4ykPWLwgQlMOtVnjrpXkiRt/uw7CM0Ijf43uSZoHFs=
X-Received: by 2002:a63:4f46:0:b0:382:56b2:f8 with SMTP id p6-20020a634f46000000b0038256b200f8mr6098889pgl.90.1649230803905;
 Wed, 06 Apr 2022 00:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220401115018.9335-1-xiam0nd.tong@gmail.com>
In-Reply-To: <20220401115018.9335-1-xiam0nd.tong@gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Wed, 6 Apr 2022 09:39:52 +0200
Message-ID: <CAMeQTsaPve23sNNm0Xkg9=8kqeN0SQp056Xyiva4pe2B7K37RQ@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: fix a missing break in psb_intel_crtc_mode_set
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Alan Cox <alan@linux.intel.com>,
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

On Fri, Apr 1, 2022 at 1:50 PM Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
>
> Instead of exiting the loop as expected when an entry is found, the
> list_for_each_entry() continues until the traversal is complete.
> when found the entry, add a break after the switch statement.
>
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>

Thanks for the patch
Applied to drm-misc-next

> ---
>  drivers/gpu/drm/gma500/psb_intel_display.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm/gma500/psb_intel_display.c
> index dc467996cce4..9a5ea06a1a8e 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_display.c
> +++ b/drivers/gpu/drm/gma500/psb_intel_display.c
> @@ -135,6 +135,8 @@ static int psb_intel_crtc_mode_set(struct drm_crtc *crtc,
>                         is_tv = true;
>                         break;
>                 }
> +
> +               break;
>         }
>         drm_connector_list_iter_end(&conn_iter);
>
> --
> 2.17.1
>
