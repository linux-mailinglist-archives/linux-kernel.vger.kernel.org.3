Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0C055227C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiFTQuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiFTQuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:50:18 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95B21758B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:50:17 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id s6-20020a056e021a0600b002d8fcba296aso3971096ild.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ExmBzSKpLkiCHa59QsqYQ/MSjLYvSFah4s+gXGLxJqg=;
        b=YPF0ZpgHCqKySH8864zZhz8jjEywgWvK0N2eUVokfhTYL9opzubKr6lpU+aEV2Mt33
         6F7mvs7DFJpAtBqyOQK5B1ZGhjpyNSN7GGDq14uIcQrfP6RtdeZMDDJTXnPOJ+eVU8sc
         dMZDwRSkv5JYW8U17L7SqX1kJB0LcJB70pbUGK3rO1T2rD9qp/AZLuLDMC7XlpZBPwsJ
         v0aBxLFLCGUdmNQZJw1a2Uv5Zf/FT/+YyXYWlORlUWuRSRzcnKX+BYEDtWUxMOvRl9t3
         5qLBIzUR9OOEN3+/b39OiDXyxrXQmIcv69lth7biygb2Cl633/n7srzCZMCrxWbrf4qi
         7Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ExmBzSKpLkiCHa59QsqYQ/MSjLYvSFah4s+gXGLxJqg=;
        b=VXqfmWBsQ0HDjY9eBSH8ajT4Qt99OsHJVsMQ5dbUVq2litBsaWCWNhB5PPffQ1w3H+
         m6mXFHmK+koKlZays+2Pqwz5dyQb0P7AWbJ0JCLxf9oevQdrrPwAa8d/AIbnZLwsYQoT
         8J+/eGhtfS6u/cZ7Kj6imfhttN9ivkHKXydgWE9o5a/8L6byd+Lg9Ck7YzTcgL6lOGXR
         1yM31YSCojLevea0S8LdfksYvcJnaYODnwMD6rtdBc25bK5HiR2w+psf6EFtBw++aRDV
         K0kpUjroqOsnNgLjFDdpMihEph3+EYo7DCs77oyWGooUj9QB1S+aZ5yVWVrRHn6f0Gz1
         X0jA==
X-Gm-Message-State: AJIora9I+WN9pYqgz9cyXoHBP/+oa4lbq5sB/t+v19YTPFnUQX6z+GgN
        VejVcn7s49fk+zP+bU6i7ZrhmwIM0uOmoQ==
X-Google-Smtp-Source: AGRyM1vGM7WoTsCDjAm/pRnXDblKRzisQgoA2GpoRfzaTLDl0iP0ZMsyTomuWIie58fRybYOHkVAbMJibswRjQ==
X-Received: from riochico.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:b3e])
 (user=rsilvera job=sendgmr) by 2002:a92:902:0:b0:2d8:ea84:e37c with SMTP id
 y2-20020a920902000000b002d8ea84e37cmr8562357ilg.214.1655743817146; Mon, 20
 Jun 2022 09:50:17 -0700 (PDT)
Date:   Mon, 20 Jun 2022 16:49:53 +0000
Message-Id: <20220620164953.1503934-1-rsilvera@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH] perf: Adjust perf-inject output data offset for backward compatibility
From:   Raul Silvera <rsilvera@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Colin Ian King <colin.king@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Raul Silvera <rsilvera@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

When perf inject creates a new file, it reuses the data offset from the
input file. If there has been a change on the size of the header, as
happened in v5.12 -> v5.13, the new offsets will be wrong, resulting in
a corrupted output file.

This change adds the function perf_session__data_offset to compute the
data offset based on the current header size, and uses that instead of
the offset from the original input file.

Signed-off-by: Raul Silvera <rsilvera@google.com>
---
 tools/perf/builtin-inject.c |  2 +-
 tools/perf/util/header.c    | 16 +++++++++++++++-
 tools/perf/util/header.h    |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a75bf11585b5..1dfdcef36607 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -916,7 +916,7 @@ static int __cmd_inject(struct perf_inject *inject)
 		inject->tool.tracing_data = perf_event__repipe_tracing_data;
 	}
 
-	output_data_offset = session->header.data_offset;
+	output_data_offset = perf_session__data_offset(session->evlist);
 
 	if (inject->build_id_all) {
 		inject->tool.mmap	  = perf_event__repipe_buildid_mmap;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 53332da100e8..93706ae827f1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3660,7 +3660,7 @@ static int perf_session__do_write_header(struct perf_session *session,
 			.size   = evlist->core.nr_entries * sizeof(f_attr),
 		},
 		.data = {
-			.offset = header->data_offset,
+			.offset = attr_offset + evlist->core.nr_entries * sizeof(f_attr),
 			.size	= header->data_size,
 		},
 		/* event_types is ignored, store zeros */
@@ -3686,6 +3686,20 @@ int perf_session__write_header(struct perf_session *session,
 	return perf_session__do_write_header(session, evlist, fd, at_exit, NULL);
 }
 
+size_t perf_session__data_offset(const struct evlist *evlist)
+{
+	struct evsel *evsel;
+	size_t data_offset;
+
+	data_offset = sizeof(struct perf_file_header);
+	evlist__for_each_entry(evlist, evsel) {
+		data_offset += evsel->core.ids * sizeof(u64);
+	}
+	data_offset += evlist->core.nr_entries * sizeof(struct perf_file_attr);
+
+	return data_offset;
+}
+
 int perf_session__inject_header(struct perf_session *session,
 				struct evlist *evlist,
 				int fd,
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 08563c1f1bff..56916dabce7b 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -136,6 +136,8 @@ int perf_session__inject_header(struct perf_session *session,
 				int fd,
 				struct feat_copier *fc);
 
+size_t perf_session__data_offset(const struct evlist *evlist);
+
 void perf_header__set_feat(struct perf_header *header, int feat);
 void perf_header__clear_feat(struct perf_header *header, int feat);
 bool perf_header__has_feat(const struct perf_header *header, int feat);
-- 
2.37.0.rc0.104.g0611611a94-goog

