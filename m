Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2D0543F51
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiFHWoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbiFHWoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:44:11 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A9A115C8F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 15:44:10 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id w36-20020a17090a6ba700b001e876698a01so6732350pjj.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 15:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bfkEdtucqgA+wBrOBxrBZd3UEfs8ZNdv2ifdbarRzlY=;
        b=ekhZ4wBvlPn/dbdAv6DpZoPYJXSrjHhH3vsu1Ns85VYgtvnHjevVS+J3GQ6jXRTSfX
         3phJNq0VEY5NXH5SQCmeb3Wq4ya5jZRnyK3jkeGs7V79agvHEAOec6tOLhKA0RW67VzT
         lnJC1t81mZiCjUex1/HhgnUlDvtebaL8C1CERHhIqNNS5COd4+lb2EudOnc17DiBvm7n
         kxr5s3eFaqc8gnb76bOXNg+jY/wA6p37zN8dLeK7s6Hnqm4Zuf8hGGepLgpmAFXl5bKm
         OJXZ6wLTeFcASLUd9lTPgYjpbXPXUJsUR2RAKHoMZt38KoirvOb8O/Sj4+wiMub0gf1U
         e52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bfkEdtucqgA+wBrOBxrBZd3UEfs8ZNdv2ifdbarRzlY=;
        b=nu+vXCqBjOf1/ytFb9P/u2Hjypt1BCbpNSepr6rh37xqz64cupF3fN/5Aq4hRNaoz7
         5wue9QHc07It1phwE+wc8oIxtP5OEr3BltYC8FA0xbcFzLSjaFAMkRvme3mb0FK1JuPh
         osAekIq7PCupxrAez+vtbO219ke3FIM598Q2AHH+3ujty/DqvV4XnGBh17AwTRkWKrTO
         D/Nul6er5tPCqOstmimfTWJEobhJljR02/fNBEWYnrmb6tGH+iNpnhdeMcFz4kad+QpF
         aqGjixUCBbG8HVncA+zBFqLgfPr5XX5n7QU8XtBVxoKjXWUmLmHrmnLEBzeteSnhRoQT
         OBRA==
X-Gm-Message-State: AOAM5336Sknjm/NiLunpOl+EacnLe1AyzjMR+LPbZWcat3tbAx3gXLJk
        3pzbMvGm+vfaZEY2Uph+uAvQvdXD7Web
X-Google-Smtp-Source: ABdhPJwiZrRqHCYP62YKEXvoVQ53Bbqy96qtS43wIUeLesJ+bttYHn5FJ24TSzmDscTk0ZfS1Ktj1g/cMxU6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:de48:5efa:e4a1:2219])
 (user=irogers job=sendgmr) by 2002:a05:6a00:1a91:b0:51c:2ef4:fa1c with SMTP
 id e17-20020a056a001a9100b0051c2ef4fa1cmr13542691pfv.75.1654728250194; Wed,
 08 Jun 2022 15:44:10 -0700 (PDT)
Date:   Wed,  8 Jun 2022 15:43:50 -0700
In-Reply-To: <20220608224353.1176079-1-irogers@google.com>
Message-Id: <20220608224353.1176079-2-irogers@google.com>
Mime-Version: 1.0
References: <20220608224353.1176079-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 1/4] libperf evsel: Open shouldn't leak fd on failure
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the perf_event_open fails the fd is opened but the fd is only freed
by closing (not by delete). Typically when an open fails you don't call
close and so this results in a memory leak. To avoid this, add a close
when open fails.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evsel.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c1d58673f6ef..952f3520d5c2 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -149,23 +149,30 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 			int fd, group_fd, *evsel_fd;
 
 			evsel_fd = FD(evsel, idx, thread);
-			if (evsel_fd == NULL)
-				return -EINVAL;
+			if (evsel_fd == NULL) {
+				err = -EINVAL;
+				goto out;
+			}
 
 			err = get_group_fd(evsel, idx, thread, &group_fd);
 			if (err < 0)
-				return err;
+				goto out;
 
 			fd = sys_perf_event_open(&evsel->attr,
 						 threads->map[thread].pid,
 						 cpu, group_fd, 0);
 
-			if (fd < 0)
-				return -errno;
+			if (fd < 0) {
+				err = -errno;
+				goto out;
+			}
 
 			*evsel_fd = fd;
 		}
 	}
+out:
+	if (err)
+		perf_evsel__close(evsel);
 
 	return err;
 }
-- 
2.36.1.255.ge46751e96f-goog

