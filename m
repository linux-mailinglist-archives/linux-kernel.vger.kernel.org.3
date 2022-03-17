Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B544DBC0F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355665AbiCQBK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbiCQBKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:10:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814B71D0FE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:09:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id D9F171F448D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647479348;
        bh=FxghuLF6sBTGTVTBe9x2sblWdZvZVCLqJRlt5cOFOLY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FzGGcxvitUUwRBDmQRUySL1ki5h49AEbAWoQeF8EBdVKTFmU/g8MT9DYqFvo90q3g
         ml8DhY6v+Gg/TCAwIuuvHpk3xT3zqoi8X657n7O0eGIUX2p+kPIlm5F0YwTKUNpS3o
         GDO9azTbZ2DRcrSBVnOVgWvWN6Y2EFFjsYIGW3rWfgRWLPv87Gp4LRSqnpzt8wj7dH
         8G0dzuxanND32r7emgrJzMQEqrQfenK+DcT6DhcZdfWBQ8k2MIbEMOBSc/xlYDumGX
         +G9Kmxb1LtNs3c1hrbHa7mRJur+oijanmbUOe0bKlKwNTY1aWAuQx6jqx1qOk27hLS
         jI+FqxFZv1q0g==
Message-ID: <eb421bd0-0ff8-1ca6-b14a-2a9bde21c4d8@collabora.com>
Date:   Thu, 17 Mar 2022 04:09:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 4/8] drm/virtio: Improve DMA API usage for shmem BOs
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
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
 <20220314224253.236359-5-dmitry.osipenko@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220314224253.236359-5-dmitry.osipenko@collabora.com>
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
> DRM API requires the DRM's driver to be backed with the device that can
> be used for generic DMA operations. The VirtIO-GPU device can't perform
> DMA operations if it uses PCI transport because PCI device driver creates
> a virtual VirtIO-GPU device that isn't associated with the PCI. Use PCI's
> GPU device for the DRM's device instead of the VirtIO-GPU device and drop
> DMA-related hacks from the VirtIO-GPU driver.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c    | 22 +++++++---
>  drivers/gpu/drm/virtio/virtgpu_drv.h    |  5 +--
>  drivers/gpu/drm/virtio/virtgpu_kms.c    |  7 ++--
>  drivers/gpu/drm/virtio/virtgpu_object.c | 56 +++++--------------------
>  drivers/gpu/drm/virtio/virtgpu_vq.c     | 13 +++---
>  5 files changed, 37 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index 5f25a8d15464..8449dad3e65c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -46,9 +46,9 @@ static int virtio_gpu_modeset = -1;
>  MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
>  module_param_named(modeset, virtio_gpu_modeset, int, 0400);
>  
> -static int virtio_gpu_pci_quirk(struct drm_device *dev, struct virtio_device *vdev)
> +static int virtio_gpu_pci_quirk(struct drm_device *dev)

Somehow I missed that virtio_gpu_pci_quirk() contains comment telling
about why dev.parent isn't used for the DRM's device.

	/*
	 * Normally the drm_dev_set_unique() call is done by core DRM.
	 * The following comment covers, why virtio cannot rely on it.
	 *
	 * Unlike the other virtual GPU drivers, virtio abstracts the
	 * underlying bus type by using struct virtio_device.
	 *
	 * Hence the dev_is_pci() check, used in core DRM, will fail
	 * and the unique returned will be the virtio_device "virtio0",
	 * while a "pci:..." one is required.
	 *
	 * A few other ideas were considered:
	 * - Extend the dev_is_pci() check [in drm_set_busid] to
	 *   consider virtio.
	 *   Seems like a bigger hack than what we have already.
	 *
	 * - Point drm_device::dev to the parent of the virtio_device
	 *   Semantic changes:
	 *   * Using the wrong device for i2c, framebuffer_alloc and
	 *     prime import.
	 *   Visual changes:
	 *   * Helpers such as DRM_DEV_ERROR, dev_info, drm_printer,
	 *     will print the wrong information.
	 *
	 * We could address the latter issues, by introducing
	 * drm_device::bus_dev, ... which would be used solely for this.
	 *
	 * So for the moment keep things as-is, with a bulky comment
	 * for the next person who feels like removing this
	 * drm_dev_set_unique() quirk.
	 */

There is no I2C, nor prime import support and framebuffer_alloc hasn't
been used for years now. I guess prime import actually will want the
real device and not the virtio_device if GEM importing will be ever
supported by VirtIO-GPU driver. Apparently this comment was outdated a
long time ago and the "visual changes" aren't too important, the
messages now says "virtio-pci 0000:00:02.0" instead of "virtio_gpu virtio0".

I'll remove the comment and drm_dev_set_unique() quirk in v3.
