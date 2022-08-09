Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE0658DC3D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245166AbiHIQih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245210AbiHIQiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:38:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FD22F9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:38:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j1so14969934wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc;
        bh=egGjE4gcTI4ZNAZGDpX66ocjeXYssjsRdLj9YeQUY3E=;
        b=B2QyLmc8VlDweK2PI4k9RXc/p5vtr8UlqQgLseFuaJs384B8mnwGUPEznaOre+W8KU
         dCb2kUkiV9frQpsm2MK2hXcQd952unPYPqAxmcWOXJ7yNHPAE/spL/7omuzRabpV8JQa
         bFQK6DEtn7QbT/8vhHtXB4DtObuPnn38JsTgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=egGjE4gcTI4ZNAZGDpX66ocjeXYssjsRdLj9YeQUY3E=;
        b=etPWmxo7s527MzkK1+/uVMm8Zsmre7PW0oRYO3xIGeAfGspVDh30oDndqufpMOX10Y
         ZxHncwasgH5vjOF0fHZtmQi153VgjgW+aUkGjAJwLUzj9UuU0nRFnYkZ4WEe5XXpD82h
         x+q7kdAIPxwgp39mGcLb9mcAwrKNPlnzZnrexCLxiED15EnsaA/OmCQS933Fp+aDXCHE
         psxkbRyfYckryd8cNrPsxw5w5fbIpD7AAxgYOgrGJg/ivSVOrYn/zqetHCUsPi/ZMmVz
         a+Tr8dH85zfgxALTMwksAcJA7MeXedctOtbDx0FqwKVVtCcn8/4v5qS5E8lKqPBRdUaA
         KbGQ==
X-Gm-Message-State: ACgBeo0SQ5dNosZE04rpOHZZI+472Ns9OF+MgOCALS+rjxA3I5SJIMKZ
        rHov2BPLkXaWS5oyUmAm2U5qFg==
X-Google-Smtp-Source: AA6agR4ZFwXQZW5QC9CXMnKGH0wNYij8ek8dXvdT/548E2OvefRpOTikGrUr+rxEJ1dXgSkB0dxUFw==
X-Received: by 2002:a5d:5984:0:b0:220:5cb7:f772 with SMTP id n4-20020a5d5984000000b002205cb7f772mr14591665wri.3.1660063099331;
        Tue, 09 Aug 2022 09:38:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id s8-20020a05600c384800b003a503a64e5esm20550022wmr.15.2022.08.09.09.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 09:38:18 -0700 (PDT)
Date:   Tue, 9 Aug 2022 18:38:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
Subject: Re: [PATCH v7 1/2] drm/shmem-helper: Add missing vunmap on error
Message-ID: <YvKNeMJjOjy8B+YH@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@linux.ie>, Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
References: <20220630200058.1883506-1-dmitry.osipenko@collabora.com>
 <20220630200058.1883506-2-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630200058.1883506-2-dmitry.osipenko@collabora.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 11:00:57PM +0300, Dmitry Osipenko wrote:
> The vmapping of dma-buf may succeed, but DRM SHMEM rejects the IOMEM
> mapping, and thus, drm_gem_shmem_vmap_locked() should unvmap the IOMEM
> before erroring out.
> 
> Cc: stable@vger.kernel.org
> Fixes: 49a3f51dfeee ("drm/gem: Use struct dma_buf_map in GEM vmap ops and convert GEM backends")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Pushed to drm-misc-next-fixes, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 8ad0e02991ca..904fc893c905 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -302,6 +302,7 @@ static int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
>  		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
>  		if (!ret) {
>  			if (WARN_ON(map->is_iomem)) {
> +				dma_buf_vunmap(obj->import_attach->dmabuf, map);
>  				ret = -EIO;
>  				goto err_put_pages;
>  			}
> -- 
> 2.36.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
