Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BFA58C545
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242062AbiHHJHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241930AbiHHJHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:07:46 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E069613EA4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:07:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id f28so7582268pfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=uXfRDudrIK/ym9JOWmRUVgw+nCbxEojGCmMIxNo4iG0=;
        b=ZWwO3btjzt2PD//bvwV3/BHYNE6I9njvJCcGeNZ4+25Hel6A0Ntv/5+6zg/+3fivd1
         G0B1ybVEE7mvZr6zvtioMZnbdnLKiIbV/hCP/yfmkIbILf1c74ZVwzNYHp3gwrUqdU6L
         E96KNJx8MSWW5RjGa4uSVpP0kMU0ukh8Ck6RsbTbh6P7lraMqRe9kNOmmUGBNuNvZttj
         bqLPl4BREuqS3l6OP533To1RCM6hZLlDoCGjP6SfEJ+cTWjdAf+9ISoVyKvlfF27Zkm2
         5kigS6kXV+2+sZEfjKMOG7ljSowE+492p8eIhAe+haKhPqTCYgRvkopCCgAd+cFftf0s
         Qg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uXfRDudrIK/ym9JOWmRUVgw+nCbxEojGCmMIxNo4iG0=;
        b=bsApAfztMPRm5v1nFdDf2ADx7A6B2leD2DDkvwVOBZhRbo+Z7pVUn88Z7FiZuvUIHf
         QhmoLhuesuLaBhHykkXTxKoQe9XP4mta+T0P1ADAB9rS57m3IT8Zd2WuyCkTi/OPgn3E
         WAFjCyyBWQgHNJ9ZpmYdCzgc+pvlyW7Hn7mot3YrMlkKg0WFjDkpDZyJ+zFNtuKUv6mg
         30/PVRqaFr/i3QUOY6Ebn/S+cIiHDfUFcgcV92SxLzzUpBSzkYXxrfGo1Vv1BGo0CZnQ
         8gZNVZekG+sfqNat05ekExLeW34optXhW4Mb4oQ2IBs1KBcFcDBoMocAxx3vuqWdmbhg
         tvnA==
X-Gm-Message-State: ACgBeo2AiM+6PF30CtXTNZUH/dHVzqEVSJE+PEpEK/TyLcVnlU7a/iR1
        A6lIT1DcVb1SJVm+mftnue05Iw==
X-Google-Smtp-Source: AA6agR60zET4m7agymxSlxzEjRGY6WxbCBr9Oj5xR7sBojNyZSazQjhdScxJB96ScZjhBEAmInPDGA==
X-Received: by 2002:a63:e511:0:b0:41d:2c8d:e9f with SMTP id r17-20020a63e511000000b0041d2c8d0e9fmr8723595pgh.404.1659949664388;
        Mon, 08 Aug 2022 02:07:44 -0700 (PDT)
Received: from localhost.localdomain ([63.222.17.38])
        by smtp.gmail.com with ESMTPSA id a3-20020aa795a3000000b005289ef6db79sm8047671pfk.32.2022.08.08.02.07.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Aug 2022 02:07:43 -0700 (PDT)
From:   margeyang <marge.yang@synaptics.corp-partner.google.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        benjamin.tissoires@redhat.com
Cc:     marge.yang@tw.synaptics.com, derek.cheng@tw.synaptcs.com,
        vincent.huang@tw.synaptics.com,
        Marge Yang <marge.yang@synaptics.corp-partner.google.com>
Subject: [PATCH] HID: HID-rmi - ignore to rmi_hid_read_block after system resumes.
Date:   Mon,  8 Aug 2022 17:07:19 +0800
Message-Id: <1659949639-3127-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/hid/hid-rmi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 311eee599ce9..236a38bfcf9a 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -101,7 +101,7 @@ struct rmi_data {
 };
 
 #define RMI_PAGE(addr) (((addr) >> 8) & 0xff)
-
+int ignoreonce;
 static int rmi_write_report(struct hid_device *hdev, u8 *report, int len);
 
 /**
@@ -203,7 +203,13 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 		if (ret < 0)
 			goto exit;
 	}
-
+	if (ignoreonce == 1) {
+		dev_err(&hdev->dev,
+			"ignoreonce (%d)\n",
+			ignoreonce);
+		ignoreonce = 0;
+		goto exit;
+	}
 	for (retries = 5; retries > 0; retries--) {
 		data->writeReport[0] = RMI_READ_ADDR_REPORT_ID;
 		data->writeReport[1] = 0; /* old 1 byte read count */
@@ -468,8 +474,12 @@ static int rmi_post_resume(struct hid_device *hdev)
 	ret = hid_hw_open(hdev);
 	if (ret)
 		return ret;
-
+	// Avoid to read rmi_hid_read_block once after system resumes.
+	// The interrupt will be pulled down
+	// after RMI Read command(Report ID:0x0A).
+	ignoreonce = 1;
 	ret = rmi_reset_attn_mode(hdev);
+	ignoreonce = 0;
 	if (ret)
 		goto out;
 
-- 
2.22.0.windows.1

