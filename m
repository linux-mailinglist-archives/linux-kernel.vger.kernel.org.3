Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA3567521
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiGERCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiGERC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:02:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E351F2F1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:02:16 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F238A660166D;
        Tue,  5 Jul 2022 18:02:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657040532;
        bh=l3lVYraeVRjfudV5BktsYjuOavhLJKEFAe1rgIjHK58=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mWg/MwfgtEriDXF2t98MRae4d5bqs3kk7Js+amAsZGsV6Ctdl6bGY1cpzpl+C4IPN
         PGzD493+kFEltUPLTV9RQFLOf3G7jZf/9eTxosnWS8/Vlu9LMt8RJFIentc/p8hnH8
         RjYB6oNaba4T5dh++v6AIuwpWcX9Dh61kglQ06dHR6i7/X9EKzaLQh5nTTAMCBzoTI
         LOoax3z6f5YnwXzPFvuxi8L9x9UQCDpS2WpBNR/rIINOOiLBfAki3t28B0CDXL7w03
         Pc352NJgO6eOyoOVWrcPjN26G0/gaw100OTLvr3yLiXjZyFkg35PeqvjvYMDenn0iq
         IrMEg7wGfO68A==
Message-ID: <1380526d-17fb-6eb2-0fd5-5cddbdf0a92e@collabora.com>
Date:   Tue, 5 Jul 2022 20:02:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 7/9] drm/virtio: Improve DMA API usage for shmem BOs
Content-Language: en-US
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     kernel@collabora.com, David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        virtualization@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
References: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
 <20220630200726.1884320-8-dmitry.osipenko@collabora.com>
 <20220705135323.emr4gdbcxoisdcxe@sirius.home.kraxel.org>
 <d2c64d09-c4bb-9aed-069d-a9b4d07a1f66@collabora.com>
 <20220705154507.67ovlun4m26xzppn@sirius.home.kraxel.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220705154507.67ovlun4m26xzppn@sirius.home.kraxel.org>
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

On 7/5/22 18:45, Gerd Hoffmann wrote:
>   Hi,
> 
>>> Also note that pci is not the only virtio transport we have.
>>
>> The VirtIO indeed has other transports, but only PCI is really supported
>> in case of the VirtIO-GPU in kernel and in Qemu/crosvm, AFAICT. Hence
>> only the PCI transport was tested.
> 
> qemu -M microvm \
>   -global virtio-mmio.force-legacy=false \
>   -device virtio-gpu-device
> 
> Gives you a functional virtio-gpu device on virtio-mmio.
> 
> aarch64 virt machines support both pci and mmio too.
> s390x has virtio-gpu-ccw ...

Gerd, thank you very much! It's was indeed unclear to me how to test the
MMIO GPU, but yours variant with microvm works! I was looking for trying
aarch64 in the past, but it also was unclear how to do it since there is
no DT support for the VirtIO-GPU, AFAICS.

I booted kernel with this patchset applied and everything is okay, Xorg
works.

 [drm] Initialized virtio_gpu 0.1.0 0 for LNRO0005:01 on minor 0
 virtio-mmio LNRO0005:01: [drm] drm_plane_enable_fb_damage_clips() not
called
 virtio-mmio LNRO0005:01: [drm] fb0: virtio_gpudrmfb frame buffer device

There is no virgl support because it's a virtio-gpu-device and not
virtio-gpu-device-gl that is PCI-only in Qemu. Hence everything seems good.

I'd appreciate if you could give s390x a test.. I never touched s390x
and it will probably take some extra effort to get into it.

-- 
Best regards,
Dmitry
