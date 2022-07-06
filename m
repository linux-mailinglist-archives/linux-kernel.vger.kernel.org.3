Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72D6567FC1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiGFHW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiGFHW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:22:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7F51EC50
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:22:56 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B3DC26601824;
        Wed,  6 Jul 2022 08:22:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657092175;
        bh=ayN1i8IAMAQxYhOykmkICXFFTfeATWtbkUitRs8K+ZQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T62jIb1V2C8sQbpYcJA+qF7T854vJT7oRV2Vz63JL0a13ArqlOhHTHkwYqzLzRJC2
         zGniTbmsVxdBzsH1bSd8X4Au/+68TMl5QM0yRiuplU7JadVQq6WxJ/AvXPJP9Apk4t
         M0jpZePSuh2FY/G9zdwGGEqMZ3nuFqNW7KMMQn1jWjqMVpYstjdpElKZv2XdJcvt6S
         9Dyrva39LRwbPIEnQ6Bye3Ck9tuXXJTiRKJlTzV6vmI/Kwl317fyoVF/lQ6tSczn0c
         VXY+aKF38ukzJDH1HQDGpqjc1Q/oyZo0QMtQAQzFlje8M+jVRSMBKuXMXhkTC0F2cS
         X68yLxb3VG11g==
Message-ID: <05a5608b-899d-71de-a7d7-406334c5604b@collabora.com>
Date:   Wed, 6 Jul 2022 10:22:52 +0300
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
 <1380526d-17fb-6eb2-0fd5-5cddbdf0a92e@collabora.com>
 <20220706071301.43fvbioka4iksqup@sirius.home.kraxel.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220706071301.43fvbioka4iksqup@sirius.home.kraxel.org>
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

On 7/6/22 10:13, Gerd Hoffmann wrote:
>   Hi,
> 
>> Gerd, thank you very much! It's was indeed unclear to me how to test the
>> MMIO GPU, but yours variant with microvm works! I was looking for trying
>> aarch64 in the past, but it also was unclear how to do it since there is
>> no DT support for the VirtIO-GPU, AFAICS.
> 
> aarch64 uses acpi by default (can be disabled via 'qemu -no-acpi').
> Not fully sure about arm(v7).
> 
> Even with DT it should work because DT only describes the virtio-mmio
> 'slots', not the actual virtio devices.
> 
>> There is no virgl support because it's a virtio-gpu-device and not
>> virtio-gpu-device-gl that is PCI-only in Qemu. Hence everything seems good.
> 
> It's named 'virtio-gpu-gl-device'

Ah, thanks again! Just quickly tested virtio-gpu-gl-device and
everything works too for MMIO GPU on microvm, including virgl and Xorg
(glamor).

[drm] features: +virgl +edid -resource_blob -host_visible
[drm] features: -context_init
[drm] number of scanouts: 1
[drm] number of cap sets: 2
[drm] cap set 0: id 1, max-version 1, max-size 308
[drm] cap set 1: id 2, max-version 2, max-size 696
[drm] Initialized virtio_gpu 0.1.0 0 for LNRO0005:01 on minor 0
virtio-mmio LNRO0005:01: [drm] drm_plane_enable_fb_damage_clips() not called

-- 
Best regards,
Dmitry
