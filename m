Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43977521453
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbiEJL6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241273AbiEJLz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:55:59 -0400
Received: from smtp124.ord1d.emailsrvr.com (smtp124.ord1d.emailsrvr.com [184.106.54.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DF8270185
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1652183519;
        bh=vzRwUlGToYcHVeBq8ROmOTE4BYm05ZC+d240t0warA8=;
        h=From:To:Subject:Date:From;
        b=MQ/YsUQzXbKiOGKQWGacqxpFyEGIY7pIdpxWs0Qol7ng+gWXXn5CGdLf9L1Yd7ymc
         Pnl/NTiS9orL3/7LEq/fNG+K33NVqO2vB7kT6/2CuhGHlgcUpsrq702XQEaVgCHlmg
         8DTprCXSrY3HdjDVcAIAtOL+YbUBFEYHbc5V4hMw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp8.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id D8407C00B6;
        Tue, 10 May 2022 07:51:58 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 2/2] spi: cadence-quadspi: remove unnecessary (void *) casts
Date:   Tue, 10 May 2022 12:51:41 +0100
Message-Id: <20220510115141.212779-3-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510115141.212779-1-abbotti@mev.co.uk>
References: <20220510115141.212779-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b75da69c-0230-413e-8e5d-188bceb56f6b-3-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a couple of unnecessary casts to `(void *)` when initializing the
`.data` members in the device ID table.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/spi/spi-cadence-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 9915704eaf06..aea6c132cbab 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1811,11 +1811,11 @@ static const struct of_device_id cqspi_dt_ids[] = {
 	},
 	{
 		.compatible = "xlnx,versal-ospi-1.0",
-		.data = (void *)&versal_ospi,
+		.data = &versal_ospi,
 	},
 	{
 		.compatible = "intel,socfpga-qspi",
-		.data = (void *)&socfpga_qspi,
+		.data = &socfpga_qspi,
 	},
 	{ /* end of table */ }
 };
-- 
2.35.1

