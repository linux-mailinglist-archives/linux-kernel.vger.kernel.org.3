Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB7851E12D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444524AbiEFVgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444528AbiEFVgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE43B6F4AA
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651872766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dJbJbWsoyM+Ik6q37wpw5Oa4Nh86YRow8ddVHHmJk08=;
        b=Mogfye/mTZEmePYp0uFboMftlTM2s/fjnz1kqqos0JeUBeMBKURC0xvXO7IJyTujOuZHp3
        4ubpZwPTTmJ74P8NyjzSHJRzP/z+p/EkmQpaCZMqV4nyLKYIb2RF8YbazbUMj/KqCnrxaX
        sgPgBZutuhdtlDpyU1KUmf3DeHr1Rds=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-T07rAprUMcKaleG2PLuxSA-1; Fri, 06 May 2022 17:32:44 -0400
X-MC-Unique: T07rAprUMcKaleG2PLuxSA-1
Received: by mail-qt1-f200.google.com with SMTP id l7-20020a05622a174700b002f3c49f49ffso3859012qtk.15
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 14:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=dJbJbWsoyM+Ik6q37wpw5Oa4Nh86YRow8ddVHHmJk08=;
        b=o02RFvf0P5ZwFgRK48JB5/8WpWVyq4qIm4j/adzrCn9cnE1mu1KjRJ9T0FWV3N6SQR
         JsItZ6m7QPn05nSdtAi1S+MxU/R7/GHAVoIPb6VXu4Jvh27zzhzPfJLqaMSvglE/ZtB5
         wVtNdET8WRsqeEAp5W+8MX4VVHpg+PU4XSRmH1kAJn7Y4v+iq4Z2SgySvdL2Evx7/FWc
         6eqO6+gcOPdq4OF9SfSo5evxbFgBBeDOCAtiXBNIcgDn8iacoh+A6r3oTDyJ09Un6gy2
         GlESE9KkeXAzkxDLlmIOUuExv9fkxYlKO2lU3D17wDq4uDi3SmUkLo6gPGiCr6bRtGlo
         1OkQ==
X-Gm-Message-State: AOAM533oWh4pp5UoEslW6bV3zDCGM7Ig7KoVf9IwD9jUZjXkWqDDhJvx
        wpBIK5XI1JbZKDs71aneMP+Ij3+1xQ/+g1Pb4nl6e5lO4fiWnQDtmfZ4ksROkJD9xG3spRwjTTQ
        WnQhGb7V1ZW3RFEx9KFWBae8R
X-Received: by 2002:a0c:ab09:0:b0:443:95d9:140c with SMTP id h9-20020a0cab09000000b0044395d9140cmr4170802qvb.84.1651872764248;
        Fri, 06 May 2022 14:32:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK5FWqqA+iA50nH6ppws5HNXmaCdaMsh8I0itmM43LaQ06P84wOxCI5Gl5CmLPygLNpGGy8Q==
X-Received: by 2002:a0c:ab09:0:b0:443:95d9:140c with SMTP id h9-20020a0cab09000000b0044395d9140cmr4170789qvb.84.1651872763988;
        Fri, 06 May 2022 14:32:43 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id b3-20020ac85403000000b002f39b99f6adsm3164237qtq.71.2022.05.06.14.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 14:32:43 -0700 (PDT)
Message-ID: <9b7eab5df5e63e3fe899bca9ea35f4be8bbff98c.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Fix a potential theorical leak in
 nouveau_get_backlight_name()
From:   Lyude Paul <lyude@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pierre Moreau <pierre.morrow@free.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Date:   Fri, 06 May 2022 17:32:42 -0400
In-Reply-To: <9ba85bca59df6813dc029e743a836451d5173221.1644386541.git.christophe.jaillet@wanadoo.fr>
References: <9ba85bca59df6813dc029e743a836451d5173221.1644386541.git.christophe.jaillet@wanadoo.fr>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I totally missed this patch up until now, noticed it while going through
unread emails today. This is:

Reviewed-by: Lyude Paul <lyude@redhat.com>

FWIW, if there's something you need reviews on that hasn't gotten looked at
after a few weeks feel free to poke the nouveau list/me.

Anyway, I will go ahead and push this to drm-misc-fixes in a moment. Thanks!

On Wed, 2022-02-09 at 07:03 +0100, Christophe JAILLET wrote:
> If successful ida_simple_get() calls are not undone when needed, some
> additional memory may be allocated and wasted.
> 
> Here, an ID between 0 and MAX_INT is required. If this ID is >=100, it is
> not taken into account and is wasted. It should be released.
> 
> Instead of calling ida_simple_remove(), take advantage of the 'max'
> parameter to require the ID not to be too big. Should it be too big, it
> is not allocated and don't need to be freed.
> 
> While at it, use ida_alloc_xxx()/ida_free() instead to
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
> 
> Fixes: db1a0ae21461 ("drm/nouveau/bl: Assign different names to interfaces")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is more a clean-up than a fix.
> It is unlikely than >= 100 backlight devices will be registered, and the
> over allocation would occur even much later when the underlying xarray is
> full.
> 
> I also think that the 'if (bl->id >= 0)' before the ida_simple_remove()
> calls are useless. We don't store the id if a negative (i.e. error) is
> returned by ida_simple_get().
> 
> Finally, having a '#define BL_MAX_MINORS 99' could be better than a
> magic number in the code.
> ---
>  drivers/gpu/drm/nouveau/nouveau_backlight.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> index ae2f2abc8f5a..ccd080ba30bf 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> @@ -46,8 +46,8 @@ static bool
>  nouveau_get_backlight_name(char backlight_name[BL_NAME_SIZE],
>                            struct nouveau_backlight *bl)
>  {
> -       const int nb = ida_simple_get(&bl_ida, 0, 0, GFP_KERNEL);
> -       if (nb < 0 || nb >= 100)
> +       const int nb = ida_alloc_max(&bl_ida, 99, GFP_KERNEL);
> +       if (nb < 0)
>                 return false;
>         if (nb > 0)
>                 snprintf(backlight_name, BL_NAME_SIZE, "nv_backlight%d",
> nb);
> @@ -414,7 +414,7 @@ nouveau_backlight_init(struct drm_connector *connector)
>                                             nv_encoder, ops, &props);
>         if (IS_ERR(bl->dev)) {
>                 if (bl->id >= 0)
> -                       ida_simple_remove(&bl_ida, bl->id);
> +                       ida_free(&bl_ida, bl->id);
>                 ret = PTR_ERR(bl->dev);
>                 goto fail_alloc;
>         }
> @@ -442,7 +442,7 @@ nouveau_backlight_fini(struct drm_connector *connector)
>                 return;
>  
>         if (bl->id >= 0)
> -               ida_simple_remove(&bl_ida, bl->id);
> +               ida_free(&bl_ida, bl->id);
>  
>         backlight_device_unregister(bl->dev);
>         nv_conn->backlight = NULL;

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

