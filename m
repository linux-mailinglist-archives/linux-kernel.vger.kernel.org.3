Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDFE53B436
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiFBHSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiFBHSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:18:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C077F30C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:18:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c2so3826876plh.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 00:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R8Jzvn4KoI6zyaEC1swBdZnPsmFAJHlige3FcDhZ5Gc=;
        b=Pa6M1iUSEgtHJ+P+TN+zX25lnv33UQYDykQS3F4wk/IJGJiTEko4StIiyBUDfX6R9h
         0HQ59fKfvhydM/hJNnbaDRhY0ixmiF5JhHncDLI+ULMSAdzx/p8ABC1ljPS3Pg1z6ozq
         LhVo9hfZpmU7ELx+hRRzC1s7vs+mahvAJ+bQP06on8d9T94WFtW2CQLqBNA5seEasxPo
         YcT2U36KTqMtQzlZYzLh4/dYrXGMap+jYzbIfeed8TC6+MG7zpEsfxq6RE6T1UR9vhjR
         pyQHjiGHMgbfnTajE1Ae4ztnJyZUj9w3wwNk2X2fH1jfA6GV0NlnGKXluRkLluyDUo+P
         o1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R8Jzvn4KoI6zyaEC1swBdZnPsmFAJHlige3FcDhZ5Gc=;
        b=hDRWj32wdqtd4bLAp9zufYeedTumQdkA8jTKZLCrW38JjNMJjmUU+jgLdZgohxGxds
         ngG1Y2liosFCeQxcjxFt7MakcNUODDLPFVM2ZOY28EpIVnj3wjxAOnKED/Lzsb2qPSV/
         m8pDIvWLeB9MIYCrBACh0oBefOSe9nPfocTeJPc/PEtFNjJLQhxoLnNUv03t5y6zpEg6
         6sW+7lGRLK2JRaQpazSix/AsTSPnJFLRaJHTaXlV7ZbZXQoeVd4fAEgV4UwiHX1yCG4U
         AO8gHaDMrm6H/l2tKnIEgJunOWh6EmZy1qcrexO3VlcQxEj6qgUytTyCjk5SCiGhn0AA
         L1sg==
X-Gm-Message-State: AOAM533r5hI238pJ29/+D+H/l78UMQUT4KknLzkRlGcmfn0enoiueibY
        Mq+EMj9hmkpEXZGdSy6+Bv0=
X-Google-Smtp-Source: ABdhPJwCF9zgTxD8Jpl1zz1KmAQnvxwxZhmFVGBpKn7FmZfjlKFdV7MDWp00dul1ao9oGPCp7+0XJQ==
X-Received: by 2002:a17:902:c952:b0:162:14b6:3179 with SMTP id i18-20020a170902c95200b0016214b63179mr3390242pla.7.1654154293331;
        Thu, 02 Jun 2022 00:18:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b5-20020a1709027e0500b0016353696f46sm2741624plm.269.2022.06.02.00.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 00:18:12 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: mediatek: remove unnecessary check of clk_disable_unprepare
Date:   Thu,  2 Jun 2022 07:18:09 +0000
Message-Id: <20220602071809.278134-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Because clk_disable_unprepare already checked NULL clock
parameter, so the additional checks are unnecessary, just remove them.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 31494930433f..dcaeeeb8aac7 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -286,10 +286,8 @@ static int mt8173_afe_dais_set_clks(struct mtk_base_afe *afe,
 static void mt8173_afe_dais_disable_clks(struct mtk_base_afe *afe,
 					 struct clk *m_ck, struct clk *b_ck)
 {
-	if (m_ck)
-		clk_disable_unprepare(m_ck);
-	if (b_ck)
-		clk_disable_unprepare(b_ck);
+	clk_disable_unprepare(m_ck);
+	clk_disable_unprepare(b_ck);
 }
 
 static int mt8173_afe_i2s_startup(struct snd_pcm_substream *substream,
-- 
2.25.1


