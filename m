Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EB0492359
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiARJzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiARJzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:55:11 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDE5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 01:55:10 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m4so76829520edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 01:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xehe2GRXgQYN/+dRP8wnpXRUBfEHFaQIKrZHmlK7Gkc=;
        b=NMnFrZh7b8z20cbVj3sAC5udzo0Oe3RiHbKJ4a7YROrEsX9NWwDvwnCQauIsX7znwX
         vfO8jWzwD6YjeImeo1BVOO6VmJcl/7gO8SyZKMwLtURaGByFHq4k1jzlGCGqkWaTP8qP
         7BpUqTWIqmaj5zYmvIzm/tj+dQtEMK8YpLQqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xehe2GRXgQYN/+dRP8wnpXRUBfEHFaQIKrZHmlK7Gkc=;
        b=BLhMHzZ0XxZBGMIn0PYj5ddEvAP1DgE+oVUMpzhDBEz6raCQQjf+0wqrZvv/Z/hybh
         kDCxUklB74jlse/B/mQjyEkdXdHN+hB/Pl37EQ93Z5IgHxfuG6h20IwVy7Pv1n9VsQ4p
         FCElm95NqaBenLYaJyypIxj4A7mPruuAmDjMOPdbtHcgDpK9AFJaZkGODQeghl7dhqq+
         fGkwqP0siUxiYUI5KtwqUcE60T7SVJgG+7tCNPS01v+IStmPxTQgGbAyW66exp7lnpNM
         nYwXG9SynNZmnKVDdaq2m3s5ZA7LXR9jTwCy1MiWDrc2eOwLBAWXgXwCQ5xz2Ej1ya0N
         8t7w==
X-Gm-Message-State: AOAM532RiLwgpJT4bvKNTUDNBF23e9SNf0Kg0SbuGuAkgVB2tGYszM26
        +uOfro5nkfcRb3ZHMR7R8Ft0VhiFpAtxoQ==
X-Google-Smtp-Source: ABdhPJwWEKhNqf1JZzX3FA0R0DGU3cjYeegcCormXg5HGMlO+9TulADkuk8ct4HcDBxgzuptFuLYHg==
X-Received: by 2002:a17:906:4983:: with SMTP id p3mr20017289eju.589.1642499709124;
        Tue, 18 Jan 2022 01:55:09 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id w3sm5173520eji.134.2022.01.18.01.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 01:55:08 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 2/4] mtd: rawnand: gpmi: fix controller timings setting
Date:   Tue, 18 Jan 2022 10:54:32 +0100
Message-Id: <20220118095434.35081-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220118095434.35081-1-dario.binacchi@amarulasolutions.com>
References: <20220118095434.35081-1-dario.binacchi@amarulasolutions.com>
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
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---

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

