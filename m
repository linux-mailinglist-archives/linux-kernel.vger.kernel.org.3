Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B4E521EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345984AbiEJPiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345877AbiEJPhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:37:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F3E8FD76
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:33:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m12so3322003plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eag9/N12Mu3KYJJ0B0WDBdKQD2EGzDc2Cj2dmt69sIg=;
        b=hlIhyjXWWaS429dekFzsxpoSrs74VJmufWGmWV5tWMWylXvaSzSNiV8KwCOJCJl/ms
         5lbySympGAvbFfBejHNe6TUiO8nLo944xo9TetryJDHFoNW1CJ6DqnyFORYry4nd86QB
         OtqaS3H4VNJoR7k1pLVLtc46D3wHeTIp50VOuCZdQYksAwdjKdu1uddenfl+8+/oe0nK
         YfCSxtVHXQDP1BZMTP4/zxV3ObVeZkmYfe9kmg43VpNd9v2sdxTyCDMWMCSqhP8jUk1F
         +FvfwoIdU0wwxnS9G8SWQNXjAjVvpDfTRT/2ZApNxpAAdnWZIkEsAyiM5DMReiwzC8we
         8lbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eag9/N12Mu3KYJJ0B0WDBdKQD2EGzDc2Cj2dmt69sIg=;
        b=zkgozzIxncoo/dTYFwl9U/aFlv4daAWXRltnZqREdfM1uA1umDVuujnjx1BqYVKY4x
         U42wq69TS4p6igwIHr6KLJbgiCUQ2+umJ2MAnBWFibdKas92JEJMTxCDxbp+J8dpwOWT
         fuXvlOKnZeNaBXu59p1xKoHnX37sZBj3qgi0o5vupUfuJoTzD32p4cHNthjktc/V4Jr7
         RMrusKgz9+sWKa7FosslScEgoNiyczx6rW4yZcdbsT+OT13dulGC4xsiCDvymKTi4y+O
         EOG+R7lfeWSh38XVq5BJSK4y7vLZM2y8+4ODRMveV9YelqLARaJIGN/yMjDG8qZwjSoz
         cj8w==
X-Gm-Message-State: AOAM530B+R5+gaGuYXunOSdEbhwyLxfNIpoG8E8jhJNq4hiFIuayZb02
        eQbosDgSW/2nddHqGrOqFg==
X-Google-Smtp-Source: ABdhPJxFNiE/WgSKaJPA7RFpU5aiK16uBpllXCpM3cyKm0NYEOM3FXJtOGT7rNWzr+Vz36Pu6iKMpQ==
X-Received: by 2002:a17:902:edc7:b0:15b:4196:1957 with SMTP id q7-20020a170902edc700b0015b41961957mr20688090plk.161.1652196806644;
        Tue, 10 May 2022 08:33:26 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id cd10-20020a056a00420a00b0050dc76281d0sm11104248pfb.170.2022.05.10.08.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:33:26 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, rf@opensource.cirrus.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, oder_chiou@realtek.com
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 2/6] ASoC: cs35l36: Fix the error handling of cs35l36_i2c_probe()
Date:   Tue, 10 May 2022 23:32:47 +0800
Message-Id: <20220510153251.1741210-3-zheyuma97@gmail.com>
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

The driver should goto label 'err' when failing at regmap_read().

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 sound/soc/codecs/cs35l36.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
index cc5e80222916..920190daa4d1 100644
--- a/sound/soc/codecs/cs35l36.c
+++ b/sound/soc/codecs/cs35l36.c
@@ -1803,7 +1803,7 @@ static int cs35l36_i2c_probe(struct i2c_client *i2c_client)
 	if (ret < 0) {
 		dev_err(&i2c_client->dev, "Failed to read otp_id Register %d\n",
 			ret);
-		return ret;
+		goto err;
 	}
 
 	if ((l37_id_reg & CS35L36_OTP_REV_MASK) == CS35L36_OTP_REV_L37)
-- 
2.25.1

