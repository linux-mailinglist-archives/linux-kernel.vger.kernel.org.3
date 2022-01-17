Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B92490C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbiAQQSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbiAQQSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:18:14 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84930C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:18:14 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a18so67806906edj.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9REQV9VUHF/RRnZE0ju+SnWMY/5CBxb+FFHFaOix1wk=;
        b=fn+mo15mN5OLz1/1FjeSghX/opgVerV9w0pyZgmqzgRCPh05eGakNeu8MbxtVBVSld
         3GnjsXIyhQW0+JTLxOjUrxPdEzCGjMCLNhG7+ma71dUwLY7UxRkZUX86KrrcmUk436/g
         aUYzLKO/yL5O7Q+Ti5XY+JoZFBX5xGoDl58Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9REQV9VUHF/RRnZE0ju+SnWMY/5CBxb+FFHFaOix1wk=;
        b=Dj9BBgfSzC0k2bCSQvrYucPxcZWlIP7jeZKEjNZ2C0+/8UXRojh2a9a5Sork0/1tr7
         SaEVl8sYenvLsMwcQXKlQC9GAuy3zSArM6e5yObzryj5G7SuECKaRYeIykqv+UYMQCwy
         q9+CUgP5bG2pEW6MEDILTCHJSiX5fOoST6G0XgoUBJwtaJOx+GOINUzX+XUOnsrPLHUR
         GMq3RtUNX2uWp6rZ1s/xYEfWcKGhEcNpWqA5J3JZKlr1cjjfXVcEyhxHjVp/zTZeO3kM
         AcSPpvoBzlE9uwTP4lOuEyMLwhPU0XQVWCUwZiCpTWibEAkmKWJdVOTNMx6w8ZVh3FNG
         W4vg==
X-Gm-Message-State: AOAM533RpvqsmxfAckwwgax0YckhngDaVFgYcKxO0mbRxgmJUMiVuy0N
        kRdwf58fFH4EMTPNDINRTb91q79qM4UwwQ==
X-Google-Smtp-Source: ABdhPJxlH+heyB1LM4NMeH1SwpQd4drcVL9osv2R0ZUdgy5ISXEcrQtJY2p5IFIrivwXZZpvbWlozA==
X-Received: by 2002:aa7:ccda:: with SMTP id y26mr6237449edt.371.1642436292967;
        Mon, 17 Jan 2022 08:18:12 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id s4sm4147652ejm.146.2022.01.17.08.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 08:18:12 -0800 (PST)
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
Subject: [RFC PATCH v3 2/4] mtd: rawnand: gpmi: fix controller timings setting
Date:   Mon, 17 Jan 2022 17:17:53 +0100
Message-Id: <20220117161755.1863579-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220117161755.1863579-1-dario.binacchi@amarulasolutions.com>
References: <20220117161755.1863579-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v2)

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

