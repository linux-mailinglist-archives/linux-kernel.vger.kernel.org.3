Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E804790B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbhLQPz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238506AbhLQPzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:55:51 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF28DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:55:50 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y12so9386800eda.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GPyuWnLPH8PFNFJh17BU4dw6g8DK6MUXDTmu7+hfLlY=;
        b=gFDRtlH3e1/Jlp1cAjp2QqkKroRvrg65fXs2p8TfqllBfCqoiogpYwTR2o5QbEEuD/
         OogD9ePzwhTd3y+dc4zEXuNYNse3FghP9+qtQXfNman3VDrKlL33nC10tLbMMRpOpJ+Q
         pj0s34n97SOV7qZy0zdvh0DyIOmt/GleRGk3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GPyuWnLPH8PFNFJh17BU4dw6g8DK6MUXDTmu7+hfLlY=;
        b=p1yTuNavmQA3EehrG7EwW4C1asEAFAE7W3lA7TJ38vOHvxKGar95pG2eVUDQIgR1Us
         ddvScUNnrfLGnX0BMCX557nkDi7q0Cmu1eodPwlgSjZIITxy5HFZ6QotHbOe4rkpOuQY
         4CGZZUJXzh4PRJMjofvKCdTwTHKakEx8aJ5vqV0J5SmTlw0288clr9OAgsedbJxRD8WV
         2/n02QSiBQ6Xfo1kVO3v3nzxcMszTMb3hyo+AS5jKMnjYtQgJ6XjX04lhPwkhz6d2Kzq
         etKawOeMGktOLbH9quw4tY6s6MCYDnM1AG1NB42Hrgadnz7nYcR1FLzbMCZBaX8+4/Zu
         0ZNA==
X-Gm-Message-State: AOAM5320FH39Ao83WoYVCD8GIQD9hiVy2fKHkNaAmmDiedN/gXeIXyLq
        WSTl7itxolu4lCJaVlOnqXH+X1LCijOLLg==
X-Google-Smtp-Source: ABdhPJypWJce5q+VYVZqPNebWyJZp9GWchWxQ7EUMp01LDmMnu4A8AyP1ZlWihYdRXcrf843n+1caw==
X-Received: by 2002:aa7:c6c8:: with SMTP id b8mr3513024eds.164.1639756549196;
        Fri, 17 Dec 2021 07:55:49 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-79-56-50-241.retail.telecomitalia.it. [79.56.50.241])
        by smtp.gmail.com with ESMTPSA id i6sm772158edx.46.2021.12.17.07.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 07:55:48 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [RFC PATCH 3/4] mtd: rawnand: gpmi: fix controller timings setting
Date:   Fri, 17 Dec 2021 16:55:11 +0100
Message-Id: <20211217155512.1877408-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211217155512.1877408-1-dario.binacchi@amarulasolutions.com>
References: <20211217155512.1877408-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The controller registers are now set accordling to the real clock rate.

Fixes: b1206122069a ("mtd: rawnand: gpmi: use core timings instead of an empirical derivation")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
---

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index fd935e893daf..0517b81bb24c 100644
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

