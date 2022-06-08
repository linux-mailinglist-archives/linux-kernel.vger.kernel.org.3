Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F775430BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbiFHMuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbiFHMts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:49:48 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFE81B1F49;
        Wed,  8 Jun 2022 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692584; x=1686228584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DXNnJFUlFK8d9qe5CIxVjNz1sNl5AGBt22+P99Ui0ZU=;
  b=KOSXbDJxFGvnMjk/uGZpU0rxsCmvhM5bJyCkpQR0VQiF6qGbEOQMT92m
   nrQyTeQ7WJL7rQwnF1bxklf+mXSG2QY7AwNUeSsB+SlXU3WFIYX568rp6
   8hRJHHhP+ZgxzZrbg0d+wJarhMrw2DZ/qEzbhjrDAUkwWq7AI/AKmcfp7
   Z8iG8rLnCS4aYm1wjKuSBCnncKOjbjn8SHwSy6Wvx1V7kq/VG3/einMFp
   krGhHt3z3PLjdUOcTj3bVOAy1qPEyDtS5gG42o7jETVhAkoNKWqhYCbND
   1Ql65OyUS2Xr13UDr/JMzJ6hV1yivN94UydRuGzfF4tRb2y8KIrOzJBlA
   g==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330552"
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
  bh=DXNnJFUlFK8d9qe5CIxVjNz1sNl5AGBt22+P99Ui0ZU=;
  b=a6GhMFxzEwEyYhC0v8/SHBlHTLQuErDOKvUMnt+NVanWwF/gHnJXijpI
   K3eEvAqdW+QS3WsPyvBlN7xwIXttAD7nRVrbNW6sKVhmVfzUHr3z0sOSF
   QMIhjNOWqwigOU+c5XocIZevAzgDG5/fOrA6YDkmDpxBQsQ5SS8eSezYA
   bLzRS8bhAJa2sYzWgfK5w5Cn0DFP5jS94pRxOMKH7v8aJOHsmD0iDMhXz
   fFJ+TiyYpGCicByAsJGlr7PL0kQ4sBEyfPivq6xXIdPYzDVG8Z8w20VC0
   juuoZ6CxO9D6kpcD+Z1BHi2XudhG1aKZbJ75E9iQvfqVKP3fXoUlatZif
   w==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330550"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Jun 2022 14:49:32 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.136])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 0CFDB280056;
        Wed,  8 Jun 2022 14:49:31 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 8/9] Input: synaptics-rmi4 - simplify rmi_f34v7_start_reflash()
Date:   Wed,  8 Jun 2022 14:48:07 +0200
Message-Id: <20220608124808.51402-9-matthias.schiffer@ew.tq-group.com>
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

rmi_f34v7_enter_flash_prog() already enables IRQs and checks the flash
status - there's no need for rmi_f34v7_start_reflash() to do the same just
before calling rmi_f34v7_enter_flash_prog().

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/input/rmi4/rmi_f34v7.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
index 5c22ad4bcc74..f16c67eb6cc6 100644
--- a/drivers/input/rmi4/rmi_f34v7.c
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -1107,8 +1107,11 @@ static int rmi_f34v7_enter_flash_prog(struct f34_data *f34)
 	if (ret < 0)
 		return ret;
 
-	if (f34->v7.in_bl_mode)
+	if (f34->v7.in_bl_mode) {
+		dev_info(&f34->fn->dev, "%s: Device in bootloader mode\n",
+			 __func__);
 		return 0;
+	}
 
 	init_completion(&f34->v7.cmd_done);
 
@@ -1127,32 +1130,16 @@ int rmi_f34v7_start_reflash(struct f34_data *f34, const struct firmware *fw)
 {
 	int ret = 0;
 
-	f34->fn->rmi_dev->driver->set_irq_bits(f34->fn->rmi_dev, f34->fn->irq_mask);
-
 	f34->v7.config_area = v7_UI_CONFIG_AREA;
 	f34->v7.image = fw->data;
 
 	ret = rmi_f34v7_parse_image_info(f34);
 	if (ret < 0)
-		goto exit;
+		return ret;
 
 	dev_info(&f34->fn->dev, "Firmware image OK\n");
 
-	ret = rmi_f34v7_read_flash_status(f34);
-	if (ret < 0)
-		goto exit;
-
-	if (f34->v7.in_bl_mode) {
-		dev_info(&f34->fn->dev, "%s: Device in bootloader mode\n",
-				__func__);
-	}
-
-	rmi_f34v7_enter_flash_prog(f34);
-
-	return 0;
-
-exit:
-	return ret;
+	return rmi_f34v7_enter_flash_prog(f34);
 }
 
 int rmi_f34v7_probe(struct f34_data *f34)
-- 
2.25.1

