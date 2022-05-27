Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5585358F2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243740AbiE0GBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiE0GBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C223FC5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653631295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=C6ulUTaI7LQ92YVyQB8D+J23sZvDZdCC6tlciX7vVfM=;
        b=iCu4ye2ujurupZPykoJzv65SRu2vPHPPSHX7JnOvx/ipG5keLwaNaW5XTRXKrOLnaPye5U
        iXvAGQd6ZtCC7Xqa7WFWoOn5+SJSqxgs11x/sNDrHYnuxv0NaXqvjTz9gA5suEA/Xp+VDl
        ZfOvaYju+SiWaQQhIrQtlwbHA5DVa/g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-bJdtZfGfPW2mfUaSlevzjg-1; Fri, 27 May 2022 02:01:31 -0400
X-MC-Unique: bJdtZfGfPW2mfUaSlevzjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B208C858EEE;
        Fri, 27 May 2022 06:01:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-240.pek2.redhat.com [10.72.13.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D5352166B26;
        Fri, 27 May 2022 06:01:22 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, sgarzare@redhat.com,
        xuanzhuo@linux.alibaba.com
Subject: [PATCH V6 0/9] rework on the IRQ hardening of virtio
Date:   Fri, 27 May 2022 14:01:11 +0800
Message-Id: <20220527060120.20964-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes since V5:

- Various tweaks on the comments

Changes since V4:

- use spin_lock_irq()/spin_unlock_irq() to synchronize with
  vring_interrupt() for ccw
- use spin_lock()/spin_unlock() to protect vring_interrupt() for non
  airq
- add comment to explain the ordering implications of set_status() for
  PCI, ccw and MMIO
- various tweaks on the comments and changelogs

Changes since V3:

- Rename synchornize_vqs() to synchronize_cbs()
- tweak the comment for synchronize_cbs()
- switch to use a dedicated helper __virtio_unbreak_device() and
  document it should be only used for probing
- switch to use rwlock to synchornize the non airq for ccw

Changes since V2:

- add ccw and MMIO support
- rename synchronize_vqs() to synchronize_cbs()
- switch to re-use vq->broken instead of introducing new device
  attributes for the future virtqueue reset support
  - remove unnecssary READ_ONCE()/WRITE_ONCE()
  - a new patch to remove device triggerable BUG_ON()
  - more tweaks on the comments

Changes since v1:

- Use transport specific irq synchronization method when possible
- Drop the module parameter and enable the hardening unconditonally
- Tweak the barrier/ordering facilities used in the code
- Reanme irq_soft_enabled to driver_ready
- Avoid unnecssary IRQ synchornization (e.g during boot)

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

 drivers/s390/virtio/virtio_ccw.c       | 34 +++++++++++++++++++
 drivers/virtio/virtio.c                | 24 +++++++++----
 drivers/virtio/virtio_mmio.c           | 13 +++++++
 drivers/virtio/virtio_pci_legacy.c     |  1 +
 drivers/virtio/virtio_pci_modern.c     |  2 ++
 drivers/virtio/virtio_pci_modern_dev.c |  5 +++
 drivers/virtio/virtio_ring.c           | 33 +++++++++++++++---
 include/linux/virtio.h                 |  1 +
 include/linux/virtio_config.h          | 47 +++++++++++++++++++++++++-
 9 files changed, 148 insertions(+), 12 deletions(-)

-- 
2.25.1

