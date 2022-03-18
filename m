Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8274DD7A8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiCRKK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiCRKK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:10:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8C81F9FC8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:09:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q13so6592769plk.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqTragMvIuyF2G0eNMg49ec3Fe5cawaQAXvvejFzdIM=;
        b=qXwXkk0olJ0XDtllYBpfRHL/aedk+D1cB23bq8H1tudbY0Os+Et3oFOf/Pc0BG/5/+
         +yRK9PawpTJwQCj4raaVJAb42DypRyfAXxCtqLS8U8Fea7c6vtzpkml1ByZ8uhEEGjr8
         bgXf3ZcCDXwd5+UNeQpJ77RpXYAYAn+4MNuXKAPqgGbpJ3+ytYvR4hC8qlMq9k8cO8dF
         o7HtFAbnv7+MSQR/fZGvxk4MRO9YQHvmZu+LQwjqjThoVgHbnOltQrIgaijn7MrKHpMp
         6HKtebsjY+zOhOE6rQ0TMgoxMpAwWJkZk3G3NKcHA2S4m6tA1IfLjRnjR7J4GY6Oc77a
         TbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqTragMvIuyF2G0eNMg49ec3Fe5cawaQAXvvejFzdIM=;
        b=qyM7F+8ShJGhhei4WJouQfio4lgklYipDPwTaY3l0VIUG4eplH0kOyESP8Guy0o90H
         gp3doi8Ou+8Qj+hmbIl0o+8sgBejVCwFr+ictZfDhljY49lkbeIbYKuGBz9Drg2dfQwy
         LwYbXwuhEKIovtlciNvpzaJo6UYkor3kjsB77gmbjyf3qdTirENwQvVFzJnDTewzZIyN
         kGKDz6hFbjq7+EQYUgGr3O+l3tkDyMhdNnlo3YL53rdUaYyvP72qQr8bcHn4Vu8tHQfG
         T46gv20rvZkMDqCOcX3EJZ5so8y5Lg4NRIhso0loH1r0NdE2v/+iZ68kQmNo7NKehdmp
         GMvg==
X-Gm-Message-State: AOAM533UriGZl/tzB1uDvCWTmh1XGW+YAf0RaTiV8cnPFf+I4iAu0Db9
        8YQyZ5I6CHrlyLDojBVT28UJ1Q==
X-Google-Smtp-Source: ABdhPJwYPVd8MicGEiN4zrjKB2SVRMQvXml+oxRRxpDhAvQvmm05Oyp3FZLDCzGvE+iUQJwPVMmWCg==
X-Received: by 2002:a17:903:32c3:b0:152:c1b:e840 with SMTP id i3-20020a17090332c300b001520c1be840mr9533735plr.40.1647598148363;
        Fri, 18 Mar 2022 03:09:08 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id j3-20020a056a00234300b004fa042e8216sm9541252pfj.2.2022.03.18.03.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 03:09:08 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 0/4] add hugetlb_free_vmemmap sysctl
Date:   Fri, 18 Mar 2022 18:07:16 +0800
Message-Id: <20220318100720.14524-1-songmuchun@bytedance.com>
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

This series is based on next-20220310.

This series amis to add hugetlb_free_vmemmap sysctl to enable the feature
of freeing vmemmap pages of HugeTLB pages.

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
  mm: hugetlb_vmemmap: introduce STRUCT_PAGE_SIZE_IS_POWER_OF_2
  mm: memory_hotplug: override memmap_on_memory when
    hugetlb_free_vmemmap=on
  sysctl: allow to set extra1 to SYSCTL_ONE
  mm: hugetlb_vmemmap: add hugetlb_free_vmemmap sysctl

 Documentation/admin-guide/sysctl/vm.rst |  14 +++++
 Kbuild                                  |  12 ++++
 fs/Kconfig                              |   2 +-
 include/linux/memory_hotplug.h          |   9 +++
 include/linux/mm_types.h                |   2 +
 kernel/sysctl.c                         |   2 +-
 mm/Kconfig                              |   3 +
 mm/hugetlb_vmemmap.c                    | 107 ++++++++++++++++++++++++--------
 mm/hugetlb_vmemmap.h                    |   4 +-
 mm/memory_hotplug.c                     |  27 ++++++--
 mm/struct_page_size.c                   |  19 ++++++
 scripts/check_struct_page_po2.sh        |  11 ++++
 12 files changed, 177 insertions(+), 35 deletions(-)
 create mode 100644 mm/struct_page_size.c
 create mode 100755 scripts/check_struct_page_po2.sh

-- 
2.11.0

