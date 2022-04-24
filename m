Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A208350D05E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 09:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbiDXH76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 03:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiDXH7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 03:59:55 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B1F5DA05
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 00:56:55 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q12so10857322pgj.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 00:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=gXnBpJRWWZHz4VNliAsh+cW2p8QDP/pr8g0gHxnSkb8=;
        b=ZLMTw+LPO4m6iN8dn5OOOIxghO9PW21/vOeRdHMxRbnN2MrKOKD4wsJih6P+KB9dPt
         bo11DMFIB7B9c4n8OJjNq/73BDWNbOhKZ0I6RN9YT00gfPK2qF7Lzv8TxIYkMbly0YB7
         Vd6uwKe6NQXAa8qRLSdQcqogsYQUSLaouSs0zUvDx4TcnQExPCGTX4Uqqu+d2v4ArCmc
         hBLScI9h6NhdRx07pvhcVlhLTyAasIzd9zFKHooBpE6+fmwGBl/sGFHbbEu2ISYJ5t9a
         xisV69zJ9f9Q2HpJa7u+dM6QAPF+K3CSMMMCytJMDJjmzzkfdQBENQUvwtWm/kfRdkhh
         cF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=gXnBpJRWWZHz4VNliAsh+cW2p8QDP/pr8g0gHxnSkb8=;
        b=BpJQU21TeaSw0JuKVgDHrHjYnwBMZyL1peTWCaKcU0+JAZGFf1PLkkmtHMPtiFCrlD
         EaSu4hKSXct5D2RFdHJ0UY/Qtvm8t4YC7atZb57ItGwNHQIXm18AFvNjR4XhOxRl/BH5
         eBQP4D78+xyrVds3r3ZwJxehZF33uGpNFiN5sX1J42sD9o1AZHWMz9xgDloI78tDSSSi
         6gSh0qWgS6URVoS27ksqKV/k8BzcuIJe2WwS1Qzipxw/TO7U48dIpIK5+R35pdb6YBL+
         SZCrBIQybwTmG+0UnUHzSLKjS3k0mUESnbQ+FdyFqCJW4bj7m/Tk17oXLv38pXW/qfsi
         AX0A==
X-Gm-Message-State: AOAM532ADTUtjotjhzfWu2tu6nEXFSk8xAFq3jqpJrnXz6/xeWh1aJDw
        spDZlt8y0m/4qUkZ6gUcEvQ=
X-Google-Smtp-Source: ABdhPJxjmtEZi91y/jYgrAnPzQr1Th442XOItJJfukWVrjCA91Fzcd6kmTBOkfwx+g7atLVdRI0eGA==
X-Received: by 2002:a05:6a00:228c:b0:50c:6a9a:a325 with SMTP id f12-20020a056a00228c00b0050c6a9aa325mr12900415pfe.79.1650787014939;
        Sun, 24 Apr 2022 00:56:54 -0700 (PDT)
Received: from localhost.localdomain ([150.109.127.35])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79042000000b005057336554bsm7478487pfo.128.2022.04.24.00.56.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Apr 2022 00:56:54 -0700 (PDT)
From:   zgpeng <zgpeng.linux@gmail.com>
X-Google-Original-From: zgpeng <zgpeng@tencent.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Fix decision matrix of type misfit_task
Date:   Sun, 24 Apr 2022 15:56:50 +0800
Message-Id: <1650787010-8701-1-git-send-email-zgpeng@tencent.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the group type of the busiest is misfit_task, as
long as the type of the local group is not equal to
has_spare, those situation already filtered while
updating statistics.

Signed-off-by: zgpeng <zgpeng@tencent.com>
Reviewed-by: Samuel Liao <samuelliao@tencent.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299..b8c67e7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9495,7 +9495,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
  * busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
  * has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
  * fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
- * misfit_task      force     N/A        N/A    N/A  force      force
+ * misfit_task      force     N/A        N/A    N/A  N/A        N/A
  * asym_packing     force     force      N/A    N/A  force      force
  * imbalanced       force     force      N/A    N/A  force      force
  * overloaded       force     force      N/A    N/A  force      avg_load
-- 
2.9.5

