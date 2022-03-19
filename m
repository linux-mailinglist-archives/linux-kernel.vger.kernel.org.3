Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A19B4DE51F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 03:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241782AbiCSCEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 22:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbiCSCEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 22:04:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572469683F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 19:03:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n2so8459385plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 19:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xoAR2yJVMUeB0bOOrib4HlR43jGO+3UNSvj/b9LiFUQ=;
        b=aNK7F9MGvu9GmcJTkBB1frsQTl+WFfM31pE8duZPG/4vLLu1sV8crLU1Cjqt6ZITBV
         j+ebcjdv7EEakCVNOmFTCad+rRqiylDyuit2aDM3kqwICNqk8IVP9Kw2C0K+0fqDTlgd
         HidoSZmLFdKJ62j9Tey+JqCvKeuR7G8B/D8DU169H/d4Lg4OtgYks7zl8jsBqwYgjwiP
         /xQBjnhKGUvX86jVpltZ9UVSzLCuKx5/mhhWxJ9TjGX0TwB6yiVjEBbbsTf740SHZbZ6
         L6VhC0ALhnGwOGKScXhMnPcZq0PjKtMn30sVgzl71M6PXrqiClBe/r0qwAtnOYP+qWa9
         12kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xoAR2yJVMUeB0bOOrib4HlR43jGO+3UNSvj/b9LiFUQ=;
        b=sQl/TcUscd1zlUk545ISuIYU5IP9k4Saxnt0E8r8tX9jZsCoHAbsOFSfd3Tii+9w9I
         39ht1XGXra25vfZcCg0bg8GdpHzwi1sRAfahZcC7M20xE7x+dA5gI49DLzjk+HPdGcZP
         5ITXjwGv/pwa8bIuHsPwZV2RYrR15mmRbWzrKIWD9m9XXT7JUtbxYfBxr8PUdOovRkSR
         fbZyRIUmVwpH+hrRwYUR2wzplcYSD7gv6507FhDQgYNEgmPY5JEal8zeJHgKgmWgZITA
         scA6GiwzBugQuHpOB2yByzdh+9qFaaFPuU8oT0FktkHs5a+JX8azzg/bMASFniwakZJh
         /4Ww==
X-Gm-Message-State: AOAM530CFVjLTLFdf0G/OZscm0+hQD3jeVAn4Blgd5x2Kgr3AflFp6ht
        ooSHjQcO8AP27Cc4a5CDHsU=
X-Google-Smtp-Source: ABdhPJwTP3VMs0asgQeocvUNjtfID3/u/2reGMDGPKYUq8a2WBpC0xyak0M/1dQ+o9h1SLCVcackkw==
X-Received: by 2002:a17:902:e94e:b0:154:3a4:c5e8 with SMTP id b14-20020a170902e94e00b0015403a4c5e8mr2413704pll.19.1647655406845;
        Fri, 18 Mar 2022 19:03:26 -0700 (PDT)
Received: from localhost.localdomain ([119.3.102.56])
        by smtp.gmail.com with ESMTPSA id t9-20020a056a0021c900b004f7b425211bsm10225674pfj.36.2022.03.18.19.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 19:03:26 -0700 (PDT)
From:   Bang Li <libang.linuxer@gmail.com>
To:     vgupta@kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, valentin.schneider@arm.com,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bang Li <libang.linuxer@gmail.com>
Subject: [PATCH] ARC: remove redundant READ_ONCE() in cmpxchg loop
Date:   Sat, 19 Mar 2022 10:03:16 +0800
Message-Id: <20220319020316.142479-1-libang.linuxer@gmail.com>
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

This patch reverts commit 7082a29c22ac ("ARC: use ACCESS_ONCE in cmpxchg
loop").

It is not necessary to use READ_ONCE() because cmpxchg contains barrier. We
can get it from commit d57f727264f1 ("ARC: add compiler barrier to LLSC
based cmpxchg").

Signed-off-by: Bang Li <libang.linuxer@gmail.com>
---
 arch/arc/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index 78e6d069b1c1..56c23f3e1309 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -274,7 +274,7 @@ static void ipi_send_msg_one(int cpu, enum ipi_msg_type msg)
 	 * and read back old value
 	 */
 	do {
-		new = old = READ_ONCE(*ipi_data_ptr);
+		new = old = *ipi_data_ptr;
 		new |= 1U << msg;
 	} while (cmpxchg(ipi_data_ptr, old, new) != old);
 
-- 
2.25.1

