Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEBC55A818
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 10:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiFYIhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 04:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiFYIhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 04:37:40 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C3337ABF;
        Sat, 25 Jun 2022 01:37:38 -0700 (PDT)
Received: from localhost.localdomain ([37.4.249.155]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M3DBd-1o6OCq1Hif-003aCA; Sat, 25 Jun 2022 10:37:21 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] clk: bcm: rpi: Fix error handling of raspberrypi_fw_get_rate
Date:   Sat, 25 Jun 2022 10:36:43 +0200
Message-Id: <20220625083643.4012-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Vy6icAiczF0gw0MoXatbk2jXhrSuQ7VJMzuHmw0S6CNnF5C1W5Z
 Agav/V+gv8xK47eb0kYjJuh7ANFjFg6yE6t29NIk37gM7sgslw1fuMkH8rFWV0im+Mm8uvO
 TgA+Inxv9MxfR0oHG/XcD6p8mN0z6svksrTveZc+hgcHAqp83VguIR0UUMNfNihO4TLeAuk
 KNPAg8sHJlV51kcwjg7DA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Stru1JlMmJ0=:gfTZrHPcEAVKnTCpULi1sm
 GK/p9GY678WyqGGjQF0Vf2EcsNrK4BHkLrfPveBN8jKBvGXrRrsaeNjmpPipvXvM4GN3qrP2Q
 ha9toybsFXWHVLvXGUSD99fDb29YWRmVDCooAqmsOkC+92w7/3xfyVC8SArdoflhtxX3Yx++m
 Og71tBBdIF9V7m1UCHv7LvZpawGtivezMkEFRA1KiOykjE0hy8NpsVb7LF6xgT3KU/Ou2f0zC
 Q8SULZ60Ss1iZFkZexnl5Rurkagijt/wDd7y3WqdVIfAnieZe1r9hVvj2RGdJDwi+hQBDPyby
 wlP7N24XiiSAb04TaMuIu/MxiRunE5JP+H2A9bzdB7jgwPRrJAJLzaaQF0ys6zEGSbWn1TmDh
 Tyn6gFZSwaTT3f5FQM01z2beXbjt9wOJHyIyl+VXNAWyUAbHyyq2WMRTP0HnXan3ol3ffTEkw
 q09DDoeZEZ7BGWPPZudCwpYwFjRbRPEUjh7pi+SafTo8VUuAbycz1FXjgn3s9yBInQ4nxB+5C
 I3xg21uX366vbd+CEQKjvkOOpTBV8kTBpdebRlbS4+9h2BQZF02jjnhcThGH/Cq48+J10X9Y9
 V0A/kMEaXwoqfIuqxnMO+cCvOJILEhH6q4bPPhIBJ93caTPCFYDidtTlasDmf6XQjFj44AgnD
 AfM/m1iMXqipBm4v0U9zqXUNedql+pVHbj8A9doeQm6Ik9hNT2pJbx11Sdj6STd4EXGApJJ5T
 RaBjKU3FqR3pqxJ5zFtjoVdvP3fSbwKY5KzWwh1GlaEadXfzJdLiHIxvLmc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function raspberrypi_fw_get_rate (e.g. used for the recalc_rate
hook) can fail to get the clock rate from the firmware. In this case
we cannot return a signed error value, which would be casted to
unsigned long. Fix this by returning 0 instead.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/clk/bcm/clk-raspberrypi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 73518009a0f2..39d63c983d62 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -203,7 +203,7 @@ static unsigned long raspberrypi_fw_get_rate(struct clk_hw *hw,
 	ret = raspberrypi_clock_property(rpi->firmware, data,
 					 RPI_FIRMWARE_GET_CLOCK_RATE, &val);
 	if (ret)
-		return ret;
+		return 0;
 
 	return val;
 }
-- 
2.25.1

