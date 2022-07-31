Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B72F585E83
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiGaKuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbiGaKup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:50:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF40011821
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 03:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8843CB80CC5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 10:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC69C433D6;
        Sun, 31 Jul 2022 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659264642;
        bh=Qm90ax5F/85o497xB98g0dIa3GOLg1AqvHKn/kB035o=;
        h=From:To:Cc:Subject:Date:From;
        b=ovpUhqhhAkqoNPthPEexCSVlkbTN8Z1hZXHZLBpqAbT1bo3dVgcv0XzGE7Ox4iHEO
         RYlQw10BNQ42HoUYV9FxdUafQZ0RtwZSWF9UJePi/20AUM62gxEKW80Co15goak4s6
         +GYaSOEBUuFrU/X90gFkFXsvvwMjRIP0X3QZwGeeQpa6ur8czHjLr+uZt3weuBNVPX
         fjVJlVTk4pfnoaX4yvfhQM22oREcNGZBmQkJvzHMc9+wJ4lRDEggP+2GO6zwymcc+e
         Qx3UM4x/UKfBweiLd43R14XFAlzuJFwwBpzH00I5x5CI0ie76EhhfNpBQbP8LoK4X7
         0A4kmgZC9b2XQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/8] habanalabs/gaudi: fix print format for div_sel
Date:   Sun, 31 Jul 2022 13:50:30 +0300
Message-Id: <20220731105037.545106-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Print format was for int (%d) while variable is u32.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 4d11efed3e64..866dc4b891d6 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -939,9 +939,7 @@ static int gaudi_fetch_psoc_frequency(struct hl_device *hdev)
 			else
 				freq = pll_clk / (div_fctr + 1);
 		} else {
-			dev_warn(hdev->dev,
-				"Received invalid div select value: %d",
-				div_sel);
+			dev_warn(hdev->dev, "Received invalid div select value: %#x", div_sel);
 			freq = 0;
 		}
 	}
-- 
2.25.1

