Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97E44D9BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348543AbiCONGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348532AbiCONG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:06:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC99517D0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:05:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id EE84C1F415A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647349504;
        bh=b7ZAtAzK1nmdrxrEfagaapYt3BcO4V9nmCc81ZlA8+s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UpTmq7KjH1lO5fZ8TVawUj8c5D3flmcQqfy+Xh2LeKvmX/PNoL4xP3Q07QB90NfV4
         /d6U6S51BoASb6nVFrBSD4EYOowNwhPAbeS1FjMy129p5rNF+5kNFafpKBF3F+5zwM
         cVbgSR240nMYYtje9zeZ5dCfHaCuPkAsOOtXkiSA6ztnB8df9B2/5yij1kR/h359hq
         ABBQuqjl0uvpPptAHOHG3v9vBcabi/EPKN20FWf5/33FyhKJKPZQM3KEz6Li5b9PsS
         JVJbB+tzccrIxRs0/0Z+YIB9RsFJS0xhKPvQWYyuyC9/WWWUmRrWqH6y0RyxYw87HZ
         Jn1AayjVUOU6A==
Message-ID: <1b6f21ce-1677-9d6e-f036-973a7f98a298@collabora.com>
Date:   Tue, 15 Mar 2022 16:05:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 1/8] drm/virtio: Correct drm_gem_shmem_get_sg_table()
 error handling
Content-Language: en-US
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
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
        Emil Velikov <emil.l.velikov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
 <20220314224253.236359-2-dmitry.osipenko@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220314224253.236359-2-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/15/22 01:42, Dmitry Osipenko wrote:
> drm_gem_shmem_get_sg_table() never ever returned NULL on error. Correct
> the error handling to avoid crash on OOM.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index f293e6ad52da..bea7806a3ae3 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -168,9 +168,11 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
>  	 * since virtio_gpu doesn't support dma-buf import from other devices.
>  	 */
>  	shmem->pages = drm_gem_shmem_get_sg_table(&bo->base);
> -	if (!shmem->pages) {
> +	ret = PTR_ERR(shmem->pages);

This actually needs to be PTR_ERR_OR_ZERO. This code is changed to use
drm_gem_shmem_get_pages_sgt()+IS_ERR() by the further patch, so I just
missed the typo previously. I'll correct it in v3.
