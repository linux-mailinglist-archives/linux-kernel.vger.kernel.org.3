Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A14466102
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357104AbhLBKAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:00:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240859AbhLBJ5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638438827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fV6MddJ34nvL6SN6OucVEqPOcOC0ApCN730v736bDgw=;
        b=ay8F0AHHMG9j61/ol7B9tPSth9i/9cztunqxldHlmTqp0IBRABHA0xcyWKjyJszlu5tm2z
        yBlEYB7txmr21ZdvpkLeQr0HwiSdPwOV2q9etoAhv4LoSKIGvWAasOTQ+yWYIpw1erRcUr
        Zz+ogStlt4KnUH5D5Jk3kJ4qIXd9kEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-HUmXPeToPLG9EYyZoDhiOw-1; Thu, 02 Dec 2021 04:53:46 -0500
X-MC-Unique: HUmXPeToPLG9EYyZoDhiOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BFC81934105;
        Thu,  2 Dec 2021 09:53:45 +0000 (UTC)
Received: from xps-13.redhat.com (unknown [10.39.195.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC64C19C46;
        Thu,  2 Dec 2021 09:53:43 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/4] HID: do not inline some hid_hw_ functions
Date:   Thu,  2 Dec 2021 10:53:34 +0100
Message-Id: <20211202095334.14399-5-benjamin.tissoires@redhat.com>
In-Reply-To: <20211202095334.14399-1-benjamin.tissoires@redhat.com>
References: <20211202095334.14399-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't gain much by having them as inline, and it
actually prevents us to attach a probe to those helpers.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c | 64 +++++++++++++++++++++++++++++++++++++++
 include/linux/hid.h    | 68 ++++--------------------------------------
 2 files changed, 70 insertions(+), 62 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5402329d6eca..f1aed5bbd000 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2126,6 +2126,70 @@ void hid_hw_close(struct hid_device *hdev)
 }
 EXPORT_SYMBOL_GPL(hid_hw_close);
 
+/**
+ * hid_hw_request - send report request to device
+ *
+ * @hdev: hid device
+ * @report: report to send
+ * @reqtype: hid request type
+ */
+void hid_hw_request(struct hid_device *hdev,
+		    struct hid_report *report, int reqtype)
+{
+	if (hdev->ll_driver->request)
+		return hdev->ll_driver->request(hdev, report, reqtype);
+
+	__hid_request(hdev, report, reqtype);
+}
+EXPORT_SYMBOL_GPL(hid_hw_request);
+
+/**
+ * hid_hw_raw_request - send report request to device
+ *
+ * @hdev: hid device
+ * @reportnum: report ID
+ * @buf: in/out data to transfer
+ * @len: length of buf
+ * @rtype: HID report type
+ * @reqtype: HID_REQ_GET_REPORT or HID_REQ_SET_REPORT
+ *
+ * Return: count of data transferred, negative if error
+ *
+ * Same behavior as hid_hw_request, but with raw buffers instead.
+ */
+int hid_hw_raw_request(struct hid_device *hdev,
+		       unsigned char reportnum, __u8 *buf,
+		       size_t len, unsigned char rtype, int reqtype)
+{
+	if (len < 1 || len > HID_MAX_BUFFER_SIZE || !buf)
+		return -EINVAL;
+
+	return hdev->ll_driver->raw_request(hdev, reportnum, buf, len,
+					    rtype, reqtype);
+}
+EXPORT_SYMBOL_GPL(hid_hw_raw_request);
+
+/**
+ * hid_hw_output_report - send output report to device
+ *
+ * @hdev: hid device
+ * @buf: raw data to transfer
+ * @len: length of buf
+ *
+ * Return: count of data transferred, negative if error
+ */
+int hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len)
+{
+	if (len < 1 || len > HID_MAX_BUFFER_SIZE || !buf)
+		return -EINVAL;
+
+	if (hdev->ll_driver->output_report)
+		return hdev->ll_driver->output_report(hdev, buf, len);
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL_GPL(hid_hw_output_report);
+
 #ifdef CONFIG_PM
 int hid_driver_suspend(struct hid_device *hdev, pm_message_t state)
 {
diff --git a/include/linux/hid.h b/include/linux/hid.h
index cce1b01b3055..313fa4a2554f 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1071,6 +1071,12 @@ int __must_check hid_hw_start(struct hid_device *hdev,
 void hid_hw_stop(struct hid_device *hdev);
 int __must_check hid_hw_open(struct hid_device *hdev);
 void hid_hw_close(struct hid_device *hdev);
+void hid_hw_request(struct hid_device *hdev,
+		    struct hid_report *report, int reqtype);
+int hid_hw_raw_request(struct hid_device *hdev,
+		       unsigned char reportnum, __u8 *buf,
+		       size_t len, unsigned char rtype, int reqtype);
+int hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len);
 
 /**
  * hid_hw_power - requests underlying HW to go into given power mode
@@ -1088,68 +1094,6 @@ static inline int hid_hw_power(struct hid_device *hdev, int level)
 }
 
 
-/**
- * hid_hw_request - send report request to device
- *
- * @hdev: hid device
- * @report: report to send
- * @reqtype: hid request type
- */
-static inline void hid_hw_request(struct hid_device *hdev,
-				  struct hid_report *report, int reqtype)
-{
-	if (hdev->ll_driver->request)
-		return hdev->ll_driver->request(hdev, report, reqtype);
-
-	__hid_request(hdev, report, reqtype);
-}
-
-/**
- * hid_hw_raw_request - send report request to device
- *
- * @hdev: hid device
- * @reportnum: report ID
- * @buf: in/out data to transfer
- * @len: length of buf
- * @rtype: HID report type
- * @reqtype: HID_REQ_GET_REPORT or HID_REQ_SET_REPORT
- *
- * Return: count of data transferred, negative if error
- *
- * Same behavior as hid_hw_request, but with raw buffers instead.
- */
-static inline int hid_hw_raw_request(struct hid_device *hdev,
-				  unsigned char reportnum, __u8 *buf,
-				  size_t len, unsigned char rtype, int reqtype)
-{
-	if (len < 1 || len > HID_MAX_BUFFER_SIZE || !buf)
-		return -EINVAL;
-
-	return hdev->ll_driver->raw_request(hdev, reportnum, buf, len,
-						    rtype, reqtype);
-}
-
-/**
- * hid_hw_output_report - send output report to device
- *
- * @hdev: hid device
- * @buf: raw data to transfer
- * @len: length of buf
- *
- * Return: count of data transferred, negative if error
- */
-static inline int hid_hw_output_report(struct hid_device *hdev, __u8 *buf,
-					size_t len)
-{
-	if (len < 1 || len > HID_MAX_BUFFER_SIZE || !buf)
-		return -EINVAL;
-
-	if (hdev->ll_driver->output_report)
-		return hdev->ll_driver->output_report(hdev, buf, len);
-
-	return -ENOSYS;
-}
-
 /**
  * hid_hw_idle - send idle request to device
  *
-- 
2.33.1

