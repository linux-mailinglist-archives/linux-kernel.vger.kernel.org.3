Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1155D53BCBE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbiFBQrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbiFBQrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:47:02 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D6ABE27
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:46:58 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id i19-20020aa79093000000b0050d44b83506so2982146pfa.22
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AjgkzHRF/kCv3qib+iv1yxeRLWexzkrlF44AYXOVusk=;
        b=PxcI3fqzRJ7ZD3F6KPWNr09AVcJI3FmA018q2QE7ljYZ8ppYLmY6bTn+v/xRABQGzp
         dgNKXCmEAexbMOwU1KkOvF6piTfhYEhVMTWQWsIpFpNFLMtc4mfllCSHGAJdQk5ygEx5
         jh6JUAwHYFTllZ0dMB833W72tz5J+XqkfjrO0Gbifa2eEmfkKVS2tbjme7t9MRTQNgn8
         wwxi2oZS6MefD6oVPHX3XuNP7fbSg2brEIq4LwVvhFIaCCk9V0MXWJdWhiOoh/IVJwGe
         Y8EtxkroN3qmRx/2olrHz6SxgDavRLd5PKiV/Fqn1UWPpuqOwWhUdfqAZQwD9MVtS4Vi
         nKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AjgkzHRF/kCv3qib+iv1yxeRLWexzkrlF44AYXOVusk=;
        b=3kfAiKDNOnUQjCnilicvbVpPc/zbSG1rkAjNM6PwRN6KPPV7U79gAcEGsox7ik9BX3
         X5yJKQ/DNUKFaS+/ddqoGkFrrfIB4Pno9cLGqoKp2vvgudN9gjKGDPPO6IZdXGQkO/gx
         ogTfrCTCj9yK3djaVsBYpktoOpGa47wOCQgFXmO2Fb9BNj5Izw8D8nt5Q2U5d6sc/arn
         kkyJICNlchPFogx2aYjd98KuNOeqar76UylGQihwttObU1NsZXqGhI0UOhiY/Qu+MXK7
         bb+7pvIjlRTe/bt6JdusSd/TwxJg5OifbhCoQgDlVlI8CowvUU8/pc90UQ41cdS7R4sO
         kInw==
X-Gm-Message-State: AOAM533Iqbrz6xLYC+LljT+MUFZmrrWfaFRuQvZsCdh2TAuUjPw66EA2
        hqBDPht5W5yzm93JLZIz2zHflSJu+WjmeO6eFGqDeQ==
X-Google-Smtp-Source: ABdhPJzMZ7vAEN4yoTtCnwEpdV5+bYJUnxSfJnm0kicvX9WAmIRgBOKPinDQ13Q7fSmw2ILb6suwvmfBYsxE/o9sPRV4kg==
X-Received: from abps.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:9b4])
 (user=abhishekpandit job=sendgmr) by 2002:a63:5c52:0:b0:3fc:cf92:ff43 with
 SMTP id n18-20020a635c52000000b003fccf92ff43mr4911152pgm.249.1654188418220;
 Thu, 02 Jun 2022 09:46:58 -0700 (PDT)
Date:   Thu,  2 Jun 2022 09:46:50 -0700
In-Reply-To: <20220602094645.1.I7d191480c15b45a237b927e26aa26ba806409efb@changeid>
Message-Id: <20220602094645.2.I8fe1bc0737dd40d4e3843ddd973fdd04ee006cfa@changeid>
Mime-Version: 1.0
References: <20220602094645.1.I7d191480c15b45a237b927e26aa26ba806409efb@changeid>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 2/2] Bluetooth: Unregister suspend with userchannel
From:   Abhishek Pandit-Subedi <abhishekpandit@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
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

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

When HCI_USERCHANNEL is used, unregister the suspend notifier when
binding and register when releasing. The userchannel socket should be
left alone after open is completed.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
Currently, the suspend notifier is harmless when used since no traffic
is actually passed to controller with HCI_USERCHANNEL. When I suspend,
all I see is the MGMT Controller Suspended and Controller Resumed
events. However, for correctness, I've opted to unregister the suspend
notifier entirely when using HCI_USERCHANNEL (similar to how the
HCI_QUIRK_NO_SUSPEND_NOTIFIER works).

The alternative to this approach would be to always keep the notifier
registered and exit early in hci_suspend_notifier. Please let me know
which you prefer.

Tested on ChromeOS kernel and compiled with allmodconfig on
bluetooth-next.

 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 33 ++++++++++++++++++++++++--------
 net/bluetooth/hci_sock.c         |  3 +++
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5a52a2018b56..5b92a9abe141 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1289,6 +1289,8 @@ void hci_free_dev(struct hci_dev *hdev);
 int hci_register_dev(struct hci_dev *hdev);
 void hci_unregister_dev(struct hci_dev *hdev);
 void hci_release_dev(struct hci_dev *hdev);
+int hci_register_suspend_notifier(struct hci_dev *hdev);
+int hci_unregister_suspend_notifier(struct hci_dev *hdev);
 int hci_suspend_dev(struct hci_dev *hdev);
 int hci_resume_dev(struct hci_dev *hdev);
 int hci_reset_dev(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5abb2ca5b129..ab647a63830d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2639,12 +2639,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	hci_sock_dev_event(hdev, HCI_DEV_REG);
 	hci_dev_hold(hdev);
 
-	if (!test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks)) {
-		hdev->suspend_notifier.notifier_call = hci_suspend_notifier;
-		error = register_pm_notifier(&hdev->suspend_notifier);
-		if (error)
-			goto err_wqueue;
-	}
+	if (hci_register_suspend_notifier(hdev))
+		goto err_wqueue;
 
 	queue_work(hdev->req_workqueue, &hdev->power_on);
 
@@ -2677,8 +2673,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_cmd_sync_clear(hdev);
 
-	if (!test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks))
-		unregister_pm_notifier(&hdev->suspend_notifier);
+	hci_unregister_suspend_notifier(hdev);
 
 	msft_unregister(hdev);
 
@@ -2742,6 +2737,28 @@ void hci_release_dev(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL(hci_release_dev);
 
+int hci_register_suspend_notifier(struct hci_dev *hdev)
+{
+	int ret = 0;
+
+	if (!test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks)) {
+		hdev->suspend_notifier.notifier_call = hci_suspend_notifier;
+		ret = register_pm_notifier(&hdev->suspend_notifier);
+	}
+
+	return ret;
+}
+
+int hci_unregister_suspend_notifier(struct hci_dev *hdev)
+{
+	int ret = 0;
+
+	if (!test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks))
+		ret = unregister_pm_notifier(&hdev->suspend_notifier);
+
+	return ret;
+}
+
 /* Suspend HCI device */
 int hci_suspend_dev(struct hci_dev *hdev)
 {
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index bd8358b44aa4..0d015d4a8e41 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -887,6 +887,7 @@ static int hci_sock_release(struct socket *sock)
 			 */
 			hci_dev_do_close(hdev);
 			hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
+			hci_register_suspend_notifier(hdev);
 			mgmt_index_added(hdev);
 		}
 
@@ -1215,6 +1216,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		}
 
 		mgmt_index_removed(hdev);
+		hci_unregister_suspend_notifier(hdev);
 
 		err = hci_dev_open(hdev->id);
 		if (err) {
@@ -1229,6 +1231,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 				err = 0;
 			} else {
 				hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
+				hci_register_suspend_notifier(hdev);
 				mgmt_index_added(hdev);
 				hci_dev_put(hdev);
 				goto done;
-- 
2.36.1.255.ge46751e96f-goog

