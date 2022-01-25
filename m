Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2566649AB36
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S246802AbiAYEpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:45:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1325465AbiAYDhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643081832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ajFuIcB4jTNx/UM4V4dBkhnn/5IgHZMqOqwixvXnOT0=;
        b=I0ZLdBtv90osBFzCa7i2owsYYYuFVz1AJnt2Dqb2K6sts+NHU8wvrKxkt5E9zTLGQSvl0W
        IxrWOGJVpAnt3QHjzqch5a4puMD29735cYB0pjI+2DQIS8IpUgZuSQBIF2TJtRZJQuPfcP
        +nIyEEh/0ex/ZNvYj22c0r71xq7N9I8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-DHIIXYYYPUuVlpw80EJ3Uw-1; Mon, 24 Jan 2022 22:37:10 -0500
X-MC-Unique: DHIIXYYYPUuVlpw80EJ3Uw-1
Received: by mail-pj1-f72.google.com with SMTP id s13-20020a17090a5d0d00b001b4f4299cf9so11615310pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ajFuIcB4jTNx/UM4V4dBkhnn/5IgHZMqOqwixvXnOT0=;
        b=InNpnOXd8mwzjVwwUq5GKDu6rlKTBNpSipQ81MGxgtelaHj6piVuhlPH+vWuP41pRE
         GzAbrIC8woEhXY+rPgKCguKnsYJmbDSxdgVbWOB0v6m+Q0qZYvfKLC5UINEpf6t+mLq6
         BFbk06/AXJCHEWfegAN0zKB739W7+ITvuFDeomwyz+l/28ETjtB+x7F5MT3CoEpRMOJt
         epMEmI54q6wJ2zFvM5tT7reeET0p2vRfe+19v5uzy3HAlnu5t6z7YnnBxYy+Ft030DlS
         YeggHBZq9m+PV0weA8E2MizW68zThQq4173ZgYKudSzCx5lKFg73Lc3jv7tXxcJxAuBi
         CMpw==
X-Gm-Message-State: AOAM531SnZmbadSd8gRKWTTIPEGL/l0BT6qjYTTt3dIyW77CacZ0+j7n
        oCgJmpBmbRLEute2yzku0PAJTTj+8LiuJ2C10L+pHDZMrWqmRvYa1ijuiUZQlprAH7oka/voi8B
        HigBLAvARRZrsAoHk4GEIKxFd
X-Received: by 2002:a17:90b:4a85:: with SMTP id lp5mr856682pjb.25.1643081829770;
        Mon, 24 Jan 2022 19:37:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYgG+4F8lTQQQJjbb6KtDmoIF/2sWEyisHmjmUUYY7rAedb9yb1SPGbOPrnSIEEfMK7MNtgA==
X-Received: by 2002:a17:90b:4a85:: with SMTP id lp5mr856662pjb.25.1643081829493;
        Mon, 24 Jan 2022 19:37:09 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.73])
        by smtp.gmail.com with ESMTPSA id oj7sm718783pjb.43.2022.01.24.19.37.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Jan 2022 19:37:09 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH] mm: Fix invalid page pointer returned with FOLL_PIN gups
Date:   Tue, 25 Jan 2022 11:37:00 +0800
Message-Id: <20220125033700.69705-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex reported invalid page pointer returned with pin_user_pages_remote() from
vfio after upstream commit 4b6c33b32296 ("vfio/type1: Prepare for batched
pinning with struct vfio_batch").  This problem breaks NVIDIA vfio mdev.

It turns out that it's not the fault of the vfio commit; however after vfio
switches to a full page buffer to store the page pointers it starts to expose
the problem easier.

The problem is for VM_PFNMAP vmas we should normally fail with an -EFAULT then
vfio will carry on to handle the MMIO regions.  However when the bug triggered,
follow_page_mask() returned -EEXIST for such a page, which will jump over the
current page, leaving that entry in **pages untouched.  However the caller is
not aware of it, hence the caller will reference the page as usual even if the
pointer data can be anything.

We had that -EEXIST logic since commit 1027e4436b6a ("mm: make GUP handle pfn
mapping unless FOLL_GET is requested") which seems very reasonable.  It could
be that when we reworked GUP with FOLL_PIN we could have overlooked that
special path in commit 3faa52c03f44 ("mm/gup: track FOLL_PIN pages"), even if
that commit rightfully touched up follow_devmap_pud() on checking FOLL_PIN when
it needs to return an -EEXIST.

Since at it, add another WARN_ON_ONCE() at the -EEXIST handling to make sure we
mustn't have **pages set when reaching there, because otherwise it means the
caller will try to read a garbage right after __get_user_pages() returns.

Attaching the Fixes to the FOLL_PIN rework commit, as it happened later than
1027e4436b6a.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 3faa52c03f44 ("mm/gup: track FOLL_PIN pages")
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Debugged-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index f0af462ac1e2..8ebc04058e97 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -440,7 +440,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 		pte_t *pte, unsigned int flags)
 {
 	/* No page to get reference */
-	if (flags & FOLL_GET)
+	if (flags & (FOLL_GET | FOLL_PIN))
 		return -EFAULT;
 
 	if (flags & FOLL_TOUCH) {
@@ -1181,7 +1181,13 @@ static long __get_user_pages(struct mm_struct *mm,
 			/*
 			 * Proper page table entry exists, but no corresponding
 			 * struct page.
+			 *
+			 * Warn if we jumped over even with a valid **pages.
+			 * It shouldn't trigger in practise, but when there's
+			 * buggy returns on -EEXIST we'll warn before returning
+			 * an invalid page pointer in the array.
 			 */
+			WARN_ON_ONCE(pages);
 			goto next_page;
 		} else if (IS_ERR(page)) {
 			ret = PTR_ERR(page);
-- 
2.32.0

