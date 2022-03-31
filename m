Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C954EE010
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiCaSE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiCaSEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20B82231ACC
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648749787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U6mp5k5Rfq1H2egKFRAzqPGIr9Cpe3NxjrBiX6iBTnc=;
        b=b2Zj/DlDt0NzyHj5OYK7BBuMAxPNzL9JP0hZqukbvgg7792MEXmpNwwT2+2aFnEcjmMo+Y
        Ci/jI6cViYNYR8yV5jJxgIEamI8JLf0n/VCR92x74RX0RDA1LVHR23Nim2r5mDlWAieVL6
        0qrlJuGIuzz2M3Ee2REfEZwM6BOKyd0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-Y8KF2xO9Nlqct_GzquUJCA-1; Thu, 31 Mar 2022 14:03:02 -0400
X-MC-Unique: Y8KF2xO9Nlqct_GzquUJCA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CFE0805F7C;
        Thu, 31 Mar 2022 18:03:02 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26947407F761;
        Thu, 31 Mar 2022 18:03:01 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4] mm/sparsemem: Fix 'mem_section' will never be NULL gcc 12 warning
Date:   Thu, 31 Mar 2022 14:02:46 -0400
Message-Id: <20220331180246.2746210-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

It happens with CONFIG_SPARSEMEM_EXTREME off. The mem_section
definition is

    #ifdef CONFIG_SPARSEMEM_EXTREME
    extern struct mem_section **mem_section;
    #else
    extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
    #endif

In the !CONFIG_SPARSEMEM_EXTREME case, mem_section
is a static 2-dimensional array and so the check
"!mem_section[SECTION_NR_TO_ROOT(nr)]" doesn't make sense.

Fix this warning by moving the "!mem_section[SECTION_NR_TO_ROOT(nr)]"
check up inside the CONFIG_SPARSEMEM_EXTREME block and adding an explicit
NR_SECTION_ROOTS check to make sure that there is no out-of-bound
array access.

Fixes: 3e347261a80b ("sparsemem extreme implementation")
Reported-by: Justin Forbes <jforbes@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/mmzone.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 962b14d403e8..46ffab808f03 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1397,13 +1397,16 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
 
 static inline struct mem_section *__nr_to_section(unsigned long nr)
 {
+	unsigned long root = SECTION_NR_TO_ROOT(nr);
+
+	if (unlikely(root >= NR_SECTION_ROOTS))
+		return NULL;
+
 #ifdef CONFIG_SPARSEMEM_EXTREME
-	if (!mem_section)
+	if (!mem_section || !mem_section[root])
 		return NULL;
 #endif
-	if (!mem_section[SECTION_NR_TO_ROOT(nr)])
-		return NULL;
-	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
+	return &mem_section[root][nr & SECTION_ROOT_MASK];
 }
 extern size_t mem_section_usage_size(void);
 
-- 
2.27.0

