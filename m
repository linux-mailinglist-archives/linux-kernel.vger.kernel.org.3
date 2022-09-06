Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A200E5AF460
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIFTZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiIFTZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:25:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DBB6DAE0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:25:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id ay12so7410092wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 12:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=O7HFSBd6XXtgczqxk8rJIEgRQ1dsVZ7RdrRe4zB43BQ=;
        b=W6LImk3qCnRM04osl5Ur9jTV8Nl1Pnmr0Q8v74EVcYgRMeGZoxuj7cW7rcgLX4jrMf
         Eiyos7XlKMjnaJ52wkEG5ubnR6BRrd3VMTPFNCUmMAT2Jb4HTfrS3djtJhyKvAz7j2xw
         JCnw2JfKE0ELWOtcwLu7+o9JrkvzXBCztp1O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=O7HFSBd6XXtgczqxk8rJIEgRQ1dsVZ7RdrRe4zB43BQ=;
        b=lg4UnvCCSnemCk8I70y+m+YCDZWma46KKshVx8+NNai9tQKoJMBqwkKYT7CEp1qQgI
         bYpWcMi1CS3MjjikPwSooo/Hj/3xjy8fKGDVpZcFbL/b0h6hj/uML6cNzKKo4g/MCLwz
         FdFD+J9Yn0cP3GA94lgEQXIktq4cZ9Wj+yPBjjJ2Tkk06x3NAVMVDk44DXMnnU1zkrlH
         Gt8aQhCK8oqhVB700rq1owcp3v8Ae/NSrw7uiYNNrtSUyvAnryiC2Faa2f8VJvSvwp1W
         1L7uZwI0H0qTyO4GoTU1/CqUQQrXzU8R52wu/b66EaGv+bwJROHT9pFeqf6DDkBlKroK
         uA8w==
X-Gm-Message-State: ACgBeo31bNYaxgnRyM8MgIRMyK9ZQ/9oBWnTytNsEfTHLEXVNp7BVHRH
        i+6pukc+KC3NSO7ajggiM8gkkQ==
X-Google-Smtp-Source: AA6agR6y8oDo3luv78yosJfIkhgfExQRhucenfJOK7BenFEnE+87Wy3bt6e6H/YvRgAnXmqYxPzIwg==
X-Received: by 2002:a05:600c:3ac6:b0:3a5:c03f:510d with SMTP id d6-20020a05600c3ac600b003a5c03f510dmr14693176wms.120.1662492320836;
        Tue, 06 Sep 2022 12:25:20 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id p8-20020a1c5448000000b003a63a3b55c3sm22643853wmi.14.2022.09.06.12.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:25:20 -0700 (PDT)
Date:   Tue, 6 Sep 2022 21:25:18 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Alisa Khabibrakhmanova <khabibrakhmanova@ispras.ru>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] drm/via: Add new condition to via_dma_cleanup()
Message-ID: <YxeengBAncBqNab0@phenom.ffwll.local>
Mail-Followup-To: Alisa Khabibrakhmanova <khabibrakhmanova@ispras.ru>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
References: <YuAjDvYey1hhI1AJ@ravnborg.org>
 <20220729090643.240778-1-khabibrakhmanova@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729090643.240778-1-khabibrakhmanova@ispras.ru>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 12:06:43PM +0300, Alisa Khabibrakhmanova wrote:
> Pointer dev_priv->mmio, which was checked for NULL at via_do_init_map(),
> is passed to via_do_cleanup_map() and is dereferenced there without check.
> 
> The patch adds the condition in via_dma_cleanup() which prevents potential NULL
> pointer dereference.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 22f579c621e2 ("drm: Add via unichrome support")
> Signed-off-by: Alisa Khabibrakhmanova <khabibrakhmanova@ispras.ru>

This seems to have fallen through cracks, I applied it to drm-misc-next
now.

Thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/via/via_dri1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/via/via_dri1.c b/drivers/gpu/drm/via/via_dri1.c
> index d695d9291ece..691e3ceb0062 100644
> --- a/drivers/gpu/drm/via/via_dri1.c
> +++ b/drivers/gpu/drm/via/via_dri1.c
> @@ -2961,7 +2961,7 @@ int via_dma_cleanup(struct drm_device *dev)
>  		drm_via_private_t *dev_priv =
>  		    (drm_via_private_t *) dev->dev_private;
>  
> -		if (dev_priv->ring.virtual_start) {
> +		if (dev_priv->ring.virtual_start && dev_priv->mmio) {
>  			via_cmdbuf_reset(dev_priv);
>  
>  			drm_legacy_ioremapfree(&dev_priv->ring.map, dev);
> -- 
> 2.34.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
