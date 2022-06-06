Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCA353F1DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiFFVou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbiFFVoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:44:30 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420E98DDCD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:44:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w13-20020a17090a780d00b001e8961b355dso1823630pjk.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 14:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TeR+saO9bGVSVDYLkT6whuJkztc98Y7uqJRw9Zwr6CA=;
        b=HKhirssn3eLksqebeSYrk+jXcfBxshfBpkTxjBPO9398Kqa18Cm3e71kgcZu26dIvY
         o6XXpciQWvJwXzV5TU9EluS5IVMmvxncZ5Mi/Vz+lQNfHrPN3rzLvi/l00C5t+Za+YHj
         YSPmh2kgWJ07k6J+1bq9EH3HdkCP54M7O6Vm/tRIEY34h4UfvDTYtD/vhvyQzncqUZA5
         lIVQRmQhGGRj5O6xWtvnzee96vGcj+iwnnmw/OVFSsrJmnCfV4t/Ft+pb31IkLeX0FcM
         9gByGWOdP6wH6PFe0kKeAl3/kjT4wP6BDTfJq8QgNMLS5uVGvXEfYFP0xTXUn4EZHlGi
         7T5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TeR+saO9bGVSVDYLkT6whuJkztc98Y7uqJRw9Zwr6CA=;
        b=NaZaUoVymyJ0OOmWeRKV2GIKUOLYlsR3I4CDlXSXbfwbCJO2nemnaz/iyWQwPTkkK7
         zYcbznfH//EFci4UxWgI84TrT8LADmw+rfU40CIlZ0QfqAKbwcyAp90MVrXkVzCCQ7WQ
         p1e6asTFwgK0I1ZDbx2Uywp1ed/bKiJZw/m1lHNGl+Mgn+QycreM1o9WhDeB11N0E1Er
         0aBaHlRtqKS4VpvykJxb6asiFzb4/0NS1aeJnDNF5nq7SqTMnlR2q0O/EOXASjWmvwS+
         i9ADGjqhLNIcN1J1Bpor5tJnEFZiW6yn9eGLMCSgeTxiuK1XJdJzn2DOp775MZD7ZMjx
         eNEA==
X-Gm-Message-State: AOAM532bU3VJONsRwaRWrDPBfWF+W1eNY3wu34z7vzHYlyxF2c2fU2bx
        PtcEogX1lN1Xy8aeo3mYJ8M=
X-Google-Smtp-Source: ABdhPJx+QgadWDwD5L0qXpqeZx6oasMAo4joDNR6AQwapxgpVmCIYIAdm45+392KvIhA5+qYQ6m75A==
X-Received: by 2002:a17:90b:4a90:b0:1e8:626c:e1b2 with SMTP id lp16-20020a17090b4a9000b001e8626ce1b2mr13173095pjb.141.1654551863738;
        Mon, 06 Jun 2022 14:44:23 -0700 (PDT)
Received: from localhost.biz ([8.25.197.27])
        by smtp.gmail.com with ESMTPSA id a4-20020a170903100400b0016397da033csm10881675plb.62.2022.06.06.14.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:44:23 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 3/7] mm: khugepaged: remove the redundant anon vma check
Date:   Mon,  6 Jun 2022 14:44:10 -0700
Message-Id: <20220606214414.736109-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220606214414.736109-1-shy828301@gmail.com>
References: <20220606214414.736109-1-shy828301@gmail.com>
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

The hugepage_vma_check() already checked it, so remove the redundant
check.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d0f8020164fc..7a5d1c1a1833 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -966,9 +966,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 		return SCAN_ADDRESS_RANGE;
 	if (!hugepage_vma_check(vma, vma->vm_flags))
 		return SCAN_VMA_CHECK;
-	/* Anon VMA expected */
-	if (!vma->anon_vma || !vma_is_anonymous(vma))
-		return SCAN_VMA_CHECK;
 	return 0;
 }
 
-- 
2.26.3

