Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D151A53DF7A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352048AbiFFBpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiFFBph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:45:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9834EF77;
        Sun,  5 Jun 2022 18:45:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so13457485pjm.2;
        Sun, 05 Jun 2022 18:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tmMJEfDrOjSFqugkaoY7mGyJmkmpzClAJ8D6S6ijc/E=;
        b=Y5EBX/5PgQO4RhMgbvJNn1pNzjKL+Ws1rzXsTYjq7l0xh1Nae0JiiOW0TMSPp/8EaE
         391M7kZAlPAhvHURJHO1jfKoUlaLuZVWITxte1u4oTDFtClQnaMZHjFPd18ry+LgRrMa
         Olz+nQwLTK95qLqobmXmlW+94qk08/lHvVpqoJkRuYgwiCiX/3aPHBptq5X8Ww4qjgit
         qluc/1vSfk1VXMq+QAG2oWrOECBI848LqRzU5zUG/5ZgZXqvqdC/zwTIYqGDOmmUgJdr
         wF0uRlmyyQCMeeZBNgSEb/BLLNOV6vrlIDAcdamGO1Zh7P8XZktFlS+YvZ0sVpGZ1ujv
         VZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tmMJEfDrOjSFqugkaoY7mGyJmkmpzClAJ8D6S6ijc/E=;
        b=uH/YcuZxBagqAALNmhBDyuzea56ok2t9CXiPCqZt7NP1tfndindb/ps0HB9724DmFq
         9NTWnYmUu4V2V1t7hZwYnHEibhuMuiMwVCRAj/2pASFtY5ByA8NqH2nrgOGKWhDjHnJh
         8x/euQ1buzGaABHsz7bDEs1FgktOAyyogM+Cm7HYdof3FpNIZb1B2de1riEOlUSjvW+S
         3ehHYLknhSyi9IDDa68T7bFIJcE2fQt8v6I22NYKPU1BQiaJqhLnp5thihe+eEtpd6ig
         2n+3qW1FIxxPYqEC4I04rVAXjInuUrzC7RnKrn3mHw5L994oI2kmEnHlDBhxHK24zNSc
         n8Og==
X-Gm-Message-State: AOAM531HhW9EKmhAp5ZxTcQOOIRf1bmHzafVCTgzFnFOEG9p9UZfOfSb
        kXWF7liJVSIjLV/0dqm04lY=
X-Google-Smtp-Source: ABdhPJwCzZw6U2Sr83zQQi4ysy2UfIpR0FU9Fx8Eu/42pFSLLS9sTGAgVAxMiO/lm/kwWBRRMMA86g==
X-Received: by 2002:a17:90a:6941:b0:1e2:f37a:f889 with SMTP id j1-20020a17090a694100b001e2f37af889mr42633766pjm.160.1654479936154;
        Sun, 05 Jun 2022 18:45:36 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902684600b001675d843332sm3528800pln.63.2022.06.05.18.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 18:45:35 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] sparc64: Remove redundant NULL checks before kfree
Date:   Mon,  6 Jun 2022 01:45:30 +0000
Message-Id: <20220606014530.290732-1-chi.minghao@zte.com.cn>
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

Checking a pointer for NULL before calling kfree() on it is redundant,
kfree() deals with NULL pointers just fine.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 arch/sparc/kernel/cpumap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
index f07ea88a83af..1ae22b0d938c 100644
--- a/arch/sparc/kernel/cpumap.c
+++ b/arch/sparc/kernel/cpumap.c
@@ -352,10 +352,8 @@ static void _cpu_map_rebuild(void)
 {
 	int i;
 
-	if (cpuinfo_tree) {
-		kfree(cpuinfo_tree);
-		cpuinfo_tree = NULL;
-	}
+	kfree(cpuinfo_tree);
+	cpuinfo_tree = NULL;
 
 	cpuinfo_tree = build_cpuinfo_tree();
 	if (!cpuinfo_tree)
-- 
2.25.1


