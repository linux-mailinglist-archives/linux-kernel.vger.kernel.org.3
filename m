Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3853B501FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348058AbiDOAf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348038AbiDOAfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:35:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CA4B0A4B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:32:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n8so6023810plh.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C5t3e+cZTj4xwdAITByfx8113SkQvPNyKKAsLc7zHFM=;
        b=Sre7yJqjWog5IzWlAJouxhJIxDudi3P7KD3fupciGkuyrvofNEAvI6ORbO60O9ZAZl
         Ijh9lYeRczXJ1Vvrwlg9LZ0q5AjBBmPg0zqi98nw8R+2XJEJE/dy5VprhT6XO7G34/6y
         /5tfZ9uQuwRXXUQRMhjzq7HEs4yCBtKp7QfMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C5t3e+cZTj4xwdAITByfx8113SkQvPNyKKAsLc7zHFM=;
        b=btVEvqg48/jerLnpT38w0b8XnUowBnAfTHljd+8dKz4ssXuM8ZJJTWd8Ttiek5Ec13
         gVpUWuoVRBhSYQ3rlIBtd9/0ICMg55nR84fPT8rvSLSmohCCiZy73rsa8AHkv+KxfqWP
         33E5gF9yYfhIIImL4BxyzqjY0I3eFVmr75I2uj8Zg76XiREgQQZ6sHFZHZtNWSw5eWQg
         O9xqyZmtY8VFeUm5rtnncRF4qDueid0F5KWk/2LWdznYhhPS2uA8YdpRYChgP9kOBeyi
         JfUVtOfHt+PJLjMy5nhRRop3WvMP0zUVOoKkVx3KXTbZW1MuPxVBQfgI3q2+UNN7fRhE
         jwhw==
X-Gm-Message-State: AOAM531Dp7Mb1VhUOnadhPuSTSPgNBpv6epAjgHfAwZwJKdC+1qqrrte
        HH/+idzr3EDd0m1gZfyftD2u6dQlAVjP9w==
X-Google-Smtp-Source: ABdhPJyX/cNKS4BBDlZhUfNXn3R48lgEEQXevRhtV5J7S7Guj8PpbEYGPvwnRdf6ljVjJ3e+Vg2vtA==
X-Received: by 2002:a17:902:bd06:b0:158:8973:b16b with SMTP id p6-20020a170902bd0600b001588973b16bmr15242969pls.129.1649982776334;
        Thu, 14 Apr 2022 17:32:56 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:e3e0:734:f81a:d2c1])
        by smtp.gmail.com with ESMTPSA id p12-20020a63ab0c000000b00381f7577a5csm2830187pgf.17.2022.04.14.17.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 17:32:56 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Lee Jones <lee.jones@linaro.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH 1/3] platform/chrome: cros_ec_proto: Add peripheral charger count API
Date:   Thu, 14 Apr 2022 17:32:51 -0700
Message-Id: <20220415003253.1973106-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220415003253.1973106-1-swboyd@chromium.org>
References: <20220415003253.1973106-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a peripheral charger count API similar to the one implemented in the
ChromeOS PCHG driver so we can use it to decide whether or not to
register the PCHG device in the cros_ec MFD driver.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daisuke Nojiri <dnojiri@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: <chrome-platform@lists.linux.dev>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c     | 31 +++++++++++++++++++++
 include/linux/platform_data/cros_ec_proto.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index c4caf2e2de82..42269703ca6c 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -832,6 +832,37 @@ bool cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 }
 EXPORT_SYMBOL_GPL(cros_ec_check_features);
 
+/**
+ * cros_ec_pchg_port_count() - Return the number of peripheral charger ports.
+ * @ec: EC device.
+ *
+ * Return: Number of peripheral charger ports, or 0 in case of error.
+ */
+unsigned int cros_ec_pchg_port_count(struct cros_ec_dev *ec)
+{
+	struct cros_ec_command *msg;
+	const struct ec_response_pchg_count *rsp;
+	struct cros_ec_device *ec_dev = ec->ec_dev;
+	int ret, count = 0;
+
+	msg = kzalloc(sizeof(*msg) + sizeof(*rsp), GFP_KERNEL);
+	if (!msg)
+		return 0;
+
+	msg->command = EC_CMD_PCHG_COUNT + ec->cmd_offset;
+	msg->insize = sizeof(*rsp);
+
+	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
+	if (ret >= 0) {
+		rsp = (const struct ec_response_pchg_count *)msg->data;
+		count = rsp->port_count;
+	}
+	kfree(msg);
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(cros_ec_pchg_port_count);
+
 /**
  * cros_ec_get_sensor_count() - Return the number of MEMS sensors supported.
  *
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index df3c78c92ca2..8f5781bc2d7a 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -230,6 +230,7 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
 bool cros_ec_check_features(struct cros_ec_dev *ec, int feature);
 
 int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
+unsigned int cros_ec_pchg_port_count(struct cros_ec_dev *ec);
 
 int cros_ec_command(struct cros_ec_device *ec_dev, unsigned int version, int command, void *outdata,
 		    int outsize, void *indata, int insize);
-- 
https://chromeos.dev

