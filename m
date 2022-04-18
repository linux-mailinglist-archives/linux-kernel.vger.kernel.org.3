Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2195504F40
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbiDRLIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbiDRLIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:08:22 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FD413EAE;
        Mon, 18 Apr 2022 04:05:44 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id e22so10657980qvf.9;
        Mon, 18 Apr 2022 04:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HPUttj4kngshxe6tgSoij7Hk/MCoacGhY2Ysb5anUQU=;
        b=bNVqIeTJhXUKv7SROKyONwvaOF9eOB5ackpIHf/JM7ejwo+s0rpddHWyN0u7BmQL5N
         2tKUMTi6+A35MkpR3Ir1U/b1rlm68VVdZqxMgNSlPIpli6518tPzs5OaFGplP0PkHpy8
         V56uxiBvT4lQcdWcGr9yJTSyI4UfDrqSciiDdU+JJecJiFivOZ1bXJotVGaCvxstYouv
         /i9Vw9ybQBwSnxcyZYXKwMrUihc4W4wiSI0U9XRVVJssfxjzmn83BS1PI6fTUZk8aGec
         T0HW60dvfyqU4tJjA81/xUt+bZK0ZeldtejTSQ34/avyaaM6/Wr7f/RYBomiAxTz4nsp
         UfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HPUttj4kngshxe6tgSoij7Hk/MCoacGhY2Ysb5anUQU=;
        b=TyCSDNlM9fulGEDTplaRopNY4IJkn902FXdiKgZ/eYzjASqtjCiqPMn45cXga86AmP
         8MT9KbBi7rCwxW313oIjFNapOl6Xvk87tQIafOYdzSWXw78aCZi0M70ivslqD3WMd8VI
         7jMnmIdH33Oje0dBlDZLwXDBFYYXN2m7jFYoiXUarFkRmz+JFwv+qUFbqKvddbi1r3YE
         97OKEAstt1pIG4kQg+TxOpMFznUcHStkKWm5cH9zkfEc7k4jLANwhzqgf1T1nu6DrSss
         3apJ2AFRpNFdwmvL8X/K7mPTcQ0GSgvORqQp7JDSndLmRzSuCAIUlHkHF31C8axUc0Hc
         Zs4w==
X-Gm-Message-State: AOAM533/fsdmnZgsz3jVa2vsRl9AmblVF+1ZJKaMXfxCU0MkrtR757OH
        X1GN0ip/lTvdhBG8q/sz4XdkydXSy4A=
X-Google-Smtp-Source: ABdhPJwoxQ1cwLQXeEj76PhEnDL5f/1HxC5Ox2h9pUYvdXrJ/M841zaE58ZGLXSpluZ2nA4PKgI8PQ==
X-Received: by 2002:a05:6214:3006:b0:443:cf1e:58d7 with SMTP id ke6-20020a056214300600b00443cf1e58d7mr7517072qvb.53.1650279943356;
        Mon, 18 Apr 2022 04:05:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a76-20020ae9e84f000000b0069e80daa17asm2952482qkg.113.2022.04.18.04.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 04:05:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     clabbe.montjoie@gmail.com
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] crypto: sun8i-ss: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 18 Apr 2022 11:05:37 +0000
Message-Id: <20220418110537.2559328-1-chi.minghao@zte.com.cn>
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

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
index 246a6782674c..dd677e9ed06f 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
@@ -112,11 +112,9 @@ int sun8i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 		goto err_iv;
 	}
 
-	err = pm_runtime_get_sync(ss->dev);
-	if (err < 0) {
-		pm_runtime_put_noidle(ss->dev);
+	err = pm_runtime_resume_and_get(ss->dev);
+	if (err < 0)
 		goto err_pm;
-	}
 	err = 0;
 
 	mutex_lock(&ss->mlock);
-- 
2.25.1


