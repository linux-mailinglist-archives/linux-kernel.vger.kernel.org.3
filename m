Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C43C490707
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiAQLSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbiAQLSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:18:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5170C061401
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:18:41 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m4so63982790edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1U+MO7BClWc4cGfvNBl6cQXhNHZ2EpawrE7wpyjmSlU=;
        b=H68wnCWCkg20QgNO8XJpB6pf6OSiPm1Nv2FITEANqlmGTdw2efMMfOEbbWmNs9ajC9
         46SEzeFfEUUG1Q/9PaOAZouyJ8WfFBMtiGHqKWTh4ATWtEAnoAmpTTA7L0zQqcpY85gy
         RCaHaQrgR8L7gGP6hTcWXy4Wk0mTaW2Y4VInA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1U+MO7BClWc4cGfvNBl6cQXhNHZ2EpawrE7wpyjmSlU=;
        b=nG0t9bwRUsadel7ATqWNnVzTvZq3H57XH24C85daIjG1KtFAglQhhP443PjOfl/gbv
         X6Q88vywsd7M+vHd3A2zvH0jdALeTQUB9mSogbp42n9myMQYrlnOiO/LjSgYE6BGJwwW
         CEuLtYVYi9NVaSIl9/dc9A79iHajMWhw5XWC805xJ5ALIOR420Egwz+ykR2jmmxrrM1G
         xYANGfLwvrTv70r66X/0wj/DVCX7Rzi7A0cLhne5PVN5rVBjkIEFY0le1Y/dB5tgwNyo
         uA9oXbGZqkXIV4qbq28+e2KTwEhLB3stHCvitN3ap0vnAinfU7PiKPmVP2dI9JKb6lBB
         zEHg==
X-Gm-Message-State: AOAM5311rgqQk4kFQiVxQpZ3yV1zxpK10OAOOqB1Q8Rldd/Ey4dxpJ0P
        tNKl1DxtXGUruALaN38rgZKSQWlPhh7xDg==
X-Google-Smtp-Source: ABdhPJwYitGMTeD2cK5kj6+zGxi4gy5j3Ikqrx28OOGxKCPjSf2TZwLzdfYgk1MnXae2y9supUWsRQ==
X-Received: by 2002:a17:906:8cf:: with SMTP id o15mr15146840eje.603.1642418320033;
        Mon, 17 Jan 2022 03:18:40 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id f11sm5142713edv.67.2022.01.17.03.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 03:18:39 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [RFC PATCH v2 5/5] mtd: rawnand: gpmi: support fast edo timings for mx28
Date:   Mon, 17 Jan 2022 12:18:29 +0100
Message-Id: <20220117111829.1811997-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220117111829.1811997-1-dario.binacchi@amarulasolutions.com>
References: <20220117111829.1811997-1-dario.binacchi@amarulasolutions.com>
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

---

Changes in v2:
- Improve the commit message.
- Move the patch to the end of the series.

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 7ae7a37775a3..7b9191a70ed1 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -806,8 +806,8 @@ static int gpmi_setup_interface(struct nand_chip *chip, int chipnr,
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

