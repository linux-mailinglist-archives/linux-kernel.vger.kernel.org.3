Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60B7481B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbhL3Kiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhL3Kiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:38:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885F3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 02:38:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11C4661651
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB41C36AEA;
        Thu, 30 Dec 2021 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640860731;
        bh=i6KLNpWXSLKaOd8kbSKvJwabKRIE5pVG8KgBs39rQrU=;
        h=From:To:Cc:Subject:Date:From;
        b=kpmryc4pEat+HSI2LA1Hf+Nc5QyU7bl0/OBXWzfZc4v1oAKm4V8b7BjTc7O4MmKYD
         OuLmQDvWIbuhW3lQT6IQ80nxyNYAYGTxWGwGdbYv+s8pWn6uu1agR7yFUH2EQ+ZiFd
         2u+C9Ap9CH621ss0+5qAB5Jxn4R6MnBAQa9Ubym+49JHnoZgUWEfD0BrOiwiXq8fJM
         0S+ruMHG9WjqWpnR8ATz2fFNkIj/zsNfuJUezzPYJVE+Vfkj75HlQ+GLcF9jvNC2Gr
         hjtQ2l3cKD6m5UDCakGA31AAQdfX79L/E2U4V/06mG5oYAb3sYidD5UgT4mxWi7f+M
         evbsCOafSCU9g==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     hch@lst.de, hughd@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/shmem: Fix a build error due to shmem_unuse() under !CONFIG_SHMEM
Date:   Thu, 30 Dec 2021 10:38:44 +0000
Message-Id: <20211230103844.15302-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A patch[1] in -mm tree that titled mm-simplify-try_to_unuse.patch[2]
didn't properly change the type of 'shmem_unuse()' definition under
!CONFIG_SHMEM, and therefore causing below build error when CONFIG_SHMEM
is not set.

    linux/mm/shmem.c:3992:5: error: conflicting types for 'shmem_unuse'
     3992 | int shmem_unuse(unsigned int type, unsigned long *fs_pages_to_unuse)
          |     ^~~~~~~~~~~
    In file included from linux/include/linux/khugepaged.h:6,
                     from linux/mm/shmem.c:37:
    linux/include/linux/shmem_fs.h:86:5: note: previous declaration of 'shmem_unuse' was here
       86 | int shmem_unuse(unsigned int type);
          |     ^~~~~~~~~~~
    linux/scripts/Makefile.build:289: recipe for target 'mm/shmem.o' failed

This commit fixes the issue by fixing the type of the definition under
the config.

[1] https://lore.kernel.org/linux-mm/20211224062246.1258487-9-hch@lst.de/
[2] https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-simplify-try_to_unuse.patch

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/shmem.c              | 2 +-
 scripts/rust-version.sh | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 scripts/rust-version.sh

diff --git a/mm/shmem.c b/mm/shmem.c
index 421b2459929a..a83c91282c1f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3989,7 +3989,7 @@ int __init shmem_init(void)
 	return 0;
 }
 
-int shmem_unuse(unsigned int type, unsigned long *fs_pages_to_unuse)
+int shmem_unuse(unsigned int type)
 {
 	return 0;
 }
diff --git a/scripts/rust-version.sh b/scripts/rust-version.sh
old mode 100644
new mode 100755
-- 
2.17.1

