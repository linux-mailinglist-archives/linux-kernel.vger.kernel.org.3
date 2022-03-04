Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BEF4CCAEA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 01:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbiCDAqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 19:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiCDAqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 19:46:35 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18F415DB35
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 16:45:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V69clCD_1646354745;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V69clCD_1646354745)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 04 Mar 2022 08:45:45 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        tangmeng@uniontech.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v2] ASoC: amd: Fix an ignored error return from platform_get_irq_byname()
Date:   Fri,  4 Mar 2022 08:45:43 +0800
Message-Id: <20220304004543.11797-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return from the call to platform_get_irq_byname() is int, it can be
a negative error code, however this is being assigned to an unsigned
int variable 'adata->i2s_irq', so assign the value to 'ret' concurrently
to solve this problem without affecting other functions.

Eliminate the following coccicheck warning:
./sound/soc/amd/acp/acp-renoir.c:286:5-19: WARNING: Unsigned expression
compared with zero: adata -> i2s_irq < 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 3304a242f45a ("ASoC: amd: Use platform_get_irq_byname() to get the interrupt")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

--Changes in v2:
Report the error code is being returned rather than squashing it down to -ENODEV.

 sound/soc/amd/acp/acp-renoir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index 738cf2e2b973..21e5c9744784 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -282,9 +282,9 @@ static int renoir_audio_probe(struct platform_device *pdev)
 	if (!adata->acp_base)
 		return -ENOMEM;
 
-	adata->i2s_irq = platform_get_irq_byname(pdev, "acp_dai_irq");
-	if (adata->i2s_irq < 0)
-		return -ENODEV;
+	adata->i2s_irq = ret = platform_get_irq_byname(pdev, "acp_dai_irq");
+	if (ret < 0)
+		return ret;
 
 	adata->dev = dev;
 	adata->dai_driver = acp_renoir_dai;
-- 
2.20.1.7.g153144c

