Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1714448A3F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345754AbiAJXu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345745AbiAJXu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:50:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FF9C061748;
        Mon, 10 Jan 2022 15:50:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D0E5614A5;
        Mon, 10 Jan 2022 23:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0530CC36AE9;
        Mon, 10 Jan 2022 23:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641858624;
        bh=5jg4ahzCQWXk36E+/pzngm/e3Ie4peBBN/TBo9UVz88=;
        h=From:To:Cc:Subject:Date:From;
        b=pXcnv7fjWWdlRBeHFZgiMXyJN5XB35i5B+GdQgu8x+/oowZYdVpm5gP9iwgHoZ8cK
         cuZ5ZkrPTia5x64NmESgGzImnrkRfDKlL5sbg2ph0m3Uxt1ATdQO8Eiv0gZCMJnCLU
         17BrRQOuYTXShEuz6xEjolF9fawh7lbUSIFwNvdDUab/jbFY+0KAN7P1gmAnxaeQSo
         F4ww7jL1wlGDiWY4hFWpJijonVrvzus5582rnuCBI0SZBc6OLJogaWkllxJfuU/xcw
         aQuoHFkfg1HmkCYfsxxQRXCVMC1IL2BF0CtoMM5O/pE9iQabewoG0wXgboFqxYqXFF
         KYr3ztYt5rn7A==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ceph: move CEPH_SUPER_MAGIC definition to magic.h
Date:   Mon, 10 Jan 2022 18:50:22 -0500
Message-Id: <20220110235022.138723-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uapi headers are missing the ceph definition. Move it there so
userland apps can ID cephfs.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/super.c            | 2 ++
 fs/ceph/super.h            | 3 ---
 include/uapi/linux/magic.h | 1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index bab61232dc5a..9679275c875d 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -27,6 +27,8 @@
 #include <linux/ceph/auth.h>
 #include <linux/ceph/debugfs.h>
 
+#include <uapi/linux/magic.h>
+
 static DEFINE_SPINLOCK(ceph_fsc_lock);
 static LIST_HEAD(ceph_fsc_list);
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index ac331aa07cfa..97e150724291 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -25,9 +25,6 @@
 #include <linux/fscache.h>
 #endif
 
-/* f_type in struct statfs */
-#define CEPH_SUPER_MAGIC 0x00c36400
-
 /* large granularity for statfs utilization stats to facilitate
  * large volume sizes on 32-bit machines. */
 #define CEPH_BLOCK_SHIFT   22  /* 4 MB */
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 35687dcb1a42..53a3c20394cf 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -6,6 +6,7 @@
 #define AFFS_SUPER_MAGIC	0xadff
 #define AFS_SUPER_MAGIC                0x5346414F
 #define AUTOFS_SUPER_MAGIC	0x0187
+#define CEPH_SUPER_MAGIC	0x00c36400
 #define CODA_SUPER_MAGIC	0x73757245
 #define CRAMFS_MAGIC		0x28cd3d45	/* some random number */
 #define CRAMFS_MAGIC_WEND	0x453dcd28	/* magic number with the wrong endianess */
-- 
2.34.1

