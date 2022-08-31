Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554D65A7B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiHaK3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiHaK3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:29:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8B5B8A4D;
        Wed, 31 Aug 2022 03:29:03 -0700 (PDT)
X-UUID: 30a5afa62d13414ab231337a06332c9b-20220831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=eEFFPWPurfnTLCuJ6XvA8r7eaX08wfQ5CFFfzRlVtVw=;
        b=EsnLn4s1jNt/LxvFq6yTre7tE5IBwTL8uV+7vKu4tdkP92JG/KDqd+PbRtXFFyYufqcrR/zC4blrg1ikHRlwRJp5z7bRl2ceCNtBuMib3aiAp10nRcUJKfnxmskhzDDPTK06ROqdfcMJre5XMg69VWMRraF12a9VNAi/ATsFdxA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:91675b06-663a-4676-8e5b-46416c84bb30,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:-5
X-CID-META: VersionHash:84eae18,CLOUDID:d9cc2fd0-20bd-4e5e-ace8-00692b7ab380,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 30a5afa62d13414ab231337a06332c9b-20220831
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1027227376; Wed, 31 Aug 2022 18:28:56 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 31 Aug 2022 18:28:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 31 Aug 2022 18:28:54 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [v2] media: platform: mtk-mdp3: fix smatch errors and warning
Date:   Wed, 31 Aug 2022 18:28:53 +0800
Message-ID: <20220831102853.6843-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two errors reported by smatch:
    drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c:292
        mdp_probe() error: we previously assumed 'mdp' could be null
    drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c:460
        mdp_cmdq_send() error: we previously assumed 'cmd' could be null

Also, avoid warnings reported by smatch:
    drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:872
        mdp_comp_create() warn: passing devm_ allocated variable to kfree. 'comp'

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
--

Changes in v2:
  Fix compilation fail caused by too few arguments to function call
  in mtk-mdp3-comp.c

This patch is based on hverkuil/media_tree.git tags/br-v6.1c

---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c | 2 +-
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 2 +-
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 29f6c1cd3de7..86c054600a08 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -457,7 +457,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	kfree(path);
 	atomic_dec(&mdp->job_count);
 	wake_up(&mdp->callback_wq);
-	if (cmd->pkt.buf_size > 0)
+	if (cmd && cmd->pkt.buf_size > 0)
 		mdp_cmdq_pkt_destroy(&cmd->pkt);
 	kfree(comps);
 	kfree(cmd);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index e62abf3587bf..43455755a5ac 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -869,7 +869,7 @@ static struct mdp_comp *mdp_comp_create(struct mdp_dev *mdp,
 
 	ret = mdp_comp_init(mdp, node, comp, id);
 	if (ret) {
-		kfree(comp);
+		devm_kfree(dev, comp);
 		return ERR_PTR(ret);
 	}
 	mdp->comp[id] = comp;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index cde59579b7ae..c413e59d4286 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -289,7 +289,8 @@ static int mdp_probe(struct platform_device *pdev)
 	mdp_comp_destroy(mdp);
 err_return:
 	for (i = 0; i < MDP_PIPE_MAX; i++)
-		mtk_mutex_put(mdp->mdp_mutex[i]);
+		if (mdp)
+			mtk_mutex_put(mdp->mdp_mutex[i]);
 	kfree(mdp);
 	dev_dbg(dev, "Errno %d\n", ret);
 	return ret;
-- 
2.18.0

