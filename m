Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDDD521EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242851AbiEJPin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346042AbiEJPhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:37:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA8113CA0A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:33:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x23so15234080pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUdUcfiagybpsQd1lg5V2fMeg0EXQcI6829QJGv7lks=;
        b=QvY4Ezq+fW8krO2OWe5Wx3kco/r+crV5eM0nwCM02Ofn4Qg7Qa2uUWgmNMxQvf5GzW
         3CzrriRzkyIZP7KTfQXKpPH9KBtIOOG+se2tgtqH2+kiz+C3iWntyhUedg7hWyIz8SVn
         CR5CehLZ40IueILzP+w0dBR9okD5t4jqeBp1EDIFQ/5nNqsRQGQ8VEAiTzcqzyxV7lYh
         MVfjVZJGo2NFi/rVHK8xAmFW/go+ywwLx8oT3BCVmYdwYXrhT4+aO9JMjp8b5ZjkemnO
         MDvf3sHPZt94kiWUkzQ2CB5ZDwFdU1ioPbjUkZBZrd41klzat64x5r/Ow1WM8drWNvBR
         zffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUdUcfiagybpsQd1lg5V2fMeg0EXQcI6829QJGv7lks=;
        b=qSKR0s1lK/pjX4lzwPEtXoo/xw7YpoqLAiv0vc/NLbem4kkjWGwZC6U6NAH0ic7IeZ
         hTPGa+SdbN6P+Mbxz00ogZ8Vg82gJLudWiqHCf4xM7kmE+XAoVF+noQIpKv6EWh24hLy
         TDc/CNLBM4hyXykYnWrsEQ1amjAF6JGDx7NdetVexH/MrNfUIbC7xHYSCfCpFOXGyJOp
         FwOET6GEfMpwdc0E8vZzzg8Qmpo/9lBMzyMy9YxBjnYxE0L8YEV4WtFBgsEq5a/bSyXX
         5MZRxQIdb1roogvqKyNidMFQdq5bktp+Sdudnj/AclreZ1Mi4CTQl4C103SgCKvgeA+X
         jcvw==
X-Gm-Message-State: AOAM5333Uyn6vHjmd/WiiLZ+ncD3NFXFxJ90x+1crcSRiVpOwqhCVwbL
        wnLVdlsFRLvKIXIIUu+C9g==
X-Google-Smtp-Source: ABdhPJz6N6qu89EDF0qEJaevMwCr86YbRgvjBFpTUFU7LzuQoM3gKa7lp4Q1bFnsxtUTB5NhIbzAfg==
X-Received: by 2002:a62:d0c5:0:b0:50d:a467:3cc8 with SMTP id p188-20020a62d0c5000000b0050da4673cc8mr21129069pfg.81.1652196814749;
        Tue, 10 May 2022 08:33:34 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id cd10-20020a056a00420a00b0050dc76281d0sm11104248pfb.170.2022.05.10.08.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:33:34 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, rf@opensource.cirrus.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, oder_chiou@realtek.com
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 3/6] ASoC: rt5645: Fix the error handling of rt5645_i2c_probe()
Date:   Tue, 10 May 2022 23:32:48 +0800
Message-Id: <20220510153251.1741210-4-zheyuma97@gmail.com>
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
 sound/soc/codecs/rt5645.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 1518eb7e9201..ccdea234a3ba 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3943,7 +3943,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c)
 		ret = PTR_ERR(regmap);
 		dev_err(&i2c->dev, "Failed to allocate temp register map: %d\n",
 			ret);
-		return ret;
+		goto err_enable;
 	}
 
 	/*
@@ -3974,7 +3974,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c)
 		ret = PTR_ERR(rt5645->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
 			ret);
-		return ret;
+		goto err_enable;
 	}
 
 	regmap_write(rt5645->regmap, RT5645_RESET, 0);
-- 
2.25.1

