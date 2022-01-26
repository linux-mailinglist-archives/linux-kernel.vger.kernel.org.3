Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087D949D1C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244249AbiAZSe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244138AbiAZSel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:34:41 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8BCC061749
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:34:41 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id k9so607751qvv.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=l8kTegpTqMksygyMNd7O9r7qJ6myjdhmrXkVSbv/IzA=;
        b=dcgO/hZ6elZPBdqxd4MboPCo3EmolMnIS887io5RaZKDoH7H3DsIKjWe4xL0M92rAN
         NGAs7DZ4N0Cm3Mu1BqA/u4YPeEnAejo0/rDUXvOGHwdQqDTzgDduz/YPu8cTYag6DNR2
         pZks0Czhk7nN87F+uqzoh7CXPfDmtA2bXmMEn5cLDfgC74eDx4rtj9zlO5y9Gz/6RdQY
         QYtkCpcN6yotcPm74Tik/4EYy8j0Ppcfy9AOeQyVai8riP0oJXWDwXI7oyJNNCbj4jxC
         H/r9ApPE7qNwyGQk9KJq0YaO8bT0ni9gz3Tm8obbCQhHb9KIqrUiniiwj2Db7oc6jaKC
         ByKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8kTegpTqMksygyMNd7O9r7qJ6myjdhmrXkVSbv/IzA=;
        b=ZzSUiejvpBeUd/M4O9kbf5kFlrVbqCzvE+C5r+54cAC4sLQWQHRevJlfQZf6KPM2hh
         Dohz8WCslGFsd6OmV5dVPaB9NHBstzOK37BySm3ZqsppTFyfuLPzX+U7FKmN1Q/JZ/FX
         bEQRbK6iUpjMgwKqeQ655EULOsIQL9Y5vLCOZcoAIMU8kgoq1cmFTGiFjnn8BDg2e3AJ
         YtZ98r+5Be96fRsMyxJYAANQ2d9FvCJzIGJeAiOPKW+6VTj4+PYDwI6Iztv5dv3FFfXZ
         C8yWw4VEQ12PcsJmV4dttJguyJnYy6zOKlrkf7jtZSk+VHa6WliSXAblCfm1o/6pCCqo
         FfCA==
X-Gm-Message-State: AOAM532MYRnKuU3mZuDmZ1lrSQ/y6VA+OKvmOPFrTqncq+FHYNX0yBT0
        6ziiqUFAJazs/ECO0cHk7tOl4A==
X-Google-Smtp-Source: ABdhPJx1uUL1QguAQjuOjaCUHuB84L0yLxyE8YceJm8x5PIc7mOwOmi6RJ2+VMz5b+XHNn1KPA5orA==
X-Received: by 2002:ad4:5ca4:: with SMTP id q4mr24120qvh.64.1643222080942;
        Wed, 26 Jan 2022 10:34:40 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id u17sm35886qki.12.2022.01.26.10.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:34:40 -0800 (PST)
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
Subject: [PATCH v3 9/9] mm: use atomic_cmpxchg_acquire in page_ref_freeze().
Date:   Wed, 26 Jan 2022 18:34:29 +0000
Message-Id: <20220126183429.1840447-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
References: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_ref_freeze and page_ref_unfreeze are designed to be used as a pair.
They protect critical sections where struct page can be modified.

page_ref_unfreeze() is protected by _release() atomic operation, but
page_ref_freeze() is not as it is assumed that cmpxch provides the full
barrier.

Instead, use the appropriate atomic_cmpxchg_acquire() to ensure that
memory model is excplicitly followed.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ref.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 9efabeff4e06..45be731d8919 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -308,7 +308,8 @@ static inline bool folio_try_get_rcu(struct folio *folio)
 
 static inline int page_ref_freeze(struct page *page, int count)
 {
-	int ret = likely(atomic_cmpxchg(&page->_refcount, count, 0) == count);
+	int old_val = atomic_cmpxchg_acquire(&page->_refcount, count, 0);
+	int ret = likely(old_val == count);
 
 	if (page_ref_tracepoint_active(page_ref_freeze))
 		__page_ref_freeze(page, count, ret);
-- 
2.35.0.rc0.227.g00780c9af4-goog

