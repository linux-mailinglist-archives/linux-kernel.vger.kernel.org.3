Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988F849106A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiAQSga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:36:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:48606 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242628AbiAQSer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642444486; x=1673980486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mYkC69QeVaw1eSEJY4L24VYYn4aS7wkr+OUnrytuVIU=;
  b=DjtOYLva9X6VyJYYucFBN4oUD1nvVf9Y9JZmbkH5a80TVoI3mDyGrilM
   GCkkFZeCFMfeiJtSYV2i6mxaTF1veZC2wNq6Z5Uol1td9cl1Nfw76L8rK
   IOHDHdU1us3LZxRk27YCBgx2qG6FNytfS1/QzVuDFTh9lEny1tnx2Obf+
   MJHuHyq7PKkK5UiB1PNRtTvl64MPu0cG8o/AQ6ID2pMe4KxAmVTq38SN0
   PfihSe5BZ3S/qbbue2nnR4PsiRMX3GaNDQvi5arVyQaNbiTXtUcUOyIja
   4YyPOg48auHxca8P7OttG3I0f+cTzr4tfCKPdrZJzEXjxkhOKjRL2Wf30
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224655971"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224655971"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:34:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="492434184"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2022 10:34:43 -0800
From:   Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [PATCH v13 02/16] tools lib: Introduce fdarray duplicate function
Date:   Mon, 17 Jan 2022 21:34:22 +0300
Message-Id: <2891f1def287d5863cc82683a4d5879195c8d90c.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a function to duplicate an existing file descriptor in
the fdarray structure. The function returns the position of the duplicated
file descriptor.

Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/lib/api/fd/array.c | 17 +++++++++++++++++
 tools/lib/api/fd/array.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 5e6cb9debe37..f0f195207fca 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -88,6 +88,23 @@ int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags
 	return pos;
 }
 
+int fdarray__dup_entry_from(struct fdarray *fda, int pos, struct fdarray *from)
+{
+	struct pollfd *entry;
+	int npos;
+
+	if (pos >= from->nr)
+		return -EINVAL;
+
+	entry = &from->entries[pos];
+
+	npos = fdarray__add(fda, entry->fd, entry->events, from->priv[pos].flags);
+	if (npos >= 0)
+		fda->priv[npos] = from->priv[pos];
+
+	return npos;
+}
+
 int fdarray__filter(struct fdarray *fda, short revents,
 		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
 		    void *arg)
diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
index 7fcf21a33c0c..60ad197c8ee9 100644
--- a/tools/lib/api/fd/array.h
+++ b/tools/lib/api/fd/array.h
@@ -42,6 +42,7 @@ struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow);
 void fdarray__delete(struct fdarray *fda);
 
 int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags flags);
+int fdarray__dup_entry_from(struct fdarray *fda, int pos, struct fdarray *from);
 int fdarray__poll(struct fdarray *fda, int timeout);
 int fdarray__filter(struct fdarray *fda, short revents,
 		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
-- 
2.19.0

