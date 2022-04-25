Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A4650E0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbiDYMy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241963AbiDYMxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:53:49 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0ED2E9C4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:50:27 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PAhaRZ024908;
        Mon, 25 Apr 2022 07:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=B+fAVScuRJvjR0vYP6PQpK/WVXd6VhFizgRnHYQuDNE=;
 b=NeYbHQ//zvzvlOYJ/he54DhlLgfbrnjPFcTqZXn4juoYeVGNsFWn0z5Uc0UCcMuOr5tq
 qdgUH3rGH67WyTgrCREoZ10YNjHixmoU9xwfe8UoriCo/Z/B9Rdr90uEso5nBMi9svwc
 dR59SrIVZJWEpF3FtqwL85qDi5x4/avQPBp72PtjMVF8sBnoG4cqBmOKBllqdzVBxJko
 qry62Hk1VS7Yvx/aa7juOMhlM54LztGhZ/vCPWGGeoP0bam55W2ItRi6pmqeXT23VD3y
 PVWnP7A12JwufhJirbVhBBoDaWExTJTyN23QKT1UZxbTeVZRgiB2jXl6HiGOrWnR/PMW Hg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fmev31x5p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Apr 2022 07:50:17 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 13:50:14 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 25 Apr 2022 13:50:14 +0100
Received: from debianA11184.ad.cirrus.com (debianA11184.ad.cirrus.com [198.90.251.83])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 83963B1A;
        Mon, 25 Apr 2022 12:50:14 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 2/2] ASoC: soc.h: Add SOC_SINGLE_S_EXT_TLV macro
Date:   Mon, 25 Apr 2022 13:50:12 +0100
Message-ID: <20220425125012.3044919-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425125012.3044919-1-rf@opensource.cirrus.com>
References: <20220425125012.3044919-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0Om3h4JeItrgkyajjMheeyJqad035wKk
X-Proofpoint-GUID: 0Om3h4JeItrgkyajjMheeyJqad035wKk
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a SOC_SINGLE_S_EXT_TLV macro as a convenience wrapper
around SOC_DOUBLE_R_S_EXT_TLV for mono volume controls.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/soc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8368b69dfef8..f906e5a70830 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -293,6 +293,12 @@
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = SOC_DOUBLE_R_S_VALUE(reg_left, reg_right, xshift, \
 					      xmin, xmax, xsign_bit, xinvert) }
+#define SOC_SINGLE_S_EXT_TLV(xname, xreg, xshift, xmin, xmax, \
+			     xsign_bit, xinvert, xhandler_get, xhandler_put, \
+			     tlv_array) \
+	SOC_DOUBLE_R_S_EXT_TLV(xname, xreg, xreg, xshift, xmin, xmax, \
+			       xsign_bit, xinvert, xhandler_get, xhandler_put, \
+			       tlv_array)
 #define SOC_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_bool_ext, \
-- 
2.30.2

