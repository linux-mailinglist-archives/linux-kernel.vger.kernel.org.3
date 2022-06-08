Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2AF5430D1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbiFHMto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbiFHMtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:49:41 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095731A0AD9;
        Wed,  8 Jun 2022 05:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692577; x=1686228577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CK2xFYVvQjcLpB9Lr8I4dKwUzAtt+7lcp3WZ02i3lng=;
  b=ADksulP92s4yt1x2Se9rGtDl7bJxH096A8QMXeLzdl25hpIL+QRS5BEG
   NHO+igr2FqteuLI0x3X2HwdGs4uaDlD56Oq1gdlmFaX+0/okQNVdA/wC8
   gPkBcNTzVXxB/sye5s4c/BXtg9wY3aJ6e6UW8C1aSWNKMFOFVRfsQOEMz
   k+/EzcG6zwSSYGnO+bD+m0DIIyEYA9op9B83HS3T5qLHQxQD8JFDA0o97
   LKDwlnFlwbTgjYlxelXRKU1H89jx12AW8aYubPWnwgM9xMxWtc2ZJssup
   tDKBloZyyaKXtrdfmEdR738/EfgtUIe7VbY1zX/NWsyZuIBFk7O7P80xC
   w==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330536"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Jun 2022 14:49:30 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 08 Jun 2022 14:49:30 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 08 Jun 2022 14:49:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692570; x=1686228570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CK2xFYVvQjcLpB9Lr8I4dKwUzAtt+7lcp3WZ02i3lng=;
  b=ACWIa9EN+8hvjZmDLHj5vazy8J5nrR7/NS3qUxQRt0e1CXpXMudcAFKn
   5ZmCH1pggGapdVGq8Ufebh3V01Wq9Jb/oHKPyFwIt1U7z762OS4Eg0R1T
   4XtzQI0ycpS9I+JCC9AoKx4NwsDZqS4V1RPQVoTms3fCGV8tgsybk3/ed
   3PW6snT+Yf/MEpAHscclBt6vT2fKPAKHtjiujJt0U+STBLiI3jPewFNb+
   pTDJb1plS5EYhebgxNBb2n3toxZS81YmP43XuLpTtn5iZvuLxUQrAvMIW
   tJJSa+jZgmpB87IeR538P0Y16c/HXvoe+NenV3vYCE8bw3XkqYSRJZTsF
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330535"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Jun 2022 14:49:30 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.136])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 84634280072;
        Wed,  8 Jun 2022 14:49:30 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/9] Input: synaptics-rmi4 - fix firmware update operations with bootloader v8
Date:   Wed,  8 Jun 2022 14:48:00 +0200
Message-Id: <20220608124808.51402-2-matthias.schiffer@ew.tq-group.com>
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

Commit a6977d758fed ("Input: synaptics-rmi4 - support bootloader v8 in
f34v7") allowed the F34v7 driver to probe with bootloader v8, but it did
not update various other bootloader version checks in the F34 code.

Fixes: a6977d758fed ("Input: synaptics-rmi4 - support bootloader v8 in f34v7")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/input/rmi4/rmi_f34.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index e5dca9868f87..3afc94f679ed 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -370,7 +370,7 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 
 	f34 = dev_get_drvdata(&data->f34_container->dev);
 
-	if (f34->bl_version == 7) {
+	if (f34->bl_version >= 7) {
 		if (data->pdt_props & HAS_BSR) {
 			dev_err(dev, "%s: LTS not supported\n", __func__);
 			return -ENODEV;
@@ -382,7 +382,7 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 	}
 
 	/* Enter flash mode */
-	if (f34->bl_version == 7)
+	if (f34->bl_version >= 7)
 		ret = rmi_f34v7_start_reflash(f34, fw);
 	else
 		ret = rmi_f34_enable_flash(f34);
@@ -413,7 +413,7 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 	f34 = dev_get_drvdata(&data->f34_container->dev);
 
 	/* Perform firmware update */
-	if (f34->bl_version == 7)
+	if (f34->bl_version >= 7)
 		ret = rmi_f34v7_do_reflash(f34, fw);
 	else
 		ret = rmi_f34_update_firmware(f34, fw);
-- 
2.25.1

