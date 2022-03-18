Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCFD4DDD5F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiCRP5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbiCRP5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:57:31 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E926B9AE6D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:56:10 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I4MHlb013781;
        Fri, 18 Mar 2022 10:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=4ubhXnz6J+r1+/mUBniQ5DDmUxb8UDS9SG+xDXW1Xm4=;
 b=VbwGfrwUVE3dPl+P3wUK4epol7xeR2T+kGb2o4HEgjytdknw4kYdFsl5GbqVEx9ltcmc
 Ao5t5H0Yr/WcrRknYdVgWkeOEl8p+D98A0iqJ3egQ8GaaAGq1Jx0nDPMpxGPcirf+VC9
 Nki0W52hypBd8oSxduJYctmwlykRY3IcYtcELmgOhsJflGIS17grk9gu+WbbPcnu3UZO
 PaAykPGFfJoWovWYkg0jPSqYAl2ioHJMasv/7Nd7VRTOoHhivzpBrYfL++4jYHtv8DZT
 6aUxFRFMYpzjKYvy3T94PPwXBekFCUltw61ueJmCu7/ihVLeGTHJBGdlQ4SCamJTbvAD Ng== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3et5yp65wt-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 10:55:55 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Mar
 2022 15:55:54 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 18 Mar 2022 15:55:54 +0000
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.229])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DF94CB16;
        Fri, 18 Mar 2022 15:55:53 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 2/6] ALSA: hda/cs8409: Re-order quirk table into ascending order
Date:   Fri, 18 Mar 2022 15:55:48 +0000
Message-ID: <20220318155552.24751-3-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318155552.24751-1-vitalyr@opensource.cirrus.com>
References: <20220318155552.24751-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hKjp7SwX8dQ8qUsN2K_Jx3hokyPUa6FH
X-Proofpoint-GUID: hKjp7SwX8dQ8qUsN2K_Jx3hokyPUa6FH
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
 sound/pci/hda/patch_cs8409-tables.c | 34 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index 2d1fa706327b..9c1fa97100ef 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -478,28 +478,29 @@ const struct snd_pci_quirk cs8409_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0A29, "Bullseye", CS8409_BULLSEYE),
 	SND_PCI_QUIRK(0x1028, 0x0A2A, "Bullseye", CS8409_BULLSEYE),
 	SND_PCI_QUIRK(0x1028, 0x0A2B, "Bullseye", CS8409_BULLSEYE),
+	SND_PCI_QUIRK(0x1028, 0x0A77, "Cyborg", CS8409_CYBORG),
+	SND_PCI_QUIRK(0x1028, 0x0A78, "Cyborg", CS8409_CYBORG),
+	SND_PCI_QUIRK(0x1028, 0x0A79, "Cyborg", CS8409_CYBORG),
+	SND_PCI_QUIRK(0x1028, 0x0A7A, "Cyborg", CS8409_CYBORG),
+	SND_PCI_QUIRK(0x1028, 0x0A7D, "Cyborg", CS8409_CYBORG),
+	SND_PCI_QUIRK(0x1028, 0x0A7E, "Cyborg", CS8409_CYBORG),
+	SND_PCI_QUIRK(0x1028, 0x0A7F, "Cyborg", CS8409_CYBORG),
+	SND_PCI_QUIRK(0x1028, 0x0A80, "Cyborg", CS8409_CYBORG),
 	SND_PCI_QUIRK(0x1028, 0x0AB0, "Warlock", CS8409_WARLOCK),
 	SND_PCI_QUIRK(0x1028, 0x0AB2, "Warlock", CS8409_WARLOCK),
 	SND_PCI_QUIRK(0x1028, 0x0AB1, "Warlock", CS8409_WARLOCK),
 	SND_PCI_QUIRK(0x1028, 0x0AB3, "Warlock", CS8409_WARLOCK),
 	SND_PCI_QUIRK(0x1028, 0x0AB4, "Warlock", CS8409_WARLOCK),
 	SND_PCI_QUIRK(0x1028, 0x0AB5, "Warlock", CS8409_WARLOCK),
+	SND_PCI_QUIRK(0x1028, 0x0ACF, "Dolphin", CS8409_DOLPHIN),
+	SND_PCI_QUIRK(0x1028, 0x0AD0, "Dolphin", CS8409_DOLPHIN),
+	SND_PCI_QUIRK(0x1028, 0x0AD1, "Dolphin", CS8409_DOLPHIN),
+	SND_PCI_QUIRK(0x1028, 0x0AD2, "Dolphin", CS8409_DOLPHIN),
+	SND_PCI_QUIRK(0x1028, 0x0AD3, "Dolphin", CS8409_DOLPHIN),
 	SND_PCI_QUIRK(0x1028, 0x0AD9, "Warlock", CS8409_WARLOCK),
 	SND_PCI_QUIRK(0x1028, 0x0ADA, "Warlock", CS8409_WARLOCK),
 	SND_PCI_QUIRK(0x1028, 0x0ADB, "Warlock", CS8409_WARLOCK),
 	SND_PCI_QUIRK(0x1028, 0x0ADC, "Warlock", CS8409_WARLOCK),
-	SND_PCI_QUIRK(0x1028, 0x0AF4, "Warlock", CS8409_WARLOCK),
-	SND_PCI_QUIRK(0x1028, 0x0AF5, "Warlock", CS8409_WARLOCK),
-	SND_PCI_QUIRK(0x1028, 0x0BB5, "Warlock N3 15 TGL-U Nuvoton EC", CS8409_WARLOCK),
-	SND_PCI_QUIRK(0x1028, 0x0BB6, "Warlock V3 15 TGL-U Nuvoton EC", CS8409_WARLOCK),
-	SND_PCI_QUIRK(0x1028, 0x0A77, "Cyborg", CS8409_CYBORG),
-	SND_PCI_QUIRK(0x1028, 0x0A78, "Cyborg", CS8409_CYBORG),
-	SND_PCI_QUIRK(0x1028, 0x0A79, "Cyborg", CS8409_CYBORG),
-	SND_PCI_QUIRK(0x1028, 0x0A7A, "Cyborg", CS8409_CYBORG),
-	SND_PCI_QUIRK(0x1028, 0x0A7D, "Cyborg", CS8409_CYBORG),
-	SND_PCI_QUIRK(0x1028, 0x0A7E, "Cyborg", CS8409_CYBORG),
-	SND_PCI_QUIRK(0x1028, 0x0A7F, "Cyborg", CS8409_CYBORG),
-	SND_PCI_QUIRK(0x1028, 0x0A80, "Cyborg", CS8409_CYBORG),
 	SND_PCI_QUIRK(0x1028, 0x0ADF, "Cyborg", CS8409_CYBORG),
 	SND_PCI_QUIRK(0x1028, 0x0AE0, "Cyborg", CS8409_CYBORG),
 	SND_PCI_QUIRK(0x1028, 0x0AE1, "Cyborg", CS8409_CYBORG),
@@ -512,11 +513,10 @@ const struct snd_pci_quirk cs8409_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0AEE, "Cyborg", CS8409_CYBORG),
 	SND_PCI_QUIRK(0x1028, 0x0AEF, "Cyborg", CS8409_CYBORG),
 	SND_PCI_QUIRK(0x1028, 0x0AF0, "Cyborg", CS8409_CYBORG),
-	SND_PCI_QUIRK(0x1028, 0x0AD0, "Dolphin", CS8409_DOLPHIN),
-	SND_PCI_QUIRK(0x1028, 0x0AD1, "Dolphin", CS8409_DOLPHIN),
-	SND_PCI_QUIRK(0x1028, 0x0AD2, "Dolphin", CS8409_DOLPHIN),
-	SND_PCI_QUIRK(0x1028, 0x0AD3, "Dolphin", CS8409_DOLPHIN),
-	SND_PCI_QUIRK(0x1028, 0x0ACF, "Dolphin", CS8409_DOLPHIN),
+	SND_PCI_QUIRK(0x1028, 0x0AF4, "Warlock", CS8409_WARLOCK),
+	SND_PCI_QUIRK(0x1028, 0x0AF5, "Warlock", CS8409_WARLOCK),
+	SND_PCI_QUIRK(0x1028, 0x0BB5, "Warlock N3 15 TGL-U Nuvoton EC", CS8409_WARLOCK),
+	SND_PCI_QUIRK(0x1028, 0x0BB6, "Warlock V3 15 TGL-U Nuvoton EC", CS8409_WARLOCK),
 	{} /* terminator */
 };
 
-- 
2.25.1

