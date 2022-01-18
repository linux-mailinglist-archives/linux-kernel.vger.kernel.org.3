Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E55493178
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 00:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346581AbiARXwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 18:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiARXww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 18:52:52 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3C2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:52:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l16so799446pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/RjK8BN3JSAYkOl/QC9o65LtcnAhU3UXdD1BgVr6Dc=;
        b=I3JK5GxKJNosEutNRJEjnFEOYFwZ1QUsNrU8p+R6GhPQVxZou96OUTOJJJNUYvUXlI
         djYqsWuuEpIwlotwaIt6WThuRViY62QjMtOAC3oESQLeE07JPBa7iENB1R8NVtCdVozp
         KPhBoyoOoL+vLpnNDQRI2pTsZRefcPiWZD+vMtgXegOqwK8dmBlhC1pKrzn2n33WalQ6
         u8I5lEIHn3e2WkVkySHo1yLDA/aqfeiJdTWy/oT2R7IK5/7BoD4gUBn88IlHzHMIwl5L
         tFptvPjevkIe/BK90fAKEO/eaOhkO2+zfCLCyHh4/USxnftehM/1SGXMrANgce6HlDQx
         gWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/RjK8BN3JSAYkOl/QC9o65LtcnAhU3UXdD1BgVr6Dc=;
        b=XU4itxMmpEYHHlBB6hTt1PN30WsDz1FkIwIAjrY/uUesJRCIuhtrH9Kv5yBPIB7CEL
         qiKGSHENo+NJ+mf22ifKgh2Cm+C88PwrTmd2QB1LhSqjzZWUL0pXuibdLBO83uGabTne
         URdLfCHBmUnuk1dlJ7niUVnqD3sdMjGSLA66vha9Azr5EsY5iov3/WDfLyHkaHCqIo5n
         OIX/ahy386/UpKDb7ogLLnynOKevk5PHnZpVp8zUZqMIOmPtocIvkqdQNFBtkmDOPgUe
         bkrCBkIl9YFv+TTG8BpscSB2OboyYOWqmPugHsNV+150xOsrfj9+sw94ddWFzYQjSF/6
         2HrQ==
X-Gm-Message-State: AOAM533AhZmdL29BWAQ7+4x1DyOx7E5X++gnv24pFW2cXKWW09k0L1Qd
        hdRuiDHzMZYswFjThb3CzUs=
X-Google-Smtp-Source: ABdhPJxiD2bVrhbvfdZNgIib+nJd6p1sFBUR9Rc3MGJm0eXE85gtCHvnl1zU6KKl3ctqvAbPK7LMAA==
X-Received: by 2002:a17:903:32c4:b0:14a:67ae:3e03 with SMTP id i4-20020a17090332c400b0014a67ae3e03mr29666243plr.111.1642549971771;
        Tue, 18 Jan 2022 15:52:51 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id h4sm18962329pfi.79.2022.01.18.15.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 15:52:51 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] vmap(): don't allow invalid pages
Date:   Tue, 18 Jan 2022 15:52:44 -0800
Message-Id: <20220118235244.540103-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmap() takes struct page *pages as one of arguments, and user may provide
an invalid pointer which would lead to DABT at address translation later.

Currently, kernel checks the pages against NULL. In my case, however, the
address was not NULL, and was big enough so that the hardware generated
Address Size Abort on arm64.

Interestingly, this abort happens even if copy_from_kernel_nofault() is
used, which is quite inconvenient for debugging purposes. 

This patch adds a pfn_valid() check into vmap() path, so that invalid
mapping will not be created.

RFC: https://lkml.org/lkml/2022/1/18/815
v1: use pfn_valid() instead of adding an arch-specific
    arch_vmap_page_valid(). Thanks to Matthew Wilcox for the hint.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 mm/vmalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d2a00ad4e1dd..a4134ee56b10 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -477,6 +477,8 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 			return -EBUSY;
 		if (WARN_ON(!page))
 			return -ENOMEM;
+		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
+			return -EINVAL;
 		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
 		(*nr)++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
-- 
2.30.2

