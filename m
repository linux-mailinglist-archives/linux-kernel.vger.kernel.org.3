Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ECF5A52D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiH2RLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiH2RKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:10:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2095C9DF;
        Mon, 29 Aug 2022 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661793054; x=1693329054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aDl2jIwOy7f6Y1iRFsQn+FvrMY2h4rkOmf4n9lzlNB8=;
  b=cX5IlnaaF/YbTU5iW9npA2OW6/8PN2A4XqoZi0zOFgi6KL9t8pjj9ldn
   M+zCyViApk/Hf4rXf6liTiGePfjawbDRUCgsWGT80ZRIH30XZnlv/7jhP
   ljs6chIQ1CsyGaEmJQ7VO8aR79lIoxD0psoI1eiXSs0Isj+RvRkasNpz7
   huUO1eN+7kPP1AmPG8tLAsywEUCT4UubEEC7t2uziX+0mpyb3RQL7Obfv
   jicq8E6N4tF4A1jZ7CUasxYmCVjmC9nQuDYXPqJ4o5vRlVogA047facQi
   8cP25PLVhdS87Mvr4IsT5lsZKQ9GYi0Pse26nmszx9L6j2YEIVL6W6Eoe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="281921806"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="281921806"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 10:10:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="614285463"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.3.205])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 10:10:51 -0700
From:   alison.schofield@intel.com
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Gow <davidgow@google.com>
Subject: [PATCH v2] tracepoint: Allow trace events in modules with TAINT_TEST
Date:   Mon, 29 Aug 2022 10:10:48 -0700
Message-Id: <20220829171048.263065-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Commit 2852ca7fba9f ("panic: Taint kernel if tests are run")
introduced a new taint type, TAINT_TEST, to signal that an
in-kernel test module has been loaded.

TAINT_TEST taint type defaults into a 'bad_taint' list for
kernel tracing and blocks the creation of trace events. This
causes a problem for CXL testing where loading the cxl_test
module makes all CXL modules out-of-tree, blocking any trace
events.

Trace events are in development for CXL at the moment and this
issue was found in test with v6.0-rc1.

Reported-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
- Update comment in tracepoint_module_coming()  (DavidG)
- Commit log: s/test has been run/test module has been loaded (DaveJ)

 kernel/tracepoint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 64ea283f2f86..ef42c1a11920 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -571,7 +571,8 @@ static void for_each_tracepoint_range(
 bool trace_module_has_bad_taint(struct module *mod)
 {
 	return mod->taints & ~((1 << TAINT_OOT_MODULE) | (1 << TAINT_CRAP) |
-			       (1 << TAINT_UNSIGNED_MODULE));
+			       (1 << TAINT_UNSIGNED_MODULE) |
+			       (1 << TAINT_TEST));
 }
 
 static BLOCKING_NOTIFIER_HEAD(tracepoint_notify_list);
@@ -647,7 +648,7 @@ static int tracepoint_module_coming(struct module *mod)
 	/*
 	 * We skip modules that taint the kernel, especially those with different
 	 * module headers (for forced load), to make sure we don't cause a crash.
-	 * Staging, out-of-tree, and unsigned GPL modules are fine.
+	 * Staging, out-of-tree, unsigned GPL, and test modules are fine.
 	 */
 	if (trace_module_has_bad_taint(mod))
 		return 0;

base-commit: 4c612826bec1441214816827979b62f84a097e91
-- 
2.31.1

