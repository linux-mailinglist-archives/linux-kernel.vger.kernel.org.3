Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323154EC869
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348284AbiC3PkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346546AbiC3PkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:40:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7456AA52
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:38:21 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id jx9so20989751pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IKVFgArMfLAYb/4tYUuGf6KEnDE92hMEQ9mU5hp/SXo=;
        b=y426lP1h9/gpMDvFsvkQcsWTR6r4t0uNFPGCXcCkQ0w4bDDfbd2I6w3MPvmSngD5aQ
         9UHKY99m4xTMn2S+VEWYRysvmEDjOdp+p+AaJE9UQlAtOAg9nnObmnt7SD/llMP+ydXX
         tEoTC4CvY+Alaz3nGiPuulcsMVs4yV+CghqyvhjrIdjT4SEbjXtkkYdOiUQNNPovNO65
         zooFZEF1EAKY+iSmwmGDYeeIlMmOyMmQg3y3cSgjUo/6mm1bLvfygA1ZudpOBLvdKOnK
         IAyYWShhvc4qIrg9j5+ZR6S93sOYQk7CUSaTKoYVYl/japXdL0WlkQnS9qvagsSwyJE5
         F5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IKVFgArMfLAYb/4tYUuGf6KEnDE92hMEQ9mU5hp/SXo=;
        b=HzneB2fpLxeP+GTnh3OsJdwJKVc/gTMXGOzxVOghf8KkolHNjm01WwLS/jZM0C08Ww
         gYrzccUEdzIoj8qz4QZ/RD3A6BDK+6SO/wzlViB2NQoduvb4WQgUb2vDdLnLC/o9V8m3
         jRxAEGyY3ddlaj1Q75C6c1g7MqH56p+zNRFhnM8QxmooZd99QJZhZkf4DAXHUW9viCFQ
         XczxmScQoUz7WtLpuhXX6P0J7f1Ybvl/uqv8az5lYMb1N8WfHTj7qQ+3Pk2hD3Dcp7jb
         yMa/iNLKWw7jKJb7rP/QxaRd68/nZ9S4iSNcxcDshyglP5gYc9k5/Jo/Lrqhdck+Der5
         pDig==
X-Gm-Message-State: AOAM5312vAkfXRW4nyvyz/zUrvxdIsnuVuzVEdG5v+9gb4Zz+XIDwdoC
        gE5aVi6NMMLesvIHcz87A6g8qg==
X-Google-Smtp-Source: ABdhPJyx8KyO7z1oyOwVys9x6GkHA4ruaJjbZc4MyGqZcrWkQvN5DIzM1+TzQgmsyw0Tgim4c9azmA==
X-Received: by 2002:a17:902:d3c5:b0:154:a3b5:d918 with SMTP id w5-20020a170902d3c500b00154a3b5d918mr161632plb.91.1648654701358;
        Wed, 30 Mar 2022 08:38:21 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090aa40800b001c6ccb2c395sm6686039pjp.9.2022.03.30.08.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 08:38:21 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 0/4] add hugetlb_free_vmemmap sysctl
Date:   Wed, 30 Mar 2022 23:37:41 +0800
Message-Id: <20220330153745.20465-1-songmuchun@bytedance.com>
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

v6:
  - Remove "make syncconfig" from Kbuild.

v5:
  - Fix not working properly if one is workig off of a very clean build
    reported by Luis Chamberlain.
  - Add Suggested-by for Luis Chamberlain.

Thanks.

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

 Documentation/admin-guide/sysctl/vm.rst |  14 ++++
 Kbuild                                  |  15 ++++-
 include/linux/memory_hotplug.h          |   9 +++
 include/linux/mm_types.h                |   2 +
 include/linux/page-flags.h              |   3 +-
 kernel/sysctl.c                         |   2 +-
 mm/hugetlb_vmemmap.c                    | 109 ++++++++++++++++++++++++--------
 mm/hugetlb_vmemmap.h                    |   8 ++-
 mm/memory_hotplug.c                     |  27 ++++++--
 mm/struct_page_size.c                   |  20 ++++++
 10 files changed, 171 insertions(+), 38 deletions(-)
 create mode 100644 mm/struct_page_size.c

-- 
2.11.0

