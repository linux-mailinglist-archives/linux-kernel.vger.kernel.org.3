Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2784A650D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbiBATaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:30:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239468AbiBATaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643743801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2TUBdCrGSJU9MaqKZxC4f3nHFAhGE9a8IWKYk+qvWfY=;
        b=FB+VfACQ9NaYNXCkW3yrEVf/IoQh0/a7CQz7DQh3iY7CuCsryrtgQF2lSl09zrwxvv1j5z
        Ft5SREb5gYElWbrFDhY992S1Sz3f6c0vHLiYPmyZfnBb7+xo1am9kykafLxz+RT7j261CH
        7EIK1Yyd8Jhsj4hI6Ssis4xbvANj9bQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-HBvz2wbnM5eewPRhg4YVDg-1; Tue, 01 Feb 2022 14:29:58 -0500
X-MC-Unique: HBvz2wbnM5eewPRhg4YVDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5397A1054F91;
        Tue,  1 Feb 2022 19:29:57 +0000 (UTC)
Received: from llong.com (unknown [10.22.19.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2E9719C59;
        Tue,  1 Feb 2022 19:29:39 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Justin Forbes <jforbes@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/sparsemem: Fix 'mem_section' will never be NULL gcc 12 warning
Date:   Tue,  1 Feb 2022 14:29:24 -0500
Message-Id: <20220201192924.672675-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gcc 12 compiler reports a warning on the following code:

    static inline struct mem_section *__nr_to_section(unsigned long nr)
    {
    #ifdef CONFIG_SPARSEMEM_EXTREME
        if (!mem_section)
                return NULL;
    #endif
       :

With CONFIG_SPARSEMEM_EXTREME on, the mem_section definition is

    extern struct mem_section **mem_section;

Obviously, mem_section cannot be NULL, but *mem_section can be if memory
hasn't been allocated for the dynamic mem_section[] array yet. Fix this
warning by checking for "!*mem_section" instead.

Fixes: 83e3c48729d9 ("mm/sparsemem: Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/mmzone.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aed44e9b5d89..bd1b19925f3b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1390,7 +1390,7 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
 static inline struct mem_section *__nr_to_section(unsigned long nr)
 {
 #ifdef CONFIG_SPARSEMEM_EXTREME
-	if (!mem_section)
+	if (!*mem_section)
 		return NULL;
 #endif
 	if (!mem_section[SECTION_NR_TO_ROOT(nr)])
-- 
2.27.0

