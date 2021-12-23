Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E6347DBB8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 01:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345586AbhLWAW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 19:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345544AbhLWAWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 19:22:46 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B654C061756;
        Wed, 22 Dec 2021 16:22:46 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t123so3693659pfc.13;
        Wed, 22 Dec 2021 16:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yy0dKp0QqTKRDDm+DzMuRMtHniPa8Xch60bze9ubGZk=;
        b=oiAcd/kTGkJc+314HWZKIChHC7+TT85eKuknVt2Qrl8fgIWwHb4HZLCou6kEMJC6dG
         kCTzfc6Kr6EpxJUfSYWl+8oE5OK2D8o+Nm0h7ql13+5TALigNZZeRApbq6regGDtSBBL
         YaszKtin8mMpaoJs9XguPE/UvrytJjv8GgNjG9pBw4Jmx+pzb4VTjgG+Y5dRnd5HYq0c
         fGXZPnXlyu3Wvifus+DHtjdqcGdKRPoWQeaChpnd6vrzgUjzwnnXkQpk3RubZWUdFXWn
         PwsLixClBkBVFpKtFCUFvDm4y249kx/F933+WTZWnCerksgh8P81xdJLIajz8hIJhlno
         fI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yy0dKp0QqTKRDDm+DzMuRMtHniPa8Xch60bze9ubGZk=;
        b=4ZD+EhFl21h/AoyWKc5XuRN/AdWFaF7F9m5BwnzHIrmkT+0rSe/WlLiez4LCLT8yz0
         yiQPhPeqD6iMPPyIVZ0dpZpDv4auIyj4f97afdSdD1L2sOkqCZ+QzXbo+HTF+1kKVGif
         vFWJknRXPVCQol8FQl5LVJT9O+ctJm4241/5s9C2hu3x3KX58zhDKS2nxHvMGzIvdyts
         xwYA1cP97HTT41HBhNoq6pYvaAkQSC7Pbc2aj93yZzxdzfqSYZMiq3euZjqgOi746AOj
         cdvq9aWLiFdPg7rH+hY53vIAz9Tot9Z5NnEsUhfin0BQ6ssG/PPnvBOD/je9GIGigEYa
         jdIA==
X-Gm-Message-State: AOAM533ywqmYP1jQwX+v9V40FN4Fl3Wd0HOJVzBiE8ZL540pZNroadei
        VF9MAL27GrIvCTmWH0fPllk=
X-Google-Smtp-Source: ABdhPJyEsAVWK4JWRbMSF91GaDuMQ+6a9Y/KzuHDIAlj+nme3qw1QD74G5FuOcQ6YCrjDXd27UQEEw==
X-Received: by 2002:a05:6a00:18a9:b0:4ba:d14d:88 with SMTP id x41-20020a056a0018a900b004bad14d0088mr158299pfh.59.1640218965581;
        Wed, 22 Dec 2021 16:22:45 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e24sm6720703pjt.45.2021.12.22.16.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 16:22:45 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-wireless@vger.kernel.org (open list:BROADCOM SPECIFIC AMBA DRIVER
        (BCMA)),
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER)
Subject: [PATCH 8/9] mtd: rawnand: brcmnand: BCMA controller uses command shift of 0
Date:   Wed, 22 Dec 2021 16:22:24 -0800
Message-Id: <20211223002225.3738385-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223002225.3738385-1-f.fainelli@gmail.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some odd and unexplained reason the BCMA NAND controller, albeit
revision 3.4 uses a command shift of 0 instead of 24 as it should be,
quirk that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 2f2aaa554282..2dfb94c4cc93 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -908,6 +908,12 @@ static void brcmnand_wr_corr_thresh(struct brcmnand_host *host, u8 val)
 
 static inline int brcmnand_cmd_shift(struct brcmnand_controller *ctrl)
 {
+	/* Kludge for the BCMA-based NAND controller which does not actually
+	 * shift the command
+	 */
+	if (ctrl->nand_version == 0x0304 && brcmnand_soc_has_ops(ctrl->soc))
+		return 0;
+
 	if (ctrl->nand_version < 0x0602)
 		return 24;
 	return 0;
-- 
2.25.1

