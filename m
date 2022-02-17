Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509C74B95E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 03:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiBQC3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 21:29:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiBQC3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 21:29:42 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D578429E967;
        Wed, 16 Feb 2022 18:29:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V4g3TN-_1645064962;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0V4g3TN-_1645064962)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 10:29:26 +0800
From:   Guixin Liu <kanie@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, bostroesser@gmail.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        xlpang@linux.alibaba.com
Subject: [PATCH 1/2] uio: add ioctl to uio
Date:   Thu, 17 Feb 2022 10:29:21 +0800
Message-Id: <1645064962-94123-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In TCMU, if backstore holds its own userspace buffer, for read cmd, the
data needs to be copied from userspace buffer to tcmu data area first,
and then needs to be copied from tcmu data area to scsi sgl pages again.

To solve this problem, add ioctl to uio to let userspace backstore can
copy data between scsi sgl pages and its own buffer directly.

Reviewed-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/uio/uio.c          | 22 ++++++++++++++++++++++
 include/linux/uio_driver.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 43afbb7..0fb85a3 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -815,6 +815,24 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
 	return ret;
 }
 
+long uio_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	struct uio_listener *listener = filep->private_data;
+	struct uio_device *idev = listener->dev;
+	long retval = 0;
+
+	mutex_lock(&idev->info_lock);
+	if (!idev->info || !idev->info->ioctl) {
+		retval = -EINVAL;
+		goto out;
+	}
+
+	retval = idev->info->ioctl(idev->info, cmd, arg);
+out:
+	mutex_unlock(&idev->info_lock);
+	return retval;
+}
+
 static const struct file_operations uio_fops = {
 	.owner		= THIS_MODULE,
 	.open		= uio_open,
@@ -825,6 +843,10 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
 	.poll		= uio_poll,
 	.fasync		= uio_fasync,
 	.llseek		= noop_llseek,
+	.unlocked_ioctl = uio_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl   = uio_ioctl,
+#endif
 };
 
 static int uio_major_init(void)
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 47c5962..971d172b 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -109,6 +109,7 @@ struct uio_info {
 	int (*open)(struct uio_info *info, struct inode *inode);
 	int (*release)(struct uio_info *info, struct inode *inode);
 	int (*irqcontrol)(struct uio_info *info, s32 irq_on);
+	long (*ioctl)(struct uio_info *info, unsigned int cmd, unsigned long arg);
 };
 
 extern int __must_check
-- 
1.8.3.1

