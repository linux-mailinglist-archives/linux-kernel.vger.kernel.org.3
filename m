Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2910059E812
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244760AbiHWQ4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343503AbiHWQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:55:28 -0400
X-Greylist: delayed 602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Aug 2022 06:25:47 PDT
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7CD883CA;
        Tue, 23 Aug 2022 06:25:46 -0700 (PDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id DBE46F41DDA; Tue, 23 Aug 2022 15:07:05 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Ash Logan <ash@heyquark.com>,
        rw-r-r-0644 <r.r.qwertyuiop.r.r@gmail.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>
Subject: [PATCH] rtc: gamecube: Always reset HW_SRNPROT after read
Date:   Tue, 23 Aug 2022 15:07:02 +0200
Message-Id: <20220823130702.1046-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_DUL,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This register would fail to be reset if reading the RTC bias failed for
whichever reason.  This commit reorganises the code around to
unconditionally write it back to its previous value, unmap it, and
return the result of regmap_read(), which makes it both simpler and more
correct in the error case.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 drivers/rtc/rtc-gamecube.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
index c2717bb52b2b..c828bc8e05b9 100644
--- a/drivers/rtc/rtc-gamecube.c
+++ b/drivers/rtc/rtc-gamecube.c
@@ -265,18 +265,17 @@ static int gamecube_rtc_read_offset_from_sram(struct priv *d)
 	 * SRAM address as on previous consoles.
 	 */
 	ret = regmap_read(d->regmap, RTC_SRAM_BIAS, &d->rtc_bias);
-	if (ret) {
-		pr_err("failed to get the RTC bias\n");
-		iounmap(hw_srnprot);
-		return -1;
-	}
 
 	/* Reset SRAM access to how it was before, our job here is done. */
 	if (old != 0x7bf)
 		iowrite32be(old, hw_srnprot);
+
 	iounmap(hw_srnprot);
 
-	return 0;
+	if (ret)
+		pr_err("failed to get the RTC bias\n");
+
+	return ret;
 }
 
 static const struct regmap_range rtc_rd_ranges[] = {
-- 
2.37.2

