Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831595284C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbiEPMzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243613AbiEPMy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:54:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C314B3A5C3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:53:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so10843255wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KVPhUnjtby93H1A1uu/hc4Ko2DVpGt4uhH1faHyityo=;
        b=XllTgNYK50kbDMyE4dyj5x0qu8CtLWg5XpRR9eNfxroTcObnNNxtEtVnFy+w2hyVNz
         LWHe4GKmSaj+24mz/CvwS9Z6/tvBfWPCh0u4pR8T8/Hp2Ux4ztCAlNXCRgSF2R3eMiNt
         yuktsXLDqqjhKMCIM0g2AM7wguoyBjHqlrRPuJBmbjDuNS2/3C3oXCbgqmmXChRldavi
         dU4VOzbV4yJMLPuf0V6g2sYUj4XDWZGd3OR6r8hPiPQ5Xghsf3P+ZjKCL5Mzx0hnmJmB
         mSYx3cfFHk/x6b0Tnud7aLMe0DE8V1SyJTZfO4obXZNNpb7LMplZgKQc/kJjxOhV1lPz
         ofJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KVPhUnjtby93H1A1uu/hc4Ko2DVpGt4uhH1faHyityo=;
        b=zQ/3aVshje0xOdO/pN8dii1PMhoG2IDstYkAiLxjJqc3aYpekv7fwr/FZZJSuqKMUl
         hGjZX2Cuo0G1bkEcOg3JZ5ZNgEp8ZkKFk4dXoqxDGAWoRGGPEDPL7phOMRC+04vSO0KG
         55DgT3q2eY6ir5iUWuBt8DzFr/rbBlxlJd6P8XRZK6OIKVTL+kkH9ZfScfQdJmEfnCh6
         ZrjYaVczgt+OqkKpj0pDd3Wvytom+zqm+bbUJdZdsC9ft9Xher++VurM92zdts9RhryQ
         dCIaKzIZju5aJrJv11S1+Qc7eA0YhsGMxWjrzmgVHFmwJXQXdKXc8wjsg4DSKul7YDLx
         DUUQ==
X-Gm-Message-State: AOAM530X7levYkWxIZ5CGC3HsLuyc0kgRDIo0WfD41dJw8DFz3W0WR1L
        Ne0cftwmtHP8S0v1WymAWqY=
X-Google-Smtp-Source: ABdhPJz836i6dyGykr8mqqydrdqtrl2t/GqFcsjXQE6SUcFQQ98MmBNXIlmgtRUQ79168UBbsAaoQg==
X-Received: by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP id p186-20020a1c29c3000000b003509797b38fmr27109456wmp.22.1652705626773;
        Mon, 16 May 2022 05:53:46 -0700 (PDT)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id d6-20020adfc086000000b0020c5253d8fcsm11550041wrf.72.2022.05.16.05.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:53:45 -0700 (PDT)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 89B18A0E75; Mon, 16 May 2022 14:54:07 +0200 (CEST)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     linux-mm@kvack.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        kirill@shutemov.name, riel@surriel.com, rostedt@goodmis.org,
        peterz@infradead.org, david@redhat.com,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [RFC PATCH v3 0/6] Removing limitations of merging anonymous VMAs
Date:   Mon, 16 May 2022 14:53:59 +0200
Message-Id: <20220516125405.1675-1-matenajakub@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of patches that try to improve merge success rate when
VMAs are being moved, resized or otherwise modified.

Motivation
In the current kernel it is impossible to merge two anonymous VMAs
if one of them was moved. That is because VMA's page offset is
set according to the virtual address where it was created and in
order to merge two VMAs page offsets need to follow up.
Another problem when merging two faulted VMA's is their anon_vma. In
current kernel these anon_vmas have to be the one and the same.
Otherwise merge is again not allowed.
There are several places from which vma_merge() is called and therefore
several use cases that might profit from this upgrade. These include
mmap (that fills a hole between two VMAs), mremap (that moves VMA next
to another one or again perfectly fills a hole), mprotect (that modifies
protection and allows merging with a neighbor) and brk (that expands VMA
so that it is adjacent to a neighbor).
Missed merge opportunities increase the number of VMAs of a process
and in some cases can cause problems when a max count is reached.

Solution
The series solves the first problem with
page offsets by updating them when the VMA is moved to a
different virtual address (patch 4). As for the second
problem, merging of VMAs with different anon_vma is allowed under some
conditions (patch 5). Another missed opportunity in the current kernel
is when mremap enlarges an already existing VMA and it is possible to
merge with following VMA (patch 2). Patch 1 refactors function
vma_merge and makes it easier to understand and also allows relatively
seamless tracing of successful merges introduced by the patch 6. Patch
3 introduces migration waiting and rmap locking into the pagewalk
mechnism, which is necessary for patche 4 and 5.

Limitations
For both problems solution works only for VMAs that do not share
physical pages with other processes (usually child or parent
processes). This is checked by looking at anon_vma of the respective
VMA and also by looking at mapcount of individual pages. The reason
why it is not possible or at least not easy to accomplish is that
each physical page has a pointer to anon_vma and page offset. And
when this physical page is shared we cannot simply change these
parameters without affecting all of the VMAs mapping this physical
page. Good thing is that this case amounts only for about 1-3% of
all merges (measured on jemalloc (0%), redis (2.7%) and kcbench
(1.2%) tests) that fail to merge in the current kernel.
Measuring also shows slight increase in running time, jemalloc (0.3%),
redis (1%), kcbench (1%). More extensive data can be viewed at
https://home.alabanda.cz/share/results.png

Changelog
Pagewalk - previously page struct has been accessed using follow_page()
which goes through the whole pagewalk for each call. This version uses
walk_page_vma() which goes through all the necessary pages at the pte
level (vm_normal_page() is used there).
Pgoff update was previously performed at the beginning of copy_vma()
for all the pages (page->index specifically) and also for the pgoff
variable used to construct the VMA copy. Now the update of individual
pages is done later in move_page_tables(). This makes more sense because
move_page_tables() moves all the pages to the new VMA anyway and this
again spares some otherwise duplicate page walking.
Anon_vma update for mprotect cases is done in __vma_adjust(). For
mremap cases the update is done in move_page_tables() together with
the page offset update. Previously the anon_vma update was always
handled in __vma_adjust() but it was not done in all necessary cases.
More details are mentioned in the concerned patches.

Questions
Is it necessary to check mapcount of individual pages of the VMA to
determine if they are shared with other processes? Is it even possible
when VMA or respectivelly its anon_vma is not shared? So far as my
knowledge of kernel goes, it seems that checking individual pages is not
necessary and check on the level of anon_vma is suficient. KSM would
theoretically interfere with page mapcount, but it is temporarily
disabled before move_vma() in mremap syscall happens. Does anyone know
about something else that can change mapcount without anon_vma knowing?

This series of patches and documentation of the related code will
be part of my master's thesis.
This patch series is based on tag v5.18-rc2. This is a third version.

Jakub Matěna (6):
  mm: refactor of vma_merge()
  mm: add merging after mremap resize
  mm: add migration waiting and rmap locking to pagewalk
  mm: adjust page offset in mremap
  mm: enable merging of VMAs with different anon_vmas
  mm: add tracing for VMA merges

 fs/exec.c                   |   2 +-
 fs/proc/task_mmu.c          |   4 +-
 include/linux/mm.h          |   4 +-
 include/linux/pagewalk.h    |  15 +-
 include/linux/rmap.h        |  19 ++-
 include/trace/events/mmap.h |  83 ++++++++++
 mm/internal.h               |  12 ++
 mm/mmap.c                   | 291 ++++++++++++++++++++++++++----------
 mm/mremap.c                 | 153 ++++++++++++++-----
 mm/pagewalk.c               |  75 +++++++++-
 mm/rmap.c                   | 144 ++++++++++++++++++
 11 files changed, 670 insertions(+), 132 deletions(-)

-- 
2.35.1

