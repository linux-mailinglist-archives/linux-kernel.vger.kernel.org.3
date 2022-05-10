Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A703B521EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345938AbiEJPis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346047AbiEJPh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:37:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3CE1D5275
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:33:43 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 204so12448323pfx.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDdu0AZ+jhN6LtNsF/DsY4tnnS9mzbYgTFP2SBX4foc=;
        b=DjyipPBYQ6Mz0BJ2YvmmPz0cPF4YSA0a+fMtYgqkJ77LqbIEqTP2yuaOxzXI8J7Puz
         YzVfttMONRDIJC1uBKKFmiOMdzXhIY9xzklKp1v6OLrinXC4FwDdGdvem9IooJboBvQy
         GK3dj2Q+gZYRcoEU7Z7AiRFj/wT5y5HMn74dI7mKWcCAPxzbxqc3nUTTc71NsoQZPHgZ
         jysRaf4Dr0FqZBFsUbvMJw3fhoye8auxXOIELHpDwhvf02EHOeW5Hk0Jq5xfIZZk+ghD
         6oQdmho2n+LrTWDfHjY0tktn7MLxE9rfJyCILgySVpSsBEMTM2+WKb/gJpGdMt1NhQz/
         LdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sDdu0AZ+jhN6LtNsF/DsY4tnnS9mzbYgTFP2SBX4foc=;
        b=xMO04qA3ohBHg79TE+UeEyVMxbQLNtFB1Ri6FnarLlHH+KNs2CMeCpRpfFzfusiw+R
         Lj2vjsAHL2SbatYHCQ1xlDe/oOKnx8Kya4QmKKmMIp+GCezHeq415fplLRdb6FyTLJOl
         qCilNJWBaTS+Ye6OOFK12TgnKecHpPMIdC9dHvaX+5jDdqvN2m4InEKQtG1ClqTxwDAN
         ackI/CXncE/AcMDgEVyDq2SDDePce6rjhJdyAvitKydS9NlRK4ahVLcAgfGlP66CQ3Lu
         /NIp4bFj7jMHWP1rM5Go/9DTvmWJgjnVUdQSEB/ENojeJ6cwIsyPegAw1tcwGoEOV+D9
         wpKA==
X-Gm-Message-State: AOAM533LPEBlk8+fz/5TIz/J53apfHlUe71V2O88IV/2ug6y+SBEV77M
        ZwMfv797Z/fB75PpN+d/Wg==
X-Google-Smtp-Source: ABdhPJw4MmnXegA0D1ntyoBvAJlyQNEK5XXB9HZ+vF5ceB7uq8uJuv4AGpKomxKh2ohAEsSAha8rIQ==
X-Received: by 2002:a63:fd51:0:b0:3c1:977e:1fed with SMTP id m17-20020a63fd51000000b003c1977e1fedmr16894976pgj.246.1652196822757;
        Tue, 10 May 2022 08:33:42 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id cd10-20020a056a00420a00b0050dc76281d0sm11104248pfb.170.2022.05.10.08.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:33:42 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, rf@opensource.cirrus.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, oder_chiou@realtek.com
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 4/6] ASoC: tas571x: Fix the error handling of tas571x_i2c_probe()
Date:   Tue, 10 May 2022 23:32:49 +0800
Message-Id: <20220510153251.1741210-5-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510153251.1741210-1-zheyuma97@gmail.com>
References: <20220510153251.1741210-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After enabling the regulator, The driver should disable the regulator
when failing at probing.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 sound/soc/codecs/tas571x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index dd289774efb2..7b599664db20 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -833,7 +833,8 @@ static int tas571x_i2c_probe(struct i2c_client *client)
 	if (IS_ERR(priv->pdn_gpio)) {
 		dev_err(dev, "error requesting pdn_gpio: %ld\n",
 			PTR_ERR(priv->pdn_gpio));
-		return PTR_ERR(priv->pdn_gpio);
+		ret = PTR_ERR(priv->pdn_gpio);
+		goto disable_regs;
 	}
 
 	priv->reset_gpio = devm_gpiod_get_optional(dev, "reset",
@@ -841,7 +842,8 @@ static int tas571x_i2c_probe(struct i2c_client *client)
 	if (IS_ERR(priv->reset_gpio)) {
 		dev_err(dev, "error requesting reset_gpio: %ld\n",
 			PTR_ERR(priv->reset_gpio));
-		return PTR_ERR(priv->reset_gpio);
+		ret = PTR_ERR(priv->reset_gpio);
+		goto disable_regs;
 	} else if (priv->reset_gpio) {
 		/* pulse the active low reset line for ~100us */
 		usleep_range(100, 200);
-- 
2.25.1

