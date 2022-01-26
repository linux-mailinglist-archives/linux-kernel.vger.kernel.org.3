Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EC849D1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244191AbiAZSer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239191AbiAZSee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:34:34 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73ECC061748
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:34:34 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id o9so581051qvy.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4mw64hU1ZpbwSPVpRDpj2TUUxEzGleIpOUNlQVlyvBg=;
        b=F3hPkfc5vl0lCp4Fc8VE6hdllDFjQ/KJ4ChxD81oXql/kI+Wqg+5Eg6mJp84q5ARi0
         bwTA2AeDywIsvmiI0bsQwfYhuw5oHutsV5TEGXWen0Fswl2QklzgqTABOo6pfqUX6H4A
         9iw9QJC5YKH4ek5QFHZ7USKm0q6pF0Hv/5ucF13RYA0PqDHQMv+uzuEM91G9R/l4ehP2
         FKA2+uQkBZtYXRHaOK3gVvGZ6YGKSt/5ZzAzKnPdoMy8jM7rcvPnHIKlRB/z3n0fM5tC
         qw27euVm+4l4GXriH7OI+46l5IztN1E0Q7uHd4+RVdjriFD0RFh1sJb4k12yDj0T6ywZ
         gvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4mw64hU1ZpbwSPVpRDpj2TUUxEzGleIpOUNlQVlyvBg=;
        b=uhuhv8lBVBAjcEKfZkdnB8nrwc05NcXJtHF/0GS4rn9S+JWxmKdVvWD3sblPgMm5tL
         2kv0Bb2iY3E2fZXtaq5u5uMLavDRI1B4/VVZvKzhgUKL6roCc1AYaZdm8ReBVGiHpJsm
         +xby56VQhNGPDWv+6wwfF4PVXchvkEteHZH+56fEjuYcaQNtzNS+ZZl0Aj2IN8A6ByDV
         bXKPzXyUJZOS5NYo06jB/6+fhUS6KT7rVHoaYdLCgSQgxEnkPPg+prJ/26kfEo0xVWz3
         Af39ajc25SW+mOM7cGrr9ePpIchxo+dVma3+CG67DaocZZRvNtZLWL7us4bAIbAbCGxv
         FCRw==
X-Gm-Message-State: AOAM5316lfaaHuoF/IPlAfV5HYt9U1yaGJjja6q3qtAgfzFjQSzN+m/9
        GuTehCcwGQcV2NeCU1SsuGHoTw==
X-Google-Smtp-Source: ABdhPJwb0TuIX2qSbyMJVsMfaoSMdbbLW4f4sRMAfDNGo3TL8yjF/ORtCOVu1ucqYV6uSVM24X6+vg==
X-Received: by 2002:a05:6214:401b:: with SMTP id kd27mr77991qvb.22.1643222073781;
        Wed, 26 Jan 2022 10:34:33 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id u17sm35886qki.12.2022.01.26.10.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:34:33 -0800 (PST)
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
Subject: [PATCH v3 2/9] mm: Avoid using set_page_count() in set_page_recounted()
Date:   Wed, 26 Jan 2022 18:34:22 +0000
Message-Id: <20220126183429.1840447-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
References: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_page_refcounted() converts a non-refcounted page that has
(page->_refcount == 0) into a refcounted page by setting _refcount to
1.

The current apporach uses the following logic:

VM_BUG_ON_PAGE(page_ref_count(page), page);
set_page_count(page, 1);

However, if _refcount changes from 0 to 1 between the VM_BUG_ON_PAGE()
and set_page_count() we can break _refcount, which can cause other
problems such as memory corruptions.

Instead, use a safer method: increment _refcount first and verify
that at increment time it was indeed 1.

refcnt = page_ref_inc_return(page);
VM_BUG_ON_PAGE(refcnt != 1, page);

Use page_ref_inc_return() to avoid unconditionally overwriting
the _refcount value with set_page_count(), and check the return value.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/internal.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 4c2d06a2f50b..6b74f7f32613 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -141,9 +141,11 @@ static inline bool page_evictable(struct page *page)
  */
 static inline void set_page_refcounted(struct page *page)
 {
+	int refcnt;
+
 	VM_BUG_ON_PAGE(PageTail(page), page);
-	VM_BUG_ON_PAGE(page_ref_count(page), page);
-	set_page_count(page, 1);
+	refcnt = page_ref_inc_return(page);
+	VM_BUG_ON_PAGE(refcnt != 1, page);
 }
 
 extern unsigned long highest_memmap_pfn;
-- 
2.35.0.rc0.227.g00780c9af4-goog

