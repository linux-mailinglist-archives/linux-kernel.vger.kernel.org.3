Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D98B468706
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 19:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385425AbhLDS07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 13:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385390AbhLDS0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 13:26:43 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F05C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 10:23:18 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id i13so6108636qvm.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 10:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYwuZ/sEadeZKn/jRvBALrzeKfNoxtQyFuxWcbP5Juc=;
        b=gQVWJX0xTe58lbhoVauJqMvrsEZbFOOlnV0B23iGJlqluON8ZwAlAoYwQ69wFt4sbj
         gjktJgCgkNNW/swRJLOt/eu6yVKpt0DXXXChaa+6AohLM0onwGfU/FFu7XR6YA42xAwj
         g8w1UxndUiImJ7+ZaFEuqnqus/Cb9dcUWcuasRYKIoMUZ2e806IopHHC1ZfTU/mfjJqn
         2ovBjuUSyCh5V2Lj8auOSBg82UN8lovFY8pz+Wp+ErjLC9rehRuM2srigJx7zrHNZDOw
         CnTnb66J/PyoB0R/cQ4tQ/vFuXh9o3TZEb9XD9FM9l6CzMwlLNo9xxn+z5oQU2p1az86
         QPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYwuZ/sEadeZKn/jRvBALrzeKfNoxtQyFuxWcbP5Juc=;
        b=rWdaXDRwL20eqNuBNNH4j4vNHicYTFpygDhUX91DDdclwOL4ZWbNRjenU8h+YJLoNd
         r39DkaMmXcKhWO5CS+hhH2EdwcpCks0P6Pre4/o6zbOj54OwNMBkxR0AJOuiiB4NpPgh
         Cvvxidwx7LfbwFrQhDzRDXrHoL4Ld3riW2e8dm1H5ep5WVxdPgY0Lmn9XqLFM5Y3Erqc
         S62SP4yvdnl/NA6hvSL6139hVHdnZW0gQ19AviwslGf9tFBOYpVNZXFq7l2HXaPXf/e8
         UTRow5j2+CNddo9z6Pgadm6t7zpPSLNTDpSGMmlPfj+kn6yhooKLp2rVQkPMGegzUUT6
         Szkg==
X-Gm-Message-State: AOAM533cvUYc645FNMZpgn/LnQtL6v9zNhI4SsFwkeVUiu0GjtR7igLv
        AxpcQER3PceawNss7BsO2SvoDA==
X-Google-Smtp-Source: ABdhPJzW07805BiK+FDS928MEvbtQ75zMukaE1HCYO96Pw+WEidTB2GTrnXkNiWWCzRiY+UhvnJnCw==
X-Received: by 2002:ad4:5c67:: with SMTP id i7mr27103370qvh.37.1638642197155;
        Sat, 04 Dec 2021 10:23:17 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id a24sm4394728qtp.95.2021.12.04.10.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 10:23:16 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, rientjes@google.com, pjt@google.com,
        weixugc@google.com, gthelen@google.com, mingo@redhat.com,
        corbet@lwn.net, will@kernel.org, rppt@kernel.org,
        keescook@chromium.org, tglx@linutronix.de, peterz@infradead.org,
        masahiroy@kernel.org, samitolvanen@google.com,
        dave.hansen@linux.intel.com, x86@kernel.org, frederic@kernel.org,
        hpa@zytor.com, aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com
Subject: [PATCH v2 0/4] page table check
Date:   Sat,  4 Dec 2021 18:23:10 +0000
Message-Id: <20211204182314.1470076-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v2:
- Fixed bug reported by Fushan Wen
  The root cause was that in do_swap_page() we first add page table entry
  and only later change its type to anon.
- Added EXPORT_SYMBOL() to functions which are called from set_pte_* type
  functions.
- Replaced DEFINE_STATIC_KEY_TRUE_RO with DEFINE_STATIC_KEY_TRUE to fix
  issue with module load/unload as reported and root caused by Jiri Slaby

v1:
- Added ptep_clear() to mm/debug_vm_pgtable.c (thanks Anshuman Khandual)
- Addressed documentation comments from Jonathan Corbet.

Ensure that some memory corruptions are prevented by checking at the
time of insertion of entries into user page tables that there is no
illegal sharing.

We have recently found a problem [1] that existed in kernel since 4.14.
The problem was caused by broken page ref count and led to memory
leaking from one process into another. The problem was accidentally
detected by studying a dump of one process and noticing that one page
contains memory that should not belong to this process.

There are some other page->_refcount related problems that were recently
fixed: [2], [3] which potentially could also lead to illegal sharing.

In addition to hardening refcount [4] itself, this work is an attempt to
prevent this class of memory corruption issues.

It uses a simple state machine that is independent from regular MM logic
to check for illegal sharing at time pages are inserted and removed
from page tables.

[1] https://lore.kernel.org/all/xr9335nxwc5y.fsf@gthelen2.svl.corp.google.com
[2] https://lore.kernel.org/all/1582661774-30925-2-git-send-email-akaher@vmware.com
[3] https://lore.kernel.org/all/20210622021423.154662-3-mike.kravetz@oracle.com
[4] https://lore.kernel.org/all/20211026173822.502506-1-pasha.tatashin@soleen.com

Previous versions:
v1: https://lore.kernel.org/all/20211123214814.3756047-1-pasha.tatashin@soleen.com/
RFC: https://lore.kernel.org/all/20211116220038.116484-1-pasha.tatashin@soleen.com

Pasha Tatashin (4):
  mm: change page type prior to adding page table entry
  mm: ptep_clear() page table helper
  mm: page table check
  x86: mm: add x86_64 support for page table check

 Documentation/vm/arch_pgtable_helpers.rst |   6 +-
 Documentation/vm/index.rst                |   1 +
 Documentation/vm/page_table_check.rst     |  56 +++++
 MAINTAINERS                               |   9 +
 arch/Kconfig                              |   3 +
 arch/x86/Kconfig                          |   1 +
 arch/x86/include/asm/pgtable.h            |  29 ++-
 include/linux/page_table_check.h          | 147 ++++++++++++
 include/linux/pgtable.h                   |   8 +
 mm/Kconfig.debug                          |  24 ++
 mm/Makefile                               |   1 +
 mm/debug_vm_pgtable.c                     |   2 +-
 mm/khugepaged.c                           |  12 +-
 mm/memory.c                               |   7 +-
 mm/page_alloc.c                           |   4 +
 mm/page_ext.c                             |   4 +
 mm/page_table_check.c                     | 270 ++++++++++++++++++++++
 17 files changed, 566 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/vm/page_table_check.rst
 create mode 100644 include/linux/page_table_check.h
 create mode 100644 mm/page_table_check.c

-- 
2.34.1.400.ga245620fadb-goog

