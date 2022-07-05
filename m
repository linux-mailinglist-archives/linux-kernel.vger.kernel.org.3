Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5375678F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiGEU4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiGEU42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:56:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBC720BC0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 13:56:24 -0700 (PDT)
Received: from arch-x1c3 (cpc92308-cmbg19-2-0-cust99.5-4.cable.virginm.net [82.24.248.100])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: evelikov)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1FA2D66015B5;
        Tue,  5 Jul 2022 21:56:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657054581;
        bh=NGQDvaVmdIquGOuzDM5Sp6an5+EZmtRa+tIGw27pvH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FlxkgauVNjOvx3H0gXYe5RcSLYYK08u4UK8GIHX6opp4EGTFQhd1cRxFaikKDLlbU
         gB7o2mAKtL77VBpQhqLWACR85JPO8Ch3dk6c3NbZUabwZLkChHPj+PAJRyFXnScVSH
         LhRovuODfN6tCCVhpU4NPGbcGyRXzzD5+DRP6nAUNcgKI4saVyx1RDo0Aj8ltNcq2X
         OnJ9cvokOxjcZ3cXoELUz4f4H1Jhm3JlVa4gtcBB/vgTIlQXjwG6YuZOXTTAB/GI/I
         dWCcfc4FYlE5RGRgvPgVP7Pk8B1d6tB0csAYitFGSOnkn5ZJCURKBgxnJD+74vGmxO
         Hi8I1/cwo8aLg==
Date:   Tue, 5 Jul 2022 21:56:17 +0100
From:   Emil Velikov <emil.velikov@collabora.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Laszlo Ersek <lersek@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, kernel@collabora.com,
        David Airlie <airlied@linux.ie>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas_os@shipmail.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        virtualization@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v7 7/9] drm/virtio: Improve DMA API usage for shmem BOs
Message-ID: <YsSlcStOXz2fnlON@arch-x1c3>
References: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
 <20220630200726.1884320-8-dmitry.osipenko@collabora.com>
 <20220705135323.emr4gdbcxoisdcxe@sirius.home.kraxel.org>
 <d2c64d09-c4bb-9aed-069d-a9b4d07a1f66@collabora.com>
 <20220705154507.67ovlun4m26xzppn@sirius.home.kraxel.org>
 <1380526d-17fb-6eb2-0fd5-5cddbdf0a92e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380526d-17fb-6eb2-0fd5-5cddbdf0a92e@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/07/05, Dmitry Osipenko wrote:
> On 7/5/22 18:45, Gerd Hoffmann wrote:
> >   Hi,
> > 
> >>> Also note that pci is not the only virtio transport we have.
> >>
> >> The VirtIO indeed has other transports, but only PCI is really supported
> >> in case of the VirtIO-GPU in kernel and in Qemu/crosvm, AFAICT. Hence
> >> only the PCI transport was tested.
> > 
> > qemu -M microvm \
> >   -global virtio-mmio.force-legacy=false \
> >   -device virtio-gpu-device
> > 
> > Gives you a functional virtio-gpu device on virtio-mmio.
> > 
> > aarch64 virt machines support both pci and mmio too.
> > s390x has virtio-gpu-ccw ...
> 
> Gerd, thank you very much! It's was indeed unclear to me how to test the
> MMIO GPU, but yours variant with microvm works! I was looking for trying
> aarch64 in the past, but it also was unclear how to do it since there is
> no DT support for the VirtIO-GPU, AFAICS.
> 
> I booted kernel with this patchset applied and everything is okay, Xorg
> works.
> 
>  [drm] Initialized virtio_gpu 0.1.0 0 for LNRO0005:01 on minor 0
>  virtio-mmio LNRO0005:01: [drm] drm_plane_enable_fb_damage_clips() not
> called
>  virtio-mmio LNRO0005:01: [drm] fb0: virtio_gpudrmfb frame buffer device
> 
> There is no virgl support because it's a virtio-gpu-device and not
> virtio-gpu-device-gl that is PCI-only in Qemu. Hence everything seems good.
> 
> I'd appreciate if you could give s390x a test.. I never touched s390x
> and it will probably take some extra effort to get into it.
> 

Adding Laszlo Ersek, who debugged and tested this the last time.

Laszlo Ersek do ypu have some tips for Dmitry? Xorg seems to be
working on his end with the drm_drv_set_unique(... "pci:...") call
removed.

Original patch can be found at:
https://lore.kernel.org/dri-devel/1380526d-17fb-6eb2-0fd5-5cddbdf0a92e@collabora.com/T/#mbc1a1bedc91d1855007188a725c5c75bbc771cf0

HTH
Emil
