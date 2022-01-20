Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9A54945FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358284AbiATDOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:14:30 -0500
Received: from inva021.nxp.com ([92.121.34.21]:44944 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358275AbiATDO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:14:28 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DC3FA201004;
        Thu, 20 Jan 2022 04:14:26 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A3DAE201001;
        Thu, 20 Jan 2022 04:14:26 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5A412183ACDD;
        Thu, 20 Jan 2022 11:14:24 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: soc-generic-dmaengine-pcm: separate max_buffer_size assignment
Date:   Thu, 20 Jan 2022 10:44:02 +0800
Message-Id: <1642646642-15908-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config->pcm_hardware may be NULL when config->prealloc_buffer_size
is not zero, so it is better to move max_buffer_size assignment under
a separate condition.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index c54c8ca8d715..8659cb1794f1 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -237,13 +237,15 @@ static int dmaengine_pcm_new(struct snd_soc_component *component,
 	size_t max_buffer_size;
 	unsigned int i;
 
-	if (config && config->prealloc_buffer_size) {
+	if (config && config->prealloc_buffer_size)
 		prealloc_buffer_size = config->prealloc_buffer_size;
-		max_buffer_size = config->pcm_hardware->buffer_bytes_max;
-	} else {
+	else
 		prealloc_buffer_size = prealloc_buffer_size_kbytes * 1024;
+
+	if (config && config->pcm_hardware && config->pcm_hardware->buffer_bytes_max)
+		max_buffer_size = config->pcm_hardware->buffer_bytes_max;
+	else
 		max_buffer_size = SIZE_MAX;
-	}
 
 	for_each_pcm_streams(i) {
 		struct snd_pcm_substream *substream = rtd->pcm->streams[i].substream;
-- 
2.17.1

