Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FA3474FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbhLOA6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238706AbhLOA6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:58:54 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2854C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 16:58:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JDH1m3VLSz4xd4;
        Wed, 15 Dec 2021 11:58:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1639529932;
        bh=O03uuio/CUpOafN1yI/83hrUM23XhUWquCiiChGoScs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMc5t5v/4G0MHCZ6iXqsJ5UQgIlYd9nisbV1ek29DnX28GXQRYUyz9WPMjbd1N8R2
         KQ2pB0vpK1xKY4eFYnYASJ1jRiCmSwj/rcwmgMSuKO9Tw2fcTSxB75J5scUy9hTsLf
         lQVnVu7vG0N/jMJz2tEUOKKoMniFxj/h2Ku8gXsr4BWAuHXIXdlUfYxkM/yI6QjtnZ
         DiML78FbQ/DJnXnU1lAI4V2Ca6Kv/9RlxCrPXykTgcR8td9mVO2Q2c6UC68AgT9i2U
         tkr4gTB6IcTLfyyOVmoYih53gtLiNM8TvM5RcmlMjnhw413YkPF7BIyWp8k8Yo2Da1
         2dpOlvqk0AMRg==
From:   Amitay Isaacs <amitay@ozlabs.org>
To:     linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com
Cc:     Amitay Isaacs <amitay@ozlabs.org>
Subject: [PATCH 2/2] fsi: sbefifo: implement FSI_SBEFIFO_READ_TIMEOUT ioctl
Date:   Wed, 15 Dec 2021 11:58:33 +1100
Message-Id: <20211215005833.222841-2-amitay@ozlabs.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211215005833.222841-1-amitay@ozlabs.org>
References: <20211215005833.222841-1-amitay@ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSI_SBEFIFO_READ_TIMEOUT ioctl sets the read timeout (in seconds) for
the response to *the next* chip-op sent to sbe.  The timeout value is
reset to default after the chip-op.  The timeout affects only the read()
operation on sbefifo device fd.

Signed-off-by: Amitay Isaacs <amitay@ozlabs.org>
---
 drivers/fsi/fsi-sbefifo.c | 42 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fsi.h  |  6 ++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 9188161f440c..b2654b143b85 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -32,6 +32,8 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 
+#include <uapi/linux/fsi.h>
+
 /*
  * The SBEFIFO is a pipe-like FSI device for communicating with
  * the self boot engine on POWER processors.
@@ -134,6 +136,7 @@ struct sbefifo_user {
 	void			*cmd_page;
 	void			*pending_cmd;
 	size_t			pending_len;
+	uint32_t		read_timeout_ms;
 };
 
 static DEFINE_MUTEX(sbefifo_ffdc_mutex);
@@ -796,6 +799,7 @@ static int sbefifo_user_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 	mutex_init(&user->file_lock);
+	user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
 
 	return 0;
 }
@@ -838,7 +842,11 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
 	rc = mutex_lock_interruptible(&sbefifo->lock);
 	if (rc)
 		goto bail;
+	sbefifo->timeout_start_rsp_ms = user->read_timeout_ms;
 	rc = __sbefifo_submit(sbefifo, user->pending_cmd, cmd_len, &resp_iter);
+	/* Reset the read timeout after a single chip-op */
+	sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
+	user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
 	mutex_unlock(&sbefifo->lock);
 	if (rc < 0)
 		goto bail;
@@ -847,6 +855,7 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
 	rc = len - iov_iter_count(&resp_iter);
  bail:
 	sbefifo_release_command(user);
+	user->read_timeout_ms = 0;
 	mutex_unlock(&user->file_lock);
 	return rc;
 }
@@ -928,12 +937,45 @@ static int sbefifo_user_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int sbefifo_read_timeout(struct sbefifo_user *user, void __user **argp)
+{
+	uint32_t timeout;
+
+	if (get_user(timeout, (__u32 __user *)argp))
+		return -EFAULT;
+	if (timeout < 10 || timeout > 120)
+		return -EINVAL;
+
+	user->read_timeout_ms = timeout * 1000; /* user timeout is in sec */
+	return 0;
+}
+
+static long sbefifo_user_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct sbefifo_user *user = file->private_data;
+	void __user **argp = (void __user *)arg;
+	int rc = -ENOTTY;
+
+	if (!user)
+		return -EINVAL;
+
+	mutex_lock(&user->file_lock);
+	switch (cmd) {
+	case FSI_SBEFIFO_READ_TIMEOUT:
+		rc = sbefifo_read_timeout(user, argp);
+		break;
+	}
+	mutex_unlock(&user->file_lock);
+	return rc;
+}
+
 static const struct file_operations sbefifo_fops = {
 	.owner		= THIS_MODULE,
 	.open		= sbefifo_user_open,
 	.read		= sbefifo_user_read,
 	.write		= sbefifo_user_write,
 	.release	= sbefifo_user_release,
+	.unlocked_ioctl = sbefifo_user_ioctl,
 };
 
 static void sbefifo_free(struct device *dev)
diff --git a/include/uapi/linux/fsi.h b/include/uapi/linux/fsi.h
index da577ecd90e7..3e00874ace22 100644
--- a/include/uapi/linux/fsi.h
+++ b/include/uapi/linux/fsi.h
@@ -55,4 +55,10 @@ struct scom_access {
 #define FSI_SCOM_WRITE	_IOWR('s', 0x02, struct scom_access)
 #define FSI_SCOM_RESET	_IOW('s', 0x03, __u32)
 
+/*
+ * /dev/sbefifo* ioctl interface
+ */
+
+#define FSI_SBEFIFO_READ_TIMEOUT	_IOW('s', 0x00, __u32)
+
 #endif /* _UAPI_LINUX_FSI_H */
-- 
2.33.1

