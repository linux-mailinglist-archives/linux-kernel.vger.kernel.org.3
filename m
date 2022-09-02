Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA305AA514
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiIBBbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiIBBa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:30:59 -0400
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B4E61111
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:30:52 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowACn_y63XBFjwMtgAA--.5690S2;
        Fri, 02 Sep 2022 09:30:32 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     kuninori.morimoto.gx@renesas.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] ASoC: rsnd: Add check for rsnd_mod_power_on
Date:   Fri,  2 Sep 2022 09:30:30 +0800
Message-Id: <20220902013030.3691266-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACn_y63XBFjwMtgAA--.5690S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrykZw1ktF48Xw1DGryxAFb_yoW5WrWrpw
        4kCrWDWryfAa15u3Z5tr4kAF18uay8AFZxtr4F9w1xA3WxKryDWFn7tr15uF45Wryjkrya
        9FyDJrn8Cr1rt3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUOMKZDUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As rsnd_mod_power_on() can return negative numbers,
it should be better to check the return value and
deal with the exception.

Fixes: e7d850dd10f4 ("ASoC: rsnd: use mod base common method on SSI-parent")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v1 -> v2:

1. Add check for rsnd_mod_power_on in other files.
---
 sound/soc/sh/rcar/ctu.c | 6 +++++-
 sound/soc/sh/rcar/dvc.c | 6 +++++-
 sound/soc/sh/rcar/mix.c | 6 +++++-
 sound/soc/sh/rcar/src.c | 5 ++++-
 sound/soc/sh/rcar/ssi.c | 4 +++-
 5 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 6156445bcb69..e39eb2ac7e95 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -171,7 +171,11 @@ static int rsnd_ctu_init(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
 			 struct rsnd_priv *priv)
 {
-	rsnd_mod_power_on(mod);
+	int ret;
+
+	ret = rsnd_mod_power_on(mod);
+	if (ret < 0)
+		return ret;
 
 	rsnd_ctu_activation(mod);
 
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 5137e03a9d7c..16befcbc312c 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -186,7 +186,11 @@ static int rsnd_dvc_init(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
 			 struct rsnd_priv *priv)
 {
-	rsnd_mod_power_on(mod);
+	int ret;
+
+	ret = rsnd_mod_power_on(mod);
+	if (ret < 0)
+		return ret;
 
 	rsnd_dvc_activation(mod);
 
diff --git a/sound/soc/sh/rcar/mix.c b/sound/soc/sh/rcar/mix.c
index 3572c2c5686c..1de0e085804c 100644
--- a/sound/soc/sh/rcar/mix.c
+++ b/sound/soc/sh/rcar/mix.c
@@ -146,7 +146,11 @@ static int rsnd_mix_init(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
 			 struct rsnd_priv *priv)
 {
-	rsnd_mod_power_on(mod);
+	int ret;
+
+	ret = rsnd_mod_power_on(mod);
+	if (ret < 0)
+		return ret;
 
 	rsnd_mix_activation(mod);
 
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 0ea84ae57c6a..f832165e46bc 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -463,11 +463,14 @@ static int rsnd_src_init(struct rsnd_mod *mod,
 			 struct rsnd_priv *priv)
 {
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
+	int ret;
 
 	/* reset sync convert_rate */
 	src->sync.val = 0;
 
-	rsnd_mod_power_on(mod);
+	ret = rsnd_mod_power_on(mod);
+	if (ret < 0)
+		return ret;
 
 	rsnd_src_activation(mod);
 
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 43c5e27dc5c8..7ade6c5ed96f 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -480,7 +480,9 @@ static int rsnd_ssi_init(struct rsnd_mod *mod,
 
 	ssi->usrcnt++;
 
-	rsnd_mod_power_on(mod);
+	ret = rsnd_mod_power_on(mod);
+	if (ret < 0)
+		return ret;
 
 	rsnd_ssi_config_init(mod, io);
 
-- 
2.25.1

