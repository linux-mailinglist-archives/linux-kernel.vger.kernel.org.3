Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B93E54E8D8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbiFPRsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbiFPRsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:48:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3D44BFCF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:48:49 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w21so2147439pfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gQUColGb/PRKYuEV4lE8XSFjbzf2io5XZTvMnHxGXf0=;
        b=H8066BRclkgv160HBGUSksGljw5jEx74P81Wyl7DeklPUcfVRAzzn4ytpohhWZvS6Z
         bpso2AnaKouGt/5mw84y3KUdYhbE9jmtHQatT9ICKrULazn80V2zMIJSCZPItFdRljXh
         H6aFJpbnfQughZDnUFhPMMhlzqd0YguP5GLK2+gCQuBe0X6KLNggSWTXUJR9bdZxcrR7
         WTTG+kcWkBdkQyWYbhl2priPPsi5ijjv+dcXEljTRUC2eP4QUXR4ZAyjeeVsvkurn61y
         TJjtSPV52f5tCl1bh01NNGhVozBWuNUlJ2X4U+VASX8ogw4/5DUTI2jK+RriHKc3J8IY
         DBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQUColGb/PRKYuEV4lE8XSFjbzf2io5XZTvMnHxGXf0=;
        b=hoZU+/ty5qt6LpnWlliR/M67JDM13QacYktHLUq54hwJ0c0LHbAMR5Ecl3kA8deO5k
         0b44LY/SLkauOuqS+QuBkGQkgQiYgEnshblnnlDMUw/Dp7PMIckUfmLXJ7mOFdViTIhe
         /6aPg3+dNxsdE06XBgb6EzWiPWExLLxFojqEIXSKzkPZF/yzwUckPOKBBukCyJNzXzHw
         ia3gizDICqAnhpr0Aln/D6+H8QDceJE+ox7nITDRnDNsIIBUdHokxTblHuG6Yzk3Kct/
         8nwO6cQDnzfd7PwTGp+4s+9QxHYx7GJeUsG9pd9PodlnrrWPWLN22962Wa50snjpxg0q
         R/HQ==
X-Gm-Message-State: AJIora/3DlQWSZJKZy4OYoM5xWaQc5Zy7xMPCPTVzMoYy2DW1HE7St1U
        4yyJ8aDmlqIJ+IgzESvSNFY=
X-Google-Smtp-Source: AGRyM1vVU3rKwXy9n+PUA6CJmwhrnakM7UqbwEUBt0tkabuU8YP6EHHL4ouJ2CBwwzJvSF9Zcj+yCQ==
X-Received: by 2002:a05:6a00:2392:b0:51b:fe0e:2b8 with SMTP id f18-20020a056a00239200b0051bfe0e02b8mr5799350pfc.84.1655401729182;
        Thu, 16 Jun 2022 10:48:49 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090a8b9500b001e8520b211bsm1818289pjn.53.2022.06.16.10.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 10:48:48 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, zokeefe@google.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v5 PATCH 1/7] mm: khugepaged: check THP flag in hugepage_vma_check()
Date:   Thu, 16 Jun 2022 10:48:34 -0700
Message-Id: <20220616174840.1202070-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220616174840.1202070-1-shy828301@gmail.com>
References: <20220616174840.1202070-1-shy828301@gmail.com>
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

Currently the THP flag check in hugepage_vma_check() will fallthrough if
the flag is NEVER and VM_HUGEPAGE is set.  This is not a problem for now
since all the callers have the flag checked before or can't be invoked if
the flag is NEVER.

However, the following patch will call hugepage_vma_check() in more
places, for example, page fault, so this flag must be checked in
hugepge_vma_check().

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 476d79360101..b1dab94c0f1e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -458,6 +458,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 	if (shmem_file(vma->vm_file))
 		return shmem_huge_enabled(vma);
 
+	if (!khugepaged_enabled())
+		return false;
+
 	/* THP settings require madvise. */
 	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
 		return false;
-- 
2.26.3

