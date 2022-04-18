Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEBC504F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbiDRLHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiDRLHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:07:46 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF97BDF27;
        Mon, 18 Apr 2022 04:05:07 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id q75so2225357qke.6;
        Mon, 18 Apr 2022 04:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtErJV/yyKIPlfj6WAn/f6RpUfUXiwNUlAwwF0kiTLk=;
        b=R8MKlTysX7dLOUU3lP51WrJRysFMFndd1XIRz41qPtL4+6HWMU4856FdWWI85AsyAT
         +GX9m5OTi2az5H+k9sGy76+KPqitU52nFE6frMi7UeS0tPCPTSmsVCQdo3JWYd01h+y8
         gONj+4uEJVtHD4Q5402tzC3LZo++4qM9EiIERONCkE0LzZ1s5QWj3w9TlcvLFYK6HopX
         JVu/Y2Osg9V0usnI2TzA53JasBDDWfw+4hQtrjZi4z/5AEOCeY/PJxAGqgc49gBXtRHC
         th9fdr37ZqIVLzEhr3bUqwmRNpCi0xWQWx+cF69/cqFvTZFNxI4fNS6Sck4YJ3xkfT6m
         zSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtErJV/yyKIPlfj6WAn/f6RpUfUXiwNUlAwwF0kiTLk=;
        b=ksepxschAI0urZgQ3C7eWP2Z02cWDA6Asye1OgJ5sLHl6kSnLBoYQTkYmH2vDLj+Cy
         OwrJWvJQHpbB181XQ3s07a73oJTmoYDC3b1xzKxvj78C2wWJEt5Y1YVdTdV4qclnoT+M
         O/95fsyXna6LApFwK1QkGe0kajjHAcTEI9yaSwS4VFV3MN5jQRLJRIxxrXW4rou+8BR+
         teOigALFsIhb4NxLWGvSLtkkIbQDyCGMOvY7P0n8Ww/tFyGgauuDstvIi79deJDU6C6j
         svhXpiNu8leoq2Z1jZbQqeeKJESZunpgrFp+xx+sSR9xFnYpaenhB9zeoFhv+Kfvaatv
         p6CQ==
X-Gm-Message-State: AOAM531CYFJfH5J+DDby5rR1DcSXMAr9D+tfL4ioXnNhYXyPNcR1zVBk
        KX3UEr+zN23jLi3yUKcjgAA=
X-Google-Smtp-Source: ABdhPJwWHWU0/ZdEMlcP0PKD1SIg6HseO//RD89kR9i/4h7bVGnmmPDMtqgBr3K5ML2c4gUxQzuxRQ==
X-Received: by 2002:a05:620a:2847:b0:67d:2bad:422f with SMTP id h7-20020a05620a284700b0067d2bad422fmr6176151qkp.559.1650279906517;
        Mon, 18 Apr 2022 04:05:06 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i17-20020a05620a405100b0069c45deb548sm6918521qko.130.2022.04.18.04.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 04:05:06 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] clk: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 18 Apr 2022 11:04:55 +0000
Message-Id: <20220418110455.2559264-1-chi.minghao@zte.com.cn>
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
 drivers/clk/clk.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ed119182aa1b..544e940bf40b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -113,12 +113,8 @@ static int clk_pm_runtime_get(struct clk_core *core)
 	if (!core->rpm_enabled)
 		return 0;
 
-	ret = pm_runtime_get_sync(core->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(core->dev);
-		return ret;
-	}
-	return 0;
+	ret = pm_runtime_resume_and_get(core->dev);
+	return ret;
 }
 
 static void clk_pm_runtime_put(struct clk_core *core)
-- 
2.25.1


