Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A556F5ACB81
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiIEG4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbiIEG4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:56:38 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DA220F47;
        Sun,  4 Sep 2022 23:56:32 -0700 (PDT)
Received: from HP-EliteBook-840-G7.. (1-171-245-2.dynamic-ip.hinet.net [1.171.245.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DF2C93F3B3;
        Mon,  5 Sep 2022 06:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662360990;
        bh=3OTxH04tly8ykdh4ItSLPlbz4yOOpq5wfxksyfOj0sA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=uGW1LI/emstwM+wyRNi345Bi6KinpHcmTHeidzg/TU+4g1+LOGJ1bqORO4qnq8DMx
         D/UuNRRHw6jnyqDfhYh4tAbGsyyhez3/G05fUciVD5Lpz0sThwqGI5o6jRs9jQQppa
         a1wRG7GZSVNuq2v/ZG6lWIGXuMmGRWD9zXhx8eN6nlVL6SGI6IMOHw+E6RzIIY/bOK
         fuEHz/0qsLgKN2iuCxFrbxu+orqUyFWQaFnDaeSWy9G0czDODpnWvz19sPzs1prs/j
         DbleJTrJ/Z5Heve1deqnUrFnYAgPWD1Q9pA8yhWuOnnBi0SNq9E4pQinHYGuqGWiIC
         JPH1V9IA/2URQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com
Cc:     sanju.mehta@amd.com, mario.limonciello@amd.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thunderbolt: Resume PCIe bridges after switch is found on AMD USB4 controller
Date:   Mon,  5 Sep 2022 14:56:22 +0800
Message-Id: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD USB4 can not detect external PCIe devices like external NVMe when
it's hotplugged, because card/link are not up:

pcieport 0000:00:04.1: pciehp: pciehp_check_link_active: lnk_status = 1101

Use `lspci` to resume pciehp bridges can find external devices.

A long delay before checking card/link presence doesn't help, either.
The only way to make the hotplug work is to enable pciehp interrupt and
check card presence after the TB switch is added.

Since the topology of USB4 and its PCIe bridges are siblings, hardcode
the bridge ID so TBT driver can wake them up to check presence.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216448
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/thunderbolt/nhi.c    | 29 +++++++++++++++++++++++++++++
 drivers/thunderbolt/switch.c |  6 ++++++
 drivers/thunderbolt/tb.c     |  1 +
 drivers/thunderbolt/tb.h     |  5 +++++
 include/linux/thunderbolt.h  |  1 +
 5 files changed, 42 insertions(+)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index cb8c9c4ae93a2..75f5ce5e22978 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1225,6 +1225,8 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct tb_nhi *nhi;
 	struct tb *tb;
+	struct pci_dev *p = NULL;
+	struct tb_pci_bridge *pci_bridge, *n;
 	int res;
 
 	if (!nhi_imr_valid(pdev)) {
@@ -1306,6 +1308,19 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		nhi_shutdown(nhi);
 		return res;
 	}
+
+	if (pdev->vendor == PCI_VENDOR_ID_AMD) {
+		while ((p = pci_get_device(PCI_VENDOR_ID_AMD, 0x14cd, p))) {
+			pci_bridge = kmalloc(sizeof(struct tb_pci_bridge), GFP_KERNEL);
+			if (!pci_bridge)
+				goto cleanup;
+
+			pci_bridge->bridge = p;
+			INIT_LIST_HEAD(&pci_bridge->list);
+			list_add(&pci_bridge->list, &tb->bridge_list);
+		}
+	}
+
 	pci_set_drvdata(pdev, tb);
 
 	device_wakeup_enable(&pdev->dev);
@@ -1316,12 +1331,26 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
+
+cleanup:
+	list_for_each_entry_safe(pci_bridge, n, &tb->bridge_list, list) {
+		list_del(&pci_bridge->list);
+		kfree(pci_bridge);
+	}
+
+	return -ENOMEM;
 }
 
 static void nhi_remove(struct pci_dev *pdev)
 {
 	struct tb *tb = pci_get_drvdata(pdev);
 	struct tb_nhi *nhi = tb->nhi;
+	struct tb_pci_bridge *pci_bridge, *n;
+
+	list_for_each_entry_safe(pci_bridge, n, &tb->bridge_list, list) {
+		list_del(&pci_bridge->list);
+		kfree(pci_bridge);
+	}
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index c63c1f4ff9dc7..aae898cc907d3 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2836,6 +2836,8 @@ static void tb_switch_credits_init(struct tb_switch *sw)
 int tb_switch_add(struct tb_switch *sw)
 {
 	int i, ret;
+	struct tb *tb = sw->tb;
+	struct tb_pci_bridge *pci_bridge;
 
 	/*
 	 * Initialize DMA control port now before we read DROM. Recent
@@ -2933,6 +2935,10 @@ int tb_switch_add(struct tb_switch *sw)
 	}
 
 	tb_switch_debugfs_init(sw);
+
+	list_for_each_entry(pci_bridge, &tb->bridge_list, list)
+		pm_request_resume(&pci_bridge->bridge->dev);
+
 	return 0;
 
 err_ports:
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 9853f6c7e81d7..07e97b77ac630 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1771,6 +1771,7 @@ struct tb *tb_probe(struct tb_nhi *nhi)
 		tb->security_level = TB_SECURITY_NOPCIE;
 
 	tb->cm_ops = &tb_cm_ops;
+	INIT_LIST_HEAD(&tb->bridge_list);
 
 	tcm = tb_priv(tb);
 	INIT_LIST_HEAD(&tcm->tunnel_list);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 5db76de40cc1c..8efbd1afacad0 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -489,6 +489,11 @@ struct tb_cm_ops {
 						   u32 *status);
 };
 
+struct tb_pci_bridge {
+	struct pci_dev *bridge;
+	struct list_head list;
+};
+
 static inline void *tb_priv(struct tb *tb)
 {
 	return (void *)tb->privdata;
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 9f442d73f3df8..728bb36070e9d 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -83,6 +83,7 @@ struct tb {
 	int index;
 	enum tb_security_level security_level;
 	size_t nboot_acl;
+	struct list_head bridge_list;
 	unsigned long privdata[];
 };
 
-- 
2.36.1

