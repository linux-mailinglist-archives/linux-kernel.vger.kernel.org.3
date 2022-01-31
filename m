Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235644A4B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379978AbiAaQDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:03:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55926 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiAaQDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:03:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B00C761472
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D0EC340E8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643645011;
        bh=Geg53FfiZ8DNmFWmlhXTlDj8cD1CE5S9OANecRC0zaE=;
        h=From:To:Subject:Date:From;
        b=sfZy9UZynj6zlidvOPTQRzClrIFLT2iFfdAJtxRndE9hRMYoHzPYp6QWVTiAAmWxO
         AoTG3fQMGjSzRPbUaPiZP3vz8qSrPN1pcWQVDq4o7WkpZMv2pjXeT92Py/Vb0GUVMd
         Gx4d5CrNXctrdtV7pWirOMtDsN2Q1vcQ1HeXEJCeaJ37vG+iMKc++TtXTZpmkNq3UF
         xq1ZWC0x0ztAa4Io7ebc7Q0Za6ob1eqjXTq6O/NJMclGlFhyPeTlG3G8ODLbtUOJBx
         t+3RynL7PZYBwSSI2Ql80rELdFajGHijW8BgD8lDw/OiFK5+Vf74Czbgx7W6LrfJW/
         0ppn00Eq+ammQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] habanalabs: rephrase error messages in PCI initialization
Date:   Mon, 31 Jan 2022 18:03:26 +0200
Message-Id: <20220131160327.3060127-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iATU is an internal h/w machine inside Habana's PCI controller.
Mentioning it by name doesn't say anything to the user. It is better
to say the PCI controller initialization was not done successfully.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/pci/pci.c b/drivers/misc/habanalabs/common/pci/pci.c
index a6ffa342070c..bb9ce22bafc4 100644
--- a/drivers/misc/habanalabs/common/pci/pci.c
+++ b/drivers/misc/habanalabs/common/pci/pci.c
@@ -408,13 +408,13 @@ int hl_pci_init(struct hl_device *hdev)
 
 	rc = hdev->asic_funcs->pci_bars_map(hdev);
 	if (rc) {
-		dev_err(hdev->dev, "Failed to initialize PCI BARs\n");
+		dev_err(hdev->dev, "Failed to map PCI BAR addresses\n");
 		goto disable_device;
 	}
 
 	rc = hdev->asic_funcs->init_iatu(hdev);
 	if (rc) {
-		dev_err(hdev->dev, "Failed to initialize iATU\n");
+		dev_err(hdev->dev, "PCI controller was not initialized successfully\n");
 		goto unmap_pci_bars;
 	}
 
-- 
2.25.1

