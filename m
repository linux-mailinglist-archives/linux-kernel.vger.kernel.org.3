Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED87C4B3DDC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 22:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiBMV4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 16:56:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238473AbiBMV4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 16:56:40 -0500
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Feb 2022 13:56:31 PST
Received: from zeus.flokli.de (mail.zeus.flokli.de [88.198.15.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0CA54192;
        Sun, 13 Feb 2022 13:56:31 -0800 (PST)
Received: from localhost (ip-178-200-100-055.um45.pools.vodafone-ip.de [178.200.100.55])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: flokli@flokli.de)
        by zeus.flokli.de (Postfix) with ESMTPSA id 1F91E1299FC4;
        Sun, 13 Feb 2022 21:50:00 +0000 (UTC)
From:   Florian Klink <flokli@flokli.de>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        ValdikSS <iam@valdikss.org.ru>, Florian Klink <flokli@flokli.de>
Subject: [PATCH v4 3/3] HID: lenovo: Add note about different report numbers
Date:   Sun, 13 Feb 2022 22:49:24 +0100
Message-Id: <20220213214924.32407-4-flokli@flokli.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220213214924.32407-1-flokli@flokli.de>
References: <20220213214924.32407-1-flokli@flokli.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ValdikSS <iam@valdikss.org.ru>

Signed-off-by: Florian Klink <flokli@flokli.de>
---
 drivers/hid/hid-lenovo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index e9466ae8a9cb..9dabd6323234 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -487,6 +487,11 @@ static int lenovo_send_cmd_cptkbd(struct hid_device *hdev,
 	if (!buf)
 		return -ENOMEM;
 
+	/*
+	 * Feature report 0x13 is used for USB,
+	 * output report 0x18 is used for Bluetooth.
+	 * buf[0] is ignored by hid_hw_raw_request.
+	 */
 	buf[0] = 0x18;
 	buf[1] = byte2;
 	buf[2] = byte3;
-- 
2.35.1

