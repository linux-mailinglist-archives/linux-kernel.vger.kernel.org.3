Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F0D514901
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358981AbiD2MVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbiD2MVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:21:53 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BDEAAE3C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:18:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u7so6964094plg.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3RkULuqhhhX3uuLQ5CElh2Ii/L2usT9wtqwuaXqStls=;
        b=6dgC+bHSAeFJrC8KYg2z7/2H3/R6h6zeIP2/TJM/lbA1VYy7SbJIMRyIrieRowIaQv
         kJ1SOEdSzpZW5RWIfKHc50pJY+MknWf6wyZ9mBDTSwdQHraDZEU1pDlp0hOXMDHzylgF
         ifJ3CIfECLSdzzd+Hs1I8D9emPRAiSTJWuOdPodBLLugKQxYi5DQ2J5LWb0UXB3GKT35
         VjwlylSkcqgoLK/lJASS0z3jk/BKMsGyUtgguRSoE/UUVpx+Q6mT8cdv95iEao6gZnq5
         eaE7vV4dtDupThy77SS0zIM29gLGBKU0oYc7ymGlICVJ/7p6SROAx9I4jN05YRtw2b5Q
         sVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3RkULuqhhhX3uuLQ5CElh2Ii/L2usT9wtqwuaXqStls=;
        b=LqZJhoCYQBXAwN7g6F2V6++bk35dHbUYZlXXLSUlSldhlH0CdozIsse4BpD/PfjDbC
         djIOXsR9D2ByD/kLMLs8cVPfCTRaR65GDhhrAY1XznM6Ec1v7n5qN+0JUKQ2FNZvM0hm
         Lfkanm7Jb2+THe3+7d0JMIoD8POi2CPB4PM7I3e3ZYzHAWdrsT/JdZDpLiIsBZ7Ds1Wb
         2HeYZostwCOt2Hy09muQcTIXFVzSOraxctHMIzvdBI6HWGj9M5v/MpQLh5Hwjh6H8an7
         hmbLzrQ/4KzisKX/YtKL7OpyxOUVmQXh6tabcCOezedXaBC2Ashh84Zo9MC4d2fM/nkm
         vx6Q==
X-Gm-Message-State: AOAM531qLo2BvVrPRlZLCcFP09LZnx8D10p/Ok7IrBXKL0YhlWmR5mFC
        bFC7UM0fz+jFeioDBn1z73mlpg==
X-Google-Smtp-Source: ABdhPJxtE+CaijPiIC9LAoGrQDqYJS3f51fjNp6Dgr2elQX0PSrsGMqnZLLhoG9YQBepjs7VbKUriQ==
X-Received: by 2002:a17:902:7d83:b0:158:c7e9:1ff3 with SMTP id a3-20020a1709027d8300b00158c7e91ff3mr38794664plm.55.1651234713265;
        Fri, 29 Apr 2022 05:18:33 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id k11-20020a056a00168b00b004f7e1555538sm3101421pfc.190.2022.04.29.05.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:18:32 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v9 0/4] add hugetlb_optimize_vmemmap sysctl
Date:   Fri, 29 Apr 2022 20:18:12 +0800
Message-Id: <20220429121816.37541-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on next-20220428.

This series amis to add hugetlb_optimize_vmemmap sysctl to enable or disable
the feature of optimizing vmemmap pages associated with HugeTLB pages.

v9:
  - Go back to v3 since checking the size of struct page at config time is
    very complex.

v8:
  - Fix compilation (scripts/selinux/mdp/mdp.c) error when
    CONFIG_SECURITY_SELINUX is selected.

v7:
  - Fix circular dependency issue reported by kernel test robot.
  - Introduce CONFIG_HUGETLB_PAGE_HAS_OPTIMIZE_VMEMMAP instead of
    STRUCT_PAGE_SIZE_IS_POWER_OF_2.
  - Add more comments into vm.rst to explain hugetlb_optimize_vmemmap (Andrew).
  - Drop the patch "sysctl: allow to set extra1 to SYSCTL_ONE".
  - Add a new patch "use kstrtobool for hugetlb_vmemmap param parsing".
  - Reuse static_key's refcount to count the number of HugeTLB pages with
    vmemmap pages optimized to simplify the lock scheme.

v6:
  - Remove "make syncconfig" from Kbuild.

v5:
  - Fix not working properly if one is workig off of a very clean build
    reported by Luis Chamberlain.
  - Add Suggested-by for Luis Chamberlain.

v4:
  - Introduce STRUCT_PAGE_SIZE_IS_POWER_OF_2 inspired by Luis.

v3:
  - Add pr_warn_once() (Mike).
  - Handle the transition from enabling to disabling (Luis)

v2:
  - Fix compilation when !CONFIG_MHP_MEMMAP_ON_MEMORY reported by kernel
    test robot <lkp@intel.com>.
  - Move sysctl code from kernel/sysctl.c to mm/hugetlb_vmemmap.c.

Muchun Song (4):
  mm: hugetlb_vmemmap: disable hugetlb_optimize_vmemmap when struct page
    crosses page boundaries
  mm: memory_hotplug: override memmap_on_memory when
    hugetlb_free_vmemmap=on
  mm: hugetlb_vmemmap: use kstrtobool for hugetlb_vmemmap param parsing
  mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap sysctl

 Documentation/admin-guide/kernel-parameters.txt |   6 +-
 Documentation/admin-guide/sysctl/vm.rst         |  30 +++++++
 include/linux/memory_hotplug.h                  |   9 ++
 mm/hugetlb_vmemmap.c                            | 104 ++++++++++++++++++++----
 mm/hugetlb_vmemmap.h                            |   4 +-
 mm/memory_hotplug.c                             |  27 ++++--
 6 files changed, 155 insertions(+), 25 deletions(-)

-- 
2.11.0

