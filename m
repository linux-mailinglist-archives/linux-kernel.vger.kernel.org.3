Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC91A5B153B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiIHG7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIHG72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:59:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219E02E7;
        Wed,  7 Sep 2022 23:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662620362; x=1694156362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jpVU4iOl8VZsAtBVAq669SyX2EvKQ/EEeFGahcq39aA=;
  b=JWA/ssv+e+tp3YprsRxl21JzU4dAcuv4Ieb7uuxStdhmj3rGg9+2Vpvv
   kN6aoOHRwozY78wsPosAuJa3UvJm9fy+glS/0D1qThkg+xmjt6iA9cyyg
   F0kxCJTC0SB/zXRby4+MqiBBMW8Qn6IbCS842VhWA8bbcZocPJA+KS9xT
   kmoNOycaQwDJ65FnfdZTxmzoJNtS6A2l4Zmrna65s1YU+lceeTCibWRbX
   o2Of02mfXy9CuqbysZVTFn3YsPsQGGuVZlSjg1If2vB8VfnlRpwuIZsTC
   5EZ4ygTDLgWIsMEBrjdWE3qMpZCBJkh+ewMeS6yyEA1XRoNbRkpoCsDZ6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="383381602"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="383381602"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 23:59:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="610586177"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 07 Sep 2022 23:59:18 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH] perf script: Fix Cannot print 'iregs' field for hybrid systems
Date:   Thu,  8 Sep 2022 15:00:30 +0800
Message-Id: <20220908070030.3455164-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Commit b91e5492f9d7 ("perf record: Add a dummy event on hybrid systems to
collect metadata records") adds a dummy event on hybrid systems to fix the
symbol "unknown" issue when the workload is created in a P-core but runs
on an E-core. The added dummy event will cause "perf script -F iregs" to
fail. Dummy events do not have "iregs" attribute set, so when we do
evsel__check_attr, the "iregs" attribute check will fail, so the issue
happened.

The following commit [1] has fixed a similar issue by skipping the attr
check for the dummy event because it does not have any samples anyway. It
works okay for the normal mode, but the issue still happened when running
the test in the pipe mode. In the pipe mode, it calls process_attr() which
still checks the attr for the dummy event. This commit fixed the issue by
skipping the attr check for the dummy event in the API evsel__check_attr,
Otherwise, we have to patch everywhere when evsel__check_attr() is called.

Before:

 #./perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p -c 1000 --per-thread true 2>/dev/null|./perf script -F iregs |head -5
Samples for 'dummy:HG' event do not have IREGS attribute set. Cannot print 'iregs' field.
0x120 [0x90]: failed to process type: 64

After:

 # ./perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p -c 1000 --per-thread true 2>/dev/null|./perf script -F iregs |head -5
 ABI:2    CX:0x55b8efa87000    DX:0x55b8efa7e000    DI:0xffffba5e625efbb0    R8:0xffff90e51f8ae100
 ABI:2    CX:0x7f1dae1e4000    DX:0xd0    DI:0xffff90e18c675ac0    R8:0x71
 ABI:2    CX:0xcc0    DX:0x1    DI:0xffff90e199880240    R8:0x0
 ABI:2    CX:0xffff90e180dd7500    DX:0xffff90e180dd7500    DI:0xffff90e180043500    R8:0x1
 ABI:2    CX:0x50    DX:0xffff90e18c583bd0    DI:0xffff90e1998803c0    R8:0x58

[1]https://lore.kernel.org/lkml/20220831124041.219925-1-jolsa@kernel.org/

Fixes: b91e5492f9d7 ("perf record: Add a dummy event on hybrid systems to collect metadata records")

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-script.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 585171479876..1a8790385eba 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -445,6 +445,9 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 	struct perf_event_attr *attr = &evsel->core.attr;
 	bool allow_user_set;
 
+	if (evsel__is_dummy_event(evsel))
+		return 0;
+
 	if (perf_header__has_feat(&session->header, HEADER_STAT))
 		return 0;
 
-- 
2.25.1

