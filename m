Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521C3508247
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359843AbiDTHh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359836AbiDTHh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:37:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216C9396B1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:34:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g9so860026pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YMhwvtptGsfF/ACTCQLRNBHCJudINRjpOhyhzT+fTo=;
        b=h79/pYV5ePZ+xnqW6Sc4hnVwjvpuaaHnJUn7204uDLI1W/CHJ9/0h29qAGV22oYq3H
         fJ6m2Co6FHGzLh21Zb30bV5wKZSuAEiS996QnHnAOUoyFCR16H+pgqS2TKIsFYAzHFgr
         SI2eikJOrn8ikjE+HvQQYs1ZgyOE6QuRVRDA6fHrqQSqUSk7miqenESiTaDXK2B8pAE8
         D4kCsgWdjSy7xuyXdvvc9Qos8jUcjwtTKlnbz4j3bv8RFqtrb5ldjWD3FBn0chp9gVN0
         vNoIqFMgcblZC3/HJSwFLIIrsLRcBq3RofB1RVh2dISKvedVQf8v380kaEoijfwom1eU
         EtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YMhwvtptGsfF/ACTCQLRNBHCJudINRjpOhyhzT+fTo=;
        b=8M7K3ekLVHlt/I2Ts4c1aUqHWX/qZ8Z0JKVCKMLgDutu6cVMLDC6zmUz+PVcjzFWlq
         9cBX8tMAhppW/Eud4XjdoNR7N9yV9WB8RHX7c5ZdCOTgENxtBqB4JeMYVKpgTPWErheJ
         VVNNdye33cFd+YKnS7z5QBhaWYQCVxkD/eAH0MNmaByR6OpoGXl0oXnxdHs3/zz3dPfX
         XTPT9N58JHKrWl1HIlru/TbqR0aP8Y/xGU2mAsLQJy3dF7f2Ry6sO5MsZuhJAkOmzIfy
         TqNXKgd2bsAQlZe+ytM9iWblBPtbj+KE3HJ2R5cAYdcYn3YYFO7j6nvtTTa7a5TuJwu3
         cVUA==
X-Gm-Message-State: AOAM530wcHNEuLi6id24AuLwpUJ8/U2z7NdTnRgd7no58iY+ioTUJq+I
        kmtMbduXAUnHoJWzBvUi6duwjfnHRMTGQOIx5X4=
X-Google-Smtp-Source: ABdhPJyA1889PgEB0GdrkHoqQfa0/GzzWjfxH6q0aUYd097vaaQyRbwbFpYaNFr1BC0UeO6JSQEntnzim0g4Ikhsh14=
X-Received: by 2002:a63:c155:0:b0:3aa:1ecf:9a59 with SMTP id
 p21-20020a63c155000000b003aa1ecf9a59mr8888222pgi.90.1650440081670; Wed, 20
 Apr 2022 00:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220413051105.5612-1-xiam0nd.tong@gmail.com>
In-Reply-To: <20220413051105.5612-1-xiam0nd.tong@gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Wed, 20 Apr 2022 09:34:30 +0200
Message-ID: <CAMeQTsbV1ZcUf=ZRdzufxanRj5NJAor+SReA2Fnqk4kj13c94g@mail.gmail.com>
Subject: Re: [PATCH v3] drm/gma500: fix a potential repeat execution in psb_driver_load
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
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

On Wed, Apr 13, 2022 at 7:11 AM Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
>
> Instead of exiting the loop as expected when an entry is found, the
> list_for_each_entry() continues until the traversal is complete. To
> avoid potential executing 'ret = gma_backlight_init(dev);' repeatly,
> goto outside the loop when found entry by replacing switch/case with
> if statement.
>
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>

Thanks for the patch. I've applied it to drm-misc-next.

I fixed up an indentation issue on the second line.

Cheers
Patrik

> ---
> changes since v2:
>  - replace switch with if statement (Patrik Jakobsson)
>
> changes since v1:
>  - goto outside the loop (Xiaomeng Tong)
>
> v2: https://lore.kernel.org/dri-devel/20220406113143.10699-1-xiam0nd.tong@gmail.com/
> v1: https://lore.kernel.org/lkml/20220401115811.9656-1-xiam0nd.tong@gmail.com/
> ---
>  drivers/gpu/drm/gma500/psb_drv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
> index 2aff54d505e2..85211ec16e52 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -396,9 +396,8 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
>         drm_for_each_connector_iter(connector, &conn_iter) {
>                 gma_encoder = gma_attached_encoder(connector);
>
> -               switch (gma_encoder->type) {
> -               case INTEL_OUTPUT_LVDS:
> -               case INTEL_OUTPUT_MIPI:
> +               if (gma_encoder->type == INTEL_OUTPUT_LVDS ||
> +                       gma_encoder->type == INTEL_OUTPUT_MIPI) {
>                         ret = gma_backlight_init(dev);
>                         break;
>                 }
> --
> 2.17.1
>
