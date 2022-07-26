Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512AA5809CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 05:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbiGZDHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 23:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiGZDGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 23:06:54 -0400
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CCD29CBF;
        Mon, 25 Jul 2022 20:06:52 -0700 (PDT)
Received: from amadeus-VLT-WX0.lan (unknown [113.118.189.34])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 77CCD80008D;
        Tue, 26 Jul 2022 11:06:50 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 2/3] soc: mediatek: update power domain data of MT7623A
Date:   Tue, 26 Jul 2022 11:06:20 +0800
Message-Id: <20220726030621.7555-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726030621.7555-1-amadeus@jmu.edu.cn>
References: <20220726030621.7555-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGhkZVhpPHxpITh1MHRoZSFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKSFVKSkNVSkNCVUhPWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAw6MDo5LD06ME4SCU84Ny06
        KCEKFBxVSlVKTU5DQ0tPQ0pKSkpCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
        SFVKSkNVSkNCVUhPWVdZCAFZQUhOTEg3Bg++
X-HM-Tid: 0a823878b404b03akuuu77ccd80008d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running OpenWrt on MT7623A, I receive a kernel
warning as follows (Device dts using mt7623.dtsi):

mtk-scpsys 10006000.scpsys: Failed to power on domain mfg
WARNING: CPU: 0 PID: 1 at drivers/soc/mediatek/mtk-scpsys.c:457 0xc04a4130

When I switch the device dts to using mt7623a.dtsi,
the system fails to boot:

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 0-...0: (0 ticks this GP) idle=146/1/0x40000000 softirq=53/53 fqs=1051
 (detected by 1, t=2102 jiffies, g=-1111, q=18)
Sending NMI from CPU 1 to CPUs 0:

Solved the problem by duplicating the power domain of
the MT7623 (except MFG) to MT7623A, the system works
fine without kernel warnings/errors.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 drivers/soc/mediatek/mtk-scpsys.c | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index ca75b14931ec..8b5713db1ca3 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -910,6 +910,41 @@ static const struct scp_domain_data scp_domain_data_mt7623a[] = {
 		.clk_id = {CLK_NONE},
 		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
+	[MT7623A_POWER_DOMAIN_VDEC] = {
+		.name = "vdec",
+		.sta_mask = PWR_STATUS_VDEC,
+		.ctl_offs = SPM_VDE_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.clk_id = {CLK_MM},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT7623A_POWER_DOMAIN_DISP] = {
+		.name = "disp",
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = SPM_DIS_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.clk_id = {CLK_MM},
+		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_MM_M0,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT7623A_POWER_DOMAIN_ISP] = {
+		.name = "isp",
+		.sta_mask = PWR_STATUS_ISP,
+		.ctl_offs = SPM_ISP_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.clk_id = {CLK_MM},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT7623A_POWER_DOMAIN_BDP] = {
+		.name = "bdp",
+		.sta_mask = PWR_STATUS_BDP,
+		.ctl_offs = SPM_BDP_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.clk_id = {CLK_NONE},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
 };
 
 /*
-- 
2.25.1

