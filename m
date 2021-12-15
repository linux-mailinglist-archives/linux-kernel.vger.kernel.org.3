Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F7D475417
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbhLOIIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:08:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:41311 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236140AbhLOIIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639555697; x=1671091697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EQFpy9S4/LN6TNdOKvpj+3kHSR8YJISD8yo7OpdJE98=;
  b=Cr8oPZ1ZrY2GM7HZ1/esEnXZaJa37gg9v7VMFHww8hD8ADZeyYyoGH2r
   +4UMp6pZ6R4vRwxxmH+tp6HsEnHx2L7PbLMsgN7+P/dbcvUKSByYgqce5
   bb+S1hVu/Iwe22aEq586JvjPEMx3pKPjii5n0RX9Cqqoe/KtIFzgnrafo
   WbidEvOcLr32Q/jb9tTsi94gQ8N59UNLa8ELK/MnIL+85q518QwiHrwg3
   /WFXsXav6xW5ADS6ypjksST01L51h7htIbRVyvdcceBx2HToFdcf2rnVB
   E/JiJOV+abhwkvZMbehKC8AM58k694aWOtaJwP0s8TP60klFgnaue2wJV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="302550173"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="302550173"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 00:06:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="505699421"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2021 00:06:42 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 2/3] perf script: Fix CPU filtering of a script's switch events
Date:   Wed, 15 Dec 2021 10:06:35 +0200
Message-Id: <20211215080636.149562-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215080636.149562-1-adrian.hunter@intel.com>
References: <20211215080636.149562-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU filtering was not being applied to a script's switch events.

Fixes: 5bf83c29a0ad2 ("perf script: Add scripting operation process_switch()")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9434367af166..c82b033e8942 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2473,7 +2473,7 @@ static int process_switch_event(struct perf_tool *tool,
 	if (perf_event__process_switch(tool, event, sample, machine) < 0)
 		return -1;
 
-	if (scripting_ops && scripting_ops->process_switch)
+	if (scripting_ops && scripting_ops->process_switch && !filter_cpu(sample))
 		scripting_ops->process_switch(event, sample, machine);
 
 	if (!script->show_switch_events)
-- 
2.25.1

