Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EF652778E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 14:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbiEOMnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 08:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbiEOMmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 08:42:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A80413F75
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q4so12000384plr.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7Q4DIyBFdkOfQfLesIacT6b2x85qOReA4ewSFpfUcU=;
        b=Lo6scrQ+k9iHe4huyVLvgU/wxxBjA9bU8Ih1wmkpJo0Ev0Rlpkd25v1GKuGMlqkX92
         WhVHWnsm2nWCy3gNU+y1xjk2pto+37bnLdMW3kD0/lEbz2M1JP0suKY4CLM1rvk5Z7CH
         2xadzZOzkWj/MD3u73lOVz3iUthzEzb2rkQqezefryB2ovt/hkV8mbVLG5h9JNNjnFfA
         poh54JesuZhk4+fKKyORu0rR0HlP82O00aymUyUQgEH6UwcmkHr6TLdlcK7+Y/ZifE1+
         4EV+dlTkeiLs0q8Sdvbh5mntq3H9ULNfMyNdQb4C8vzJBK2aS0p44umitDyzX+pfs9u0
         A9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7Q4DIyBFdkOfQfLesIacT6b2x85qOReA4ewSFpfUcU=;
        b=32CvXkMN7blI2lZmTLArjFsg4bXuk7Sfm1WQ2WXORLozkueesm0Bp8/PPV2M3/zIlm
         kq42q7Lk9i4n3aJIMRJUN/ACUyDZeP8dlVvdTsdaXt+C5dVgq6udGAVX0sGkXUfqEGoZ
         mCnY6VBUWu4ohkdx/VD0uqOIm40+vsoFlvO/8lJqWYC8qTh1erRcr5Jsnf+Xha0o3JuL
         FjaBv9rIfINmvmd1/N8G8sAlBG6BunOggTX3NYWLOGaKLVe4kz63aTfXO0/Y1VaqFYxo
         qlpGah2CQEVKdvzYvtocau7vlBJBmLMIpAqTkZ2SdoU+Dwy0QbNiMMYpSDVdoFCdaeOx
         eK5A==
X-Gm-Message-State: AOAM533Xmw8cjWEyEZR/rtv1AcnOL9wgKdDSZ6qJo9NAJwiA0W9lT3NT
        3KH++X/H0QjKNxpuHl5mX7GGFFVlgVMZCg==
X-Google-Smtp-Source: ABdhPJwEa15HWk3Et/kczvNW94n1lSxp/nf7itF2ZI5UFYnj6sBZE9pkT79HfOEXd7/OGPTL5nmjyw==
X-Received: by 2002:a17:902:f78d:b0:14d:522e:deb3 with SMTP id q13-20020a170902f78d00b0014d522edeb3mr13304884pln.173.1652618558263;
        Sun, 15 May 2022 05:42:38 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id f38-20020a631026000000b003c14af5062csm4751375pgl.68.2022.05.15.05.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 05:42:37 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 09/13] openrisc/traps: Declare unhandled_exception for asmlinkage
Date:   Sun, 15 May 2022 21:41:54 +0900
Message-Id: <20220515124158.3167452-10-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220515124158.3167452-1-shorne@gmail.com>
References: <20220515124158.3167452-1-shorne@gmail.com>
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

