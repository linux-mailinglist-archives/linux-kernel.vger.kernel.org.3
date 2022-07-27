Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2F05823AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiG0KBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiG0KAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:00:42 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F49A1A0;
        Wed, 27 Jul 2022 03:00:32 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DB3FAC0010;
        Wed, 27 Jul 2022 10:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1658916030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gWGk3O/39jRyG70XEIs0yy+M6P6aC9SXYdCpOIcWGAc=;
        b=VzeFWcLZgtQVOgZZTgdNslvBz0tTb4PkXgvzp79bm+WUZwAwxigyk+Gr70ktpMtGBxLBAW
        wVaKQ3MhJqOO5XWky5ME9x2eVJe4k2FvdpDsJ0W/fXeD0ymDDGzy1K2ojjQZIBtQMIKnK5
        dZBQnOMWfR7SxX/r+JuidExS6Z/I7gNpcL+5hJS7bPPH3ci2OmYaeNiY+6A0EAbRyM9Q+g
        p/uvbahz+PoW3R7eSve9Sw81m6nOEXqkf5mdmNLX6G5XygXIzPVTUuNo7LqZUSLNXjdG0s
        xGvorWSHiM9NKcWKhLZMpChqHnBl+NMGjylDalsOP31rrqDz79CCYwKvb8ltlg==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-rtc@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: zynqmp: initialize fract_tick
Date:   Wed, 27 Jul 2022 12:00:18 +0200
Message-Id: <20220727100018.3301470-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

fract_tick is used uninitialized when fract_offset is 0

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index 1dd389b891fe..c9b85c838ebe 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -203,7 +203,7 @@ static int xlnx_rtc_set_offset(struct device *dev, long offset)
 	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
 	unsigned long long rtc_ppb = RTC_PPB;
 	unsigned int tick_mult = do_div(rtc_ppb, xrtcdev->freq);
-	unsigned char fract_tick;
+	unsigned char fract_tick = 0;
 	unsigned int calibval;
 	short int  max_tick;
 	int fract_offset;
-- 
2.36.1

