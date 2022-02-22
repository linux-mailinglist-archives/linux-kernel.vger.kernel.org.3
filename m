Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428D84BF02A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 05:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbiBVDVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 22:21:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241390AbiBVDVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:21:09 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A82617065
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:20:40 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y11so10596276pfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RfVO0n5bxGhQlU0yKBog2OCZbfoJHnMeC+GhXjg5mv4=;
        b=SH76wCmHAE4xRc5mXtEW+6VYb3V3K1zqQ494/IhTi3jJbNKEvFqAOjhvl6zaS6dexo
         YLbyDtZIEwGpnaCrvizwyDLA4Rqf7zWTg01HzLXJGqQrKWW+kHr6lpukA2KmqfhVy4jN
         OFlLQFJt/I2Iut7OUqHd3dKuTddkZnVACvBzjAb5wRtyom/Fvk9vxEF3qmO8cHvuI0Xf
         YoFv0LjI33Jfa9X8pOM7qA8uPoiA5QoNCgPrahllfKIwN8iZMEJXInPCqAqWiN+9Meq8
         9sk+GQHUJ8zCOUAbQYSxEGOm4RG3kNlkQU7SrRi+BCekHUGX+QTb96Q1aNS82CnkDFfv
         N8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RfVO0n5bxGhQlU0yKBog2OCZbfoJHnMeC+GhXjg5mv4=;
        b=5sLPzPyHNmC/qKVji4DG/mfqcdRReXMFbU7cjhlWfVHMxsCFgQ6D6goCCorw2OI729
         6v9A8DC3uHz/Du3RFFnhs7XTH8GGyKc6OAu9jiJkdz5qCduflfEFmFnOlN/Cmd0bgcL4
         U072N0p0MjdTgq0NbwAJlLiWLql5gi4hHZnElefnzXEJuXh1hYqXhVYvH/SyiMrys8lp
         n9lmr+GiDTtZJQEdsnRFn+f1dOJ5OgtyYLY/dw4qVPoREuWM9ncUA/2OpQIv+iqjpA+k
         +rr6FGlbKWwtV9tEDcbgmyU/3Cng8dcDmG2giDFkjvcJlFBsPqM9dpXDS7QHuhiGHfk0
         yBsA==
X-Gm-Message-State: AOAM5301ReQBR3+6aRxKcV6ZXRImGCfpz9Z0vf+zkuIOhAwQLUl/5IQY
        TUXD+GNqMh2bhvkTGOBz9oA=
X-Google-Smtp-Source: ABdhPJxvczvkokFGOaiFlyoYc3FwWVNkDJOfBNWtbgSpyWXBFuLXVkcpbqBoy7Etht8H+XybHJqfQA==
X-Received: by 2002:a05:6a00:1795:b0:4e1:6e1f:5aed with SMTP id s21-20020a056a00179500b004e16e1f5aedmr22837139pfg.70.1645500039340;
        Mon, 21 Feb 2022 19:20:39 -0800 (PST)
Received: from 7YHHR73.igp.broadcom.net (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id x12sm19068111pgp.25.2022.02.21.19.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 19:20:38 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     david regan <dregan@mail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 4.19] mtd: rawnand: brcmnand: Fixed incorrect sub-page ECC status
Date:   Mon, 21 Feb 2022 19:20:22 -0800
Message-Id: <20220222032024.10220-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
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
[florian: make patch apply to 4.19]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 774ffa9e23f3..2b02f558b5e1 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
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

