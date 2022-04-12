Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D7D4FE441
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356801AbiDLPA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356807AbiDLPAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:00:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1485753A70
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:58:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c23so17052217plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KYagNUqIHqgU+oqSymMfranRvWhd+BPAcvJm6l98bo=;
        b=awdtt9Hf21fMcRZ78eX5oVsqrqUW1p1VOYv03F6tpNRABDCzSJnErPFiztxbDjHJUM
         Cy4jviQ653fnSpmibuVNXJ2pxrekXka+OXdgEBl+ZgY+r80nbShXvpOHKYn857b90Bdw
         dyGLb34y9P6YDmQ3YYXhuGjyubgtf3HE9mOfNzr9Q2aBkpMLqSaTES1ym3SJvqWEjEqe
         2Klh4lg9uOxqMkEaRJsNQlw4yL1C5GhF0l7X0l1Rd+OUsVCUhJOSejBihBEYjTQU0APV
         MC1SaadM2QTE/rxpChY4ukl5m96OTCaTLUSbzIaTP885lL76cyEHHWcu27BYxRSEnywu
         bSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KYagNUqIHqgU+oqSymMfranRvWhd+BPAcvJm6l98bo=;
        b=UI3zcdiV7zfyMAxnnKRYgDsk4k/AoYlHO29y4E50G37eHtoStRNT0TLpneZUCGh67e
         NT5JC+OoXQ9kAle5y5H2iIoqyWdO58WwRGziz8g0j6u71irYYrpD4Q5xoK9eGK5ZJxet
         ylyaXK9Kkn9ltQlQVoODvqaF6BHR4iIIKMAEtotIzh/YlyU+uDSooeqecr8n/J0uL/uY
         n/s/tya2CvqiupSG1Le+AveCAAtnXNffnwOX0ReuXwiwKvx5gtETuH0ZyR8L7TVrLfVF
         EhzJupFdZM2CBEBMW8lW/MX0kYBEEoTzhHH9mhqOzx0FxcNZyKwwsSXe4gUGFtvudy6s
         xHSg==
X-Gm-Message-State: AOAM530Frt0shwnfhqoWeZCbUimdpp+sgYdeNrJ7774YnIqUZ2Km8Bd0
        pryCHo2Hk7UgBZyPprZF3Yk3YcRCNPiUNy3YVh8=
X-Google-Smtp-Source: ABdhPJwkiC9k1PbeBB367CzB05gEtaV0BIJKzMnZMt+yV+mv8Bhp09l/IBDwVxerNUO1DNXnq+jbISIjT7ihyVabYZ8=
X-Received: by 2002:a17:90a:1c96:b0:1cb:1ae2:85a3 with SMTP id
 t22-20020a17090a1c9600b001cb1ae285a3mr5419500pjt.233.1649775516457; Tue, 12
 Apr 2022 07:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220406113143.10699-1-xiam0nd.tong@gmail.com>
In-Reply-To: <20220406113143.10699-1-xiam0nd.tong@gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Tue, 12 Apr 2022 16:58:24 +0200
Message-ID: <CAMeQTsaXM-ddGLukxuEJvm+0UtuJEZGL_5KEY8h9ZPH-ZxmBsQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/gma500: fix a potential repeat execution in psb_driver_load
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
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

On Wed, Apr 6, 2022 at 1:31 PM Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
>
> Instead of exiting the loop as expected when an entry is found, the
> list_for_each_entry() continues until the traversal is complete. To
> avoid potential executing 'ret = gma_backlight_init(dev);' repeatly,
> goto outside the loop when the entry is found.
>
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>
> changes since v1:
>  - goto outside the loop (Xiaomeng Tong)
>
> v1: https://lore.kernel.org/lkml/20220401115811.9656-1-xiam0nd.tong@gmail.com/
>
> ---
>  drivers/gpu/drm/gma500/psb_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
> index 2aff54d505e2..929fd47548b4 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -400,9 +400,10 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
>                 case INTEL_OUTPUT_LVDS:
>                 case INTEL_OUTPUT_MIPI:
>                         ret = gma_backlight_init(dev);
> -                       break;
> +                       goto out;
>                 }
>         }
> +out:
>         drm_connector_list_iter_end(&conn_iter);

Hi,
This would work but using gotos like this easily turns the code into
spaghetti. See "7. Centralized exiting of functions" in
Documentation/process/coding-style.rst for when to use gotos.

In this particular case I think we are better off using an
if-statement. What about something like this:

if (gma_encoder->type == INTEL_OUTPUT_LVDS ||
    gma_encoder->type == INTEL_OUTPUT_MIPI) {
        ret = gma_backlight_init();
        break;
}

-Patrik

>
>         if (ret)
> --
> 2.17.1
>
