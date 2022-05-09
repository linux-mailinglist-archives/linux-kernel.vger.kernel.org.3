Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4E85206DD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiEIVvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiEIVvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:51:16 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4852701BE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:47:20 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249KTf3I031853;
        Mon, 9 May 2022 16:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=/kuXGXVoUrJ5RtoN4zkmhDFmfSoCd+EVXdvQ993Tilg=;
 b=HJO9SgOKOxC0wNUiGj+JHtCSOaLsOtlq7LNemR/mjuvfsrQyoqRkEC6XG+xoY2fxZh5K
 g7XDXCwe/fa85pRJB6HguwUff1iAI/PiW0SeJ6xVJBjaGPtbBoDZH6TGJ+A7ZpWoWcqY
 VkmFA9Dm4zIkiztQUQW+FbkWCQqYajWKDGItVwVWKoMAmGgAMCgtp8hFe30/GMjYArGV
 WYNPMqpx6r1PwmzhPnB0cH1v6VcZ4oretFL0quoXUuKSG6f8/JHSKvMTacZ7n1vevV4n
 gOP2+nqtT6D1ErJfF+ZNZIryf81Or4xK4fy1kT6KukOKO8rR0WQYvEKIP2PSfAR42pjJ sA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fwn6nu87p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 May 2022 16:47:08 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 22:47:06 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 9 May 2022 22:47:06 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.55])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 11978B10;
        Mon,  9 May 2022 21:47:06 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 05/26] ALSA: hda: cs35l41: Enable GPIO2 Interrupt for CLSA0100 laptops
Date:   Mon, 9 May 2022 22:46:42 +0100
Message-ID: <20220509214703.4482-6-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220509214703.4482-1-vitalyr@opensource.cirrus.com>
References: <20220509214703.4482-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6zWbfpH0mMfQuTrPLKsXa6yZbIbevhWH
X-Proofpoint-GUID: 6zWbfpH0mMfQuTrPLKsXa6yZbIbevhWH
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
2.34.1

