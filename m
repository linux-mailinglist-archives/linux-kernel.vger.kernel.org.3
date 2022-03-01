Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B777E4C805D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 02:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiCABco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 20:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiCABcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:32:43 -0500
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 17:32:02 PST
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4131FF06
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:32:01 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.8.63])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4K702t401Mz1FPMg
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:26:46 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4K702c2gSmzB5kdn
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:26:32 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4K702X6pChzdmX8m
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:26:28 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4K702T1vNzz8PxDy
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:26:25 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4K702Q4kt9z8fkWd;
        Tue,  1 Mar 2022 09:26:22 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl2.zte.com.cn with SMTP id 2211Q6Ev061421;
        Tue, 1 Mar 2022 09:26:07 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-cloudhost8.localdomain (unknown [10.234.72.110])
        by smtp (Zmail) with SMTP;
        Tue, 1 Mar 2022 09:26:06 +0800
X-Zmail-TransId: 3e81621d762e002-92466
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, elic@nvidia.com, xieyongji@bytedance.com,
        sgarzare@redhat.com, wuzongyong@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Zhang Min <zhang.min9@zte.com.cn>
Subject: [PATCH] vdpa: fix use-after-free on vp_vdpa_remove
Date:   Tue,  1 Mar 2022 17:10:59 +0800
Message-Id: <20220301091059.46869-1-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 2.33.0.rc0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2211Q6Ev061421
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 621D7655.000 by FangMail milter!
X-FangMail-Envelope: 1646098006/4K702t401Mz1FPMg/621D7655.000/10.35.8.63/[10.35.8.63]/mxde.zte.com.cn/<wang.yi59@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 621D7655.000/4K702t401Mz1FPMg
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Min <zhang.min9@zte.com.cn>

When vp_vdpa driver is unbind, vp_vdpa is freed in vdpa_unregister_device
and then vp_vdpa->mdev.pci_dev is dereferenced in vp_modern_remove,
triggering use-after-free.

Call Trace of unbinding driver free vp_vdpa :
do_syscall_64
  vfs_write
    kernfs_fop_write_iter
      device_release_driver_internal
        pci_device_remove
          vp_vdpa_remove
            vdpa_unregister_device
              kobject_release
                device_release
                  kfree

Call Trace of dereference vp_vdpa->mdev.pci_dev:
vp_modern_remove
  pci_release_selected_regions
    pci_release_region
      pci_resource_len
        pci_resource_end
          (dev)->resource[(bar)].end

Signed-off-by: Zhang Min <zhang.min9@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index a57e381e830b..cce101e6a940 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -533,8 +533,8 @@ static void vp_vdpa_remove(struct pci_dev *pdev)
 {
 	struct vp_vdpa *vp_vdpa = pci_get_drvdata(pdev);
 
-	vdpa_unregister_device(&vp_vdpa->vdpa);
 	vp_modern_remove(&vp_vdpa->mdev);
+	vdpa_unregister_device(&vp_vdpa->vdpa);
 }
 
 static struct pci_driver vp_vdpa_driver = {
-- 
2.27.0
