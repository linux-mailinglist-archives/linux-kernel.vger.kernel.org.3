Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4951150AC33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442678AbiDUXqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442682AbiDUXp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:45:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32243A18A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:43:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2ec060cffa5so57091347b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3fAx+rY6rT1xlegKzoz04pzJajlBuz++rECMCocuCig=;
        b=UbTvTm/eASLKfr2ec/HX9XZ4OkYPUdY+71Bz3IlA0uDoB0X9BFAvn+p4iLdDlKRJFx
         9cCZAgiYxIpayn1hBCEP4jMhUI5XFXwJlufnjyuXlxpYBNtFAdlB16M1+Ts5FmJn6pps
         SHiXEgSo02E7ja85rdFF2S8pJS8MNP+eyJz/wH22M4HlfymbkdbSzj0SeQGNKXOIZKP1
         a6EA/8dw59pmncwFnHPteR8oIUysF6b4ySqT2i3mxoescrrkF8TaFzoW05fLVfHByxBQ
         qWrfX8/asvPnpnt7OHWXErwa3rE710sh97MXhNWnttipmgfwMzC886GsMWbc1ADGu3dy
         uVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3fAx+rY6rT1xlegKzoz04pzJajlBuz++rECMCocuCig=;
        b=HXgs4AhfE7fqQm38e64VaWdihDK1R5qAKUMRIGZ/pr6gpcOLobgxLkx9OThsCqa4Zg
         /QY/UG/BEJvJXS902RRrmU4lcFDYGgM39jjIZsHrTmnuq0cdKPeya5ybQA7Avlnqtp/k
         YhjkxzFNF/o4j5j5/EACcvR3PBY997tbSRvBD0Z0ivdXHfa/YcYzZ0RTDGxCI23p61uR
         6Bs94D991077NIq88Pgwp7dIoF0/YzEuIWKjLIs/WPV99yNgA/d6jPg8N6jS9QWTYD5X
         d8DKDgjSjFLAE9I74WOI4FmRvetOjjBdx9sZ3pdc2qPzvsTD8pr/qO6qQ0NXFKyHmS8G
         U9og==
X-Gm-Message-State: AOAM532BHOMUdpy1g7xnL79JXo/5eQwJKmsyZnTrfc2fmBJEZRxra8sP
        ym64V4mtxbPHhGhvVdzWmrSdboNkcHsA
X-Google-Smtp-Source: ABdhPJymA2xC8NqGbX5ElL/YJyaxfLAfOURTWcSJhoZtPTGmOJlQtMG/mqzIM5XVcsfzDKTJGsHAs+ZS61jP
X-Received: from pigloo.svl.corp.google.com ([2620:15c:2c5:13:fcea:37a0:4467:e04f])
 (user=jmeurin job=sendgmr) by 2002:a0d:e8d6:0:b0:2f4:df67:6dc3 with SMTP id
 r205-20020a0de8d6000000b002f4df676dc3mr2319812ywe.57.1650584587154; Thu, 21
 Apr 2022 16:43:07 -0700 (PDT)
Date:   Thu, 21 Apr 2022 16:42:42 -0700
In-Reply-To: <20220421234244.2172003-1-jmeurin@google.com>
Message-Id: <20220421234244.2172003-2-jmeurin@google.com>
Mime-Version: 1.0
References: <20220415001321.252848-1-jmeurin@google.com> <20220421234244.2172003-1-jmeurin@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v4 1/3] mtd: mtdoops: Fix the size of the header read buffer.
From:   Jean-Marc Eurin <jmeurin@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jean-Marc Eurin <jmeurin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The read buffer size depends on the MTDOOPS_HEADER_SIZE.

Tested: Changed the header size, it doesn't panic, header is still
read/written correctly.

Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
---
 drivers/mtd/mtdoops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 227df24387df..09a26747f490 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -223,7 +223,7 @@ static void find_next_position(struct mtdoops_context *cxt)
 {
 	struct mtd_info *mtd = cxt->mtd;
 	int ret, page, maxpos = 0;
-	u32 count[2], maxcount = 0xffffffff;
+	u32 count[MTDOOPS_HEADER_SIZE/sizeof(u32)], maxcount = 0xffffffff;
 	size_t retlen;
 
 	for (page = 0; page < cxt->oops_pages; page++) {
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

