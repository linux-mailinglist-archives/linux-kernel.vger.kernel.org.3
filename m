Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E460756176A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbiF3KPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiF3KPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:15:13 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A04F44A2F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:15:12 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25U40775015363;
        Thu, 30 Jun 2022 05:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=0mmmeX8EpEPHD8XrcSw4Sp8UGBDafDLcok2SpdJ8el8=;
 b=TKuCNcQLOPT5xP8Or4anqrBJ4TvBnDDVu1A5rfkYgdOqs+3mtWsiaHWkmWkIeDjPgtCI
 jD5Lk3J5d1eDtxXqLnEzNwADohaWABZL4iabKF2eR3LPh6z9Dzh4t1AuuWE1bfnqn+5O
 bSuf8+U7OD6mkUfq8F9/gqh/2vOH64VFHhnyJ8dhAA7pzgtWsVjhiq1upudrBXb47vku
 4NNMQ/Qepn/+FYEz7ZXHEIAqbJrGzvFj0WlgIUcNLVET8N28u4yGtWfgO3NdppApPsUH
 yi4cqIry9ZthrHa3yiPUpad++9e0h2yDQQi5wmCs3eESLjqlGsY8u02zzEMPj6eDQmEO 6A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gwys2pv7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 Jun 2022 05:15:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 11:14:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 30 Jun 2022 11:14:59 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 24A6C2D4;
        Thu, 30 Jun 2022 10:14:59 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: wm_adsp: Minor clean and redundant code removal
Date:   Thu, 30 Jun 2022 11:14:59 +0100
Message-ID: <20220630101459.3442327-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QVdYrsh-ca0o5avYJJNBQYefF7y699T5
X-Proofpoint-GUID: QVdYrsh-ca0o5avYJJNBQYefF7y699T5
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cs_dsp core will return an error if passed a NULL cs_dsp struct so
there is no need for the wm_adsp_write|read_ctl functions to manually
check that. The cs_dsp core will also check the data is within bounds of
the control so the additional bounds check is redundant too. Simplify
things a bit by removing said code.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index a7784ac15dde6..cfaa45ede916a 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -675,21 +675,12 @@ static void wm_adsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl)
 int wm_adsp_write_ctl(struct wm_adsp *dsp, const char *name, int type,
 		      unsigned int alg, void *buf, size_t len)
 {
-	struct cs_dsp_coeff_ctl *cs_ctl;
+	struct cs_dsp_coeff_ctl *cs_ctl = cs_dsp_get_ctl(&dsp->cs_dsp, name, type, alg);
 	struct wm_coeff_ctl *ctl;
 	struct snd_kcontrol *kcontrol;
 	char ctl_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	int ret;
 
-	cs_ctl = cs_dsp_get_ctl(&dsp->cs_dsp, name, type, alg);
-	if (!cs_ctl)
-		return -EINVAL;
-
-	ctl = cs_ctl->priv;
-
-	if (len > cs_ctl->len)
-		return -EINVAL;
-
 	ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, buf, len);
 	if (ret)
 		return ret;
@@ -697,6 +688,8 @@ int wm_adsp_write_ctl(struct wm_adsp *dsp, const char *name, int type,
 	if (cs_ctl->flags & WMFW_CTL_FLAG_SYS)
 		return 0;
 
+	ctl = cs_ctl->priv;
+
 	if (dsp->component->name_prefix)
 		snprintf(ctl_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s %s",
 			 dsp->component->name_prefix, ctl->name);
@@ -720,16 +713,8 @@ EXPORT_SYMBOL_GPL(wm_adsp_write_ctl);
 int wm_adsp_read_ctl(struct wm_adsp *dsp, const char *name, int type,
 		     unsigned int alg, void *buf, size_t len)
 {
-	struct cs_dsp_coeff_ctl *cs_ctl;
-
-	cs_ctl = cs_dsp_get_ctl(&dsp->cs_dsp, name, type, alg);
-	if (!cs_ctl)
-		return -EINVAL;
-
-	if (len > cs_ctl->len)
-		return -EINVAL;
-
-	return cs_dsp_coeff_read_ctrl(cs_ctl, 0, buf, len);
+	return cs_dsp_coeff_read_ctrl(cs_dsp_get_ctl(&dsp->cs_dsp, name, type, alg),
+				      0, buf, len);
 }
 EXPORT_SYMBOL_GPL(wm_adsp_read_ctl);
 
-- 
2.30.2

