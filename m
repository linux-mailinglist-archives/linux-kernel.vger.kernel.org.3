Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF254CA10B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240596AbiCBJpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbiCBJpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:45:05 -0500
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EAE580D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:44:20 -0800 (PST)
X-QQ-mid: bizesmtp77t1646214239t4q3lvu0
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Mar 2022 17:43:53 +0800 (CST)
X-QQ-SSF: 01400000002000C0G000000A0000000
X-QQ-FEAT: xyySF+ktKzc8o0sxazVfL1OaxjVY3Ht/nzDo91W+cec1vfOJK2+P94HZr5Ta2
        2svAAD6EXCc6FpllvhLHSRkQZSWQLRbN9BXofmljew6Fqk71bOe0o3qhGINLhBHZLOKgs1f
        PItROfzgeQocrtvNjXK9FeMRFGC3aSm94bNhe0iuFpY8sC2+KvAzGFWUO4yCfBC78dknjp7
        7jzOGJavoBZNNGBaK1PLhZ/Eu9SgloLY/UD4fouNLDcV8+o0A0iLmwentlUbnJfTo4bG3Lr
        Z7ee8MZMuCuzdZlY4bTSFCuRSoeBiaM6FT+mJRTES3g73bXsFJ3GrtP/6IvpkJmqYiO58AX
        A/9Paf8C8yoApWoQcUjU/QlLxKUwVYZNRBWC4BpRAHvpac8vJWPu8YSWYYvNg==
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] ASoC: hdac_hda: Avoid unexpected match when pcm_name is "Analog"
Date:   Wed,  2 Mar 2022 17:43:51 +0800
Message-Id: <20220302094351.3487-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcm name can be "Analog" and "Alt Analog", cpcm->name can be
"Analog Codec DAI" and "Alt Analog Codec DAI". When pcm_name
is "Analog", "Analog Codec DAI" and "Alt Analog Codec DAI" are
both satisfy the 'if (strstr(cpcm->name, pcm_name))' condition,
which may cause the returned cpcm to be "Alt Analog Codec DAI".

Even if we get the pcm name by id, and "Analog Codec DAI" goes
into the loop before "Alt Analog Codec DAI", but I still think
we'd better have multiple insurances against unexpected return
values. After, we can correctly return the expected result
even if other relevant places are changed.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/soc/codecs/hdac_hda.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 667f3df239c7..a9f61c7e44ee 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -363,8 +363,13 @@ static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
 	}
 
 	list_for_each_entry(cpcm, &hcodec->pcm_list_head, list) {
-		if (strstr(cpcm->name, pcm_name))
+		if (strstr(cpcm->name, pcm_name)) {
+			if (strcmp(pcm_name, "Analog") == 0) {
+				if (strstr(cpcm->name, "Alt Analog"))
+					continue;
+			}
 			return cpcm;
+		}
 	}
 
 	dev_err(&hcodec->core.dev, "didn't find PCM for DAI %s\n", dai->name);
-- 
2.20.1



