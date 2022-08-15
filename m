Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220C8592C64
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiHOK0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiHOK0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:26:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1A711C2A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:26:32 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so6389956pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=0qwus5b9RXy6ZokwuxSZLY/kVQYxsnCehnLTrQ4mJL4=;
        b=ivCNA94gxGAE4VWIb7M2ERdHVhCg/cke/0GkE7cRjNmtQzwn900nDgu7HkOQfJDr07
         5JtIjrKHmldfIX1JaaMzxqfkhPYGFKHsB6QZhwUvIGpCIrFG2e8yL9g5J8zrx4N8268u
         y5zqRKk8ZXEYdjJ0s7PlxpyfNBgZPY5LoGTSowEQzMh7AHD5EFvIQPgUILNBXJJOZLDA
         BlHUHKn40hnqkdkz0vmQQAqTwzMUCR1CatQLpXcZjsj4upB4RSc3lU64MQvIx7d4PTaQ
         KRx1dT0pJzm1YcKEh0JqtcMfLDgWWz+q/0u4ZhGvtNthT7ZkYE1Pi3kR3dbebG0zMdmr
         ccjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0qwus5b9RXy6ZokwuxSZLY/kVQYxsnCehnLTrQ4mJL4=;
        b=llFjlea75Zw2ox+BuwGR2OdFNIPomo3YGEdw44VmPpg9jIK1ND0OjDVz+kSGJurnbi
         cJ9nv/NCAMLNCrNtpJSg3BNPyjNR3vXedcpEK0+K47u2ADdCvF0XS1AOyF3jcImeVHMR
         HzKEenDTUu/gINTx+KR/b2jeKkWEtKmjcExbJlQOHEP+DlolRMERefReoU0C9JUADRPC
         cxrrbfJVBIDFGNuD/vqGFAtfAVe/qjTjHDhm2JuNC2smJ7CsH7fiK4/LogwU2eWmGNWH
         qxGrZ/SpvDC21lCt34c9ocQNaED49GtrStW5sSbuVYOXM/n9wvhi9rAaWWQiLTsDt5kr
         2Vxg==
X-Gm-Message-State: ACgBeo3zcmA3LJ2dBD8aFqJwyrVLlHttY1gtcz4ald4ZCVNgd0vSMXUC
        Rs+zkJSydt5EFnwPzGTf8Fyfqw==
X-Google-Smtp-Source: AA6agR6L0e1ZHyjT8e9bq8aJSS9MkSa0MGlwt/xbfty0AhZKjBEJxVZj/d/vEczDSP/ASkQrNID91w==
X-Received: by 2002:a17:903:1c7:b0:16f:1228:f632 with SMTP id e7-20020a17090301c700b0016f1228f632mr16043149plh.65.1660559191644;
        Mon, 15 Aug 2022 03:26:31 -0700 (PDT)
Received: from margeyang-ThinkPad-T440.synaptics-inc.local ([63.222.17.37])
        by smtp.gmail.com with ESMTPSA id l11-20020a63da4b000000b0041bcd8f3958sm5581258pgj.44.2022.08.15.03.26.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Aug 2022 03:26:31 -0700 (PDT)
From:   margeyang <marge.yang@synaptics.corp-partner.google.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        benjamin.tissoires@redhat.com, dancarpenter@oracle.com
Cc:     marge.yang@tw.synaptics.com, derek.cheng@tw.synaptics.com,
        vincent.huang@tw.synaptics.com,
        Marge Yang <marge.yang@synaptics.corp-partner.google.com>
Subject: [PATCH V4] HID: HID-rmi - ignore to rmi_hid_read_block after system resumes.
Date:   Mon, 15 Aug 2022 18:26:18 +0800
Message-Id: <1660559178-5323-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marge Yang <marge.yang@synaptics.corp-partner.google.com>

The interrupt GPIO will be pulled down once
after RMI driver reads this command(Report ID:0x0A).
It will cause "Dark resume test fail" for chromebook device.
Hence, TP driver will ignore rmi_hid_read_block function once
after system resumes.

Signed-off-by: Marge Yang<marge.yang@synaptics.corp-partner.google.com>
---
 drivers/hid/hid-rmi.c | 14 +++++++++++++-
 include/linux/rmi.h   |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 311eee599ce9..45eacb0b8dae 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -190,7 +190,7 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 {
 	struct rmi_data *data = container_of(xport, struct rmi_data, xport);
 	struct hid_device *hdev = data->hdev;
-	int ret;
+	int ret = 0;
 	int bytes_read;
 	int bytes_needed;
 	int retries;
@@ -204,6 +204,13 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 			goto exit;
 	}
 
+	if (xport->ignoreonce == 1) {
+		dev_err(&hdev->dev,
+			"ignoreonce (%d)\n",
+			xport->ignoreonce);
+		xport->ignoreonce = 0;
+		goto exit;
+	}
 	for (retries = 5; retries > 0; retries--) {
 		data->writeReport[0] = RMI_READ_ADDR_REPORT_ID;
 		data->writeReport[1] = 0; /* old 1 byte read count */
@@ -469,7 +476,12 @@ static int rmi_post_resume(struct hid_device *hdev)
 	if (ret)
 		return ret;
 
+	// Avoid to read rmi_hid_read_block once after system resumes.
+	// The interrupt will be pulled down
+	// after RMI Read command(Report ID:0x0A).
+	data->xport.ignoreonce = 1;
 	ret = rmi_reset_attn_mode(hdev);
+	data->xport.ignoreonce = 0;
 	if (ret)
 		goto out;
 
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index ab7eea01ab42..24f63ad00970 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -270,6 +270,8 @@ struct rmi_transport_dev {
 	struct rmi_device_platform_data pdata;
 
 	struct input_dev *input;
+
+	int ignoreonce;
 };
 
 /**
-- 
2.22.0.windows.1

