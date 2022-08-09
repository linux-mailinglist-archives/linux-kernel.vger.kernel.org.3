Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DEC58DF77
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344685AbiHISzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343575AbiHISyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:54:52 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFF354666
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:25:08 -0700 (PDT)
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oLTuT-0004fH-Iw;
        Tue, 09 Aug 2022 14:24:57 -0400
Date:   Tue, 9 Aug 2022 14:24:57 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
Message-ID: <20220809142457.4751229f@imladris.surriel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align larger anonymous memory mappings on THP boundaries by
going through thp_get_unmapped_area if THPs are enabled for
the current process.

With this patch, larger anonymous mappings are now THP aligned.
When a malloc library allocates a 2MB or larger arena, that
arena can now be mapped with THPs right from the start, which
can result in better TLB hit rates and execution time.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
v2: avoid the chicken & egg issue with MMF_VM_HUGEPAGE (Yang Shi)

 mm/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index c035020d0c89..1d859893436d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2229,6 +2229,9 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		 */
 		pgoff = 0;
 		get_area = shmem_get_unmapped_area;
+	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+		/* Ensures that larger anonymous mappings are THP aligned. */
+		get_area = thp_get_unmapped_area;
 	}
 
 	addr = get_area(file, addr, len, pgoff, flags);
-- 
2.37.1


