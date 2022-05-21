Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556E752FCAD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354942AbiEUNOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351062AbiEUNO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:14:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523B639B80
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:14:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s14so9413288plk.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7Q4DIyBFdkOfQfLesIacT6b2x85qOReA4ewSFpfUcU=;
        b=DXSLnl6bzRiqQd9B3yCFb3QN0I29DuZvmyvMOt1C5IzPBsMZujmBjjyjiPXn8dM5Mi
         1EI6K4reqiBhLCza62OYrJa3ud9LTNNkk1lz32pXboLjnSv9jja0+LzxK8QgXWcXidAL
         JUi/BgVHD1aLJfk6SrAZans9hpJJaDzzW4PwoCNXGGJxW3Fl7Guwjot7Kfi1ws4O8UB/
         TfYKuiNdoCEO6UmA0QqO8qghU9qoscOe0g+tEcxinZ5zkle3SWuNXXlUqaEudsZ+q8mS
         AckGqF8C890g19t7+O78uuwQig6Pj3bmEq4dmoKbNDK9GfOvCVYN0pn9Jt0kRQPsNTEQ
         EIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7Q4DIyBFdkOfQfLesIacT6b2x85qOReA4ewSFpfUcU=;
        b=2ONfr7WJ9qfFmPBBLdzqNsFeZIZ2AtuNr391KXg0hZtIBZjCoPGUFrj+oUgJQE+IsJ
         c8Km7zXabGpUGZnd8sV0mpHsz0PXSL+vkOE2acvibuXLGy1cTD/FPWOnQyHjLUDQj/4a
         DlZ9ZqFWDO1TYoz0uZFCphIzlnC5FyAPWlntbZA8ZGpzEm1uhTngH75+d8F8YFVeTXrj
         KgsRvHZcQIB2yVhv0HmFTUd24jg3OjyMjL7gC8QpeAUovfhxQKg96NeJ3YPY5Yuh90A4
         kkUeYl3Qwi++gGItpcOjinI0nmHcwO5/IhOEb7c5QSezpYi2Q0rGC7zSVrRniuvqK+Sc
         QJ4g==
X-Gm-Message-State: AOAM530Gy0/YagirfnwuOqMRsg2nDp8X4hY87o0Cx/8Ub812CMqF3LAB
        tmKTF8ozvb43KjzYgJoB8vP6NRPyxLoCng==
X-Google-Smtp-Source: ABdhPJzRR6zf4/aFz4vGSyRfNAJ3VFLw0FA+iXux+gNdzSOHEVGhZYeu9Oa58IX6yFdO8P/mN1weHQ==
X-Received: by 2002:a17:902:ea53:b0:15b:1bb8:ac9e with SMTP id r19-20020a170902ea5300b0015b1bb8ac9emr14147213plg.45.1653138848062;
        Sat, 21 May 2022 06:14:08 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903019100b00161c3fc7a44sm1581665plg.108.2022.05.21.06.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:14:07 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 09/13] openrisc/traps: Declare unhandled_exception for asmlinkage
Date:   Sat, 21 May 2022 22:13:19 +0900
Message-Id: <20220521131323.631209-10-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521131323.631209-1-shorne@gmail.com>
References: <20220521131323.631209-1-shorne@gmail.com>
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

Noticed this when workin on warnings.  As unhandled_exception is used in
entry.S we should attribute it with asmlinkage.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 99cd2e6f8873..fd9a0f2b66c4 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -235,7 +235,7 @@ void __noreturn die(const char *str, struct pt_regs *regs, long err)
 	make_task_dead(SIGSEGV);
 }
 
-void unhandled_exception(struct pt_regs *regs, int ea, int vector)
+asmlinkage void unhandled_exception(struct pt_regs *regs, int ea, int vector)
 {
 	printk("Unable to handle exception at EA =0x%x, vector 0x%x",
 	       ea, vector);
-- 
2.31.1

