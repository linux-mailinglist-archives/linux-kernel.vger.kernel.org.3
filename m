Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55E347C21C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbhLUPBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbhLUPBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:01:47 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA838C061746
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:01:46 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 131so1524439qkk.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8OLKCLK70MdlV7lY3Fm4nJPND3+4SBjM5tfYfr3at+o=;
        b=J7/VHH0JOS8YGb7cCfiDWVyL9L52RvtQXQMwPLoGbG4THf4d7TZ+nr3GN+lZxvr3gt
         DR+3zRsmjf8qmyeuY98lOO6DG0APhdsS3T9PbV7zB70pmM2ErA+pPzEESJOwAv5Fi81w
         KtsaENFiwW8dBAVRiZ7W+I6iah2RetGECM6ejHg3WUYuyUdI9g0vOUEOBGedrKnZPVaQ
         rSd6Yw4YzULM473hI0xFGj7CPWywVbUSzXVqRK4jNNnUPE9VstMypT1I0KCXBUKyb9WL
         V/LJtDyszKXavEJ85nP31HaFTBUoUKK4UZeO7tPUy+R2KUqthGLCG7zbzK/iMb56yo+U
         SmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8OLKCLK70MdlV7lY3Fm4nJPND3+4SBjM5tfYfr3at+o=;
        b=WmX4rtzoqHvMqM3EUQMzffoFIVgElUIIs/tk9UU4TaYI1JD4hdrgmyJ5+xYVfDXBBI
         kvEvPEhdkkcebIeL81uzwmcpdBbjPFjseU3HmxoqNvoFtNfBRaKzQWiIAC3DodJonTGP
         EhPu6y5WQcEmAc/lZb8NlOcNLA5GGwn4VFSboCQM0vWwKc8HQPJerprZ6WgPjGV8xZMk
         r6tsC3TQk3gwmp25okTu5mWXPr+TV2SuMkh4DAVX2jevkZ/rABBLWptZ1X1qvNuLcSzN
         tLx4K8udyFXGT+Sr4PJNCfABJqM52tyOQoK8AvOurRSnISBv2RuSdPnjBAC0Odv+3CAa
         qQ0A==
X-Gm-Message-State: AOAM5322ZaEnC1Jnrz/+TIjJ4N3gmxRxiwfo0t2wagNZJVFlKkxXheY4
        yTXKVNbm81tMN37Mcv85M/An+Q==
X-Google-Smtp-Source: ABdhPJzN9SRSZZItQKCqO558WN2Y7tM5Mh2bBAZZpVvE6EZpGwsiLYjKEfjD3vbJIkTtFd7w2FLsYQ==
X-Received: by 2002:a05:620a:c4f:: with SMTP id u15mr2250058qki.565.1640098905805;
        Tue, 21 Dec 2021 07:01:45 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id d4sm1991371qkn.79.2021.12.21.07.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:01:45 -0800 (PST)
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
Subject: [PATCH v2 2/9] mm: Avoid using set_page_count() in set_page_recounted()
Date:   Tue, 21 Dec 2021 15:01:33 +0000
Message-Id: <20211221150140.988298-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
In-Reply-To: <20211221150140.988298-1-pasha.tatashin@soleen.com>
References: <20211221150140.988298-1-pasha.tatashin@soleen.com>
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
index deb9bda18e59..4d45ef2ffea6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -162,9 +162,11 @@ static inline bool page_evictable(struct page *page)
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
2.34.1.307.g9b7440fafd-goog

