Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02E0525A55
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376880AbiEMDoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376863AbiEMDoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:44:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23D526CC67;
        Thu, 12 May 2022 20:44:06 -0700 (PDT)
X-UUID: 647fd9b2f359475ab7ec0a17021f233a-20220513
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:1b16f38e-b22d-47d1-bde5-7451d5c42553,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.4,REQID:1b16f38e-b22d-47d1-bde5-7451d5c42553,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:faefae9,CLOUDID:b21c25a7-eab7-4b74-a74d-5359964535a9,C
        OID:28d1a5955511,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 647fd9b2f359475ab7ec0a17021f233a-20220513
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1260386380; Fri, 13 May 2022 11:44:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 13 May 2022 11:44:01 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 May 2022 11:43:59 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <eddie.huang@mediatek.com>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <fshao@chromium.org>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <tinghan.shen@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <hsin-hsiung.wang@mediatek.com>, <sean.wang@mediatek.com>,
        <macpaul.lin@mediatek.com>, <wen.su@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v4] pwrap: mediatek: fix FSM timeout issue
Date:   Fri, 13 May 2022 11:43:56 +0800
Message-ID: <20220513034356.5268-2-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220513034356.5268-1-zhiyong.tao@mediatek.com>
References: <20220513034356.5268-1-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>

Fix pwrap FSM timeout issue which leads the system crash on GFX VSRAM
power on.
The crash log:
[ 3986.543401] mediatek-drm-dp 1c500000.edp_tx: drm_helper_hpd_irq_event
[ 3986.670756] vsram_others: is_enabled() failed: -ETIMEDOUT
[ 3986.670765] mali 13000000.mali: Power on reg 1 failed error = -110
[ 3986.670768] ------------[ cut here ]------------
[ 3986.670770] unbalanced disables for vsram_others
[ 3986.670783] WARNING: CPU: 7 PID: 4125 at drivers/regulator/core.c:2761 _regulator_disable+0x194/0x1a0
[ 3986.670785] Modules linked in: rfcomm algif_hash algif_skcipher af_alg veth uinput btusb btmtk btintel btbcm btrtl xt_cgroup bluetooth uvcvideo videobuf2_vmalloc ecdh_generic ecc mtk_vcodec_dec mtk_vcodec_enc mtk_mdp3 v4l2_h264 mtk_vcodec_common videobuf2_dma_contig mtk_vpu videobuf2_memops v4l2_mem2mem xt_MASQUERADE videobuf2_v4l2 videobuf2_common cros_ec_rpmsg mtk_scp mtk_rpmsg rpmsg_core mtk_scp_ipi ip6table_nat fuse 8021q iio_trig_sysfs cros_ec_sensors cros_ec_lid_angle cros_ec_sensors_core industrialio_triggered_buffer kfifo_buf cros_ec_sensorhub mt7921e mt7921_common mt76_connac_lib lzo_rle mt76 lzo_compress mac80211 cfg80211 zram r8152 mii joydev
[ 3986.670830] CPU: 7 PID: 4125 Comm: mali-cmar-backe Not tainted 5.10.78-CL2781499-v287 #1 b899b40a63da40d4767c6c0e96b6700d2f3eb242
[ 3986.670832] Hardware name: MediaTek Tomato board (DT)
[ 3986.670835] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
[ 3986.670838] pc : _regulator_disable+0x194/0x1a0
[ 3986.670840] lr : _regulator_disable+0x194/0x1a0
[ 3986.670842] sp : ffffffc016203a10
[ 3986.670843] x29: ffffffc016203a10 x28: ffffffb7c3186b28
[ 3986.670846] x27: 0000000000000002 x26: fffffffffffffdc8
[ 3986.670848] x25: ffffffc017225000 x24: ffffffb7c0e94880
[ 3986.670851] x23: ffffffb7c31840f0 x22: ffffffd6b4f3e275
[ 3986.670853] x21: ffffffb7c3181a00 x20: ffffffb7c27e7800
[ 3986.670855] x19: ffffffb7c27e7800 x18: 00000000ffff0a10
[ 3986.670857] x17: 0000000000000020 x16: 00000000000000ec
[ 3986.670860] x15: ffffffd6b44fa17c x14: 0000000000000003
[ 3986.670862] x13: 0000000000000004 x12: 0000000000fd8318
[ 3986.670864] x11: c000000100029ccd x10: 00000000ffffffff
[ 3986.670866] x9 : 7dd6d080afd6f400 x8 : 7dd6d080afd6f400
[ 3986.670868] x7 : 0000000000000000 x6 : ffffffd6b5459f0c
[ 3986.670871] x5 : ffffffc016203a58 x4 : 0000000000000000
[ 3986.670873] x3 : ffffffc016203668 x2 : ffffffc016203670
[ 3986.670875] x1 : 0000000100029ccd x0 : 0000000000000024
[ 3986.670878] Call trace:
[ 3986.670880]  _regulator_disable+0x194/0x1a0
[ 3986.670883]  regulator_disable+0x4c/0x8c

Add a usleep delay to avoid busy read for the H/W status.
If (time_after()) be turn first, it maybe cause the system behavior
crash problem like above. so we change it after sleep delay.

Fixes: 1f022d84bd19 ("soc: mediatek: Add PMIC wrapper for MT8135 and
MT8173 SoCs")

Signed-off-by: Zhiyong.Tao <zhiyong.tao@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 952bc554f443..f9e7c2f35157 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -4,6 +4,7 @@
  * Author: Flora Fu, MediaTek
  */
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -1197,10 +1198,13 @@ static int pwrap_wait_for_state(struct pmic_wrapper *wrp,
 	timeout = jiffies + usecs_to_jiffies(10000);
 
 	do {
-		if (time_after(jiffies, timeout))
-			return fp(wrp) ? 0 : -ETIMEDOUT;
 		if (fp(wrp))
 			return 0;
+
+		usleep_range(10, 11);
+
+		if (time_after(jiffies, timeout))
+			return fp(wrp) ? 0 : -ETIMEDOUT;
 	} while (1);
 }
 
-- 
2.18.0

