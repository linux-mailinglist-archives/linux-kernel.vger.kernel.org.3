Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897314F46FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383907AbiDEUzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443104AbiDEPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:38:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1A81456F4;
        Tue,  5 Apr 2022 06:54:40 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 235BpSUC025148;
        Tue, 5 Apr 2022 08:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=sKPCxZ+xTBcQoblGnSzkvv6udMhhqbVepx2ZD2fI5i0=;
 b=ATDDzgl9AUjcR8Pw6A0mgx4kf0fSH/e85cwNTm/yhKInblbRe6Sp0a3tqHDado5wJO1+
 uLpck0Wyx6piRQG9PHKHj34HO6+mGu1vHveI94nwEOr6q9y+8vhRu84aOaDHt5Uj4taO
 vmIhpKdntkF8BiPWrAaVfErMrp9mzAWR7RlySY/mSLG0GUVzaFbx8DYCIs6sR063FTeK
 5xDC2tiyTZnh0eoTi4layLJtiRMlbOog07SVfAHCo6pnA8mS0uNK4hPJWi4VEfzf/dPm
 D5kMPEE+t5XzzFX1jc/kz+St7r+jwHPaOs/vq0Ub9VfmmHI838qTK3AFNCSzvTutIo/3 xQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f6kw2brwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Apr 2022 08:54:25 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Apr
 2022 14:54:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 5 Apr 2022 14:54:23 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.88])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 378B8B1A;
        Tue,  5 Apr 2022 13:54:23 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 1/5] ASoC: soc.h: Add SOC_SINGLE_S_TLV() macro
Date:   Tue, 5 Apr 2022 14:54:15 +0100
Message-ID: <20220405135419.1230088-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405135419.1230088-1-rf@opensource.cirrus.com>
References: <20220405135419.1230088-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yuf6CHlyAXEpejNsxbiA-4FDRbynNDev
X-Proofpoint-GUID: yuf6CHlyAXEpejNsxbiA-4FDRbynNDev
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a convenience macro for defining a single (mono) TLV control
with a signed value. This can already be done by using
SOC_DOUBLE_R_S_TLV() with the same address for left and right
registers, but a dedicated macro is more readable.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/soc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d3d3a26e8867..55fb6a6d7d25 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -176,6 +176,8 @@
 	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw, \
 	.private_value = SOC_DOUBLE_R_S_VALUE(reg_left, reg_right, xshift, \
 					    xmin, xmax, xsign_bit, xinvert) }
+#define SOC_SINGLE_S_TLV(xname, xreg, xshift, xmin, xmax, xsign_bit, xinvert, tlv_array) \
+	SOC_DOUBLE_R_S_TLV(xname, xreg, xreg, xshift, xmin, xmax, xsign_bit, xinvert, tlv_array)
 #define SOC_SINGLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
 {	.iface  = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
-- 
2.30.2

