Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F115A321A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345095AbiHZWfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiHZWfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:35:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D79A2DA8F;
        Fri, 26 Aug 2022 15:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661553341; x=1693089341;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O4cj6su9MdCY7mmHhaPZl5o9miyzRhe/xLoVYob78Vo=;
  b=CurICu0lS+HRjy4eVrk351G6G/PYsD8C5k3MTYWS9Fn8AgAq5R9cPAlP
   /acQvpxiYDfiUX9Za3WSbQrAOpBiVVBgfScgXvU/MO9f+FH5Cihz9n/yI
   nstlHr/q/o/aLUfQ3Y9UQ7qL2iCertBrt+kGEemVJ03RqX7wI5JZSlsnA
   oVC4nSnlQV0tzuAKp7J/7SzR38h7cplo9pCP3ZBwn2xtYwj9djcfZdEl2
   R3h5eCLLKS9AaTNxB9W0blfljuHeZ1JuL615/qAYKcxPY3Z5ZZK/GfZSM
   BhYy9XzTw+TkgH6rvFwK0EOidRZfIJYyouvxa5hb2Ay0h+5nR44FzEAXs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="320714912"
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="320714912"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 15:35:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="753019198"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.82.226])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 15:35:20 -0700
From:   alison.schofield@intel.com
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] tracepoint: Allow trace events in modules with TAINT_TEST
Date:   Fri, 26 Aug 2022 15:35:11 -0700
Message-Id: <20220826223511.170256-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
in-kernel test has been run.

TAINT_TEST taint type defaults into a 'bad_taint' list for
kernel tracing and blocks the creation of trace events. This
causes a problem for CXL testing where loading the cxl_test
module makes all CXL modules out-of-tree, blocking any trace
events.

Trace events are in development for CXL at the moment and this
issue was found in test with v6.0-rc1.

Reported-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 kernel/tracepoint.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 64ea283f2f86..5f17378c9dc2 100644
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

base-commit: 4c612826bec1441214816827979b62f84a097e91
-- 
2.31.1

