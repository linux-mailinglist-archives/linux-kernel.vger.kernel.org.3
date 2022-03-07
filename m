Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0B34D0386
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbiCGP6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243986AbiCGP56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:57:58 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5CB7D00F;
        Mon,  7 Mar 2022 07:57:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D3E731F43DE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646668622;
        bh=6NoOklKLAvSst15nOrzs5E10D4lpohNoFGlreOLuXl0=;
        h=From:To:Cc:Subject:Date:From;
        b=RHBjRupZj0c8esNwufh5vf3czfEKDc/TX4C2+dN2UNabI1D3e+C0xSAlDfwnpiYK8
         Mg0lSXIa/yrlNUpzy2xYENcDpQ3IxknhWVICVnNncb/oSBDScemMddZteuM3+Grf2p
         Xea/DVARxjmj2MccLrD/zYUdCB7j5J4dpkuMsLoHiRTekU8JxIX86Nwct1OStnLxPC
         wtp6/Cd+/ymSmTmY5YNr8+VgPO2Kx9Zwbd3EVX7Zj2RPODGhiH4NYiTNS0xG0lC5O1
         CACHM5APJKHsBlf8TVPMjCtsx3oMmDTwsLfNbQZbvm0RJlaOOijBU9xerFFff2m5RN
         7mUIAw5bvHyqg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     minghsiu.tsai@mediatek.com
Cc:     houlong.wei@mediatek.com, andrew-ct.chen@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com, hans.verkuil@cisco.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, acourbot@chromium.org,
        irui.wang@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] media: platform: mtk-mdp: Fix mdp_ipi_comm structure alignment
Date:   Mon,  7 Mar 2022 16:56:53 +0100
Message-Id: <20220307155653.460910-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mdp_ipi_comm structure defines a command that is either
PROCESS (start processing) or DEINIT (destroy instance); we
are using this one to send PROCESS or DEINIT commands from Linux
to an MDP instance through a VPU write but, while the first wants
us to stay 4-bytes aligned, the VPU instead requires an 8-bytes
data alignment.

Keeping in mind that these commands are executed immediately
after sending them (hence not chained with others before the
VPU/MDP "actually" start executing), it is fine to simply add
a padding of 4 bytes to this structure: this keeps the same
performance as before, as we're still stack-allocating it,
while avoiding hackery inside of mtk-vpu to ensure alignment
bringing a definitely bigger performance impact.

Fixes: c8eb2d7e8202 ("[media] media: Add Mediatek MDP Driver")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

This patch has been tested on Acer Chromebook R 13 (MT8173 Elm) on Debian Sid.

This is an alternative solution to the mtk-vpu approach, found here:
https://lore.kernel.org/all/20210920170408.1561-1-dafna.hirschfeld@collabora.com

 drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h b/drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h
index 2cb8cecb3077..b810c96695c8 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h
@@ -40,12 +40,14 @@ struct mdp_ipi_init {
  * @ipi_id        : IPI_MDP
  * @ap_inst       : AP mtk_mdp_vpu address
  * @vpu_inst_addr : VPU MDP instance address
+ * @padding       : Alignment padding
  */
 struct mdp_ipi_comm {
 	uint32_t msg_id;
 	uint32_t ipi_id;
 	uint64_t ap_inst;
 	uint32_t vpu_inst_addr;
+	uint32_t padding;
 };
 
 /**
-- 
2.35.1

