Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5417949C370
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiAZGF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbiAZGFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:05:18 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0767AC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:05:18 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id o9so23893542qvy.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8PiQqXhI0asxLO+FZ+u7NyXhLFJh+Rha3MB+YCukq+Q=;
        b=M978v7tjWc3gOWFuhudGrYpwJwQVbjbwWSLRYqFio6nqeC7nAdmwks9kUjQjKfpA6S
         W5TzDF8YfTGKnCO1shCGqZIdYD2MxOkQGyNnaWB9G2vtxPlh713auyXlJ6zLDbFHqy4w
         iLwMYUt23pDEL+G6SsNfA/kRRBk0Xv0dhq+30F4ruGVrHsSvqWh8cKZDxXp942Z00kCr
         MepaZUvXkwJ/SEcXeHuJnhVB2kOVG22d0s5MaOaDz8mO++dmBYrTLyxSjjqVXRvL0LlA
         dAbNymRzQdVmBZ9QySkJLrmBFU7HUdw9dpD6isFxuGG50t4D4g60m/rqs7xV3WILkNFd
         TPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8PiQqXhI0asxLO+FZ+u7NyXhLFJh+Rha3MB+YCukq+Q=;
        b=hr3l2hzZdzO1/6IYAXNWV1/Qejt+gmzzPtOjFIQQdx+SEo+NoCvuzjvXxCDtYDka9B
         zGqkq1N4i5OSoFvEC4XwLSvz5RmR1hZyiJsRhxrRVZNiQaCT+bBmumrtqo7tN7312Js1
         s7u7hX0MY84O0gT4ZYzsKAXD23+kiMrHm9Rrz990K7XWCpidnRYqKY1zcD+LiQZ4l4Uo
         KsrszcXykWSLaV/7RD5BLPSfRQN/0pV5Tm/A7rsbBSKfAtYqJkz4S5OWfn0/cXW7rFWP
         mFHR6YpQX2VAhOn+Cpe8XZ3Ez8Wrb5Je8UCJ2XKfQPOFoCKQ9/egYWD7Zh8Y5H7h0FBR
         f/Zg==
X-Gm-Message-State: AOAM533v1q/CXAKC9LBpSFPGp/mnlt/1qJ0DDoBQGQHdbNxw6GStlOYs
        41CBQs+PTKhSOayFUyrRFHbFKA==
X-Google-Smtp-Source: ABdhPJxIsut29jbbnVAkvBpwK8BOoN2H0+yE4C7BCjvp+eQjhgoh/9lIrr2/RPKunvKBzF8bItetjA==
X-Received: by 2002:a05:6214:2307:: with SMTP id gc7mr22689543qvb.77.1643177117155;
        Tue, 25 Jan 2022 22:05:17 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id o19sm9856699qta.40.2022.01.25.22.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 22:05:16 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v3 0/4] page table check fixes and cleanups
Date:   Wed, 26 Jan 2022 06:05:10 +0000
Message-Id: <20220126060514.1574935-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pasha Tatashin <tatashin@google.com>

Changelog:
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

Pasha Tatashin (4):
  mm/debug_vm_pgtable: remove pte entry from the page table
  mm/page_table_check: use unsigned long for page counters and cleanup
  mm/khugepaged: unify collapse pmd clear, flush and free
  mm/page_table_check: check entries at pmd levels

 include/linux/page_table_check.h | 18 ++++++++++
 mm/debug_vm_pgtable.c            |  2 ++
 mm/khugepaged.c                  | 34 ++++++++++---------
 mm/page_table_check.c            | 56 ++++++++++++++++----------------
 4 files changed, 66 insertions(+), 44 deletions(-)

-- 
2.35.0.rc0.227.g00780c9af4-goog

