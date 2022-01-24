Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6E6497A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242233AbiAXImr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:42:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:62581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242251AbiAXIm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013749; x=1674549749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VqUTbbq8r4FFEUUEoQTcvjGJrwDHYMSfs+gNUrUb5jo=;
  b=MPo6ZxObyyaXh5Dz9cTYS75lknFjEY87Os5U36q/Yd3575JzwAxrjAfl
   S7EDa1ufmc1X4DHqBHdrlqk3ZJKV5xWRWZ0tXIvQClgjXeMYx1vZf0fRi
   EApfCNjF++iz6gFDkcmmP7aErqUGWkdjf9mcRhXYOfXYbqj+Ykj94BIpc
   I5/oL+Zc7p/i+IJhcXeI1qRE+9ZtjgzZVVIUmESGjiYj2cdSh8Bz7L+8f
   ocXuOL7TLndP6nThy678ASTHEtXlaIMmqfI/O0Cuf8dAaNPf9z+yn3/na
   nFD6P5TVnFzvZ+ynb1oxygnVxTG/6Oc0cq15XEA1SmHETFeBTl9qJsBfT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778423"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778423"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417110"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:27 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/25] perf tools: Define new D and t flags
Date:   Mon, 24 Jan 2022 10:41:47 +0200
Message-Id: <20220124084201.2699795-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define 2 new flags to represent:
 - when interrupts are disabled (D)
 - when interrupt disabling toggles (t)

This gives 4 combinations:
		no flag, interrupts enabled
	t	interrupts were enabled but become disabled
	D	interrupts are disabled
	Dt	interrupts were disabled but become enabled

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/event.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 9354619953e9..320cbcd5b902 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -101,9 +101,11 @@ enum {
 	PERF_IP_FLAG_IN_TX		= 1ULL << 10,
 	PERF_IP_FLAG_VMENTRY		= 1ULL << 11,
 	PERF_IP_FLAG_VMEXIT		= 1ULL << 12,
+	PERF_IP_FLAG_INTR_DISABLE	= 1ULL << 13,
+	PERF_IP_FLAG_INTR_TOGGLE	= 1ULL << 14,
 };
 
-#define PERF_IP_FLAG_CHARS "bcrosyiABExgh"
+#define PERF_IP_FLAG_CHARS "bcrosyiABExghDt"
 
 #define PERF_BRANCH_MASK		(\
 	PERF_IP_FLAG_BRANCH		|\
-- 
2.25.1

