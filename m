Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4443494D02
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiATLbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:31:03 -0500
Received: from foss.arm.com ([217.140.110.172]:34304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231479AbiATLbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:31:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CE47101E;
        Thu, 20 Jan 2022 03:31:02 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.37.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9CCD63F774;
        Thu, 20 Jan 2022 03:31:00 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        mike.leach@linaro.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] coresight: Fix TRCCONFIGR.QE sysfs interface
Date:   Thu, 20 Jan 2022 11:30:47 +0000
Message-Id: <20220120113047.2839622-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220120113047.2839622-1-james.clark@arm.com>
References: <20220120113047.2839622-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's impossible to program a valid value for TRCCONFIGR.QE
when TRCIDR0.QSUPP==0b10. In that case the following is true:

  Q element support is implemented, and only supports Q elements without
  instruction counts. TRCCONFIGR.QE can only take the values 0b00 or 0b11.

Currently the low bit of QSUPP is checked to see if the low bit of QE can
be written to, but as you can see when QSUPP==0b10 the low bit is cleared
making it impossible to ever write the only valid value of 0b11 to QE.
0b10 would be written instead, which is a reserved QE value even for all
values of QSUPP.

The fix is to allow writing the low bit of QE for any non zero value of
QSUPP.

This change also ensures that the low bit is always set, even when the
user attempts to only set the high bit.

Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index a0640fa5c55b..57e94424a8d6 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -367,8 +367,12 @@ static ssize_t mode_store(struct device *dev,
 	mode = ETM_MODE_QELEM(config->mode);
 	/* start by clearing QE bits */
 	config->cfg &= ~(BIT(13) | BIT(14));
-	/* if supported, Q elements with instruction counts are enabled */
-	if ((mode & BIT(0)) && (drvdata->q_support & BIT(0)))
+	/*
+	 * if supported, Q elements with instruction counts are enabled.
+	 * Always set the low bit for any requested mode. Valid combos are
+	 * 0b00, 0b01 and 0b11.
+	 */
+	if (mode && drvdata->q_support)
 		config->cfg |= BIT(13);
 	/*
 	 * if supported, Q elements with and without instruction
-- 
2.28.0

