Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B135AB64F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbiIBQMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbiIBQML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:12:11 -0400
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BB0580B2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:07:58 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id U9D1oWX719qatU9D1o9omT; Fri, 02 Sep 2022 18:07:56 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 02 Sep 2022 18:07:56 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Diana Craciun <diana.craciun@oss.nxp.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kvm@vger.kernel.org
Subject: [PATCH v3] vfio/fsl-mc: Fix a typo in a message
Date:   Fri,  2 Sep 2022 18:07:54 +0200
Message-Id: <a7c1394346725b7435792628c8d4c06a0a745e0b.1662134821.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L and S are swapped in the message.
s/VFIO_FLS_MC/VFIO_FSL_MC/

Also use 'ret' instead of 'WARN_ON(ret)' to avoid a duplicated message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in v3:
  * Remove WARN_ON() and WARN() and only keep dev_warn()   [Diana Madalina Craciun <diana.craciun@oss.nxp.com>]

Changes in v2:
  * s/comment/message/ in the subject   [Cornelia Huck <cohuck@redhat.com>]
  * use WARN instead of WARN_ON+dev_warn   [Jason Gunthorpe <jgg@ziepe.ca>]
  https://lore.kernel.org/all/3d2aa8434393ee8d2aa23a620e59ce1059c9d7ad.1660663440.git.christophe.jaillet@wanadoo.fr/

v1:
  https://lore.kernel.org/all/2b65bf8d2b4d940cafbafcede07c23c35f042f5a.1659815764.git.christophe.jaillet@wanadoo
---
 drivers/vfio/fsl-mc/vfio_fsl_mc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
index 3feff729f3ce..42b344bd7cd5 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -108,9 +108,9 @@ static void vfio_fsl_mc_close_device(struct vfio_device *core_vdev)
 	/* reset the device before cleaning up the interrupts */
 	ret = vfio_fsl_mc_reset_device(vdev);
 
-	if (WARN_ON(ret))
+	if (ret)
 		dev_warn(&mc_cont->dev,
-			 "VFIO_FLS_MC: reset device has failed (%d)\n", ret);
+			 "VFIO_FSL_MC: reset device has failed (%d)\n", ret);
 
 	vfio_fsl_mc_irqs_cleanup(vdev);
 
-- 
2.34.1

