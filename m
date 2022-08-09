Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AC758E365
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiHIWtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHIWtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:49:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F49165828;
        Tue,  9 Aug 2022 15:49:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8053B81912;
        Tue,  9 Aug 2022 22:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF84BC433D6;
        Tue,  9 Aug 2022 22:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660085367;
        bh=uPhKhKjz4nLP7Bfa+GXJs+PEOTPR67p/T4XukYbqA4o=;
        h=From:To:Cc:Subject:Date:From;
        b=QRl+7reUPLya7J6GhrTYQqv9fhHRfcuM4mzrpHvWuSEjiEx8Vxyhf+Wm/SbZvHnEt
         ecFi76RZXfgX1U6ynNeWnba3i79KvWpVipkw/jCbLWE1bylTYIWdjLsfTQ2z/mrfpx
         U/7e0y1QDSXaw4iW/VrAqbHduMDS3AEl9PnQoLCXH4rIhymotXajdcHUcTw+p7kbIv
         JIYnj+M1wtDIzVcacCzj4SAo119Bu4bh0MvlI3cLPm8FK7QAEVJK07/h315LWd3GFG
         kMPeQoDQWfFSROc5uoJEhbHr7PpfOJTlHL4GoKBsPIZxUa5o0OwO5+Rc0iC6TQqfJ7
         V55gPksXkWaQQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Jarkko Sakkinen <jarkko@profian.com>,
        Harald Hoyer <harald@profian.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org (open list:AMD CRYPTOGRAPHIC COPROCESSOR
        (CCP) DRIVER - SE...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] crypto: ccp: Add a quirk to firmware update
Date:   Wed, 10 Aug 2022 01:49:15 +0300
Message-Id: <20220809224915.92111-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Sakkinen <jarkko@profian.com>

A quirk for fixing the committed TCB version, when upgrading from a
firmware version earlier than 1.50. This is a known issue, and the
documented workaround is to load the firmware twice.

Currently, this issue requires the  following workaround:

sudo modprobe -r kvm_amd
sudo modprobe -r ccp
sudo modprobe ccp
sudo modprobe kvm_amd

Implement this workaround inside kernel by checking whether the API
version is less than 1.50, and if so, download the firmware twice.
This addresses the TCB version issue.

Link: https://lore.kernel.org/all/de02389f-249d-f565-1136-4af3655fab2a@profian.com/
Reported-by: Harald Hoyer <harald@profian.com>
Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
---
v2:
- Updated the commit message and comments.
  https://lore.kernel.org/all/0a3a790d-989f-2f76-f636-62fbd925a776@amd.com/
 drivers/crypto/ccp/sev-dev.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 799b476fc3e8..f27f8bc966b1 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -742,6 +742,11 @@ static int sev_update_firmware(struct device *dev)
 	struct page *p;
 	u64 data_size;
 
+	if (!sev_version_greater_or_equal(0, 15)) {
+		dev_dbg(dev, "DOWNLOAD_FIRMWARE not supported\n");
+		return -1;
+	}
+
 	if (sev_get_firmware(dev, &firmware) == -ENOENT) {
 		dev_dbg(dev, "No SEV firmware file present\n");
 		return -1;
@@ -774,6 +779,14 @@ static int sev_update_firmware(struct device *dev)
 	data->len = firmware->size;
 
 	ret = sev_do_cmd(SEV_CMD_DOWNLOAD_FIRMWARE, data, &error);
+
+	/*
+	 * A quirk for fixing the committed TCB version, when upgrading from
+	 * earlier firmware version than 1.50.
+	 */
+	if (!ret && !sev_version_greater_or_equal(1, 50))
+		ret = sev_do_cmd(SEV_CMD_DOWNLOAD_FIRMWARE, data, &error);
+
 	if (ret)
 		dev_dbg(dev, "Failed to update SEV firmware: %#x\n", error);
 	else
@@ -1283,8 +1296,7 @@ void sev_pci_init(void)
 	if (sev_get_api_version())
 		goto err;
 
-	if (sev_version_greater_or_equal(0, 15) &&
-	    sev_update_firmware(sev->dev) == 0)
+	if (sev_update_firmware(sev->dev) == 0)
 		sev_get_api_version();
 
 	/* If an init_ex_path is provided rely on INIT_EX for PSP initialization
-- 
2.37.1

