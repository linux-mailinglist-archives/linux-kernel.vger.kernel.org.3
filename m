Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7EC5AA2C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiIAWTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiIAWSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:10 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC8E5AC74
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:18:06 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id h21so243254qta.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=TrK5dOUuJ472Va/MQxlZM4Ul27mMRNSxArIaJwpPfZg=;
        b=TUcC0u4QM5Ny9KLvPnrxQITVTokuBxEATE/WsQfbGYFGD9PpxIg9MJCiMdUCQf7Laq
         X6rikyqdDpvNk6vlDW0YVq5/0S8OJYELbrNlakftwrW0WN0AsYlxa096qY1FJJBELlxI
         jL2uVxkUi+pIbxFoV4OaGYaWTNiex9ahiveZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=TrK5dOUuJ472Va/MQxlZM4Ul27mMRNSxArIaJwpPfZg=;
        b=B99T5Fl/DOrjsYWPiMhiItZeY72mgk5+OsEVmEF2WqUDntPIim4pt9T2BVUsSBmlma
         iFKCagbFNObWAgWqmi9tw4lzhRRL4Ca5h9AOJag1ciDlfxnHweZi1naNO7jnTfO/19dL
         3crFzGZURie3+muTKmYXuks2rEUb65mXK4SCQNSmrOyVG4b/H1FOZsQU/cIbWCIUDgbP
         1otpRcAqfQMFe8g2bR0K6I/h1U97mSc5QEuVulFQaaLquKibY3Ob46aDgV+QRmsyhTyE
         SaT8R+YeZnkugerfR2y/E+m7niviq23nKlycYNsaj4JbRY5UKC7gBSDTBf9FdRt09eSz
         M7Ug==
X-Gm-Message-State: ACgBeo3D3UP5MVbG+cqlT0/xt4dotyhG2t1RKYlqI8CJxNoTKrtFgurT
        mlY50zpOYJtz9X5qrL9hQngARQ==
X-Google-Smtp-Source: AA6agR4uiuD53PR2JnbYvQYDsN+ofsO7SW63BGOkp2t0qORapVEs6g6ATsIcI2VvrBk+/fuLb48KeQ==
X-Received: by 2002:a05:622a:53:b0:344:6f46:9b16 with SMTP id y19-20020a05622a005300b003446f469b16mr26319627qtw.664.1662070685785;
        Thu, 01 Sep 2022 15:18:05 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:05 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 12/18] cred: Move call_rcu() to call_rcu_lazy()
Date:   Thu,  1 Sep 2022 22:17:14 +0000
Message-Id: <20220901221720.1105021-13-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required to prevent callbacks triggering RCU machinery too
quickly and too often, which adds more power to the system.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/cred.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index e10c15f51c1f..c7cb2e3ac73a 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -150,7 +150,7 @@ void __put_cred(struct cred *cred)
 	if (cred->non_rcu)
 		put_cred_rcu(&cred->rcu);
 	else
-		call_rcu(&cred->rcu, put_cred_rcu);
+		call_rcu_lazy(&cred->rcu, put_cred_rcu);
 }
 EXPORT_SYMBOL(__put_cred);
 
-- 
2.37.2.789.g6183377224-goog

