Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AED759112E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbiHLNHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiHLNHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:07:05 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23D685A86;
        Fri, 12 Aug 2022 06:07:02 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CAU5rU016140;
        Fri, 12 Aug 2022 08:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=I9klxWCl20GzOsgSo6Cjo6h4lDJXRQZ68eRcuQxCfKE=;
 b=o3UT8W665PB+2d68TT8kwsfsJOUJ1xJo/3ApAz3kHXTM+Yx7ZmlVGpBBzbPQPwm8bG03
 4z4bYsb4IGPCkXr9j1hvX+36qzq1EzCtYSheUpqD/QYOp++kIdUyMtQnrMGMPszVfBqT
 2hjoReYezghjthaMrj+VtH9mxIgoaPJ4SDxbsYQxfE6smzTFTiMlkv8E5XpXlzulYH8D
 OaXnG08/dw2O0oG7H1NigtB7s8dX5sZd15HnJljlNcFOWwnb2L6/TqQQcA42bFePO4KH
 gXiFGKKo06DON5bl0NIKp3S6Rd0swy6oKjEVNEZSnTIPKqE04Vbwx8AqwsAi7urKP/cq 7Q== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3huwr3m0ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 08:06:52 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 12 Aug
 2022 08:06:50 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Fri, 12 Aug 2022 08:06:50 -0500
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 88D8245D;
        Fri, 12 Aug 2022 13:06:49 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1] ACPI: Property: Fix type detection of unified integer reading functions
Date:   Fri, 12 Aug 2022 14:06:45 +0100
Message-ID: <20220812130645.14710-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: dwkhdVRx1rycG4nIQXZuNbNXOgWGMA_J
X-Proofpoint-ORIG-GUID: dwkhdVRx1rycG4nIQXZuNbNXOgWGMA_J
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code expects the type of the value to be an integer type,
instead the value passed to the macro is a pointer.
Ensure the size comparison uses the correct pointer type to choose the
max value, instead of using the integer type.

Fixes: 923044133367 ("ACPI: property: Unify integer value reading functions")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 drivers/acpi/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 7b3ad8ed2f4e..b1d4a8db89df 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1043,10 +1043,10 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 				break;					\
 			}						\
 			if (__items[i].integer.value > _Generic(__val,	\
-								u8: U8_MAX, \
-								u16: U16_MAX, \
-								u32: U32_MAX, \
-								u64: U64_MAX, \
+								u8 *: U8_MAX, \
+								u16 *: U16_MAX, \
+								u32 *: U32_MAX, \
+								u64 *: U64_MAX, \
 								default: 0U)) { \
 				ret = -EOVERFLOW;			\
 				break;					\
-- 
2.34.1

