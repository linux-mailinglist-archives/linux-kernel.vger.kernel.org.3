Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5BB49BC2E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiAYTft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:35:49 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:42806 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiAYTei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1643139277; x=1674675277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lxztq/mtL0h23FYq/vaK8RPNJ15WKjUkIqfQpt8jYbs=;
  b=Ez+uLbD+C2yqw7Cd2MTW8PHfPxor1A/tQ0/3bVXCuUq/UpW8NFfnitGg
   DjtRPRQ8DlJzPh0jMuBPshNH5HL+xqE4b5kNws9jl0D/bLQQmja/n+GbH
   I0GanQlBDrEfVbzSlP+f3YosybY46JLNKforzORr/ji8z9CHvrobKNuh/
   M=;
X-IronPort-AV: E=Sophos;i="5.88,315,1635206400"; 
   d="scan'208";a="173065575"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-e6c05252.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 25 Jan 2022 19:34:33 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-e6c05252.us-west-2.amazon.com (Postfix) with ESMTPS id E215C41A77;
        Tue, 25 Jan 2022 19:34:27 +0000 (UTC)
Received: from EX13D02UWB001.ant.amazon.com (10.43.161.240) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Tue, 25 Jan 2022 19:34:24 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D02UWB001.ant.amazon.com (10.43.161.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Tue, 25 Jan 2022 19:34:24 +0000
Received: from dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com
 (10.200.138.153) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Tue, 25 Jan 2022 19:34:23
 +0000
Received: by dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 93D8D21E70; Tue, 25 Jan 2022 19:34:23 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <alisaidi@amazon.com>, <benh@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        "Will Deacon" <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Leo Yan" <leo.yan@linaro.org>, James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
Subject: [PATCH 1/2] perf arm-spe: Add arm_spe_record to synthesized sample
Date:   Tue, 25 Jan 2022 19:20:09 +0000
Message-ID: <20220125192016.20538-2-alisaidi@amazon.com>
X-Mailer: git-send-email 2.24.4.AMZN
In-Reply-To: <20220125192016.20538-1-alisaidi@amazon.com>
References: <20220125192016.20538-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Providing the arm_spe_record as raw data to the synthesized SPE samples
allows perf scripts to read and separately process the data in ways
existing perf tools don't support and mirrors functionality available
for PEBS.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/util/arm-spe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index d2b64e3f588b..a7499cde6fc0 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -336,6 +336,8 @@ static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
 	sample.phys_addr = record->phys_addr;
 	sample.data_src = data_src;
 	sample.weight = record->latency;
+	sample.raw_size = sizeof(*record);
+	sample.raw_data = record;
 
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
@@ -354,6 +356,8 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
 	sample.stream_id = spe_events_id;
 	sample.addr = record->to_ip;
 	sample.weight = record->latency;
+	sample.raw_size = sizeof(*record);
+	sample.raw_data = record;
 
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
@@ -383,6 +387,8 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	sample.data_src = data_src;
 	sample.period = spe->instructions_sample_period;
 	sample.weight = record->latency;
+	sample.raw_size = sizeof(*record);
+	sample.raw_data = record;
 
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
-- 
2.24.4.AMZN

