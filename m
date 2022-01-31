Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1F64A4B31
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379990AbiAaQEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379977AbiAaQEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:04:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42680C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:04:01 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so14296171pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EdwjQ9O81xo0HbY8DB+rb28P0Ow/SLHwRSfgB0iNvbE=;
        b=0rSTva8PXDXQWYHFmrkLtPUojfACp2HQQZ4/HdJQPdOHCldzg6syLFpdKXlyOP4TT8
         CL1Fv5aI6o7zy6BwTiJ/I1B7VUhNk7o+Xz/WTfJAjIetm8i/NY++xzrA3UoS75I3dJPX
         Fyk8P+0Xha+ysuA/NwSsOFP8vknZVhqknjX3FWmsqeINPAOHlbIppp7QhgIob1vhHngg
         TYRyVHB8vuyD3qBLywaIN5fO+erezHi1h+VeKSVpHZ6PMPPW1ednc7EMi33F92MUGPpb
         HrzodO3s8n08aUkmZmavbBLvjlaS6qYMIfVH4TMktheP3+c5+rozge9oaApo0Ewzlrgc
         xnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EdwjQ9O81xo0HbY8DB+rb28P0Ow/SLHwRSfgB0iNvbE=;
        b=2qb+idCloNy16nkFIAq21WL611rOurvJdVPyf/drGQk552iRwanCvfHP3fmOOOv8lw
         QQrexvTBGJxxCovg3PsKdcgfeeOnlrZYPCvhqV3ULIo6GkGUexL/fxcNM+kxlG3vOLGS
         zO/12GJNuWsRT8Mho8QvkaNKL3TybObZj2LhPFWsCkwn/c+LdIsSTvRc00V0IT2/Qrya
         8FS+RirJeQJzvn+dVNNbTCFovIvdDbCMw734/so53yQC/mICVfMvdsDL9mnhNLcgxX37
         5qOYESowIyJAIfX87ouSSmWUv29X2zUszdOfS3ecHorMcQSnkhNcoZdsRYSIADv+QKAE
         k4yA==
X-Gm-Message-State: AOAM531KyQAoU5nNA7XnOAicDL/spTcOliKsU2JK9z2v2FlEsC3QaQWq
        qgv7vkEK+RzUjXrsTjgp8ni8uQ==
X-Google-Smtp-Source: ABdhPJxDGehQY/CmoySOGWWQNCrEx3jNpJjCZJUOvECVzdgdrGLxC4NZpiXRakqJeEqwqaibui2+dQ==
X-Received: by 2002:a17:902:d2cf:: with SMTP id n15mr20695824plc.33.1643645040656;
        Mon, 31 Jan 2022 08:04:00 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id n42sm17940716pfv.29.2022.01.31.08.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 08:04:00 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 0/5] Fix some cache flush bugs
Date:   Tue,  1 Feb 2022 00:02:49 +0800
Message-Id: <20220131160254.43211-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series focus on fixing cache maintenance.

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
 mm/hugetlb.c     | 1 +
 mm/memory.c      | 2 ++
 mm/migrate.c     | 3 +--
 4 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.11.0

