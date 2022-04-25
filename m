Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505B750E0CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbiDYMyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241869AbiDYMxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:53:48 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17512C657
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:50:22 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PAhaRX024908;
        Mon, 25 Apr 2022 07:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=n893oul7mPkRsKG48wR65EWeJYs8y/PNZSl5VT/2nfw=;
 b=lND4Ywi2UvaS6VsO//58Nsxft8a3HUe2HPcGW3g39yK58ebM3LVrv4w//MZGANUSMBDh
 Ne7CYdANPMYmaW1AnAIE9t/HgRZmNL4jTHM4pRySmj6bXPmLRQs65ZKc33TDe57TQkAC
 YWir2us0lY3WeJ+Jl1EZUZT1YoaJIaPiaahXcx9M54kQuKU58kD+GpjdLngFn2QapnHp
 AEdUqY+JFL97LulvtYxz20ZC/PD8+wsiAGpT36f3tu0r8GyM5OWQO4rjH4g4xuOIchIn
 X/nE5E4OzyWqzq9ZFChd4DQbblWw+Sf375wCNcrMMLUhESwuITfwcnWA5muFRJLtd/9A 6Q== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fmev31x5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Apr 2022 07:50:16 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 13:50:14 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 25 Apr 2022 13:50:14 +0100
Received: from debianA11184.ad.cirrus.com (debianA11184.ad.cirrus.com [198.90.251.83])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 70B71B16;
        Mon, 25 Apr 2022 12:50:14 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 1/2] ASoC: soc.h: Introduce SOC_DOUBLE_R_S_EXT_TLV() macro
Date:   Mon, 25 Apr 2022 13:50:11 +0100
Message-ID: <20220425125012.3044919-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425125012.3044919-1-rf@opensource.cirrus.com>
References: <20220425125012.3044919-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sw4z_-IdXYgptxZVgrh-ogjDESMQR3KR
X-Proofpoint-GUID: sw4z_-IdXYgptxZVgrh-ogjDESMQR3KR
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

A straightforward extension of the SOC_DOUBLE_R_S_TLV() macro that
allows the get and put functions to be customised.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/soc.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2d3261799d2c..8368b69dfef8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -282,6 +282,17 @@
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
 					    xmax, xinvert) }
+#define SOC_DOUBLE_R_S_EXT_TLV(xname, reg_left, reg_right, xshift, xmin, xmax, \
+			       xsign_bit, xinvert, xhandler_get, xhandler_put, \
+			       tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+		  SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = SOC_DOUBLE_R_S_VALUE(reg_left, reg_right, xshift, \
+					      xmin, xmax, xsign_bit, xinvert) }
 #define SOC_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_bool_ext, \
-- 
2.30.2

