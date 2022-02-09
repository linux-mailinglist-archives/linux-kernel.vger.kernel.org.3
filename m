Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92C04AEE60
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbiBIJps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:45:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiBIJpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:45:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDA3E0699AE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:45:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7DA4619BA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61F4C340E7;
        Wed,  9 Feb 2022 09:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644399739;
        bh=Hj4guPRHDf34ilQhSL4H2ZHu0uoUXzIKahEM2dGbhc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dBIiEUglGNaozi8wCk7JEHogC+s6n2oGOegdedQLT58ZmDH4oLBynvio9o6Z9Hke7
         H3C1fXPgBPsynjoLfyixntDZb2Zrvj4+mp0US991qnja3Z19YxJyn95o+QD/ZHoCuK
         OH5ayPgSRzULSPTnUjTnBChmgu03SeV6jIo49U/zRfru8G7UItNu+/Gm/Ozvkb3uX+
         TbSMW/+uLI8ryzHRee4iD8ZuZ+3XVhQWV7fHJ/11caNrAopel4SD63Ehw3BSKb2uac
         ssBzq4/0eax4rwqbOICH8md5mUX/em9RC7gI1DiC+tS3ETTojG0nhulpd5P13nvZwp
         vTKgxCQSSxpjQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, apopple@nvidia.com
Subject: [PATCH for-mm 2/2] mm/gup: Make migrate_device_page() fails always if !CONFIG_DEVICE_PRIVATE
Date:   Wed,  9 Feb 2022 09:41:58 +0000
Message-Id: <20220209094158.21941-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209094158.21941-1-sj@kernel.org>
References: <20220209094158.21941-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7059ac82be44 ("mm/gup.c: migrate device coherent pages when
pinning instead of failing") in -mm tree[1] introduces
'migrate_device_page()', which uses several functions that defined under
CONFIG_DEVICE_RIVATE.  As a result, build under 'CONFIG_MIGRATION &&
!CONFIG_DEVICE_PRIVATE' fails as below.

      LD      .tmp_vmlinux.kallsyms1
    mm/gup.o: In function `migrate_device_page':
    /linux/mm/gup.c:1856: undefined reference to `migrate_vma_setup'
    /linux/mm/gup.c:1876: undefined reference to `migrate_vma_pages'
    /linux/mm/gup.c:1879: undefined reference to `migrate_vma_finalize'
    /linux/Makefile:1222: recipe for target 'vmlinux' failed
    make[1]: *** [vmlinux] Error 1

This commit fixes it by implementing an always-failing version of the
function for !CONFIG_DEVICE_PRIVATE'.

[1] https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-gupc-migrate-device-coherent-pages-when-pinning-instead-of-failing.patch

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/gup.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 1df99a5e90cf..0cf59858114d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1834,6 +1834,7 @@ struct page *get_dump_page(unsigned long addr)
 #endif /* CONFIG_ELF_CORE */
 
 #ifdef CONFIG_MIGRATION
+#ifdef CONFIG_DEVICE_PRIVATE
 /*
  * Migrates a device coherent page back to normal memory. Caller should have a
  * reference on page which will be copied to the new page if migration is
@@ -1887,6 +1888,14 @@ static struct page *migrate_device_page(struct page *page,
 
 	return dpage;
 }
+#else
+static inline struct page *migrate_device_page(struct page *page,
+					unsigned int gup_flags)
+{
+	return NULL;
+}
+#endif /* CONFIG_DEVICE_PRIVATE */
+
 
 /*
  * Check whether all pages are pinnable, if so return number of pages.  If some
-- 
2.17.1

