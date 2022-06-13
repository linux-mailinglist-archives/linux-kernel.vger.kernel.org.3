Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D9A547F97
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiFMGfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiFMGf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:35:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C020ABC9C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:35:27 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h192so4734196pgc.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ejoz2DCbggYc1zBmQNGGZRqPtrQj0ureLICOuzJFZmU=;
        b=OxTUnNdHpp50SMsYqQOIYKSwtagFzLBUmMmPY9dFZ+mCEDI0GK+/N644JE0MVvRWuD
         oi1jkSH30j46ZX061wTIpMoKjsckKkkuG/UTdIMbtVUUrwrWj6v0vGxlZ5xKHU3UMk9T
         MrG7FrNRnF7cqn36SdxWn026hu4EX/7nFvs5WuiE7CM50W17zGVGpz84tR9HpKEl3rAP
         ebelIoFS5Lhto5GBs76E3lrxeLiAqiWUJpaQk8EmX7YkGPsQrbcXln9b+NRDLz4b96yY
         iO0CKZxjNJq7XR6NnOJoSyQDAR3SBeko1QHhxk3M5dWxw7EsjElP96SoYkXgUEZRLgbb
         1vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ejoz2DCbggYc1zBmQNGGZRqPtrQj0ureLICOuzJFZmU=;
        b=Obm/RdU2/d16p7wrzuHw2ybQObqNhhx5LDGmb72vH47QDkeiD2ccV5m+pXyyIq/Y5o
         0JL8Ega1QLyZUslO0H9hvp9Sfcv74upjXugi0p71jiIep1uwmfX4myZbYFgt50kpOA31
         oBxVj1n7K1ffM7L+ZQMObKmA5vKkujIpukU+wJ80GUEdiPFLkOq3eSYD9ibIxiM0h78j
         mI0P0JKzO/2z9RNaQX9OtDCVI835C/EJv7tZlV6MFkU+5+Ctk+fC/r27Mwg0z/kGrwRl
         qe0V9OWHEvGzlg+f8fQjGz61bdxTybSZCb1P6rlmpcaz7U4zvGWGp1pFm0auwKmDZKyX
         MrEQ==
X-Gm-Message-State: AOAM531lCFLV0FYkMt8mvDH8+pAtu+UWSn6KhxcxRM3mSe1MlP6/5oR4
        lPP1xqYd/XTdHKAwyFrQoV5yVA==
X-Google-Smtp-Source: ABdhPJymj2CTUZcvnfpi7YZkMigHH98usV2DwWdiEfXKQZqUz6w1sAVIilmQqx44Ffhe7JQCx6y0YA==
X-Received: by 2002:a63:5723:0:b0:3fd:d8b4:c19f with SMTP id l35-20020a635723000000b003fdd8b4c19fmr31492536pgb.137.1655102127199;
        Sun, 12 Jun 2022 23:35:27 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id v3-20020aa799c3000000b0051bc538baadsm4366554pfi.184.2022.06.12.23.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 23:35:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/6] Simplify hugetlb vmemmap and improve its readability
Date:   Mon, 13 Jun 2022 14:35:06 +0800
Message-Id: <20220613063512.17540-1-songmuchun@bytedance.com>
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
and is based on next-20220610.

Muchun Song (6):
  mm: hugetlb_vmemmap: delete hugetlb_optimize_vmemmap_enabled()
  mm: hugetlb_vmemmap: optimize vmemmap_optimize_mode handling
  mm: hugetlb_vmemmap: introduce the name HVO
  mm: hugetlb_vmemmap: move vmemmap code related to HugeTLB to
    hugetlb_vmemmap.c
  mm: hugetlb_vmemmap: replace early_param() with core_param()
  mm: hugetlb_vmemmap: improve hugetlb_vmemmap code readability

 Documentation/admin-guide/kernel-parameters.txt |   7 +-
 Documentation/admin-guide/mm/hugetlbpage.rst    |   3 +-
 Documentation/admin-guide/sysctl/vm.rst         |   3 +-
 arch/arm64/mm/flush.c                           |  13 +-
 fs/Kconfig                                      |  13 +-
 include/linux/hugetlb.h                         |   7 +-
 include/linux/mm.h                              |   7 -
 include/linux/page-flags.h                      |  16 +-
 mm/hugetlb.c                                    |  11 +-
 mm/hugetlb_vmemmap.c                            | 592 ++++++++++++++++++------
 mm/hugetlb_vmemmap.h                            |  43 +-
 mm/sparse-vmemmap.c                             | 391 ----------------
 12 files changed, 509 insertions(+), 597 deletions(-)


base-commit: 6d0c806803170f120f8cb97b321de7bd89d3a791
-- 
2.11.0

