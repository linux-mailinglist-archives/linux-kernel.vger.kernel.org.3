Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6298658830C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbiHBUQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbiHBUQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:16:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFF24D4D0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 13:16:12 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o3so14463034ple.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nC6Hx+qiMFP0kKK+gIayIBAMJyU5NtZQrF2GRnpsTMA=;
        b=KYjbiOhxaNQ9mFkKfgNioYpb2Oev3w3SfsxtbC6ttjwc+M/vWt0mEA372FciOnZ/NN
         xth3FspJHg+5z1HYbIBHDX0pvSJRggWnAun73cBgnyu/NBqzbXoUWEfTLxwEk2LsBcpW
         447qEuyG+m8StQUqexnVF6lDHm5rKtdwz0b1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nC6Hx+qiMFP0kKK+gIayIBAMJyU5NtZQrF2GRnpsTMA=;
        b=TZEikiZxtvj2xGDbCDPQmXDc8zryudjaFfux6MIWsZ8hCq6txGCxEpyRDYw7qNB6vs
         nPbx+tjPSfCSHHEMjks1srmHUpvWlU3vII6W7oSY9Tsn3qJELy8uSHSiez/9KRV0gjW6
         eH3vmtToiXRNipYPd0lF3Kbn9i6j7jYKLWmB57VDRcMftkXgWTZckSNvs4aWpL2DM4Pj
         FpoEh2MmqhfvCxJTaGOnSI2Lgj119IXonF4OUDhx8keVcAaEhNOoAVl4lBU1SRpnm5ck
         fNi1Jylw4McX3QJ28enFruCFNoSJ0z6oGDwR1cyZKNdHY0uFvsMyMrTXojV5JMBse/Fw
         ZVdw==
X-Gm-Message-State: ACgBeo1qvNMacWQOPwYTOsyiy2z6xYbdtJBgPlokY/FBFROf9MtJcBCx
        hmFi9PIKZSvzGQ4lCzzd8vmC5A==
X-Google-Smtp-Source: AA6agR42Uixt4w/tXOci7Vlkr/HLqtdEZQtCdblMMrEMdGGCrn3m3AcZr3byoGzuveAoRUrn+xrqew==
X-Received: by 2002:a17:902:b08a:b0:16c:68b6:311 with SMTP id p10-20020a170902b08a00b0016c68b60311mr21685501plr.166.1659471371483;
        Tue, 02 Aug 2022 13:16:11 -0700 (PDT)
Received: from localhost.localdomain ([183.83.136.224])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902a71200b0016ee26224a4sm80863plq.305.2022.08.02.13.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 13:16:11 -0700 (PDT)
From:   Suniel Mahesh <sunil@amarulasolutions.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Zachary Holland <Zachary.Holland@biamp.com>,
        Daniel McLean <Daniel.McLean@biamp.com>,
        Rene Samson Ambrose <renesamson.ambrose@biamp.com>,
        David Sands <David.Sands@biamp.com>
Cc:     linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        USB list <linux-usb@vger.kernel.org>
Subject: [RFC v2 1/2] usb: gadget: f_hid: Extend functionality for GET_REPORT mode
Date:   Wed,  3 Aug 2022 01:45:55 +0530
Message-Id: <20220802201556.1510069-2-sunil@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802201556.1510069-1-sunil@amarulasolutions.com>
References: <20220802201556.1510069-1-sunil@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current kernel implementation for GET_REPORT is that the kernel
sends back a zero filled report (of length == report_length), when
the Host request's a particular report from the device/gadget.

This changeset extends functionality for GET_REPORT by sending a
particular report based on report type and report number.

corresponding ioctl is also implemented.

Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
Changes for v2:
- Map report type coming from userspace reports to the ones
  defined in kernel headers.
---
 drivers/usb/gadget/function/f_hid.c  | 184 ++++++++++++++++++++++++++-
 include/{ => uapi}/linux/usb/g_hid.h |  10 ++
 2 files changed, 192 insertions(+), 2 deletions(-)
 rename include/{ => uapi}/linux/usb/g_hid.h (72%)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index ca0a7d9eaa34..e1da4fb10ab3 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/usb/g_hid.h>
+#include <linux/uhid.h>
 
 #include "u_f.h"
 #include "u_hid.h"
@@ -27,6 +28,11 @@ static struct class *hidg_class;
 static DEFINE_IDA(hidg_ida);
 static DEFINE_MUTEX(hidg_ida_lock); /* protects access to hidg_ida */
 
+struct report_entry {
+	struct uhid_set_report_req report_data;
+	struct list_head node;
+};
+
 /*-------------------------------------------------------------------------*/
 /*                            HID gadget struct                            */
 
@@ -71,6 +77,10 @@ struct f_hidg {
 	wait_queue_head_t		write_queue;
 	struct usb_request		*req;
 
+	/* hid report list */
+	spinlock_t			report_spinlock;
+	struct list_head		report_list;
+
 	int				minor;
 	struct cdev			cdev;
 	struct usb_function		func;
@@ -553,6 +563,154 @@ static int f_hidg_open(struct inode *inode, struct file *fd)
 	return 0;
 }
 
+static enum uhid_report_type f_hidg_from_report_to_type(__u8 r_type)
+{
+	switch (r_type) {
+		case 1:
+			return UHID_FEATURE_REPORT;
+		case 2:
+			return UHID_OUTPUT_REPORT;
+		case 3:
+			return UHID_INPUT_REPORT;
+		default:
+			break;
+	}
+	return -EINVAL;
+}
+
+static bool f_hidg_param_valid(struct report_entry *entry)
+{
+	enum uhid_report_type report_type;
+
+	if (entry->report_data.size > UHID_DATA_MAX)
+		return false;
+
+	report_type = f_hidg_from_report_to_type(entry->report_data.rtype);
+
+	switch (report_type) {
+	case UHID_FEATURE_REPORT:
+	case UHID_OUTPUT_REPORT:
+	case UHID_INPUT_REPORT:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static struct report_entry *f_hidg_search_for_report(struct f_hidg *hidg, u8 rnum, u8 rtype)
+{
+	struct list_head *ptr;
+	struct report_entry *entry;
+
+	list_for_each(ptr, &hidg->report_list) {
+		entry = list_entry(ptr, struct report_entry, node);
+		if (entry->report_data.rnum == rnum &&
+		    entry->report_data.rtype == rtype) {
+			return entry;
+		}
+	}
+
+	return NULL;
+}
+
+static long f_hidg_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct f_hidg *hidg = file->private_data;
+	struct report_entry *entry;
+	struct report_entry *ptr;
+	unsigned long flags;
+	struct uhid_get_report_req report;
+	u16 size;
+
+	switch (cmd) {
+	case GADGET_ADD_REPORT_STATUS:
+		entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+		if (!entry)
+			return -ENOMEM;
+
+		if (copy_from_user(&entry->report_data, (struct uhid_set_report_req *)arg,
+					sizeof(struct uhid_set_report_req))) {
+			kfree(entry);
+			return -EFAULT;
+		}
+
+		if (f_hidg_param_valid(entry) == false) {
+			kfree(entry);
+			return -EINVAL;
+		}
+
+		spin_lock_irqsave(&hidg->report_spinlock, flags);
+		ptr = f_hidg_search_for_report(hidg, entry->report_data.rnum,
+						entry->report_data.rtype);
+		if (ptr) {
+			spin_unlock_irqrestore(&hidg->report_spinlock, flags);
+			kfree(ptr);
+			return -EEXIST;
+		}
+		list_add_tail(&entry->node, &hidg->report_list);
+		spin_unlock_irqrestore(&hidg->report_spinlock, flags);
+		break;
+	case GADGET_REMOVE_REPORT_STATUS:
+		spin_lock_irqsave(&hidg->report_spinlock, flags);
+		if (list_empty(&hidg->report_list)) {
+			spin_unlock_irqrestore(&hidg->report_spinlock, flags);
+			return -ENODATA;
+		}
+		spin_unlock_irqrestore(&hidg->report_spinlock, flags);
+
+		if (copy_from_user(&report, (struct uhid_get_report_req *)arg, sizeof(report)))
+			return -EFAULT;
+
+		spin_lock_irqsave(&hidg->report_spinlock, flags);
+
+		ptr = f_hidg_search_for_report(hidg, report.rnum, report.rtype);
+		if (ptr) {
+			list_del(&ptr->node);
+		} else {
+			spin_unlock_irqrestore(&hidg->report_spinlock, flags);
+			return -ENODATA;
+		}
+		spin_unlock_irqrestore(&hidg->report_spinlock, flags);
+		kfree(ptr);
+		break;
+	case GADGET_UPDATE_REPORT_STATUS:
+		spin_lock_irqsave(&hidg->report_spinlock, flags);
+		if (list_empty(&hidg->report_list)) {
+			spin_unlock_irqrestore(&hidg->report_spinlock, flags);
+			return -ENODATA;
+		}
+		spin_unlock_irqrestore(&hidg->report_spinlock, flags);
+
+		if (copy_from_user(&report, (struct uhid_get_report_req *)arg, sizeof(report)))
+			return -EFAULT;
+
+		if (copy_from_user(&size, (void __user *)(arg + sizeof(report)), sizeof(size)))
+			return -EFAULT;
+
+		if (size > UHID_DATA_MAX)
+			return -EINVAL;
+
+		spin_lock_irqsave(&hidg->report_spinlock, flags);
+
+		ptr = f_hidg_search_for_report(hidg, report.rnum, report.rtype);
+		if (!ptr) {
+			spin_unlock_irqrestore(&hidg->report_spinlock, flags);
+			return -ENODATA;
+		}
+
+		if (copy_from_user(&ptr->report_data, (struct uhid_set_report_req *)arg,
+					sizeof(struct uhid_set_report_req))) {
+			spin_unlock_irqrestore(&hidg->report_spinlock, flags);
+			return -EFAULT;
+		}
+		spin_unlock_irqrestore(&hidg->report_spinlock, flags);
+		break;
+	}
+	return 0;
+}
+
 /*-------------------------------------------------------------------------*/
 /*                                usb_function                             */
 
@@ -634,6 +792,8 @@ static int hidg_setup(struct usb_function *f,
 	struct f_hidg			*hidg = func_to_hidg(f);
 	struct usb_composite_dev	*cdev = f->config->cdev;
 	struct usb_request		*req  = cdev->req;
+	struct report_entry		*entry;
+	unsigned long			flags;
 	int status = 0;
 	__u16 value, length;
 
@@ -649,9 +809,25 @@ static int hidg_setup(struct usb_function *f,
 		  | HID_REQ_GET_REPORT):
 		VDBG(cdev, "get_report\n");
 
-		/* send an empty report */
 		length = min_t(unsigned, length, hidg->report_length);
-		memset(req->buf, 0x0, length);
+		spin_lock_irqsave(&hidg->report_spinlock, flags);
+		if (list_empty(&hidg->report_list)) {
+			spin_unlock_irqrestore(&hidg->report_spinlock, flags);
+			memset(req->buf, 0x0, length);
+			goto respond;
+		}
+
+		entry = f_hidg_search_for_report(hidg, value & 0xf,
+						 value >> 8);
+
+		/* send a report */
+		if (entry) {
+			length = min_t(unsigned, length, entry->report_data.size);
+			memcpy(req->buf, entry->report_data.data, length);
+		} else {
+			memset(req->buf, 0x0, length);
+		}
+		spin_unlock_irqrestore(&hidg->report_spinlock, flags);
 
 		goto respond;
 		break;
@@ -893,6 +1069,7 @@ static const struct file_operations f_hidg_fops = {
 	.owner		= THIS_MODULE,
 	.open		= f_hidg_open,
 	.release	= f_hidg_release,
+	.unlocked_ioctl = f_hidg_ioctl,
 	.write		= f_hidg_write,
 	.read		= f_hidg_read,
 	.poll		= f_hidg_poll,
@@ -997,6 +1174,9 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	init_waitqueue_head(&hidg->read_queue);
 	INIT_LIST_HEAD(&hidg->completed_out_req);
 
+	spin_lock_init(&hidg->report_spinlock);
+	INIT_LIST_HEAD(&hidg->report_list);
+
 	/* create char device */
 	cdev_init(&hidg->cdev, &f_hidg_fops);
 	dev = MKDEV(major, hidg->minor);
diff --git a/include/linux/usb/g_hid.h b/include/uapi/linux/usb/g_hid.h
similarity index 72%
rename from include/linux/usb/g_hid.h
rename to include/uapi/linux/usb/g_hid.h
index 7581e488c237..ba3e47f076bb 100644
--- a/include/linux/usb/g_hid.h
+++ b/include/uapi/linux/usb/g_hid.h
@@ -22,6 +22,8 @@
 #ifndef __LINUX_USB_G_HID_H
 #define __LINUX_USB_G_HID_H
 
+#include <linux/uhid.h>
+
 struct hidg_func_descriptor {
 	unsigned char		subclass;
 	unsigned char		protocol;
@@ -30,4 +32,12 @@ struct hidg_func_descriptor {
 	unsigned char		report_desc[];
 };
 
+/* The 'g' code is also used by gadgetfs and printer ioctl requests.
+ * Don't add any colliding codes to either driver, and keep
+ * them in unique ranges (size 0x40 for now).
+ */
+#define GADGET_ADD_REPORT_STATUS	_IOWR('g', 0x41, struct uhid_set_report_req)
+#define GADGET_REMOVE_REPORT_STATUS	_IOWR('g', 0x42, struct uhid_get_report_req)
+#define GADGET_UPDATE_REPORT_STATUS	_IOWR('g', 0x43, struct uhid_set_report_req)
+
 #endif /* __LINUX_USB_G_HID_H */
-- 
2.25.1

