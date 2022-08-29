Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4E55A55BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiH2Uow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiH2Uov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:44:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D674F1D7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:44:44 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D2ED56601E60;
        Mon, 29 Aug 2022 21:44:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661805883;
        bh=56t/P/UzpgnnweTlfOL3hudUR1zs7PONQt/DyaRaMG0=;
        h=From:To:Cc:Subject:Date:From;
        b=F+F5kD919uaV+N6QmLPLmUqAsZh38RTmqX8AjvekKvya1KLKDTk6SAue8XVe+d4u6
         HIBKezp12bUQtO2Wqm8EkKUbS48Y+jzOMzjLHnm4MxbdUD1xDWVJMLj1wSA2rEZGqr
         0563ATdHgaUy9lvDt4+7Ujmj+XIJuNbhgq+LUXjscZ8J4QSlQ/f26pfYZyj2RSBzfa
         mQ8OS6BsW/ZgBvLBniU7zxeLlwJA9z49iKLtYKf2LuTA3gq+4RIAAo3YVSP8tdsu9K
         zQVHKCbaw9uWJKkWK3yBKyrZ2OBlOgRBLdhVkHVAMZff4pIc4O8MOLjDStJY5RpzmD
         2v9Szr3OvY/lg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] soc: mediatek: mtk-svs: Explicitly include bitfield header
Date:   Mon, 29 Aug 2022 16:44:39 -0400
Message-Id: <20220829204439.3748648-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a92438c5a30a ("soc: mediatek: mtk-svs: Use bitfield access macros
where possible") introduced the use of FIELD_GET and FIELD_PREP macros,
which are defined in the bitfield header. Add an explicit include for it
so we're sure to have the symbols defined independently of the config.

Fixes: a92438c5a30a ("soc: mediatek: mtk-svs: Use bitfield access macros where possible")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 drivers/soc/mediatek/mtk-svs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 64dba9f830f3..f67f3e971653 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2022 MediaTek Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
-- 
2.37.2

