Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352F7510C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356047AbiDZXVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356030AbiDZXVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:21:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81A32FFEC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A010619E3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383B8C385A0;
        Tue, 26 Apr 2022 23:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651015080;
        bh=rP/Ez48eOv8zrnsuUn1nCWIemTRbFqsVKd8lpk7Wji4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCFX/ET9+2zk2t6Hyr64Ihi3w2axWHPU4hsV0O5W6nidK9DDWa7ITxuu+1tOX30Zw
         RwCgxwhoyXYqjsao7i2vnQVbCGSaYkW1vmRjSHFM2LBK6nhy586cpK3kRq66S2DBSU
         Zxb3EpUluIgFKEthKETw0sKe2LQv2MgpWTBrK00O0ZxLQnZtVDPbbAp5PJvr438iz5
         xPAPaMqCILyXt5VIEjI5Td0bKyMS478SZRTBh8hwqmZn+GzJm1n+L7M+bTVvcEq4TK
         gu4Lz1l4f1zLA/G3Bzg+rLEmyx7EcjY6PLo+oevQr4YNnn5bEfT59nxhnUbcH9MmCC
         BA67ZZyKNuMxw==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 3/3] Docs/{ABI,admin-guide}/damon: update for fixed virtual address ranges monitoring
Date:   Tue, 26 Apr 2022 23:17:50 +0000
Message-Id: <20220426231750.48822-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426231750.48822-1-sj@kernel.org>
References: <20220426231750.48822-1-sj@kernel.org>
MIME-Version: 1.0
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

This commit documents the user space support of the newly added
monitoring operations set for fixed virtual address ranges monitoring,
namely 'fvaddr', on the ABI and usage documents for DAMON.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 14 ++++++++------
 Documentation/admin-guide/mm/damon/usage.rst    | 14 +++++++++++---
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index d724b8a12228..fab97ea22569 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -50,12 +50,14 @@ What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/operations
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing a keyword for a monitoring operations set ('vaddr' for
-		virtual address spaces monitoring, and 'paddr' for the physical
-		address space monitoring) to this file makes the context to use
-		the operations set.  Reading the file returns the keyword for
-		the operations set the context is set to use.  Note that only
-		the operations sets that listed in 'avail_operations' file are
-		valid inputs.
+		virtual address spaces monitoring, 'fvaddr' for fixed virtual
+		address ranges monitoring, and 'paddr' for the physical address
+		space monitoring) to this file makes the context to use the
+		operations set.  Reading the file returns the keyword for the
+		operations set the context is set to use.
+
+		Note that only the operations sets that listed in
+		'avail_operations' file are valid inputs.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
 Date:		Mar 2022
diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index af6ffaea567b..9c67311a79d8 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -154,8 +154,13 @@ available monitoring operations set on the currently running kernel by reading
 list some or all of below keywords.
 
  - vaddr: Monitor virtual address spaces of specific processes
+ - fvaddr: Monitor fixed virtual address ranges
  - paddr: Monitor the physical address space of the system
 
+Please refer to :ref:`regions sysfs directory <sysfs_regions>` for detailed
+differences between the operations sets in terms of the monitoring target
+regions.
+
 You can set and get what type of monitoring operations DAMON will use for the
 context by writing one of the keywords listed in ``avail_operations`` file and
 reading from the ``operations`` file.
@@ -198,6 +203,8 @@ If you wrote ``vaddr`` to the ``contexts/<N>/operations``, each target should
 be a process.  You can specify the process to DAMON by writing the pid of the
 process to the ``pid_target`` file.
 
+.. _sysfs_regions:
+
 targets/<N>/regions
 -------------------
 
@@ -208,9 +215,10 @@ can be covered.  However, users could want to set the initial monitoring region
 to specific address ranges.
 
 In contrast, DAMON do not automatically sets and updates the monitoring target
-regions when ``paddr`` monitoring operations set is being used (``paddr`` is
-written to the ``contexts/<N>/operations``).  Therefore, users should set the
-monitoring target regions by themselves in the case.
+regions when ``fvaddr`` or ``paddr`` monitoring operations sets are being used
+(``fvaddr`` or ``paddr`` have written to the ``contexts/<N>/operations``).
+Therefore, users should set the monitoring target regions by themselves in the
+cases.
 
 For such cases, users can explicitly set the initial monitoring target regions
 as they want, by writing proper values to the files under this directory.
-- 
2.25.1

