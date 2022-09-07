Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7A65B0230
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiIGK4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIGK4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:56:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA2C70E62;
        Wed,  7 Sep 2022 03:56:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 95E0E33912;
        Wed,  7 Sep 2022 10:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662548198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=//MZlcT6eU5vDlRWsa/iMgNiD/OaPXoYWtqxLmFxrQU=;
        b=mV8HwtR20OHwkonR1Vlypdq9ZXtIlMwZeiVPoqsIXQ3HnugVcIhQ2r5njvnGd4i0Rlb1d0
        23OmPHmfpQ7ck3is73Ctjwmeel46wGrcUy4vYe4AWbciEOpEiKecC2NvCiaSeEruec85zB
        BHaHHMmVUVruYpLaK2GoO4GOMPK9RkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662548198;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=//MZlcT6eU5vDlRWsa/iMgNiD/OaPXoYWtqxLmFxrQU=;
        b=qhMIoMOKpefDo69RSOVGyjG4OJt3rFZnWPbS5bG/INDvlbJxpp7AosXNleEe2nPcB8Ly/0
        sexirFySrSVScICA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CF7172C141;
        Wed,  7 Sep 2022 10:56:37 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     acme@redhat.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] perf: don't install data files with x permissions
Date:   Wed,  7 Sep 2022 12:56:34 +0200
Message-Id: <20220907105634.29649-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

install(1), by default, installs with rwxr-xr-x permissions. Modify
perf's Makefile to pass '-m 644' when installing:
* perf_dlfilter.h header
* trace/strace/groups/*
* scripts/perl/Perf-Trace-Util/lib/Perf/Trace/*
* scripts/perl/*.pl
* perf-completion.sh
* Documentation/tips.txt
* tests/attr.py
* tests/attr/*
* tests/shell/lib/*.sh

All those are supposed to be non-executable. Either they are not scripts
at all, or they don't have shebang.

Fixes: 0beb218315e0 (perf build: Install perf_dlfilter.h)
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 tools/perf/Makefile.perf | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e5921b347153..52826a242c68 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -967,13 +967,13 @@ endif
 ifndef NO_LIBAUDIT
 	$(call QUIET_INSTALL, strace/groups) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'; \
-		$(INSTALL) trace/strace/groups/* -t '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'
+		$(INSTALL) trace/strace/groups/* -m 644 -t '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'
 endif
 ifndef NO_LIBPERL
 	$(call QUIET_INSTALL, perl-scripts) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
-		$(INSTALL) scripts/perl/Perf-Trace-Util/lib/Perf/Trace/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
-		$(INSTALL) scripts/perl/*.pl -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl'; \
+		$(INSTALL) scripts/perl/Perf-Trace-Util/lib/Perf/Trace/* -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
+		$(INSTALL) scripts/perl/*.pl -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/bin'; \
 		$(INSTALL) scripts/perl/bin/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/bin'
 endif
@@ -990,23 +990,23 @@ endif
 		$(INSTALL) $(DLFILTERS) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/dlfilters';
 	$(call QUIET_INSTALL, perf_completion-script) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(sysconfdir_SQ)/bash_completion.d'; \
-		$(INSTALL) perf-completion.sh '$(DESTDIR_SQ)$(sysconfdir_SQ)/bash_completion.d/perf'
+		$(INSTALL) perf-completion.sh -m 644 '$(DESTDIR_SQ)$(sysconfdir_SQ)/bash_completion.d/perf'
 	$(call QUIET_INSTALL, perf-tip) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(tip_instdir_SQ)'; \
-		$(INSTALL) Documentation/tips.txt -t '$(DESTDIR_SQ)$(tip_instdir_SQ)'
+		$(INSTALL) Documentation/tips.txt -m 644 -t '$(DESTDIR_SQ)$(tip_instdir_SQ)'
 
 install-tests: all install-gtk
 	$(call QUIET_INSTALL, tests) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
-		$(INSTALL) tests/attr.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
+		$(INSTALL) tests/attr.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
 		$(INSTALL) tests/pe-file.exe* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
-		$(INSTALL) tests/attr/* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
+		$(INSTALL) tests/attr/* -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
 		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
-		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
-		$(INSTALL) tests/shell/lib/*.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
+		$(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
+		$(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
 
 install-bin: install-tools install-tests install-traceevent-plugins
 
-- 
2.37.3

