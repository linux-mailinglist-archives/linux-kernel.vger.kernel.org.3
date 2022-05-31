Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9F85397CF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347692AbiEaULF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344114AbiEaULC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:11:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01929CCB3;
        Tue, 31 May 2022 13:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41FA9B80FAF;
        Tue, 31 May 2022 20:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBEDC385A9;
        Tue, 31 May 2022 20:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654027856;
        bh=rpBXoHlR/6gtJTb0rw4qQzRZ4suDxVA/38CFIEqDunw=;
        h=From:To:Cc:Subject:Date:From;
        b=q+hWo2a15+1v/q2nboYtYbVnGk/FwtXuII4D30Uk5Pl7U2at+Euap9Q28b4J1pnrT
         JGW49lBfhYk/UWkNROlYf6TZ4bNadluh+uHS+CUXKdxBRuxyZkV4yLbOlMPoTTmdoD
         JGYnzTBObMQ3nSbZNQNIbrKm3TQ4Y7bOyodDBht8xmLFoKxWLs81OgyHvRPO46Djm3
         TXDyLbCIqKcy6HumlA4zT+lMzsKmiQ22VEVeqCm5J2LDYRWifIETo4TWwfpRmVMrne
         /mLOGmw0ftbb9AVRj5mVnkmMNEnXcN13aTS7+ZVhlwIsSDKMizphk3gtjVTv4eakpq
         K+TyNkskr+hYg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] scsi: ufs: add a quirk to disable FUA support
Date:   Tue, 31 May 2022 13:10:53 -0700
Message-Id: <20220531201053.3300018-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
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

UFS stack shows very low performance of FUA comparing to write and cache_flush.
Let's add a quirk to adjust it.

E.g., average latency according to the chunk size of write

Write(us/KB)	4	64	256	1024	2048
FUA		873.792	754.604	995.624	1011.67	1067.99
CACHE_FLUSH	824.703	712.98	800.307	1019.5	1037.37

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 3 +++
 drivers/scsi/ufs/ufshcd.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3f9caafa91bf..811f3467879c 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5035,6 +5035,9 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 	 */
 	sdev->silence_suspend = 1;
 
+	if (hba->quirks & UFSHCD_QUIRK_BROKEN_FUA)
+		sdev->broken_fua = 1;
+
 	ufshcd_crypto_register(hba, q);
 
 	return 0;
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 94f545be183a..6c480c6741d6 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -602,6 +602,11 @@ enum ufshcd_quirks {
 	 * support physical host configuration.
 	 */
 	UFSHCD_QUIRK_SKIP_PH_CONFIGURATION		= 1 << 16,
+
+	/*
+	 * This quirk disables FUA support.
+	 */
+	UFSHCD_QUIRK_BROKEN_FUA				= 1 << 17,
 };
 
 enum ufshcd_caps {
-- 
2.36.1.255.ge46751e96f-goog

