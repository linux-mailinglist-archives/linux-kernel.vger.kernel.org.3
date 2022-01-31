Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8FE4A5029
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349931AbiAaUc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiAaUcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:32:54 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33849C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:32:54 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id b5so12540085qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M9bJkWIxdplxM33vp/vaahjmYZYfOtnMQWqcHJyRGQo=;
        b=UnO4XGFkeRTflixRXkT5Qf9epZSfzdbOgDE2e8Aj93hJv4zvVQvhzksjJt0NYEm4ka
         phBngWzQ7BuZNTSQzOG+LV/9ozMlE9QqsLwMcPmqHeATMhHLtqWrAqq/mYnQDtut1zsI
         bN6d7QeM+SyyeUMTOkvC4EeCbPWDyStYkTqMpUcpmuJZOaAx1doFglokuOoUuMJ9H+7s
         4VccCE/CZropjwtu+1JEOjo07dLGLq12LMqxuvD7jHnAlfFE0EAlMX6qrTTYVIHMYn5r
         hQk91HgluZehXwuerL5TwodhantJKuSpazg4wu2gpHtT3VGJgeq8x7+pD3tV1CwbiiNu
         LUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M9bJkWIxdplxM33vp/vaahjmYZYfOtnMQWqcHJyRGQo=;
        b=PfBmda2LiOmOtgQGJxa3WFf1F+9FluPhV/viGnigfPXusALKcOhzKRULO4j+3ny3oU
         tuLK4ENNxqQkJ8s+CvErIyFXC1nYTiIYBIc2+5kg/oN5uqKBm1RWbMy3eA705n08qeOR
         nTLcOZaVBE6jdNTlCXi6CE1/1PWju3BBtD8IHWmHgkHmsBNZgG2RXCtMUX/ZfS9p6LPm
         uvbCGQHNLJlxmayfimLbmpRDml/qLAMlRt9WCIhu6D8kJmV5HJ2DJzFT0CPFUKir60Mq
         1kkU0bbT2OhsSDmh5PsxUMRpPh+HiQ4Q43SKclU/7/zUVZckdbg2e9AGUqjCN+gAPVFQ
         scpg==
X-Gm-Message-State: AOAM530orFQeYcLrF77jFDm3suiidC5M2AtYoSCDvle7lpUwRmC1INfo
        L08uQsaO1JxW1u/1epD1CIV3/A==
X-Google-Smtp-Source: ABdhPJwZY02U9jdJ67/vnrhOchekBjrA8W5GbEYziRVhN+Ubguzy+7BKvcGeFzK5vX3XpU6d7/+4IQ==
X-Received: by 2002:a05:622a:13cf:: with SMTP id p15mr16566805qtk.389.1643661173304;
        Mon, 31 Jan 2022 12:32:53 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id j14sm5349661qko.10.2022.01.31.12.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:32:52 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v5 0/4] page table check fixes and cleanups
Date:   Mon, 31 Jan 2022 20:32:45 +0000
Message-Id: <20220131203249.2832273-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pasha Tatashin <tatashin@google.com>

Changelog:
v5:	- Renamed page_table_check_pmd_clear_full() ->
	  page_table_check_clear_pte_range().
	  Removed call to __page_table_check_pmd_clear() from this
	  function.
	- Added Acks.
v4:	- Addressed review comments from David Rientjes
	- Added Acks.
v3:	- Resolved a regression introduced in previous version, where
	  page collapse in khugepaged would cause crash on boot.
	- Addressed comments from Anshuman Khandual regarding commit
	  log.
v2:	- Addressed simplification comments from Wei Xu
	- Added Review-by/Tested-by's from Zi Yan and Wei Xu


Two fixes:

  mm/debug_vm_pgtable: remove pte entry from the page table
	- remove a pte entry from the page table at the end of
	  debug_vm_pgtable pte test

  mm/khugepaged: unify collapse pmd clear, flush and free
  mm/page_table_check: check entries at pmd levels
	- check pmd level in page_table_check for PTE regular entries
	  prior to freeing.
	  repro.c: https://gist.github.com/soleen/fdcd501d5df103976245fe84e9535087
	  config: https://gist.github.com/soleen/8a56f923c2fea9ce9c75b4e2517d4162
	  qemu_script: https://gist.github.com/soleen/f4be4795826b7ab1a51ae659582e179c
	  base image:
	  https://storage.googleapis.com/syzkaller/wheezy.img
	  https://storage.googleapis.com/syzkaller/wheezy.img.key

Small cleanup:
  mm/page_table_check: use unsigned long for page counters and cleanup

Previous versions:
v1: https://lore.kernel.org/all/20220120042513.1648831-1-pasha.tatashin@soleen.com
v2: https://lore.kernel.org/all/20220120191250.2671557-1-pasha.tatashin@soleen.com
v3: https://lore.kernel.org/all/20220126060514.1574935-1-pasha.tatashin@soleen.com
v4: https://lore.kernel.org/all/20220126183637.1840960-1-pasha.tatashin@soleen.com

Pasha Tatashin (4):
  mm/debug_vm_pgtable: remove pte entry from the page table
  mm/page_table_check: use unsigned long for page counters and cleanup
  mm/khugepaged: unify collapse pmd clear, flush and free
  mm/page_table_check: check entries at pmd levels

 include/linux/page_table_check.h | 19 +++++++++++
 mm/debug_vm_pgtable.c            |  2 ++
 mm/khugepaged.c                  | 37 +++++++++++----------
 mm/page_table_check.c            | 55 ++++++++++++++++----------------
 4 files changed, 69 insertions(+), 44 deletions(-)

-- 
2.35.0.rc2.247.g8bbb082509-goog

