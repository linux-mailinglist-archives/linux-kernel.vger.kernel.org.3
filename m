Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A744DDEFD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbiCRQb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbiCRQbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:31:15 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525B1197FAB;
        Fri, 18 Mar 2022 09:29:53 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I7cSw1022149;
        Fri, 18 Mar 2022 11:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=4tc4ncIANn0s6SD489iah443tBWGZROgIIkzG9Cdyrw=;
 b=U5HqeiPXiw9YftLaOP0XUUlTtsIVeCxqnsN2ACwSbItAwBA760un4JoAQbSgMwy7zthy
 ie6hwMGLzzkMS/Q4G2cdMnMOpFDVnI/J0T2QYwPAE5FMEkZ3rcGTRGk8sQ3GKtII5HwB
 m4Hk5GNRJH6cD1W3PP2NfRGzbfh3KQifO8ro6Pyz2BJmTJ6UZLtbSaVMFhfJbSY4kZmI
 ydBu0ft21tp49kxYc0q1zuhz2OGw38yKi//v2tnSdCOc11+zYtbfs56vo74KSgHhUW5C
 H1/OKAIA1yGwvXu7WMYvHUvg4wy9/quZyEQ2KXn226e3Vpx9mcyp93c7I1iLUq+yhGx3 VA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3et642efpx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 11:29:47 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Mar
 2022 16:29:44 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 18 Mar 2022 16:29:44 +0000
Received: from debianA11184.ad.cirrus.com (debianA11184.ad.cirrus.com [198.90.251.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5483DB16;
        Fri, 18 Mar 2022 16:29:44 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 1/5] ASoC: soc.h: Add SOC_SINGLE_S_TLV() macro
Date:   Fri, 18 Mar 2022 16:29:39 +0000
Message-ID: <20220318162943.1578102-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220318162943.1578102-1-rf@opensource.cirrus.com>
References: <20220318162943.1578102-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: esRbDl9EM1KkxmG1I-SXkSOw3ElnV3WL
X-Proofpoint-ORIG-GUID: esRbDl9EM1KkxmG1I-SXkSOw3ElnV3WL
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 7a1650b303f1..e063b1ea9634 100644
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

