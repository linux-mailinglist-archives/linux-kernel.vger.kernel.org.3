Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A3848FD0D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbiAPMxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:53:41 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:58804 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiAPMxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:53:40 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id 952QnSJT0EuQ2952QnkOP2; Sun, 16 Jan 2022 13:53:39 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 16 Jan 2022 13:53:39 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andy Shevchenko <andy@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] lib/string_helpers: Use the given gfp flag when allocating memory
Date:   Sun, 16 Jan 2022 13:53:37 +0100
Message-Id: <1ec96b6e4f2e35599931d7516c6938c4a8845bf0.1642337606.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup_quotable_cmdline() and kstrdup_quotable_file() are given a gfp flag
that is passed and used for memory allocation in kstrdup_quotable() just a
few lines below.

It looks reasonable to use this gfp value for the buffer allocated and
freed in these functions as well.

Fixes: 0ee931c4e31a ("mm: treewide: remove GFP_TEMPORARY allocation flag")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
According to what I've found in 5.16, all callers use GFP_KERNEL, so this
patch should be a no-op.
But who knows how it will be used in the future. Better safe than sorry.

v2: Add the change for kstrdup_quotable_file()
---
 lib/string_helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 90f9f1b7afec..4433e486b725 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -624,7 +624,7 @@ char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp)
 	char *buffer, *quoted;
 	int i, res;
 
-	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	buffer = kmalloc(PAGE_SIZE, gfp);
 	if (!buffer)
 		return NULL;
 
@@ -660,7 +660,7 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp)
 		return kstrdup("<unknown>", gfp);
 
 	/* We add 11 spaces for ' (deleted)' to be appended */
-	temp = kmalloc(PATH_MAX + 11, GFP_KERNEL);
+	temp = kmalloc(PATH_MAX + 11, gfp);
 	if (!temp)
 		return kstrdup("<no_memory>", gfp);
 
-- 
2.32.0

