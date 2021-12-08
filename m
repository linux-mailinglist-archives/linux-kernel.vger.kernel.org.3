Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D867F46DD8E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 22:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbhLHVZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 16:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbhLHVZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 16:25:51 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55507C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 13:22:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w5-20020a25ac05000000b005c55592df4dso6694181ybi.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 13:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d5tOeWVQTPZlPIcldFSGDsFeR/8SS3+rAWonTN5sOts=;
        b=As/cw9k3ZGJr9vmFWL0o7VOvTAGnXVlb8lU3/Obtf/MjW9RffGBvhTi9jUNHiB0iKY
         g1U1xeLjv30acYeHHel4z4Gj+bkE2iKp/JNXsJVAkeWgHX8YC5XjgE/iZgMXe/lWJaH/
         yk1xCNdSL825zlvcc+aYZMRi2aZhzOvMlsGPrTkl5JPFkbuKX7uSOODzECIx5H86+ues
         1+zUptQJzqGpwf2KXRjU+9i659AXUUR+fyajHgnELIPU66JLQG+GgOyRkMsEhozaq75O
         LbIChGRevW74+fRvT4mDBjW/vgoRFQH9mRsO8zKyTy8Ho7u0pZ6u08gXdpiHUjw5Jt/B
         Y3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d5tOeWVQTPZlPIcldFSGDsFeR/8SS3+rAWonTN5sOts=;
        b=b7T6e6G0Extn6enXZAw1nUsu9/NIm7sS1e239UOBAI4npnhOK66tnGRHfKLqETFBzx
         PHw5gqM4jWAWBOSaoJatQjWoC8GzsVGsscsfDMJBE1Fd+Be+gXtcQtIaqADBI/vfeZba
         QjlRzw98UtWrNrPKDFoyJMpEExF2MpkEYpRsUNQm3cFsxQygL2z/yt90/+iFw/7AnpjC
         IVASva37+eQyK2hjC4UUfZ3X/Nb5/kAyMdIR1mvjTUjFIAdWYfTcl0LI4OQB9hNmxEqJ
         ARrKlsXwoTLCw19b15Hf+OSLvnZouxPshgJYI00s6gvZ+hlzus28e5bWPB/HT80oO9/a
         mazg==
X-Gm-Message-State: AOAM533Wpgzhqvn6ZWqHMvLwfpNhUIcDauMxTKKY6Ln8OjlvJBrhKh1N
        bMa7FpQLDjy2yGRjCBSWci+kK6uugso=
X-Google-Smtp-Source: ABdhPJzCWyLFduG8i0U5m4IS2ULnaIHBO3AedQA8BjTiMJWDd56I5AJrHyXipL4ekCx1ST67qEUF19Klq34=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4efa:9eac:2174:103c])
 (user=surenb job=sendgmr) by 2002:a25:5c3:: with SMTP id 186mr1408710ybf.505.1638998537538;
 Wed, 08 Dec 2021 13:22:17 -0800 (PST)
Date:   Wed,  8 Dec 2021 13:22:10 -0800
In-Reply-To: <20211208212211.2860249-1-surenb@google.com>
Message-Id: <20211208212211.2860249-2-surenb@google.com>
Mime-Version: 1.0
References: <20211208212211.2860249-1-surenb@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v4 2/3] mm: document locking restrictions for vm_operations_struct::close
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments for vm_operations_struct::close documenting locking
requirements for this callback and its callers.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..b9b88ba7564b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -577,6 +577,10 @@ enum page_entry_size {
  */
 struct vm_operations_struct {
 	void (*open)(struct vm_area_struct * area);
+	/**
+	 * @close: Called when the VMA is being removed from the MM.
+	 * Context: User context.  May sleep.  Caller holds mmap_lock.
+	 */
 	void (*close)(struct vm_area_struct * area);
 	/* Called any time before splitting to check if it's allowed */
 	int (*may_split)(struct vm_area_struct *area, unsigned long addr);
-- 
2.34.1.400.ga245620fadb-goog

