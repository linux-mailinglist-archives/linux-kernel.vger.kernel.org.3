Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DBF47BC64
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbhLUJEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:04:51 -0500
Received: from smtp1.axis.com ([195.60.68.17]:65464 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234178AbhLUJEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1640077490;
  x=1671613490;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=21MVjU8BBU4s3iqha0uhpIEldo19sR0X+czAnqzhGmM=;
  b=f0OEJquD69q2pZcMG9bfU7vI7k/WP38ZLPu25rh/GAfc9ToH5U2Ck1r2
   grSf5HRaoZDPZY4Gpf/SR+iDN5QZgp3o9+7KjtJ6H3Z7VrEMdnm28/oTz
   nXSh9faMFL7OADZosutvzYuqsW/dlpiu/rbw22ipK38iIhW+CtE9Z52Jz
   GgYGCM6uM+PjA65oLvWD8EXm0P4Lld3NrYhLQnOvx3isWMVXCNuPubDv0
   heawjITqpEKs5wnc5x3OEHTlMdytKOfLj0iVqq1Qo51i99dlQi0YfYFv7
   NH0a0RrrO1EPjQF81Nm1pRP+Bpoj9za7aK2U4b0yDxIyY0weFB0yszorg
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC:     <kernel@axis.com>, <johannes.berg@intel.com>,
        <devicetree@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] um: virtio_uml: allow probing from devicetree
Date:   Tue, 21 Dec 2021 10:04:46 +0100
Message-ID: <20211221090447.1567-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the virtio_uml device to be probed from the devicetree so that
sub-devices can be specified using the standard virtio bindings, for
example:

  virtio@1 {
    compatible = "virtio,uml";
    socket-path = "i2c.sock";
    virtio-device-id = <0x22>;

    i2c-controller {
      compatible = "virtio,device22";
      #address-cells = <0x01>;
      #size-cells = <0x00>;

      light-sensor@01 {
        compatible = "ti,opt3001";
        reg = <0x01>;
      };
    };
  };

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    Requires the UML devicetree support I posted a couple of weeks ago:
    https://lore.kernel.org/all/20211208151123.29313-1-vincent.whitchurch@axis.com/

 arch/um/drivers/virtio_uml.c | 50 +++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index d51e445df797..3e4fa0f262d3 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -21,6 +21,7 @@
  * Based on Virtio MMIO driver by Pawel Moll, copyright 2011-2014, ARM Ltd.
  */
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/virtio.h>
@@ -49,6 +50,7 @@ struct virtio_uml_platform_data {
 struct virtio_uml_device {
 	struct virtio_device vdev;
 	struct platform_device *pdev;
+	struct virtio_uml_platform_data *pdata;
 
 	spinlock_t sock_lock;
 	int sock, req_fd, irq;
@@ -149,7 +151,7 @@ static int vhost_user_recv(struct virtio_uml_device *vu_dev,
 	if (rc == -ECONNRESET && vu_dev->registered) {
 		struct virtio_uml_platform_data *pdata;
 
-		pdata = vu_dev->pdev->dev.platform_data;
+		pdata = vu_dev->pdata;
 
 		virtio_break_device(&vu_dev->vdev);
 		schedule_work(&pdata->conn_broken_wk);
@@ -1113,21 +1115,63 @@ void virtio_uml_set_no_vq_suspend(struct virtio_device *vdev,
 		 no_vq_suspend ? "dis" : "en");
 }
 
+static void vu_of_conn_broken(struct work_struct *wk)
+{
+	/*
+	 * We can't remove the device from the devicetree so the only thing we
+	 * can do is warn.
+	 */
+	WARN_ON(1);
+}
+
 /* Platform device */
 
+static struct virtio_uml_platform_data *
+virtio_uml_create_pdata(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct virtio_uml_platform_data *pdata;
+	int ret;
+
+	if (!np)
+		return ERR_PTR(-EINVAL);
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_WORK(&pdata->conn_broken_wk, vu_of_conn_broken);
+	pdata->pdev = pdev;
+
+	ret = of_property_read_string(np, "socket-path", &pdata->socket_path);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = of_property_read_u32(np, "virtio-device-id",
+				   &pdata->virtio_device_id);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return pdata;
+}
+
 static int virtio_uml_probe(struct platform_device *pdev)
 {
 	struct virtio_uml_platform_data *pdata = pdev->dev.platform_data;
 	struct virtio_uml_device *vu_dev;
 	int rc;
 
-	if (!pdata)
-		return -EINVAL;
+	if (!pdata) {
+		pdata = virtio_uml_create_pdata(pdev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	}
 
 	vu_dev = kzalloc(sizeof(*vu_dev), GFP_KERNEL);
 	if (!vu_dev)
 		return -ENOMEM;
 
+	vu_dev->pdata = pdata;
 	vu_dev->vdev.dev.parent = &pdev->dev;
 	vu_dev->vdev.dev.release = virtio_uml_release_dev;
 	vu_dev->vdev.config = &virtio_uml_config_ops;
-- 
2.33.1

