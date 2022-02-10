Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4C4B0DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbiBJMhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:37:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241588AbiBJMhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:37:19 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F8725F9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:20 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso1771645pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CF7K12UiHyUD8RD1jeYY8SOUVycWdbyPt5EtzOn4lQw=;
        b=ISYayM7HD4PDDxgAQEj7ZxaBeXkg55hZEZUJ9/011NcLqiLDBvHYG1mZTewaXAZUZv
         XQc1oHESzLZ4AV83ol2dg4VBY+m9jxtkvSHSB1bsn0ery+gvLJ5v1WEZ9DKzm9uAWmC0
         ap6bquUhRVZ15OZ9E9a4Lk1mt2faC5NcVRUHjgZblv5+2wynEIpVdsgpxlt6Ctcs4IZO
         aZn4J2LIneMvcK1HSfX/YPnefbwrR9NFaHw1/Oob9oTSMu3+YCA32I8tFatuOkDQqtC8
         KhgJ+Itxj8o7a0bobjHFDD8tjoM6PUfeoSFJOi0safpm2XJ3qalHl52JE2q4LfhhpQA7
         0opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CF7K12UiHyUD8RD1jeYY8SOUVycWdbyPt5EtzOn4lQw=;
        b=3Kt2tI2+y25sduw14FKoD15wm5v0S3mYmXdSo0xsZxYaWWgnT7ekoN/J95Y3SdI4D6
         22CmrmpQAlgULqNamrHOsp4NSn7k+svyqEB0EuEJ69IomRk0MW8BswJFUrAjebF2+Ox6
         6+F+/s6yYeWcm5015ZH6fG9qtQhoJJzYH48OrnwEcBt2PHEWwTsoqsfjMP7F+Mof/bQ1
         XRJ+4qA38HpGj9LIjMgZaroQB384iWu7iee6oC83ZokBao4VO7i2/fWUBNCoLcg/gngL
         rFvIkFuP6s4ny9VDEIGQLtYmfVx3U3xSC8QnyI+goKfL0urMJqNveaKE5yUks1Tkl4zn
         Uphw==
X-Gm-Message-State: AOAM531OyPsdXDUS4L0PR7GUkuMJD7kPf1JlM8pzsk3OuXgQLYuaLBXs
        6dyAb34wVWWRRUdkWl8q4fTozg==
X-Google-Smtp-Source: ABdhPJyG+mucPIqcKKRI/wRmsnd43dnkXL7d4glLC3bKKaAKx8N+wgAmMc8TBF+kr2WM5lKjW9w/8w==
X-Received: by 2002:a17:90a:4f04:: with SMTP id p4mr2592587pjh.180.1644496640426;
        Thu, 10 Feb 2022 04:37:20 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id i8sm11767812pgf.94.2022.02.10.04.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 04:37:20 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 0/7] Fix some cache flush bugs
Date:   Thu, 10 Feb 2022 20:30:51 +0800
Message-Id: <20220210123058.79206-1-songmuchun@bytedance.com>
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

v5:
  - Collect Reviewed-by from Mike.
  - Fix mcopy_atomic_pte() and __mcopy_atomic() (Mike).
  - Fix shmem_mfill_atomic_pte().

v4:
  - Replace folio_copy() with copy_user_huge_page().
  - Update commit message for patch 2.

v3:
  - Collect Reviewed-by tag from Zi Yan.
  - Fix hugetlb cache maintenance.

v2:
  - Collect Reviewed-by tag from Zi Yan.
  - Using a for loop instead of the folio variant for backportability.

Muchun Song (7):
  mm: thp: fix wrong cache flush in remove_migration_pmd()
  mm: fix missing cache flush for all tail pages of compound page
  mm: hugetlb: fix missing cache flush in copy_huge_page_from_user()
  mm: hugetlb: fix missing cache flush in hugetlb_mcopy_atomic_pte()
  mm: shmem: fix missing cache flush in shmem_mfill_atomic_pte()
  mm: userfaultfd: fix missing cache flush in mcopy_atomic_pte() and
    __mcopy_atomic()
  mm: replace multiple dcache flush with flush_dcache_folio()

 mm/huge_memory.c | 3 ++-
 mm/hugetlb.c     | 3 ++-
 mm/memory.c      | 2 ++
 mm/migrate.c     | 3 +--
 mm/shmem.c       | 4 +++-
 mm/userfaultfd.c | 3 +++
 6 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.11.0

