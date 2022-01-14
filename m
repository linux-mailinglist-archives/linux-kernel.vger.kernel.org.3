Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF08748EF41
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbiANRdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:33:07 -0500
Received: from foss.arm.com ([217.140.110.172]:36214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241472AbiANRdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:33:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB4B6101E;
        Fri, 14 Jan 2022 09:33:03 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.38.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6010F3F766;
        Fri, 14 Jan 2022 09:33:02 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] coresight: Fix TRCCONFIGR.QE sysfs interface
Date:   Fri, 14 Jan 2022 17:32:54 +0000
Message-Id: <20220114173254.1876151-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220114173254.1876151-1-james.clark@arm.com>
References: <20220114173254.1876151-1-james.clark@arm.com>
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

This change doesn't go any further to validate if the user supplied value
is valid, because none of the other parts this function do, but it does fix
the case where it was impossible to ever set a valid value.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index a0640fa5c55b..a99bb537ea23 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -368,7 +368,7 @@ static ssize_t mode_store(struct device *dev,
 	/* start by clearing QE bits */
 	config->cfg &= ~(BIT(13) | BIT(14));
 	/* if supported, Q elements with instruction counts are enabled */
-	if ((mode & BIT(0)) && (drvdata->q_support & BIT(0)))
+	if ((mode & BIT(0)) && drvdata->q_support)
 		config->cfg |= BIT(13);
 	/*
 	 * if supported, Q elements with and without instruction
-- 
2.17.1

