Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CF447C218
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhLUPBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhLUPBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:01:45 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E5AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:01:45 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id de30so12835678qkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uk8YgK1Ly4Qp8Z1wtUyGc5Gd4Fa8htvQXqStGOTAFlg=;
        b=DLq9Zxo6bIG9zVg+QwTMol+8eThkinUwX4GPZO59PHXMZQ3sk4vS6ndJ7Swp52Hsry
         DlCho1ZYO222nKWdIkh83F1p2NckEPiOArtaQ1reK6PFJBA49twgQJizJbKgj2QAz7pY
         FYU+zt1uwWLqFMvRlY/gETnpAvME3/+BTpRXovIsUNlZljT3ZZi3/fO/AB1KeUVB9L+u
         4npjN+zuWT2A4dX16mVZtYP3xbLkiFgGCEPyZbOxI15DuWAC7rYcBf0loNMe/P6X6F+W
         kqLc8sIQGvcQRDumPH+FSY2LJLVUCgz4Sg5zj1KkTCE3jOqH4X6G9PZkVNgmP5TS8Wy1
         9Xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uk8YgK1Ly4Qp8Z1wtUyGc5Gd4Fa8htvQXqStGOTAFlg=;
        b=Faq4tL+nr0bj/RgCRrXGcs861aAHbDje2NIWVlT/rCdKA9OMcSS1k/H65yoegCc7HW
         KDf2hpBFjviEltH+PFkFftZtQyzYGZhgi86FYZTFwiawntJ/PJKmPwnDfj6avKu/5UGb
         SBLD5GIFIfU6JgRX7OK3tIoMwpXoBZicFQnOkibaa9vk4+op9M7f1H4g4CEdWbas9bCI
         kUf5418IoP1KN7Pxyv3XkJK5JY0Fz3yEn96so464E7rN8tsdzfQ84a/OCwvQF7SUbXfl
         aiJ+2Tv6NDLlg9t/yaIz+pzeazPwTmhiwcX/RsTsZ+iPL44g21j+AuLQ4e9bsLo9GqZ6
         PKVQ==
X-Gm-Message-State: AOAM531k7P2zfiAVQu1iV8yBhJyzG6ODIdhbcYiFGBkAHxRtHPJtBeNC
        DakXUiYlQlbrwr2PYlfvEmYcHUVHperzyQ==
X-Google-Smtp-Source: ABdhPJxT5O7xvrWjkIpZNLBuskaJWMbsvAeuLNSHPXbH7hWO0KuVJ+/DELo8dgq+NUXlN2pM74Zgkg==
X-Received: by 2002:a37:9a82:: with SMTP id c124mr2233404qke.707.1640098904210;
        Tue, 21 Dec 2021 07:01:44 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id d4sm1991371qkn.79.2021.12.21.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:01:43 -0800 (PST)
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
Subject: [PATCH v2 0/9] Hardening page _refcount
Date:   Tue, 21 Dec 2021 15:01:31 +0000
Message-Id: <20211221150140.988298-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pasha Tatashin <tatashin@google.com>

Changelog:
v2:
- As suggested by Matthew Wilcox removed "mm: page_ref_add_unless()
  does not trace 'u' argument" patch as page_ref_add_unless is going
  away.
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

Applies against next-20211221.

Previous verions:
v1: https://lore.kernel.org/all/20211208203544.2297121-1-pasha.tatashin@soleen.com
RFCv2: https://lore.kernel.org/all/20211117012059.141450-1-pasha.tatashin@soleen.com
RFCv1: https://lore.kernel.org/all/20211026173822.502506-1-pasha.tatashin@soleen.com

[1] https://lore.kernel.org/all/xr9335nxwc5y.fsf@gthelen2.svl.corp.google.com
[2] https://lore.kernel.org/all/1582661774-30925-2-git-send-email-akaher@vmware.com
[3] https://lore.kernel.org/all/20210622021423.154662-3-mike.kravetz@oracle.com

Pasha Tatashin (9):
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
 include/linux/page_ref.h        | 149 +++++++++++++++-----------------
 include/trace/events/page_ref.h |  58 ++++++++-----
 mm/debug_page_ref.c             |  22 +----
 mm/internal.h                   |   6 +-
 mm/page_alloc.c                 |  19 ++--
 7 files changed, 132 insertions(+), 126 deletions(-)

-- 
2.34.1.307.g9b7440fafd-goog

