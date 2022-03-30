Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8334E4EBEC1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245370AbiC3Ka1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242950AbiC3KaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:30:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A9F25E9E;
        Wed, 30 Mar 2022 03:28:38 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KT2fW0wL6z67kNj;
        Wed, 30 Mar 2022 18:26:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 30 Mar 2022 12:28:35 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 30 Mar 2022 11:28:32 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <matthieu.baerts@tessares.net>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH] perf tools: Stop depending on .git files for building PERF-VERSION-FILE
Date:   Wed, 30 Mar 2022 18:22:54 +0800
Message-ID: <1648635774-14581-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This essentially reverts commit c72e3f04b45fb2e50cdd81a50c3778c6a57251d8
and commit 4e666cdb06eede2069a7b1a96a1359d1c441a3eb.

In commit c72e3f04b45f ("tools/perf/build: Speed up git-version test on
re-make"), a makefile dependency on .git/HEAD was added. The background is
that running PERF-VERSION-FILE is relatively slow, and commands like
"git describe" are particularly slow.

In commit 4e666cdb06ee ("perf tools: Fix dependency for version file
creation"), an additional dependency on .git/ORIG_HEAD was added, as
.git/HEAD may not change for "git reset --hard HEAD^" command. However,
depending on whether we're on a branch or not, a "git cherry-pick" may
not lead to the version being updated.

As discussed with the git community in [0], using git internal files for
dependencies is not reliable. Commit 4e666cdb06ee also breaks some build
scenarios [1].

As mentioned, c72e3f04b45f was added to speed up the build. However in
commit 7572733b8499 ("perf tools: Fix version kernel tag") we removed the
call to "git describe", so just revert Makefile.perf back to same as pre
c72e3f04b45f and the build should not be so slow, as below:

Pre 7572733b8499:
$> time util/PERF-VERSION-GEN
  PERF_VERSION = 5.17.rc8.g4e666cdb06ee

real    0m0.110s
user    0m0.091s
sys     0m0.019s

Post 7572733b8499:
$> time util/PERF-VERSION-GEN
  PERF_VERSION = 5.17.rc8.g7572733b8499

real    0m0.039s
user    0m0.036s
sys     0m0.007s

[0] https://lore.kernel.org/git/87wngkpddp.fsf@igel.home/T/#m4a4dd6de52fdbe21179306cd57b3761eb07f45f8
[1] https://lore.kernel.org/linux-perf-users/20220329093120.4173283-1-matthieu.baerts@tessares.net/T/#u

Fixes: 4e666cdb06ee ("perf tools: Fix dependency for version file creation")
Reported-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9c935f86d172..ddd03b21bda2 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -691,9 +691,8 @@ $(OUTPUT)common-cmds.h: $(wildcard Documentation/perf-*.txt)
 $(SCRIPTS) : % : %.sh
 	$(QUIET_GEN)$(INSTALL) '$@.sh' '$(OUTPUT)$@'
 
-$(OUTPUT)PERF-VERSION-FILE: ../../.git/HEAD ../../.git/ORIG_HEAD
+$(OUTPUT)PERF-VERSION-FILE: .FORCE-PERF-VERSION-FILE
 	$(Q)$(SHELL_PATH) util/PERF-VERSION-GEN $(OUTPUT)
-	$(Q)touch $(OUTPUT)PERF-VERSION-FILE
 
 # These can record PERF_VERSION
 perf.spec $(SCRIPTS) \
@@ -1139,21 +1138,12 @@ else
 	@echo "FEATURE-DUMP file available in $(OUTPUT)FEATURE-DUMP"
 endif
 
-#
-# Trick: if ../../.git does not exist - we are building out of tree for example,
-# then force version regeneration:
-#
-ifeq ($(wildcard ../../.git/HEAD),)
-    GIT-HEAD-PHONY = ../../.git/HEAD ../../.git/ORIG_HEAD
-else
-    GIT-HEAD-PHONY =
-endif
 
 FORCE:
 
 .PHONY: all install clean config-clean strip install-gtk
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-.PHONY: $(GIT-HEAD-PHONY) TAGS tags cscope FORCE prepare
+.PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
 .PHONY: libtraceevent_plugins archheaders
 
 endif # force_fixdep
-- 
2.26.2

