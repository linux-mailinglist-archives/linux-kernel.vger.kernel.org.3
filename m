Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FF85206DC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiEIVvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiEIVvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:51:16 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB7B26FA39
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:47:20 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249BF6xX021606;
        Mon, 9 May 2022 16:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=cUP9ZJK4cSynfAf4icaGqJ4giaJY3xcHVfwyrJ14f+0=;
 b=TFXFoXYV0Rt8hTBnyfej9AexixLn/Us0JsI4fN8mY5TFn2ZGR0Lh6Vk+7nc6cdckfCDI
 CP93Cshpx2fJX/qEq84LdlAyXe5IP0OSdyIZQ+HGTsjuvKXkcsHoKm4943Im5sINPCJj
 FqCCZNf4Wxf3IyDpGiZ4ZOkaf+K291Deco1nsoDJjbdXIhD3h7K3HmMNVU2RdGvgWcGu
 9zVh0+ImKqDqyJAws30oJdA6GF1YFcYNrfJdrrFNWtqOxQ0ZUXXwV5AFFviNliH55EGa
 LwzDvAl1TZM/yHutGg519vypgdJOih0/4zfvXvnlL/ji1M27fMMCjHH2oy98UXJCpPbQ 2w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fwp613jer-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 May 2022 16:47:06 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 22:47:04 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 9 May 2022 22:47:04 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.55])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E24E911D1;
        Mon,  9 May 2022 21:47:03 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 01/26] ALSA: hda: cs35l41: Fix error in spi cs35l41 hda driver name
Date:   Mon, 9 May 2022 22:46:38 +0100
Message-ID: <20220509214703.4482-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220509214703.4482-1-vitalyr@opensource.cirrus.com>
References: <20220509214703.4482-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: g1fdCMvJA-xd_C6XjPTCWq-pxO4JiHhR
X-Proofpoint-ORIG-GUID: g1fdCMvJA-xd_C6XjPTCWq-pxO4JiHhR
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

For consistency, rename spi cs35l41 hda driver name so that
it matches i2c.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda_spi.c b/sound/pci/hda/cs35l41_hda_spi.c
index 50eb6c0e6658..22e088f28438 100644
--- a/sound/pci/hda/cs35l41_hda_spi.c
+++ b/sound/pci/hda/cs35l41_hda_spi.c
@@ -48,7 +48,7 @@ MODULE_DEVICE_TABLE(acpi, cs35l41_acpi_hda_match);
 
 static struct spi_driver cs35l41_spi_driver = {
 	.driver = {
-		.name		= "cs35l41_hda",
+		.name		= "cs35l41-hda",
 		.acpi_match_table = ACPI_PTR(cs35l41_acpi_hda_match),
 	},
 	.id_table	= cs35l41_hda_spi_id,
-- 
2.34.1

