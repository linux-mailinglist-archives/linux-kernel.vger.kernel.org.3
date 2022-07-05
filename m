Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAD15672FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiGEPpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiGEPph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0397318E04
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657035918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8LevNv3Hf68ZwMaX/GpqTB2JxrZ9cDDvu+Nb0ET+5is=;
        b=RUbCnqHcqMvbgD1fHiuAexYtWA9AqPiom2PdQ79TGjWONQJJUccTAQHDZyWx7pyzjkxVAj
        HP0ri99wv0kAMqhQSnjq37f5FqwprXDEeUyUXv2Y+sykVIxWSlLgie0DQoChMRj2YrHGcs
        kTrag+t7XKTBJPnZDWj1UIrekE8g5Ic=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-loLCFY4GMoicMdzRKYlMbQ-1; Tue, 05 Jul 2022 11:45:13 -0400
X-MC-Unique: loLCFY4GMoicMdzRKYlMbQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A3B1185A7B2;
        Tue,  5 Jul 2022 15:45:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B75ED404E4DC;
        Tue,  5 Jul 2022 15:45:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 173C31800083; Tue,  5 Jul 2022 17:45:07 +0200 (CEST)
Date:   Tue, 5 Jul 2022 17:45:07 +0200
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
Message-ID: <20220705154507.67ovlun4m26xzppn@sirius.home.kraxel.org>
References: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
 <20220630200726.1884320-8-dmitry.osipenko@collabora.com>
 <20220705135323.emr4gdbcxoisdcxe@sirius.home.kraxel.org>
 <d2c64d09-c4bb-9aed-069d-a9b4d07a1f66@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2c64d09-c4bb-9aed-069d-a9b4d07a1f66@collabora.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > Also note that pci is not the only virtio transport we have.
> 
> The VirtIO indeed has other transports, but only PCI is really supported
> in case of the VirtIO-GPU in kernel and in Qemu/crosvm, AFAICT. Hence
> only the PCI transport was tested.

qemu -M microvm \
  -global virtio-mmio.force-legacy=false \
  -device virtio-gpu-device

Gives you a functional virtio-gpu device on virtio-mmio.

aarch64 virt machines support both pci and mmio too.
s390x has virtio-gpu-ccw ...

take care,
  Gerd

