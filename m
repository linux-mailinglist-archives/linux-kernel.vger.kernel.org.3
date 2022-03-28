Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1774E960C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbiC1MAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242591AbiC1L6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:58:25 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE6F3335F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:56:31 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S8AHvb030601;
        Mon, 28 Mar 2022 06:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=OLEzghvnn9gNLbQwwYzpsmkhYm8klpUyJxyvOaxpoqo=;
 b=A9JEl25WDBwJPzl2bd3tjKh0MM1fBuMMNDyu2GJmtiIGFtjR/AdFJHSAnP8QdMnfz6CQ
 eQqRNmJVdPNuewF+L4NhkZ6oBFTku7Tig5pc25o++eRHccFVLjtrbCUcY3WOufwgFdCB
 OqhNLilVBtywEKBxIyQXXkHoS3us1hywEuKrN5fuAMGOC0h08BXAkkctItlK5wq4rby/
 ksDSbs+D0ff8dt5B6khmKwffbCr7ELFCwb0hLpaq6X1K77yDtlfXiNvNLFXvpc2NSFAu
 lMr9jdAztJbhXMxMMPG7EMXu2lFSxmUHRBqqvjhJ8o9Drq9s0T7JBIDLgaU7QTR5iRbe wA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f2081apda-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Mar 2022 06:56:17 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 12:56:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 28 Mar 2022 12:56:15 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.244])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 13DADB1A;
        Mon, 28 Mar 2022 11:56:15 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 1/6] ALSA: hda/cs8409: Fix Warlock to use mono mic configuration
Date:   Mon, 28 Mar 2022 12:56:09 +0100
Message-ID: <20220328115614.15761-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328115614.15761-1-vitalyr@opensource.cirrus.com>
References: <20220328115614.15761-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PrqM8UFwgvvPaq0uEZi1ucSLTTz5umcS
X-Proofpoint-GUID: PrqM8UFwgvvPaq0uEZi1ucSLTTz5umcS
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Warlock/Bullseye Laptops have a mono DMIC, Cyborg uses
a stereo DMIC, and the configuration should reflect this.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Changes in v2:
Add patch description in commit message.

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

