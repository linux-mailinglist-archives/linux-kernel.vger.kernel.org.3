Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9636548C03C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349472AbiALIvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:51:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:1134 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237959AbiALIvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641977460; x=1673513460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3BkFAFfHwy4jrIGT9bGeUQf8kxHlsUWji9HfgEYUk0A=;
  b=OuaZJaO9qHMB0/dM4veZKKEoTZxCeWYxBtKz4JqOhBLYiC9KAujPkWni
   FLtttaghy+i6v8Bj+mxoDbIJ4VgqfvtTUbLmPz3t06hLg4lYTTPr/CU7/
   iwuPiKbNFSHzjH2hc/WU3B6z4QqRBv3OuH4EgPyJpThLe/f/+46ocFOPb
   fCuI3Q9LpwzI6zWDbB16w/k4/OWUONrW/yzzPmSCFWFr3fIh73z9ucQFd
   R6CIHRQRQlkM3bYhnTYI2D6W1WDmd59j/ZCgEhDzC699SZoAEviZyAkI9
   5vwLvYZr3rbQp7gHZlltyrng7mssf34EKRDnRtD4DPDt65cKE2401N95u
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243488473"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="243488473"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 00:50:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="515409394"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga007.jf.intel.com with ESMTP; 12 Jan 2022 00:50:58 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf script: Fix hex dump character output
Date:   Wed, 12 Jan 2022 10:50:57 +0200
Message-Id: <20220112085057.277205-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using grep -C with perf script -D can give erroneous results as grep loses
lines due to non-printable characters, for example, below the 0020, 0060
and 0070 lines are missing:

 $ perf script -D | grep -C10 AUX | head
 .  0010:  08 00 00 00 00 00 00 00 1f 00 00 00 00 00 00 00  ................
 .  0030:  01 00 00 00 00 00 00 00 00 04 00 00 00 00 00 00  ................
 .  0040:  00 08 00 00 00 00 00 00 02 00 00 00 00 00 00 00  ................
 .  0050:  00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
 .  0080:  02 00 00 00 00 00 00 00 1b 00 00 00 00 00 00 00  ................
 .  0090:  00 00 00 00 00 00 00 00                          ........

 0 0 0x450 [0x98]: PERF_RECORD_AUXTRACE_INFO type: 1
   PMU Type            8
   Time Shift          31

perf's isprint() is a custom implementation from the kernel, but the
kernel's _ctype appears to include characters from Latin-1 Supplement which
is not compatible with, for example, UTF-8. Fix by checking also isascii().

After:

 $ tools/perf/perf script -D | grep -C10 AUX | head
 .  0010:  08 00 00 00 00 00 00 00 1f 00 00 00 00 00 00 00  ................
 .  0020:  03 84 32 2f 00 00 00 00 63 7c 4f d2 fa ff ff ff  ..2/....c|O.....
 .  0030:  01 00 00 00 00 00 00 00 00 04 00 00 00 00 00 00  ................
 .  0040:  00 08 00 00 00 00 00 00 02 00 00 00 00 00 00 00  ................
 .  0050:  00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
 .  0060:  00 02 00 00 00 00 00 00 00 c0 03 00 00 00 00 00  ................
 .  0070:  e2 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00  ................
 .  0080:  02 00 00 00 00 00 00 00 1b 00 00 00 00 00 00 00  ................
 .  0090:  00 00 00 00 00 00 00 00                          ........

Fixes: 3052ba56bcb589 ("tools perf: Move from sane_ctype.h obtained from git to the Linux's original")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index c7a9fa0ffae9..7b5eec300d66 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -189,7 +189,7 @@ static int trace_event_printer(enum binary_printer_ops op,
 		break;
 	case BINARY_PRINT_CHAR_DATA:
 		printed += color_fprintf(fp, color, "%c",
-			      isprint(ch) ? ch : '.');
+			      isprint(ch) && isascii(ch) ? ch : '.');
 		break;
 	case BINARY_PRINT_CHAR_PAD:
 		printed += color_fprintf(fp, color, " ");
-- 
2.25.1

