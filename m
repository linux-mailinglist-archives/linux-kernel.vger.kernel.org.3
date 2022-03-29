Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D764EB40C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbiC2TXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiC2TXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:23:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCC43AA61
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 12:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C2CA61671
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D95C340ED;
        Tue, 29 Mar 2022 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648581717;
        bh=rOG5x7ne5RtE2hLtLSECZZWo9mT5dqZyYU+Xx5uD8AQ=;
        h=Date:From:To:Cc:Subject:From;
        b=ui4ImLq0Sre50G5qHVrcwmElhTUkoAc4S/PildXOaaXkWRUj4X+4xN388oM50fbBs
         ZhGc3hRgLHc9rGf650dNuxMYPyiW/JzCda7mLwyX3xP9rGTFzJgIvAxnWEQjDZDZNF
         xaMvSYQiDIXbST4fr3vwh/e+oCc6wnFyLW1X+ZC481mvhIUnHjwylzAQAane3j+Scy
         PISOrm32XmkRUsVSPA6YlDj0aqy7cjBoq8mKMTqgfvh71jBeKSpTQMns1r47iDxwRA
         Be1/SyLPF0LctMImMwUjQ75OyrXwehAm/9rGZWpNZ8Msw2SPoBNg88uj/MuxcxzoJ8
         7iFS8g3oFp89g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AFC8340407; Tue, 29 Mar 2022 16:21:53 -0300 (-03)
Date:   Tue, 29 Mar 2022 16:21:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [FYI PATCH 1/1] tools headers UAPI: Sync asm-generic/mman-common.h
 with the kernel
Message-ID: <YkNcUfeh795yqGMV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI: I'm carrying this patch on the perf tools tree.

- Arnaldo

---

To pick the changes from:

  9457056ac426e5ed ("mm: madvise: MADV_DONTNEED_LOCKED")

That result in these changes in the tools:

  $ diff -u tools/include/uapi/asm-generic/mman-common.h include/uapi/asm-generic/mman-common.h
  --- tools/include/uapi/asm-generic/mman-common.h	2022-03-29 16:17:50.461694991 -0300
  +++ include/uapi/asm-generic/mman-common.h	2022-03-27 19:12:48.923250468 -0300
  @@ -75,6 +75,8 @@
   #define MADV_POPULATE_READ	22	/* populate (prefault) page tables readable */
   #define MADV_POPULATE_WRITE	23	/* populate (prefault) page tables writable */

  +#define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
  +
   /* compatibility flags */
   #define MAP_FILE	0

  $ tools/perf/trace/beauty/madvise_behavior.sh > before
  $ cp include/uapi/asm-generic/mman-common.h tools/include/uapi/asm-generic/mman-common.h
  $ tools/perf/trace/beauty/madvise_behavior.sh > after
  $ diff -u before after
  --- before	2022-03-29 16:18:04.091044244 -0300
  +++ after	2022-03-29 16:18:11.692238906 -0300
  @@ -20,6 +20,7 @@
   	[21] = "PAGEOUT",
   	[22] = "POPULATE_READ",
   	[23] = "POPULATE_WRITE",
  +	[24] = "DONTNEED_LOCKED",
   	[100] = "HWPOISON",
   	[101] = "SOFT_OFFLINE",
   };
  $

I.e. now when madvise gets those behaviours as args, 'perf trace' will
be able to translate from the number to a human readable string and to
use the strings in tracepoint filter expressions.

This addresses the following perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman-common.h' differs from latest version at 'include/uapi/asm-generic/mman-common.h'
  diff -u tools/include/uapi/asm-generic/mman-common.h include/uapi/asm-generic/mman-common.h

Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/mman-common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index 1567a3294c3dbf3e..6c1aa92a92e44119 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -75,6 +75,8 @@
 #define MADV_POPULATE_READ	22	/* populate (prefault) page tables readable */
 #define MADV_POPULATE_WRITE	23	/* populate (prefault) page tables writable */
 
+#define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
-- 
2.35.1

