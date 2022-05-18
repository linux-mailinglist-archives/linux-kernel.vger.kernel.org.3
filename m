Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7FE52B28B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiERG0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiERGZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:25:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E21F10B4;
        Tue, 17 May 2022 23:25:50 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so1083232pjq.2;
        Tue, 17 May 2022 23:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qd6Bh43n9oT71nAgw+lLWasROian3bGolpDdPCo1434=;
        b=PbqgKlZC+Gzxht8k2Ga8KpfhYY5Sgu6xkl3Qsj58ccpA8HWtIweJFDpsVH9Uu4vXHH
         AxfbhaFZsZP0/IsnBd+ObknLQguo6VoP9Z8glWaGFe2fTKGhoh2slxvNoeHjN7zNxrqP
         R7yEuDj612zq+H3cEybMPapr5W/fcdhuPhIQq3BGixn3RzbvHqbX6C4QiHlkA/TTJAza
         tprZk1BdTAxKLLo4qsPeBQj1XStpn4tPyUgHwSs8tSS5q0SBZMWE6gDuHppOnTtvRsxY
         9K8kfcqm3dsk1jcnIGDFpeJX8s2S6wqYADJmgWsZ43y2r0L+qvKGtVSylksUCwXTiQTd
         7mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qd6Bh43n9oT71nAgw+lLWasROian3bGolpDdPCo1434=;
        b=lW9tT6qhGQxrZQVZFljURvaIjpLREPzf1+fd7tKK2PLiiofT8PFawp8heDHyYfwzSQ
         /Szzu6UAzo+kbyShXrRGdrQgTQStfGKn+PSkZ20YzCzAU3TUM1+/3Rx4WsQlW+voJ7Jw
         W/JmnI+xB/HZspqgNoGS8dfog0w0lOrJwYcg6kcabcKVMDHn9LJBbPRf0WVT+RFTZruL
         QjuECxoaUR6iTO5YGyJqc5ee64QIFDwCO3EXqK3q8Zlw2doaJI4pmYzGJVqE6gtNYsRN
         GxSZf+gJRWJV0QKEY9EYOFmleETm+FAgGvYSw692aY7eMkbJr+I6Bh+0C/88Z5+tx8j2
         1TGg==
X-Gm-Message-State: AOAM533DRiF4+IhbRq14474gmitGNCB/fdUIQ6eQWMiWNqi/5IkjAglS
        DEEtAJSPZqpxVxMFL6Jl+J93ceSf5jjJ6A==
X-Google-Smtp-Source: ABdhPJzpE22eWDu37ux4RIWPGFEFKfCByXA11S1eV7RsHyrX2a4pG60QazrfaEGCF5QDf9Sfx7hckw==
X-Received: by 2002:a17:903:2310:b0:15e:a944:aa52 with SMTP id d16-20020a170903231000b0015ea944aa52mr26024408plh.49.1652855149740;
        Tue, 17 May 2022 23:25:49 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709028f9500b0015e8d4eb210sm711341plo.90.2022.05.17.23.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 23:25:49 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     ulf.hansson@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] clk: ux500: fix a possible off-by-one in u8500_prcc_reset_base()
Date:   Wed, 18 May 2022 14:25:37 +0800
Message-Id: <20220518062537.17933-1-hbh25y@gmail.com>
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

Off-by-one will happen when index == ARRAY_SIZE(ur->base).

Fixes: b14cbdfd467d ("clk: ux500: Add driver for the reset portions of PRCC")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/clk/ux500/reset-prcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/reset-prcc.c b/drivers/clk/ux500/reset-prcc.c
index fcd5d042806a..f7e48941fbc7 100644
--- a/drivers/clk/ux500/reset-prcc.c
+++ b/drivers/clk/ux500/reset-prcc.c
@@ -58,7 +58,7 @@ static void __iomem *u8500_prcc_reset_base(struct u8500_prcc_reset *ur,
 	prcc_num = id / PRCC_PERIPHS_PER_CLUSTER;
 	index = prcc_num_to_index(prcc_num);
 
-	if (index > ARRAY_SIZE(ur->base))
+	if (index >= ARRAY_SIZE(ur->base))
 		return NULL;
 
 	return ur->base[index];
-- 
2.25.1

