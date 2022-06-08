Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6CA5430C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbiFHMuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbiFHMto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:49:44 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A961A8990;
        Wed,  8 Jun 2022 05:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692582; x=1686228582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ExR7nz1l+qJd8VCWWH8Z3rCzQytlVekQ7lshd0c3hog=;
  b=Fftmgi5Lg6X+dk6oFfvrgruMsZijFxAMKWAM/O3rv9YHkhQCo4YUULOu
   k4GLTS4XVW9lEcaG/Y1VUESTaIYFoPRa/t7QUORoFCxnheYRPwPpnDOh6
   6c7E5BvUl8JrrKYht8bTMaL1Y8tcBE0zPh5ycxjY1idbZjC8d589lMbNI
   jtSAGvCG8GkAcvHUe9Aaep6/Q2MXWfC+bw3EeKD1rlZa1yN3taQbGtKOM
   G4QEIGxGjtGU3x7uhnSindARxCVs8ntgf4GSgaCOfmqgAhIyyFo8a5dUb
   orBVDzTSov0pG0c4zg2SYKja0ft3ZBcjFtAyxxp8ASfawci88bUrA8Nvd
   A==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330547"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Jun 2022 14:49:31 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 08 Jun 2022 14:49:31 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 08 Jun 2022 14:49:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692571; x=1686228571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ExR7nz1l+qJd8VCWWH8Z3rCzQytlVekQ7lshd0c3hog=;
  b=jP2MLwltruQ3NkK9lrmNUwIM2s31p/VHimWt2Xbh/XTFZbhXVERYZmIZ
   qmrpkLhpA1adVe4e7PqhO4xR5Axsjz4mucj1z5U5210SYxhZI6HkJEcrA
   e1HCDKEcH1RPGvGnOGw3xorZ2LU8bqqQjRDEC8sCVK+sSeB1d2pJXDvm0
   OzPybeiiVYOwE+Cjv8h4c8TuxwBuvhYQ1vtQPiIC7dU9Rv+hoebknpqnH
   xBi32MTvELu3mpda75DLwC7P5uX87eVgPgvRAESgoua37Hu/Uyx8b3nNH
   ttAahRwfag+nR54F8qcyivWBPDHT7P0NjNmGBPC8h0aAxfKHCGJCai2y5
   w==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330545"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Jun 2022 14:49:31 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.136])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 928FF280072;
        Wed,  8 Jun 2022 14:49:31 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 6/9] Input: synaptics-rmi4 - make rmi_f34v7_erase_all() use the "erase all" command
Date:   Wed,  8 Jun 2022 14:48:05 +0200
Message-Id: <20220608124808.51402-7-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
References: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A full erase is required to recover from error conditions like "Bad
Partition Table". Various individual partition erase commands can be
(and need to be) omitted, as they will fail until a new partition table
has been written.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/input/rmi4/rmi_f34v7.c | 87 +---------------------------------
 1 file changed, 1 insertion(+), 86 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
index 9b78f98bb21c..9c1a73611761 100644
--- a/drivers/input/rmi4/rmi_f34v7.c
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -608,58 +608,6 @@ static int rmi_f34v7_check_bl_config_size(struct f34_data *f34)
 	return 0;
 }
 
-static int rmi_f34v7_erase_config(struct f34_data *f34)
-{
-	int ret;
-
-	dev_info(&f34->fn->dev, "Erasing config...\n");
-
-	init_completion(&f34->v7.cmd_done);
-
-	switch (f34->v7.config_area) {
-	case v7_UI_CONFIG_AREA:
-		ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_UI_CONFIG);
-		if (ret < 0)
-			return ret;
-		break;
-	case v7_DP_CONFIG_AREA:
-		ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_DISP_CONFIG);
-		if (ret < 0)
-			return ret;
-		break;
-	case v7_BL_CONFIG_AREA:
-		ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_BL_CONFIG);
-		if (ret < 0)
-			return ret;
-		break;
-	}
-
-	ret = rmi_f34v7_check_command_status(f34, F34_ERASE_WAIT_MS);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static int rmi_f34v7_erase_guest_code(struct f34_data *f34)
-{
-	int ret;
-
-	dev_info(&f34->fn->dev, "Erasing guest code...\n");
-
-	init_completion(&f34->v7.cmd_done);
-
-	ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_GUEST_CODE);
-	if (ret < 0)
-		return ret;
-
-	ret = rmi_f34v7_check_command_status(f34, F34_ERASE_WAIT_MS);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static int rmi_f34v7_erase_all(struct f34_data *f34)
 {
 	int ret;
@@ -668,7 +616,7 @@ static int rmi_f34v7_erase_all(struct f34_data *f34)
 
 	init_completion(&f34->v7.cmd_done);
 
-	ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_UI_FIRMWARE);
+	ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_ALL);
 	if (ret < 0)
 		return ret;
 
@@ -676,24 +624,6 @@ static int rmi_f34v7_erase_all(struct f34_data *f34)
 	if (ret < 0)
 		return ret;
 
-	f34->v7.config_area = v7_UI_CONFIG_AREA;
-	ret = rmi_f34v7_erase_config(f34);
-	if (ret < 0)
-		return ret;
-
-	if (f34->v7.has_display_cfg) {
-		f34->v7.config_area = v7_DP_CONFIG_AREA;
-		ret = rmi_f34v7_erase_config(f34);
-		if (ret < 0)
-			return ret;
-	}
-
-	if (f34->v7.has_guest_code) {
-		ret = rmi_f34v7_erase_guest_code(f34);
-		if (ret < 0)
-			return ret;
-	}
-
 	return 0;
 }
 
@@ -897,17 +827,6 @@ static int rmi_f34v7_write_flash_config(struct f34_data *f34)
 
 	init_completion(&f34->v7.cmd_done);
 
-	ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_FLASH_CONFIG);
-	if (ret < 0)
-		return ret;
-
-	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
-		"%s: Erase flash config command written\n", __func__);
-
-	ret = rmi_f34v7_check_command_status(f34, F34_WRITE_WAIT_MS);
-	if (ret < 0)
-		return ret;
-
 	ret = rmi_f34v7_write_config(f34);
 	if (ret < 0)
 		return ret;
@@ -937,10 +856,6 @@ static int rmi_f34v7_write_partition_table(struct f34_data *f34)
 	if (ret < 0)
 		return ret;
 
-	ret = rmi_f34v7_erase_config(f34);
-	if (ret < 0)
-		return ret;
-
 	ret = rmi_f34v7_write_flash_config(f34);
 	if (ret < 0)
 		return ret;
-- 
2.25.1

