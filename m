Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2344AD246
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 08:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348263AbiBHHgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 02:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347537AbiBHHgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:36:33 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ACEC0401EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 23:36:33 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y5so16517079pfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 23:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+K2+bccFd9pF7rMmuVPXnwO8vRc9g2LL3P0SAyHRK+Y=;
        b=bFLdHv8F7+IkS1x9FDn/nMVODlJJT7tS8ubDF8UDx/pizVANYbf4hTALtMblgdKSvi
         Bs6ulF74X72LHXWITBSbK6pj06RNvnAkAU1HzL7ZljKDm+4sI6FJI3cyLRMgdp2TDWdm
         hrdrUBgDHfwMd816/LLj56k8P8oUcVtWAHKGlvHIbXzjLp/pJYpcNj/2gG8rVgyWxLRx
         vtLIj98pvETsKnc/EGNRCXCn3TD9Cp29ZibqT+d6j5lK2YHFTgBaee6P1a+UpLVnnQmi
         2/tzh57k+C2zrp326yeImXKdYzf3ZeNtVnbbJRpn8BKY6aG+ok7WKYFMFUnJwGA/OxSQ
         qjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+K2+bccFd9pF7rMmuVPXnwO8vRc9g2LL3P0SAyHRK+Y=;
        b=ggtpKhiCt4pir4/UVHb0T4YVMocr4+fyiiDLoSwsbD0oKVsaUMN5iJBmBEaOXyE9EF
         DsxPeVHyDMnjxdwCWcZYSkxtvoEbZwTyBiA9H/LRogz0KKAv8baiT8zQo2gHfqHjGQ6+
         X5k2s9xYiROh5WfArUEJslKn/cq6cXfKJz3UZGp7JMvpu2T2TAsngZvvs9SJw13ajcNF
         kC+GNhbxYlG2zGtL+eaciF07CwtykP1nm4RmS+8o7DDrbglstQ9KQjti0H80jJAJiolw
         CCJSHWWu0z/LNDFQUS4Kxo0jJTNqfY9Tw5wmdDOfNvlHhG0Q/W1ehxvC9Cvt7bYl/CF0
         Lz7A==
X-Gm-Message-State: AOAM533J0oXzNc+YCm09ImM5LdqwYnjRvWTtLu0iRURoyTXSx9YC3qHX
        ZJ3aKkQY0dcqrSMEszG6SLb0RHx1Pw6z3w9s
X-Google-Smtp-Source: ABdhPJzQN94mbsB4pg/ookLcIVi0PGpPJ05QdCuBiqj9d+vG1wjRlnSDp86Lu6H9TJijxP+B9MCmBw==
X-Received: by 2002:a65:5c48:: with SMTP id v8mr2184170pgr.343.1644305792595;
        Mon, 07 Feb 2022 23:36:32 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id gx10sm1621017pjb.7.2022.02.07.23.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 23:36:32 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 0/5] Fix some cache flush bugs
Date:   Tue,  8 Feb 2022 15:36:12 +0800
Message-Id: <20220208073617.70342-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series focus on fixing cache maintenance.

v4:
  - Replace folio_copy() with copy_user_huge_page().
  - Update commit message for patch 2.

v3:
  - Collect Reviewed-by tag from Zi Yan.
  - Fix hugetlb cache maintenance.

v2:
  - Collect Reviewed-by tag from Zi Yan.
  - Using a for loop instead of the folio variant for backportability.

Muchun Song (5):
  mm: thp: fix wrong cache flush in remove_migration_pmd()
  mm: fix missing cache flush for all tail pages of compound page
  mm: hugetlb: fix missing cache flush in copy_huge_page_from_user()
  mm: hugetlb: fix missing cache flush in hugetlb_mcopy_atomic_pte()
  mm: replace multiple dcache flush with flush_dcache_folio()

 mm/huge_memory.c | 3 ++-
 mm/hugetlb.c     | 3 ++-
 mm/memory.c      | 2 ++
 mm/migrate.c     | 3 +--
 4 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.11.0

