Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4962B4C9A4B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbiCBBP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCBBPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:15:25 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E08457B9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 17:14:43 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id c7so108597qka.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 17:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0TkFFWcgAksB0r/eiWpvcxH5MHjEqDfjobzCtyWnt4=;
        b=e5BlFQgu75oQLnkpJb4FsfUxJG+JyX/bm0JpdLwMDTpJB75rrgraCfEQeGrCast3B+
         mzJkWKRtGPQYnkq7nN3TeOFq7QFm+o4UybKfiE4PsV+YtHxvYA0dV6ux8hBFOQ2tzmsi
         qnKjdxdWamUx5ARjGGJE3yM3aZI8g3vqywCkww/hPmSdBG3AiHpO0RItvWPhEVEe0TyB
         WqC6mpBLGn76ws20TyUxytKckE9JgJDN2M2vnnfUyCnULifrD7NkkI0OwCF2osEZaUQS
         MwSYCMm+S8eD4N3vZYzUoWwHcWRwHdbEEnvQp3MdUw+zH1ipOlyKpm0LojIWGa3rckXU
         UoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0TkFFWcgAksB0r/eiWpvcxH5MHjEqDfjobzCtyWnt4=;
        b=wPcsgDNMdu0iypcCAONsv+PJ1SUyIvjTxNz09qxIpIVN8z/GfM1HZl/iW8Fsbuyuwm
         e5D6EZ/z4QAPAW1sUxIXyUDGArMEh68mp8uXsAA7DQJ9A5tOaKytD2YUXihDhIvXuhov
         ugoBYFrp/44egK+FOTrmFoNoy1lxV9GWGr3vWzAXWVgikQDWndTdwTK1sNX33mkUNkXZ
         P2CR5EwUbO+a08bK9GArCsAa2tM9YrwUDzVsPQP8abydmnN4mhKStR9vGSvRL5eIt5ed
         DojM0iGm7Tr+HoJnO+fbqr4Xwr4Q2/E29SfKCdpeKYl5sLMFCj7zHmk1d580Qer4ZB2Q
         knnA==
X-Gm-Message-State: AOAM533huLEA8gy5bXpsB/SB0S7BaAYdHjYNQhN39pvnu7/cPwNCk5N9
        w8ShxL3Ypx47s9qT542VPJU=
X-Google-Smtp-Source: ABdhPJyezYxwcR0F1+1iaSAiJqCwx5d3/dCvaoN6S/JKkuTi32iCrCtK8z5qItsWOPPrwQtUqDrJcA==
X-Received: by 2002:a37:b447:0:b0:649:33c4:bd5e with SMTP id d68-20020a37b447000000b0064933c4bd5emr15256858qkf.342.1646183682470;
        Tue, 01 Mar 2022 17:14:42 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bq42-20020a05620a46aa00b006494fb49246sm7427360qkb.86.2022.03.01.17.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 17:14:42 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] sched/topology: avoid calling synchronize_rcu()
Date:   Wed,  2 Mar 2022 01:14:33 +0000
Message-Id: <20220302011433.2054613-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>

Kfree_rcu() usually results in even simpler code than does
synchronize_rcu() without synchronize_rcu()'s multi-millisecond
latency, so replace synchronize_rcu() with kfree_rcu().

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>
---
 kernel/sched/topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 974212620fa1..0ce302b4d732 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1970,8 +1970,7 @@ static void sched_reset_numa(void)
 	if (distances || masks) {
 		int i, j;
 
-		synchronize_rcu();
-		kfree(distances);
+		kfree_rcu(distances);
 		for (i = 0; i < nr_levels && masks; i++) {
 			if (!masks[i])
 				continue;
-- 
2.25.1

