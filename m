Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F5497A77
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbiAXImX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:42:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:62581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242239AbiAXImN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013733; x=1674549733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ruYPOgJrcYMBa3FmjqCOu4n6zLK6I1fiqk+W/rHxgTc=;
  b=gldvlAX0inIrOreqHj1TB2nf7uYy1mabAyzghXoK2effShzMImzpQwRO
   A/jcAn9PrHmTN2lNuXH0SIh4u2P657T40W2lOeJk6sLMGCoDqE44Ns9wh
   rvMqz9R0Chk2bsFZa1KMmicLhfAEXyzusNjgP90htE0Xy3ZE34EircMUI
   0iOI1/eYTqIU0Fu4MmY0IcYektik9QGPCLHWJ3F+VvND8KiMX41ne7kd5
   I985dmm0WCFF9TpwVdswiNG4eTo3uV6NWh/1cf2SerPKMAPCxPfLZOdCm
   BnYUPNMzsGkUqOtLNK8UXXmWUYdZxEgGzUMO8pv6PLqOMwiDmXJhyk4LV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778338"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778338"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627416985"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:11 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/25] perf intel-pt: pkt-decoder: Add MODE.Exec IFLAG bit
Date:   Mon, 24 Jan 2022 10:41:40 +0200
Message-Id: <20220124084201.2699795-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of Intel SDM (https://www.intel.com/sdm) version 076, there is a new
Intel PT feature called Event Trace which adds a bit to the existing
MODE.Exec packet to record the interrupt flag. Amend the packet decoder and
packet decoder test accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c   | 7 +++++--
 tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c | 4 +++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c b/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
index 0155215c1d41..42237656f453 100644
--- a/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
+++ b/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
@@ -70,8 +70,11 @@ static struct test_data {
 	{8, {0x02, 0x43, 3, 4, 6, 8, 10, 12}, 0, {INTEL_PT_PIP, 0, 0xC0A08060403}, 0, 0 },
 	/* Mode Exec Packet */
 	{2, {0x99, 0x00}, 0, {INTEL_PT_MODE_EXEC, 0, 16}, 0, 0 },
-	{2, {0x99, 0x01}, 0, {INTEL_PT_MODE_EXEC, 0, 64}, 0, 0 },
-	{2, {0x99, 0x02}, 0, {INTEL_PT_MODE_EXEC, 0, 32}, 0, 0 },
+	{2, {0x99, 0x01}, 0, {INTEL_PT_MODE_EXEC, 1, 64}, 0, 0 },
+	{2, {0x99, 0x02}, 0, {INTEL_PT_MODE_EXEC, 2, 32}, 0, 0 },
+	{2, {0x99, 0x04}, 0, {INTEL_PT_MODE_EXEC, 4, 16}, 0, 0 },
+	{2, {0x99, 0x05}, 0, {INTEL_PT_MODE_EXEC, 5, 64}, 0, 0 },
+	{2, {0x99, 0x06}, 0, {INTEL_PT_MODE_EXEC, 6, 32}, 0, 0 },
 	/* Mode TSX Packet */
 	{2, {0x99, 0x20}, 0, {INTEL_PT_MODE_TSX, 0, 0}, 0, 0 },
 	{2, {0x99, 0x21}, 0, {INTEL_PT_MODE_TSX, 0, 1}, 0, 0 },
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index 885174964c27..18f97f43e01a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -504,6 +504,7 @@ static int intel_pt_get_mode(const unsigned char *buf, size_t len,
 	switch (buf[1] >> 5) {
 	case 0:
 		packet->type = INTEL_PT_MODE_EXEC;
+		packet->count = buf[1];
 		switch (buf[1] & 3) {
 		case 0:
 			packet->payload = 16;
@@ -741,7 +742,8 @@ int intel_pt_pkt_desc(const struct intel_pt_pkt *packet, char *buf,
 		return snprintf(buf, buf_len, "%s CTC 0x%x FC 0x%x", name,
 				(unsigned)payload, packet->count);
 	case INTEL_PT_MODE_EXEC:
-		return snprintf(buf, buf_len, "%s %lld", name, payload);
+		return snprintf(buf, buf_len, "%s IF:%d %lld",
+				name, !!(packet->count & 4), payload);
 	case INTEL_PT_MODE_TSX:
 		return snprintf(buf, buf_len, "%s TXAbort:%u InTX:%u",
 				name, (unsigned)(payload >> 1) & 1,
-- 
2.25.1

