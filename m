Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF34CFF9A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbiCGNJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiCGNJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:09:30 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B0212602
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:08:35 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id f8so3241550pfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJPfLXFh8zeL0ZGxZZAtDpaG7vHzuWPH4ZZJpp3Y79g=;
        b=f/e7pAUL9+MhXiC5/0IlcGejZvwIdXseqcgbxNJ2Sup/ujWZ5v52uvd+Odm9ZDaphn
         lxPc1WLidrEBle5uWhp2AwPySNNCA9SX4HQL/9I4jUuuhWZJ1e0JgeUoZaSu0En0WRqJ
         ON88vnF2LIU6qj56icOBNUjomTkvg7H12zSNbKGhy/ZRmHFwAJJVrPDFxxeeRX5voEXF
         n/fCSm+Z6VajvnzMeNpwGtZKhZ4UmtKqrg7eKt5FZMcvSPNC6ytsjw3j1+KCBSqGVKpG
         C42DlijM9tjRgaATdm+sTWwNhgCzpfPRO1YWghiCxjPgMRuzc/1Tm5VhhymbhceUB8fL
         HhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJPfLXFh8zeL0ZGxZZAtDpaG7vHzuWPH4ZZJpp3Y79g=;
        b=46s+FMSLCDAtECBM4HZlTRzmgcc+W+ZTh8de9j1sFBhObdYrOhgDBQc/wNHKqpAVaE
         glacYaxsBlsjW4n0GN17H1WRaGM6t0XwvUEWOTARSiMnNj4eSBcUOiadXq8zXj7iOqGR
         asV2azhSFaRHuZxcQjOViUQbJoqm+hhVLNYa28+AMutI8ikV9OgplqQkimYMa8CjOgc1
         INp0g9lWC0VXViFHBsGv71pmx9KfXI60Aa0LOm4cfER4pU6S4sn5pSppTnp2G+Mif0Yv
         s7Md9nuKC6WzYVV1K7D8ZEqngSpX4f9UKDlxJCf8cHcu8Tp9/XhDA/IMjw87kdfQI2Ku
         DEdg==
X-Gm-Message-State: AOAM532aTbbTtfprGIFqGmG8sXK6Q8qr1gkxQJkrIk7SCYLvzvgD6fdV
        hA7VfybUP/uKJZMIA58Huj566Q==
X-Google-Smtp-Source: ABdhPJw5RDwGaMofaK51SgcgAGQmNJackUvqcMSogw6ycP0+UhBodVpqboWXcPaGByz0fNXkdDukBQ==
X-Received: by 2002:aa7:9522:0:b0:4e1:d277:ce8 with SMTP id c2-20020aa79522000000b004e1d2770ce8mr12390233pfp.16.1646658514956;
        Mon, 07 Mar 2022 05:08:34 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id x9-20020aa79409000000b004f704d33ca0sm3258528pfo.136.2022.03.07.05.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:08:34 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 0/4] add hugetlb_free_vmemmap sysctl
Date:   Mon,  7 Mar 2022 21:07:04 +0800
Message-Id: <20220307130708.58771-1-songmuchun@bytedance.com>
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

This series amis to add hugetlb_free_vmemmap sysctl to enable the feature
of freeing vmemmap pages of HugeTLB pages.

v3:
  - Add pr_warn_once() (Mike).
  - Handle the transition from enabling to disabling (Luis)

v2:
  - Fix compilation when !CONFIG_MHP_MEMMAP_ON_MEMORY reported by kernel
    test robot <lkp@intel.com>.
  - Move sysctl code from kernel/sysctl.c to mm/hugetlb_vmemmap.c.

Muchun Song (4):
  mm: hugetlb: disable freeing vmemmap pages when struct page crosses
    page boundaries
  mm: memory_hotplug: override memmap_on_memory when
    hugetlb_free_vmemmap=on
  sysctl: allow to set extra1 to SYSCTL_ONE
  mm: hugetlb: add hugetlb_free_vmemmap sysctl

 Documentation/admin-guide/sysctl/vm.rst |  14 ++++
 include/linux/memory_hotplug.h          |   9 +++
 kernel/sysctl.c                         |   2 +-
 mm/hugetlb_vmemmap.c                    | 113 +++++++++++++++++++++++++++-----
 mm/hugetlb_vmemmap.h                    |   4 +-
 mm/memory_hotplug.c                     |  27 ++++++--
 6 files changed, 143 insertions(+), 26 deletions(-)

-- 
2.11.0

