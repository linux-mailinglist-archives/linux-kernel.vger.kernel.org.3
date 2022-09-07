Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C91A5B00D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIGJqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIGJqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:46:50 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6907F97523
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6YUzk
        P4hI4MJG55mRUTRj+Zl4JF98Rmu8opT9JrlXq8=; b=DHdneHzli0u4DWLbeWeAp
        i2ThrnDfKt2Nzgm4BQFizqFqZ9M/dRf9y1e+CPmXbl9fYKNaD8dvNdtLb28xYmqp
        DiglvFz5BVMjYz48OfObkQSKgOj8/m118FiBssNNwZKuweMhr9mhS0vYAutAxrXp
        b3VfffhNpPattkbsfA2PtY=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp2 (Coremail) with SMTP id GtxpCgDnac8RaBhj0Vovbg--.51651S2;
        Wed, 07 Sep 2022 17:44:51 +0800 (CST)
From:   Zongmin Zhou <min_halo@163.com>
To:     airlied@redhat.com, kraxel@redhat.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, zhouzongmin@kylinos.cn,
        Ming Xie <xieming@kylinos.cn>
Subject: [PATCH] drm/qxl: fix the suspend/resume issue on qxl device
Date:   Wed,  7 Sep 2022 17:44:23 +0800
Message-Id: <20220907094423.93581-1-min_halo@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="Add_By_Label_Mail_Nextpart_001"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgDnac8RaBhj0Vovbg--.51651S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4DKr17JrWftF4ktF1UJrb_yoW5tw18pF
        W7GFykKrW8ArWUtF45CFZrCF1fZ39xtFWxWrWkK39xC3s8CF1kXF98t3y2vas8AFyUA3WS
        qF4kt34Uua129aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnHUDUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/1tbisA51q1UMUafGbgABsm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Add_By_Label_Mail_Nextpart_001
Content-Type: text/plain;
Content-Transfer-Encoding: 8bit


From: Zongmin Zhou <zhouzongmin@kylinos.cn>

Details:
Currently, when trying to suspend and resume with qxl device，
there are some error messages after resuming,
eventually caused to black screen and can't be recovered.

The first error message:
	[   64.668577][    C3] [drm] driver is in bug mode

This error is due to guest qxl driver
will call qxl_reinit_memslots(qdev) during system resume,
but didn't call qxl_io_reset(qdev) before this,
Then will cause the QXL_IO_MEMSLOT_ADD operation to fail on QEMU,
qxl->guest_bug flag will be set，As a result,
the QXL device can't communicate with guest qxl driver through the IO port.

after fix the first error,can success to resume and login to desktop,
but shortly after that will observe the second error message :
	[  353.095343][  T863] qxl 0000:00:02.0: object_init failed for (262144, 0x00000001)
	[  353.096660][  T863] [drm:qxl_gem_object_create [qxl]] *ERROR* Failed to allocate GEM object (260852, 1, 4096, -12)
	[  353.097277][  T863] [drm:qxl_alloc_ioctl [qxl]] *ERROR* qxl_alloc_ioctl: failed to create gem ret=-12
	[  368.197538][  T863] qxl 0000:00:02.0: object_init failed for (3149824, 0x00000001)
	[  368.197541][  T863] [drm:qxl_alloc_bo_reserved [qxl]] *ERROR* failed to allocate VRAM BO

The problem is caused by calling qxl_ring_init_hdr(qdev->release_ring)
in qxl_drm_resume() function.
When do QXL_IO_RESET,QEMU will call init_qxl_ram(),
so params like prod,cons,notify_on_cons and notify_on_prod
will be set to default value.
Ring push/pop actions for release_ring can be performed normally.
But call qxl_ring_init_hdr(qdev->release_ring)
will eventually set notify_on_prod to number of QXL_RELEASE_RING_SIZE,
affect the value of notify in qxl_push_free_res() function always be false,
QEMU will no longer send events of QXL_INTERRUPT_DISPLAY to the
guest qxl driver，so qxl_ring_pop() will never been called anymore，
and can't do dma_fence_signal(),result to ttm_bo_wait_ctx(bo, ctx)
always return EBUSY,fail to call qxl_bo_create().

Test scenario:
1) start virtual machine with qemu command "-device qxl-vga"
2) click suspend botton to enter suspend mode
3) resume and observe the error message in kernel logs,screen will be black

Let's fix this by reset io and remove the qxl_ring_init_hdr calling.

Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
Suggested-by: Ming Xie<xieming@kylinos.cn>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 1cb6f0c224bb..3044ca948ce2 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -194,7 +194,6 @@ static int qxl_drm_resume(struct drm_device *dev, bool thaw)
 	qdev->ram_header->int_mask = QXL_INTERRUPT_MASK;
 	if (!thaw) {
 		qxl_reinit_memslots(qdev);
-		qxl_ring_init_hdr(qdev->release_ring);
 	}
 
 	qxl_create_monitors_object(qdev);
@@ -220,6 +219,7 @@ static int qxl_pm_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct qxl_device *qdev = to_qxl(drm_dev);
 
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
@@ -227,6 +227,7 @@ static int qxl_pm_resume(struct device *dev)
 		return -EIO;
 	}
 
+	qxl_io_reset(qdev);
 	return qxl_drm_resume(drm_dev, false);
 }
 
-- 
2.25.1


--Add_By_Label_Mail_Nextpart_001

Content-type: Text/plain

No virus found
		Checked by Hillstone Network AntiVirus

--Add_By_Label_Mail_Nextpart_001--

