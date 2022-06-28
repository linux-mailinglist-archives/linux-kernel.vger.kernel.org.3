Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ADD55D62F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343939AbiF1JYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344173AbiF1JXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:23:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524A01EAC1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:23:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so15232062pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQkt4wjPT/v+iF+fXDGRisMQCM0vLDWYyifuIV/OGDo=;
        b=BGy1MI8xqjO6lduBhMa13lY37kGteP8POqCXl3BZdOwHo9Opp1aEltf4yPcfE+uJ+2
         ITWTBRfi0L2QIwl4XxMjPM/RcSAjUuGie94NjWZ0TSq3iPSH3m7NdNUSnvWYoyrIqjjj
         wkMqlgUCZLwlmXIWSvSo8zk4PWzCIDtGfDBMK87KLwi0vavL57ofaJpo4R+pPLDm4og/
         /DZrlTwoxGLTO8ZDdWHkX4l9IIH9xzMH+zfkDqNK6rp+Cx7gTAIZX1rtZGL5ZZQ0ZJV3
         kibsGCfxlIe99uHGHgCQwvo15q+zI3SrLYIcHxMgWZNMnUMQuM9WX8Afa/Ic8O+hzH9K
         /2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQkt4wjPT/v+iF+fXDGRisMQCM0vLDWYyifuIV/OGDo=;
        b=i4omTE/gpsQ8vUQcwIwwUf8xTKnPinkJ432xw3A7HxhngaHgBHsbNCviOTm9R7mYgy
         /AgKZD/nUrweEbiLkXtiAGfKPJWclZGjSz7ikpaH7vMBE1Lg5azwFJqUKy/fZt3tKnjC
         9jtQd128jvpQp2DhMKrVldh/OP4pxox7IclPJNaGzEYvLVmb6ZNgSyp89ImlS1iRcj5Y
         wZz44Rwm9pj7yVcjqS9xWyjqxFPGCkf1F74ITE/vilRe9yW/Rv3Wv9Xnw41BannFL/Pn
         kjuXVIJG0XOEblwU/JJSmxEMCr74lvGSmJDgvK7Fv2UZQZE5bbWf+xsFe6unRq7cyuTf
         PuVw==
X-Gm-Message-State: AJIora9SfSzkMPRGvchN95K0i98gBZXb0snkfP95HH0QOgfy6Jxk+xlW
        9YcMnV3YclrqJxEtZHCvqFbXrQ==
X-Google-Smtp-Source: AGRyM1ue3KkVfkoriauuRkSduIpdUzZ8CoxO4+O4HV1szaRrCPOfb8vOnORTEmnfN6gQ6hitXaQo/A==
X-Received: by 2002:a17:90b:1d0a:b0:1ee:de8e:9d58 with SMTP id on10-20020a17090b1d0a00b001eede8e9d58mr10347710pjb.39.1656408227811;
        Tue, 28 Jun 2022 02:23:47 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id mm9-20020a17090b358900b001ec729d4f08sm8780463pjb.54.2022.06.28.02.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:23:47 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 0/8] Simplify hugetlb vmemmap and improve its readability
Date:   Tue, 28 Jun 2022 17:22:27 +0800
Message-Id: <20220628092235.91270-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to simplify hugetlb vmemmap and improve its readability
and is based on next-20220627.

v2:
  - Collect Reviewed-ed and Acked-by.
  - Improve patch 6's log print.
  - Add patch 7 to improve vmemmap_dedup.rst.
  - Add patch 8 for cleanup.

Muchun Song (8):
  mm: hugetlb_vmemmap: delete hugetlb_optimize_vmemmap_enabled()
  mm: hugetlb_vmemmap: optimize vmemmap_optimize_mode handling
  mm: hugetlb_vmemmap: introduce the name HVO
  mm: hugetlb_vmemmap: move vmemmap code related to HugeTLB to
    hugetlb_vmemmap.c
  mm: hugetlb_vmemmap: replace early_param() with core_param()
  mm: hugetlb_vmemmap: improve hugetlb_vmemmap code readability
  mm: hugetlb_vmemmap: move code comments to vmemmap_dedup.rst
  mm: hugetlb_vmemmap: use PTRS_PER_PTE instead of PMD_SIZE / PAGE_SIZE

 Documentation/admin-guide/kernel-parameters.txt |   7 +-
 Documentation/admin-guide/mm/hugetlbpage.rst    |   4 +-
 Documentation/admin-guide/mm/memory-hotplug.rst |   4 +-
 Documentation/admin-guide/sysctl/vm.rst         |   3 +-
 Documentation/vm/vmemmap_dedup.rst              |  72 ++-
 arch/arm64/mm/flush.c                           |  13 +-
 fs/Kconfig                                      |  12 +-
 include/linux/hugetlb.h                         |   7 +-
 include/linux/mm.h                              |   7 -
 include/linux/page-flags.h                      |  32 +-
 include/linux/sysctl.h                          |   4 +
 mm/hugetlb.c                                    |  15 +-
 mm/hugetlb_vmemmap.c                            | 589 ++++++++++++++++++------
 mm/hugetlb_vmemmap.h                            |  45 +-
 mm/sparse-vmemmap.c                             | 399 ----------------
 15 files changed, 567 insertions(+), 646 deletions(-)


base-commit: aab35c3d5112df6e329a1a5a5a1881e5c4ca3821
-- 
2.11.0

