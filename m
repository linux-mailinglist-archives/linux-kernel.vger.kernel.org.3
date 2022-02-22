Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B443C4BF0D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 05:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbiBVDVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 22:21:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241420AbiBVDVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:21:15 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008CC193CD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:20:44 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id i1so629204plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=It4RGSp99XFUqiUGEzXdClglbEaTDz0QTVwNHQyEiwQ=;
        b=cx1GruLCUFuWF7dtq9M4B+SERi38A8PQacjrwesId9ucpYxtjotiSzO4viRRv/JP9Q
         WcliL46uWLjYbOHMp+awY+Zu8CwIsXbs08iczmte1LLIbhx/rVIs1xBNfQxd3zHMp1kf
         ruTlt0V03qjcNf/gOL+XRYE2XWl46F1iNfxUKqyAukgmj/CISyiaBYCjIQCU0g+EYOAJ
         eJVVn0n2/RggnLnJwa+xxclZuueEhw1NOuEtAEaQhrDtVeviQE1ej7iYbTFlruvdnffi
         2jIH7zDmfdnfguTInXU/gQpev9UgrtfQ9yim4Bfk3Ef3hVZ/OthgdtsiAdW5hvUfMgN3
         A9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=It4RGSp99XFUqiUGEzXdClglbEaTDz0QTVwNHQyEiwQ=;
        b=0lgTQ4bogAkpfMBAk4iNlbfZuc/nakazbB6ERFVB5QDIuU0dIlFINgP/lFXZegrnZt
         BQbWaBAisPNeXMnHeITXl9/53HsJNz4VuuBGC3/RRVx8hpV9NyUNQJn+owFCdXsxPG6Z
         MbNCuiUxNn7vV956NIoQULb0lR3IJSfxSoQksVRtIbhVj2eEgMfMsrn5WoUfH3b55Ivx
         Rfo32vkrKrp0Z4BR9pJQ77410DSgPOl9dU9/YoeRm1H1Vkh7iG84SYYqvieTkKq48ruE
         qmGpPSPx/ZI1RLG5goAq1kHfOAgyUOZKw+sqniLr/bLjna5Lq5oUAkg/Tx/IXcRAliSr
         3JNA==
X-Gm-Message-State: AOAM531jTT/XU4rkb7lReKl/pGzM/CEzwlL6J9DhVLBOmWJRSUAEy7/l
        0hV5YSZQtGKx1DBLUF9pNk8=
X-Google-Smtp-Source: ABdhPJyoHG04LqVY1IevXNqwDu7zqZjBOqBAtL3B6R+NdFZG6EVXz/I5pqamqF9ZVV7eGCHSnCWYtg==
X-Received: by 2002:a17:90b:3a85:b0:1b9:e751:2335 with SMTP id om5-20020a17090b3a8500b001b9e7512335mr2020652pjb.43.1645500044463;
        Mon, 21 Feb 2022 19:20:44 -0800 (PST)
Received: from 7YHHR73.igp.broadcom.net (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id x12sm19068111pgp.25.2022.02.21.19.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 19:20:43 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     david regan <dregan@mail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 4.9] mtd: rawnand: brcmnand: Fixed incorrect sub-page ECC status
Date:   Mon, 21 Feb 2022 19:20:24 -0800
Message-Id: <20220222032024.10220-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222032024.10220-1-f.fainelli@gmail.com>
References: <20220222032024.10220-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: david regan <dregan@mail.com>

commit 36415a7964711822e63695ea67fede63979054d9 upstream

The brcmnand driver contains a bug in which if a page (example 2k byte)
is read from the parallel/ONFI NAND and within that page a subpage (512
byte) has correctable errors which is followed by a subpage with
uncorrectable errors, the page read will return the wrong status of
correctable (as opposed to the actual status of uncorrectable.)

The bug is in function brcmnand_read_by_pio where there is a check for
uncorrectable bits which will be preempted if a previous status for
correctable bits is detected.

The fix is to stop checking for bad bits only if we already have a bad
bits status.

Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom STB NAND controller")
Signed-off-by: david regan <dregan@mail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/trinity-478e0c09-9134-40e8-8f8c-31c371225eda-1643237024774@3c-app-mailcom-lxa02
[florian: make patch apply to 4.14, file was renamed]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/brcmnand/brcmnand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index 40fdc9d267b9..1c8e95cf29d2 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1637,7 +1637,7 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 					mtd->oobsize / trans,
 					host->hwcfg.sector_size_1k);
 
-		if (!ret) {
+		if (ret != -EBADMSG) {
 			*err_addr = brcmnand_read_reg(ctrl,
 					BRCMNAND_UNCORR_ADDR) |
 				((u64)(brcmnand_read_reg(ctrl,
-- 
2.25.1

