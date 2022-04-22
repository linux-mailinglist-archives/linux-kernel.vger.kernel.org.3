Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6E650BC77
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353460AbiDVQEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiDVQEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:04:40 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE5956777
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:01:46 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23MEKBXI008279;
        Fri, 22 Apr 2022 11:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=tTEzWeUHH5E9k6oqu7beTYZ7ixC/Pc1XFXFw6Ded1To=;
 b=GtzBrttXW7okXRCSEiZ0IDYLPgEZ/zxxxvDX6pPaj4zebTLzh6qk4O0+fk4IqqKwTfOU
 Pk38sIVAwcodEYLbpTUlMxcg84zx7ZZ1k92KzR4OdYg4o69/0uZ3e9wG5vjck2D/Csel
 wEhULBYeAt3YvIZTv2Krl+w/nUn1Uwat9n3cZ1vKnn+mLUVPMphLeiG0ZlCKukNMEmEq
 r+dAdO2VjG8dgVPNy6BzV08YuVopIFdNTds4qQ7nIdFg+IEJcfipG30/eSktc/r4kdyb
 X6YwL36xAhyY2VtRuc8zQi7tov1sPMhZvZRI7OA+g9xuFJTfuTut2bzuiDjic/eBnOIl oA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ffu70qb7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 Apr 2022 11:01:33 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 17:01:19 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 17:01:19 +0100
Received: from debianA11184.ad.cirrus.com (debianA11184.ad.cirrus.com [198.90.251.83])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B71BF458;
        Fri, 22 Apr 2022 16:01:19 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: soc.h: Introduce SOC_DOUBLE_R_S_EXT_TLV() macro
Date:   Fri, 22 Apr 2022 17:01:11 +0100
Message-ID: <20220422160112.3026542-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220422160112.3026542-1-rf@opensource.cirrus.com>
References: <20220422160112.3026542-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Tv-pIJwTLQh6uXyEIeHRGmPLevCxn0if
X-Proofpoint-GUID: Tv-pIJwTLQh6uXyEIeHRGmPLevCxn0if
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

