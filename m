Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCAD527421
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiENVP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiENVP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:15:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B59625291
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:15:27 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 31so10627849pgp.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LJ1TiZWIwFC+0opultkzqc9TR+djjH86dn+EQyDfmgk=;
        b=nyZydSDrCBcbuEB2JRujTxM3tALzTyIYU4S6fkmkIAMlcL/19c1leoS1kvwHAvseKM
         +jzh2xRwIK9WFHr5wAl93CPdTxtXw1mOyoPGHTiiz4vDTHLTv6gX84sTsa5XOndJU6qR
         G5m6L+HleNQBB22C0X0OVbpCTObY/tcgDlmIao4qthK2RWLyG7VMZXlIA2oJM3MglfHJ
         zqamIfurfvp2VmbmHgFHcrDQ5p8O3MTSgLScW2eabNdqlPHPbcY464+Q94DtOvr1mv1X
         MlzMY/4m91h4HKP2X/V4PaXJFFkkaQ2yc/WCk1+YY1J/JXC+l5iVLPcPsl5r913wgFfz
         Ulig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJ1TiZWIwFC+0opultkzqc9TR+djjH86dn+EQyDfmgk=;
        b=jDPfUkILrFwBMqLN9/hZF+Z0FJ44iRP6BpDVUC9MzNiFgDuYvZV7yob+f3y+gszY2j
         4YWEJ1YrTTKwJh6TBPKy4InBVZU7NCDkTXPyy9pzNcCrP1T3w7xuJtUuVLh9pW9ExXdf
         WVtwTHWCi2iGp+eFStovHRgfl/4l41h4N86esD+bQsJDBVN0jS3y7ezWjVIrS8G/k/Sg
         OP5UaymzDY805zU2zNlwqOOavpve1FOkgtG+z9jS37XvvC0KVRxLPx7bjMsrraDXTbQM
         G2bF82q8Qp8OTl/uPkmQ6Z25uPs/voK2k9/bZEVOy0E5VHXQtrUVIS6ByZ/XT7la5sw7
         EmdQ==
X-Gm-Message-State: AOAM531CNXoeqxH8FQUs+RQ80zf8XcX+B2yJQCHZSeyCpYquUWgmlNNm
        nnWCNfXmBE6/f9Dzhi1pOFe2Usx273cOJS8/KxFO1Oh/
X-Google-Smtp-Source: ABdhPJzr11I/vO466pkaITQ7dZc9Ta+t0gUSuH7Vt/gbCFUg4qK3UnlhL5CxgQaY+t3rcrkqhr9WvQ==
X-Received: by 2002:a05:6a00:22d4:b0:510:4c30:3f6b with SMTP id f20-20020a056a0022d400b005104c303f6bmr10791265pfj.74.1652562926587;
        Sat, 14 May 2022 14:15:26 -0700 (PDT)
Received: from f34-buildvm.eng.vmware.com ([66.170.99.2])
        by smtp.googlemail.com with ESMTPSA id e35-20020a635023000000b003db141a5f26sm3826825pgb.1.2022.05.14.14.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:15:26 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, paul@paul-moore.com,
        eparis@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        yesshedi@gmail.com, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH 2/5] char: lp: remove redundant initialization of err
Date:   Sun, 15 May 2022 02:44:52 +0530
Message-Id: <20220514211455.284782-2-sshedi@vmware.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514211455.284782-1-sshedi@vmware.com>
References: <20220514211455.284782-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 drivers/char/lp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index d474d02b6c7f..536ceb11176e 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -1019,7 +1019,7 @@ static struct parport_driver lp_driver = {
 
 static int __init lp_init(void)
 {
-	int i, err = 0;
+	int i, err;
 
 	if (parport_nr[0] == LP_PARPORT_OFF)
 		return 0;
-- 
2.36.1

