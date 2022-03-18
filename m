Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68E84DD799
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiCRKDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiCRKDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:03:36 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFA52EA91A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:02:17 -0700 (PDT)
X-QQ-mid: bizesmtp87t1647597713tmh93ghn
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 18 Mar 2022 18:01:47 +0800 (CST)
X-QQ-SSF: 01400000002000D0I000000A0000000
X-QQ-FEAT: tV/YCL8KvSigEojevuX8Z4ksKFjFwYMDDUbPH/+nVcU7UGmXSmpaGh5Fw2TTJ
        ijQgE8ge+s9vAMzDJ2oQSggoIqRj1D8rYiQVWISYIsQzywwW2GZY4boK0F509frGzxeSetM
        /YeeeSwqAc/FIlE/SWOjLFvAM1TXdkVQSWHNw9oGipU0RYnkbheHybma516x3Es1MGb2HGf
        nZy9DSHMivEJDGBc0sMUVL0+OPHNff0hPUvo4UIyGJj0LcN14XHH2iamuk0Jgf3KQLlDOUF
        NS4P4pwdT2GhiWXrVT8IjFfyrjWWgd1kT6jFUbR2t56wNPiQVjaSXZO/jLMTWZ5xhExWs1O
        XTUcae4Sxw1eeuY1t+yFgoFtai4KT4X8Lq+pOiBcM7kQ5XQD2s=
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     frattaroli.nicolas@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com, heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] ASoC: rockchip: i2s_tdm: Fixup config for SND_SOC_DAIFMT_DSP_A/B
Date:   Fri, 18 Mar 2022 18:01:46 +0800
Message-Id: <20220318100146.23991-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SND_SOC_DAIFMT_DSP_A: PCM delay 1 bit mode, L data MSB after FRM LRC
SND_SOC_DAIFMT_DSP_B: PCM no delay mode, L data MSB during FRM LRC

Fixes: 081068fd64140 (ASoC: rockchip: add support for i2s-tdm controller)

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 5f9cb5c4c7f0..f21296679bff 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -469,14 +469,14 @@ static int rockchip_i2s_tdm_set_fmt(struct snd_soc_dai *cpu_dai,
 		txcr_val = I2S_TXCR_IBM_NORMAL;
 		rxcr_val = I2S_RXCR_IBM_NORMAL;
 		break;
-	case SND_SOC_DAIFMT_DSP_A: /* PCM no delay mode */
-		txcr_val = I2S_TXCR_TFS_PCM;
-		rxcr_val = I2S_RXCR_TFS_PCM;
-		break;
-	case SND_SOC_DAIFMT_DSP_B: /* PCM delay 1 mode */
+	case SND_SOC_DAIFMT_DSP_A: /* PCM delay 1 mode */
 		txcr_val = I2S_TXCR_TFS_PCM | I2S_TXCR_PBM_MODE(1);
 		rxcr_val = I2S_RXCR_TFS_PCM | I2S_RXCR_PBM_MODE(1);
 		break;
+	case SND_SOC_DAIFMT_DSP_B: /* PCM no delay mode */
+		txcr_val = I2S_TXCR_TFS_PCM;
+		rxcr_val = I2S_RXCR_TFS_PCM;
+		break;
 	default:
 		ret = -EINVAL;
 		goto err_pm_put;
-- 
2.20.1



