Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06815120F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbiD0PpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbiD0PpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:45:01 -0400
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Apr 2022 08:41:47 PDT
Received: from smtp99.ord1d.emailsrvr.com (smtp99.ord1d.emailsrvr.com [184.106.54.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9093033E29
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1651073700;
        bh=dFJHFsLRZTyNfS0SkWwtBPTu73T8OM5Iqc9DWInCJ6g=;
        h=From:To:Subject:Date:From;
        b=KUCb6ZJehsrOrzmlH3xyAYvvnmu3+72FhzUdsz9xu93xuslFhMwEVmqWdY4AlenwS
         uAVxHaHZZgGBYf5QTJ3wNjzAVGTK0U15L+MQ64hdgiM9D3cQC9ZKX+nvu41fc4UceX
         QIXF02MzJwqR5MnBMmwTkyi28hX8INpgAr2wV5iw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp13.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id D6BBCC019D;
        Wed, 27 Apr 2022 11:34:59 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH] spi: cadence-quadspi: fix Direct Access Mode disable for SoCFPGA
Date:   Wed, 27 Apr 2022 16:34:46 +0100
Message-Id: <20220427153446.10113-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: be3968db-419c-4c49-af1b-b8e23ba017e0-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cadence QSPI compatible string required for the SoCFPGA platform
changed from the default "cdns,qspi-nor" to "intel,socfpga-qspi" with
the introduction of an additional quirk in
commit 98d948eb8331 ("spi: cadence-quadspi: fix write completion support").
However, that change did not preserve the previously used
quirk for this platform.  Reinstate the `CQSPI_DISABLE_DAC_MODE` quirk
for the SoCFPGA platform.

Fixes: 98d948eb8331 ("spi: cadence-quadspi: fix write completion support")
Cc: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 41922a5ea1f4..30307392c75a 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1781,7 +1781,7 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
 };
 
 static const struct cqspi_driver_platdata socfpga_qspi = {
-	.quirks = CQSPI_NO_SUPPORT_WR_COMPLETION,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION,
 };
 
 static const struct cqspi_driver_platdata versal_ospi = {
-- 
2.35.1

