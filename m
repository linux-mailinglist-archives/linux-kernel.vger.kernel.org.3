Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430BE46DD30
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbhLHUjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240424AbhLHUje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:39:34 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85F5C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:36:01 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id i12so3271161qvh.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 12:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=efM54ZomnMnKj0fHwD8epFpVs6vA4uxGPqXneKhOTQ4=;
        b=CZ/IogjHt1FbEK64p+q+xuoukwqzLKyhR90K8mytumvWC+vu/dpMMkLo0NclHiem3C
         AwyOLMF2L37XfyjnKdZHevKOTvxFQPHHYuN4I8sFBKFU3Dt4toJ0aVQkF8FYQ5U9piS9
         mWZuncXku17SW28aLVS8oXi7hSJciCeLq8rGiOj5nHJBrgs/8rJbamPH1q59ZGD90FsB
         gk+TYOHPsQW4eNpXD3trVyulGXNsZL/DjJH/6/3DMb/fYpCoS+QfvZ3GaJ7MeZafXUPp
         +j0E2jLWB3qHikLo0dcmjZdUCvVTN/K8yAKp5jdEMQ4AhdKSGGi4QwdFI4dIurB7zlUq
         +2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=efM54ZomnMnKj0fHwD8epFpVs6vA4uxGPqXneKhOTQ4=;
        b=yuyew6XQVzhxkqSjTtiHDUdO5kUOKeuZS5mhe65AK3qjNY1bYDpJ4xMImWreZUmKcN
         6B3Q2oO2uF/ac4Au9wtnUmTsGkvfLfRBxh6+nszDaV+90twn+ObqcK0Ji/j4eZajqfoA
         FIu+3kcNZwyG6OQauvckLPvJuIlwXz07SC1vCV3PyMuqrgPkl24JOCmKswLnR6gLbgd6
         XS5cVvzAOuOof/g3Myb9D1oa6g3WYBSB4mahhv6MpZMbehvU2tlbSXR5hLstEup3uISA
         j4HyCqKRP56ZnpYvbErInINAFBUaUWDyWpif/8jUUbCpW4oVJ/JW1WWjFJ7VMNXc3PMY
         32yA==
X-Gm-Message-State: AOAM532rR6MHTO0IPQPe7FFjlPbDNL/w/+YGGNCZ3CL2Eh/Jm+DkJC0E
        lGwTMQwGgWDhRXmQcMdEclcS4Q==
X-Google-Smtp-Source: ABdhPJw5Y75cfC2gowj44e6l5E9jZvUJuE9e1B0YDT6zuJ1nBlD+sF7LQYQG/tOa7zC/p8ZoFaHJWA==
X-Received: by 2002:ad4:5744:: with SMTP id q4mr10173588qvx.99.1638995760976;
        Wed, 08 Dec 2021 12:36:00 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 143sm1898710qkg.87.2021.12.08.12.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:35:59 -0800 (PST)
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
Subject: [PATCH 09/10] mm: do not use atomic_set_release in page_ref_unfreeze()
Date:   Wed,  8 Dec 2021 20:35:43 +0000
Message-Id: <20211208203544.2297121-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
References: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In we set the old _refcount value after verifying that the old value was
indeed 0.

VM_BUG_ON_PAGE(page_count(page) != 0, page);
< the _refcount may change here>
atomic_set_release(&page->_refcount, count);

To avoid the smal gap where _refcount may change lets verify the time
of the _refcount at the time of the set operation.

Use atomic_xchg_release() and at the set time verify that the value
was 0.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ref.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 8c76bf3bf7e1..26676d3bcd58 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -322,10 +322,9 @@ static inline int folio_ref_freeze(struct folio *folio, int count)
 
 static inline void page_ref_unfreeze(struct page *page, int count)
 {
-	VM_BUG_ON_PAGE(page_count(page) != 0, page);
-	VM_BUG_ON(count == 0);
+	int old_val = atomic_xchg_release(&page->_refcount, count);
 
-	atomic_set_release(&page->_refcount, count);
+	VM_BUG_ON_PAGE(count == 0 || old_val != 0, page);
 	if (page_ref_tracepoint_active(page_ref_unfreeze))
 		__page_ref_unfreeze(page, count);
 }
-- 
2.34.1.400.ga245620fadb-goog

