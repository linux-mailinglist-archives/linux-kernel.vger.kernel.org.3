Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D8354E8D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiFPRsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiFPRss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:48:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5454C419
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:48:48 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso1277823pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h8VaiU+wdtwucND04NHMKvGiEcGRAR+Ek42xLKO1//A=;
        b=PikuA1lQkVNweJNVfn6BCJXBju5d1DFaJ9fL4AntcPB4EvTITObGabCUoTMC4Agh5v
         eAcgU2U7Nb84ZqgwRmpGKMDKhsS979FlE8SEt+Fzq7sMAc5//f5M24DbxFsEUK1yVaFc
         Snu/uHQlH79PbD8S21Kz4K45Jqcs3T5y3seLR3z3sYsV7f04Uz53ZwWB8e/SpQWGDY3p
         WFVZgDBXllGal6fHOCbofyBQvRfc9dQAh6rQ6GttvJ/6mabZyrX0agrFLAfm0XEXGgIy
         WyNx1/h1QUn0cpBoIj9rHEyRHi+JsTA8PHB+X4MZCCD14UqV0Lo8ctf36e+0alGXsgmy
         9ofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h8VaiU+wdtwucND04NHMKvGiEcGRAR+Ek42xLKO1//A=;
        b=JUtxibiZiSYwnVzqJeyO7T9fGjjKZcQrvtusCBG7aB4SYUN/wOqgEvSaZBxO/K4jhb
         Yi84ZlDwDGezP2Got7n3hx5jLNqaUcKLEetT14Dta9Yp8O/EXlFE5N9M70I9UxKUr5eY
         lkprLEOgnrlOEvE2+V2fcxyNwFI5/rfVsKfeO/VouZU2ytPNefqCZ2TQZvkj0LU4vB0h
         6zVr17aOlWYok7ieLyBCfezLkFDISaGiRjY7EBhBECo8rYd4rf+UNRlz6A+8VpB+tudw
         yyeJHuTQdR80tVzlCFq/ed+a3Ct7v64D7HID2F5J7nJCxMnIkQEimuBfuslzjmDbxvKr
         BYbg==
X-Gm-Message-State: AJIora9MkowR0kl/KCABfCly93eVfYniJGIMMsg8aAFBP2ZYzPZsjkvZ
        I5R8mYDCMf3S2XSFq+aFixM=
X-Google-Smtp-Source: AGRyM1v7tKkwxdWNJ9mjdIS8jxopiWFrNTrXTbrer4mCD+IvQj4oczh1vhpUKF2XMNAK6WYP2ARxPg==
X-Received: by 2002:a17:90b:1b05:b0:1e2:a053:2fad with SMTP id nu5-20020a17090b1b0500b001e2a0532fadmr17088907pjb.209.1655401727540;
        Thu, 16 Jun 2022 10:48:47 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090a8b9500b001e8520b211bsm1818289pjn.53.2022.06.16.10.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 10:48:46 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, zokeefe@google.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [mm-unstable v5 PATCH 0/7] Cleanup transhuge_xxx helpers
Date:   Thu, 16 Jun 2022 10:48:33 -0700
Message-Id: <20220616174840.1202070-1-shy828301@gmail.com>
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


v5: * Removed transparent_hugepage_active() for !THP, per Zach.
      Patch 4/7 and 5/7 were updated accordingly.
    * Collected review tags.
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
 include/linux/huge_mm.h            | 80 +++++++++++++++++++----------------------------------------
 include/linux/khugepaged.h         | 30 ----------------------
 mm/huge_memory.c                   | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
 mm/khugepaged.c                    | 84 +++++++++++++++++++-------------------------------------------
 mm/memory.c                        |  7 ++++--
 7 files changed, 130 insertions(+), 158 deletions(-)

