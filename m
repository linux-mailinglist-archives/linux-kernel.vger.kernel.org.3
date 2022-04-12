Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04BB4FDFC8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347850AbiDLMO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354397AbiDLMOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:14:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C90985669
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:15:01 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c23so16537104plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/LHQ0nWmz2r/pD7wgSsiKJq8hFpZAK2dEG+C+pVYguk=;
        b=RgweYEl2njKBQ/qkD0QsEqFYmun8JoT7QAE9/9a8ypuYGYrQVmiL8WG0sENk1bRlB9
         DdpFfhUEl39HPbnsBVsXjIw2BDTBBBRE6jW52nEPelTno7oI4BvsIluMkuuDnVa+rLTc
         IRDl9RdjBI/bp5RnOopsKDizvkCpGgwrnVJRcXQMBCo9Qy8tF05bIqofh7dTe1WMzO/C
         aP8eewe6tH4gOiZXlafAG1vJkFZ7GEHXZnSDtvOyH9rUT8+DOtrdEL9VYRK4rU9dnMTA
         vLOYXWfy422owFKiQuP8ohMxu+lE1GU8qWWkK+3QOwg2UPuxJWhpveIPPimR77YwZmkA
         pLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/LHQ0nWmz2r/pD7wgSsiKJq8hFpZAK2dEG+C+pVYguk=;
        b=YcEDjtMpkzVbsjitn3rf/zX52P8Q+hXKvaHdWch5dvYWiDVM+mLJTv4atn06VGa3ZV
         Dj5W8lX0nw4jxHtNuvHZF0wFrP5lvWNVHa3TG3eMT5fyL+YSZWrLQkg2vNTw/tK5JDmJ
         QkscUYBdGQN/XioRBId7zDLQ36OutYmjAGU6zrAku/NpKkk9uXut0Rf4um1TUriAJGMj
         ocejRsQWl2fKkJOjBF6QIKbGmvicmA/pWS+6mRuKh2tQy0WgLW/iRLVf+WFk7JqSw0px
         KiIM82gzYMy0RnkM3UtawLZI78o9etqAwUAq5M/KZTIDVvwIa3deIUcimKJ5mzHFXUAN
         0YRw==
X-Gm-Message-State: AOAM5320PDjHack8OkRG5LC+tQK/VnMe7X3OjsVo3mdND5WwBLhbfDsM
        c6mFs/PWmXieqpg6dUF7SCQ5mw==
X-Google-Smtp-Source: ABdhPJyxhPc5PVq3oT4Nhp6xmJ9VdjMh9PULiQuZiylRW5MGUuA3lL9aU58g8xg3Wuc8aEJV27QiLA==
X-Received: by 2002:a17:90b:3b43:b0:1c6:f878:ea52 with SMTP id ot3-20020a17090b3b4300b001c6f878ea52mr4428201pjb.68.1649762100641;
        Tue, 12 Apr 2022 04:15:00 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id l25-20020a635719000000b0039da6cdf82dsm402507pgb.83.2022.04.12.04.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 04:15:00 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 0/4] add hugetlb_optimize_vmemmap sysctl
Date:   Tue, 12 Apr 2022 19:14:30 +0800
Message-Id: <20220412111434.96498-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on next-20220407.

This series amis to add hugetlb_optimize_vmemmap sysctl to enable or disable
the feature of optimizing vmemmap pages associated with HugeTLB pages.

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

