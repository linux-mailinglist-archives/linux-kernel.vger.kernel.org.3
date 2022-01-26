Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A52B49D1BA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbiAZSef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiAZSed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:34:33 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09745C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:34:33 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id g11so637975qvu.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4IovCRgH1RgHp4B3YVZ3j1Sxx63RD9XOtaeQVlJ6EjA=;
        b=cgAboSEa2W3SDny9D7uPpojRwRaMozw8cHMX9fJDnnoYIt2ZF3kZgYqcM+UJ5kUXkc
         Gb6s+Ho6OMevgVCAwfmvOvEFeHwQ/AwdBskRgB/cidmB8cWSA1HK9MwxqxCFiuOQbGob
         icfvcRmSoXHFvXIKwOkQ22NN+lY0HcDy+0rTuKiUhFH7i1CGpENDtl+rRgXlfnm99wwg
         sBnlcfCOKf3ZFzhOW4PSP5fo5TfOHkY2iUwFVWs6kCzJAJfmcNyb7jER3yTKHMAJf8qC
         p5HCWtJ/rVWsBFyq9TMqBun1yR2U+WcTAYkjtqY6iHv+Nde5v7BO4pJszzR7Vi7pJYxI
         8vXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4IovCRgH1RgHp4B3YVZ3j1Sxx63RD9XOtaeQVlJ6EjA=;
        b=ICvm5XxWJ+YrmPwvU45wN1FayyRVtRE4Xczie3RrMoxpqFcUO1HzsoLyyvQZdAIwld
         1Mx5wQiC2PUkkLpd8NNSUzRf38hR+IhMN+8wEGxMP2qSFoc7oF4npivMledM2bbfzggB
         U30z98gNPcEakRk3JotcQ2Hfp0VBTItf44e3WStTPYZAdU/pZXiZh4tmtvIHraDKgZ6x
         dAGzkgSDtDtNhCpql09p3Oak32lrj+A921XWuIqKlDvI1mARlKssuP4MyYrNrXLNZxx4
         Dau6D2CQtM4vm8dfZr1uj/CqL2GvNYStsEFCKmDQof3G+lt8RI5KcAVk9MnRD7/5v2tB
         d3Cw==
X-Gm-Message-State: AOAM533I0XHvDuh3HOzU+HCEQc0Fvl2t251Na9/upxRBRcTRUupFngGi
        V//dkVJwo6SkrNentL3OKrOhtg==
X-Google-Smtp-Source: ABdhPJzpUIaLSRUPyh5LBumbcaXtMQrxMKylayajsZz55yXuQrU4tEv8317y9zTEIig6tVf5vHdguw==
X-Received: by 2002:a05:6214:262d:: with SMTP id gv13mr25607644qvb.1.1643222072145;
        Wed, 26 Jan 2022 10:34:32 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id u17sm35886qki.12.2022.01.26.10.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:34:31 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com, rientjes@google.com,
        pjt@google.com, hughd@google.com
Subject: [PATCH v3 0/9] Hardening page _refcount
Date:   Wed, 26 Jan 2022 18:34:20 +0000
Message-Id: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v3:
- Sync with the latest linux-next
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

Applies against next-20220125.

Previous verions:
v2: https://lore.kernel.org/all/20211221150140.988298-1-pasha.tatashin@soleen.com
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
2.35.0.rc0.227.g00780c9af4-goog

