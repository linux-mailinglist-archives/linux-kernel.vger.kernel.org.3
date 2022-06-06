Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EF753F1DC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiFFVpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiFFVo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:44:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B451181486
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:44:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so13684154pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 14:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9AymPPffeIR1VQQPaQ/nzlIfZdjrOkxBeqoJZ0QW7Q=;
        b=dhkIidP9TDH9wpEPcVPvs+yx1doA1HyD65I5go3pCHsNqRF6zO80Q689hhPpcdi1i8
         AeNKphBHL/T7ROn1fB0y7y2L0iidfw/exIF8YawilsG+2wnterdE0RDRmpVylpfWoSZB
         lfNGLPZVBqJqd4+USHbNtDDlZ149kk9NjmwedZ8SbPjVaO0MJaave1Sgz+StKQ4oCr1s
         TZXlKrfPd0GlE7Brx38GBpq4ZHoKY9kM4tU42VQp1dbPJRBiwtY8ybSeQpkqwU4lce0p
         ua8lTh72X/bTWX1uFercec6E1TYN9pqZ+pIPi9M4gu4z7rmygORfVX9eAare/XMArw3d
         9IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9AymPPffeIR1VQQPaQ/nzlIfZdjrOkxBeqoJZ0QW7Q=;
        b=iMASsIvlR356i7AduT/dfpez3tbKNT+PT+sx8t4DGgWLEH01YpzhAiHWr5nOo3dbMw
         f2mi4ljGT8l6JDlOVF27fnUGQiA59XrzL2Ch++E4k+RKy+Jubc6xgQilY+LPdbX0gi0i
         U/zuV3jr6KPiWZnpm8csWqGn637jqZi8pYr9rakYrEIk9cfz7P1unRzHhGY8i9p2Zv1B
         lrj2vj6KcuEkoi1BNmD1i6hrBB+DvAHqzKo4vWlV6PhojrIOKNa5S4DcHd9ngwqGFOG5
         b6Vvj9241K9BN8OiejnLhE32F/ufqo7Y0+z9kJ3rFZKB51FjpGPdF1k+As7kRcHIrrZK
         0xVg==
X-Gm-Message-State: AOAM533hS1VE/hf3PKm/PI24tmHibSolw2Q8sYgjH/XgTT89j/503dYP
        PhtTj8I6Og9pbHLBRw/tRaM=
X-Google-Smtp-Source: ABdhPJwKmWKXAYuoYaGrhEXXA0EBVG5iWfr3EaP0Y73mI+/FRVnIsYoqUZ5CgX8LP1Z3jVbZL4+ycQ==
X-Received: by 2002:a17:902:ce87:b0:163:fc5e:398b with SMTP id f7-20020a170902ce8700b00163fc5e398bmr25674640plg.125.1654551859268;
        Mon, 06 Jun 2022 14:44:19 -0700 (PDT)
Received: from localhost.biz ([8.25.197.27])
        by smtp.gmail.com with ESMTPSA id a4-20020a170903100400b0016397da033csm10881675plb.62.2022.06.06.14.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:44:18 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [mm-unstable v3 PATCH 0/7] Cleanup transhuge_xxx helpers
Date:   Mon,  6 Jun 2022 14:44:07 -0700
Message-Id: <20220606214414.736109-1-shy828301@gmail.com>
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

Added transhuge_vma_size_ok() helper to remove some duplicate code.


Yang Shi (7):
      mm: khugepaged: check THP flag in hugepage_vma_check()
      mm: thp: introduce transhuge_vma_size_ok() helper
      mm: khugepaged: remove the redundant anon vma check
      mm: khugepaged: use transhuge_vma_suitable replace open-code
      mm: thp: kill transparent_hugepage_active()
      mm: thp: kill __transhuge_page_enabled()
      mm: khugepaged: reorg some khugepaged helpers

 fs/proc/task_mmu.c         |  2 +-
 include/linux/huge_mm.h    | 84 ++++++++++++++++++++++++++++------------------------------------------
 include/linux/khugepaged.h | 21 ++----------------
 mm/huge_memory.c           | 64 +++++++++++++++++++++++++++++++++++++++++++++--------
 mm/khugepaged.c            | 78 +++++++++++++++--------------------------------------------------
 mm/memory.c                |  7 ++++--
 6 files changed, 114 insertions(+), 142 deletions(-)


