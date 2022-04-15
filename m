Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5A501F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347928AbiDOAQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347921AbiDOAQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:16:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254B974846
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:14:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h82-20020a25d055000000b00641d2fd5f3fso5232948ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XrMml7qKUkK/vfRO+Yh9HesyPHxDc4iM4I0XZDhBTs0=;
        b=NOCt70nhWy1emhIvsudKXkm4pJsO2JlwqpGNAW593FYdxY46MUU9gMxIC1thIfmwFq
         2yJTcFGDzWQLAn1FLyW19CMYYSsnhqt4HASAriTHBwL5szrjXnClfPOhyi1ozVCQ/YC+
         cN896HhGn0hf55j8WigJsjtz3EBg8p0sAwhg9rJsEd2rneuZ2gbzhOyCIADBu5eN5/j8
         Yd8JxQlSC8Q0VVyGq1jqAoE5UH2XrRzFbcHO08wxLp2xhklKU8jW6cvU0hWfqXOyTynp
         ltgIvcpB7DLWiXOJJsQBVKG1MZ3XRsLZrghodhDc8qNSCvH/o+HnDlz2LPIjPFm9XYHe
         d9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XrMml7qKUkK/vfRO+Yh9HesyPHxDc4iM4I0XZDhBTs0=;
        b=EAVEsntTD6yk75DtWoAivcWJ7abwH1zKoTwiRNSUVlhgGGglzZtBZx6G7K0534bFne
         FBs7F2My5b0Lt0ZqLf2hh/cJVJNqzfnPfmtBeo2R/zFEiMDQn5qFTVdLZRA4VhzHHqd3
         1woHJOks+8i65+b9esdkX60ePNFL4/MeqzRw3P7LCMsDHp+jY1w5lnv5mIFzl+p70gp+
         +f8l16HQL0pdWBGcMwSBWYh8P7VL6ptHx8rp5xDhBcR8YTHQ206XLS2UeaPCbbmPoVy4
         RfiCwV8cwkoXp0t+xFUmWLed4Q8tyEgNRVdK1OB9buVm6otU7L9lno0OzBK4KI2Ilw74
         Kr6Q==
X-Gm-Message-State: AOAM5313yi4Lh1gXaeP8gkrLweCoQoSXXAtjDAyWjvAUK8ehgzsFsQir
        AcICbuWK+YdEK7RU8Gy9XuKu9AVKxbdw
X-Google-Smtp-Source: ABdhPJw6OIlBScgMItG1ez9NzljktXTkxPDeFx6Lr0saWhpnJFjwgeDN+52OvPjR0WJONlvR/kqFmQ7v1Pyg
X-Received: from pigloo.svl.corp.google.com ([2620:15c:2c5:13:7d77:8cae:9dfe:95c])
 (user=jmeurin job=sendgmr) by 2002:a5b:8c8:0:b0:641:e8de:a6f4 with SMTP id
 w8-20020a5b08c8000000b00641e8dea6f4mr3814847ybq.533.1649981644388; Thu, 14
 Apr 2022 17:14:04 -0700 (PDT)
Date:   Thu, 14 Apr 2022 17:13:19 -0700
In-Reply-To: <20220415001321.252848-1-jmeurin@google.com>
Message-Id: <20220415001321.252848-2-jmeurin@google.com>
Mime-Version: 1.0
References: <20220207163409.19c3bc4c@xps13> <20220415001321.252848-1-jmeurin@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v3 1/3] mtd: mtdoops: Fix the size of the header read buffer.
From:   Jean-Marc Eurin <jmeurin@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jean-Marc Eurin <jmeurin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
2.36.0.rc0.470.gd361397f0d-goog

