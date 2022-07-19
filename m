Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E057A6CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiGSS4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGSS4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:56:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704DA27CD0;
        Tue, 19 Jul 2022 11:56:15 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A48B366019F4;
        Tue, 19 Jul 2022 19:56:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658256973;
        bh=Pmpn1KNodZGi3VW2Y2bnZCKePhymp3labejgNlq3r8I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GO9pxN3Fbw/c0pt1D/zMDFY2ys9X+ZsZ0CV7fMCGE2ELu0ZugrwevglWrR2cuqpD/
         KHFz3HwRE/SWP1cpet3PAZtDcLUCm6i3LxZzLcZmxiFKMAfcrPoIfeE1+e5jJSISjS
         CEF/aaKp4x3JW81fnP2axbdi+/ZWrHpfYew+JQnslN4gtTTg/PFNAj+4Rue33vdeXJ
         Zvg+v+zIS+7AIui/PCX7L7LL834VxjxAIYeFDGzZNZ9mQ1K6SMTLhWY4qncaPCPoxe
         qo/r1Rbr+DMS0JuPSH2zRguKXNC7T4zbhMnOCInL9GV93rseG6GOv+MbAWfQVTZJb9
         FqOi+Saf0NNAA==
Message-ID: <c5beb186-96d3-59d7-fad8-987bb8125de1@collabora.com>
Date:   Tue, 19 Jul 2022 21:56:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 09/13] drm/gem: Add LRU/shrinker helper
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
References: <20220719171900.289265-1-robdclark@gmail.com>
 <20220719171900.289265-10-robdclark@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220719171900.289265-10-robdclark@gmail.com>
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

On 7/19/22 20:18, Rob Clark wrote:
> +void
> +drm_gem_lru_move_tail_locked(struct drm_gem_lru *lru, struct drm_gem_object *obj)
> +{
> +	WARN_ON(!mutex_is_locked(lru->lock));

Nit: What about lockdep_assert_held_once(&lru->lock->base)) ?

Otherwise, looks good! I'll use it for the DRM-SHMEM shrinker after
completing the work on the dma-buf locks.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
