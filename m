Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE65D55313B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349951AbiFULmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349833AbiFULmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:42:44 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC00BE28
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NDivncQ+nuA5i32alXvrHtKC02tI1GI+RHIHBVYRB/E=; b=hXHGyMDjJg+VL/rIFAAXJdBHgI
        RJYQU6mjIuvTot4/qNH0FhpOlsCqkjzUAZGf5JLMtAJLRqF8MAP/XBYcltUhDoFc3uyGdAxX1RV2x
        Ox/mDIyhhrDeIHIASMKqkQ36De0fXKPzCVJ+pMWS1jOxPfXLyZ3IroY3nK+6FqD7HNPlVzgXHAOob
        OVJHQinxQD4JHYpGRU2jBwHhwcOjS4cK1wE1CK1xYhdmH+fPEsXEb0sDJdyGmBSn0lIe4qSlTk8VF
        K9zwb5vTxTzvx+nRp9+vEAM4UhgIGFjqxhqcKlukX7q+y0AadfflJYxrbD9BaNNCWlC1yeeIxcs2l
        fkPYZH/w==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1o3blo-005hKr-U0; Tue, 21 Jun 2022 13:10:08 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 1/2] virtio_mmio: Add missing PM calls to freeze/restore
Date:   Tue, 21 Jun 2022 13:06:20 +0200
Message-Id: <20220621110621.3638025-2-stephan.gerhold@kernkonzept.com>
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

Most virtio drivers provide freeze/restore callbacks to finish up
device usage before suspend and to reinitialize the virtio device after
resume. However, these callbacks are currently only called when using
virtio_pci. virtio_mmio does not have any PM ops defined.

This causes problems for example after suspend to disk (hibernation),
since the virtio devices might lose their state after the VMM is
restarted. Calling virtio_device_freeze()/restore() ensures that
the virtio devices are re-initialized correctly.

Fix this by implementing the dev_pm_ops for virtio_mmio,
similar to virtio_pci_common.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/virtio/virtio_mmio.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index c9bec3813e94..980dffd69586 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -62,6 +62,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/virtio.h>
@@ -556,6 +557,25 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
 	.synchronize_cbs = vm_synchronize_cbs,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int virtio_mmio_freeze(struct device *dev)
+{
+	struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+	return virtio_device_freeze(&vm_dev->vdev);
+}
+
+static int virtio_mmio_restore(struct device *dev)
+{
+	struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+	return virtio_device_restore(&vm_dev->vdev);
+}
+
+static const struct dev_pm_ops virtio_mmio_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(virtio_mmio_freeze, virtio_mmio_restore)
+};
+#endif
 
 static void virtio_mmio_release_dev(struct device *_d)
 {
@@ -799,6 +819,9 @@ static struct platform_driver virtio_mmio_driver = {
 		.name	= "virtio-mmio",
 		.of_match_table	= virtio_mmio_match,
 		.acpi_match_table = ACPI_PTR(virtio_mmio_acpi_match),
+#ifdef CONFIG_PM_SLEEP
+		.pm	= &virtio_mmio_pm_ops,
+#endif
 	},
 };
 
-- 
2.30.2

