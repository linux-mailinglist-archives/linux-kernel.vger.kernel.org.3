Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B654ECE72
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351178AbiC3VBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346753AbiC3VBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:01:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E021D24BD7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648673974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sy8bkqtPJSZgcyuTbRCJfF/i6zL7BC/uXgP8JV+OWLU=;
        b=W1hmkRBUfvu74FTDIpNenxTkMH0sELTQxDwr1ChfnqNv/T6X0ImF3UiLENX18zOxrLQEAv
        jzJUyWUudHtLL2blvuHB+HuCpuyrTM6o2yafOn2Du4i0ToKEvfgpTRfpYBBfNK+BJC2Fp7
        j1+wR5INhDda7GWRWSPwHAjCGVzCLRg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-ji24S9IEPZaTOciUVy2QlA-1; Wed, 30 Mar 2022 16:59:30 -0400
X-MC-Unique: ji24S9IEPZaTOciUVy2QlA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F6B985A5BE;
        Wed, 30 Mar 2022 20:59:30 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D18C140CF8E4;
        Wed, 30 Mar 2022 20:59:29 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3] mm/sparsemem: Fix 'mem_section' will never be NULL gcc 12 warning
Date:   Wed, 30 Mar 2022 16:59:19 -0400
Message-Id: <20220330205919.2713275-1-longman@redhat.com>
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
check up inside the CONFIG_SPARSEMEM_EXTREME block.

Fixes: 3e347261a80b ("sparsemem extreme implementation")
Reported-by: Justin Forbes <jforbes@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/mmzone.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 962b14d403e8..8a89efe47571 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1398,11 +1398,9 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
 static inline struct mem_section *__nr_to_section(unsigned long nr)
 {
 #ifdef CONFIG_SPARSEMEM_EXTREME
-	if (!mem_section)
+	if (!mem_section || !mem_section[SECTION_NR_TO_ROOT(nr)])
 		return NULL;
 #endif
-	if (!mem_section[SECTION_NR_TO_ROOT(nr)])
-		return NULL;
 	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
 }
 extern size_t mem_section_usage_size(void);
-- 
2.27.0

