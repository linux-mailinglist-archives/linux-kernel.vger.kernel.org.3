Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAD651E6E6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350637AbiEGMaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 08:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiEGMaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:30:07 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932323AA67
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 05:26:19 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D3639200284;
        Sat,  7 May 2022 14:26:17 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C55D2007C8;
        Sat,  7 May 2022 14:26:17 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2096D180031B;
        Sat,  7 May 2022 20:26:16 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoc: fsl_micfil: explicitly clear software reset bit
Date:   Sat,  7 May 2022 20:14:13 +0800
Message-Id: <1651925654-32060-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SRES is self-cleared bit, but REG_MICFIL_CTRL1 is defined as
non volatile register, it still remain in regmap cache after set,
then every update of REG_MICFIL_CTRL1, software reset happens.
to avoid this, clear it explicitly.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index cd85c8714f97..2149fac0dcc6 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -179,6 +179,17 @@ static int fsl_micfil_reset(struct device *dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * SRES is self-cleared bit, but REG_MICFIL_CTRL1 is defined
+	 * as non-volatile register, so SRES still remain in regmap
+	 * cache after set, that every update of REG_MICFIL_CTRL1,
+	 * software reset happens. so clear it explicitly.
+	 */
+	ret = regmap_clear_bits(micfil->regmap, REG_MICFIL_CTRL1,
+				MICFIL_CTRL1_SRES);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.17.1

