Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AB65430C8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbiFHMuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239701AbiFHMtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:49:55 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793901A0AD9;
        Wed,  8 Jun 2022 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692584; x=1686228584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P46A/HLCcBellPLyCR/hDuNj3WtIwUmFCC+4ZNYe5rg=;
  b=W/FOZf8x7CnevjfJR7Uwo6CWv4F2e+vYU6XKIiGkCKpUZ976/mBlYPDU
   Y2B6ekhNmcI7S2rBiWzDgSeuaJeshzVVIrwuGXWLfFa3YkTYm7TStlFtn
   ploCmIW5J4qs/A5njlAIhbflTOfNwxRCKkg7oo5MCPBqjxF7WSLOL6XYK
   /9I9e+fw5kuOyx4vfU6DpPkPU82mcH5OdMHsIWpphaWqiO2nQjl/bCtDm
   jbwUBQv2qRK9YtBd96vxxFNAL4/i2M2uTjfMXV6P/g+Z+Ch+rLIEjwWuK
   OnIVknxI1Y5jfqK68XEFHjKijjwex4ogA+9rwHHHpGDm3/psCbOpfGCH7
   g==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330554"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Jun 2022 14:49:32 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 08 Jun 2022 14:49:32 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 08 Jun 2022 14:49:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692572; x=1686228572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P46A/HLCcBellPLyCR/hDuNj3WtIwUmFCC+4ZNYe5rg=;
  b=DGwIGYrSBlczcQ+tUCI8Tgiq3yu5G/X+k/7F2D/51iAIFQEfmsdBDRhl
   9j52m+ryXV0wHsSgl7HzOlmzikEC8DprKOGSXyHqRqGvUHjyl6MlO5cD2
   K7edR9b1ZEz3++AHPp/woo5csM/iqVlFYBza8dPzXA3VRWWD+7JnwzgXD
   ZvFTipfuw9/mLR6C0GVPc5uYiKjBr0R28SV4c1TuNa5VCNSzFVJDFxd2m
   WjCt0woPVvylTdczFyuTYepH7bZE4TONRANfeYAL5FCsUlzMHbW1RSRu4
   Jg3SDPp/9Wf+cHDYMYc7vxLvtRBgNPEh/IofuPaIrEXhzhRVZbO8DGffN
   w==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330553"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Jun 2022 14:49:32 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.136])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 301DA280072;
        Wed,  8 Jun 2022 14:49:32 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 9/9] Input: synaptics-rmi4 - drop useless gotos in rmi_f34v7_do_reflash()
Date:   Wed,  8 Jun 2022 14:48:08 +0200
Message-Id: <20220608124808.51402-10-matthias.schiffer@ew.tq-group.com>
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

Returning directly makes the code clearer.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/input/rmi4/rmi_f34v7.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
index f16c67eb6cc6..886557b01eba 100644
--- a/drivers/input/rmi4/rmi_f34v7.c
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -1039,19 +1039,19 @@ int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw)
 
 	ret = rmi_f34v7_parse_image_info(f34);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	ret = rmi_f34v7_check_bl_config_size(f34);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	ret = rmi_f34v7_erase_all(f34);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	ret = rmi_f34v7_write_partition_table(f34);
 	if (ret < 0)
-		goto fail;
+		return ret;
 	dev_info(&f34->fn->dev, "%s: Partition table programmed\n", __func__);
 
 	/*
@@ -1067,7 +1067,7 @@ int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw)
 
 	ret = rmi_f34v7_write_firmware(f34);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	dev_info(&f34->fn->dev, "Writing config (%d bytes)...\n",
 		 f34->v7.img.ui_config.size);
@@ -1075,14 +1075,14 @@ int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw)
 	f34->v7.config_area = v7_UI_CONFIG_AREA;
 	ret = rmi_f34v7_write_ui_config(f34);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	if (f34->v7.has_display_cfg && f34->v7.img.contains_display_cfg) {
 		dev_info(&f34->fn->dev, "Writing display config...\n");
 
 		ret = rmi_f34v7_write_dp_config(f34);
 		if (ret < 0)
-			goto fail;
+			return ret;
 	}
 
 	if (f34->v7.has_guest_code && f34->v7.img.contains_guest_code) {
@@ -1090,11 +1090,10 @@ int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw)
 
 		ret = rmi_f34v7_write_guest_code(f34);
 		if (ret < 0)
-			goto fail;
+			return ret;
 	}
 
-fail:
-	return ret;
+	return 0;
 }
 
 static int rmi_f34v7_enter_flash_prog(struct f34_data *f34)
-- 
2.25.1

