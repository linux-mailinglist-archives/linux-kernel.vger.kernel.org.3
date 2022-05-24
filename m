Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9029E532D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbiEXPPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbiEXPPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:15:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66CD8AE48;
        Tue, 24 May 2022 08:15:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 098691F4245A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653405318;
        bh=Jw7Qs12cCaNOX3+lUyOyFDUD62eb1EsAiVttOmBXYhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQ+em6N60cpA2YXTjMqKs4bg02DieVGlrLgitwoWja7fCSSv2O7PL58BaQUck10er
         EEfM1cbBJO1fdSOecYaCjIAmz3qk68JapnydLS8M0yguy9eUXqNOT8o+n5ttjIbD1r
         5Sc7lCfMYpnvx+iosb+m5Fl0fRl84VEQ/tO3QXYFCz3UtLoqWLtdPzw2UyBSUs7vg1
         DV0KBgoFBcVHqeI7l7eDQZ1iMBWsAlM9jHwwp+xWbKRPOganWuot8FewTl7ouVak4j
         kLPjWibrJ6wyRB7uDcE4fChO93cyU2XbobmooLZPdcV2+gkjvRhl2mAc4W0/ICd18D
         pPYi4GHQsu+Pg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     jassisinghbrar@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, houlong.wei@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/2] mailbox: mtk-cmdq-mailbox: Simplify getting multi-gce clocks
Date:   Tue, 24 May 2022 17:15:12 +0200
Message-Id: <20220524151512.247435-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524151512.247435-1-angelogioacchino.delregno@collabora.com>
References: <20220524151512.247435-1-angelogioacchino.delregno@collabora.com>
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

Instead of looking for gceX aliases across the entire devicetree and
getting clocks by then reading these nodes with of_clk_get(), since
the maximum number of GCEs is two, it is more convenient to simply
assign two clocks to both of the GCE nodes.

Luckily, as of now, there is no devicetree for any multi-gce device
upstream: remove the aforementioned mechanism in favor of getting
both "gce0" and "gce1" clocks with devm_clk_bulk_get() instead.

Compatibility with single-gce mailboxes is retained by assigning
only one id to the clk_bulk_data, as the number of clocks to handle
is already signaled by the "gce_num" member of struct cmdq.

While at it, also beautify the clocks get failure message.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 32 +++++++-----------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 2578e5aaa935..89a0fdde730c 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -527,11 +527,6 @@ static int cmdq_probe(struct platform_device *pdev)
 	struct cmdq *cmdq;
 	int err, i;
 	struct gce_plat *plat_data;
-	struct device_node *phandle = dev->of_node;
-	struct device_node *node;
-	int alias_id = 0;
-	static const char * const clk_name = "gce";
-	static const char * const clk_names[] = { "gce0", "gce1" };
 
 	cmdq = devm_kzalloc(dev, sizeof(*cmdq), GFP_KERNEL);
 	if (!cmdq)
@@ -567,29 +562,16 @@ static int cmdq_probe(struct platform_device *pdev)
 		dev, cmdq->base, cmdq->irq);
 
 	if (cmdq->gce_num > 1) {
-		for_each_child_of_node(phandle->parent, node) {
-			alias_id = of_alias_get_id(node, clk_name);
-			if (alias_id >= 0 && alias_id < cmdq->gce_num) {
-				cmdq->clocks[alias_id].id = clk_names[alias_id];
-				cmdq->clocks[alias_id].clk = of_clk_get(node, 0);
-				if (IS_ERR(cmdq->clocks[alias_id].clk)) {
-					of_node_put(node);
-					return dev_err_probe(dev,
-							     PTR_ERR(cmdq->clocks[alias_id].clk),
-							     "failed to get gce clk: %d\n",
-							     alias_id);
-				}
-			}
-		}
+		cmdq->clocks[0].id = "gce0";
+		cmdq->clocks[1].id = "gce1";
 	} else {
-		cmdq->clocks[alias_id].id = clk_name;
-		cmdq->clocks[alias_id].clk = devm_clk_get(&pdev->dev, clk_name);
-		if (IS_ERR(cmdq->clocks[alias_id].clk)) {
-			return dev_err_probe(dev, PTR_ERR(cmdq->clocks[alias_id].clk),
-					     "failed to get gce clk\n");
-		}
+		cmdq->clocks[0].id = "gce";
 	}
 
+	err = devm_clk_bulk_get(&pdev->dev, cmdq->gce_num, cmdq->clocks);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to get GCE clocks\n");
+
 	cmdq->mbox.dev = dev;
 	cmdq->mbox.chans = devm_kcalloc(dev, cmdq->thread_nr,
 					sizeof(*cmdq->mbox.chans), GFP_KERNEL);
-- 
2.35.1

