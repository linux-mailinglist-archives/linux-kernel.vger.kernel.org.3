Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06FA4B25A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350049AbiBKM1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:27:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350006AbiBKM1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:27:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C799F28;
        Fri, 11 Feb 2022 04:27:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A9AD1477;
        Fri, 11 Feb 2022 04:27:01 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.196.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 655FD3F70D;
        Fri, 11 Feb 2022 04:26:59 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: [PATCH v10 06/18] rtc: sun6i: Add Allwinner H616 support
Date:   Fri, 11 Feb 2022 12:26:31 +0000
Message-Id: <20220211122643.1343315-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211122643.1343315-1-andre.przywara@arm.com>
References: <20220211122643.1343315-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H616 RTC changes its day storage to the newly introduced linear day
scheme, so pair the new compatible string with this feature flag.
The RTC clock parts are handled in a separate driver now, so we skip
the clock parts in this driver completely.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/rtc/rtc-sun6i.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 799d98ee6df6..5252ce4cbda4 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -831,6 +831,8 @@ static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun8i-v3-rtc" },
 	{ .compatible = "allwinner,sun50i-h5-rtc" },
 	{ .compatible = "allwinner,sun50i-h6-rtc" },
+	{ .compatible = "allwinner,sun50i-h616-rtc",
+		.data = (void *)RTC_LINEAR_DAY },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun6i_rtc_dt_ids);
-- 
2.25.1

