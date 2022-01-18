Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769CE49235B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbiARJzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbiARJzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:55:15 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02173C061748
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 01:55:13 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id b13so77184075edn.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 01:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gS+McM99BOsxvgHxeM4x0busg1n4mFja6rUY4zotoT4=;
        b=ZSEH8tiAoctr1Ec2wZ8zFylBCoSFuEj9+zg3vdt9ziHlmbbcDITIMOJN/df6wna54c
         j+8+LTG3J04j2sWDJMga11YnnHXzUPSaQLC1tC+R/LCSElwitRxA+xsoOov0NdfEdF7l
         DhF5/2gHDaXCg0o0SQN3CCp+S7v1HBSCYnEpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gS+McM99BOsxvgHxeM4x0busg1n4mFja6rUY4zotoT4=;
        b=z3Y1jUOYQ8/w+8b5aCw/y5XyGvXZA6KV2WItF8iaU49dg+wujN6o4KYlbnPQfPsTzG
         GZEsGnt0l46De+psRxWDcN4VyY1UCrgD3/r3IRxQt+WX08q3zMzruEsnqbjiuU9QoTyR
         ijIVZ4KCTyXaJta5SnxWc9aesoiChCkyCxx1iqXYGtEnpN2MO9Hs1BagB09VbANN4AJK
         duHsUbHXlLKd4IoHi6JCPRQVr1dpJ4jS6zL8kP3SRnuLi491KxB8RSNpaHa02n+T2hN0
         S85zs4xgCb+anHIgZd0j/2MhFrnnNDHEf4wXyEWwSS9yb2gzfyc4oEacVRRY457YYaT0
         aQXQ==
X-Gm-Message-State: AOAM533rETQsoxfGLcsS1odCzSsn5TjfK4I7wRurk0MZUz08F7EsNOQ2
        Ag89JjTtgr/Cy0mPNgGPsbdGF4GB3cKfuQ==
X-Google-Smtp-Source: ABdhPJw7G96SDLNhtQf0/8gp+iDRI2d7IwV0mbK8W3Y3mEzeEuJ4ngwDBUWmFlLiOlbmnlKt2rK16g==
X-Received: by 2002:a05:6402:27c7:: with SMTP id c7mr5259157ede.116.1642499711260;
        Tue, 18 Jan 2022 01:55:11 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id w3sm5173520eji.134.2022.01.18.01.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 01:55:10 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 4/4] mtd: rawnand: gpmi: support fast edo timings for mx28
Date:   Tue, 18 Jan 2022 10:54:34 +0100
Message-Id: <20220118095434.35081-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220118095434.35081-1-dario.binacchi@amarulasolutions.com>
References: <20220118095434.35081-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the i.MX28 manual (MCIMX28RM, Rev. 1, 2010) you can find an example
(15.2.4 High-Speed NAND Timing) of how to configure the GPMI controller
to manage High-Speed ​​NAND devices, so it was wrong to assume that only
i.MX6 can achieve EDO timings.

This patch has been tested on a 2048/64 byte NAND (Micron MT29F2G08ABAEAH4).
Kernel mtd tests:
 - mtd_nandbiterrs
 - mtd_nandecctest
 - mtd_oobtest
 - mtd_pagetest
 - mtd_readtest
 - mtd_speedtest
 - mtd_stresstest
 - mtd_subpagetest
 - mtd_torturetest [cycles_count = 10000000]
run without errors.

Before this patch (mode 0):
---------------------------
eraseblock write speed is 2098 KiB/s
eraseblock read speed is 2680 KiB/s
page write speed is 1689 KiB/s
page read speed is 2522 KiB/s
2 page write speed is 1899 KiB/s
2 page read speed is 2579 KiB/s
erase speed is 128000 KiB/s
2x multi-block erase speed is 73142 KiB/s
4x multi-block erase speed is 204800 KiB/s
8x multi-block erase speed is 256000 KiB/s
16x multi-block erase speed is 256000 KiB/s
32x multi-block erase speed is 256000 KiB/s
64x multi-block erase speed is 256000 KiB/s

After this patch (mode 5):
-------------------------
eraseblock write speed is 3390 KiB/s
eraseblock read speed is 5688 KiB/s
page write speed is 2680 KiB/s
page read speed is 4876 KiB/s
2 page write speed is 2909 KiB/s
2 page read speed is 5224 KiB/s
erase speed is 170666 KiB/s
2x multi-block erase speed is 204800 KiB/s
4x multi-block erase speed is 256000 KiB/s
8x multi-block erase speed is 256000 KiB/s
16x multi-block erase speed is 256000 KiB/s
32x multi-block erase speed is 256000 KiB/s
64x multi-block erase speed is 256000 KiB/s

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

---

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index cf35f4206030..d96899fa90b7 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -787,8 +787,8 @@ static int gpmi_setup_interface(struct nand_chip *chip, int chipnr,
 	if (IS_ERR(sdr))
 		return PTR_ERR(sdr);
 
-	/* Only MX6 GPMI controller can reach EDO timings */
-	if (sdr->tRC_min <= 25000 && !GPMI_IS_MX6(this))
+	/* Only MX28/MX6 GPMI controller can reach EDO timings */
+	if (sdr->tRC_min <= 25000 && !GPMI_IS_MX28(this) && !GPMI_IS_MX6(this))
 		return -ENOTSUPP;
 
 	/* Stop here if this call was just a check */
-- 
2.32.0

