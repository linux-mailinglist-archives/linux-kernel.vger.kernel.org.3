Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63876587189
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbiHATlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiHATls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:41:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601E1AE6B;
        Mon,  1 Aug 2022 12:41:47 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8D2A46601BA5;
        Mon,  1 Aug 2022 20:41:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659382905;
        bh=k5EraTwHAEVrhojLCqVx1FWHD2f7NGKvuhlO2ptrZ8c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gTmFFtTz0V1cbFEZIG4avYtl1KBj8ARpZgTTbHPEaLeBhlx5TS4UGiv6SIcSivaQG
         8COE65IXzErRaIgVt3NuVZmojRPcp6TNXfRBFXG9mtLvm8VfYOReoLhkdiRx73uew5
         cnx7ung2K2PXXjHs17F9WyeTjUoFAvA2nSy6fi5cPtPGpaDQSwONgPBz9Fx8wWWpal
         +p+6kyTyU4JxvKxtcmjTDQTc45JBY1nLRuUZARaGpCojqI50EOv94+NtwUEyJTovdx
         i25DDfP/GyqrarCky7ixFCXc9AgdXPkZ2gvy2ek5YU7lnc9q+rt7ij3kSo4ZjpVakw
         h3j2XjuKyWw9Q==
Message-ID: <def8e47c-067e-0841-4ae4-1eb90244cd50@collabora.com>
Date:   Mon, 1 Aug 2022 22:41:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 09/15] drm/gem: Add LRU/shrinker helper
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20220726175043.1027731-1-robdclark@gmail.com>
 <20220726175043.1027731-10-robdclark@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220726175043.1027731-10-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 20:50, Rob Clark wrote:
> +/**
> + * drm_gem_lru_remove - remove object from whatever LRU it is in
> + *
> + * If the object is currently in any LRU, remove it.
> + *
> + * @obj: The GEM object to remove from current LRU
> + */
> +void
> +drm_gem_lru_remove(struct drm_gem_object *obj)
> +{
> +	struct drm_gem_lru *lru = obj->lru;
> +
> +	if (!lru)
> +		return;
> +
> +	mutex_lock(lru->lock);
> +	lru_remove(obj);
> +	mutex_unlock(lru->lock);
> +}
> +EXPORT_SYMBOL(drm_gem_lru_remove);

I made a preliminary port of the DRM-SHMEM shrinker on top of the the
latest version of dma-buf locking convention and yours LRU patches. It
all works good, the only thing that is missing for the DRM-SHMEM
shrinker is the drm_gem_lru_remove_locked().

What about to add a locked variant of drm_gem_lru_remove()?

-- 
Best regards,
Dmitry
