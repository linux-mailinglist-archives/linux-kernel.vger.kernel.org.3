Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E993471B07
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 16:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhLLPAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 10:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhLLPAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 10:00:17 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107C8C061714;
        Sun, 12 Dec 2021 07:00:17 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c4so22982001wrd.9;
        Sun, 12 Dec 2021 07:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UP9pG6uKZAoL6xiFw7btc/sBc9qDC7+hGRLW0JFhSVk=;
        b=HmWK9zrUArMWPecimSXNGOviBl90BWrJqgUGPU7yVt13kPvA9G6JvY7VAJtJi7/eje
         BRkinnynjf56loJ1VqDKhxHKtb98Vx/DiT7LUeqP/Tl0hh599HdhA9/UxQYRZe+OxPDy
         9op1J1ZSDfy0RXoTokv3DAcAl1q4Eeh1NYxjYoDhX4KKuJzCBvvePd232YSBn0zJWo/R
         79GoQ3cqFTrU2xHzpVI2ek0DnSQl+8qCzyad4S75YRAQuTEx9Zz8az1CZy4Nvn+AYoRf
         3fQgM26oppedVZbAoLTJVVeCJuDwdrSM5sUCzvDYCFpLDGVSNOtfI2uNr9w6ilR9Mn8A
         tKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UP9pG6uKZAoL6xiFw7btc/sBc9qDC7+hGRLW0JFhSVk=;
        b=UZ7AHVMkvUxIg1FBFYhXOe+XpkWuANMiR8rIqItP4hs6hP9dRBGxe+ZWd5DWHZJWHK
         4mU5z84+2mj/ehaLz4QPUihJ8oBU+qjoUzXKtOtrGLVPwrAJ2nP63zNSOgcO6e2nKp9s
         wSKBguJ6tYofBSHDvIq7Ex32q+lf02MUL8ALhZGSvXyxHAs9JPP0Aa6sGwjWYDkaHSYo
         9IZX/fcS/is+MUVRyMc39glbFPdQoGAei+nStl2eiwp9LHB5O1nYFVy0U5JEeaJsK/ts
         t9cmqzIAg3AkxUGXKhpJG4UGUpA9treEf61Jda6xkSmtMNwijccavm5VkIg/9Rao1qpp
         KHQQ==
X-Gm-Message-State: AOAM532FjUJl63hY+sosJU5Tw1SVJX/1MoLit6U9dV8n/jZfbQiMV0UE
        yGvDjDtj63ddtVvpQx5j8AwG5fuTuW8=
X-Google-Smtp-Source: ABdhPJwpaIddF4DVl6f4wvuWcPjNKOVW2rREdmwupLSd5gDnxqV8ytN/+qfTw9Ic3bUFJ61NQ0xx7A==
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr26132109wrs.237.1639321215068;
        Sun, 12 Dec 2021 07:00:15 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-6ebc-0100-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:6ebc:100:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id v6sm4284789wmh.8.2021.12.12.07.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 07:00:14 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ulf.hansson@linaro.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 1/2] mmc: meson-mx-sdhc: Set MANUAL_STOP for multi-block SDIO commands
Date:   Sun, 12 Dec 2021 15:59:55 +0100
Message-Id: <20211212145956.1423755-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211212145956.1423755-1-martin.blumenstingl@googlemail.com>
References: <20211212145956.1423755-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor driver implements special handling for multi-block
SD_IO_RW_DIRECT and SD_IO_RW_EXTENDED commands. It sets the MANUAL_STOP
bit in the MESON_SDHC_MISC register for these commands. In All other
cases this bit is cleared.

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
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
index 7cd9c0ec2fcf..a89190d479cf 100644
--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -135,6 +135,7 @@ static void meson_mx_sdhc_start_cmd(struct mmc_host *mmc,
 				    struct mmc_command *cmd)
 {
 	struct meson_mx_sdhc_host *host = mmc_priv(mmc);
+	bool manual_stop = false;
 	u32 ictl, send;
 	int pack_len;
 
@@ -172,12 +173,20 @@ static void meson_mx_sdhc_start_cmd(struct mmc_host *mmc,
 		else
 			/* software flush: */
 			ictl |= MESON_SDHC_ICTL_DATA_XFER_OK;
+
+		manual_stop = cmd->data->blocks > 1 &&
+			      (cmd->opcode == SD_IO_RW_DIRECT ||
+			       cmd->opcode == SD_IO_RW_EXTENDED);
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

