Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD945599756
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347602AbiHSIUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347781AbiHSIU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:20:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E7DE9AA4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:20:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso4206499pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Ho4m4En4HK++bOeuu6JBS98B/wcraAxdFHe8jNgAOJs=;
        b=PQ5AgKpq4YGS+6ESKbpyvGcUN9wAUX8cJ9Q+bcsd6Vg1A2pFGHNbAeSqmLwA2YYEXh
         W7hYhXZxfKbRCJMi3aoPuZC4Y7R5VBsB56vP8hW3DCl1QNurr/K882916BX1aDhFtZ4R
         kUMnAicYJog5vymfWi6V/FUDxJsxJ9Ygt7smzBUu9RBedCoMx7f1NWakttbMu/FfCAvD
         LT6oqwgrD/0AQa5yFplU78hMq7L9KOd3Pb7Kx5MudaC4Zl4RB7bsTWD3Q0znLFshkjLY
         1eT4CKQ5Os9Lm/BYzMmIbZkBpV6regXM7X98VZ47wLR/UcsZeasEtnRgdB2eK3HW2h0U
         NQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Ho4m4En4HK++bOeuu6JBS98B/wcraAxdFHe8jNgAOJs=;
        b=yIKU6TmlyFxfFZH6u2QGQHeX5WPrp9QL3djZDzDGbgeEo6M7ZsQXPFJVANiQjv88sM
         BsgS6X7qhipvlN3k+ro8VbdFbm3UiKGpagDCS7SgKy6MrMUNR83jJ/ze0144o3B730ws
         6ulF5DMaBVa99Sqv+KElmtZPYOPoSeCpDb/qiM1XjaW8LE+OgVvlVIVn/mYnABeLDOj8
         Y1FK7PJqkfaztarp7pkaNdKy8+j+FSzdFBV4hZUnWV6x75NghyiVkbLBhZO5HQpsHOho
         CCKHKF9EG5JCNotoPcbHHX0QqEW6srkb7htGhlhe6V6Ea74L6AXSkJC7XW0qD4uokrl3
         sfvw==
X-Gm-Message-State: ACgBeo1tMQpdYs/MmXXi9f0QM5TitISTBtb7AopM/CSmPXvC7NbTuH+h
        rjfiMEBWB5IWwKDhaNEr6hV05INrCOI=
X-Google-Smtp-Source: AA6agR7LG4s9kQjz1Rli7BDQSzybZnwFz4MNgYA2WcXPRgKgSXJQFcn8NX3/Q4Ohuxwq3uXGAdrcnQ==
X-Received: by 2002:a17:90b:4b05:b0:1f5:b530:af6b with SMTP id lx5-20020a17090b4b0500b001f5b530af6bmr13045826pjb.150.1660897218771;
        Fri, 19 Aug 2022 01:20:18 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090301ce00b00171311470eesm2667943plh.8.2022.08.19.01.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:20:18 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     chi.minghao@zte.com.cn
Cc:     linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] qnx6: delete unnecessary checks before brelse()
Date:   Fri, 19 Aug 2022 08:20:15 +0000
Message-Id: <20220819082015.96476-1-chi.minghao@zte.com.cn>
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

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus remove the tests which are not needed around the shown calls.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 fs/qnx6/super_mmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index d282c2c73404..26854f1356d6 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -141,9 +141,7 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 	return sbi->sb;
 
 out:
-	if (bh1 != NULL)
-		brelse(bh1);
-	if (bh2 != NULL)
-		brelse(bh2);
+	brelse(bh1);
+	brelse(bh2);
 	return NULL;
 }
-- 
2.25.1
