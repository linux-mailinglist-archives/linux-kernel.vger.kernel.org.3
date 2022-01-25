Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8687749BC2A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiAYTfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:35:08 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:42674 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiAYTeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1643139260; x=1674675260;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eai/aZmBQfgBxad8NOkpwEmtOizddqtvtIYAogy/SMk=;
  b=H7KOkFqIez8Knp9uGnu4KBtABIW8+hNNmdlln/J5Be1duQTxSOFe35vo
   cTMDmO+r7DxvRMt4PkkE2fDgErimJF6dUjLf9/oRnM9En+fkVHyPGNa2d
   9to1MHQ4svVP+lFSYxrjEoJD9ThDy2wFDTPWB/H2SBZsKwAUqMUiuTyUi
   8=;
X-IronPort-AV: E=Sophos;i="5.88,315,1635206400"; 
   d="scan'208";a="172099002"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-d9fba5dd.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 25 Jan 2022 19:34:15 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-d9fba5dd.us-west-2.amazon.com (Postfix) with ESMTPS id 78FE341A6B;
        Tue, 25 Jan 2022 19:34:14 +0000 (UTC)
Received: from EX13D02UWC002.ant.amazon.com (10.43.162.6) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Tue, 25 Jan 2022 19:34:14 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D02UWC002.ant.amazon.com (10.43.162.6) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Tue, 25 Jan 2022 19:34:13 +0000
Received: from dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com
 (10.200.138.153) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Tue, 25 Jan 2022 19:34:13
 +0000
Received: by dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 4807121E70; Tue, 25 Jan 2022 19:34:12 +0000 (UTC)
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
Subject: [PATCH 0/2] Allow perf scripts to process SPE raw data
Date:   Tue, 25 Jan 2022 19:20:08 +0000
Message-ID: <20220125192016.20538-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.24.4.AMZN
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two changes first expose the arm_spe_record as raw data to the 
synthesized perf sample and second decode more of the operation and event
types that aren't used for existing perf tools into the arm_spe_record. 

This allows perf scripts to process the decoded SPE records instead of
parsing the raw-trace back into some type of structure.

Ali Saidi (2):
  perf arm-spe: Add arm_spe_record to synthesized sample as raw_data
  perf arm-spe: Parse more SPE fields

 .../util/arm-spe-decoder/arm-spe-decoder.c    | 23 +++++++++++++++++++
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 ++++++++
 tools/perf/util/arm-spe.c                     |  6 +++++
 3 files changed, 38 insertions(+)

-- 
2.24.4.AMZN

