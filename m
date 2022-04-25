Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE48250D709
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbiDYCrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbiDYCri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:47:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8094B68F84
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650854675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+8C7DSgyJWy1q7RA6Qw/esnyL/KKYx1eZrXFTjxxJkw=;
        b=DzsPqbAuGAQhsI9XKqOscrzLIKTE8JGMij3SB6slwltWn/AzjyrtZFvYSZ/gTOxL//FabQ
        TAowpDs1fmMiBaBFz8x39wPjmbpmaYQNgHqu/CR0T+erexS3Tnvn4BKkhALrtzsvgQUHUC
        psop5+aV+hj9X37WuC5dANTAWuC1HU0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-D2672sSbN1W4TolXNzqmZQ-1; Sun, 24 Apr 2022 22:44:32 -0400
X-MC-Unique: D2672sSbN1W4TolXNzqmZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7373C802819;
        Mon, 25 Apr 2022 02:44:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-160.pek2.redhat.com [10.72.13.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A3AD7B7C;
        Mon, 25 Apr 2022 02:44:20 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     sgarzare@redhat.com, eperezma@redhat.com, lulu@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH V3 0/9] rework on the IRQ hardening of virtio
Date:   Mon, 25 Apr 2022 10:44:09 +0800
Message-Id: <20220425024418.8415-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

This is a rework on the IRQ hardening for virtio which is done
previously by the following commits are reverted:

9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
080cd7c3ac87 ("virtio-pci: harden INTX interrupts")

The reason is that it depends on the IRQF_NO_AUTOEN which may conflict
with the assumption of the affinity managed IRQ that is used by some
virtio drivers. And what's more, it is only done for virtio-pci but
not other transports.

In this rework, I try to implement a general virtio solution which
borrows the idea of the INTX hardening by re-using per virtqueue
boolean vq->broken and toggle it in virtio_device_ready() and
virtio_reset_device(). Then we can simply reuse the existing checks in
the vring_interrupt() and return early if the driver is not ready.

Note that, I only did compile test on ccw and MMIO transport.

Please review.

Changes since v1:

- Use transport specific irq synchronization method when possible
- Drop the module parameter and enable the hardening unconditonally
- Tweak the barrier/ordering facilities used in the code
- Reanme irq_soft_enabled to driver_ready
- Avoid unnecssary IRQ synchornization (e.g during boot)

Changes since V2:

- add ccw and MMIO support
- rename synchronize_vqs() to synchronize_cbs()
- switch to re-use vq->broken instead of introducing new device
  attributes for the future virtqueue reset support
- remove unnecssary READ_ONCE()/WRITE_ONCE()
- a new patch to remove device triggerable BUG_ON()
- more tweaks on the comments

Jason Wang (8):
  virtio: use virtio_reset_device() when possible
  virtio: introduce config op to synchronize vring callbacks
  virtio-pci: implement synchronize_cbs()
  virtio-mmio: implement synchronize_cbs()
  virtio-ccw: implement synchronize_cbs()
  virtio: allow to unbreak virtqueue
  virtio: harden vring IRQ
  virtio: use WARN_ON() to warning illegal status value

Stefano Garzarella (1):
  virtio: use virtio_device_ready() in virtio_device_restore()

 drivers/char/virtio_console.c              |  2 +-
 drivers/crypto/virtio/virtio_crypto_core.c |  2 +-
 drivers/s390/virtio/virtio_ccw.c           | 31 ++++++++++++++++--
 drivers/virtio/virtio.c                    | 24 ++++++++++----
 drivers/virtio/virtio_mmio.c               |  9 +++++
 drivers/virtio/virtio_pci_common.c         |  2 +-
 drivers/virtio/virtio_pci_common.h         |  2 ++
 drivers/virtio/virtio_pci_legacy.c         |  1 +
 drivers/virtio/virtio_pci_modern.c         |  2 ++
 drivers/virtio/virtio_ring.c               | 15 +++++----
 include/linux/virtio.h                     |  2 +-
 include/linux/virtio_config.h              | 38 +++++++++++++++++++++-
 12 files changed, 110 insertions(+), 20 deletions(-)

-- 
2.25.1


