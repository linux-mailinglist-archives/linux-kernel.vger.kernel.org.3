Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187A3490704
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiAQLSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbiAQLSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:18:38 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016DAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:18:38 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id k15so63983595edk.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iq4FM2PRLAcot9iAnDMYHV6yAJ0nWXkPdknU80um0hk=;
        b=IB+KjWd8cHfC4D1zKJykFmFfRmcOLwb4vXLkbsk9WocfSgH8I5Zsn7Q+ReAXfRq4tI
         dgQzZE03Y58DdmDRXhZYG8Z1dqsocUfJLE9StlBfkTwhCilKOfJFi1teHXEhCe1mWArK
         n6fxSeoQ62y8Jjc5gCCy3wM37psn7FkhoDwa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iq4FM2PRLAcot9iAnDMYHV6yAJ0nWXkPdknU80um0hk=;
        b=52ZQfms2VBqrlGs1lNjFWGZG2zKF1DSy7TmO8KI3YVTmTyK2ohqPv5TJV3BFkLt6RL
         rSkHrBvvIPP/JJ/HEauoGDDYf8+HS8pz2o6gqqzk47kO7nMG6safJsCHc5w7j2ngdrHN
         2ZAMgsMVzIBJ7pqw1Kfc7s2dD7ulcV8jVMwdmwgpCevYFGLg6Yb6CvvFjQ4g52ImLA1s
         udRH8U1kjZK+ibN8evfNZ/XaeRN7RG6CmWZcQ/972/6r/p0yqrV/Mi2jJmPiHO6ko4Am
         gYIYyzxbI6XXDS7jMU4Qq7HHAgZEInl/eCQJCAnENMMtTNsrNBjnkaZIMke6MsGOzwRP
         mzlg==
X-Gm-Message-State: AOAM531eSh6Ox4tJumpNd444tkKggtfw3h0u4cwikZ1zRrwpzA2/x8DL
        KJaUVsq9ljN4Pc/WMWBjzg0PE/uDXtzaEfGy
X-Google-Smtp-Source: ABdhPJz17OYx8Igx0F5Esesia6peK+Jesr70iLxwxSwJi0kzRAjt0Ua+ypjgQwM6s3j3r35pU8cc2g==
X-Received: by 2002:a17:907:3da4:: with SMTP id he36mr1872514ejc.707.1642418316340;
        Mon, 17 Jan 2022 03:18:36 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id f11sm5142713edv.67.2022.01.17.03.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 03:18:35 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [RFC PATCH v2 2/5] mtd: rawnand: gpmi: fix controller timings setting
Date:   Mon, 17 Jan 2022 12:18:26 +0100
Message-Id: <20220117111829.1811997-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220117111829.1811997-1-dario.binacchi@amarulasolutions.com>
References: <20220117111829.1811997-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the controller registers according to the real clock rate. The
controller registers configuration (setup, hold, timeout, ... cycles)
depends on the clock rate of the GPMI. Using the real rate instead of
the ideal one, avoids that this inaccuracy (required_rate - real_rate)
affects the registers setting.

This patch has been tested on two custom boards with i.MX28 and i.MX6
SOCs:
- i.MX28:
  required rate 100MHz, real rate 99.3MHz
- i.MX6
  required rate 100MHz, real rate 99MHz

Fixes: b1206122069a ("mtd: rawnand: gpmi: use core timings instead of an empirical derivation")
Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Improve the commit description.
- give examples of frequencies on my setup.

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 1b64c5a5140d..73c3bf59b55e 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -648,6 +648,7 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
 				     const struct nand_sdr_timings *sdr)
 {
 	struct gpmi_nfc_hardware_timing *hw = &this->hw;
+	struct resources *r = &this->resources;
 	unsigned int dll_threshold_ps = this->devdata->max_chain_delay;
 	unsigned int period_ps, reference_period_ps;
 	unsigned int data_setup_cycles, data_hold_cycles, addr_setup_cycles;
@@ -671,6 +672,8 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
 		wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
 	}
 
+	hw->clk_rate = clk_round_rate(r->clock[0], hw->clk_rate);
+
 	/* SDR core timings are given in picoseconds */
 	period_ps = div_u64((u64)NSEC_PER_SEC * 1000, hw->clk_rate);
 
-- 
2.32.0

