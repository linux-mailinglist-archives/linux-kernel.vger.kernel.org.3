Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E266246E900
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbhLINV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237796AbhLINVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:21:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBE1C0617A2;
        Thu,  9 Dec 2021 05:18:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 844C3CE25C1;
        Thu,  9 Dec 2021 13:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA3BC341CD;
        Thu,  9 Dec 2021 13:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055897;
        bh=/bpNJdZ+aWFgZMWnCW/UQJnzz/QzCabU/kmiGB685LY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rqBxCVD9tK2L6PRlcpj9j0zEiuALm4LQ7ospbxpM4oDC5NKgK+pT7NUtvDfGzBXUv
         bowLQ+AmJqq6kcLmKORujrQUXgjUlB2rhme7i9QkYFEgTzAJNOFzt9CihaSobak9WQ
         jcvrSsPSaB6kAOUo0hi0gfb4277d0a11jjVo9PmTWSL90sipI6vlZGV8f7xnX6n2Rj
         mtkPVUb9gaA53tlPz3xcfQZ2fO+7HD6sXLSVZ1ck7n7Uvl2Y8h/HMEt1HKtpCraAt5
         HCU2fCR2UIm5TG58PKhtZv1/GLPYbAh8HinZcApUrLE9jGAxA1ERh76os2lUMhxaqN
         gCi6JrpcbEaRA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 5/6] Docs/admin-guide/mm/damon/usage: Update for kdamond_pid and (mk|rm)_contexts
Date:   Thu,  9 Dec 2021 13:18:05 +0000
Message-Id: <20211209131806.19317-6-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209131806.19317-1-sj@kernel.org>
References: <20211209131806.19317-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DAMON debugfs usage document is missing descriptions for
'kdamond_pid', 'mk_contexts', and 'rm_contexts' debugfs files.  This
commit adds those.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 52 ++++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 846c85bf4b9d..cb614c84ba9e 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -38,9 +38,9 @@ DAMON provides below three interfaces for different users.
 debugfs Interface
 =================
 
-DAMON exports five files, ``attrs``, ``target_ids``, ``init_regions``,
-``schemes`` and ``monitor_on`` under its debugfs directory,
-``<debugfs>/damon/``.
+DAMON exports eight files, ``attrs``, ``target_ids``, ``init_regions``,
+``schemes``, ``monitor_on``, ``kdamond_pid``, ``mk_contexts`` and
+``rm_contexts`` under its debugfs directory, ``<debugfs>/damon/``.
 
 
 Attributes
@@ -273,6 +273,52 @@ the monitoring is turned on.  If you write to the files while DAMON is running,
 an error code such as ``-EBUSY`` will be returned.
 
 
+Monitoring Thread PID
+---------------------
+
+DAMON does requested monitoring with a kernel thread called ``kdamond``.  You
+can get the pid of the thread by reading the ``kdamond_pid`` file.  When the
+monitoring is turned off, reading the file returns ``none``. ::
+
+    # cd <debugfs>/damon
+    # cat monitor_on
+    off
+    # cat kdamond_pid
+    none
+    # echo on > monitor_on
+    # cat kdamond_pid
+    18594
+
+
+Using Multiple Monitoring Threads
+---------------------------------
+
+One ``kdamond`` thread is created for each monitoring context.  You can create
+and remove monitoring contexts for multiple ``kdamond`` required use case using
+the ``mk_contexts`` and ``rm_contexts`` files.
+
+Writing the name of the new context to the ``mk_contexts`` file creates a
+directory of the name on the DAMON debugfs directory.  The directory will have
+DAMON debugfs files for the context. ::
+
+    # cd <debugfs>/damon
+    # ls foo
+    # ls: cannot access 'foo': No such file or directory
+    # echo foo > mk_contexts
+    # ls foo
+    # attrs  init_regions  kdamond_pid  schemes  target_ids
+
+If the context is not needed anymore, you can remove it and the corresponding
+directory by putting the name of the context to the ``rm_contexts`` file. ::
+
+    # echo foo > rm_contexts
+    # ls foo
+    # ls: cannot access 'foo': No such file or directory
+
+Note that ``mk_contexts``, ``rm_contexts``, and ``monitor_on`` files are in the
+root directory only.
+
+
 .. _tracepoint:
 
 Tracepoint for Monitoring Results
-- 
2.17.1

