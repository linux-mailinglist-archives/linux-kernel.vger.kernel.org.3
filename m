Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22D849F370
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346373AbiA1GTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:19:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346369AbiA1GTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643350774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RToFXIUfsXCiLH3IYE93p3Ce7kkEvmZK7yXFyS7R3rs=;
        b=KQgQ2qEHyie7dMI+3qGEqZhKXim9UdUcA0TBFFdKcxZhc7959yvyYGjXxXtV0l/ZDsLWci
        JVai95K6TUu1aw3HLV2mh5BV5GOV3+GkW15/9+ExCbVZ7DDNgvWWyxR3YgfHISdzOFcPYM
        TEinYfP9xSYRTg9tTJ6x7Vjf1iJbmgs=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-vmx-9WCoNcqJBDp5AEzU2w-1; Fri, 28 Jan 2022 01:19:33 -0500
X-MC-Unique: vmx-9WCoNcqJBDp5AEzU2w-1
Received: by mail-pf1-f200.google.com with SMTP id v3-20020a622f03000000b004c412d02ca3so2975711pfv.20
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 22:19:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RToFXIUfsXCiLH3IYE93p3Ce7kkEvmZK7yXFyS7R3rs=;
        b=hhfuuMcI/0iW35vO1/c5MK+8UzcGz5Vo8mt7aTfAOYbDZlA7tlmB7IbrXtxNP9DuKr
         SOGrTd7eocvvH20p4BNY3IRG9HqGUSr5ptt9EYDMpkuC8UVvktazBWyrdcKj7ItFZavA
         mmLxKRUvW3mtZk+aajWmnet4mqo/yByQmaSvMfv36m4JstWr9qLEQLQFoi4xoCVy45Cq
         w4Z0+SvBEGrDtNm6/iF5V3LnCNcrN9y4HHgrEu7jtTJB3ge+pQ7/BPUekmMkb2F5oLvE
         y39+DYLLOJuUbKpL4U0H5tbPXkN/l7+usmgfkq8PqOtFo0bP3oiWPYnME6mQprasHHhn
         4mDw==
X-Gm-Message-State: AOAM533T4d45ypgbzGvftFkNLDT82zJ1DzH21PHPYacPrDeCbQI6fmKR
        tKaRnMnQyv2OFD5a3mXe0FzZdSmLI1HjnkGbORd3b8toykJfT7s6mjuhoYAOCypLmf2KWQ9miSN
        3sKQv94Gd8RZKdOWZUN71ScDP
X-Received: by 2002:a17:902:ce8d:: with SMTP id f13mr6747635plg.142.1643350767492;
        Thu, 27 Jan 2022 22:19:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRaHK4URjqYNa73vAYGcVE+xtCjMwOyQ/++59IxtYTc4ppN/5o14unYbibM6qPH8lw/S7jkg==
X-Received: by 2002:a17:902:ce8d:: with SMTP id f13mr6747619plg.142.1643350767226;
        Thu, 27 Jan 2022 22:19:27 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.75])
        by smtp.gmail.com with ESMTPSA id p17sm3241049pfo.11.2022.01.27.22.19.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Jan 2022 22:19:26 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v2] mm: Fix invalid page pointer returned with FOLL_PIN gups
Date:   Fri, 28 Jan 2022 14:19:18 +0800
Message-Id: <20220128061918.20121-1-peterx@redhat.com>
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
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- Drop the WARN_ON_ONCE() [Jason, John]
- Add Alex's Tested-by too, as after dropping the WARN_ON_ONCE() then the patch
  is exactly the one that Alex helped on bug verification, hence very safe to
  grant the credit alongside.
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index f0af462ac1e2..65575ae3602f 100644
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
-- 
2.32.0

