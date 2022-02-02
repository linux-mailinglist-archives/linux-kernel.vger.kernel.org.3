Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887604A7330
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343976AbiBBOeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbiBBOeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:34:19 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCFDC06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:34:19 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id e28so18959117pfj.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 06:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=16vqX60UmjqWNFm7zG92JTmfSodESNq7kHVS1cy34iA=;
        b=pIE1avRsIxoQ5fVb4NSUe2Fxzd41PZOYVQWoiDsv0TjH20bhHYZ6DaMZU98/la6pab
         Ys6Qj3meDpkxL4odhvTHC3NKoSceGl6HCEEbjCFCljQyHx5pq0eXnKt4rhvwLEM0WPdN
         jxHZWknT/IImkOgRBUgIUSkYo1p5IUWAten8PDNxyfwCOk0eIpxZlep6r6Cv3FkTx58R
         WtJuO/aQKel4Hjwnsn33aCyWIn6ru+9Fc/xQZ459ZpfYNxVWtVIg2Gi0IwMANRRV4wML
         QMzxLkfQltwAIg0/1hSHN0+y8MX9A61/sDEgQ5LaKetiS2+zr6uC64oWPnFzQ3mwsGs8
         mgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=16vqX60UmjqWNFm7zG92JTmfSodESNq7kHVS1cy34iA=;
        b=0Xdaz4yFL4UWdGi6w4IRUv5YIDSuGDTPEGrgrMECWWTnJldHv6l9Qlk9OqYLp7HDIp
         T+ujTGU2jwn0+Pd1jnH5iwm8zKGedeCJRaSRxcPzWoJkQ1SCIa7pjKX40GjAexBSIyKu
         b5V0+Lx8LvPOcJ/crsnumEKFwmrFNTXO/M/8uhwstW95S+HbgRvjuAlCDdcV13pYbwCQ
         8pSednRJCKAVqgSqtlb9Lc2awiAbnMJ6C0R9dE18iJ4amhXelAi+26qTpHbksoZR8ViC
         L9it/0DPhC9aOGLQ1MAGIcZSVn4fJLT8t55aP1qgaiP/t30T7K3V8eA8IE9s96UZVsqZ
         GPlA==
X-Gm-Message-State: AOAM530sTl32bUxPm4tN08GZd2Yiw5t4BiaQAy8ey1BZxbAN70my3YuW
        CP5IzKJQ36QSiMJ1DkK4qOxpZf450Kq0dQ==
X-Google-Smtp-Source: ABdhPJxOdQap8/4HoWdm4i8JqHFqRS1d4ylTDNP39+aW3pX5NvYo3r+I5ODTVwdlAGTqeidAEK+lQQ==
X-Received: by 2002:a62:7650:: with SMTP id r77mr29703773pfc.85.1643812458488;
        Wed, 02 Feb 2022 06:34:18 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id s9sm29079268pgm.76.2022.02.02.06.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 06:34:18 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 0/6] Fix some bugs related to ramp and dax
Date:   Wed,  2 Feb 2022 22:33:01 +0800
Message-Id: <20220202143307.96282-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1-2 fix a cache flush bug, because subsequent patches depend on
those on those changes, there are placed in this series.  Patch 3-4
are preparation for fixing a dax bug in patch 5.  Patch 6 is code cleanup
since the previous patch remove the usage of follow_invalidate_pte().

Changes in v2:
  - Avoid the overly long line in lots of places suggested by Christoph.
  - Fix a compiler warning reported by kernel test robot since pmd_pfn()
    is not defined when !CONFIG_TRANSPARENT_HUGEPAGE on powerpc architecture.
  - Split a new patch 4 for preparation of fixing the dax bug.

Muchun Song (6):
  mm: rmap: fix cache flush on THP pages
  dax: fix cache flush on PMD-mapped pages
  mm: page_vma_mapped: support checking if a pfn is mapped into a vma
  mm: rmap: introduce pfn_mkclean_range() to cleans PTEs
  dax: fix missing writeprotect the pte entry
  mm: remove range parameter from follow_invalidate_pte()

 fs/dax.c                | 82 ++++------------------------------------------
 include/linux/mm.h      |  3 --
 include/linux/rmap.h    | 17 ++++++++--
 include/linux/swapops.h | 13 +++++---
 mm/internal.h           | 52 +++++++++++++++++++----------
 mm/memory.c             | 23 ++-----------
 mm/page_vma_mapped.c    | 68 ++++++++++++++++++++++++--------------
 mm/rmap.c               | 87 ++++++++++++++++++++++++++++++++++++++-----------
 8 files changed, 180 insertions(+), 165 deletions(-)

-- 
2.11.0

