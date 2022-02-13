Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDF94B3DDB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 22:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbiBMV4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 16:56:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238448AbiBMV4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 16:56:40 -0500
Received: from zeus.flokli.de (mail.zeus.flokli.de [88.198.15.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5F454196;
        Sun, 13 Feb 2022 13:56:31 -0800 (PST)
Received: from localhost (ip-178-200-100-055.um45.pools.vodafone-ip.de [178.200.100.55])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: flokli@flokli.de)
        by zeus.flokli.de (Postfix) with ESMTPSA id 984D61299FBD;
        Sun, 13 Feb 2022 21:49:58 +0000 (UTC)
From:   Florian Klink <flokli@flokli.de>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        ValdikSS <iam@valdikss.org.ru>, Florian Klink <flokli@flokli.de>
Subject: [PATCH v4 2/3] HID: lenovo: Sync Fn-lock state on button press for Compact and TrackPoint II keyboards
Date:   Sun, 13 Feb 2022 22:49:23 +0100
Message-Id: <20220213214924.32407-3-flokli@flokli.de>
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

When Fn-Esc is pressed on the keyboard, it emits the scancode which could
be used to sync the fn_lock sysfs state.

Previously fn_lock only allowed to set new Fn-lock state and did not
keep the value in sync upon Fn-Esc press, which is now fixed.

Signed-off-by: Florian Klink <flokli@flokli.de>
---
 drivers/hid/hid-lenovo.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index a612ae7dfbfc..e9466ae8a9cb 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -690,6 +690,15 @@ static int lenovo_event_cptkbd(struct hid_device *hdev,
 		return 1;
 	}
 
+	if (usage->type == EV_KEY && usage->code == KEY_FN_ESC && value == 1) {
+		/*
+		 * The user has toggled the Fn-lock state. Toggle our own
+		 * cached value of it and sync our value to the keyboard to
+		 * ensure things are in sync (the syncing should be a no-op).
+		 */
+		cptkbd_data->fn_lock = !cptkbd_data->fn_lock;
+	}
+
 	return 0;
 }
 
-- 
2.35.1

