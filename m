Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CE952EFCA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351278AbiETP4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351276AbiETP43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:56:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D91F53A7C
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653062171; x=1684598171;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=QKc/EhjtozyiIqZXJMmyuE7NaobnHY6+1jw25/G7tsY=;
  b=ewvsxq3j1N5xGGG7niEJgFD8QGUv6ejhAtESExWKOcesdonzBuiuAP6L
   fL1l01W4COPICOsbO22ZjrYGv2EhHwK1vDI0FebwU6t/I04zITY2C+13b
   PUnkL7LkIiIaGl2GoO/MExZwO5/KP0IMGRe5Cr0k/3CkQ2YAwSJ1/3Jzq
   h+zTzzVtWL3I8DknyVKj4PxX0yc41GGeEzW0WOA42MjOazJFC5D5xHKd4
   M/Dr+1lUGqkGj+HkILqhCV3/Y+C0DnUmJ5S9OXBXemnLQezOaIRqybK3x
   5ScJy6m6U2LEoxE3gxrS7Y6VsVNIZXmPsOTdBoDKbYgndaJRSaHR48py9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="335700246"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="335700246"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 08:56:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="599284945"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.38.124])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 08:56:09 -0700
Message-ID: <ab8918a4-7ac8-a37e-2e2c-28438c422d87@intel.com>
Date:   Fri, 20 May 2022 18:56:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: [PATCH V2 2/5] libperf: Add preadn()
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220520132404.25853-1-adrian.hunter@intel.com>
 <20220520132404.25853-3-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220520132404.25853-3-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add preadn() to provide pread() and readn() semantics.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2:

	Make preadn() thread-safe in case someone infers
	from the name that it is.


 tools/lib/perf/include/internal/lib.h |  2 ++
 tools/lib/perf/lib.c                  | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/lib/perf/include/internal/lib.h b/tools/lib/perf/include/internal/lib.h
index 5175d491b2d49..85471a4b900f7 100644
--- a/tools/lib/perf/include/internal/lib.h
+++ b/tools/lib/perf/include/internal/lib.h
@@ -9,4 +9,6 @@ extern unsigned int page_size;
 ssize_t readn(int fd, void *buf, size_t n);
 ssize_t writen(int fd, const void *buf, size_t n);
 
+ssize_t preadn(int fd, void *buf, size_t n, off_t offs);
+
 #endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/lib/perf/lib.c b/tools/lib/perf/lib.c
index 18658931fc714..696fb0ea67c6e 100644
--- a/tools/lib/perf/lib.c
+++ b/tools/lib/perf/lib.c
@@ -38,6 +38,26 @@ ssize_t readn(int fd, void *buf, size_t n)
 	return ion(true, fd, buf, n);
 }
 
+ssize_t preadn(int fd, void *buf, size_t n, off_t offs)
+{
+	size_t left = n;
+
+	while (left) {
+		ssize_t ret = pread(fd, buf, left, offs);
+
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret <= 0)
+			return ret;
+
+		left -= ret;
+		buf  += ret;
+		offs += ret;
+	}
+
+	return n;
+}
+
 /*
  * Write exactly 'n' bytes or return an error.
  */
-- 
2.34.1

