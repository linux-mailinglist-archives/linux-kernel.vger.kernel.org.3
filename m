Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC0C48407D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiADLKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:10:23 -0500
Received: from inva020.nxp.com ([92.121.34.13]:59256 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbiADLKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:10:21 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D14061A0DE9;
        Tue,  4 Jan 2022 12:10:20 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9ABC71A2251;
        Tue,  4 Jan 2022 12:10:20 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 36792183AD67;
        Tue,  4 Jan 2022 19:10:19 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ASoC: imx-card: Need special setting for ak4497 on i.MX8MQ
Date:   Tue,  4 Jan 2022 18:40:33 +0800
Message-Id: <1641292835-19085-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641292835-19085-1-git-send-email-shengjiu.wang@nxp.com>
References: <1641292835-19085-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SAI on i.MX8MQ don't support one2one ratio for mclk:bclk, so
the mclk frequency exceeds the supported range of codec for
the case that sample rate is larger than 705kHZ and format is
S32_LE. Update the supported width for such case.

Fixes: aa736700f42f ("ASoC: imx-card: Add imx-card machine driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/imx-card.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index e758c4f1b0bc..e0f3aa6d9501 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -553,8 +553,23 @@ static int imx_card_parse_of(struct imx_card_data *data)
 			link_data->cpu_sysclk_id = FSL_SAI_CLK_MAST1;
 
 			/* sai may support mclk/bclk = 1 */
-			if (of_find_property(np, "fsl,mclk-equal-bclk", NULL))
+			if (of_find_property(np, "fsl,mclk-equal-bclk", NULL)) {
 				link_data->one2one_ratio = true;
+			} else {
+				int i;
+
+				/*
+				 * i.MX8MQ don't support one2one ratio, then
+				 * with ak4497 only 16bit case is supported.
+				 */
+				for (i = 0; i < ARRAY_SIZE(ak4497_fs_mul); i++) {
+					if (ak4497_fs_mul[i].rmin == 705600 &&
+					    ak4497_fs_mul[i].rmax == 768000) {
+						ak4497_fs_mul[i].wmin = 32;
+						ak4497_fs_mul[i].wmax = 32;
+					}
+				}
+			}
 		}
 
 		link->cpus->of_node = args.np;
-- 
2.17.1

