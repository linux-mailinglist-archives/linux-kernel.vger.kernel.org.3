Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D27560C31
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiF2WPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiF2WPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:15:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10F6344FB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 15:15:41 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 38C876601926;
        Wed, 29 Jun 2022 23:15:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656540939;
        bh=bhZaA7/Smyh0XRFzLMtb69xiZ0vjfNMCv3A/P8IEc9A=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=GQAFeGCODBDvgPPPfTOVe6b1O0JI9XmFrldGCjBUVPpAve5u+tifIgw3p+z0dsSzn
         MsxeZ2Ls/EYGoOsHY1YAnAcveilANEz78hi5n/PG/HP0KZJLqMOtqzSVfBCyGkxQ50
         xVSwZ5CQMESPmzX2ZM+6zPRXJzxSRRU3mfxZLAe1CG+bnEaAVlLBUtfkY0p9pcyULc
         x0ib1AUlTSxC6M5gkhLw3zCsDw3SygmqdR9bI1xDJTZbQSAY0qqAPaCrq3jIxv29cS
         +tG2oDLZ12JWyDK6dNCjpDP151J9EGvoV503417rLmNtSbA7XoHSsryKTSATTIpHLW
         JmyGkm/q6YKxg==
Message-ID: <d2852b09-7613-3d6c-fec7-7cf9fdf959ed@collabora.com>
Date:   Thu, 30 Jun 2022 01:15:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] drm/virtio: Fix NULL vs IS_ERR checking in
 virtio_gpu_object_shmem_init
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>, David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220602104223.54527-1-linmq006@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220602104223.54527-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/22 13:42, Miaoqian Lin wrote:
> Since drm_prime_pages_to_sg() function return error pointers.
> The drm_gem_shmem_get_sg_table() function returns error pointers too.
> Using IS_ERR() to check the return value to fix this.
> 
> Fixes: 2f2aa13724d5 ("drm/virtio: move virtio_gpu_mem_entry initialization to new function")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - Update Fixes tag.
> - rebase the working tree.
> v1 Link: https://lore.kernel.org/all/20211222072649.18169-1-linmq006@gmail.com/
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index f293e6ad52da..1cc8f3fc8e4b 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -168,9 +168,9 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
>  	 * since virtio_gpu doesn't support dma-buf import from other devices.
>  	 */
>  	shmem->pages = drm_gem_shmem_get_sg_table(&bo->base);
> -	if (!shmem->pages) {
> +	if (IS_ERR(shmem->pages)) {
>  		drm_gem_shmem_unpin(&bo->base);
> -		return -EINVAL;
> +		return PTR_ERR(shmem->pages);
>  	}
>  
>  	if (use_dma_api) {

Sorry for noticing this late. This patch is incorrect because
shmem->pages must be NULLed on error, otherwise
virtio_gpu_cleanup_object() will crash :/

I also had a patch that fixes this problem [1] and it did it properly. I
see that this patch is in -next already, so will update my patch to fix
the fix now.

[1]
https://vanko.io/project/dri-devel/patch/20220526235040.678984-6-dmitry.osipenko@collabora.com/

-- 
Best regards,
Dmitry
