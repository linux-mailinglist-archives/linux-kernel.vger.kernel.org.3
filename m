Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A35573A90
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbiGMPuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbiGMPue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:50:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62024D4F9;
        Wed, 13 Jul 2022 08:50:31 -0700 (PDT)
Received: from localhost.localdomain ([37.4.249.155]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MmUcL-1nlMDX3e4X-00iSaV; Wed, 13 Jul 2022 17:50:14 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH 1/3] clk: bcm: rpi: Prevent out-of-bounds access
Date:   Wed, 13 Jul 2022 17:49:51 +0200
Message-Id: <20220713154953.3336-2-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713154953.3336-1-stefan.wahren@i2se.com>
References: <20220713154953.3336-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jGsizjmPYWgMoUirvQPLUgxsbQQ2ElofdI3BKUEign/NkaXhQnb
 7QjSp9tRRJjSoRwYo2JCI9mm5WE4aTOFLAXAb7B4AU8+U27vsejDtad6uMOwUTiCs7HYia9
 4slz0QSgGGiFI55mLVpss+WK/KvQYCtBOwQSn1E/LesqOJhf2BivXmj1vBeUTVPQZUTxS2a
 W3IWa+gsVuN0RW+ci6LxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JZF35l+UcLk=:3rrKjxywLhZnx3saFAZ03f
 RMfNv9To5MMrJae+wasiax14VAta/qz7qlHqYscW9QG+W9uSeXq/Q/sPT2z1U6iEHwEyJ/Fc6
 l6iWARRu/GyhECQ3JgEWVxp3X9z1N1z9ba59O+O4wUc6TaYuICWxURN2yp9xTP2hVhcSIJmZs
 B/EIupn4iudl0TpKqHqXI3DKeIObvsmGPXd7mZsDynZHA/ZTW8F2h2Waf0JDQ1YrZUr9cMavD
 OIueboobopg4KlWlidkOcDW2AaFVWYis7t0HvcysUU2La0M8aeXP7G5Ayoi+pIlOAC8CPAgNR
 LZU+aX7CjgXHIlLDS0vGb2ZJTgSkc4u+s6Q+IA8KS72QiyLD2NbYeJ7Bo885+NeVCmFn/k9ip
 GpRvbFaQ3+szbQ9VKDuqtcjJ3ugpzSar85MPtaA/EzdOLHTwRzxUoQdfqo1/Yuv8xP4Cw4K1o
 bNvvuaB4IcOldicNvi6F0nL6dRvgGuNt96qJO/yhKOusHJYFfA0Ip4DLZj9tnKmIzw2b396dF
 4QTw0brk8XiTRIL8lgKkCTXP2hjZvToJ7ZkfbBGfZLCPgjKyBS77uDcO8vSiyvcF/Ar5XgdPi
 DMTREaU4xn5O9599xbDHf9eMW+EYLyXyhNcF8IenY+AvCxKYjTBAfUfdBWg4pTx9D9OfkerDu
 sT8g3yYbA/e/Nvt8yrrZcSmH2ZoiEbsJmdPjtMMWDbrLIB2BQetGGCVeCeTPKT++h1c++0PuF
 BHNrLVqmNEUcsVN+8AU7CCO3BwnhyMLGi3OEPiZ8JTXZS5I/puT+etUuIDI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The while loop in raspberrypi_discover_clocks() relies on the assumption
that the id of the last clock element is zero. Because this data comes
from the Videocore firmware and it doesn't guarantuee such a behavior
this could lead to out-of-bounds access. So fix this by providing
a sentinel element.

Fixes: 93d2725affd6 ("clk: bcm: rpi: Discover the firmware clocks")
Link: https://github.com/raspberrypi/firmware/issues/1688
Suggested-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/clk/bcm/clk-raspberrypi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 73518009a0f2..79cbf0c0b401 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -344,8 +344,13 @@ static int raspberrypi_discover_clocks(struct raspberrypi_clk *rpi,
 	struct rpi_firmware_get_clocks_response *clks;
 	int ret;
 
+	/*
+	 * The firmware doesn't guarantee that the last element of
+	 * RPI_FIRMWARE_GET_CLOCKS is zeroed. So allocate an additional
+	 * zero element as sentinel.
+	 */
 	clks = devm_kcalloc(rpi->dev,
-			    RPI_FIRMWARE_NUM_CLK_ID, sizeof(*clks),
+			    RPI_FIRMWARE_NUM_CLK_ID + 1, sizeof(*clks),
 			    GFP_KERNEL);
 	if (!clks)
 		return -ENOMEM;
-- 
2.25.1

