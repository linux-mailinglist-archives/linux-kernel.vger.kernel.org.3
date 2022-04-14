Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2F850088C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiDNInU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbiDNInP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:43:15 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8857D3890;
        Thu, 14 Apr 2022 01:40:51 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 718896000E;
        Thu, 14 Apr 2022 08:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649925650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3jQQts1QROHMG7XnSLWZq2iYhsnf02jvC7G3MrzCtgw=;
        b=njoPuEKOd0/9D2sAqpuiLQDVlCir7gLIRo8bkhrpNPEuJyey/Yo1iRIK5VvDVkxFmcSRIZ
        MVv2dGptHq0l533VSxSgFfHefPbAEBXutqOhdFF+7eNaHydVY/NXO1SlD/fmcXoKwI+tVM
        hpIfG0igiL20MVhwR0CUf3uLqhCZbPAyUa/TQoZTWZyi23UcfgMxCtwKkgHDTOdX6/mo4o
        NGH6AeAEvluorOP+5lCjQzLyFjL8NDhtHHJsYOiIMwQVXRs9AuYJNWpbWTrvId4x3NDiG3
        99+PDtJhVc4aSPhlnv7EnZWh+D3AWYhU/zgO1cR4oq0KiOZXQ4+nA3KoZ10CDQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] spi: core: Initialize returned status in spi_setup
Date:   Thu, 14 Apr 2022 10:40:40 +0200
Message-Id: <20220414084040.975520-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous commit that made bits-per-word validation conditional
results in leaving no unconditional affectation of the status variable.

Since the variable is returned at the end of the function, initialize
it to avoid returning an undefined value.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Fixes: b3fe2e516741 ("spi: core: Only check bits_per_word validity when explicitly provided")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 563a56ce34a0..890ff46c784a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3475,7 +3475,7 @@ static int __spi_validate_bits_per_word(struct spi_controller *ctlr,
 int spi_setup(struct spi_device *spi)
 {
 	unsigned	bad_bits, ugly_bits;
-	int		status;
+	int		status = 0;
 
 	/*
 	 * Check mode to prevent that any two of DUAL, QUAD and NO_MOSI/MISO
-- 
2.35.1

