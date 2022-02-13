Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032354B39DA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 07:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiBMGmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 01:42:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbiBMGmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 01:42:08 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D045DE45
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:42:03 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id l19so17924343pfu.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GLtGzCbeMg/qgbKDDCf7XWab2gZD78AfYQXR9n7ELa8=;
        b=HNwlDyGl0139uKx7mMf20bh413PTnzikv89/CepT7QqbUy9gBYJQwlpteBkcgGTE1e
         fwDsW+Zy2ANnzxo9ZeZjzCaDQQqInlDUVEz/0FOHv7ZaTlfFy83nWhMKftDQgOoqLZsL
         M4U2JhjPzlrMJmI/AuksJo9e33QLtf3eXB47yV5KU0s+L+mabXrjg6v2/clVQJQOnwUP
         lYJprnQfrzVJWcXh2c63Xa2cTqNu4jKWumDHYbXIDzcMPvukBVQNxv1YM+sBt+IXXnec
         mHX9fbp2MOhAfni2gjxb2eud1XsejhTDzrP+Px7sx+W3uTfSzzkkp2IVzFNyV46r7hd4
         oDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GLtGzCbeMg/qgbKDDCf7XWab2gZD78AfYQXR9n7ELa8=;
        b=2Goiuq7My5rTjfUFsMdnZi2M3avnzzrabpA7hSXQAbr/gAqvpAEHcgNGxhqBoR24FN
         Pq9MnloJILUfzXgwhgUTynqRN1/yrXOPcuIB+2RQSuXzNu0OFkauxP+wPDnUXSb8VfOg
         ifvGmMCBJ4qggOm+wIWTOK0n+4Dw2TGwMqpGk8LPmynv2r8A8GNrxfE0HoUD95Zu6l5X
         QrSd9hFmKSOxTqA86ucanABIPDbwngBheKoB67w7mOhBghuJdjB8/w3OKKBE/sONK578
         gkCGknJYWutKAGnUjSzkB5BPdgdEKxmu0vhofH2eaDXK5OGASHoIe6IiCXU2Rkpp2RME
         SmWg==
X-Gm-Message-State: AOAM533OjXznG5rS1gZepNiyEzJtDyBeGD3zSf4jPW5TcO8zBtVhgpre
        Vql4RxbMcVgEaGsjCBIGvRw=
X-Google-Smtp-Source: ABdhPJyJXzBMzoMunUfpRtqtr+uHskJSD4+WqQuAMDp4sG32t2Ubv0IbDnqIexPDX3typstIYzyBsQ==
X-Received: by 2002:a05:6a00:15d0:: with SMTP id o16mr8802460pfu.19.1644734523050;
        Sat, 12 Feb 2022 22:42:03 -0800 (PST)
Received: from localhost.localdomain ([240b:12:500:6500:d566:8d88:e4de:7a25])
        by smtp.gmail.com with ESMTPSA id h4sm32117786pfv.166.2022.02.12.22.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 22:42:02 -0800 (PST)
From:   INAGAKI Hiroshi <musashino.open@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     rafal@milecki.pl, baruch@tkos.co.il, hauke@hauke-m.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        INAGAKI Hiroshi <musashino.open@gmail.com>
Subject: [PATCH] mtd: parsers: trx: allow to use on MediaTek MIPS SoCs
Date:   Sun, 13 Feb 2022 15:40:44 +0900
Message-Id: <20220213064045.1781-1-musashino.open@gmail.com>
X-Mailer: git-send-email 2.34.1.windows.1
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

Buffalo sells some router devices which have trx-formatted firmware,
based on MediaTek MIPS SoCs. To use parser_trx on those devices, add
"RALINK" to dependency and allow to compile for MediaTek MIPS SoCs.

examples:

- WCR-1166DS  (MT7628)
- WSR-1166DHP (MT7621)
- WSR-2533DHP (MT7621)

Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
---
 drivers/mtd/parsers/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
index 337ea8b9a4c3..23763d16e4f9 100644
--- a/drivers/mtd/parsers/Kconfig
+++ b/drivers/mtd/parsers/Kconfig
@@ -115,7 +115,7 @@ config MTD_AFS_PARTS
 
 config MTD_PARSER_TRX
 	tristate "Parser for TRX format partitions"
-	depends on MTD && (BCM47XX || ARCH_BCM_5301X || ARCH_MEDIATEK || COMPILE_TEST)
+	depends on MTD && (BCM47XX || ARCH_BCM_5301X || ARCH_MEDIATEK || RALINK || COMPILE_TEST)
 	help
 	  TRX is a firmware format used by Broadcom on their devices. It
 	  may contain up to 3/4 partitions (depending on the version).
-- 
2.25.1

