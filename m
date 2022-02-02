Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7532A4A694A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbiBBAhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:37:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243361AbiBBAhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643762233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kcWuqd5evricJIxS6cUHjNVZ199P8EXWi5nJ6wTm+mw=;
        b=fMtdMmsPC8xdBgLajAtmVE1VsZBqxclwl7Z6vTzm5/v4cTmzQ/PbX/tGD4gt87xQ9CS8vb
        pwE0C7kPbcaWPAa+fra0tr6OBBNtkwdIFaHk0UgvfN1nky2pULedsOpLOInmxWEheJJjJL
        mIQHVU38wNRQZtJfjhUpfnke8GpVNVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-HJoyl65mNLytNk4FbvMUZQ-1; Tue, 01 Feb 2022 19:37:10 -0500
X-MC-Unique: HJoyl65mNLytNk4FbvMUZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A01A11124C40;
        Wed,  2 Feb 2022 00:37:09 +0000 (UTC)
Received: from llong.com (unknown [10.22.19.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 688FD105C74E;
        Wed,  2 Feb 2022 00:36:52 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Justin Forbes <jforbes@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] mm/sparsemem: Fix 'mem_section' will never be NULL gcc 12 warning
Date:   Tue,  1 Feb 2022 19:35:50 -0500
Message-Id: <20220202003550.698768-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gcc 12 compiler reports a "'mem_section' will never be NULL"
warning on the following code:

    static inline struct mem_section *__nr_to_section(unsigned long nr)
    {
    #ifdef CONFIG_SPARSEMEM_EXTREME
        if (!mem_section)
                return NULL;
    #endif
        if (!mem_section[SECTION_NR_TO_ROOT(nr)])
                return NULL;
       :

It happens with both CONFIG_SPARSEMEM_EXTREME on and off. The mem_section
definition is

    #ifdef CONFIG_SPARSEMEM_EXTREME
    extern struct mem_section **mem_section;
    #else
    extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
    #endif

In the CONFIG_SPARSEMEM_EXTREME case, mem_section obviously cannot
be NULL, but *mem_section can be if memory hasn't been allocated for
the dynamic mem_section[] array yet. In the !CONFIG_SPARSEMEM_EXTREME
case, mem_section is a static 2-dimensional array and so the check
"!mem_section[SECTION_NR_TO_ROOT(nr)]" doesn't make sense.

Fix this warning by checking for "!*mem_section" instead of
"!mem_section" and moving the "!mem_section[SECTION_NR_TO_ROOT(nr)]"
check up inside the CONFIG_SPARSEMEM_EXTREME block.

Fixes: 83e3c48729d9 ("mm/sparsemem: Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y")
Fixes: 3e347261a80b ("sparsemem extreme implementation")
Reported-by: Justin Forbes <jforbes@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/mmzone.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aed44e9b5d89..08517376c765 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1390,11 +1390,9 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
 static inline struct mem_section *__nr_to_section(unsigned long nr)
 {
 #ifdef CONFIG_SPARSEMEM_EXTREME
-	if (!mem_section)
+	if (!*mem_section || !mem_section[SECTION_NR_TO_ROOT(nr)])
 		return NULL;
 #endif
-	if (!mem_section[SECTION_NR_TO_ROOT(nr)])
-		return NULL;
 	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
 }
 extern size_t mem_section_usage_size(void);
-- 
2.27.0

