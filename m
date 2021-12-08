Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7FE46DD25
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbhLHUjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbhLHUjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:39:20 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06111C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:35:48 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id p19so3345081qtw.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 12:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UcwIfa9Q1MTq8zG33ugFYvbjeTEPFMdkgQsXOakzRUs=;
        b=YlACTCnGc24GsFKawqgHfolnYdISsTq88d/0YI/6NrvyZdGTFgH83rF9U4pEADNk6h
         RYDEa8F+P+3i6QJdRd6Z/IeU4p1M+TSO5sjdKJw2/U3dsSrCzgdgevt2LqqBNsF5bztz
         ZENs+r3asp1MEKOsRCaDRDhGC9yFkTrkD/RF0Hxb4WoTZCLiB2EYC+6G2lAEajJqgvvw
         7RjJZkF4J73rUI2H9lTZwexOcc4JQrEC9m590YhaEILyBkhAI6WdhOLIXsYaJzxMxvD9
         AmcgFBWhTv+ksvYm712A6uDYB7/NL3yZGcw0gBcd7vLVSTTcAyNTL+0UOjIHhc609uWb
         Pfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UcwIfa9Q1MTq8zG33ugFYvbjeTEPFMdkgQsXOakzRUs=;
        b=p0hU33EL7E0Kbska7zp2xSWXC4FMzNBH88p7zrfyo+JSQoqzOLrjc1ZYh0J09Xg97x
         IIiSkxUuUtXOZK6FXQcNwbqNNJetx6hQUW6SimhIxU8ii1sOYrkyjSpzZpKRZLLNBxZU
         PyjeYQE+fXZ3ks0RWtEqZTu0dYd1K7A87TWnjekWi1qm39rvs8JIBX6lUbUKkO6wMZaZ
         Ed7qmbBqZpc+QImzkSiFLMS9E2zDlJiG4YNGVq+8qWz2yo+oa66XqFXbAdfBijCnznBo
         5pIMUo+gwT4r9uPXecs8Bb6WlhJUyHgVFT5fNhZ4ZTio5v5Y/RazWvvxCFu6M0D0h55T
         /u6g==
X-Gm-Message-State: AOAM530XmMRuL/GJF9YMCB2a8nzomL1sC4WfnKZuNeVYIrstjKpdWg61
        n8puz4uYHRgB/biwaHckknQyow==
X-Google-Smtp-Source: ABdhPJwRtSIS9JHVQruIhtRtSiWxusJu07ubKDoUdrUWvGS4ssN4aSSNDnM0cJSn6V5VUznWrOLgjg==
X-Received: by 2002:a05:622a:1483:: with SMTP id t3mr11082168qtx.518.1638995747143;
        Wed, 08 Dec 2021 12:35:47 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 143sm1898710qkg.87.2021.12.08.12.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:35:46 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com, rientjes@google.com,
        pjt@google.com
Subject: [PATCH 00/10] Hardening page _refcount
Date:   Wed,  8 Dec 2021 20:35:34 +0000
Message-Id: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v1:
- sync with the latest linux-next
RFCv2:
- use the "fetch" variant instead of "return" of atomic instructions
- allow negative values, as we are using all 32-bits of _refcount.


It is hard to root cause _refcount problems, because they usually
manifest after the damage has occurred.  Yet, they can lead to
catastrophic failures such memory corruptions. There were a number
of refcount related issues discovered recently [1], [2], [3].

Improve debugability by adding more checks that ensure that
page->_refcount never turns negative (i.e. double free does not
happen, or free after freeze etc).

- Check for overflow and underflow right from the functions that
  modify _refcount
- Remove set_page_count(), so we do not unconditionally overwrite
  _refcount with an unrestrained value
- Trace return values in all functions that modify _refcount

Applies against next-20211208.

Previous verions:
RFCv2: https://lore.kernel.org/all/20211117012059.141450-1-pasha.tatashin@soleen.com
RFCv1: https://lore.kernel.org/all/20211026173822.502506-1-pasha.tatashin@soleen.com

[1] https://lore.kernel.org/all/xr9335nxwc5y.fsf@gthelen2.svl.corp.google.com
[2] https://lore.kernel.org/all/1582661774-30925-2-git-send-email-akaher@vmware.com
[3] https://lore.kernel.org/all/20210622021423.154662-3-mike.kravetz@oracle.com

Pasha Tatashin (10):
  mm: page_ref_add_unless() does not trace 'u' argument
  mm: add overflow and underflow checks for page->_refcount
  mm: Avoid using set_page_count() in set_page_recounted()
  mm: remove set_page_count() from page_frag_alloc_align
  mm: avoid using set_page_count() when pages are freed into allocator
  mm: rename init_page_count() -> page_ref_init()
  mm: remove set_page_count()
  mm: simplify page_ref_* functions
  mm: do not use atomic_set_release in page_ref_unfreeze()
  mm: use atomic_cmpxchg_acquire in page_ref_freeze().

 arch/m68k/mm/motorola.c         |   2 +-
 include/linux/mm.h              |   2 +-
 include/linux/page_ref.h        | 159 +++++++++++++++-----------------
 include/trace/events/page_ref.h |  99 +++++++++++++++-----
 mm/debug_page_ref.c             |  30 ++----
 mm/internal.h                   |   6 +-
 mm/page_alloc.c                 |  19 ++--
 7 files changed, 180 insertions(+), 137 deletions(-)

-- 
2.34.1.400.ga245620fadb-goog

