Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF8E5A7499
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiHaDsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiHaDse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:48:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F891AA361;
        Tue, 30 Aug 2022 20:48:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id z3-20020a17090abd8300b001fd803e34f1so11290807pjr.1;
        Tue, 30 Aug 2022 20:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=LkZFLTRHCxJP7baQNiQhF9xJbbc9+xPvFqvmMA0dNQk=;
        b=G+aGh/wODj36SyksTQmmr/y+sHPBgjQvDtniONmCqFvGAJpYjYcmLNqwPXGbHFpc52
         ExDGgWuSKapPN0f9+9rU7pZLqEpL83Ffyz9RFYsKDl97UerCokI8nvbn/Oaa+O569CfS
         vkPXkzYRzPQooYYXwcxjpJmbzndBPpfymqVqHQnqwauTQSXRykk2d1jg3f0m5KEx0l9k
         EM3bL6tDcz004w5Vbqzep3o7VPYopCra+p2LvKm7aIJH3SPjyIBszbzcp0uq2NozV3RL
         RY6XExTwaG5f/3cm4zFcwHDj3LXJ2fvlZ6XHTu76fYDm03ES7d7swWQNpLtRIejQDJys
         hZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=LkZFLTRHCxJP7baQNiQhF9xJbbc9+xPvFqvmMA0dNQk=;
        b=dSpa9eJ7cbnRolgvLNtxKdCxz3DJDOf8S/0Mv/HqTIR250FR0CimeKGnvHVz1t2fgr
         EjkRtkp6xNcCSX3i8AREUaIIVsUH3dPAKdn9MNQiZ22xNj8NiBnIbVKHn34QoWMpIJMd
         KdWWtjAtg2Zy9dAVNFb9/8Lwf4nUOaC6KyiTl9X1DOk6qEPh98M0tAmCxWetyII14bON
         HnwLHnKPajcP16Z4+u94rIZFsZxu8WAIH54eortwtiLh1KEe3zMFM7v8qWm0M3maalUM
         XQvwGFoSW/rKSkIWDQ7Ob/sfAPeLktSqBrF657NVYSLMnqQqZZwFn1qUOVYF0AiUAF4Z
         hyMw==
X-Gm-Message-State: ACgBeo2lk11v69kFaMmzjWk6snvdPOogfz4R1eKHVWVxj2we5LMoAEux
        P9PWlsfupU+lSVW1CFNwGPbRjz7etbo=
X-Google-Smtp-Source: AA6agR5DuMCG16in5AJ9Ud1b6icvIBJ5vXl1hrFIRX86zC12kZsrWOFmsnYVa1qKOFb533wbHcszeQ==
X-Received: by 2002:a17:902:cf0c:b0:16f:9023:e07b with SMTP id i12-20020a170902cf0c00b0016f9023e07bmr23733978plg.143.1661917713515;
        Tue, 30 Aug 2022 20:48:33 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902784f00b00172f4835f65sm8525158pln.271.2022.08.30.20.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 20:48:33 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     rafael@kernel.org
Cc:     lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, wangxiang@cdjrlc.com, jakobkoschel@gmail.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ACPI: APEI: Remove the unneeded result variable 'rc'
Date:   Wed, 31 Aug 2022 03:48:24 +0000
Message-Id: <20220831034824.302320-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value apei_exec_write_register() directly instead of storing
it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/acpi/apei/apei-base.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 9f49272cad39..9b52482b4ed5 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -125,12 +125,9 @@ EXPORT_SYMBOL_GPL(apei_exec_write_register);
 int apei_exec_write_register_value(struct apei_exec_context *ctx,
 				   struct acpi_whea_header *entry)
 {
-	int rc;
-
 	ctx->value = entry->value;
-	rc = apei_exec_write_register(ctx, entry);
 
-	return rc;
+	return apei_exec_write_register(ctx, entry);
 }
 EXPORT_SYMBOL_GPL(apei_exec_write_register_value);
 
-- 
2.25.1
