Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A768A4AC72E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiBGRWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390804AbiBGRL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:11:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24353C0401E5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:11:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1A8D6118F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04AFC340F2;
        Mon,  7 Feb 2022 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644253880;
        bh=RgvX0jcqavLp9XJXFApY0G2VLvAkEQCQ/aIXU87qu70=;
        h=From:To:Cc:Subject:Date:From;
        b=OkCcogNC3DZDflNBkNEseageG13LbVg9LQZvtOXB2Byk0lRVth8BWE4B8zl6BQ4B2
         Q6qcx7bKtTzImt1qw7mQBZJbnB457mIJ9sL+6mPL0OZSNZwdXms6wt9c02GsSqyN+c
         zesZ0T+Czt3HiwzGJeeyxfd0/AubF8J2RszyG/1hRLB0UG16WVfZQSPrJIn+AmwNRl
         5jQSgG7WgRLtHharj+imJ5wq0knTUjChsJCTgvpujHa+7xqwjBRXYlK0why6jpQ2jt
         1bImjPr0PPVJU8mqz3YGpAACWsDmjXZBseNiggfcIwiGgELoiXuJUexfGQWnv6TGVy
         1WetWAtPQl5iA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] proc: Avoid unused variable warning in pagemap_pmd_range()
Date:   Mon,  7 Feb 2022 10:10:50 -0700
Message-Id: <20220207171049.1102239-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with CONFIG_TRANSPARENT_HUGEPAGE=n, there is a warning
about migration being unused:

  fs/proc/task_mmu.c:1444:7: warning: unused variable 'migration' [-Wunused-variable]
          bool migration = false;
               ^
  1 warning generated.

Move the ifdef preprocessor directive up to include migration so it is
only included in the file when it is used.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

This is a fix for fs-proc-task_mmuc-dont-read-mapcount-for-migration-entry-v4.patch.

 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index bc2f46033231..6e97ed775074 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1441,9 +1441,9 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	spinlock_t *ptl;
 	pte_t *pte, *orig_pte;
 	int err = 0;
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	bool migration = false;
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptl = pmd_trans_huge_lock(pmdp, vma);
 	if (ptl) {
 		u64 flags = 0, frame = 0;

base-commit: b3c0a155ef77550d48f6eb7c6fdd6075764a5622
-- 
2.35.1

