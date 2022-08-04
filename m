Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471A258958F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 03:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbiHDBCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 21:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiHDBCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 21:02:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEBF18E1C;
        Wed,  3 Aug 2022 18:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A47F6172C;
        Thu,  4 Aug 2022 01:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57664C433D6;
        Thu,  4 Aug 2022 01:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659574953;
        bh=ojOGwVmUtAwEibZBXIJloUOWkBRws1ynoRVHan4EmDQ=;
        h=From:To:Cc:Subject:Date:From;
        b=DPRfoCrv0r98FNMwDUmPEWXziQjIJmZQ9o76KB0ty0LVoBGVNvbyHPrcbLkROmGBk
         hbVqhkkxw1MJaIU2MnB2XNR6e8JmgbFPDxkhZZEqq2RfyEuAmx3ypoHLDA4PIal0XD
         hRkU8Rrdi6FqJBHmnSN7JOGIr9tg5fdVunDWSh5cBXLOgoE0qi8DbJVoYAplXeEGrU
         Ri5fNC2b2J6v4GFTx34uwFFrbdTAWd/59Ww7+GpdU8529dcFs6/oydrGUz4NqUfLVz
         F7a3lLY4Xx29fCP1iSTrvJYngmT0ojQne5fltnzraWkOKIHTheVoJIzvyipmfqYs4T
         WRRaVs5+xsxCA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jarkko Sakkinen <jarkko@profian.com>,
        Harald Hoyer <harald@profian.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org (open list:AMD CRYPTOGRAPHIC COPROCESSOR
        (CCP) DRIVER - SE...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] crypto: ccp: Load the firmware twice when SEV API version < 1.43
Date:   Thu,  4 Aug 2022 04:02:23 +0300
Message-Id: <20220804010223.3619-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Sakkinen <jarkko@profian.com>

SEV-SNP does not initialize to a legit state, unless the firmware is
loaded twice, when SEP API version < 1.43, and the firmware is updated
to a later version. Because of this user space needs to work around
this with "rmmod && modprobe" combo. Fix this by implementing the
workaround to the driver.

Reported-by: Harald Hoyer <harald@profian.com>
Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
---
 drivers/crypto/ccp/sev-dev.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 799b476fc3e8..f2abb7439dde 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -76,6 +76,9 @@ static void *sev_es_tmr;
 #define NV_LENGTH (32 * 1024)
 static void *sev_init_ex_buffer;
 
+/*
+ * SEV API version >= maj.min?
+ */
 static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
 {
 	struct sev_device *sev = psp_master->sev_data;
@@ -89,6 +92,14 @@ static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
 	return false;
 }
 
+/*
+ * SEV API version < maj.min?
+ */
+static inline bool sev_version_less(u8 maj, u8 min)
+{
+	return !sev_version_greater_or_equal(maj, min);
+}
+
 static void sev_irq_handler(int irq, void *data, unsigned int status)
 {
 	struct sev_device *sev = data;
@@ -1274,6 +1285,7 @@ void sev_pci_init(void)
 {
 	struct sev_device *sev = psp_master->sev_data;
 	int error, rc;
+	int i;
 
 	if (!sev)
 		return;
@@ -1283,9 +1295,13 @@ void sev_pci_init(void)
 	if (sev_get_api_version())
 		goto err;
 
-	if (sev_version_greater_or_equal(0, 15) &&
-	    sev_update_firmware(sev->dev) == 0)
-		sev_get_api_version();
+	/*
+	 * SEV-SNP does not work properly before loading the FW twice in the API
+	 * versions older than SEV 1.43.
+	 */
+	for (i = 0; i < sev_version_greater_or_equal(0, 15) + sev_version_less(1, 43); i++)
+		if (sev_update_firmware(sev->dev) == 0)
+			sev_get_api_version();
 
 	/* If an init_ex_path is provided rely on INIT_EX for PSP initialization
 	 * instead of INIT.
-- 
2.37.1

