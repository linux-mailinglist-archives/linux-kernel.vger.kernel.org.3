Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6371E5673C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiGEQD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiGEQDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:03:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4803F100A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 09:03:22 -0700 (PDT)
Received: from arch-x1c3 (cpc92308-cmbg19-2-0-cust99.5-4.cable.virginm.net [82.24.248.100])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: evelikov)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EDBAE6601638;
        Tue,  5 Jul 2022 17:03:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657037000;
        bh=PuRJwgghVrWRSi/gz8l232C34f7rDIf/ZjkluxP+eIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEjgCRzIRvo/SASMqeO8WsKm+7F5oUsdSCkNRG4IVKyViQojd/IVCpa3j+mgQwjFy
         +nVxTkIJN0x5pF2HDziGELT5nZnQMTa0tn4Kw1tGzc3Q5RsdPO6W3Hdbuf6NmGM2Zs
         G4M8sky9c1kPnwfzELGHUss/BFz/cn4Jx99+y/SuK7z5m7a6SNAtK/o1t+n/7Z3+Ah
         2Jt55TVfcCFZZ9Ixn9FkQ/9gco+pQl6g+oppgXtjsv9jcgX/cD4BhlsBxWwCeucd3u
         MJmGTWvrVXSKZTWfICAFNzNn0nd5TzSE2WAK6H9n7LGJdOtgDeI9IQTWl1BhBxtEmp
         H601x76Bo6RJQ==
Date:   Tue, 5 Jul 2022 17:03:16 +0100
From:   Emil Velikov <emil.velikov@collabora.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        kernel@collabora.com, David Airlie <airlied@linux.ie>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas_os@shipmail.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        virtualization@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v7 7/9] drm/virtio: Improve DMA API usage for shmem BOs
Message-ID: <YsRgxDYyU/jpF1MV@arch-x1c3>
References: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
 <20220630200726.1884320-8-dmitry.osipenko@collabora.com>
 <20220705135323.emr4gdbcxoisdcxe@sirius.home.kraxel.org>
 <d2c64d09-c4bb-9aed-069d-a9b4d07a1f66@collabora.com>
 <20220705154507.67ovlun4m26xzppn@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705154507.67ovlun4m26xzppn@sirius.home.kraxel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/07/05, Gerd Hoffmann wrote:
>   Hi,
> 
> > > Also note that pci is not the only virtio transport we have.
> > 
> > The VirtIO indeed has other transports, but only PCI is really supported
> > in case of the VirtIO-GPU in kernel and in Qemu/crosvm, AFAICT. Hence
> > only the PCI transport was tested.
> 
> qemu -M microvm \
>   -global virtio-mmio.force-legacy=false \
>   -device virtio-gpu-device
> 
> Gives you a functional virtio-gpu device on virtio-mmio.
> 
> aarch64 virt machines support both pci and mmio too.
> s390x has virtio-gpu-ccw ...
> 

As the last person who was there - the problem is indeed when using
virtio on top of mmio. If that's no longer supported by the kernel then
the hacky code-path can be dropped.

Even in that case, I would suggest keeping it a separate commit.

HTH
Emil
