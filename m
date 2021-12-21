Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BE047C222
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbhLUPCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbhLUPBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:01:55 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFAFC06175E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:01:54 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id q4so6015864qvh.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ujiBeyeY0ZhWFNLdTCKueYw4ysMT9Aw/7apPybkWG1s=;
        b=PA3Q/yDh7W+DgSnKOTeVJUsVJL2iHQHGtRuXH0oQMCfi3NgBzbAlRtnkbB9VslFuln
         JgUXIsrq1dntIqfnKtVub3TAjFSBwovezuGjEs3vddMSz4B5E6iP75xXidJlVHdWmWRJ
         K2Hka8iaYZ5H/DI+OAzA2Wp0g/1hRTlVUi1AkgHDGaUEHi4zkn+tCPyqgXJyaUlevaHs
         LbEjFWY6ySLuQAHYvgf2ziB9zfVBqb9otAVbfhkvHbGoUQrnySsFwdw6XlQqKyE9RhVo
         XBcZRWgYNo4vWOlPwLvSnUALA/P7VH0q92uNKhHlNB67+Ut18sXhqjf6Ed+1ptUU0jls
         bK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujiBeyeY0ZhWFNLdTCKueYw4ysMT9Aw/7apPybkWG1s=;
        b=V+lPZyT9K9VRm2aYtrJfnT7NnAdoXHohzfRfab9p4792SiC1hEQ2PGIl0ArWQ7iv8T
         +UxILcBw8IhbqTXCZPO1nCK8HuggtSEC3o3S4pkxaqDKUpkHQKNM07GcH3Ax8LNmaWDR
         Ft+v7hmpV3H8VOy1MMIdR5Lb4sWQssILw2gTEN/FZzT/rkn3I1tGoDeJgllMQtLYQmFx
         059OAGfqztXPCgFZVoO4cE7waDpinnc3tBp5rBZb7C8ZqPoDv7H9WjtSZgPqjDp8zjz9
         z5KXTdMo/bB1VAN7fwe+DWWWu7vncnADi+T/1b1iqRBfncTp7ew1HaOqBgVHYr3xvOdw
         pO7g==
X-Gm-Message-State: AOAM533nuupxgPzRo2SqOGXYOW8NpBVHcD4QDXMbFtGTW6xp+KWcgIU3
        JNbCSALClOSsc+wPeyeOpXdXaA==
X-Google-Smtp-Source: ABdhPJwstE7x+0HpgXRt/GfFm68tAcQrAuhOR2pvSynOcMLtQsVanoM/IfrenS7mms+J84bIphIm9Q==
X-Received: by 2002:ad4:5aad:: with SMTP id u13mr2841845qvg.46.1640098913240;
        Tue, 21 Dec 2021 07:01:53 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id d4sm1991371qkn.79.2021.12.21.07.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:01:52 -0800 (PST)
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
Subject: [PATCH v2 9/9] mm: use atomic_cmpxchg_acquire in page_ref_freeze().
Date:   Tue, 21 Dec 2021 15:01:40 +0000
Message-Id: <20211221150140.988298-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
In-Reply-To: <20211221150140.988298-1-pasha.tatashin@soleen.com>
References: <20211221150140.988298-1-pasha.tatashin@soleen.com>
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
2.34.1.307.g9b7440fafd-goog

