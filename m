Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277D1490C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbiAQQSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241019AbiAQQSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:18:17 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366ECC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:18:17 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id k15so67649237edk.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XLwG7XRfre6R+aQSdeErC+1iFRSY828R4VD71xP5o0w=;
        b=MiN7ibyXaw8dNl1iR4wiSvvN1GMlk9PZOGdk4g7mr7DrP1/Th/2U4RbDWc/BBnGvfP
         dl23vitA6D3p4CrilUxRiWqONsoZTTyT1M/J1k1kMMyKQllo7JI6Gvo2QonGAdlpvP3q
         LdjaIE5eRd7bJqDeBzFvYmFEC1uRw7gtVPy28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XLwG7XRfre6R+aQSdeErC+1iFRSY828R4VD71xP5o0w=;
        b=eggO/EkEYygjiSYgCacx2zMBNLLflkjw+qxmuJiZ23HiB7iDh80hGJLYEe2qA5P1U1
         ZGgCexkFQ4iw242PO9dEBsXbIAPOi9rTT9pxTSX3PlCoCBnDh0aNU/7lVcsw6Sm8RiYY
         vzYry6V+h7woCA+gA7dfYl6iMtboMOjKOQlqzTHdc0lXhboe7GTWT0XalkaHq0qr/Bsq
         6A87ZnZtsKv/eQO6iGvqVk6YE1Vb3HsRTFZYvYeZ9+7cQZi+4humGIiWaJxy+z4OVpsJ
         iPYJwvKbgQjBHyLSjPw7Bub97hrAX4+UggUUTGOZTY4lgo0IacSRwI7alqbbWJPDrd92
         kTfw==
X-Gm-Message-State: AOAM530vheOtP8GRZGA1Nn0p4Y8oSrlmeQwUfIFlnmKc4SzEVRrKKeYc
        zH2mJbNxxGrL/qEykLFEp3qkIgfE9YeSNg==
X-Google-Smtp-Source: ABdhPJzivBEVN9pJF+YeJqeoaLhyI85GbGL/0qRS9Y5rLC/zDWRgTEerETio7ZlsXLA7FE9MoLWzVQ==
X-Received: by 2002:aa7:c79a:: with SMTP id n26mr14887264eds.350.1642436295531;
        Mon, 17 Jan 2022 08:18:15 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id s4sm4147652ejm.146.2022.01.17.08.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 08:18:15 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [RFC PATCH v3 4/4] mtd: rawnand: gpmi: support fast edo timings for mx28
Date:   Mon, 17 Jan 2022 17:17:55 +0100
Message-Id: <20220117161755.1863579-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220117161755.1863579-1-dario.binacchi@amarulasolutions.com>
References: <20220117161755.1863579-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v2)

Changes in v2:
- Improve the commit message.
- Move the patch to the end of the series.

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

