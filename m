Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391B7470C60
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbhLJVUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbhLJVUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:20:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4280C061746;
        Fri, 10 Dec 2021 13:17:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DC5EB829D7;
        Fri, 10 Dec 2021 21:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFF3C00446;
        Fri, 10 Dec 2021 21:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639171036;
        bh=5IhiPw2RvqrosQfP1NnT+2qXeY8kkmX4/rnA3yxNXyo=;
        h=From:To:Cc:Subject:Date:From;
        b=ZhzDJ3HZt5QVAcDohjJqajvEEjGkbJ94hY/I+WhLVmXvPuq2LvTfKq+D4sPkwMmdb
         vpU1EzBThIzV1cueMlSIaZ/MN2iXmJSc095okHi1/1OaLQhfgP+n007U1cQixCCWcZ
         1SUWTIZeBbVpuQt1bjpRrb7NEsFcHpRf6fwncS28w09atrCiEM3qMldV7x7EQ1Yphn
         S9p1AsNpFV65zwVLjcoEH0HT4QN2DwiRk/K+RXjZZ5WZrrjxTdnyZ0TdHgXA6Dghp4
         CdM0OItFgy0ryLne5mruYdFGsUNHLWZVTmeGjYDvkfnJPK5Net9lwQOHdIHFz0Z1t1
         aRlw3dCbwX5UA==
From:   broonie@kernel.org
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: linux-next: manual merge of the akpm-current tree with the folio tree
Date:   Fri, 10 Dec 2021 21:17:11 +0000
Message-Id: <20211210211711.3472866-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/migrate.c

between commit:

  2871d169178ba ("filemap: Add folio_put_wait_locked()")

from the folio tree and commit:

  dfbfdd72f50ce ("mm/migrate.c: rework migration_entry_wait() to not take a pageref")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc mm/migrate.c
index 7079e6b7dbe7d,d487a399253b0..0000000000000
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@@ -302,17 -303,10 +303,9 @@@ void __migration_entry_wait(struct mm_s
  	if (!is_migration_entry(entry))
  		goto out;
  
 -	page = pfn_swap_entry_to_page(entry);
 -	page = compound_head(page);
 +	folio = page_folio(pfn_swap_entry_to_page(entry));
  
- 	/*
- 	 * Once page cache replacement of page migration started, page_count
- 	 * is zero; but we must not call folio_put_wait_locked() without
- 	 * a ref. Use folio_try_get(), and just fault again if it fails.
- 	 */
- 	if (!folio_try_get(folio))
- 		goto out;
- 	pte_unmap_unlock(ptep, ptl);
- 	folio_put_wait_locked(folio, TASK_UNINTERRUPTIBLE);
 -	migration_entry_wait_on_locked(page_folio(page), ptep, ptl);
++	migration_entry_wait_on_locked(folio, ptep, ptl);
  	return;
  out:
  	pte_unmap_unlock(ptep, ptl);
