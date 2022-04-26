Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006F6510AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355096AbiDZUmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355076AbiDZUmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:42:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B177C159
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:38:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7C3C61460
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F68C385C1;
        Tue, 26 Apr 2022 20:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651005536;
        bh=EJTLlpRlUCkEhKFM6MungmBPQeFMLPhClXDK/efWxik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GRwDexlP/87pblyKCM6WAN/LSZPIQ/UBs4lFHVo6lWOaQssnenqG8+L1+WbOTXozY
         3SAtRV65+WGruiUFbP62mEBDmt8wqPgSR2kZIIKZ0kfn/Kx05DdtfdMW9Uem3rDTAu
         wwZtAbLSrzZhQWYR3u1pFlIwKp7wu56aJlmzWRntcdo3D9x72CsjGYlXDbAwfe1HiS
         lcOm0YeRxKvsJ9a0VsdyXn9aQpDbru6GZ00oZBP3iDtkn6UNqyF2FCy1l5+xj7PKG/
         yv5+W0UfjF5halkZSnDOYu1zIQulZCwM9slHj3vT9D64tDiol3YfDrt4j3YVUZgzYM
         bllirWCyIpNzg==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 4/4] Docs/{ABI,admin-guide}/damon: document 'avail_operations' sysfs file
Date:   Tue, 26 Apr 2022 20:38:43 +0000
Message-Id: <20220426203843.45238-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426203843.45238-1-sj@kernel.org>
References: <20220426203843.45238-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

This commit updates the DAMON ABI and usage documents for the new sysfs
file, 'avail_operations'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon          | 10 +++++++++-
 Documentation/admin-guide/mm/damon/usage.rst   | 18 ++++++++++++------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 9e282065cbcf..d724b8a12228 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -40,6 +40,12 @@ Description:	Writing a number 'N' to this file creates the number of
 		directories for controlling each DAMON context named '0' to
 		'N-1' under the contexts/ directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/avail_operations
+Date:		Apr 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the available monitoring operations
+		sets on the currently running kernel.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/operations
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
@@ -47,7 +53,9 @@ Description:	Writing a keyword for a monitoring operations set ('vaddr' for
 		virtual address spaces monitoring, and 'paddr' for the physical
 		address space monitoring) to this file makes the context to use
 		the operations set.  Reading the file returns the keyword for
-		the operations set the context is set to use.
+		the operations set the context is set to use.  Note that only
+		the operations sets that listed in 'avail_operations' file are
+		valid inputs.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
 Date:		Mar 2022
diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 592ea9a50881..af6ffaea567b 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -68,7 +68,7 @@ comma (","). ::
     │ kdamonds/nr_kdamonds
     │ │ 0/state,pid
     │ │ │ contexts/nr_contexts
-    │ │ │ │ 0/operations
+    │ │ │ │ 0/avail_operations,operations
     │ │ │ │ │ monitoring_attrs/
     │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
     │ │ │ │ │ │ nr_regions/min,max
@@ -143,17 +143,23 @@ be written to the file.
 contexts/<N>/
 -------------
 
-In each context directory, one file (``operations``) and three directories
-(``monitoring_attrs``, ``targets``, and ``schemes``) exist.
+In each context directory, two files (``avail_operations`` and ``operations``)
+and three directories (``monitoring_attrs``, ``targets``, and ``schemes``)
+exist.
 
 DAMON supports multiple types of monitoring operations, including those for
-virtual address space and the physical address space.  You can set and get what
-type of monitoring operations DAMON will use for the context by writing one of
-below keywords to, and reading from the file.
+virtual address space and the physical address space.  You can get the list of
+available monitoring operations set on the currently running kernel by reading
+``avail_operations`` file.  Based on the kernel configuration, the file will
+list some or all of below keywords.
 
  - vaddr: Monitor virtual address spaces of specific processes
  - paddr: Monitor the physical address space of the system
 
+You can set and get what type of monitoring operations DAMON will use for the
+context by writing one of the keywords listed in ``avail_operations`` file and
+reading from the ``operations`` file.
+
 contexts/<N>/monitoring_attrs/
 ------------------------------
 
-- 
2.25.1

