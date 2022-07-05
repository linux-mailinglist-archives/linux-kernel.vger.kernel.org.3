Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8E8567A8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 01:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiGEXI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 19:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGEXIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 19:08:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93255654D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 16:08:52 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EEDD066015C8;
        Wed,  6 Jul 2022 00:08:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657062530;
        bh=WPOS98C1ww0h7wB7KgFVUb6rtlK2oW5qXdt8zEVQLug=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N7LGrGeSOIko5kkF72sygNNFT39CyshZm8kTw0mZ2MqISS2fFDrzoNnac+9PrU5pf
         4eegombBvVeNI/s7PuLSkI3bRvgO+qteC33drFOT/VyMMT4mz4RFpVyDx1NVba1jc/
         hbwksP4piUZr58sEzyF87b00UNBUZOP5MxOSqtAo3bCc1cK8ONDNvXEDMrgKtPPe9H
         MpwjB2D6/wmWjuQ04HLpwt07Hg6vicwf7onlWmvE1nS5PNXG4ErSF2+fXpZMugI88P
         TaS7d5HJczeWywpx3fd2Zwwx6IPIDeEYSkI9enCN9HSrz3BWrqewBqD0TWTtMdI9IU
         7ha4eh69MxKQg==
Message-ID: <005b1bc3-084c-2ae4-e30a-71b0f239cc67@collabora.com>
Date:   Wed, 6 Jul 2022 02:08:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 7/9] drm/virtio: Improve DMA API usage for shmem BOs
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
References: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
 <20220630200726.1884320-8-dmitry.osipenko@collabora.com>
 <20220705135323.emr4gdbcxoisdcxe@sirius.home.kraxel.org>
 <d2c64d09-c4bb-9aed-069d-a9b4d07a1f66@collabora.com>
 <20220705154507.67ovlun4m26xzppn@sirius.home.kraxel.org>
 <1380526d-17fb-6eb2-0fd5-5cddbdf0a92e@collabora.com>
 <CAF6AEGtE+3AbaJnSZ07VY0xMOJMNz6BSQ+mPKmPYLi_Z-CLAig@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAF6AEGtE+3AbaJnSZ07VY0xMOJMNz6BSQ+mPKmPYLi_Z-CLAig@mail.gmail.com>
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

On 7/6/22 00:39, Rob Clark wrote:
> On Tue, Jul 5, 2022 at 10:02 AM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> On 7/5/22 18:45, Gerd Hoffmann wrote:
>>>   Hi,
>>>
>>>>> Also note that pci is not the only virtio transport we have.
>>>>
>>>> The VirtIO indeed has other transports, but only PCI is really supported
>>>> in case of the VirtIO-GPU in kernel and in Qemu/crosvm, AFAICT. Hence
>>>> only the PCI transport was tested.
>>>
>>> qemu -M microvm \
>>>   -global virtio-mmio.force-legacy=false \
>>>   -device virtio-gpu-device
>>>
>>> Gives you a functional virtio-gpu device on virtio-mmio.
>>>
>>> aarch64 virt machines support both pci and mmio too.
>>> s390x has virtio-gpu-ccw ...
>>
>> Gerd, thank you very much! It's was indeed unclear to me how to test the
>> MMIO GPU, but yours variant with microvm works! I was looking for trying
>> aarch64 in the past, but it also was unclear how to do it since there is
>> no DT support for the VirtIO-GPU, AFAICS.
> 
> just a drive-by note, IME on aarch64 kernels, at least with crosvm,
> virtgpu is also a pci device.. the non-pci things in the guest kernel
> use dt, but devices on discoverable busses like pci don't need dt
> nodes (which is true also in the non-vm case)

Sure, I was only looking how to test MMIO GPU on aarch64. Since I
haven't a found a way to test MMIO back then, I concluded that the MMIO
case wasn't really well supported.

-- 
Best regards,
Dmitry
