Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6EE5ACCF3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbiIEHfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbiIEHez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:34:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C90140ED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662363293; x=1693899293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+nTHFuemR5oM1NhPlF1zfB39r/A8m5ItXCejZ9C21So=;
  b=cjmQDzmvbQGWpAiu/d0m96tQYspuEDhtkPX0R1CjtUUERWkqlf3h7oe1
   LpKrrSnYGSmXVkmVwKj/1FRqaSxkhb6uJuyn2kgV5ZjHH+q5GMNcbn3ML
   aPkFJ/vSf/Xf0pedkGvjq0VtATMRyYMTkQJuqRpnfHeKAtIzMKrsWjGpm
   0/zXbIRvViyxsvP/ggjLmgHeTCwmbRmc2ijGTHy8BMIn7jKWKpa62zhek
   /tISp8YoXWk1xEasa/jJlvluzGlv8/TCUripftpcgyVINir1oWcuX5Vuy
   fu3ThHHdt/x1uhhQIAeisu64YQ9EYmRaqQp5qhv8BKZDGzMqvNx54rrK6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="296332713"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="296332713"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:34:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="609595403"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.56.151])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:34:50 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/6] perf intel-pt: Remove first line of log dumped on error
Date:   Mon,  5 Sep 2022 10:34:24 +0300
Message-Id: <20220905073424.3971-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905073424.3971-1-adrian.hunter@intel.com>
References: <20220905073424.3971-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of printing "(first line may be sliced)", always remove the
first line of the debug log if the buffer has wrapped when dumping on
error.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2:

	Remove first line only if the buffer has wrapped.


 .../perf/util/intel-pt-decoder/intel-pt-log.c | 33 ++++++++++++++++---
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.c b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
index 24684edc49f7..ef55d6232cf0 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-log.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
@@ -143,16 +143,39 @@ static FILE *log_buf__open(struct log_buf *b, FILE *backend, unsigned int sz)
 	return file;
 }
 
+static bool remove_first_line(const char **p, size_t *n)
+{
+	for (; *n && **p != '\n'; ++*p, --*n)
+		;
+	if (*n) {
+		*p += 1;
+		*n -= 1;
+		return true;
+	}
+	return false;
+}
+
+static void write_lines(const char *p, size_t n, FILE *fp, bool *remove_first)
+{
+	if (*remove_first)
+		*remove_first = !remove_first_line(&p, &n);
+	fwrite(p, n, 1, fp);
+}
+
 static void log_buf__dump(struct log_buf *b)
 {
+	bool remove_first = false;
+
 	if (!b->buf)
 		return;
 
-	fflush(f);
-	fprintf(b->backend, "Dumping debug log buffer (first line may be sliced)\n");
-	if (b->wrapped)
-		fwrite(b->buf + b->head, b->buf_sz - b->head, 1, b->backend);
-	fwrite(b->buf, b->head, 1, b->backend);
+	fflush(f); /* Could update b->head and b->wrapped */
+	fprintf(b->backend, "Dumping debug log buffer\n");
+	if (b->wrapped) {
+		remove_first = true;
+		write_lines(b->buf + b->head, b->buf_sz - b->head, b->backend, &remove_first);
+	}
+	write_lines(b->buf, b->head, b->backend, &remove_first);
 	fprintf(b->backend, "End of debug log buffer dump\n");
 
 	b->head = 0;
-- 
2.25.1

