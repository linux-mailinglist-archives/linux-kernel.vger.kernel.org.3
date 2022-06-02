Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D9253BE01
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbiFBSWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbiFBSWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:22:06 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998F19586
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:22:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e24so5668288pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SWErXY/21cRT+JuPcizRjGDN5I2BQSMNvqCbtDuuEgI=;
        b=OoXAfZEZ4MNYzgwa1mxiiNLYILQhuzvKYToutAR1jjUYvKsN/qDaq0gORFJAw9/cMc
         Swt3hbAIAH81YoqZPRe0tQShdki9kmu9D8ux7uQVtefn1LynwDEYYY4W7FQXp9cZiw6z
         RbDJFDdvFyH8GP+u4N4gMypVi6x6+gxi0ewd3+HgSj8ymzFH8MzRlbC/kzV13iEMGwmH
         Lp8clnYaxcOFH1CqANZ7k/LKzCNXs1qiY+fd9Yu1zJ1EjGGrcosgC5Xzvp2gBS0EHOpE
         5JOBXFQqT2zKdvyP2JZh6k9aG87muIeU40osHXul4peFUx4vhf4iBwzGpqaX2iKMR8AS
         Nraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SWErXY/21cRT+JuPcizRjGDN5I2BQSMNvqCbtDuuEgI=;
        b=xBMJgcNZFvw7L8M+bZ16UmCyHVf12L4OLbmDE/dMxChvf6G9M3zJbSH24jyM4Vd+XY
         ugLE0IkpLDn68wNrudmlddY5N/1TvUtkbh2Zx15tPcyxAsGTdIJhK/p2KyTSu0gr4ga1
         Hax04OxFldK4ja5TXzCfQQn8k5RH5Lur8DTWbgMlOWtQjoa4M46dvl6Axah9h2IFQpvl
         V+R0b7/a5FsQj4y7E7CmovPIN4Ko4wgJEhYEcgcSPOTRSHQaVlN9OiIcT1+6jmUruRTA
         c9iZkEaV9XX4X+KRRDr/5IisDNLMrk3rRmMlrgLyT6FL/SunnR9zXotb5FiN77975g1W
         fG2w==
X-Gm-Message-State: AOAM533D3AnahX1w5tauITNBiF/kWqCR4RS3dy8FbCl6upDstl6PSgs6
        Q5HMulzasyb+CdvDHQKKJ2I=
X-Google-Smtp-Source: ABdhPJzC7OcR42WCXQLvw7aP2hx+qZcdKxnU7F7jgc1gw7m3PVF8cbDihuLNflGU/XhxlYAkH0vxSQ==
X-Received: by 2002:a17:903:1108:b0:156:73a7:7c1 with SMTP id n8-20020a170903110800b0015673a707c1mr6113799plh.101.1654194125146;
        Thu, 02 Jun 2022 11:22:05 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709027fca00b0015f2d549b46sm3866779plb.237.2022.06.02.11.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 11:22:04 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 1/7] mm: khugepaged: check THP flag in hugepage_vma_check()
Date:   Thu,  2 Jun 2022 11:21:53 -0700
Message-Id: <20220602182159.248387-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220602182159.248387-1-shy828301@gmail.com>
References: <20220602182159.248387-1-shy828301@gmail.com>
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

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 671ac7800e53..84b9cf4b9be9 100644
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

