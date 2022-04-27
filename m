Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DBE511FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbiD0PL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbiD0PK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:10:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA722338A9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:07:46 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RBg6qC022428;
        Wed, 27 Apr 2022 10:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=QqZ9HtcxxjkVTo4erCRoqSajBnEHY2kDDmUBOTtQWWI=;
 b=T1FP2PtI3x1a0mpZTGZI7QXs3UFW1gM2Jtr8abneWTgtzKjolnxh3GLmgncRn/5moPdL
 Pc/+oDKwQkm6jDezlGO2cXaFQJXEcBe6gqIYA4ZSL3V08dC5H0YK6VabajejF+Mpd7SO
 NOiYkQqb4rziNZ0KTbBkOiC4Pz4ksGor7yrwF7BoiUP9gkp5Cz4Gul03BT6Ff0QLm9Jt
 3no37S8Bttkf1XvQKesSrY/VjVc5t9CTeYKxuPLTTJkwjbKtTGEtz8HzWs86dNt4+BKw
 hgemtSXvrsoQKR927CWZAsxpflzNkMoTfHrBXtsWi1AtXUvaezfLBbx0bwpfGxmUee4W jw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xte-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 10:07:34 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 16:07:24 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8B0C8478;
        Wed, 27 Apr 2022 15:07:23 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 05/26] ALSA: hda: cs35l41: Enable GPIO2 Interrupt for CLSA0100 laptops
Date:   Wed, 27 Apr 2022 16:06:59 +0100
Message-ID: <20220427150720.9194-6-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4wgY_6bPxQ919g1R8npHiikPJ96kfO4s
X-Proofpoint-ORIG-GUID: 4wgY_6bPxQ919g1R8npHiikPJ96kfO4s
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

CLSA0100 Laptop does not contain configuration inside ACPI,
instead the hardware configuration needs to be hardcoded.
Hardcode GPIO2 Interrupt in the driver for CSLA0100.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index bd52e0c2c772..2608bf4a6851 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -412,6 +412,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	cs35l41->hw_cfg.spk_pos = cs35l41->index;
 	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
 	cs35l41->hw_cfg.bst_type = CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
+	hw_cfg->gpio2.func = CS35L41_GPIO2_INT_OPEN_DRAIN;
+	hw_cfg->gpio2.valid = true;
 	cs35l41->hw_cfg.valid = true;
 	put_device(physdev);
 
-- 
2.32.0

