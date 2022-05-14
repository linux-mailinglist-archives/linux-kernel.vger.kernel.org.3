Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3694C527420
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiENVPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiENVPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:15:15 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB9F24F00
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:15:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d17so11098356plg.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MH7QLYCQ/FCDzGPmiLPAinlWef0OZhM6Qty5FlB1d7E=;
        b=CeVxyh+pFUmJCDygOk+0e+EsJx38Tcl+Z1gsyepIHEe4riyJQdNPztb7hxlFDeOsQp
         AFy+JtjMaT1DWyiy5tZ1KqKcTs1Vso/LbgC5wvdcsTPBj6hEeb6/DCJutTJk3aHjzNrF
         zcdfS3VTMbr1Of8CKJIqjuW8FEorhv/OZygT3UYiD6CdgDOU5mbNpGTR2nLrsmkePgVf
         UFCWMnJtr+68wAZOx191GCKIkrJ7+yPf4O9oAzQEYD8o5SA350nZWDxyzTzATdHl8ygg
         o9bPt5yLRP1MD1/TNCII1Q57ROMhg2CGxLN0yT63RrVsG0S2qqpvcgnziJnHqeWOjjh7
         ot2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MH7QLYCQ/FCDzGPmiLPAinlWef0OZhM6Qty5FlB1d7E=;
        b=fvc7Op1//WRTIzWce1287wGoE7KeVWJgeb1hEuCdPHBIcrwrWlD1cN8OtcKMJMVtYF
         m5YWb/TdYXToqM9ycKa8Jpz8Z2jB37ootHu5ocRMWigCF8ll9Ft8g2lXPrKOIcLcjhh8
         bHGhNut0l7fiwETYwoO8hVsKdoXsNjog5BLjHDYlvcUh0RgBT7nDECBIoJgh8AFq1q7C
         bQJzC8deoJUx7SkX1nJrNgV39bHCjeaoeRPje+FEOzTmV4hU1aV/8UneUQ5bclVxPZ6u
         2sraeF/y+UH4lPhUAL/mVJi8cyKmwCegWR2PKnesDZzUjkWUb2i6L52clMLhqqDwE2Xg
         kChw==
X-Gm-Message-State: AOAM530Vz6J+U7qTtZjsAJHrcos97+BLEZA1YLfQgjUJCccP6cnOR7A/
        4cslfRN+SDtEcEbrHDCcCss=
X-Google-Smtp-Source: ABdhPJzEUPdvjFTESYYA1LyDQm79XGI5ilYpxTI/ZK+T5HFLnhHIC7TiRj2gB8gY0GmdYuISsC6oNw==
X-Received: by 2002:a17:90b:4f8d:b0:1dc:6cca:1d96 with SMTP id qe13-20020a17090b4f8d00b001dc6cca1d96mr22948648pjb.135.1652562913803;
        Sat, 14 May 2022 14:15:13 -0700 (PDT)
Received: from f34-buildvm.eng.vmware.com ([66.170.99.2])
        by smtp.googlemail.com with ESMTPSA id e35-20020a635023000000b003db141a5f26sm3826825pgb.1.2022.05.14.14.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:15:13 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, paul@paul-moore.com,
        eparis@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        yesshedi@gmail.com, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH 1/5] char: lp: ensure that index has not exceeded LP_NO
Date:   Sun, 15 May 2022 02:44:51 +0530
Message-Id: <20220514211455.284782-1-sshedi@vmware.com>
X-Mailer: git-send-email 2.36.1
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
index 0e22e3b0a04e..d474d02b6c7f 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -972,7 +972,7 @@ static void lp_attach(struct parport *port)
 			if (port_num[i] == -1)
 				break;
 
-		if (!lp_register(i, port))
+		if (i < LP_NO && !lp_register(i, port))
 			lp_count++;
 		break;
 
-- 
2.36.1

