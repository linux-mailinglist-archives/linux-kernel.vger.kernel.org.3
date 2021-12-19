Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15C247A12F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 16:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbhLSPe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 10:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbhLSPe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 10:34:56 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128EEC061574;
        Sun, 19 Dec 2021 07:34:56 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a9so14853716wrr.8;
        Sun, 19 Dec 2021 07:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MeA65dvwLUBRiBlXrb74voXUaCWcwbuJME/G4fyM1WE=;
        b=LR8rz9Cc7Yg0w1IbXjVOyA50yFgAwND+RfR8wGeEOu8d3iV09J0ES+c4ehcpNvgVHg
         ePf5xN/1/lKNwsKEy8qsx3+sLsbeKq4XJacBnijh7eet3vQ/hBo1geY55i8aVYdIBOt5
         xCDUhGvsjQpgtp7fXhcPKYqPHZLBBW+bGdYIl4Iq/p54BUEx9RAIwSqEg0b43sMsIWP7
         zjfQ1e2dI2GFg3ibFnF/dx5VqdlKKwE6YMM5zxYr96dJEWeT4+RMatmYTw2P/YiKDbnd
         Czjg2akOp/8z9+EulFPAeW48I6MQCoLRXoCXHDxK5RaPlAViFFDbb//xj/bNo14ehrIw
         2Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MeA65dvwLUBRiBlXrb74voXUaCWcwbuJME/G4fyM1WE=;
        b=1hGfX77DjfylgOO5BUUyVX5ix7HUlYmnwbiAxW8a0nOpJW5OHBXxIvycpo8dyMQp+Q
         Xn7ncJN4bM/dytk0WlsQLMi+42LIpXhNEdRkLCQRydE7vjSace3IYVsSGicrNGIcU+oP
         7ugPn4qOyFyOoIlxpvkmUNOrcueGJlLD2muyAU54bBHU8zyuFw4ZK4yrhV8v4GVkonaE
         Np8Sb/rxy6CS347fkPDieYQ4EHMDAZYBCVZDDuSCD6PJoZIM+dP7u35ZyoUk15Cyq9fI
         QIWd7C6QQsGS1HgPQ/10U4P78MNJlOC1zNS3Mq6Ee01aUysRU8P/iXZYw9XCCJz5aBO1
         r8sA==
X-Gm-Message-State: AOAM533jvi7/G9ud+tU+/ro5eROaHvFNcal0B0Bio6xYOmb5kSeTKwm1
        92tkD4ofjPpgbvouiaISsq76xJWhivE=
X-Google-Smtp-Source: ABdhPJwANpA9yK16E0dLSdCWIR5awSquoxmfcfjBl6sh0u8qf6+TLJTC2uJRJzY4rmt9V6rmN6dAqQ==
X-Received: by 2002:a5d:6c6d:: with SMTP id r13mr9834007wrz.76.1639928094412;
        Sun, 19 Dec 2021 07:34:54 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-721d-8f00-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:721d:8f00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id d2sm9262020wrw.26.2021.12.19.07.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 07:34:54 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ulf.hansson@linaro.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] mmc: meson-mx-sdhc: Set MANUAL_STOP for multi-block SDIO commands
Date:   Sun, 19 Dec 2021 16:34:41 +0100
Message-Id: <20211219153442.463863-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219153442.463863-1-martin.blumenstingl@googlemail.com>
References: <20211219153442.463863-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor driver implements special handling for multi-block
SD_IO_RW_EXTENDED (and SD_IO_RW_DIRECT) commands which have data
attached to them. It sets the MANUAL_STOP bit in the MESON_SDHC_MISC
register for these commands. In all other cases this bit is cleared.
Here we omit SD_IO_RW_DIRECT since that command never has any data
attached to it.

This fixes SDIO wifi using the brcmfmac driver which reported the
following error without this change on a Netxeon S82 board using a
Meson8 (S802) SoC:
  brcmf_fw_alloc_request: using brcm/brcmfmac43362-sdio for chip
                          BCM43362/1
  brcmf_sdiod_ramrw: membytes transfer failed
  brcmf_sdio_download_code_file: error -110 on writing 219557 membytes
                                 at 0x00000000
  brcmf_sdio_download_firmware: dongle image file download failed

And with this change:
  brcmf_fw_alloc_request: using brcm/brcmfmac43362-sdio for chip
                          BCM43362/1
  brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may
                            have limited channels available
  brcmf_c_preinit_dcmds: Firmware: BCM43362/1 wl0: Apr 22 2013 14:50:00
                         version 5.90.195.89.6 FWID 01-b30a427d

Fixes: e4bf1b0970ef96 ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
index 7cd9c0ec2fcf..8fdd0bbbfa21 100644
--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -135,6 +135,7 @@ static void meson_mx_sdhc_start_cmd(struct mmc_host *mmc,
 				    struct mmc_command *cmd)
 {
 	struct meson_mx_sdhc_host *host = mmc_priv(mmc);
+	bool manual_stop = false;
 	u32 ictl, send;
 	int pack_len;
 
@@ -172,12 +173,27 @@ static void meson_mx_sdhc_start_cmd(struct mmc_host *mmc,
 		else
 			/* software flush: */
 			ictl |= MESON_SDHC_ICTL_DATA_XFER_OK;
+
+		/*
+		 * Mimic the logic from the vendor driver where (only)
+		 * SD_IO_RW_EXTENDED commands with more than one block set the
+		 * MESON_SDHC_MISC_MANUAL_STOP bit. This fixes the firmware
+		 * download in the brcmfmac driver for a BCM43362/1 card.
+		 * Without this sdio_memcpy_toio() (with a size of 219557
+		 * bytes) times out if MESON_SDHC_MISC_MANUAL_STOP is not set.
+		 */
+		manual_stop = cmd->data->blocks > 1 &&
+			      cmd->opcode == SD_IO_RW_EXTENDED;
 	} else {
 		pack_len = 0;
 
 		ictl |= MESON_SDHC_ICTL_RESP_OK;
 	}
 
+	regmap_update_bits(host->regmap, MESON_SDHC_MISC,
+			   MESON_SDHC_MISC_MANUAL_STOP,
+			   manual_stop ? MESON_SDHC_MISC_MANUAL_STOP : 0);
+
 	if (cmd->opcode == MMC_STOP_TRANSMISSION)
 		send |= MESON_SDHC_SEND_DATA_STOP;
 
-- 
2.34.1

