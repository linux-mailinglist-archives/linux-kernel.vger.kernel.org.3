Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB43555782D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiFWKvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiFWKvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:51:40 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301EE4B428
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:51:39 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NAKUqF006859;
        Thu, 23 Jun 2022 05:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=spwI6sAhpzo+8xV2qTuPti6l56+juOG2iCl+GRXgx6Y=;
 b=YWTCg5gwM6HNsL65S8x+ByDROJzBjEfDXslKcVsKpC68nrFMzeAHWHMwaXfQKtH+awqK
 Uv3IRazjoT8cu0EcFOdMh6h9IEvtK+o9pLpggDOHIbAYdzyZvnBusfPcrBH6Vc5MXrTC
 Bc1ANrSAIMvpbcvRpSXGq9zNHg4ITTNlW5wl3tS38LU/Pj1BC6dFfF7OECLEykd/lpnA
 /uME74/99UrDGT2/NGn/2FM4e4htX154qZMbSIq56mb3UAuylf0/SmROFdvd0bnpkWoJ
 DogLwUE5fb9/Ia4CxHm+tPtHQnWSk3uSuGq56O3rakggs30Z7WfpejcQu4JudaG/MOL5 jw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gsc41f17q-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jun 2022 05:51:23 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 23 Jun
 2022 11:51:20 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 23 Jun 2022 11:51:20 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 60B1A475;
        Thu, 23 Jun 2022 10:51:20 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] ASoC: dapm: Move stereo autodisable check
Date:   Thu, 23 Jun 2022 11:51:20 +0100
Message-ID: <20220623105120.1981154-6-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220623105120.1981154-1-ckeepax@opensource.cirrus.com>
References: <20220623105120.1981154-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JgCLQNmst0Kq0Pq3_XSo28iJj41Qufod
X-Proofpoint-ORIG-GUID: JgCLQNmst0Kq0Pq3_XSo28iJj41Qufod
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tidy up the code a little, rather than repeating the check of
mc->autodisable move the stereo error check to be under the
existing if for mc->autodisable.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-dapm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a8e842e02cdc2..b05231414c1d0 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -370,14 +370,14 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 	case snd_soc_dapm_mixer_named_ctl:
 		mc = (struct soc_mixer_control *)kcontrol->private_value;
 
-		if (mc->autodisable && snd_soc_volsw_is_stereo(mc))
-			dev_warn(widget->dapm->dev,
-				 "ASoC: Unsupported stereo autodisable control '%s'\n",
-				 ctrl_name);
-
 		if (mc->autodisable) {
 			struct snd_soc_dapm_widget template;
 
+			if (snd_soc_volsw_is_stereo(mc))
+				dev_warn(widget->dapm->dev,
+					 "ASoC: Unsupported stereo autodisable control '%s'\n",
+					 ctrl_name);
+
 			name = kasprintf(GFP_KERNEL, "%s %s", ctrl_name,
 					 "Autodisable");
 			if (!name) {
-- 
2.30.2

