Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0274DDD5C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbiCRP5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbiCRP5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:57:31 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7424E9F6C3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:56:11 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I4MHla013781;
        Fri, 18 Mar 2022 10:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=RLNYZa9UQSYGFio1Lh72vGHwbi2NTG9rHAVm+2NLYF4=;
 b=hLVcZWvRgKUGsPBQkxbtptbfaxZv5MTvWjNYsthZipZF7mjSvCEV481Eo34aWObva2nn
 CSMHqgkTzbCQwN7ZiRqKDBsuPODXiaAMwF1+BEQn384n55xjHHLa8UTPTegxEoHbUCJx
 tle7DxfcMYzyvlXa2TjHxbhe9osgjvC19mlICq1ofVhlmxfZacoDFOc3je6qvQ6hI4SR
 6jrGlHUwbjLpd2paK92lLZ7f7fpOaxSHP8284erZOdM2MB95pP39I5nXzl7lrBxzFyKn
 XvO2evesus8czoEiGe+gVcIPxo2uCRMur10e7w/geJiqSfBxRXItdTrB2SE4rp6azjEE jw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3et5yp65wt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 10:55:55 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Mar
 2022 15:55:53 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 18 Mar 2022 15:55:53 +0000
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.229])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 03AC17C;
        Fri, 18 Mar 2022 15:55:52 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 1/6] ALSA: hda/cs8409: Fix Warlock using dual mic configuration
Date:   Fri, 18 Mar 2022 15:55:47 +0000
Message-ID: <20220318155552.24751-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318155552.24751-1-vitalyr@opensource.cirrus.com>
References: <20220318155552.24751-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MclKH3A3hirQnOnPfU1GyyCX2c4RpoJ8
X-Proofpoint-GUID: MclKH3A3hirQnOnPfU1GyyCX2c4RpoJ8
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index aff2b5abb81e..1411e3845f16 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -907,8 +907,8 @@ static void cs8409_cs42l42_hw_init(struct hda_codec *codec)
 	}
 
 	/* DMIC1_MO=00b, DMIC1/2_SR=1 */
-	if (codec->fixup_id == CS8409_WARLOCK || codec->fixup_id == CS8409_CYBORG)
-		cs8409_vendor_coef_set(codec, 0x09, 0x0003);
+	if (codec->fixup_id == CS8409_CYBORG)
+		cs8409_vendor_coef_set(codec, CS8409_DMIC_CFG, 0x0003);
 
 	cs42l42_resume(cs42l42);
 
-- 
2.25.1

