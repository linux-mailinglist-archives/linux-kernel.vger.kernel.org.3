Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A45D58FB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiHKLtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiHKLtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:49:49 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2692395E44
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:49:48 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id b7so13106112qvq.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=v7hLfcMomteQMGYnnnGVzBU2y9bVfdrurSUN+5SjKM8=;
        b=aw+VI2JmDYSyNusfXcufHp6EPVCvqLqjZ69YVXvlcmqpKOribWhYTvC9uieitKWAm5
         uQicszOphd3/So1DgZZCx9vj8UqvGhdzZPRsRAFmAsVVvTv7zWjeiQQKdGtTGIx3+ZmH
         o1NsTljye41iZ8gdA7NaLxzVwHCRaU5GGBKjEYs7uPBRLz6L/6JKOrcadj7zwP6wyW8q
         wu50PO/0+zRbgbUgId73B19Jgn4ID3pOAZGGwjpE7Nw0+mWY8wlHaBWMVI9esml9IahN
         DrbsvpgdXJwoyOov27RVBC3cET+sas0tb63rAtS1Vx8C5TEDSJ0uKlQ64sA9hnMk2mGR
         YqOw==
X-Gm-Message-State: ACgBeo2WAdf+5BSLtO+jOpsWlK78qxGauFgZL+41B7HZfxzRALCO7yGT
        22RZBHPQjxnaJ0fzDlyIsP75TDUbVz/TrsfX
X-Google-Smtp-Source: AA6agR616COIPFGub9lXZ63QvmXXJGJrPfKRQOkmsxbhyQ3Rj5Tpk4ZdS8o/cKmCGP5iENAUhlSjLw==
X-Received: by 2002:a05:6214:c8d:b0:479:7222:a279 with SMTP id r13-20020a0562140c8d00b004797222a279mr22180367qvr.39.1660218587390;
        Thu, 11 Aug 2022 04:49:47 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id c15-20020ac84e0f000000b0034356a0666fsm1456230qtw.17.2022.08.11.04.49.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 04:49:47 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-31f661b3f89so169611817b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:49:46 -0700 (PDT)
X-Received: by 2002:a81:b812:0:b0:328:68e4:c886 with SMTP id
 v18-20020a81b812000000b0032868e4c886mr31521818ywe.502.1660218586534; Thu, 11
 Aug 2022 04:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220811102304.70769-1-strochuk@ispras.ru>
In-Reply-To: <20220811102304.70769-1-strochuk@ispras.ru>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Aug 2022 13:49:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRVHiBZj=MQ3jLy2AEnwrvMXt6KXbZXr10ZJMhJDAmsw@mail.gmail.com>
Message-ID: <CAMuHMdXRVHiBZj=MQ3jLy2AEnwrvMXt6KXbZXr10ZJMhJDAmsw@mail.gmail.com>
Subject: Re: [PATCH] drm/fb-helper: add virtual screen size check to drm_fb_helper_check_var()
To:     Andrey Strachuk <strochuk@ispras.ru>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Thu, Aug 11, 2022 at 12:23 PM Andrey Strachuk <strochuk@ispras.ru> wrote:
> Add virtual screen size check to drm_fb_helper_check_var() in
> order to validate userspace input.
>
> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
>
> Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>

Thanks for your patch!

> Fixes: 6c11df58fd1a ("fbmem: Check virtual screen sizes in fb_set_var()")

This Fixes tag is misleading: the bug has existed since basically
forever.

> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1355,6 +1355,16 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
>             (drm_format_info_block_height(fb->format, 0) > 1))
>                 return -EINVAL;
>
> +       /* verify that virtual resolution >= physical resolution */
> +       if (var->xres_virtual < var->xres ||
> +           var->yres_virtual < var->yres) {
> +               drm_dbg_kms(dev, "requested virtual screen size that is "
> +                               "below the physical size(%ux%u vs. %ux%u)\n",
> +                       var->xres_virtual, var->yres_virtual,
> +                       var->xres, var->yres);
> +               return -EINVAL;

According to the fbdev rounding rules, invalid values should be rounded
up, if possible.  Hence it is better to not return an error, but round up:

    if (var->xres_virtual < var->xres)
            var->xres_virtual = var->xres;
    if (var->yres_virtual < var->yres)
            var->yres_virtual = var->yres;

> +       }
> +
>         /*
>          * Changes struct fb_var_screeninfo are currently not pushed back
>          * to KMS, hence fail if different settings are requested.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
