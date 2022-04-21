Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8742F509C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387479AbiDUJUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387582AbiDUJUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:20:35 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08AB25C47;
        Thu, 21 Apr 2022 02:17:40 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 21 Apr
 2022 17:17:40 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 21 Apr
 2022 17:17:38 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] HID: amd_sfh: Drop redundant memset
Date:   Thu, 21 Apr 2022 17:17:36 +0800
Message-ID: <1650532656-27602-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The region set by the call to memset is immediately overwritten by the
subsequent call to memcpy. So we drop redundant memset.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
index 76095bd53c65..26ccdcfbcda5 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
@@ -33,27 +33,22 @@ int get_report_descriptor(int sensor_idx, u8 *rep_desc)
 {
 	switch (sensor_idx) {
 	case accel_idx: /* accel */
-		memset(rep_desc, 0, sizeof(accel3_report_descriptor));
 		memcpy(rep_desc, accel3_report_descriptor,
 		       sizeof(accel3_report_descriptor));
 		break;
 	case gyro_idx: /* gyro */
-		memset(rep_desc, 0, sizeof(gyro3_report_descriptor));
 		memcpy(rep_desc, gyro3_report_descriptor,
 		       sizeof(gyro3_report_descriptor));
 		break;
 	case mag_idx: /* Magnetometer */
-		memset(rep_desc, 0, sizeof(comp3_report_descriptor));
 		memcpy(rep_desc, comp3_report_descriptor,
 		       sizeof(comp3_report_descriptor));
 		break;
 	case als_idx: /* ambient light sensor */
-		memset(rep_desc, 0, sizeof(als_report_descriptor));
 		memcpy(rep_desc, als_report_descriptor,
 		       sizeof(als_report_descriptor));
 		break;
 	case HPD_IDX: /* HPD sensor */
-		memset(rep_desc, 0, sizeof(hpd_report_descriptor));
 		memcpy(rep_desc, hpd_report_descriptor,
 		       sizeof(hpd_report_descriptor));
 		break;
-- 
2.7.4

