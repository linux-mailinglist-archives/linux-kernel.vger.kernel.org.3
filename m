Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82E448407F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiADLK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:10:26 -0500
Received: from inva021.nxp.com ([92.121.34.21]:34104 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231937AbiADLKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:10:24 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EEF85200CC7;
        Tue,  4 Jan 2022 12:10:22 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B7C1D200C96;
        Tue,  4 Jan 2022 12:10:22 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 51B77183AD05;
        Tue,  4 Jan 2022 19:10:21 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: imx-card: improve the sound quality for low rate
Date:   Tue,  4 Jan 2022 18:40:35 +0800
Message-Id: <1641292835-19085-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641292835-19085-1-git-send-email-shengjiu.wang@nxp.com>
References: <1641292835-19085-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to RM, on auto mode:
For codec AK4458 and AK4497, the lowest ratio of MLCK/FS is 256
if sample rate is 8kHz-48kHz,
For codec AK5558, the lowest ratio of MLCK/FS is 512 if sample
rate is 8kHz-48kHz.

With these setting the sound quality for 8kHz-48kHz can be improved.

Fixes: aa736700f42f ("ASoC: imx-card: Add imx-card machine driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/imx-card.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index f9196fb7e833..6f8efd838fcc 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -120,7 +120,7 @@ struct imx_card_data {
 
 static struct imx_akcodec_fs_mul ak4458_fs_mul[] = {
 	/* Normal, < 32kHz */
-	{ .rmin = 8000,   .rmax = 24000,  .wmin = 1024, .wmax = 1024, },
+	{ .rmin = 8000,   .rmax = 24000,  .wmin = 256,  .wmax = 1024, },
 	/* Normal, 32kHz */
 	{ .rmin = 32000,  .rmax = 32000,  .wmin = 256,  .wmax = 1024, },
 	/* Normal */
@@ -151,8 +151,8 @@ static struct imx_akcodec_fs_mul ak4497_fs_mul[] = {
 	 * Table 7      - mapping multiplier and speed mode
 	 * Tables 8 & 9 - mapping speed mode and LRCK fs
 	 */
-	{ .rmin = 8000,   .rmax = 32000,  .wmin = 1024, .wmax = 1024, }, /* Normal, <= 32kHz */
-	{ .rmin = 44100,  .rmax = 48000,  .wmin = 512,  .wmax = 512, }, /* Normal */
+	{ .rmin = 8000,   .rmax = 32000,  .wmin = 256,  .wmax = 1024, }, /* Normal, <= 32kHz */
+	{ .rmin = 44100,  .rmax = 48000,  .wmin = 256,  .wmax = 512, }, /* Normal */
 	{ .rmin = 88200,  .rmax = 96000,  .wmin = 256,  .wmax = 256, }, /* Double */
 	{ .rmin = 176400, .rmax = 192000, .wmin = 128,  .wmax = 128, }, /* Quad */
 	{ .rmin = 352800, .rmax = 384000, .wmin = 128,  .wmax = 128, }, /* Oct */
@@ -164,7 +164,7 @@ static struct imx_akcodec_fs_mul ak4497_fs_mul[] = {
  * (Table 4 from datasheet)
  */
 static struct imx_akcodec_fs_mul ak5558_fs_mul[] = {
-	{ .rmin = 8000,   .rmax = 32000,  .wmin = 1024, .wmax = 1024, },
+	{ .rmin = 8000,   .rmax = 32000,  .wmin = 512,  .wmax = 1024, },
 	{ .rmin = 44100,  .rmax = 48000,  .wmin = 512,  .wmax = 512, },
 	{ .rmin = 88200,  .rmax = 96000,  .wmin = 256,  .wmax = 256, },
 	{ .rmin = 176400, .rmax = 192000, .wmin = 128,  .wmax = 128, },
-- 
2.17.1

