Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D716151A2FB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351794AbiEDPGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351777AbiEDPGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:06:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF9E63702F;
        Wed,  4 May 2022 08:02:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 492B11042;
        Wed,  4 May 2022 08:02:29 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.32.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A4E13F885;
        Wed,  4 May 2022 08:02:27 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] perf cs_etm: Basic support for virtual/kernel timestamps
Date:   Wed,  4 May 2022 16:02:11 +0100
Message-Id: <20220504150216.581281-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This change has a soft dependency on [1], but assuming the name/location
of the new sysfs interface (ts_source) doesn't change, it should be safe
to apply.

The new 'ts_source' interface allows perf to detect if the timestamps in
the trace correspond to the value of CNTVCT_EL0, which we can convert to
a perf timestamp and store it in the instruction and branch samples.

Due to the way the trace is compressed and decoded by OpenCSD, we only
know the precise time of the first instruction in a range, but I think
for now this is better than not having timestamps at all...

Thanks,
German

[1] https://lore.kernel.org/all/20220503123537.1003035-1-german.gomez@arm.com/

German Gomez (4):
  perf pmu: Add function to check if a pmu file exists
  perf cs_etm: Keep separate symbols for ETMv4 and ETE parameters
  perf cs_etm: Record ts_source in AUXTRACE_INFO for ETMv4 and ETE
  perf cs_etm: Set the time field in the synthetic samples

 tools/perf/arch/arm/util/cs-etm.c |  89 +++++++++++++++++++--
 tools/perf/util/cs-etm.c          | 126 +++++++++++++++++++++++++-----
 tools/perf/util/cs-etm.h          |  13 ++-
 tools/perf/util/pmu.c             |  17 ++++
 tools/perf/util/pmu.h             |   2 +
 5 files changed, 221 insertions(+), 26 deletions(-)

-- 
2.25.1

