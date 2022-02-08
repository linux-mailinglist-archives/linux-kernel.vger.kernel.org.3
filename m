Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EB14AD98F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353949AbiBHNU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356765AbiBHMWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:22:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BD2DC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644322930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mt0hncQ/RRm0riihXr626lJBH3pbgbYhHyz5dtgoOAs=;
        b=h/biWEzIboYQxj/i4m7E8LLf3Ca9ZqJkRlBdThiKTIyBKHNXOsrkXnCYk6YXJ6oDK0UY/a
        DJplQvm0gaxC/mZJh9qm1UqqB65RHFPUdDHc9YN+o+Mjy229yblj2S13pOcANLDKQgDhyk
        x1AM+Eujvr2NaEmHAIs+zRPODwc37mA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-SBb_V7DINOaHH0I2kPcdlA-1; Tue, 08 Feb 2022 07:22:09 -0500
X-MC-Unique: SBb_V7DINOaHH0I2kPcdlA-1
Received: by mail-wr1-f70.google.com with SMTP id y10-20020adfc7ca000000b001e30ed3a496so2690790wrg.15
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mt0hncQ/RRm0riihXr626lJBH3pbgbYhHyz5dtgoOAs=;
        b=y6xD1we91xO0gqNk3Zo9LrRJ2xIkHxOstuwsuGdJUtrXKm/c/5fh+6Xhlv+xROvFhL
         OPGgHCNWWeOsbt0YdrP1oYmewQ5BtW+kMQdpsR8iJ50Wt62LXz4VlcwqWWlFxYzy87me
         oKnsKkUi18B3CHnzW9uAEKcbfZf+KJ2Xyt2sEnEbftF74EdBsjbjFNmn4KGWNeTp5bj+
         sknEbVkywc/gZLqh73J/sGaiSRf2XG/RYQaIMa+kJXpiJZB+hZtYIa+R9IfWJRAotiGp
         YITMadH4kC7YMIkZ/5i7p6W+By79HgKzzAm9QF3HUvNXojM8/VLdBkzTjeKwkrW77uxj
         YbTg==
X-Gm-Message-State: AOAM533t7kTIUjXqFoe6BT5gTofl1fTK+AdBCieVlAur/mPbCbgvz5w6
        BqjmUfmssOAtRaa5tdJlqrmprWTXekt56J5Vmdgd5GvsdRFfQHlchM1GK5AmB/33SCycw3HzeVa
        sNrZxWB98tKTzTCD7JQkj4VO7ZGtgYikpFPBjJObZ
X-Received: by 2002:a7b:c21a:: with SMTP id x26mr938347wmi.74.1644322928164;
        Tue, 08 Feb 2022 04:22:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw05S2FM4hb+eMcua2vq2VzpKE6qzOqTT3pzSCAKpcyucQY5qglNO8kSljUgpASBmw4liJar8UCAeaCMl7/oQ0=
X-Received: by 2002:a7b:c21a:: with SMTP id x26mr938337wmi.74.1644322927980;
 Tue, 08 Feb 2022 04:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20220204193319.451119-1-lyude@redhat.com>
In-Reply-To: <20220204193319.451119-1-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 8 Feb 2022 13:21:57 +0100
Message-ID: <CACO55tv1yFYeboJsdV9sg1KWqWhs3WfJVmHuBKjAV6FUi6BLSA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/backlight: Just set all backlight types as RAW
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Fri, Feb 4, 2022 at 8:33 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Currently we can get a warning on systems with eDP backlights like so:
>
>   nv_backlight: invalid backlight type
>   WARNING: CPU: 4 PID: 454 at drivers/video/backlight/backlight.c:420
>     backlight_device_register+0x226/0x250
>
> This happens as a result of us not filling out props.type for the eDP
> backlight, even though we do it for all other backlight types.
>
> Since nothing in our driver uses anything but BACKLIGHT_RAW, let's take the
> props\.type assignments out of the codepaths for individual backlight types
> and just set it unconditionally to prevent this from happening again.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 6eca310e8924 ("drm/nouveau/kms/nv50-: Add basic DPCD backlight support for nouveau")
> Cc: <stable@vger.kernel.org> # v5.15+
> ---
>  drivers/gpu/drm/nouveau/nouveau_backlight.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> index 6af12dc99d7f..daf9f87477ba 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> @@ -101,7 +101,6 @@ nv40_backlight_init(struct nouveau_encoder *encoder,
>         if (!(nvif_rd32(device, NV40_PMC_BACKLIGHT) & NV40_PMC_BACKLIGHT_MASK))
>                 return -ENODEV;
>
> -       props->type = BACKLIGHT_RAW;
>         props->max_brightness = 31;
>         *ops = &nv40_bl_ops;
>         return 0;
> @@ -343,7 +342,6 @@ nv50_backlight_init(struct nouveau_backlight *bl,
>         else
>                 *ops = &nva3_bl_ops;
>
> -       props->type = BACKLIGHT_RAW;
>         props->max_brightness = 100;
>
>         return 0;
> @@ -411,6 +409,7 @@ nouveau_backlight_init(struct drm_connector *connector)
>                 goto fail_alloc;
>         }
>
> +       props.type = BACKLIGHT_RAW;
>         bl->dev = backlight_device_register(backlight_name, connector->kdev,
>                                             nv_encoder, ops, &props);
>         if (IS_ERR(bl->dev)) {
> --
> 2.34.1
>

