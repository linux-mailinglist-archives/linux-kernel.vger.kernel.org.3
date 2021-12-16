Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9167476A56
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhLPGYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:24:30 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:39771 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbhLPGYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:24:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JF2Bt6GwJz4xhp;
        Thu, 16 Dec 2021 17:24:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1639635862;
        bh=TOQQNhdUVc9jwBr9ZRIOteofPlHjByYzf2cnNiSSIH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h0oOcj9bb31xKIJ0p/+SzlgWmmNhWkx3ejpNC79SThIqrhezgHdXlmqc7t0gYKy4j
         3/99qnpTyTSAtibz5N+sTB+mxPEAFbDY/B9Af5I/QrvvH1o9qjqAzqDEIs0e5rfKvW
         er7G6MY74qvRl6VRv6reM2pXfEjnRPo+ZMVqcxb2YZtP42yOx8Cq+BCIEOEm8cU15L
         PWbpOzvmHhd7HVFXwiLoqyyaYDpP1izrwCy8y+WoFQxWtWzyuQFEfF2sl1bzYJfkmj
         KTKOJeQS6Xdf6iRhElZlCtyJTpkZ4Tilt+lwCM8ihr5nTnycB4lBQYrNpHQ6njfAuZ
         oDqPK+/KgJiEQ==
From:   Amitay Isaacs <amitay@ozlabs.org>
To:     linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com
Cc:     Amitay Isaacs <amitay@ozlabs.org>
Subject: [PATCH v2 2/2] fsi: sbefifo: implement FSI_SBEFIFO_READ_TIMEOUT ioctl
Date:   Thu, 16 Dec 2021 17:24:05 +1100
Message-Id: <20211216062405.415888-3-amitay@ozlabs.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211216062405.415888-1-amitay@ozlabs.org>
References: <20211216062405.415888-1-amitay@ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSI_SBEFIFO_READ_TIMEOUT ioctl sets the read timeout (in seconds) for
the response received by sbefifo device from sbe.  The timeout affects
only the read operation on sbefifo device fd.

Certain SBE operations can take long time to complete and the default
timeout of 10 seconds might not be sufficient to start receiving
response from SBE.  In such cases, allow the timeout to be set to the
maximum of 120 seconds.

Signed-off-by: Amitay Isaacs <amitay@ozlabs.org>
---
 drivers/fsi/fsi-sbefifo.c | 44 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fsi.h  | 14 +++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 1e9b326e8f67..771b1a44a61c 100644
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
+	u32			read_timeout_ms;
 };
 
 static DEFINE_MUTEX(sbefifo_ffdc_mutex);
@@ -796,6 +799,7 @@ static int sbefifo_user_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 	mutex_init(&user->file_lock);
+	user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
 
 	return 0;
 }
@@ -838,7 +842,9 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
 	rc = mutex_lock_interruptible(&sbefifo->lock);
 	if (rc)
 		goto bail;
+	sbefifo->timeout_start_rsp_ms = user->read_timeout_ms;
 	rc = __sbefifo_submit(sbefifo, user->pending_cmd, cmd_len, &resp_iter);
+	sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
 	mutex_unlock(&sbefifo->lock);
 	if (rc < 0)
 		goto bail;
@@ -928,12 +934,50 @@ static int sbefifo_user_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int sbefifo_read_timeout(struct sbefifo_user *user, void __user *argp)
+{
+	u32 timeout;
+
+	if (get_user(timeout, (__u32 __user *)argp))
+		return -EFAULT;
+
+	if (timeout == 0) {
+		user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
+		return 0;
+	}
+
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
+	int rc = -ENOTTY;
+
+	if (!user)
+		return -EINVAL;
+
+	mutex_lock(&user->file_lock);
+	switch (cmd) {
+	case FSI_SBEFIFO_READ_TIMEOUT:
+		rc = sbefifo_read_timeout(user, (void __user *)arg);
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
index da577ecd90e7..a4c886832df5 100644
--- a/include/uapi/linux/fsi.h
+++ b/include/uapi/linux/fsi.h
@@ -55,4 +55,18 @@ struct scom_access {
 #define FSI_SCOM_WRITE	_IOWR('s', 0x02, struct scom_access)
 #define FSI_SCOM_RESET	_IOW('s', 0x03, __u32)
 
+/*
+ * /dev/sbefifo* ioctl interface
+ */
+
+/**
+ * FSI_SBEFIFO_READ_TIMEOUT sets the read timeout for response from SBE.
+ *
+ * The read timeout is specified in seconds.  The minimum value of read
+ * timeout is 10 seconds (default) and the maximum value of read timeout is
+ * 120 seconds.  A read timeout of 0 will reset the value to the default of
+ * (10 seconds).
+ */
+#define FSI_SBEFIFO_READ_TIMEOUT	_IOW('s', 0x00, __u32)
+
 #endif /* _UAPI_LINUX_FSI_H */
-- 
2.33.1

