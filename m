Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE71950DD52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbiDYJ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiDYJ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:56:02 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3EE3F886
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:52:23 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P9PN9p019843;
        Mon, 25 Apr 2022 04:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=NFYRxNRFMgph5kuhS/kFHxiZIc8JuWC3fIicqgsvoqw=;
 b=jthua2KuL1MAJPBg7Hz+E4nZHxUeSqasfyxx5l/qlTU56YNZucP6HkwZ3quIvrYBk1Nq
 K3oBw5KD9CrFOrAhpgm8qIrsvO/PXfJ8oehG5yHL3rwMlnYYPHsihMdc8PMn8jayvzyC
 wXrVtSJfJNm3Gf+Dl9E0LRWj1eA//X0OjoRL6C65LHyMRKZkeHsYhqUqfCADC4PMKnOG
 LIF2z3YRMKaEdLeQUG6Iq/jLw6LhvjrOxbJgdtlGIWFrJk1UdATyerkMW7lmKW1aUhIV
 qrjiXoCjgk3/3rpL0mekJGGxLlqILH7H7l8fzXaAhHprpQGTHukpoEEdepJFtdJ1fBxk MA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fmev31rbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Apr 2022 04:52:11 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 10:52:09 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 25 Apr 2022 10:52:09 +0100
Received: from debianA11184.ad.cirrus.com (debianA11184.ad.cirrus.com [198.90.251.83])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 54717B16;
        Mon, 25 Apr 2022 09:52:03 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] firmware: cirrus: cs_dsp: Avoid padding bytes in cs_dsp_coeff_ctl
Date:   Mon, 25 Apr 2022 10:51:59 +0100
Message-ID: <20220425095159.3044527-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OJnBY_xRTKz-Fg6o5MuUGyNJgsWreoGb
X-Proofpoint-GUID: OJnBY_xRTKz-Fg6o5MuUGyNJgsWreoGb
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the order of members in struct cs_dsp_coeff_ctl to avoid
the compiler having to insert alignment padding bytes. On a x86_64
build this saves 16 bytes per control.

- Pointers are collected to the top of the struct (with the exception of
  priv, as noted below), so that they are inherently aligned.
- The set and enable bitflags are placed together so they can be merged.
- priv is placed at the end of the struct - it is for use by the
  client so it is helpful to make it stand out, and since the compiler
  will always pad the struct size to an alignment multiple putting a
  pointer last won't introduce any more padding.
- struct cs_dsp_alg_region is placed at the end, right before priv, for
  the same reasoning as priv.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/linux/firmware/cirrus/cs_dsp.h | 28 +++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/firmware/cirrus/cs_dsp.h b/include/linux/firmware/cirrus/cs_dsp.h
index 38b4da3ddfe4..30055706cce2 100644
--- a/include/linux/firmware/cirrus/cs_dsp.h
+++ b/include/linux/firmware/cirrus/cs_dsp.h
@@ -68,36 +68,36 @@ struct cs_dsp_alg_region {
 
 /**
  * struct cs_dsp_coeff_ctl - Describes a coefficient control
+ * @list:		List node for internal use
+ * @dsp:		DSP instance associated with this control
+ * @cache:		Cached value of the control
  * @fw_name:		Name of the firmware
  * @subname:		Name of the control parsed from the WMFW
  * @subname_len:	Length of subname
- * @alg_region:		Logical region associated with this control
- * @dsp:		DSP instance associated with this control
- * @enabled:		Flag indicating whether control is enabled
- * @list:		List node for internal use
- * @cache:		Cached value of the control
  * @offset:		Offset of control within alg_region in words
  * @len:		Length of the cached value in bytes
- * @set:		Flag indicating the value has been written by the user
- * @flags:		Bitfield of WMFW_CTL_FLAG_ control flags defined in wmfw.h
  * @type:		One of the WMFW_CTL_TYPE_ control types defined in wmfw.h
+ * @flags:		Bitfield of WMFW_CTL_FLAG_ control flags defined in wmfw.h
+ * @set:		Flag indicating the value has been written by the user
+ * @enabled:		Flag indicating whether control is enabled
+ * @alg_region:		Logical region associated with this control
  * @priv:		For use by the client
  */
 struct cs_dsp_coeff_ctl {
+	struct list_head list;
+	struct cs_dsp *dsp;
+	void *cache;
 	const char *fw_name;
 	/* Subname is needed to match with firmware */
 	const char *subname;
 	unsigned int subname_len;
-	struct cs_dsp_alg_region alg_region;
-	struct cs_dsp *dsp;
-	unsigned int enabled:1;
-	struct list_head list;
-	void *cache;
 	unsigned int offset;
 	size_t len;
-	unsigned int set:1;
-	unsigned int flags;
 	unsigned int type;
+	unsigned int flags;
+	unsigned int set:1;
+	unsigned int enabled:1;
+	struct cs_dsp_alg_region alg_region;
 
 	void *priv;
 };
-- 
2.30.2

