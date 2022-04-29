Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD855141E4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354206AbiD2FtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351480AbiD2FtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:49:22 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAC98E1B0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 22:46:05 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c1so5154508qkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 22:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLTftZOmNCEKWdg/w/LKAiVP4XXhL/YylRxacAEvnUM=;
        b=HZDi7YrcD7xdcirUzbKmgfCUwU2mAUIMxLK6Pfl/vXm8dXaCa6oXJJnM94XedJsXJW
         d7tXeECGF66fkQaVC/8ZnRRdU00yEtUsPABlMNqn9lEgozeeUnTlVm53XHdvZD/Z0tyo
         ZGO/03ZVgKDyEXakICg1glfHPx/pZPDhLUtQSg7B3OEbyJqdpK9h9+exyaL8gWziyIvf
         GOalhUhOrt//j+HanjgDq8+wqT6/KBQZ6Fv+ab2y3KyX/HkpjJge/xXFpggkY5EGxt6J
         nWjex5cU9dc2gOvfd06sbax7dIxjwAO7lyDxCC+4upHoch9N9YGnIgOw6jOMP9crBA1+
         dsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLTftZOmNCEKWdg/w/LKAiVP4XXhL/YylRxacAEvnUM=;
        b=GdW/rlntWXkM5MUbaPIa2aCOKUPQELIpET7/cQw0EhKXwv0zmeCk6T/kV5UnEniFhD
         5INr3aqAZABGELaQcHFh0V3Iwpe6GOuanKB6Bc0ymwP6Y6/k9snPNvCp3oNFqLCyDH8B
         yiavfUACzVzlQx7uD+fbs1uLrpUk4IOFlGi/qH755NcQobO3Rh09FB4xvs0Ox8F2uu9h
         lQhgHMzIFkJHEdvWY0LkSkArpOIi/39t+77OBqaXx2CqDv6FfeZNLfXWw/KpnGX5XMn5
         NfK45fH4gLuLBkcy+gETt3nOfCqbF7CPKDdx526KHO7A/F120haoYjQIqNpniQxupPWh
         u97Q==
X-Gm-Message-State: AOAM530D/Cn4tU27Jw4frzYiFRLZsgMyKba9UFHytW6z3K+VpoTtanAi
        QQBNnAah2klkdhi0hrH33flSbGqlSms=
X-Google-Smtp-Source: ABdhPJzXfwoRnrSfH1iu4KqIReOFh1KQsHnmjpSDX7rs/uIg/dywVen246u6DCBlSv5WGou7UcrNog==
X-Received: by 2002:a37:a90e:0:b0:69f:9b8f:86b4 with SMTP id s14-20020a37a90e000000b0069f9b8f86b4mr5555492qke.513.1651211164465;
        Thu, 28 Apr 2022 22:46:04 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f10-20020a05622a104a00b002f35726ccd8sm1188876qte.86.2022.04.28.22.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 22:46:03 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] UBIFS: simplify the return expression of run_gc()
Date:   Fri, 29 Apr 2022 05:45:56 +0000
Message-Id: <20220429054556.3851784-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 fs/ubifs/budget.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ubifs/budget.c b/fs/ubifs/budget.c
index c0b84e960b20..e8b9b756f0ac 100644
--- a/fs/ubifs/budget.c
+++ b/fs/ubifs/budget.c
@@ -65,7 +65,7 @@ static void shrink_liability(struct ubifs_info *c, int nr_to_write)
  */
 static int run_gc(struct ubifs_info *c)
 {
-	int err, lnum;
+	int lnum;
 
 	/* Make some free space by garbage-collecting dirty space */
 	down_read(&c->commit_sem);
@@ -76,10 +76,7 @@ static int run_gc(struct ubifs_info *c)
 
 	/* GC freed one LEB, return it to lprops */
 	dbg_budg("GC freed LEB %d", lnum);
-	err = ubifs_return_leb(c, lnum);
-	if (err)
-		return err;
-	return 0;
+	return ubifs_return_leb(c, lnum);
 }
 
 /**
-- 
2.25.1


