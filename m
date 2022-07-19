Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B6D5797B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbiGSKb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiGSKbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 107EA3FA10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658226682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pulf+GTQxk5uin6YUOuCzeis2FI3CtuvGLbmZk5/0oY=;
        b=h63D6aj5gTLJX/X1wLLG07Csoo65t6QHxJGH4TC+Z6Tn0SCZUlPux+GlpS2SzxbRzdZNoY
        Jkf8zLO3OpWf06++QB2Isu5dOVHVu1tYQ7DZFHzBcyACRH0bZwdFZFzlQy/eUo72y2PEr/
        NFQC5hBCLuGS+B/wG0GpqX1mNM//Ed4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-Quqbb-BjMrWIOgrgNYImrA-1; Tue, 19 Jul 2022 06:31:08 -0400
X-MC-Unique: Quqbb-BjMrWIOgrgNYImrA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AC8F8039A2;
        Tue, 19 Jul 2022 10:31:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0460492C3B;
        Tue, 19 Jul 2022 10:31:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 62DE21800098; Tue, 19 Jul 2022 12:31:06 +0200 (CEST)
Date:   Tue, 19 Jul 2022 12:31:06 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     kernel@collabora.com, David Airlie <airlied@linux.ie>,
        Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        virtualization@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v7 7/9] drm/virtio: Improve DMA API usage for shmem BOs
Message-ID: <20220719103106.gttro4tjjbis6pgg@sirius.home.kraxel.org>
References: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
 <20220630200726.1884320-8-dmitry.osipenko@collabora.com>
 <20220705135323.emr4gdbcxoisdcxe@sirius.home.kraxel.org>
 <d2c64d09-c4bb-9aed-069d-a9b4d07a1f66@collabora.com>
 <20220705154507.67ovlun4m26xzppn@sirius.home.kraxel.org>
 <1380526d-17fb-6eb2-0fd5-5cddbdf0a92e@collabora.com>
 <20220706071301.43fvbioka4iksqup@sirius.home.kraxel.org>
 <05a5608b-899d-71de-a7d7-406334c5604b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a5608b-899d-71de-a7d7-406334c5604b@collabora.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:22:52AM +0300, Dmitry Osipenko wrote:
> On 7/6/22 10:13, Gerd Hoffmann wrote:
> >   Hi,
> > 
> >> Gerd, thank you very much! It's was indeed unclear to me how to test the
> >> MMIO GPU, but yours variant with microvm works! I was looking for trying
> >> aarch64 in the past, but it also was unclear how to do it since there is
> >> no DT support for the VirtIO-GPU, AFAICS.
> > 
> > aarch64 uses acpi by default (can be disabled via 'qemu -no-acpi').
> > Not fully sure about arm(v7).
> > 
> > Even with DT it should work because DT only describes the virtio-mmio
> > 'slots', not the actual virtio devices.
> > 
> >> There is no virgl support because it's a virtio-gpu-device and not
> >> virtio-gpu-device-gl that is PCI-only in Qemu. Hence everything seems good.
> > 
> > It's named 'virtio-gpu-gl-device'
> 
> Ah, thanks again! Just quickly tested virtio-gpu-gl-device and
> everything works too for MMIO GPU on microvm, including virgl and Xorg
> (glamor).
> 
> [drm] features: +virgl +edid -resource_blob -host_visible
> [drm] features: -context_init
> [drm] number of scanouts: 1
> [drm] number of cap sets: 2
> [drm] cap set 0: id 1, max-version 1, max-size 308
> [drm] cap set 1: id 2, max-version 2, max-size 696
> [drm] Initialized virtio_gpu 0.1.0 0 for LNRO0005:01 on minor 0
> virtio-mmio LNRO0005:01: [drm] drm_plane_enable_fb_damage_clips() not called

Cool.  Havn't found the time to try s390x, so I'm taking that as good
enough test that we don't have any unnoticed dependencies on pci.

Queued up.  I'll go over a few more pending patches, and assuming no
issues show up in testing this should land in drm-misc-next in a few
hours.

take care,
  Gerd

