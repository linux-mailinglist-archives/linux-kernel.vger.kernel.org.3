Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE75F4B38F3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 03:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiBMCh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 21:37:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiBMCh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 21:37:58 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4F960056
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 18:37:54 -0800 (PST)
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nJ4lg-0004ha-KH; Sat, 12 Feb 2022 21:37:40 -0500
Date:   Sat, 12 Feb 2022 21:37:40 -0500
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, linux-mm@kvack.org,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] mm: clean up hwpoison page cache page in fault path
Message-ID: <20220212213740.423efcea@imladris.surriel.com>
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

Sometimes the page offlining code can leave behind a hwpoisoned clean
page cache page. This can lead to programs being killed over and over
and over again as they fault in the hwpoisoned page, get killed, and
then get re-spawned by whatever wanted to run them.

This is particularly embarrassing when the page was offlined due to
having too many corrected memory errors. Now we are killing tasks
due to them trying to access memory that probably isn't even corrupted.

This problem can be avoided by invalidating the page from the page
fault handler, which already has a branch for dealing with these
kinds of pages. With this patch we simply pretend the page fault
was successful if the page was invalidated, return to userspace,
incur another page fault, read in the file from disk (to a new
memory page), and then everything works again.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
v2: fix compiler warning found by kernel test robot

 mm/memory.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c125c4969913..55270ea2a7c7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3871,11 +3871,16 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 		return ret;
 
 	if (unlikely(PageHWPoison(vmf->page))) {
-		if (ret & VM_FAULT_LOCKED)
+		vm_fault_t poisonret = VM_FAULT_HWPOISON;
+		if (ret & VM_FAULT_LOCKED) {
+			/* Retry if a clean page was removed from the cache. */
+			if (invalidate_inode_page(vmf->page))
+				poisonret = 0;
 			unlock_page(vmf->page);
+		}
 		put_page(vmf->page);
 		vmf->page = NULL;
-		return VM_FAULT_HWPOISON;
+		return poisonret;
 	}
 
 	if (unlikely(!(ret & VM_FAULT_LOCKED)))
-- 
2.34.1



-- 
All rights reversed.
