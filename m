Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E25B4FF957
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiDMOu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbiDMOuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:50:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62C463BF0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:48:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p10so2157776plf.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/LdJAtOUO57Ha4IsgdkfD8oFYqd/Z71aYJmqNULy+Q=;
        b=tDtubE/ZwH48VZrJoDlBbZ3+P3KQGydQEJdFXKPOZgToajCjO+pn4TZojzE43ltN6s
         Ce0D9N8Rb0wPcLdJLIq4w1n1syJkOLwRvAU3gTbLNCPHkd1fJyQZAFej1vcVXzqThQpI
         cQIWi0FWFWFUZRDlVFfCbHKV3RH0O+yGzMPZBmljFsVoO+TjZ1PnjMgq3Rf5eDxhW1wC
         Cv/Iim/J0Zj2Jbe4/3jTDCqt7pzLtHzbrKeJ6gR7d2ef75OOCujFGYKxgn69xvFOzWxp
         /v4yVUV762iD/MKcDOAOvrbzG+6iNxTTiuzIl5J9zzVfR2G2gQV1tqhQRpLRCuqLh2Dq
         Q15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/LdJAtOUO57Ha4IsgdkfD8oFYqd/Z71aYJmqNULy+Q=;
        b=4pXdjLOkl8WMlLjXiJb9KkioE1zYUODccbs3be56i+UO32TzqkHSkYETSn9cHhU1Jj
         uAhY6d4n/dx9zkjPU4Nn4URZWXTI1XBifOZerxttGyhXGt0xxW4CY7PekNpxhbm3VjnL
         xNgvcMFIyio9DN8D4hyiX+/UBhhza+uM8+keFbAOFLVxgwgV+FsNSX2DIv7y6gAcwi6q
         s1SHW32UcLWf/5lcW12FYLj9WN+zI45ajnsg547RsVZVEvXcfFM+vjF9p2yzDHtdlgPj
         4HgAtwvvMXU4zYyE4j3Y/cBMFmoP2cgBRjNbIuuQJ0JB+N+vjkewd0UOgZKIUdmYUCyJ
         gohQ==
X-Gm-Message-State: AOAM532pXx7LJWFjedWE37lzeYqZEjYqiHYHsvqyDRIOVswZhZgFnpMh
        +F/cu0ICCvtB9Evcf0Vg6wCcyw==
X-Google-Smtp-Source: ABdhPJz2EPmb6m43FkHiFxBEpO7vn7u8K8m686phmKJ6SIsaXxoigMHrk2FsX/UcUEV3dgNYt4fFKg==
X-Received: by 2002:a17:902:d4c3:b0:158:a79e:9bf with SMTP id o3-20020a170902d4c300b00158a79e09bfmr2237005plg.40.1649861309243;
        Wed, 13 Apr 2022 07:48:29 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a000a1b00b004f3f63e3cf2sm47817257pfh.58.2022.04.13.07.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 07:48:28 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v8 0/4] add hugetlb_optimize_vmemmap sysctl
Date:   Wed, 13 Apr 2022 22:47:44 +0800
Message-Id: <20220413144748.84106-1-songmuchun@bytedance.com>
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

This series is based on next-20220407.

This series amis to add hugetlb_optimize_vmemmap sysctl to enable or disable
the feature of optimizing vmemmap pages associated with HugeTLB pages.

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
  mm: hugetlb_vmemmap: introduce
    CONFIG_HUGETLB_PAGE_HAS_OPTIMIZE_VMEMMAP
  mm: memory_hotplug: override memmap_on_memory when
    hugetlb_free_vmemmap=on
  mm: hugetlb_vmemmap: use kstrtobool for hugetlb_vmemmap param parsing
  mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap sysctl

 Documentation/admin-guide/kernel-parameters.txt |   6 +-
 Documentation/admin-guide/sysctl/vm.rst         |  27 +++++++
 Kbuild                                          |  19 +++++
 arch/x86/mm/init_64.c                           |   2 +-
 include/linux/hugetlb.h                         |   2 +-
 include/linux/kconfig.h                         |   4 +
 include/linux/memory_hotplug.h                  |   9 +++
 include/linux/mm.h                              |   2 +-
 include/linux/page-flags.h                      |   2 +-
 kernel/autoconf_ext.c                           |  26 ++++++
 mm/hugetlb_vmemmap.c                            | 102 ++++++++++++++++++++----
 mm/hugetlb_vmemmap.h                            |   8 +-
 mm/memory_hotplug.c                             |  27 +++++--
 mm/sparse-vmemmap.c                             |   4 +-
 scripts/mod/Makefile                            |   2 +
 15 files changed, 207 insertions(+), 35 deletions(-)
 create mode 100644 kernel/autoconf_ext.c

-- 
2.11.0

