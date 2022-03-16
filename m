Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4B4DAD45
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354773AbiCPJOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243385AbiCPJOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:14:52 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2395DE73
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 02:13:34 -0700 (PDT)
X-QQ-mid: bizesmtp91t1647421990t37qmosd
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 16 Mar 2022 17:13:04 +0800 (CST)
X-QQ-SSF: 01400000002000D0H000000A0000000
X-QQ-FEAT: TskX/GkkryCtF3MMUU7WGeLJerz6JGDXThH7VyNE/T3DPVypoS4JBKwYguSjL
        +o/qFTpdpmvQ3QQU3Gz/AceDwgtpxI+JZtqgzzOtVSmIxSSJrqn6tmzQqom790x5nUVNb7M
        ZcSHX6rwVMb+ihYHEpvAulQr2lQLyiPPsL0c9UjaxqDYDLE6nQLLJy2gxife7F3/zTaBIxG
        QAeP+/gFa9KsRCvJMAZj+K8qJcPuRLwnjKRhq2erjDI/x+51xCTLgDDn6UEc4AOwrxAyfov
        gnfnZ2maK3fRBEb1R0zdy2bI4w/aUbKy+J3lGQVtp7IARXgO1stlJ2Huqp8qZB8lRb7olhF
        fkBx8mARx+DLFcYbmfcgG+RoDvTZtHbyENf86t2
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        lgirdwood@gmail.com, Vijendar.Mukunda@amd.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] ASoC: amd: Fix reference to PCM buffer address
Date:   Wed, 16 Mar 2022 17:13:03 +0800
Message-Id: <20220316091303.9745-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCM buffers might be allocated dynamically when the buffer
preallocation failed or a larger buffer is requested, and it's not
guaranteed that substream->dma_buffer points to the actually used
buffer.  The driver needs to refer to substream->runtime->dma_addr
instead for the buffer address.

Fixes: cab396d8b22c1 ("ASoC: amd: add ACP5x pcm dma driver ops")
Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/soc/amd/vangogh/acp5x-pcm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
index 31fa166df98a..d36bb718370f 100644
--- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
+++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
@@ -281,7 +281,7 @@ static int acp5x_dma_hw_params(struct snd_soc_component *component,
 		return -EINVAL;
 	}
 	size = params_buffer_bytes(params);
-	rtd->dma_addr = substream->dma_buffer.addr;
+	rtd->dma_addr = substream->runtime->dma_addr;
 	rtd->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
 	config_acp5x_dma(rtd, substream->stream);
 	return 0;
-- 
2.20.1



