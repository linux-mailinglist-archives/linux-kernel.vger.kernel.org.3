Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDCD507F46
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348853AbiDTDFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbiDTDFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:05:11 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2ED39172;
        Tue, 19 Apr 2022 20:02:26 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id y129so370258qkb.2;
        Tue, 19 Apr 2022 20:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KavF0KS5KLJOY2dExE8lwinSJ4LN/Ebtbb6yL/bzNzQ=;
        b=HUVQ9hYwgHZNg5WnRMOni56Ap1MZ70xEe/27UfralAfuzxuhGwVEV7sWnzKU7PE4VI
         mnKA/Syzu4UHEK8i3A3VZhFq4N884cadqvoFjq9hasIXcxROpbhLDufXszewlNUNUprm
         SC2zMIdzeDG70E8tfF8MaTn9yYZ+ux+BVsWNxDqT/iWCu961dXsxBo8lhVnJVGd+LblU
         T6NZM6wNYsriaZFLgU0RhtFvlK0We6tBHyraDAUTUpXFAIzwmBOy+3j6uB9PUncT1aYG
         pq1v1yQmpd/dhl8kM2xtD7kbhDfM/EB6D63MeBdhvRcguPoJqzVO0LTfo5DlVs2IP3ZV
         y4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KavF0KS5KLJOY2dExE8lwinSJ4LN/Ebtbb6yL/bzNzQ=;
        b=GZ5i7hnWOO+0DMuF88CEewbTUsFzj6oG5bMH4Pl+K0sAvI9lqGPEaajGqYGZvqTM1r
         x5xzfm3KHufMkUqGHrQrgDLnkh0MMiCpmpmg0TWEuHfSwDkBUge+AHOb6E0eRTkDhX59
         KRFh94w2tkLPs9+xqUmKuJ1GxxZJ/4GN8IrYyiJLYwGB2j6+ceIxRIPa6CJ/50y5fUgj
         DoTwbgk49LhpibXoP/ysnm/GvJcOLH+KoTozGZrYbDbLIvVyZPC0YKTuT+CH0tV1inlz
         YhROBGS6Rj16uyPXUAxCV6TdJVazFZvdtsOGiKjNkydJSNyDoc44Py9GsZG6yn1nq5yn
         Blbw==
X-Gm-Message-State: AOAM532FGI+MVmZA3byEu3f5D+5mFkStwqX3kQitYUx19LeRhlIK5kFV
        L/0yHhSOxjx5mCNSGsYJ1tU=
X-Google-Smtp-Source: ABdhPJze4x0EooB6fj4coS6yKRAfPwsXGsHPWMbc2mEf9a1fZVmbOKI/UVTTi1Cheg3zVUKCLBbzEw==
X-Received: by 2002:a37:88c2:0:b0:69b:f243:b5c7 with SMTP id k185-20020a3788c2000000b0069bf243b5c7mr11102150qkd.758.1650423745722;
        Tue, 19 Apr 2022 20:02:25 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q139-20020a37a791000000b0069e88513517sm947132qke.91.2022.04.19.20.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 20:02:24 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     clabbe.montjoie@gmail.com
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] crypto: sun8i-ce: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Wed, 20 Apr 2022 03:02:18 +0000
Message-Id: <20220420030218.2575565-1-chi.minghao@zte.com.cn>
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

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
index b3a9bbfb8831..b3cc43ea6c8a 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
@@ -108,11 +108,9 @@ int sun8i_ce_prng_generate(struct crypto_rng *tfm, const u8 *src,
 		goto err_dst;
 	}
 
-	err = pm_runtime_get_sync(ce->dev);
-	if (err < 0) {
-		pm_runtime_put_noidle(ce->dev);
+	err = pm_runtime_resume_and_get(ce->dev);
+	if (err < 0)
 		goto err_pm;
-	}
 
 	mutex_lock(&ce->rnglock);
 	chan = &ce->chanlist[flow];
-- 
2.25.1


