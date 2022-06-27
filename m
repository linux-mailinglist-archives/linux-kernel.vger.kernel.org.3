Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C0355DA2E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbiF0Pur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbiF0Puj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2332A193E2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656345037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=d2N3t1uLLFd3tbeSCYzNndzlSKHoLHoiZV7zauWsqwQ=;
        b=SN6LFtaZA9loga4a+zsprkppHXSNgPe1rc/weX3p/Z0UjoQdM8+qAI2IeKPJN/l0PNXnsf
        L2RaRlqLjKPqEbo0YLG36z6tBz1euFyWY98sZZ1TjJbFWJp4awdLlTdvvduTtZEeDoPqbI
        Ue9B1ryDlGsA0tAiJzdPJiV2r+rKHNQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-XL8CLHhAO46U52eYmZniqg-1; Mon, 27 Jun 2022 11:50:36 -0400
X-MC-Unique: XL8CLHhAO46U52eYmZniqg-1
Received: by mail-ej1-f72.google.com with SMTP id l2-20020a170906078200b006fed42bfeacso2592306ejc.16
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=d2N3t1uLLFd3tbeSCYzNndzlSKHoLHoiZV7zauWsqwQ=;
        b=cbchlGkCktVQfJpX5c5xYBEU0n2x1M8JTqfNin2qyZuUSfNNle4yDVsSdp2bKn1WSF
         whq7hJqseucT6C1058SyVEKA2l/ULv7rgF6IDVLmHLs/uqxCuPL3FSNoVvdN9sjEHtPi
         VT+66RNWTYrIdQC04eVlrkYJixZOvvRl5OP79SGoawrF/R6u6o6H7kD4C4Aq4cO4kvTA
         z4vE36+pZ3+TzITt0McyIexsZvXAO1vuqe/XutBdUYvJdvS6B2LuMKNTgaDiV/7fGRJt
         tMo5HFZBAV4RTUZ4ODDIkR68+R9Dpzq7MOfYuyhv0IaTpyfVowtn1SKApvrnZwemfAPe
         F+2g==
X-Gm-Message-State: AJIora/7Eo3f+EevHF3y4Dk7RRtA9gf1sRjvxqYvf//y/qsQd8ej+Eme
        T85eaoqetLjzQxU2Bv1G8LBwoiecfT1pqw27tBCZtLhfmRLUEStKjHVbbPPieMbU0t5QkrHLVnG
        v2r2x/0miz3+aHmLF5xsfvMZc
X-Received: by 2002:a05:6402:2929:b0:435:6dfc:c4f2 with SMTP id ee41-20020a056402292900b004356dfcc4f2mr17235991edb.284.1656345034861;
        Mon, 27 Jun 2022 08:50:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t9WduttwuVIwVX53FDNgXbP08lIvO3IwG/IkW/gZFLxJ/LK30Gor89dpwiWdlE1Y3HvzMjUQ==
X-Received: by 2002:a05:6402:2929:b0:435:6dfc:c4f2 with SMTP id ee41-20020a056402292900b004356dfcc4f2mr17235967edb.284.1656345034631;
        Mon, 27 Jun 2022 08:50:34 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207e:1f30:b6f8:324d:b101:20ff])
        by smtp.gmail.com with ESMTPSA id c20-20020a056402101400b004358cec9ce1sm7776739edu.65.2022.06.27.08.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:50:33 -0700 (PDT)
Date:   Mon, 27 Jun 2022 11:50:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        elic@nvidia.com, eperezma@redhat.com, gautam.dawar@xilinx.com,
        huangjie.albert@bytedance.com, jasowang@redhat.com,
        liubo03@inspur.com, mst@redhat.com, parav@nvidia.com,
        sgarzare@redhat.com, stephan.gerhold@kernkonzept.com,
        wangdeming@inspur.com
Subject: [GIT PULL] virtio,vdpa: fixes
Message-ID: <20220627115024-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to c7cc29aaebf9eaa543b4c70801e0ecef1101b3c8:

  virtio_ring: make vring_create_virtqueue_split prettier (2022-06-27 08:05:35 -0400)

----------------------------------------------------------------
virtio,vdpa: fixes

Fixes all over the place, most notably we are disabling
IRQ hardening (again!).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Bo Liu (1):
      virtio: Remove unnecessary variable assignments

Deming Wang (1):
      virtio_ring: make vring_create_virtqueue_split prettier

Eli Cohen (2):
      vdpa/mlx5: Update Control VQ callback information
      vdpa/mlx5: Initialize CVQ vringh only once

Jason Wang (3):
      virtio: disable notification hardening by default
      virtio-net: fix race between ndo_open() and virtio_device_ready()
      caif_virtio: fix race between virtio_device_ready() and ndo_open()

Parav Pandit (1):
      vduse: Tie vduse mgmtdev and its device

Stefano Garzarella (1):
      vhost-vdpa: call vhost_vdpa_cleanup during the release

Stephan Gerhold (2):
      virtio_mmio: Add missing PM calls to freeze/restore
      virtio_mmio: Restore guest page size on resume

huangjie.albert (1):
      virtio_ring : keep used_wrap_counter in vq->last_used_idx

 drivers/net/caif/caif_virtio.c         | 10 +++-
 drivers/net/virtio_net.c               |  8 ++-
 drivers/s390/virtio/virtio_ccw.c       |  9 +++-
 drivers/vdpa/mlx5/net/mlx5_vnet.c      | 33 ++++++++-----
 drivers/vdpa/vdpa_user/vduse_dev.c     | 60 ++++++++++++++---------
 drivers/vhost/vdpa.c                   |  2 +-
 drivers/virtio/Kconfig                 | 13 +++++
 drivers/virtio/virtio.c                |  2 +
 drivers/virtio/virtio_mmio.c           | 26 ++++++++++
 drivers/virtio/virtio_pci_modern_dev.c |  2 -
 drivers/virtio/virtio_ring.c           | 89 +++++++++++++++++++++++-----------
 include/linux/virtio_config.h          |  2 +
 12 files changed, 187 insertions(+), 69 deletions(-)

