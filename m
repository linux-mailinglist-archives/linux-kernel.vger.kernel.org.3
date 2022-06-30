Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB1D5623FF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbiF3UPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiF3UPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:15:21 -0400
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5791443E9;
        Thu, 30 Jun 2022 13:15:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 287903FBC7;
        Thu, 30 Jun 2022 22:15:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.11
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zMRp0Gpm_aAo; Thu, 30 Jun 2022 22:15:14 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 9F1973F2B6;
        Thu, 30 Jun 2022 22:15:11 +0200 (CEST)
Received: from [192.168.0.209] (h-155-4-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 17C36362576;
        Thu, 30 Jun 2022 22:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1656620111; bh=4c+nxp1qLKRL4M+Rz8maAK/c0bGA3bi5lIsZV+iAH9g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=onHF8Fi28t/842R78D+UlPauOYwI7CxxedzxutH5Boka9+X2FsfwDSuwq5JHZOD1T
         oTppCghKwsgmjgvQtGbqHOImhhF3gtDbhSZCD8f4GfcjvW87PGfYdF2C7okdELmdo/
         65NRuAdsEEZbsrTlQMgaqipY9gkxo+X6qL/bUyio=
Message-ID: <75b677b6-c704-e270-c921-93c982020c38@shipmail.org>
Date:   Thu, 30 Jun 2022 22:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 2/2] drm/gem: Don't map imported GEMs
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org, kernel@collabora.com,
        virtualization@lists.linux-foundation.org
References: <20220630200405.1883897-1-dmitry.osipenko@collabora.com>
 <20220630200405.1883897-3-dmitry.osipenko@collabora.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
In-Reply-To: <20220630200405.1883897-3-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dmitry,

On 6/30/22 22:04, Dmitry Osipenko wrote:
> Drivers that use drm_gem_mmap() and drm_gem_mmap_obj() helpers don't
> handle imported dma-bufs properly, which results in mapping of something
> else than the imported dma-buf. On NVIDIA Tegra we get a hard lockup when
> userspace writes to the memory mapping of a dma-buf that was imported into
> Tegra's DRM GEM.
>
> Majority of DRM drivers prohibit mapping of the imported GEM objects.
> Mapping of imported GEMs require special care from userspace since it
> should sync dma-buf because mapping coherency of the exporter device may
> not match the DRM device. Let's prohibit the mapping for all DRM drivers
> for consistency.
>
> Cc: stable@vger.kernel.org
> Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

This might break drivers whose obj->funcs->mmap() callback already 
handles this case, and has userspace that does the right thing.

I think the disabling must be checked on a per-driver basis to avoid 
that; in particular drivers that already call dma_buf_mmap() should be 
able to continue doing this.

Also the Fixes: review comment remains,

thanks,

Thomas



> ---
>   drivers/gpu/drm/drm_gem.c              | 4 ++++
>   drivers/gpu/drm/drm_gem_shmem_helper.c | 9 ---------
>   2 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 86d670c71286..fc9ec42fa0ab 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1034,6 +1034,10 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
>   {
>   	int ret;
>   
> +	/* Don't allow imported objects to be mapped */
> +	if (obj->import_attach)
> +		return -EINVAL;
> +
>   	/* Check for valid size. */
>   	if (obj_size < vma->vm_end - vma->vm_start)
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 8ad0e02991ca..6190f5018986 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -609,17 +609,8 @@ EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
>    */
>   int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct *vma)
>   {
> -	struct drm_gem_object *obj = &shmem->base;
>   	int ret;
>   
> -	if (obj->import_attach) {
> -		/* Drop the reference drm_gem_mmap_obj() acquired.*/
> -		drm_gem_object_put(obj);
> -		vma->vm_private_data = NULL;
> -
> -		return dma_buf_mmap(obj->dma_buf, vma, 0);
> -	}
> -
>   	ret = drm_gem_shmem_get_pages(shmem);
>   	if (ret) {
>   		drm_gem_vm_close(vma);
