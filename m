Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C17546D7C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhLHQMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:12:55 -0500
Received: from foss.arm.com ([217.140.110.172]:35476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229743AbhLHQMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:12:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7A1D11FB;
        Wed,  8 Dec 2021 08:09:20 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.34.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7ADA83F5A1;
        Wed,  8 Dec 2021 08:09:18 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] coresight: Fail to open with return stacks if they are unavailable
Date:   Wed,  8 Dec 2021 16:09:06 +0000
Message-Id: <20211208160907.749482-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211208160907.749482-1-james.clark@arm.com>
References: <20211208160907.749482-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintain consistency with the other options by failing to open when they
aren't supported. For example ETM_OPT_TS, ETM_OPT_CTXTID2 and the newly
added ETM_OPT_BRANCH_BROADCAST all return with -EINVAL if they are
requested but not supported by hardware.

The consequence of not doing this is that the user may not be
aware that they are not enabling the feature as it is silently disabled.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index d2bafb50c66a..0a9bb943a5e5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -674,10 +674,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 	}
 
 	/* return stack - enable if selected and supported */
-	if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
-		/* bit[12], Return stack enable bit */
-		config->cfg |= BIT(12);
-
+	if (attr->config & BIT(ETM_OPT_RETSTK)) {
+		if (!drvdata->retstack) {
+			ret = -EINVAL;
+			goto out;
+		} else {
+			/* bit[12], Return stack enable bit */
+			config->cfg |= BIT(12);
+		}
+	}
 	/*
 	 * Set any selected configuration and preset.
 	 *
-- 
2.28.0

