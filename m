Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD8D4DACCA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354599AbiCPIrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346253AbiCPIrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:47:45 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17FC63BFA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:46:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id t5so3108725pfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=o2a1XLIA6SCc0OXj4X5fM3NulfHLBIGjv/KhHaIx6PQ=;
        b=GNDL68UBBmY9vm3mPI6hh9CD2lRNaMjHpLpzwJYp4vN18zMrNfL27bTXmeAheLjH7Z
         ecZl5cZJ34sM/UeT0NIJxgjzQOAw/qlejEiRiv1+pBxV9tsO461LciCvRpMAE2cgajjU
         z830dTGPQ+ZAvvyzvy1Pc6UbLiLN4rDNupCRklX8g1Y4zE/SKTxak6T8hbT/v4ZMp5+G
         7C56/ec+oJnQXcXHzmPbWmj0/RrwPCU9g+oQa37G6Uc0V7OIwplZH4PiV5Amn5HO9P+F
         qKbi3nrAxG9LnsTuVdfE069vEEzlbTr+1ysYmMF0qoA+svztQ6fDMkHJcE4m6sXMmDEc
         fueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=o2a1XLIA6SCc0OXj4X5fM3NulfHLBIGjv/KhHaIx6PQ=;
        b=rbOxMdaDtFvLL9s38Sk99rgh+cnZn3mQCk7rM5VtipZCxu1Dp63S1HMYzrqzHH2N6G
         QNhXzbw1jUtY7ynAElrMeRc+Fw8Mlg4fic+OvpIV7V8jPJs2wYe8Pygdl9MvzqN+n7c1
         oTCirj50grdkfIgpLWkJDb3uzMoQcCmPZGUDz1mkLuAyjNIbor1D80vfyKm7lvfKu6wq
         Xab26p0n+lTcy3aksPglduJREnXvNjSCojw147stIKm+/aEJ4Clj73T897Aw9FbhF+tw
         b3XeghGPE4Refl6i21r3n6OEb5YXeL4wPVSb60w7LjIzY9nCyUvlM5yTaJRLLYdFbiMH
         BYSg==
X-Gm-Message-State: AOAM531EobMU5pKQX4GTRjSaqwDYY3NMNXUItcXI1iJ/BvYSwMMI5jl5
        VC/QGhGSSnlifwsjHSaPPWk=
X-Google-Smtp-Source: ABdhPJwcB/cDd4LmceuZ9xTWzG6XnUJNJeFpS8VorH67V1q4Tm8M7vPqz5CjVnvFBNjLjZwice/4BA==
X-Received: by 2002:a63:5751:0:b0:381:4050:143a with SMTP id h17-20020a635751000000b003814050143amr10698013pgm.410.1647420391500;
        Wed, 16 Mar 2022 01:46:31 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id l10-20020a056a00140a00b004c55d0dcbd1sm2055283pfu.120.2022.03.16.01.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 01:46:31 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        YC Hung <yc.hung@mediatek.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Bixuan Cui <cuibixuan@huawei.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mediatek: mt8195: Fix error handling in mt8195_mt6359_rt1019_rt5682_dev_probe
Date:   Wed, 16 Mar 2022 08:46:15 +0000
Message-Id: <20220316084623.24238-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.

This function only calls of_node_put() in the regular path.
And it will cause refcount leak in error path.

Fixes: 082482a50227 ("ASoC: mediatek: mt8195: release device_node after snd_soc_register_card")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
index 29c2d3407cc7..e3146311722f 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
@@ -1342,7 +1342,8 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 					      "mediatek,dai-link");
 		if (ret) {
 			dev_dbg(&pdev->dev, "Parse dai-link fail\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto put_node;
 		}
 	} else {
 		if (!sof_on)
@@ -1398,6 +1399,7 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 
+put_node:
 	of_node_put(platform_node);
 	of_node_put(adsp_node);
 	of_node_put(dp_node);
-- 
2.17.1

