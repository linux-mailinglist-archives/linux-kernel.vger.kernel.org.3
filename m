Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D84D9051
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbiCNX1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiCNX1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:27:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2D43B551
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:26:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 379461F433AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647300370;
        bh=x8lO7dndy69NlEFUnZVKtUz8PSJBYw2u9qurEt77Vsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+dcmDZCNTDph2K+zp5okl/Ae4m+f/HMMa4eOTa7hDDJW0Ns/dkJY4eFiEVciL7lD
         aVoGX1VRUERwLeiXVd8iipVskwhB67RogoQp2Q9MMrVV3dWWqb958m+DUIq9haf0/U
         /wdOQGxOXhdjCh+kBLVNEujv45EZXyHQy414JOqgcJ+8uVDHg16AGf6bqc5QdvBe0B
         2hkUjdk3EVqHua4taq3f0w/j8zRnRCoh8yVuH0WDF60ljaCssnrcZJo14eQc685dzK
         hUAJYrb8c6PFlooACVb4xJ+IAvgGDbGWoe/XcIA/tLih9GM6grNdxYzZdXvQHfZIHy
         f5zYTAOFRmevg==
Date:   Mon, 14 Mar 2022 19:26:00 -0400
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 8/8] drm/panfrost: Switch to generic memory shrinker
Message-ID: <Yi/PCCQqvxA6aHzA@maud>
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
 <20220314224253.236359-9-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314224253.236359-9-dmitry.osipenko@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 01:42:53AM +0300, Dmitry Osipenko wrote:
> Replace Panfrost's memory shrinker with a generic DRM memory shrinker.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/Makefile          |  1 -
>  drivers/gpu/drm/panfrost/panfrost_device.h |  4 ----
>  drivers/gpu/drm/panfrost/panfrost_drv.c    | 19 ++-------------
>  drivers/gpu/drm/panfrost/panfrost_gem.c    | 27 ++++++++++++++--------
>  drivers/gpu/drm/panfrost/panfrost_gem.h    |  9 --------
>  drivers/gpu/drm/panfrost/panfrost_job.c    | 22 +++++++++++++++++-
>  6 files changed, 40 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/Makefile b/drivers/gpu/drm/panfrost/Makefile
> index b71935862417..ecf0864cb515 100644
> --- a/drivers/gpu/drm/panfrost/Makefile
> +++ b/drivers/gpu/drm/panfrost/Makefile
> @@ -5,7 +5,6 @@ panfrost-y := \
>  	panfrost_device.o \
>  	panfrost_devfreq.o \
>  	panfrost_gem.o \
> -	panfrost_gem_shrinker.o \
>  	panfrost_gpu.o \
>  	panfrost_job.o \
>  	panfrost_mmu.o \

I'm not sure you actually deleted gem_shrinker anywhere in this patch?
Diff stat is too small.
