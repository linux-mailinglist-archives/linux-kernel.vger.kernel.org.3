Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095084CA19F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiCBKBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbiCBKBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:01:19 -0500
X-Greylist: delayed 8257 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 02:00:33 PST
Received: from smtpbg506.qq.com (smtpbg506.qq.com [203.205.250.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D84E5EBFD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:00:32 -0800 (PST)
X-QQ-mid: bizesmtp77t1646215227tx88lfbo
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Mar 2022 18:00:22 +0800 (CST)
X-QQ-SSF: 0140000000200060D000B00A0000000
X-QQ-FEAT: HoyAXBWgskmYdSdyebFBiWjxCytgNey9Aae4l7NvKJrtYf/1UqQ8fM1QK4I+m
        CbnWyd2+7bCShdqhan+VzGSRt+cMuQ2hVE19BLeF2n45eNFGihIMAT+Sy7/thMyeEbKosPT
        IiZpZb1oudFqlhNFHxRlSdmvheplHNsHZQNEG/ogqtjB2cT0C2vJOFJ0282dCG77/IUJGl6
        Cs+io3wd/sccnIac73X2G26JYwDYkyvme7CbhDqZ9KasJDw0u0CS+0cWOyl+vx9yJVQq7YT
        puhiPsxy+48QtjG2NuaK9gkEnDdbaK/q/sthFOqyJPRcEqPfxHpS6ywrzpJT83xyh/4KI+d
        QD1RaflZwBBf1VSYEaJMwoIm8pNR1g/vYJ3cyTYn8kMbrE7yvc=
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     frattaroli.nicolas@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] ASoC: rockchip: i2s_tdm: fix runtime pm imbalance on error
Date:   Wed,  2 Mar 2022 18:00:19 +0800
Message-Id: <20220302100019.22891-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync() increments the runtime PM usage counter even the
call returns an error code. Thus a pairing decrement is needed on the
error handling path to keep the counter balanced.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 5f9cb5c4c7f0..4691a76b499d 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -1739,8 +1739,10 @@ static int __maybe_unused rockchip_i2s_tdm_resume(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(dev);
 		return ret;
+	}
 	ret = regcache_sync(i2s_tdm->regmap);
 	pm_runtime_put(dev);
 
-- 
2.20.1



