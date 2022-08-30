Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD6B5A5F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiH3Jjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiH3JjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:39:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545FFF32F7;
        Tue, 30 Aug 2022 02:37:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:10:389d:42df:ae4c:c047:294c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6B4B76601BF7;
        Tue, 30 Aug 2022 10:37:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661852233;
        bh=b5EMCAqklGR1n0mJHp5xybG1xU4cd1JVpNMDf92YVuw=;
        h=From:To:Cc:Subject:Date:From;
        b=EESiaD3LrZwZ9y2nz6qqZgxhvdx9xDoCCINMgc+1v7rnk/1HZ0zO3eUYeyCHBn+qm
         deJpl3nOBWIsbDMIWl5ZCh1oUprkqb6Cjw3XkEYxFrCiy97EkBrWl7W/LWdbezQRkG
         unqgNDO3H/lR2n/inW5PeitcMCcjYkBaX9+gEDuUAJpFRkLgu7zpcHZ9Z02ynRwlyN
         1+LqpCKAiA+Q08E9ubHbt79+rFBMKCwsAhFLkqXPIx3qNGCD+r3A+mebq4IaR41JuI
         +iIrDURS24PeOcDHp/5aZ4aCVxntZ2T1iBLK1b+LYkAjPBVg+qgVWUWlQBTwWo67uJ
         FFSugDG1v1VwA==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     broonie@kernel.org, sanju.mehta@amd.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, krisman@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH] spi: amd: Fix speed selection
Date:   Tue, 30 Aug 2022 15:06:07 +0530
Message-Id: <20220830093607.45484-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
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

If the current speed is equal to the requested speed by the device
then return success.
This patch fixes a bug introduced by the commit 3fe26121dc3a
("spi: amd: Configure device speed") which checks speed_hz instead
of amd_spi->speed_hz.

Fixes: 3fe26121dc3a ("spi: amd: Configure device speed")
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 drivers/spi/spi-amd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 264633c5ce0b..e23121456c70 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -240,9 +240,6 @@ static int amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
 {
 	unsigned int i, spd7_val, alt_spd;
 
-	if (speed_hz == amd_spi->speed_hz)
-		return 0;
-
 	if (speed_hz < AMD_SPI_MIN_HZ)
 		return -EINVAL;
 
@@ -250,7 +247,7 @@ static int amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
 		if (speed_hz >= amd_spi_freq[i].speed_hz)
 			break;
 
-	if (speed_hz == amd_spi_freq[i].speed_hz)
+	if (amd_spi->speed_hz == amd_spi_freq[i].speed_hz)
 		return 0;
 
 	amd_spi->speed_hz = amd_spi_freq[i].speed_hz;
-- 
2.30.2

