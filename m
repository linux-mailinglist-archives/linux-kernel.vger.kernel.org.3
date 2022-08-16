Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C89959628A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbiHPSgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbiHPSgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:36:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2C37C76D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660674995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ATLTNrU7GYz0luvrW4anz32ZvPvWjx6FLjAwIXa1ryQ=;
        b=IBQ9Gk4M4BhfnDx5cYuUV4j6zZLYAJbJeAaGqZum/88hkj7ep/yVzB2LVdJksT0w+St6Xd
        r6osT38TFGOinYr9vZ6c5YH3XmRVzcWFo6NGHL2vFt1SG8cU4n5vh5nJYPApOfb+o1vKfa
        T+VNIz/4BbuGStEwfXuvr1qU1Zhm9uI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-snhDVn4KOGeyMLyS8wxmSQ-1; Tue, 16 Aug 2022 14:36:33 -0400
X-MC-Unique: snhDVn4KOGeyMLyS8wxmSQ-1
Received: by mail-qk1-f200.google.com with SMTP id w17-20020a05620a425100b006b97978c693so9908319qko.19
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ATLTNrU7GYz0luvrW4anz32ZvPvWjx6FLjAwIXa1ryQ=;
        b=OwtyUqHH7wwZAfhO+5pN7NRw/LNS39XnNiBcfjMVJkL6IasJWxoZx6I48GNgmlyBwe
         Rh8bx8MfD6AgRmcr6e7ukDZ45y9P+GaGPWQr7Z38LR6+zlPLqDYGb2b7bYx3rubVV9lS
         QIpfcR/h1NjwVHVbV0TZh2jJ5W74vNXFXClP5MniJTDEbasli88DFzg1N0ruNzRGPS4e
         QcEsbSp1dfVGlgUCmIGTVoAKLkW3q2K9/NqqfNdggsvIjmXwgHxcXgSvE63wX8C8KOAd
         1THjUDqCmp5QdA83MANwbIv9zP4lHA7XKEBx7W9s/RFYr9vdeX8r9ar4AAYXsBlxM8CO
         tuww==
X-Gm-Message-State: ACgBeo17I52QlrO2b8/Qt1F2u3mf9mwGWB3Ca/s8PcbTZ1gcDxG3xsa/
        kmCH+WpfSWqUu+hfd+YEt9xNnkdnMlqQPLwgAzp/1hDMMazk3oSYgIoNk6AzTC0YkDzdpySoexG
        NkA/itdaHy6B9uXmWqZ8KXhkTnvowlRFMSJvR/cwY
X-Received: by 2002:a05:622a:53:b0:344:6f46:9b16 with SMTP id y19-20020a05622a005300b003446f469b16mr4523476qtw.664.1660674993000;
        Tue, 16 Aug 2022 11:36:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4uzqnNt/HXR/q6B/lqjN5qSDiPZY/PY86apwP8teYfRNvnblpR+HCXfIUeJjTQ/VgoEgoyP1yH48Iodoy+LVI=
X-Received: by 2002:a05:622a:53:b0:344:6f46:9b16 with SMTP id
 y19-20020a05622a005300b003446f469b16mr4523466qtw.664.1660674992830; Tue, 16
 Aug 2022 11:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220816180436.156310-1-lyude@redhat.com>
In-Reply-To: <20220816180436.156310-1-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 16 Aug 2022 20:36:22 +0200
Message-ID: <CACO55tvoDZMTr6my2LvhWWz7h3L6u2938n5dwvjvLANpvwxhjA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/kms/nv140-: Disable interlacing
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 8:04 PM Lyude Paul <lyude@redhat.com> wrote:
>
> As it turns out: while Nvidia does actually have interlacing knobs on their
> GPU still pretty much no current GPUs since Volta actually support it.
> Trying interlacing on these GPUs will result in NVDisplay being quite
> unhappy like so:
>
> nouveau 0000:1f:00.0: disp: chid 0 stat 00004802 reason 4 [INVALID_ARG] mthd 2008 data 00000001 code 00080000
> nouveau 0000:1f:00.0: disp: chid 0 stat 10005080 reason 5 [INVALID_STATE] mthd 0200 data 00000001 code 00000001
>
> So let's fix this by following the same behavior Nvidia's driver does and
> disable interlacing entirely.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 43a9d1e1cf71..8100c75ee731 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -504,7 +504,8 @@ nouveau_connector_set_encoder(struct drm_connector *connector,
>                         connector->interlace_allowed =
>                                 nv_encoder->caps.dp_interlace;
>                 else
> -                       connector->interlace_allowed = true;
> +                       connector->interlace_allowed =
> +                               drm->client.device.info.family < NV_DEVICE_INFO_V0_VOLTA;
>                 connector->doublescan_allowed = true;
>         } else
>         if (nv_encoder->dcb->type == DCB_OUTPUT_LVDS ||
> --
> 2.37.1
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

