Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98EA4A8359
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350339AbiBCLyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:54:01 -0500
Received: from foss.arm.com ([217.140.110.172]:41706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348023AbiBCLx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:53:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA8EB1396;
        Thu,  3 Feb 2022 03:53:57 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.13.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4978C3F774;
        Thu,  3 Feb 2022 03:53:56 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] coresight: no-op refactor to make INSTP0 check more idiomatic
Date:   Thu,  3 Feb 2022 11:53:35 +0000
Message-Id: <20220203115336.119735-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220203115336.119735-1-james.clark@arm.com>
References: <20220203115336.119735-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spec says this:

  P0 tracing support field. The permitted values are:
      0b00  Tracing of load and store instructions as P0 elements is not
            supported.
      0b11  Tracing of load and store instructions as P0 elements is
            supported, so TRCCONFIGR.INSTP0 is supported.

            All other values are reserved.

The value we are looking for is 0b11 so simplify this. The double read
and && was a bit obfuscated.

Suggested-by: Suzuki Poulose <suzuki.poulose@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index bf18128cf5de..e2eebd865241 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1091,7 +1091,7 @@ static void etm4_init_arch_data(void *info)
 	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
 
 	/* INSTP0, bits[2:1] P0 tracing support field */
-	if (BMVAL(etmidr0, 1, 1) && BMVAL(etmidr0, 2, 2))
+	if (BMVAL(etmidr0, 1, 2) == 0b11)
 		drvdata->instrp0 = true;
 	else
 		drvdata->instrp0 = false;
-- 
2.28.0

