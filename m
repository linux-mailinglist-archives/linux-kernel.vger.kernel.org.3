Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7074767E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhLPCYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:24:33 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33276 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230021AbhLPCYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:24:32 -0500
X-UUID: 0e311d87e129456c830bbb56eb241c3c-20211216
X-UUID: 0e311d87e129456c830bbb56eb241c3c-20211216
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1773176115; Thu, 16 Dec 2021 10:24:29 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 16 Dec 2021 10:24:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 16 Dec
 2021 10:24:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Dec 2021 10:24:28 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: mediatek: mt8195: correct default value
Date:   Thu, 16 Dec 2021 10:24:24 +0800
Message-ID: <20211216022424.28470-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8195_cg_patch is used to reset the default value of audio cg, so the
register value could be consistent with CCF reference count.
Nevertheless, AUDIO_TOP_CON1[1:0] is used to control an internal mux,
and it's expected to keep the default value 0.

This patch corrects the default value in case an unexpected behavior
happens in the future.

Fixes: 6746cc8582599 ("ASoC: mediatek: mt8195: add platform driver")
Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 8a6db24116e3..e425f868476a 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -3029,7 +3029,7 @@ static const struct reg_sequence mt8195_afe_reg_defaults[] = {
 
 static const struct reg_sequence mt8195_cg_patch[] = {
 	{ AUDIO_TOP_CON0, 0xfffffffb },
-	{ AUDIO_TOP_CON1, 0xfffffffa },
+	{ AUDIO_TOP_CON1, 0xfffffff8 },
 };
 
 static int mt8195_afe_init_registers(struct mtk_base_afe *afe)
-- 
2.18.0

