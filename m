Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E86A53B3F4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiFBG4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiFBGz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:55:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291A35DBD3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:55:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so8497277pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 23:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:from:to:cc:subject:content-transfer-encoding
         :mime-version;
        bh=ak8tm6cSyofXH4NSo0o05XLV88OnObDuw/irZITZJvU=;
        b=h9aa/kTq+ADsCg63i/CIxTkWwRJjqpDY9QrQlrlu2BdzqwlsmT4rVHBwDPBVjVkSVs
         cW0fNTb6c8AlGdtufemN8Ps7ueUPrr1KdjZg/+7L8cyi9ZLgtI04Fp2OvJrwhiVt0xbF
         1jsvLxDcoYaSXDLOnnGk4hMLxcW1rwqvbaeh/e5gJmDJAYLQTa8WGcqFs78KplnILOrf
         K5ajmlu0Qy0oQcF/Fev9Eph9pDA1md07OwFnyz51/MaYUUp28C6C3FteHLTDIKlfivrD
         85p/fu4bbo5WObeuftx5hQgQJ5Qo9ewjF9pmuT7dmcXXO8fXNKTHMB+7e4r3gNccQrkH
         X1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=ak8tm6cSyofXH4NSo0o05XLV88OnObDuw/irZITZJvU=;
        b=VNl91kuInVVBixV8/BPlGVxxCivHHbtCjMW/yS7iSiQZn/RXE1gA5mGphY17AraVeE
         V/31bjQiQ3vKmc6VZz4i/jaHTIoyg1AD9D4hD4A2QhLRL5nMYbXJY6lJE/ZmvQc+XfAM
         /uQ2Iky7LPG7yft82FPkFfilRsUx/rEoZm5JBycTWbGomSN2Et06YfnC4lNbopm9vZuw
         y5WEPW7LohKIrgf3iBSuv35vcl/CAkMY8BD0pIBlnX34knMYXa1tN8Ikl3QcjHRluL6X
         PJ3BuXruYTuL85j81lrOYtkdIeFA17rrM7mrbVemnp2vesegMcaSWT7rLVglUZSvdWkh
         HkDg==
X-Gm-Message-State: AOAM531LLCbSlg1qwb/96RrK9e+715c+5fTaIwFEru5PZP9/+8gP1Jev
        rt++eKtlt4Wk6mwpf7fiokMmTw==
X-Google-Smtp-Source: ABdhPJxrArf5KLRpV3wAL6QuQ+ibDlPrVvQutjXenWxhmMoCLJQ8SFzVqY4t9PeIRC6bZGvMAHCL5A==
X-Received: by 2002:a17:903:244d:b0:166:3983:5569 with SMTP id l13-20020a170903244d00b0016639835569mr3393987pls.44.1654152956597;
        Wed, 01 Jun 2022 23:55:56 -0700 (PDT)
Received: from [127.0.1.1] (117-20-68-152.751444.bne.nbn.aussiebb.net. [117.20.68.152])
        by smtp.gmail.com with UTF8SMTPSA id t15-20020a17090340cf00b0016168e90f2csm2555125pld.208.2022.06.01.23.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 23:55:56 -0700 (PDT)
Date:   Thu, 02 Jun 2022 06:55:44 +0000
Message-Id: <20220602065544.2552771-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI/ASPM: Wait for data link active after retraining
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Rossi <nathan.rossi@digi.com>

When retraining the link either the child or the parent device may have
the data link layer state machine of the respective devices move out of
the active state despite the physical link training being completed.
Depending on how long is takes for the devices to return to the active
state, the device may not be ready and any further reads/writes to the
device can fail.

This issue is present with the pci-mvebu controller paired with a device
supporting ASPM but without advertising the Slot Clock, where during
boot the pcie_aspm_cap_init call would cause common clocks to be made
consistent and then retrain the link. However the data link layer would
not be active before any device initialization (e.g. ASPM capability
queries, BAR configuration) causing improper configuration of the device
without error.

To ensure the child device is accessible, after the link retraining use
pcie_wait_for_link to perform the associated state checks and any needed
delays.

Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
---
 drivers/pci/pcie/aspm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a96b7424c9..4b8a1810be 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -288,7 +288,8 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 		reg16 &= ~PCI_EXP_LNKCTL_CCC;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
 
-	if (pcie_retrain_link(link))
+	/* Retrain link and then wait for the link to become active */
+	if (pcie_retrain_link(link) && pcie_wait_for_link(parent, true))
 		return;
 
 	/* Training failed. Restore common clock configurations */
---
2.36.1
