Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4343555313A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349993AbiFULmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349833AbiFULmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:42:50 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF37E48
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LcqlgrS7zj13sDDduNZ2hZFqVURpCBy3Ki4wyCilt+Q=; b=kMBGSmVw3QnKKa6d3FhfEYQw75
        2TAOzLxlIbjHi+qMYl0ePadqRiBOW4EcqIx5L2SrHR1B8lj/fPJEVvekkzbYSukNRj1j25DrNvF0q
        eC5LFrhAHq5CWgg1WNhPFmFFbPCQRrmrx9HEF5B1qbiFYNKgSt1RhtdxbmV7GNKQT/G16S1WhG57U
        GkxwmduqFmF9D+XpnWQuemMZlZavWU5fitl4ODVsDtF7uyAKMtEc0INWvLcgyGTJunsoHTqwUUykO
        5tdz2Xxm+Yvl9Am12r3J5g223E7lMCjMmnmqPLXTyN2Zcpn2dWyLZmWtJx9q6B/3MVZqUFyE9jmHP
        VyVJT99A==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1o3blp-005hKr-CO; Tue, 21 Jun 2022 13:10:09 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 2/2] virtio_mmio: Restore guest page size on resume
Date:   Tue, 21 Jun 2022 13:06:21 +0200
Message-Id: <20220621110621.3638025-3-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220621110621.3638025-1-stephan.gerhold@kernkonzept.com>
References: <20220621110621.3638025-1-stephan.gerhold@kernkonzept.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtio devices might lose their state when the VMM is restarted
after a suspend to disk (hibernation) cycle. This means that the
guest page size register must be restored for the virtio_mmio legacy
interface, since otherwise the virtio queues are not functional.

This is particularly problematic for QEMU that currently still defaults
to using the legacy interface for virtio_mmio. Write the guest page
size register again in virtio_mmio_restore() to make legacy virtio_mmio
devices work correctly after hibernation.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/virtio/virtio_mmio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 980dffd69586..083ff1eb743d 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -569,6 +569,9 @@ static int virtio_mmio_restore(struct device *dev)
 {
 	struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
 
+	if (vm_dev->version == 1)
+		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
+
 	return virtio_device_restore(&vm_dev->vdev);
 }
 
-- 
2.30.2

