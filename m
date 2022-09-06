Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D275AEEEC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbiIFPdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiIFPdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:33:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87445C32FE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:43:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E05F6614DF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DF8C4314B;
        Tue,  6 Sep 2022 14:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662475404;
        bh=jKsuMbYl55Lo1LGaW0M20c5jGcpmzFxlzSyZ9tbRAXY=;
        h=From:To:Cc:Subject:Date:From;
        b=L+fITAyBzeFbZbN5oNfWdFcCDFfKHfMRPDLOmGXZHemS3C8VLKE/oq52A1WlgUtFv
         QBBRsvbZ7lLuXsGLW8fe5T4PUAA9BkTh/VfEqmi+LIjOcWTn6Nb7tUbQtjgVc9xB+y
         R/J0cfHSeBdUJc3duxCj2KMBN2/N+Le529/dhSV5mrQEKJll6r7oMA0++inQpaQ5xD
         A3+v5EzDUe6VgLReHqw2e+Us2/sU3tuCqbB6eoiDcb7N5Xc5HnYRk39YXY5lC1cSZt
         tZZBYIGmsssGnPjBYayQa/pOqN7JqHpGYfaFsxfhxllmWgq4EF4YT4MS1pzvwvR8Y9
         2E9EYl7HpVISg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/9] habanalabs: send device activity in a proper context
Date:   Tue,  6 Sep 2022 17:43:10 +0300
Message-Id: <20220906144318.1890416-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

'Device activity open packet' should be sent outside of mutex as
there is no real necessity for a lock.
In addition 'device activity close packet' should be sent upon an
actual release of the device.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c         | 4 ++--
 drivers/misc/habanalabs/common/habanalabs_drv.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 986045de552e..a59cbbc8965f 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -385,6 +385,8 @@ static void hpriv_release(struct kref *ref)
 
 	hdev = hpriv->hdev;
 
+	hdev->asic_funcs->send_device_activity(hdev, false);
+
 	put_pid(hpriv->taskpid);
 
 	hl_debugfs_remove_file(hpriv);
@@ -492,8 +494,6 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 	hdev->last_open_session_duration_jif =
 		jiffies - hdev->last_successful_open_jif;
 
-	hdev->asic_funcs->send_device_activity(hdev, false);
-
 	return 0;
 }
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index f9db7b91bfe3..c60d6dab7aa7 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -204,11 +204,11 @@ int hl_device_open(struct inode *inode, struct file *filp)
 		goto out_err;
 	}
 
-	rc = hdev->asic_funcs->send_device_activity(hdev, true);
-
 	list_add(&hpriv->dev_node, &hdev->fpriv_list);
 	mutex_unlock(&hdev->fpriv_list_lock);
 
+	hdev->asic_funcs->send_device_activity(hdev, true);
+
 	hl_debugfs_add_file(hpriv);
 
 	atomic_set(&hdev->last_error.cs_timeout.write_enable, 1);
-- 
2.25.1

