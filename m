Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0594E52ED0A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349782AbiETNY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349766AbiETNYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:24:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11EE149D83
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653053060; x=1684589060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iv29HntL/Q08w5g4iDaOvR5G0CNgN0/IpP8ZjjHsRRU=;
  b=FDGICByjzDnMRB6hA0AWjIPhiSkx3Dq6XcocEkHbIAvn7BryfrwNa4lx
   5Ef9DYKMqyRHSSYoZYIhEO3VadnGiov3A+2Wxm3NEQ5lxWLQyoT24zDUb
   DTRPzlmmJ9AlCbMPILEfYHiBuVp7WXTkk3GD9rDyzGcCgOuNaZ9aZiOjo
   VP4LLqymZ3a7ByzJ/s0ywe6pAHrJUuNP9s/b52g0XEhVkTTcn8zZi6uZN
   xnaiybNVR6NXUZwNXVWsi9GhRKK8K6MXziodbO40XbVC7HBnAzMr+753q
   vY57VXf6wEr1RyK1VMipvePth4VXJwKLrbpuAmd7pRCRgHFQNJzLWLX4H
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="335661010"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="335661010"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:24:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="715530808"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.38.124])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:24:19 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] perf header: Add ability to keep feature sections
Date:   Fri, 20 May 2022 16:24:00 +0300
Message-Id: <20220520132404.25853-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520132404.25853-1-adrian.hunter@intel.com>
References: <20220520132404.25853-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many feature sections should not be re-written during perf inject. In
preparation to support that, add callbacks that a tool can use to copy
a feature section from elsewhere. perf inject will use this facility to
copy features sections from the input file.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/header.c | 54 ++++++++++++++++++++++++++++++++++------
 tools/perf/util/header.h | 10 ++++++++
 2 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a27132e5a5ef..b0c57a130d1e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3462,9 +3462,22 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 	return 0;
 }
 
+struct header_fw {
+	struct feat_writer	fw;
+	struct feat_fd		*ff;
+};
+
+static int feat_writer_cb(struct feat_writer *fw, void *buf, size_t sz)
+{
+	struct header_fw *h = container_of(fw, struct header_fw, fw);
+
+	return do_write(h->ff, buf, sz);
+}
+
 static int do_write_feat(struct feat_fd *ff, int type,
 			 struct perf_file_section **p,
-			 struct evlist *evlist)
+			 struct evlist *evlist,
+			 struct feat_copier *fc)
 {
 	int err;
 	int ret = 0;
@@ -3478,7 +3491,23 @@ static int do_write_feat(struct feat_fd *ff, int type,
 
 		(*p)->offset = lseek(ff->fd, 0, SEEK_CUR);
 
-		err = feat_ops[type].write(ff, evlist);
+		/*
+		 * Hook to let perf inject copy features sections from the input
+		 * file.
+		 */
+		if (fc && fc->copy) {
+			struct header_fw h = {
+				.fw.write = feat_writer_cb,
+				.ff = ff,
+			};
+
+			/* ->copy() returns 0 if the feature was not copied */
+			err = fc->copy(fc, type, &h.fw);
+		} else {
+			err = 0;
+		}
+		if (!err)
+			err = feat_ops[type].write(ff, evlist);
 		if (err < 0) {
 			pr_debug("failed to write feature %s\n", feat_ops[type].name);
 
@@ -3494,7 +3523,8 @@ static int do_write_feat(struct feat_fd *ff, int type,
 }
 
 static int perf_header__adds_write(struct perf_header *header,
-				   struct evlist *evlist, int fd)
+				   struct evlist *evlist, int fd,
+				   struct feat_copier *fc)
 {
 	int nr_sections;
 	struct feat_fd ff;
@@ -3523,7 +3553,7 @@ static int perf_header__adds_write(struct perf_header *header,
 	lseek(fd, sec_start + sec_size, SEEK_SET);
 
 	for_each_set_bit(feat, header->adds_features, HEADER_FEAT_BITS) {
-		if (do_write_feat(&ff, feat, &p, evlist))
+		if (do_write_feat(&ff, feat, &p, evlist, fc))
 			perf_header__clear_feat(header, feat);
 	}
 
@@ -3561,9 +3591,10 @@ int perf_header__write_pipe(int fd)
 	return 0;
 }
 
-int perf_session__write_header(struct perf_session *session,
-			       struct evlist *evlist,
-			       int fd, bool at_exit)
+static int perf_session__do_write_header(struct perf_session *session,
+					 struct evlist *evlist,
+					 int fd, bool at_exit,
+					 struct feat_copier *fc)
 {
 	struct perf_file_header f_header;
 	struct perf_file_attr   f_attr;
@@ -3615,7 +3646,7 @@ int perf_session__write_header(struct perf_session *session,
 	header->feat_offset = header->data_offset + header->data_size;
 
 	if (at_exit) {
-		err = perf_header__adds_write(header, evlist, fd);
+		err = perf_header__adds_write(header, evlist, fd, fc);
 		if (err < 0)
 			return err;
 	}
@@ -3648,6 +3679,13 @@ int perf_session__write_header(struct perf_session *session,
 	return 0;
 }
 
+int perf_session__write_header(struct perf_session *session,
+			       struct evlist *evlist,
+			       int fd, bool at_exit)
+{
+	return perf_session__do_write_header(session, evlist, fd, at_exit, NULL);
+}
+
 static int perf_header__getbuffer64(struct perf_header *header,
 				    int fd, void *buf, size_t size)
 {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 0eb4bc29a5a4..e76ab02d5541 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -121,6 +121,16 @@ int perf_session__write_header(struct perf_session *session,
 			       int fd, bool at_exit);
 int perf_header__write_pipe(int fd);
 
+/* feat_writer writes a feature section to output */
+struct feat_writer {
+	int (*write)(struct feat_writer *fw, void *buf, size_t sz);
+};
+
+/* feat_copier copies a feature section using feat_writer to output */
+struct feat_copier {
+	int (*copy)(struct feat_copier *fc, int feat, struct feat_writer *fw);
+};
+
 void perf_header__set_feat(struct perf_header *header, int feat);
 void perf_header__clear_feat(struct perf_header *header, int feat);
 bool perf_header__has_feat(const struct perf_header *header, int feat);
-- 
2.25.1

