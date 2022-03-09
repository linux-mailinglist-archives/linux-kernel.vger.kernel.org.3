Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5564D2F9B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiCINBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiCINBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:01:34 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F86177D39
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:00:35 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2297bass017891;
        Wed, 9 Mar 2022 07:00:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=aieqZlDUNTBFo8m3hIx2HjZ32UrM5bNMZPIFGBrUeWw=;
 b=nvx7KJ0n2iVtCnh9RjxpD6JADY3tMPy0JTTUaVHfS8rMiiUUotGbqfqGT+TAXtGb0v5q
 K7lVfD+RFfVfClR4Zr/c0a8z9lRQERKX5FaqEvAL/Jq+Gjgcr3S+S1s4ggvJFyViZD2i
 /1Nnyb9eBJXSvQ1SGdatqs49vDq0ZVnU57frr+v5mUSTJRDEJQksja4eJlrv8cSq0SFh
 1UZc4XaxpSERGRAorFrOBEOdArZt9QlMlzAwjJpRXHb3JboNBDBYo4jlRwF+rlP7s8er
 ZB+8LmSNIbcXYmabXmkdxjAU5TPNMfy6AVQVsvxkTB22AZkPqD45oCoX1pIDcojrNPoI 7Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3em656nmv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Mar 2022 07:00:24 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Mar
 2022 13:00:22 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 9 Mar 2022 13:00:22 +0000
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.206])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 839AC46C;
        Wed,  9 Mar 2022 13:00:22 +0000 (UTC)
From:   Simon Trimmer <simont@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: Compressed stream DSP memory structs should be __packed
Date:   Wed, 9 Mar 2022 13:00:17 +0000
Message-ID: <20220309130017.2816-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vGR8aaCZxS66amqOsI1Jt15Dpny43634
X-Proofpoint-GUID: vGR8aaCZxS66amqOsI1Jt15Dpny43634
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compressed stream code has a bunch of structs that are used to
represent DSP memory but have not been marked __packed. This isn't
safe, they could get padded on a 64-bit build.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 0582585236a2..5a57bb04a0ae 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -97,13 +97,13 @@ struct wm_adsp_system_config_xm_hdr {
 	__be32 wdma[8];
 	__be32 build_job_name[3];
 	__be32 build_job_number;
-};
+} __packed;
 
 struct wm_halo_system_config_xm_hdr {
 	__be32 halo_heartbeat;
 	__be32 build_job_name[3];
 	__be32 build_job_number;
-};
+} __packed;
 
 struct wm_adsp_alg_xm_struct {
 	__be32 magic;
@@ -114,13 +114,13 @@ struct wm_adsp_alg_xm_struct {
 	__be32 high_water_mark;
 	__be32 low_water_mark;
 	__be64 smoothed_power;
-};
+} __packed;
 
 struct wm_adsp_host_buf_coeff_v1 {
 	__be32 host_buf_ptr;		/* Host buffer pointer */
 	__be32 versions;		/* Version numbers */
 	__be32 name[4];			/* The buffer name */
-};
+} __packed;
 
 struct wm_adsp_buffer {
 	__be32 buf1_base;		/* Base addr of first buffer area */
@@ -141,7 +141,7 @@ struct wm_adsp_buffer {
 	__be32 min_free;		/* min free space since stream start */
 	__be32 blocks_written[2];	/* total blocks written (64 bit) */
 	__be32 words_written[2];	/* total words written (64 bit) */
-};
+} __packed;
 
 struct wm_adsp_compr;
 
-- 
2.34.1

