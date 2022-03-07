Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DC84D051D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244437AbiCGRUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244433AbiCGRUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:20:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4D4A8565F;
        Mon,  7 Mar 2022 09:19:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F392153B;
        Mon,  7 Mar 2022 09:19:31 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.41.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A94963FA45;
        Mon,  7 Mar 2022 09:19:29 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        anshuman.khandual@arm.com
Cc:     german.gomez@arm.com, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] perf: Refactor perf script branch stack printing
Date:   Mon,  7 Mar 2022 17:19:16 +0000
Message-Id: <20220307171917.2555829-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220307171917.2555829-1-james.clark@arm.com>
References: <20220307171917.2555829-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate code so that future changes to flags are always made to
all 3 printing variations.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-script.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9e032343f1c6..fac2e9470926 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -857,6 +857,15 @@ mispred_str(struct branch_entry *br)
 	return br->flags.predicted ? 'P' : 'M';
 }
 
+static int print_bstack_flags(FILE *fp, struct branch_entry *br)
+{
+	return fprintf(fp, "/%c/%c/%c/%d ",
+		       mispred_str(br),
+		       br->flags.in_tx ? 'X' : '-',
+		       br->flags.abort ? 'A' : '-',
+		       br->flags.cycles);
+}
+
 static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 					struct thread *thread,
 					struct perf_event_attr *attr, FILE *fp)
@@ -895,11 +904,7 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 			printed += fprintf(fp, ")");
 		}
 
-		printed += fprintf(fp, "/%c/%c/%c/%d ",
-			mispred_str(entries + i),
-			entries[i].flags.in_tx ? 'X' : '-',
-			entries[i].flags.abort ? 'A' : '-',
-			entries[i].flags.cycles);
+		printed += print_bstack_flags(fp, entries + i);
 	}
 
 	return printed;
@@ -941,11 +946,7 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 			printed += map__fprintf_dsoname(alt.map, fp);
 			printed += fprintf(fp, ")");
 		}
-		printed += fprintf(fp, "/%c/%c/%c/%d ",
-			mispred_str(entries + i),
-			entries[i].flags.in_tx ? 'X' : '-',
-			entries[i].flags.abort ? 'A' : '-',
-			entries[i].flags.cycles);
+		printed += print_bstack_flags(fp, entries + i);
 	}
 
 	return printed;
@@ -991,11 +992,7 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 			printed += map__fprintf_dsoname(alt.map, fp);
 			printed += fprintf(fp, ")");
 		}
-		printed += fprintf(fp, "/%c/%c/%c/%d ",
-			mispred_str(entries + i),
-			entries[i].flags.in_tx ? 'X' : '-',
-			entries[i].flags.abort ? 'A' : '-',
-			entries[i].flags.cycles);
+		printed += print_bstack_flags(fp, entries + i);
 	}
 
 	return printed;
-- 
2.28.0

