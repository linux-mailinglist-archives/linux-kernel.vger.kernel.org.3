Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57BD5A21C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245303AbiHZH00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245295AbiHZH0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:26:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BC64C609
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:26:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p18so881792plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=lI4CWqG6v5ZBU8gDLirXlKuy5ZufBDP2aWB6a62sKfw=;
        b=mR4gX7Tz+bNOj8ZzMZoRVkmpEQhvnSujiHvBAKEJJTnaXeuBZDHISmfru+LfBZJcRJ
         s1ynwTszEuGn54naMqxe6eyI/Uj/YM2yFR0RoBkgjw8Aon/64Doi5hfqZkFfdQ6EPVe+
         ytiiPMMyxUwpGr/B/ZSHgUwA0nqIy1DXu8g9d5onC7reo1fO77NWQll/357mgvAnTitG
         jDLFub43SqrRc4Ir5Pb9Vxe+d92XQME9hOSLR0BUBpEKP0FzkkXvOMW8+91H12J4/kWp
         NaeJGOzhRk9lE4hSN0vHd9P4dUGJoV2GYFFHPZT8ITd6cazaPztl3agXkaELg2nC2eqL
         NJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=lI4CWqG6v5ZBU8gDLirXlKuy5ZufBDP2aWB6a62sKfw=;
        b=nPj2ZRmmVImFCvKC1lR2+EpC+JIhTq2iAcKGeKbTTeAPSoTnVONLYBIdz2AgXSaQrT
         IxInSbp08uyJiysPHqtdYuv5LFsMTwnj8uAdafb1CB3Ywr+Gjn4j8BEIJ7mLQZ5rjlVA
         bvovnaR0kSQZ1sWqScg3WsZZeZDMdZnvi8nbeYuHkxaKHFXDbPB+tlUpKq70YYTFtvoC
         WIsA9EFTEh6GH99f2r6EOu8eWaKRZP0xosuRS+mknShrNjfadcE5PvbFR7y36OtEuGeU
         2u5D41takrjTx1q3NrB+ZnInXssHK97D7pZu1AgUP6tOrBeyoIFCdd7xSAHTnZ0K8V+c
         6JBg==
X-Gm-Message-State: ACgBeo1grlpGDDjXaaPhj5IyBQUY0TFbJFoLy/DaeZw4CMLj7xB4unlk
        EVUjZa6lJdOx+9wi/+QONjU=
X-Google-Smtp-Source: AA6agR6FI/XsvaYBR+70cHAeWlu/xebq0AOp1LX8OGvxawzLhq1Hg86HQbk/7tSHO6xTF62n7L4SvA==
X-Received: by 2002:a17:902:9886:b0:172:bb36:70f1 with SMTP id s6-20020a170902988600b00172bb3670f1mr2577202plp.139.1661498768536;
        Fri, 26 Aug 2022 00:26:08 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f60-20020a17090a704200b001f319e9b9e5sm944505pjk.16.2022.08.26.00.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 00:26:08 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux@armlinux.org.uk
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] arm/ftrace: Remove the unneeded result variable
Date:   Fri, 26 Aug 2022 07:26:03 +0000
Message-Id: <20220826072603.252909-1-ye.xingchen@zte.com.cn>
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

Return the value ftrace_modify_code() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 arch/arm/kernel/ftrace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index a0b6d1e3812f..94924a2ecd94 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -190,7 +190,6 @@ int ftrace_make_nop(struct module *mod,
 	unsigned long ip = rec->ip;
 	unsigned long old;
 	unsigned long new;
-	int ret;
 
 #ifdef CONFIG_ARM_MODULE_PLTS
 	/* mod is only supplied during module loading */
@@ -216,9 +215,8 @@ int ftrace_make_nop(struct module *mod,
 	 * so validation may fail spuriously in such cases. Let's work around
 	 * this by omitting those from validation.
 	 */
-	ret = ftrace_modify_code(ip, old, new, !is_kernel_inittext(ip));
 
-	return ret;
+	return ftrace_modify_code(ip, old, new, !is_kernel_inittext(ip));
 }
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
-- 
2.25.1
