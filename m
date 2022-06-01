Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E708553A9B5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354476AbiFAPMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353781AbiFAPMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:12:37 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A500488A8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:12:36 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c8-20020a05620a268800b0069c0f1b3206so1490779qkp.18
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kgeENkTKQF5CH/ji/s7eILYDZxj2xanbyJLZhsasnkA=;
        b=FJxMPGLt2Bpvw2/0+tJdREvb+DvBVoSgL11uuMKQGGTKHhbzS1I+Kb5IoBEB8FEwZl
         5PL30L7Ye9wlkvHJ1x3wx36AWb/z3moL84nUSqZlHzJrad66C9/VQ9u7QQzKEvTSXlW7
         rvy4jBfDlCdSiT+XDVTD+i2XLVhe3o0D/1rXCHKitF61d49rYkx8M4L4h2HqRjpXDL3m
         uY3Cm8nhLzAqLc+TY/4QGvQR9at5NiE8yWTOylrD8Iz9Y/wIZrRIccGo4Da7Y1jFL1N9
         JODWH9iZODIrQCpWLK80EzwKYOygFwR434EKMuiqMbBMbutxv5twhC1Q2gU+37CZx135
         StQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kgeENkTKQF5CH/ji/s7eILYDZxj2xanbyJLZhsasnkA=;
        b=O+EA0zpT232WNcVkOd80udbjiNcHM3VYH3WTPeVlyuLq8SPO5UX3Mhv4IDMDva2MW7
         JEblOCdrI8HMFN+xQkp92RlnE+zsQ8LB2aIiuFbEDshUwvvNs6xQMJ3SRBB68L1nsxO9
         kUz8cQzmHaAB7WR5X5bfRZVnmbdahtb123g145BsC+7UrO3WKKymGbsY3OWM8zoOQ2Nn
         +AAJBz5Al3uqxNrLnz8DgBKWoXtjS6dGd5vU+9eUFQMHSSg+NTtV3FW5ODnyAJeex7bP
         z3U/+D7cNTY5Jj4n0SWKnP8O0CWbS7Vs3quDuHrh3kUbLZU4Kf5q5PUplJGVptbOYa4Q
         ep9g==
X-Gm-Message-State: AOAM532vYMxeg/kAlo9KDqT7B/fWmerPYeCJj2GJIVSjqq7MyIGS5y3S
        3mFLG1oEkaJnbByzDIkdhlMKYzPKTslcJSeULTs=
X-Google-Smtp-Source: ABdhPJzoNig3fFGatBX6poNGyFUAGYYb28s9k+CvU/LWYXulZuecUpb6DYnP8BHOpM1XCl11+luMa+37t/YNT9crnFU=
X-Received: from alainmic.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2890])
 (user=alainmichaud job=sendgmr) by 2002:ad4:5b8e:0:b0:464:50c4:c568 with SMTP
 id 14-20020ad45b8e000000b0046450c4c568mr13309768qvp.115.1654096355448; Wed,
 01 Jun 2022 08:12:35 -0700 (PDT)
Date:   Wed,  1 Jun 2022 15:11:27 +0000
Message-Id: <20220601151115.1.Ia503b15be0f366563b4e7c9f93cbec5e756bb0ae@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH] Bluetooth: clear the temporary linkkey in hci_conn_cleanup
From:   Alain Michaud <alainmichaud@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Michaud <alainm@chromium.org>

If a hardware error occurs and the connections are flushed without a
disconnection_complete event being signaled, the temporary linkkeys are
not flushed.

This change ensures that any outstanding flushable linkkeys are flushed
when the connection are flushed from the hash table.

Signed-off-by: Alain Michaud <alainm@chromium.org>

---

 net/bluetooth/hci_conn.c  | 3 +++
 net/bluetooth/hci_event.c | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 352d7d612128..85dc1af90fcb 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -118,6 +118,9 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 	if (test_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags))
 		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
 
+	if (test_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
+		hci_remove_link_key(hdev, &conn->dst);
+
 	hci_chan_list_flush(conn);
 
 	hci_conn_hash_del(hdev, conn);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6b83f9b0082c..09f4ff71e747 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3372,8 +3372,10 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
 				reason, mgmt_connected);
 
 	if (conn->type == ACL_LINK) {
-		if (test_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
+		if (test_bit(HCI_CONN_FLUSH_KEY, &conn->flags)) {
 			hci_remove_link_key(hdev, &conn->dst);
+			clear_bit(HCI_CONN_FLUSH_KEY, &conn->flags);
+		}
 
 		hci_req_update_scan(hdev);
 	}
-- 
2.36.1.255.ge46751e96f-goog

