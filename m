Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CB453BE0A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbiFBSWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbiFBSWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:22:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E18F6436
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:22:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso5530700pjg.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZg9G1Jigxu5VDpW1ndUwDTe9Jmg6ruXCB1hvTF+Mu4=;
        b=AmECwCzRA2ye4WTB6kLWt8TCEMR0BwnaoJniQW+diXxpJMhv2pFkKM76UsI2sS8jSg
         9irwS2emrAQ1ekIn5UJKoPDsuv0Y0bLe5KqAUngC4QiTn3DaHf/HzA+lFeV+96LBE99i
         NzvKttHRRLZriAcsH4xrR6Q5v6kmAuiWiUZaSZRn0HH53gU48s36hB3/dCTEkkkBeY24
         GvJ3wpUwmHtj1CQhG4aZTZv/waE+MI0lZbU6qvxsWpoNxsB+e0ljiFCh4C4VpPVleU0m
         C7ET3J077c1nCRhRjMQO87GNMnfmxBgUjYsaWBxTLiUty+r1AQXtDXH7wMbsAFONOvwI
         e6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZg9G1Jigxu5VDpW1ndUwDTe9Jmg6ruXCB1hvTF+Mu4=;
        b=ojezjzcJrsrmwHH3fWUeDJFfxy++dVWZ97zhZSKor1cKcIwjDMWRWpKZ3rOcfyqTfT
         AJ/rJ0GEDdqAM8ZQebSHOyfESUcPbZUMNwOAvbWYKuQ3IEUy4GKO1UWQn9Zf/x/9YZod
         rkSCQHpw8ZVk+Vpj5aqPn4B/x8XF75hcvyNkft1e65/vCb9eeh39qgkw0+uLpbMZmrZZ
         LNmRMNXNuR0v79Ri8CckpRPjkYIaUJ8NmQYmuPUNXx/tiy73WDAyAYNEsh/6SllaR/vI
         jLlZlbBlOH/vUA07s97iPYU/52UPU5RjckgY69fsGbCvO1n040+wu4i+pACkUh4ehH8D
         K7rw==
X-Gm-Message-State: AOAM531AtIuzjrn14avT35gyFmev33ODWmcqDKcdnrsyfRnDxzo4emFL
        e8IYnCUnzhzMHBLJ7LwVKFk=
X-Google-Smtp-Source: ABdhPJzjVsqBnFCFU8qYje4nhCFPAu9tWLe2d7fZ3U4X/OcnEhKtSWq398rkFx0fPUZvwq/2zuORpw==
X-Received: by 2002:a17:903:25c1:b0:164:1517:e8c3 with SMTP id jc1-20020a17090325c100b001641517e8c3mr6325632plb.116.1654194123822;
        Thu, 02 Jun 2022 11:22:03 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709027fca00b0015f2d549b46sm3866779plb.237.2022.06.02.11.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 11:22:03 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [mm-unstable v2 PATCH 0/7] Cleanup transhuge_xxx helpers
Date:   Thu,  2 Jun 2022 11:21:52 -0700
Message-Id: <20220602182159.248387-1-shy828301@gmail.com>
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

