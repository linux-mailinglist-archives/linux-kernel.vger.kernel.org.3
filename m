Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85885596EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbiHQMl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbiHQMlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:41:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062828A7E1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660740068; x=1692276068;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WLP1n8kDuTWFlfVABXbMCll3pTSAJ7VVuuXMV+2OYuw=;
  b=GxHbZCGFed7wupX4ORqUEBpQilQ7mRrIyMYGlVxtVo4YemMdOMfSfMsa
   IZFSfC11hX7TIJ8zHJ7Mzx1zIUs+tWe7BpanYt6FdgtatBq1IzB4lP34s
   W3nSs1u5/subi4y9HxhTY2W3KF0bGRweJ6xkQMnFuijnYNFAoEiCCeTlH
   MwgNeAsJV+8ekhpceyKRBMqXi8KC/AKrcahRlaSQHhGDkBevgLpmSchi+
   Z/IKtqaXBPm3rV2m4O/g6aRUxxmywakii62hwQRjmDeiFYicLJyAQl/I/
   0UrDAPgv0IlnSAUj3hcAR5XFveQzUmU1R4jryRCs+qzkoqmKPwYaSWXfT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="378772736"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="378772736"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="640445156"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga001.jf.intel.com with ESMTP; 17 Aug 2022 05:41:06 -0700
From:   kan.liang@linux.intel.com
To:     acme@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com, namhyung@kernel.org,
        irogers@google.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf evsel: Update the hint for the usage of the load latency event
Date:   Wed, 17 Aug 2022 05:40:50 -0700
Message-Id: <20220817124050.2351268-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The current message is not providing enough information. It's hard for
a user to figure out what's the auxiliary event.

Adding the event name of the auxiliary event in the hint. The user can
simply cut & paste.

Suggested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evsel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4852089e1d79..0d1bb5c723e9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3056,7 +3056,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 		break;
 	case ENODATA:
 		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
-				 "Please add an auxiliary event in front of the load latency event.");
+				 "Please add an auxiliary event in front of the load latency event. "
+				 "For example, -e {mem-loads-aux,%s}.", evsel__name(evsel));
 	default:
 		break;
 	}
-- 
2.35.1

