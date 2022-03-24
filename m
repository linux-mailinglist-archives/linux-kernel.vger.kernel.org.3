Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625A04E6081
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348991AbiCXImE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344542AbiCXImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A15DA9BB92
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648111228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8YEyrlmnQdg2INNFhefHDH4uWMgnQzaNh1TmwLtH5Fg=;
        b=SOrq2syG+AnYaGIupirzF7bGDyAG9P5t4dScZMdEa5/fevgxIEbSn0SpCQdKmirLuRmX/v
        dTB1YfKErjk7EY87MrkEd51YoP3T6XMWx5kYErpj+GHA2vdiQqewDLamnXH+BveFs5/Bgo
        IEaYJ7BPDu2GFdMDAoSOIE389o0VV4E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-IooITgx-PfeRHfchqbq6ug-1; Thu, 24 Mar 2022 04:40:25 -0400
X-MC-Unique: IooITgx-PfeRHfchqbq6ug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02FB53C23FA2;
        Thu, 24 Mar 2022 08:40:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-240.pek2.redhat.com [10.72.13.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3505D40CF8ED;
        Thu, 24 Mar 2022 08:40:20 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com, keirf@google.com
Subject: [PATCH 0/3] rework on the IRQ hardening of virtio
Date:   Thu, 24 Mar 2022 16:40:01 +0800
Message-Id: <20220324084004.14349-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
borrows the idea of the INTX hardening by introducing a boolean for
virtqueue callback enabling and toggle it in virtio_device_ready()
and virtio_reset_device(). Then vring_interrupt() can simply check and
return early if the driver is not ready.

To unbreak legacy setups that may generate IRQ before DRIVER_OK, a
module parameter is introduced to disable the hardening by
default. The features can then be turned on the setups that the
hardening is needed (e.g the confidential computing and other cases).

Please review.

Thanks

Jason Wang (2):
  virtio: use virtio_reset_device() when possible
  virtio: harden vring IRQ

Stefano Garzarella (1):
  virtio: use virtio_device_ready() in virtio_device_restore()

 drivers/virtio/virtio.c       | 28 ++++++++++++++++++++++++----
 drivers/virtio/virtio_ring.c  |  9 ++++++++-
 include/linux/virtio.h        |  4 ++++
 include/linux/virtio_config.h | 25 +++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 5 deletions(-)

-- 
2.25.1

