Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCB25A799C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiHaI5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiHaI5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:57:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E55DCCD45;
        Wed, 31 Aug 2022 01:56:27 -0700 (PDT)
X-UUID: 6f3a6b590994490ebc6960668afaef05-20220831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zHSZP1OWHazBgWQXESQByXqKm9vhBpvgdCCmwtEmCjU=;
        b=JgkDZEY7OYt/QnXipLh0PXRnpFK2jJyP4x1701TkCaYTJUIjwEKNuQJbuijcafjA7GgUYmJfFiLaucW3WjOoLe73HmgvLf/GHdfFLQDjdV8rJ0Jj3CbJqz7BZgfG42gI043V7h1OkDeTHDk8ycA2yRZKWS2ziQX54OBtTCcTj6E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:7ac88c3c-f6aa-4144-9442-fd50ae88724d,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:90
X-CID-INFO: VERSION:1.1.10,REQID:7ac88c3c-f6aa-4144-9442-fd50ae88724d,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS9
        81B3D,ACTION:quarantine,TS:90
X-CID-META: VersionHash:84eae18,CLOUDID:25172dd0-20bd-4e5e-ace8-00692b7ab380,C
        OID:b7553ccf3b0b,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6f3a6b590994490ebc6960668afaef05-20220831
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 15634917; Wed, 31 Aug 2022 16:56:07 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 31 Aug 2022 16:56:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 31 Aug 2022 16:56:06 +0800
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
Subject: [v1] media: platform: mtk-mdp3: fix smatch errors and warning
Date:   Wed, 31 Aug 2022 16:56:04 +0800
Message-ID: <20220831085604.2739-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_CSS autolearn=no autolearn_force=no version=3.4.6
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
index e62abf3587bf..d1064b149ef9 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -869,7 +869,7 @@ static struct mdp_comp *mdp_comp_create(struct mdp_dev *mdp,
 
 	ret = mdp_comp_init(mdp, node, comp, id);
 	if (ret) {
-		kfree(comp);
+		devm_kfree(comp);
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

