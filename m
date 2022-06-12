Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546DF547B75
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiFLSXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbiFLSX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:23:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE6B4093F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 11:23:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso6878496pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cNqVSGRpc6PfKoYS4rbiG4/6+kXDZAGCvWAhlJaU3Kw=;
        b=YMFisgdNLzZga7LeDHFsel0PBi2qjOzYKpzMdIhTq1aOANcikyWVofLJI2f9AMEjYc
         QPzj0+GPyGglElaRrF58vA3MILwmMHDRsXdEImkHYIeAwLw6ISjESX9EQA5QqogqOXai
         78Q6Gy0wPTO2Py5eLl0/KQcan4I3LlA1ZWr2CHqkY+S5c0gTqJMYZvNFNjezysU22r0e
         icyxWOq8gmkgoX4deafYBXV3o+VkADl5HyqNVjN5YB7fNp+mxrSijy2MXjTvvOUxCQp2
         dP8hQB6TwnHUXQn2AjKvKotwratXUDuaMlDFDaXu5wR7pprIhTLhi42fhkTmLbAtsc7B
         pzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cNqVSGRpc6PfKoYS4rbiG4/6+kXDZAGCvWAhlJaU3Kw=;
        b=6/xvscLmsTszo5Acw8Qy0dYTyPSUTR/FX2uxmYEPfSmZvOVcrDWSz0zqz+aMkEncHR
         oFZv+0a8gTchJRg12f45vrfROg68LhNZtz5YwSScN/+S4QsI45kGGI0NHFuOM2tSUvFx
         7m+PnOGlDlmS+qrl7KNW7xtAJdAHUbHcymyaMFNZUDpGCDCH8mC8k9d1I9KDRIMEbvGi
         TCbSdegwNqz+F3+KI8Kj0BNy6/954C2h1AXfljvKznEPQS/IfakZSqp4SZ1hzVkYTSrA
         ChKga9fKim2dfgooShS+L/H1/3LRXFdQ11Yiwq/hVMkWxByFYYHBK7vxPIm7Y5Gwk90T
         I5qA==
X-Gm-Message-State: AOAM530n7COWjKXgY1y00JD6uUjnYeae6rshInHZknEF8adrL3YuZ7Od
        IQLEX05vhneSC4TTQbm6ksw/EAM6utOkbWgJ
X-Google-Smtp-Source: ABdhPJzYmAUmYH3aWWXZAwMst6IYCfIpfDC8xFykWNs4Ly8KRfOCST6sCoeGaHejexQ32I7u5smTQw==
X-Received: by 2002:a17:90b:3b45:b0:1e8:8688:219d with SMTP id ot5-20020a17090b3b4500b001e88688219dmr11329466pjb.231.1655058206407;
        Sun, 12 Jun 2022 11:23:26 -0700 (PDT)
Received: from ubuntu.localdomain ([103.230.148.189])
        by smtp.gmail.com with ESMTPSA id e17-20020a637451000000b003fb0354c43asm3666322pgn.32.2022.06.12.11.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 11:23:26 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     akpm@linux-foundation.org
Cc:     Gautam Menghani <gautammenghani201@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Remove unwanted initialization in vmemmap_populate_compound_pages()
Date:   Sun, 12 Jun 2022 11:23:20 -0700
Message-Id: <20220612182320.160651-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unwanted initialization for the variable 'next'. This fixes the
clang scan warning: Value stored to 'next' during its initialization is 
never read [deadcode.DeadStores]

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 mm/sparse-vmemmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index f4fa61dbbee3..3008aa7859e0 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -737,7 +737,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 
 	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
 	for (addr = start; addr < end; addr += size) {
-		unsigned long next = addr, last = addr + size;
+		unsigned long next, last = addr + size;
 
 		/* Populate the head page vmemmap page */
 		pte = vmemmap_populate_address(addr, node, NULL, NULL);
-- 
2.25.1

