Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D894D490C18
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbiAQQI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:08:57 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:48504 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240729AbiAQQIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:08:49 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20HFFYHF025138;
        Mon, 17 Jan 2022 10:08:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ckVtzevqA4xEJuoQpPtGyoEZQ52WPU9G2ryA25vdTls=;
 b=K1jiK7zTH68LhnKTRwBxnEYQNLryayc+bC5Sswo1kpNoU5z2iHf9C+ztpm2KqPtAyK6Q
 LZDKnTIdhsdBG0czs/AjH//WuQSjdX+mw5imVMn0CcWMPPzvKzFYY4IwluBonzrWrqul
 0dx0HaiBGu9bGIWAoRMleQe0cXG39kDegj1cx0nczX3rGhM5jYrhXVn8JiBA9XQr2AZ3
 L9QsTxXd36XJkOTvjp8FkfQJqxFoeMuhyVKRkh3ljoj44GblzaiUVKcQ7kpO1eBduv/P
 0AKWmJJVuudQlArLdndJ38s/+pzRMbCUmlicgw1sQ0X4zbyXoX9Vizkt7fYRfg25vs1H pA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dnaxhr22c-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Jan 2022 10:08:36 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 16:08:33 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 17 Jan 2022 16:08:33 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1E92446C;
        Mon, 17 Jan 2022 16:08:33 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 5/6] ALSA: hda: cs35l41: Make use of the helper function dev_err_probe()
Date:   Mon, 17 Jan 2022 16:08:29 +0000
Message-ID: <20220117160830.709403-5-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117160830.709403-1-tanureal@opensource.cirrus.com>
References: <20220117160830.709403-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: LdW5S1a2eD39MAr7yv-u5LsfcYP51c3E
X-Proofpoint-ORIG-GUID: LdW5S1a2eD39MAr7yv-u5LsfcYP51c3E
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When possible use dev_err_probe help to properly deal with the
PROBE_DEFER error, the benefit is that DEFER issue will be logged
in the devices_deferred debugfs file.
Using dev_err_probe() can reduce code size, and the error value
gets printed.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---

V2: New patch with code split from Tidyup patch in this series

---
 sound/pci/hda/cs35l41_hda.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 82f982f574a9..c317b392c3e3 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -429,8 +429,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 		if (ret == -EBUSY) {
 			dev_info(cs35l41->dev, "Reset line busy, assuming shared reset\n");
 		} else {
-			if (ret != -EPROBE_DEFER)
-				dev_err(cs35l41->dev, "Failed to get reset GPIO: %d\n", ret);
+			dev_err_probe(cs35l41->dev, ret, "Failed to get reset GPIO: %d\n", ret);
 			goto err;
 		}
 	}
-- 
2.34.1

