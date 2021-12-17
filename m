Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1874790B2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbhLQPzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbhLQPzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:55:50 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC0CC061746
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:55:49 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x15so9601425edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pCjPRfOE0ubdFKl1wroT8qZZ50obE6oG33Hg0XGM304=;
        b=GT7+ilekxSTS5dFNut7H6CiyF+s4HbxoxVMua+CSJLqW+fj8bgZ36r7laPoZzjTKVO
         /0ZsMq4hFsukMP44g8xdxWMyJ84oewN+Pqh49hxeu7h8jm/FApB0Emn134cSqYtoUf+Z
         PIca9tyY8AbC86kn8KUvHaTa5CHPRYorzTGPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pCjPRfOE0ubdFKl1wroT8qZZ50obE6oG33Hg0XGM304=;
        b=tbOv+R+s41p8ijLbswx868McxYeVp9krgr8TgdSKatsAxmwSmB6z0pjfi6oiW/2Qaw
         fxMRL77pEGeBUX/Y4qSuwgr1I3Y1ran+w2XfgbMHmb9wwS2zN6EjuGVMyv0F7Tbmjk5D
         xoPx2/5s8YPK95jm7/1VKA3bqgoyyoXI/7tzttMQ7F0FlUIE3LzGd0e64FfRMmP8Xoto
         iKomUIjtkLrZYX6j6Jtxe4CfEhYZJP57P1pTuFcLM/TQZWy+VFkuotC7jQ91eON9QUUy
         A0I4sLkFfXkSMAk9Jkx8AyBHDizHhiFa63rcO/6ELKLDc+Nld7MdrCWM/cYPUyAFeq48
         t8Pg==
X-Gm-Message-State: AOAM532nsMzCVLhNt1qOhvmyNr+s9e0hRRbluK+H0oP7RLgMJ1CAdLdL
        ji8iVBLNHn0N53Lq6PtxuPUMPP0l4WQOKA==
X-Google-Smtp-Source: ABdhPJwq9J1DWJQ8i4E0EiIDgAaMs/AhSQZcnTaJ1HC6l3gTEc24oM/ESRtaqP0UYIOPboiOppaXCg==
X-Received: by 2002:a17:907:1c81:: with SMTP id nb1mr3125382ejc.9.1639756548087;
        Fri, 17 Dec 2021 07:55:48 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-79-56-50-241.retail.telecomitalia.it. [79.56.50.241])
        by smtp.gmail.com with ESMTPSA id i6sm772158edx.46.2021.12.17.07.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 07:55:47 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [RFC PATCH 2/4] mtd: rawnand: gpmi: support fast edo timings for mx28
Date:   Fri, 17 Dec 2021 16:55:10 +0100
Message-Id: <20211217155512.1877408-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211217155512.1877408-1-dario.binacchi@amarulasolutions.com>
References: <20211217155512.1877408-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the mx28 reference manual there are examples of how to set up the
GPMI controller to support fast NAND EDO timing.

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

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
---

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 65bcd1c548d2..fd935e893daf 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -772,8 +772,8 @@ static int gpmi_setup_interface(struct nand_chip *chip, int chipnr,
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

