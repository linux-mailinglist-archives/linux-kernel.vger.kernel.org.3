Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6276535055
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiEZODF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346294AbiEZODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:03:02 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F0F2CDEA
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:03:01 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id e11-20020a9d6e0b000000b0060afcbafa80so1054245otr.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xER5qd7NDHJpu21bf/QgYTxPeVwPuTdZeetijhnYaKY=;
        b=ZoWSLfhYUiiK/8XkSqjEkby5wMNctocjGlTkOpdBbIO1QaY2vum16sC1gBdHNgGi1Y
         ShUiHX6hftTluYaIeyEL6M0qCsKv8i2OeLLEYj3i1osUSfR3KnPfmw9vfsJxk7auMaI6
         grK6pROBi7PdUTDh+pFse6U6Vqp+PyQ5U8PISz5X6bTNlzSRmmySssOM6vbqrxYFSgNJ
         3vr1nWyHDuaQh29Vuc3akSyTStHPapH64avS2ANCf50u3b9dTok0m39igRkOuScJ2ZpI
         Aet9KTTabL8vg3+QubWRsNBo2pE3PXA+pUO9NeUWmUu7AAkVNnvD/e6TZF1H8/8Waukl
         N3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xER5qd7NDHJpu21bf/QgYTxPeVwPuTdZeetijhnYaKY=;
        b=hak0WE4+MAgjy1GpdSS7DlLhneKCX1l7AEJvZbmTOpl0BBIHYGOrvoD7VAzzLxhduU
         FodVKNP6guMwXMt3+qe0ZU82Gqem9BxcQ7cXT8++ps1B9+S5BTJ1dV8e4JpucPiN+tg0
         0pq37/JvgwtnSYnSiAQt1QSeB0eO/p8t0uh49QJtwZYrlZp7HvFX7IAcdPciRx9cYLcH
         p3xoG9FmkCFnm6dxceq6yBS596N2Vq5VgqO21yYwB8ozXbjBBeJQYKKnZ/9KrPnNRKwG
         HKnNapWXabvqaFHXZ6vUX1m9dGox4B2nTDCz4O/DAJ2lWpwYC4+NpPnh3H/v4W5ah2jF
         ov1w==
X-Gm-Message-State: AOAM5317yoDlszmrKPrkHr8QgBTs6BIZGrwOWcZHnjTeVrKtY/q6icIO
        Dd//Yq0bYnQsTKZd6iaDrDM=
X-Google-Smtp-Source: ABdhPJw8h/iNW2cKl1ZPDKdZeuN5zOsSrx6KZwv97+IoAil0hgyghxwN2if3xWRvFuhrS9M2ZLr6bw==
X-Received: by 2002:a9d:479a:0:b0:60b:359f:db6f with SMTP id b26-20020a9d479a000000b0060b359fdb6fmr2839841otf.67.1653573780601;
        Thu, 26 May 2022 07:03:00 -0700 (PDT)
Received: from localhost ([199.180.249.178])
        by smtp.gmail.com with ESMTPSA id b18-20020a4a9fd2000000b0035eb4e5a6b8sm679673oom.14.2022.05.26.07.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:03:00 -0700 (PDT)
From:   bh1scw@gmail.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Fanjun Kong <bh1scw@gmail.com>
Subject: [PATCH] mm: use PAGE_ALIGNED instead of IS_ALIGNED
Date:   Thu, 26 May 2022 22:02:57 +0800
Message-Id: <20220526140257.1568744-1-bh1scw@gmail.com>
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

From: Fanjun Kong <bh1scw@gmail.com>

The <linux/mm.h> already provides the PAGE_ALIGNED macro. Let's
use this macro instead of IS_ALIGNED and passing PAGE_SIZE directly.

Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
---
 mm/sparse-vmemmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index f4fa61dbbee3..49cb15cbe590 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -200,8 +200,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 	unsigned long next;
 	pgd_t *pgd;
 
-	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
-	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
+	VM_BUG_ON(!PAGE_ALIGNED(start));
+	VM_BUG_ON(!PAGE_ALIGNED(end));
 
 	pgd = pgd_offset_k(addr);
 	do {
-- 
2.36.0

