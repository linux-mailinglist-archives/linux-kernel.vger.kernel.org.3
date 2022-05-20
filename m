Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79ED52F2F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352735AbiETSex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349180AbiETSeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:34:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BD86B7D9;
        Fri, 20 May 2022 11:34:43 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m20so1473798wrb.13;
        Fri, 20 May 2022 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71rNmvdBNzrDpvjl6ye6mbU4jyI75AeH59SJ+4jpFZc=;
        b=FC1S0/4xLynlkKxblmICDerO/KOcxzps4ZEDHNsyV4XiIUvW3UoGUmFMgRI1U1+Uxz
         AYvM7Ympxl+zPuyJeTvD0x75fVKk4uNCOzGxJ3zRPATWARu18IhcKEXlC9HD4wEXaBkH
         omYWfka6r8203TMw8WhVy3BuGDOkxaA3EbV7gW8HhD/qJE7LJHEmgUH685ANOqjpg/ou
         D6sSrDrbCvIfwM9Myj/K/MYnEApOPV39y4TOWI4fiDYthi3rz8u4/pPTU8XEBTbvffqE
         bC48Tt6EpNMPocoqGkhyZqTo0cA2CD/M1o7jsJiLjX47J3IIwhItHgl+ZBIIJNBvHSJg
         a4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71rNmvdBNzrDpvjl6ye6mbU4jyI75AeH59SJ+4jpFZc=;
        b=LqF8K5g0b4/SG50DzsbgWSWP+WF+4YqyS3by97BHpFfG0hYwrBUooul2Q8to5khS0U
         XWbRptkNDPXmhiiCJX63SRzSJhbSXpgrW1YpPNUJvEulIIfTfullasRa2IiLNUDG6nAJ
         D/cKLAmpcTAxlbV98eBpRmtWOgpcnwNN6N/Zp8cElfpX16UkJy3Jc4RkY7HY3KuevmvT
         m9qHI5FC4TDQ95fbWASCUTmUytF23WMcEnyX1oUxlzzN/7W8ZHm6J78U2qbctvgeO/a3
         vxXxjouAiyqfUgtp4bnScyhgiVCStar9QX/x1bX67ChhPyK+6ODURakMl2wuwWHzlyZQ
         39Kg==
X-Gm-Message-State: AOAM530tmvl03XERRizxOMZ1I7s9Vr2UEzhlIgokXsaeTnrmnanyzLAW
        dWYgxx/Y8NR5woDCK8WtMLA=
X-Google-Smtp-Source: ABdhPJxt3nDqtx1ogf7NJXt4PCZFVicNi7Z27RLRla8Rc9UbhVU3A2DahhT7K45Y0OxSoBa8gHffjw==
X-Received: by 2002:a05:6000:15ca:b0:20c:4f4b:84ee with SMTP id y10-20020a05600015ca00b0020c4f4b84eemr9794115wry.207.1653071681801;
        Fri, 20 May 2022 11:34:41 -0700 (PDT)
Received: from xws.localdomain (pd9e5a9fe.dip0.t-ipconnect.de. [217.229.169.254])
        by smtp.gmail.com with ESMTPSA id r9-20020adfa149000000b0020e62feca05sm3252081wrr.32.2022.05.20.11.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:34:41 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] platform/surface: aggregator: Allow devices to be marked as hot-removed
Date:   Fri, 20 May 2022 20:34:13 +0200
Message-Id: <20220520183422.7185-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520183422.7185-1-luzmaximilian@gmail.com>
References: <20220520183422.7185-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SSAM devices, notably the keyboard cover (keyboard and touchpad) on
the Surface Pro 8, can be hot-removed. When this occurs, communication
with the device may fail and time out. This timeout can unnecessarily
block and slow down device removal and even cause issues when the
devices are detached and re-attached quickly. Thus, communication should
generally be avoided once hot-removal is detected.

While we already remove a device as soon as we detect its (hot-)removal,
the corresponding device driver may still attempt to communicate with
the device during teardown. This is especially critical as communication
failure may also extend to disabling of events, which is typically done
at that stage.

Add a flag to allow marking devices as hot-removed. This can then be
used during client driver teardown to check if any communication
attempts should be avoided.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 include/linux/surface_aggregator/device.h | 48 +++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index cc257097eb05..491aa7e9f4bc 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -148,17 +148,30 @@ struct ssam_device_uid {
 #define SSAM_SDEV(cat, tid, iid, fun) \
 	SSAM_DEVICE(SSAM_DOMAIN_SERIALHUB, SSAM_SSH_TC_##cat, tid, iid, fun)
 
+/*
+ * enum ssam_device_flags - Flags for SSAM client devices.
+ * @SSAM_DEVICE_HOT_REMOVED_BIT:
+ *	The device has been hot-removed. Further communication with it may time
+ *	out and should be avoided.
+ */
+enum ssam_device_flags {
+	SSAM_DEVICE_HOT_REMOVED_BIT = 0,
+};
+
 /**
  * struct ssam_device - SSAM client device.
- * @dev:  Driver model representation of the device.
- * @ctrl: SSAM controller managing this device.
- * @uid:  UID identifying the device.
+ * @dev:   Driver model representation of the device.
+ * @ctrl:  SSAM controller managing this device.
+ * @uid:   UID identifying the device.
+ * @flags: Device state flags, see &enum ssam_device_flags.
  */
 struct ssam_device {
 	struct device dev;
 	struct ssam_controller *ctrl;
 
 	struct ssam_device_uid uid;
+
+	unsigned long flags;
 };
 
 /**
@@ -240,6 +253,35 @@ struct ssam_device *ssam_device_alloc(struct ssam_controller *ctrl,
 int ssam_device_add(struct ssam_device *sdev);
 void ssam_device_remove(struct ssam_device *sdev);
 
+/**
+ * ssam_device_mark_hot_removed() - Mark the given device as hot-removed.
+ * @sdev: The device to mark as hot-removed.
+ *
+ * Mark the device as having been hot-removed. This signals drivers using the
+ * device that communication with the device should be avoided and may lead to
+ * timeouts.
+ */
+static inline void ssam_device_mark_hot_removed(struct ssam_device *sdev)
+{
+	dev_dbg(&sdev->dev, "marking device as hot-removed\n");
+	set_bit(SSAM_DEVICE_HOT_REMOVED_BIT, &sdev->flags);
+}
+
+/**
+ * ssam_device_is_hot_removed() - Check if the given device has been
+ * hot-removed.
+ * @sdev: The device to check.
+ *
+ * Checks if the given device has been marked as hot-removed. See
+ * ssam_device_mark_hot_removed() for more details.
+ *
+ * Return: Returns ``true`` if the device has been marked as hot-removed.
+ */
+static inline bool ssam_device_is_hot_removed(struct ssam_device *sdev)
+{
+	return test_bit(SSAM_DEVICE_HOT_REMOVED_BIT, &sdev->flags);
+}
+
 /**
  * ssam_device_get() - Increment reference count of SSAM client device.
  * @sdev: The device to increment the reference count of.
-- 
2.36.1

