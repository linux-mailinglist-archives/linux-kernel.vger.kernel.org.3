Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1258446955F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242835AbhLFMHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242822AbhLFMHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:07:10 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713A1C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 04:03:42 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id m20-20020a17090aab1400b001ad6e2148ccso5331961pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 04:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p1dnwp9pexb4Wt3I9dr5nw5PW+WuwG9peUBcyXTrLmk=;
        b=ItMJzmgvxGxPVesVHjU0mcymz1iyNdwpJWoB73JHipYHHFD56MFpq4sYU4NBiImkoI
         m+7ZaTUYKErzvpu8Ynaz0TYQK3PPupffOC9QQMyR3Mw+7XeLkNGV2OQPWa8xbUgIWBPH
         79az/W5Oq4Kc3oPYhGGXgmBxGjRWvTDoSJMubBBFCM+85x/7OCOAPPjHKEsB6N1gxwn8
         toYbj+BJ2FyXGJE5jadM7l8lFVu3vwlrvkWCifhw/XT5v9sVEuHOefDxzzSkNpGmfao8
         PsaQEZPlDCSbln5xDaZxhBLkKwRyUH7J7zi6hiflWwOhBOmima9KuqA5oga0B04BgZSY
         nipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p1dnwp9pexb4Wt3I9dr5nw5PW+WuwG9peUBcyXTrLmk=;
        b=TOhSkXJfZh9gJGyLpj+gLmfJW6XA+KyQ5XatLga7nIEXmH49UVDmmHNgx9z3/sD+rc
         ivQ3zHxM4HI3N5eJFwEeYtYR95wVthjlGKVqliE95lgdkqL25+NNPEDJBHdk7El3swop
         eq67svFBVa2CZqLAP10KO37t3K5txy8WYw2jqZ46SuYZ687yyajiCSe6qhd2eOnTVpPp
         Gv14+nEriXh5mQ2gfTf9tQcmFuF0r40mH5tqWyvzPP6qYFETqH1JTyQM2btaXz3Vk1fa
         imvQwGRbmgSvqrNh370xg1HkQB64pUWZQWhc+PvjcOxFktJ6xlPoQ+6yPk8CYHlpZCen
         najQ==
X-Gm-Message-State: AOAM531aRoAUY/ukynPqTLgmtDIwP8XRiYgoKc3I7RVyLLKRQWjzUnni
        3Wl42uSNQUm0pmWW3Nf53nmRe+u6Q3vbdFo=
X-Google-Smtp-Source: ABdhPJx+ASdS+2v1RcQjXuw5XjroTrKuPkStI0J3v+VCCjEsMDvw7wj+8AHdDAGbYM0+DtL9BgAwfSBPmDEQ4LQ=
X-Received: from robscloud.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:553e])
 (user=robbarnes job=sendgmr) by 2002:a17:902:c204:b0:142:2441:aa26 with SMTP
 id 4-20020a170902c20400b001422441aa26mr43283611pll.84.1638792221807; Mon, 06
 Dec 2021 04:03:41 -0800 (PST)
Date:   Mon,  6 Dec 2021 12:03:09 +0000
In-Reply-To: <Yaut12SfSYPGcs6S@iki.fi>
Message-Id: <20211206120311.2844838-1-robbarnes@google.com>
Mime-Version: 1.0
References: <Yaut12SfSYPGcs6S@iki.fi>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3] char: tpm: cr50: Set TPM_FIRMWARE_POWER_MANAGED based on
 device property
From:   Rob Barnes <robbarnes@google.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Rob Barnes <robbarnes@google.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set TPM_FIRMWARE_POWER_MANAGED flag based on 'firmware-power-managed'
ACPI DSD property. For the CR50 TPM, this flag defaults to true when
the property is unset.

When this flag is set to false, the CR50 TPM driver will always send
a shutdown command whenever the system suspends.

Signed-off-by: Rob Barnes <robbarnes@google.com>
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 16 +++++++++++++++-
 drivers/char/tpm/tpm_tis_spi_cr50.c | 16 +++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index c89278103703..f6c0affbb456 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -628,6 +628,19 @@ static bool tpm_cr50_i2c_req_canceled(struct tpm_chip *chip, u8 status)
 	return status == TPM_STS_COMMAND_READY;
 }
 
+static bool tpm_cr50_i2c_is_firmware_power_managed(struct device *dev)
+{
+	u8 val;
+	int ret;
+
+	/* This flag should default true when the device property is not present */
+	ret = device_property_read_u8(dev, "firmware-power-managed", &val);
+	if (ret)
+		return true;
+
+	return val;
+}
+
 static const struct tpm_class_ops cr50_i2c = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.status = &tpm_cr50_i2c_tis_status,
@@ -686,7 +699,8 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 
 	/* cr50 is a TPM 2.0 chip */
 	chip->flags |= TPM_CHIP_FLAG_TPM2;
-	chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
+	if (tpm_cr50_i2c_is_firmware_power_managed(dev))
+		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
 
 	/* Default timeouts */
 	chip->timeout_a = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
index dae98dbeeeac..7bf123d3c537 100644
--- a/drivers/char/tpm/tpm_tis_spi_cr50.c
+++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
@@ -185,6 +185,19 @@ static int cr50_spi_flow_control(struct tpm_tis_spi_phy *phy,
 	return 0;
 }
 
+static bool tpm_cr50_spi_is_firmware_power_managed(struct device *dev)
+{
+	u8 val;
+	int ret;
+
+	/* This flag should default true when the device property is not present */
+	ret = device_property_read_u8(dev, "firmware-power-managed", &val);
+	if (ret)
+		return true;
+
+	return val;
+}
+
 static int tpm_tis_spi_cr50_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 				     u8 *in, const u8 *out)
 {
@@ -309,7 +322,8 @@ int cr50_spi_probe(struct spi_device *spi)
 	cr50_print_fw_version(&phy->priv);
 
 	chip = dev_get_drvdata(&spi->dev);
-	chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
+	if (tpm_cr50_spi_is_firmware_power_managed(&spi->dev))
+		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
 
 	return 0;
 }
-- 
2.34.1.400.ga245620fadb-goog

