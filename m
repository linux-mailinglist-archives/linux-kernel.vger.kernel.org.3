Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE249495981
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 06:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378548AbiAUFjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 00:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348689AbiAUFi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 00:38:58 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E5FC06173F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 21:38:57 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id x8so8845357qta.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 21:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAAjcbMGSfL+ONrTTuf3PGqmWSdgQ+wWZZ+GAzxN19Y=;
        b=AFDRxD4KSiEmsFxkbegWggpnP7XEfoiBH4Se3tS9WTgRK8Lbj6wcD/Trmsj9nLMayq
         wn7R7We7IuvIS9jDgBHr9SiGGa+4F4SpsM0KxgJdQPEIBfikqUnqTrFa0Bq4o8tm7Q/5
         Z1jKn0p7Nr+VUxzgQHaBB0DZSpnE+Atr28N31Fu/K3z08xS848QM5ay71r6UFPNatgtw
         qEOZhXLYnTrbRnPqcXQBfflDi69Y/+1G7GhMDscw1GTmPnCUTZGTE+7CdA7q+uUZJiOg
         91SpJ8hWuCspmLFKILWLyJlDWIsWZohYKI1RQnD0fZTE3GA4y4vL20KZiBLZi7J4t3gk
         a7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aAAjcbMGSfL+ONrTTuf3PGqmWSdgQ+wWZZ+GAzxN19Y=;
        b=sIhoVL2JI0vcCM42z8JV2qqpIKT+cS0+LcJxOdLcg1TcVl4vN+Tl6Kb2F5lOKZD5Vm
         Js1YUQD2yFDo2tvRqpM8dWRsPJ6Y9XZ2SucBJYT9mtC0Tf+fcFP4l5L/ntyK3wh7K21S
         ryeTX/aMdV0K6rM56zSCiwqgpufjUxmWQfSKjmyj0gYSC64vl3oRIN2A4Z7Z18yWkHs3
         g6+kjSQEEQz2hR7SnMq9Fn67WXwrbtxpkHv0G20fDOn68XlvTSmTczPrvS6fswD+MhDF
         ynU/ZmZy5IuvAyjZfVt1mytFZLEiGYGxfFUU4jRw7IZD+CqIj/ccqC2DlXFi6FPnwNEy
         5/HA==
X-Gm-Message-State: AOAM531AQEEhBzDunhbpTsyDRSShSz7T5+SqrM6fit7KeH2ytBcAKqQF
        dyqDhsuVNCuNMyMsxMp/Y0N12TQqbtY=
X-Google-Smtp-Source: ABdhPJx1i2+IsbzcSIY3h0DecqKpQVtqGLmonyUfXtGyRkQpXghCg5k6zwKgutiBsmrwnO56D3ZjQw==
X-Received: by 2002:ac8:1186:: with SMTP id d6mr2159010qtj.192.1642743536985;
        Thu, 20 Jan 2022 21:38:56 -0800 (PST)
Received: from localhost.localdomain ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id y17sm2607169qtw.0.2022.01.20.21.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 21:38:56 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Amitay Isaacs <amitay@ozlabs.org>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] fsi: sbefifo: Implement FSI_SBEFIFO_READ_TIMEOUT_SECONDS ioctl
Date:   Fri, 21 Jan 2022 16:08:16 +1030
Message-Id: <20220121053816.82253-3-joel@jms.id.au>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121053816.82253-1-joel@jms.id.au>
References: <20220121053816.82253-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amitay Isaacs <amitay@ozlabs.org>

FSI_SBEFIFO_READ_TIMEOUT_SECONDS ioctl sets the read timeout (in
seconds) for the response received by sbefifo device from sbe.  The
timeout affects only the read operation on current sbefifo device fd.

Certain SBE operations can take long time to complete and the default
timeout of 10 seconds might not be sufficient to start receiving
response from SBE.  In such cases, allow the timeout to be set to the
maximum of 120 seconds.

The kernel does not contain the definition of the various SBE
operations, so we must expose an interface to userspace to set the
timeout for the given operation.

Signed-off-by: Amitay Isaacs <amitay@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3:
  - Clarify why this is an ioctl and not hardcoded in the kernel
  - Add seconds to the name
---
 drivers/fsi/fsi-sbefifo.c | 49 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fsi.h  | 14 +++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 1e9b326e8f67..f52a912cdf16 100644
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
@@ -928,12 +934,55 @@ static int sbefifo_user_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int sbefifo_read_timeout(struct sbefifo_user *user, void __user *argp)
+{
+	struct device *dev = &user->sbefifo->dev;
+	u32 timeout;
+
+	if (get_user(timeout, (__u32 __user *)argp))
+		return -EFAULT;
+
+	if (timeout == 0) {
+		user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
+		dev_dbg(dev, "Timeout reset to %d\n", user->read_timeout_ms);
+		return 0;
+	}
+
+	if (timeout < 10 || timeout > 120)
+		return -EINVAL;
+
+	user->read_timeout_ms = timeout * 1000; /* user timeout is in sec */
+
+	dev_dbg(dev, "Timeout set to %d\n", user->read_timeout_ms);
+
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
+	case FSI_SBEFIFO_READ_TIMEOUT_SECONDS:
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
index da577ecd90e7..b2f1977378c7 100644
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
+#define FSI_SBEFIFO_READ_TIMEOUT_SECONDS	_IOW('s', 0x00, __u32)
+
 #endif /* _UAPI_LINUX_FSI_H */
-- 
2.34.1

