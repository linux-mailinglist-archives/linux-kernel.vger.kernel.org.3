Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E7F497A76
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbiAXImW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:42:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:62581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242235AbiAXImL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013731; x=1674549731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4HqDhHpdzhZMi5Mnlsq1Wqbo/bNQn4IaJJZW/kCwnuY=;
  b=g2UKcuxg3WWh8BfE6MOmjIy9qCiTSH/1r/i5xNS9p89sxe5rq23qbebe
   aSD7LPGN+xO9CHLJrQ6l/DJx5Nj4M3U+4xgq2WUhl3uzfikkMNbab54bT
   C97QQg+GYjK8ErKkUcMdJJ+hjhvurTD19jd6vohmIqENjgtEpKbeewCYO
   X+FsP3N4dhu3I5GtqnNoxQSYewNHG7YixqxnEHa3qVHHD/bNu0Q1Spp/h
   S+qE51Z2/GH99CV6ZdsVsQIzDWiiCPR0KAcwJdH24KaY6chYw45B/hFyp
   bJkNl0Tqh9StnrQRrjvu36u2Lrnlu5JStl9FC/KvE2u45XzC+KLiMcmt/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778334"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778334"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627416964"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:09 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 03/25] perf intel-pt: pkt-decoder: Add CFE and EVD packets
Date:   Mon, 24 Jan 2022 10:41:39 +0200
Message-Id: <20220124084201.2699795-4-adrian.hunter@intel.com>
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
Intel PT feature called Event Trace which requires 2 new packets CFE and
EVD. Add them to the packet decoder and packet decoder test.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../x86/tests/intel-pt-pkt-decoder-test.c     |  8 ++++
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 32 +++++++++++++++
 .../intel-pt-decoder/intel-pt-pkt-decoder.c   | 40 +++++++++++++++++++
 .../intel-pt-decoder/intel-pt-pkt-decoder.h   |  3 ++
 4 files changed, 83 insertions(+)

diff --git a/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c b/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
index 395de4471840..0155215c1d41 100644
--- a/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
+++ b/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
@@ -166,6 +166,14 @@ static struct test_data {
 	{2, {0x02, 0xb3}, INTEL_PT_BLK_4_CTX, {INTEL_PT_BEP_IP, 0, 0}, 0, 0 },
 	{2, {0x02, 0x33}, INTEL_PT_BLK_8_CTX, {INTEL_PT_BEP, 0, 0}, 0, 0 },
 	{2, {0x02, 0xb3}, INTEL_PT_BLK_8_CTX, {INTEL_PT_BEP_IP, 0, 0}, 0, 0 },
+	/* Control Flow Event Packet */
+	{4, {0x02, 0x13, 0x01, 0x03}, 0, {INTEL_PT_CFE, 1, 3}, 0, 0 },
+	{4, {0x02, 0x13, 0x81, 0x03}, 0, {INTEL_PT_CFE_IP, 1, 3}, 0, 0 },
+	{4, {0x02, 0x13, 0x1f, 0x00}, 0, {INTEL_PT_CFE, 0x1f, 0}, 0, 0 },
+	{4, {0x02, 0x13, 0x9f, 0xff}, 0, {INTEL_PT_CFE_IP, 0x1f, 0xff}, 0, 0 },
+	/*  */
+	{11, {0x02, 0x53, 0x09, 1, 2, 3, 4, 5, 6, 7}, 0, {INTEL_PT_EVD, 0x09, 0x7060504030201}, 0, 0 },
+	{11, {0x02, 0x53, 0x3f, 2, 3, 4, 5, 6, 7, 8}, 0, {INTEL_PT_EVD, 0x3f, 0x8070605040302}, 0, 0 },
 	/* Terminator */
 	{0, {0}, 0, {0, 0, 0}, 0, 0 },
 };
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 0e013c2d9eb4..3980ee2080ae 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -820,6 +820,9 @@ static int intel_pt_calc_cyc_cb(struct intel_pt_pkt_info *pkt_info)
 	case INTEL_PT_BIP:
 	case INTEL_PT_BEP:
 	case INTEL_PT_BEP_IP:
+	case INTEL_PT_CFE:
+	case INTEL_PT_CFE_IP:
+	case INTEL_PT_EVD:
 		return 0;
 
 	case INTEL_PT_MTC:
@@ -1873,6 +1876,9 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 		case INTEL_PT_BIP:
 		case INTEL_PT_BEP:
 		case INTEL_PT_BEP_IP:
+		case INTEL_PT_CFE:
+		case INTEL_PT_CFE_IP:
+		case INTEL_PT_EVD:
 			decoder->have_tma = false;
 			intel_pt_log("ERROR: Unexpected packet\n");
 			err = -EAGAIN;
@@ -1975,6 +1981,9 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 		case INTEL_PT_BIP:
 		case INTEL_PT_BEP:
 		case INTEL_PT_BEP_IP:
+		case INTEL_PT_CFE:
+		case INTEL_PT_CFE_IP:
+		case INTEL_PT_EVD:
 			intel_pt_log("ERROR: Missing TIP after FUP\n");
 			decoder->pkt_state = INTEL_PT_STATE_ERR3;
 			decoder->pkt_step = 0;
@@ -2134,6 +2143,9 @@ static int intel_pt_vm_psb_lookahead_cb(struct intel_pt_pkt_info *pkt_info)
 	case INTEL_PT_TIP:
 	case INTEL_PT_PSB:
 	case INTEL_PT_TRACESTOP:
+	case INTEL_PT_CFE:
+	case INTEL_PT_CFE_IP:
+	case INTEL_PT_EVD:
 	default:
 		return 1;
 	}
@@ -2653,6 +2665,9 @@ static int intel_pt_vm_time_correlation(struct intel_pt_decoder *decoder)
 			decoder->blk_type = 0;
 			break;
 
+		case INTEL_PT_CFE:
+		case INTEL_PT_CFE_IP:
+		case INTEL_PT_EVD:
 		case INTEL_PT_MODE_EXEC:
 		case INTEL_PT_MODE_TSX:
 		case INTEL_PT_MNT:
@@ -2789,6 +2804,9 @@ static int intel_pt_hop_trace(struct intel_pt_decoder *decoder, bool *no_tip, in
 	case INTEL_PT_BIP:
 	case INTEL_PT_BEP:
 	case INTEL_PT_BEP_IP:
+	case INTEL_PT_CFE:
+	case INTEL_PT_CFE_IP:
+	case INTEL_PT_EVD:
 	default:
 		return HOP_PROCESS;
 	}
@@ -2857,6 +2875,9 @@ static int intel_pt_psb_lookahead_cb(struct intel_pt_pkt_info *pkt_info)
 	case INTEL_PT_BIP:
 	case INTEL_PT_BEP:
 	case INTEL_PT_BEP_IP:
+	case INTEL_PT_CFE:
+	case INTEL_PT_CFE_IP:
+	case INTEL_PT_EVD:
 		if (data->after_psbend) {
 			data->after_psbend -= 1;
 			if (!data->after_psbend)
@@ -3223,6 +3244,11 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 			}
 			goto next;
 
+		case INTEL_PT_CFE:
+		case INTEL_PT_CFE_IP:
+		case INTEL_PT_EVD:
+			break;
+
 		default:
 			return intel_pt_bug(decoder);
 		}
@@ -3265,6 +3291,9 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 		case INTEL_PT_BIP:
 		case INTEL_PT_BEP:
 		case INTEL_PT_BEP_IP:
+		case INTEL_PT_CFE:
+		case INTEL_PT_CFE_IP:
+		case INTEL_PT_EVD:
 			intel_pt_log("ERROR: Unexpected packet\n");
 			err = -ENOENT;
 			goto out;
@@ -3476,6 +3505,9 @@ static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
 		case INTEL_PT_BIP:
 		case INTEL_PT_BEP:
 		case INTEL_PT_BEP_IP:
+		case INTEL_PT_CFE:
+		case INTEL_PT_CFE_IP:
+		case INTEL_PT_EVD:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index fada96746705..885174964c27 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -64,6 +64,9 @@ static const char * const packet_name[] = {
 	[INTEL_PT_BIP]		= "BIP",
 	[INTEL_PT_BEP]		= "BEP",
 	[INTEL_PT_BEP_IP]	= "BEP",
+	[INTEL_PT_CFE]		= "CFE",
+	[INTEL_PT_CFE_IP]	= "CFE",
+	[INTEL_PT_EVD]		= "EVD",
 };
 
 const char *intel_pt_pkt_name(enum intel_pt_pkt_type type)
@@ -328,6 +331,29 @@ static int intel_pt_get_bep_ip(size_t len, struct intel_pt_pkt *packet)
 	return 2;
 }
 
+static int intel_pt_get_cfe(const unsigned char *buf, size_t len,
+			    struct intel_pt_pkt *packet)
+{
+	if (len < 4)
+		return INTEL_PT_NEED_MORE_BYTES;
+	packet->type = buf[2] & 0x80 ? INTEL_PT_CFE_IP : INTEL_PT_CFE;
+	packet->count = buf[2] & 0x1f;
+	packet->payload = buf[3];
+	return 4;
+}
+
+static int intel_pt_get_evd(const unsigned char *buf, size_t len,
+			    struct intel_pt_pkt *packet)
+{
+	if (len < 11)
+		return INTEL_PT_NEED_MORE_BYTES;
+	packet->type = INTEL_PT_EVD;
+	packet->count = buf[2] & 0x3f;
+	packet->payload = buf[3];
+	memcpy_le64(&packet->payload, buf + 3, 8);
+	return 11;
+}
+
 static int intel_pt_get_ext(const unsigned char *buf, size_t len,
 			    struct intel_pt_pkt *packet)
 {
@@ -374,6 +400,10 @@ static int intel_pt_get_ext(const unsigned char *buf, size_t len,
 		return intel_pt_get_bep(len, packet);
 	case 0xb3: /* BEP with IP */
 		return intel_pt_get_bep_ip(len, packet);
+	case 0x13: /* CFE */
+		return intel_pt_get_cfe(buf, len, packet);
+	case 0x53: /* EVD */
+		return intel_pt_get_evd(buf, len, packet);
 	default:
 		return INTEL_PT_BAD_PACKET;
 	}
@@ -623,6 +653,9 @@ void intel_pt_upd_pkt_ctx(const struct intel_pt_pkt *packet,
 	case INTEL_PT_MWAIT:
 	case INTEL_PT_BEP:
 	case INTEL_PT_BEP_IP:
+	case INTEL_PT_CFE:
+	case INTEL_PT_CFE_IP:
+	case INTEL_PT_EVD:
 		*ctx = INTEL_PT_NO_CTX;
 		break;
 	case INTEL_PT_BBP:
@@ -750,6 +783,13 @@ int intel_pt_pkt_desc(const struct intel_pt_pkt *packet, char *buf,
 	case INTEL_PT_BIP:
 		return snprintf(buf, buf_len, "%s ID 0x%02x Value 0x%llx",
 				name, packet->count, payload);
+	case INTEL_PT_CFE:
+	case INTEL_PT_CFE_IP:
+		return snprintf(buf, buf_len, "%s IP:%d Type 0x%02x Vector 0x%llx",
+				name, packet->type == INTEL_PT_CFE_IP, packet->count, payload);
+	case INTEL_PT_EVD:
+		return snprintf(buf, buf_len, "%s Type 0x%02x Payload 0x%llx",
+				name, packet->count, payload);
 	default:
 		break;
 	}
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h
index 996090cb84f6..496ba4be875c 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h
@@ -56,6 +56,9 @@ enum intel_pt_pkt_type {
 	INTEL_PT_BIP,
 	INTEL_PT_BEP,
 	INTEL_PT_BEP_IP,
+	INTEL_PT_CFE,
+	INTEL_PT_CFE_IP,
+	INTEL_PT_EVD,
 };
 
 struct intel_pt_pkt {
-- 
2.25.1

