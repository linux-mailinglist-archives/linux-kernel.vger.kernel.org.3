Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7DB5430C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbiFHMuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239637AbiFHMto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:49:44 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236921952C0;
        Wed,  8 Jun 2022 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692582; x=1686228582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ly4PphYlHbTt2w07Bt1mEJ+CFdsurRW+zLnlwgb8Oe8=;
  b=Xd6c2e+ldjpfxt94VsSsrRBnIJJSK+hPfbfqip+1xRRgAKcSQgYXXo8E
   LSY1Oyft9Xhqp+eHznK3pcZkD5LeIpKG69a/VY4T2CElsHZIbzXjNoTeJ
   +H9+zfzi3e6R6NwkIJF2qlHZMYpxXC4SnhPKuNZOLGvnC59D9/uAFdG9X
   MT4K2Tb6gqsPycCMVPqdO4HkZMld/gR/+EmgM3IfKn6peYHZWzFjb/Z+m
   VMBUlEYZesbXU4HyCKYvujS5XYN4AwbwUhMzNEdI1FSTOk5fUidg7Jzub
   QPELgiU0Nb6Ad14lySZYI4OF1k8hlmwcLaAKhXwsQcc2eAtxtr3QLvmcW
   w==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330544"
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
  bh=Ly4PphYlHbTt2w07Bt1mEJ+CFdsurRW+zLnlwgb8Oe8=;
  b=ktD4l9WdveK5/JV0Hz7cHud6JBkCdAjGN6JUSzuzKnKODoV57+VIvxxz
   dajtPVcIgDMFNFyYgJU10OE6rJ6rN1jD2/wMzal4xKH4BCN308S04ir8E
   qvvY2eWG2fi+ZdnqwUUAvnmZa6lM5jFERDfEuzP5yMOA3uHx9wnQDH0yZ
   QmntPwlJl0D/Wi1dm8ThK1ka77r00SLUK3FAB7Ex3YhcgXp/8QWN7tt2O
   PdyUy38vUok/ckv6v7p5DNA5Mc/YzkjsIq4eK/980rkGNykkYptPAG20M
   vqVsFYbinY+TlbROYHJsuwUio5sUCHQoSLlNMn494wAkVF4+2uNNl+9bc
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330543"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Jun 2022 14:49:31 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.136])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 69ADE280056;
        Wed,  8 Jun 2022 14:49:31 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 5/9] Input: synaptics-rmi4 - reset after writing partition table
Date:   Wed,  8 Jun 2022 14:48:04 +0200
Message-Id: <20220608124808.51402-6-matthias.schiffer@ew.tq-group.com>
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

When recovering from a bad partition table (for example after an
interrupted update), a reset is necessary for the new partition table to
become effective. Without this reset, writing the core code partition
will fail with status 0x03 (Invalid Command).

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/input/rmi4/rmi_f34v7.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
index 19b94b1c1a33..9b78f98bb21c 100644
--- a/drivers/input/rmi4/rmi_f34v7.c
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -1146,6 +1146,14 @@ int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw)
 		goto fail;
 	dev_info(&f34->fn->dev, "%s: Partition table programmed\n", __func__);
 
+	/*
+	 * Reset to reload partition table - as the previous firmware has been
+	 * erased, we remain in bootloader mode.
+	 */
+	ret = rmi_scan_pdt(f34->fn->rmi_dev, NULL, rmi_initial_reset);
+	if (ret < 0)
+		dev_warn(&f34->fn->dev, "RMI reset failed!\n");
+
 	dev_info(&f34->fn->dev, "Writing firmware (%d bytes)...\n",
 		 f34->v7.img.ui_firmware.size);
 
-- 
2.25.1

