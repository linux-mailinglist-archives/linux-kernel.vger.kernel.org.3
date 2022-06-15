Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1079254CFDC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355519AbiFOR3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349861AbiFOR3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:29:36 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B68393E1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:29:33 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id d129so11979410pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tmRjS93QbcER/KipISqrMEyiblmHFSxAPW8kxLpmooc=;
        b=KLnFQA3N/38Ci7xwD7pYPH26rby8f9RxbUZsJlp4Rjy0tHdZ3jSJfljdl52oM0yyQf
         pZ0BKyece6woQWlaxf8di5Fs4iUquUgur2ybWVuQ1PgB1qljENG8+0mjyzFvbhGr5pez
         PP0QD2BqwiyczlfPE/I5vBtc9cknjBPMF3mfK4xMUiYXw9vEeWNEa2jixr4HkGI5qNEI
         Hb8N3sH3cSFfoO2rnjEadjbeLiKH8pDooEw2UF6ZGoxA6PxT7ScQZAkteg235WyIsYhF
         E16bpRQRTBlYrACebvj1ySVcN48JioVMdN0EnlOB8DPoClKkhHcfEtYcIPtDVPQabEcI
         N1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tmRjS93QbcER/KipISqrMEyiblmHFSxAPW8kxLpmooc=;
        b=vA8NJ3kSTxhyuFr1E4tttajWrPYRjFFKHB0uECvLrUdQzep/phP/edatRq1gUAiMwz
         BTvnowc6ROuKVispavYvj0dvjPhE8yYDrIANwrknPVda6KvLzRsexHAjRZiQREJixvgG
         /TlEQoKS7PlUEfJN6/xLAAWNdepCxdJg7pjsE8XKenvld/8MFHtU9QK3HkZQyr10PxjH
         nRyIe5l00QzbPs6A2mvWlK7L//LwdXHBdFYu+bDrQ1j8v1c5c+Otsz500nyhBnJk2BOX
         1ZOLCcJgWts6a9LBHFweIGPYk9xB7cv1+E4wfKeSttsP9gSVxTjlF3eO58WtIiYFUKdN
         YblQ==
X-Gm-Message-State: AJIora8RTsshjUw1uLDnEYXbWQcWHVZqIXEiHSpoNfpFl9M9im5A1dq9
        +V0InB3BlZ6VNybIYz75T6Y=
X-Google-Smtp-Source: AGRyM1u3+RNW/fGgr0Vv/LcOX4rr7kXu8Qk4YW6i5WFssxnq8oeBhwm8lUVHdPTJqr/7goTW6817/g==
X-Received: by 2002:a63:ee54:0:b0:3fe:30cc:899f with SMTP id n20-20020a63ee54000000b003fe30cc899fmr799999pgk.234.1655314172863;
        Wed, 15 Jun 2022 10:29:32 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709029a8e00b001676f87473fsm9552244plp.302.2022.06.15.10.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:29:32 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, zokeefe@google.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [mm-unstable v4 PATCH 0/7] Cleanup transhuge_xxx helpers
Date:   Wed, 15 Jun 2022 10:29:19 -0700
Message-Id: <20220615172926.546974-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


v4: * Consolidated the transhuge_vma_size_ok() helper proposed in the
      earlier versions into transhuge_vma_suitable(), per Zach.
    * Fixed the regression introduced by patch 3/7, per Zach and Miaohe.
    * Reworded the comment for transhuge_vma_suitable(), per Zach.
    * Removed khugepaged_enter() per Miaohe.
    * More comments for hugepage_vma_check(), per Zach.
    * Squashed patch 4/7 (mm: khugepaged: use transhuge_vma_suitable replace open-code)
      in the earlier version into patch 2/7 of this version.
    * Minor correction to the doc about THPeligible (patch 7/7), so the
      total number of patches is kept 7. 
v3: * Fixed the comment from Willy
v2: * Rebased to the latest mm-unstable
    * Fixed potential regression for smaps's THPeligible

This series is the follow-up of the discussion about cleaning up transhuge_xxx
helpers at https://lore.kernel.org/linux-mm/627a71f8-e879-69a5-ceb3-fc8d29d2f7f1@suse.cz/.

THP has a bunch of helpers that do VMA sanity check for different paths, they
do the similar checks for the most callsites and have a lot duplicate codes.
And it is confusing what helpers should be used at what conditions.

This series reorganized and cleaned up the code so that we could consolidate
all the checks into hugepage_vma_check().

The transhuge_vma_enabled(), transparent_hugepage_active() and
__transparent_hugepage_enabled() are killed by this series.


Yang Shi (7):
      mm: khugepaged: check THP flag in hugepage_vma_check()
      mm: thp: consolidate vma size check to transhuge_vma_suitable
      mm: khugepaged: better comments for anon vma check in hugepage_vma_revalidate
      mm: thp: kill transparent_hugepage_active()
      mm: thp: kill __transhuge_page_enabled()
      mm: khugepaged: reorg some khugepaged helpers
      doc: proc: fix the description to THPeligible

 Documentation/filesystems/proc.rst |  4 ++-
 fs/proc/task_mmu.c                 |  2 +-
 include/linux/huge_mm.h            | 75 +++++++++++++++++++------------------------------------
 include/linux/khugepaged.h         | 30 ----------------------
 mm/huge_memory.c                   | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
 mm/khugepaged.c                    | 84 +++++++++++++++++++-------------------------------------------
 mm/memory.c                        |  7 ++++--
 7 files changed, 130 insertions(+), 153 deletions(-)

