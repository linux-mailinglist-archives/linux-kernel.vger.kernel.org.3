Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B142A4DB1E3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353441AbiCPNxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbiCPNxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:53:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC6364BE1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:52:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id C1E881F44628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647438737;
        bh=FqvajMGnxRjtpeh5DO1PC1ggOMUMBHDf7570Spd3GV0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V+rSKskSoX2RTbQWfBTESQ8eTq8joYpfqPvvw3zETS2u/Mm6WrV6YTF6b1wer64p7
         VY1qY7+ww2l6tgnJWoGPN9umMFhRMjfXvxPeXLcLXqfPiFWqWO+PU5oMSCsf6zyYeH
         pX/Ti8PiKa6pv5HD5iuvJ4HmxOIy05LikmRqJjtdwxxGJpOgPZ+57jxZhmB9jYBJ8I
         fHLRakOJkqWtFx/SAD59BDDhdVDR9ww3eGjByonf8eQjyOR36ti1Ijuj+QKAgef8JQ
         LU5ulPaoeapDLy/MTrJz+k2hny+szY/aw0VEYLjVdrqSUsbXrjL8FbQNfzn1EuWiBE
         h+Nhfsa6BP9Ug==
Message-ID: <13f77cd8-ed57-3593-ab21-dafce91ee85e@collabora.com>
Date:   Wed, 16 Mar 2022 16:52:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 4/8] drm/virtio: Improve DMA API usage for shmem BOs
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
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
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        dri-devel@lists.freedesktop.org, Dmitry Osipenko <digetx@gmail.com>
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
 <20220314224253.236359-5-dmitry.osipenko@collabora.com>
 <f2fed903-c61b-8040-ddfd-25a7bf0a625a@arm.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <f2fed903-c61b-8040-ddfd-25a7bf0a625a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/16/22 15:41, Robin Murphy wrote:
> On 2022-03-14 22:42, Dmitry Osipenko wrote:
>> DRM API requires the DRM's driver to be backed with the device that can
>> be used for generic DMA operations. The VirtIO-GPU device can't perform
>> DMA operations if it uses PCI transport because PCI device driver creates
>> a virtual VirtIO-GPU device that isn't associated with the PCI. Use PCI's
>> GPU device for the DRM's device instead of the VirtIO-GPU device and drop
>> DMA-related hacks from the VirtIO-GPU driver.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>   drivers/gpu/drm/virtio/virtgpu_drv.c    | 22 +++++++---
>>   drivers/gpu/drm/virtio/virtgpu_drv.h    |  5 +--
>>   drivers/gpu/drm/virtio/virtgpu_kms.c    |  7 ++--
>>   drivers/gpu/drm/virtio/virtgpu_object.c | 56 +++++--------------------
>>   drivers/gpu/drm/virtio/virtgpu_vq.c     | 13 +++---
>>   5 files changed, 37 insertions(+), 66 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c
>> b/drivers/gpu/drm/virtio/virtgpu_drv.c
>> index 5f25a8d15464..8449dad3e65c 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
>> @@ -46,9 +46,9 @@ static int virtio_gpu_modeset = -1;
>>   MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
>>   module_param_named(modeset, virtio_gpu_modeset, int, 0400);
>>   -static int virtio_gpu_pci_quirk(struct drm_device *dev, struct
>> virtio_device *vdev)
>> +static int virtio_gpu_pci_quirk(struct drm_device *dev)
>>   {
>> -    struct pci_dev *pdev = to_pci_dev(vdev->dev.parent);
>> +    struct pci_dev *pdev = to_pci_dev(dev->dev);
>>       const char *pname = dev_name(&pdev->dev);
>>       bool vga = (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
>>       char unique[20];
>> @@ -101,6 +101,7 @@ static int virtio_gpu_pci_quirk(struct drm_device
>> *dev, struct virtio_device *vd
>>   static int virtio_gpu_probe(struct virtio_device *vdev)
>>   {
>>       struct drm_device *dev;
>> +    struct device *dma_dev;
>>       int ret;
>>         if (drm_firmware_drivers_only() && virtio_gpu_modeset == -1)
>> @@ -109,18 +110,29 @@ static int virtio_gpu_probe(struct virtio_device
>> *vdev)
>>       if (virtio_gpu_modeset == 0)
>>           return -EINVAL;
>>   -    dev = drm_dev_alloc(&driver, &vdev->dev);
>> +    /*
>> +     * If GPU's parent is a PCI device, then we will use this PCI device
>> +     * for the DRM's driver device because GPU won't have PCI's IOMMU
>> DMA
>> +     * ops in this case since GPU device is sitting on a separate
>> (from PCI)
>> +     * virtio-bus.
>> +     */
>> +    if (!strcmp(vdev->dev.parent->bus->name, "pci"))
> 
> Nit: dev_is_pci() ?

Yes, thank you.

> However, what about other VirtIO transports? Wouldn't virtio-mmio with
> F_ACCESS_PLATFORM be in a similar situation?

I couldn't find anyone using virtio-mmio for the GPU, both Qemu and
crosvm support only PCI transport for GPU.

But I'm now looking at virtio_mmio_probe() and see that virtio-mmio
devices actually should be in the exactly same position as PCI devices.
So you should be right and we need to use vdev->dev.parent for the DRM
device universally. I'll improve it in the v3, thank you again.
