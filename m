Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E57474196
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhLNLi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhLNLiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:38:55 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921A3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 03:38:55 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id o17so18075325qtk.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 03:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcW3xiqgDuKYWliemyl+M/gIwk5rkWVzmoooCQukSqg=;
        b=eHD2KXyGrXQtMdB4Z1JJNSaGoZGW9Qo9R5BgJwUPaqqsL8dUtwZb9L7mvnnmSxnNYi
         71TOTdsuypbA8GiYIcTWBgvmNrO+BfJNodn747qiOzEAqXb6hrdR5Tl5lzPzSkpqLfpw
         oJkXwL/P3xAIDBTxowarul29tYXFpuwPDGwW3gNCdUpab/bCPELbZDuUkI0DUkNbEXoG
         VA2CDl6vSeb7lIrf2svgu++IyLhyNUMdhUEXV1948ZcVg89ZvoBx82M3qhnQdmcI8n06
         NPU1v9IyNNuWJHUm6DyFvDJK8FHZVDpKlbTiQ6qsedxAwFo1l4wW+A3VoFvFZEO9MXik
         BEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcW3xiqgDuKYWliemyl+M/gIwk5rkWVzmoooCQukSqg=;
        b=Ik2qDleyDkdzVkoirBR4+Z2d8VLYS6i1SjMy8YmH2l6s+6v82aiKB1IHvVBYyNIe0O
         JOGPrSochypDsbtJ8V3/4JaoyrxPk5Q/RGLn3MiQ1rEqltlY6ujGxmM74TKQCRyd//Xy
         WZdW6nTQu9eTcpw/tSN1PpdKlZcF3RxnR7okuPlVWoclowPnAXJaL/qb6PlfgXlFXAMg
         +Ce8qG4+QtgZqFgqrJy+fFtiPfa7atT/5NIzPaRt0fg66WKT3689C2DYc2BxsSRcwnvk
         RxCBTAx+orTAH57/EkJH3HxjQQHMcbTpRJCqt8uQ62f4dMJuE4kIQKLhbBKKTsWjmk90
         lDEg==
X-Gm-Message-State: AOAM530KleZK4vot9xtq6PZWuUXXVTwOUbBkMmHykFUSXwreizU2r6ox
        r0Et6ZwlfScmXrPP34tTm9M=
X-Google-Smtp-Source: ABdhPJwEw23G1MYrbTmZBU1gYPU5WfEn0W5n3mrfC+p7UjV538wmbjrk/Qa2x4BJISDfRIE7EetqWg==
X-Received: by 2002:a05:622a:1102:: with SMTP id e2mr5216827qty.194.1639481934682;
        Tue, 14 Dec 2021 03:38:54 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f12sm7591369qkh.22.2021.12.14.03.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 03:38:54 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] sched/fair: fix boolreturn.cocci warning
Date:   Tue, 14 Dec 2021 11:38:45 +0000
Message-Id: <20211214113845.439392-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

./kernel/sched/fair.c: 9781: 9-10: WARNING: return of 0/1 in function
'imbalanced_active_balance' with return type bool

Return statements in functions returning bool should use true/false
instead of 1/0.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ac5e55441cab..0e62fd7ac0e6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9778,9 +9778,9 @@ imbalanced_active_balance(struct lb_env *env)
 	 */
 	if ((env->migration_type == migrate_task) &&
 	    (sd->nr_balance_failed > sd->cache_nice_tries+2))
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 static int need_active_balance(struct lb_env *env)
-- 
2.25.1

