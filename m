Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9853557DF85
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiGVKXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbiGVKXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:23:39 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6228D5C7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:23:38 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id bd7-20020a656e07000000b00412a946da8eso2224570pgb.20
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hBY0IJGvt2jUk2Z9CmQ7C6mkhe5vlF82u2blKwho5Mw=;
        b=KibTanT7hOnEd+7E4Vg8YmsyhYwS2LYcPHC595oEHzyTeOsx9D/IvnI1qfQ4dKui0z
         68cdSTR2hWoGbXfwHzZzwcxy7K6G87aRWlHR89SX15NeBH4oCgKd5nLz3VSLXXad1xdR
         SVIQEbIhp4u3jrpwoIfq80J1RSb4nC/5A+jrfIhQ1MjIldWmx28U7LHMg2ktroWgMnK5
         iiFjDSNCAl6rjjXAiYG594fy6I/jy2t/w+a4qb8AeMW9+rEyZBKx7KOXUJipMdJg9Vcx
         yF3/oANduwV1UvIctvAtBPDRrU0NXLoBa6kGuBZK+9umy0hottJBhlPPivg81qwfhrJr
         v6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hBY0IJGvt2jUk2Z9CmQ7C6mkhe5vlF82u2blKwho5Mw=;
        b=6+t9fqSIokLQC4mPPGet3jjtH5JuO9Cgm1R3r5cdvyeFIlX192qngsdk2yD2J09jcN
         Rm34u6ETau4diTXItqDEQXp3pAdWHTBx3Gk83lWS0bXqn1kYmZ8RCOoUVIRo/cXLhs0V
         8qWuH4xq3fr91Ze1pcxefbrWVl8Rr5AmEO34ke+N8onyG0dKelmicjzEpD/XR2JIisrZ
         K+EHD8JTs0Qzgukpu8+SAqdeJh3+Pjq7e/LgbXjRd4Do5bAMd2a3NEhJiWh8ZEkOzfze
         Fh7KuGftnYatAZGpcBSbvh16ozHD38xm1goEUp3XwYKlksqxze2XHFfpaJppdomSRGGf
         5aTA==
X-Gm-Message-State: AJIora9cNkpqRhnROFubfK714sPFT6gIQM5YF3QxFzglhusjqmMMxuVz
        3i8bQGOhMStpQriKyso1tKg7a+x8os5h
X-Google-Smtp-Source: AGRyM1usGPR5zIG3GM+0W7vlI1ncHH6VPG7LalUXm1vbL88XAZTxlmvluhzpJyRCRTJJ8AYQrXhBEElHFLjM
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:4ceb:6376:128b:2c25])
 (user=apusaka job=sendgmr) by 2002:a05:6a00:1a44:b0:528:6af7:ff4a with SMTP
 id h4-20020a056a001a4400b005286af7ff4amr2806413pfv.78.1658485418118; Fri, 22
 Jul 2022 03:23:38 -0700 (PDT)
Date:   Fri, 22 Jul 2022 18:23:30 +0800
Message-Id: <20220722182248.1.I20e96c839200bb75cd6af80384f16c8c01498f57@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH] Bluetooth: hci_sync: Use safe loop when adding accept list
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Zhengping Jiang <jiangzp@google.com>,
        Michael Sun <michaelfsun@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

When in the middle of adding accept list, the userspace can still
remove devices, therefore causing crash if the removed device is
the one being processed.

Use a safe loop mechanism to guard against deletion while iterating
the pending items.

Below is a sample btsnoop log when user enters wrong passkey when
pairing a LE keyboard and the corresponding stacktrace.
@ MGMT Event: Command Complete (0x0001) plen 10
      Add Device (0x0033) plen 7
        Status: Success (0x00)
        LE Address: CA:CA:BD:78:37:F9 (Static)
< HCI Command: LE Add Device To Accept List (0x08|0x0011) plen 7
        Address type: Random (0x01)
        Address: CA:CA:BD:78:37:F9 (Static)
@ MGMT Event: Device Removed (0x001b) plen 7
        LE Address: CA:CA:BD:78:37:F9 (Static)
> HCI Event: Command Complete (0x0e) plen 4
      LE Add Device To Accept List (0x08|0x0011) ncmd 1
        Status: Success (0x00)

[  167.409813] Call trace:
[  167.409983]  hci_le_add_accept_list_sync+0x64/0x26c
[  167.410150]  hci_update_passive_scan_sync+0x5f0/0x6dc
[  167.410318]  add_device_sync+0x18/0x24
[  167.410486]  hci_cmd_sync_work+0xe8/0x150
[  167.410509]  process_one_work+0x140/0x4d0
[  167.410526]  worker_thread+0x134/0x2e4
[  167.410544]  kthread+0x148/0x160
[  167.410562]  ret_from_fork+0x10/0x30

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Zhengping Jiang <jiangzp@google.com>
Reviewed-by: Michael Sun <michaelfsun@google.com>

---

 net/bluetooth/hci_sync.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3067d94e7a8e..8e843d34f7de 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1863,7 +1863,7 @@ struct sk_buff *hci_read_local_oob_data_sync(struct hci_dev *hdev,
  */
 static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 {
-	struct hci_conn_params *params;
+	struct hci_conn_params *params, *tmp;
 	struct bdaddr_list *b, *t;
 	u8 num_entries = 0;
 	bool pend_conn, pend_report;
@@ -1930,7 +1930,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	 * just abort and return filer policy value to not use the
 	 * accept list.
 	 */
-	list_for_each_entry(params, &hdev->pend_le_conns, action) {
+	list_for_each_entry_safe(params, tmp, &hdev->pend_le_conns, action) {
 		err = hci_le_add_accept_list_sync(hdev, params, &num_entries);
 		if (err)
 			goto done;
@@ -1940,7 +1940,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	 * the list of pending reports and also add these to the
 	 * accept list if there is still space. Abort if space runs out.
 	 */
-	list_for_each_entry(params, &hdev->pend_le_reports, action) {
+	list_for_each_entry_safe(params, tmp, &hdev->pend_le_reports, action) {
 		err = hci_le_add_accept_list_sync(hdev, params, &num_entries);
 		if (err)
 			goto done;
-- 
2.37.1.359.gd136c6c3e2-goog

