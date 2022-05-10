Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A9B5222F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348337AbiEJRoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348324AbiEJRoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:44:01 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A022C07F7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:40:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v10so15190958pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bI5Wq4fYlgvsn7ewbzWHly8tO9mGqbvCrFEIK0Y2ebs=;
        b=e5Mb3fqlcxp0+sOSIOk4vaheuaR9HaV9MHrJRei2FFux8gDFiodvmlTJTekCbXiQQc
         97J347DqjHwSB4tG7pHiS3X4lv9MpyeiEpj/RqML+2aIlzJhZHh7YtYp/fBjNIbJ1JLT
         3+GUoZWGaam3/6347gI2+VM95JzZL2GCK6ORY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bI5Wq4fYlgvsn7ewbzWHly8tO9mGqbvCrFEIK0Y2ebs=;
        b=6FORwvDy2F2FYDQaypUQpqOTQpZF7rdn4/hd7hB0Uhl1rxssoUXS3PW3oSfuGjDcrT
         7xCNSP+2OocnUYjKScrhds8/+l5qKUS8RoMPI70fGcGQwF+b1kp/dnClPpKWADfY/o/A
         AhukguWF7Sz3GLWRqulxsUotykbaucm+2I3ICmvmgCuTKHUM2tim8lHd3VmyJ69Jowfq
         mi9ViowvHzMvO21HGusxMZjuArNVTfkCGvyJfuWPsc4WPcPkIyABH1UsnQvBRNkIDIns
         EFgs9/mXSa3JAx+wLWPm9m2fL2rPgpTBxY3roLQDzoACBmW/N51dU3U6M2JBGBs6uG4f
         8dYQ==
X-Gm-Message-State: AOAM533uycC4JfdRjKJcNKDeM1KAAMRke69PmkJeAz98uUdkFcIqDRS+
        u8JAJBwr7+l7akTFz4kfgSoNAw==
X-Google-Smtp-Source: ABdhPJy15+8IPlBIEr4dYQNJE6VnAZvUJHrYDeaifFeufVvGKJ5NH2dVjeWnYfU91kcN+93OOnk3aA==
X-Received: by 2002:a05:6a02:206:b0:399:3c9:f465 with SMTP id bh6-20020a056a02020600b0039903c9f465mr18317973pgb.388.1652204403260;
        Tue, 10 May 2022 10:40:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y8-20020a1709029b8800b0015e8d4eb1c7sm2384766plp.17.2022.05.10.10.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:40:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] randomize_kstack: Improve docs on requirements/rationale
Date:   Tue, 10 May 2022 10:40:00 -0700
Message-Id: <20220510174000.3561471-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2628; h=from:subject; bh=sZN8G42EsIJgCeEnSvfbE1A7fV6oYv2zKuE4eX87/5Q=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBieqNvKvEtsGycbnfDYZgwscE04dNz1ZnWfsUOBV2M v3G7FymJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnqjbwAKCRCJcvTf3G3AJlZ5D/ 453wnLZtcnR75TpA77v/tQNIQAUGLEb28/qoQfN1PPcNzQpftVXTWKQh/w8iPdAoTGWENhpg6cfsA2 5n1k2a0Anbbx5tXTJmqzQ8nfLs3DroNuJjITxnfv+W9qy8jmMKI5miSMnSChxtwfEyCftUi7239C55 Ug4QQ9f77eS+P8tVhDpt5C5tB/QMuaBtsvf1we/QvVWqdva7GCXdSv1G8FtJ3nbaH/uBeqHJxl8R3u y4QpY0+0WMvoQAa2JSUUpZ2efp3AwoEvC1Pe0Vto4KjvDds7fFgWC+y7TiI48A7F7MGTMRO6Rs5cJ9 Xd5v34+sL3uawSsZAy+CLaEHIF2IA4TZrUuATV+xOwHK0wrqjuTj2L3bCw9jvpModNiMcQOxhn+znK ymw5psLQXZFFYNLErnaiYEcAk2cAKPTl5Wu6GxuU/doevQ8goZVEr4hNcUE+VU3ffx+PVT9fHo1Bc9 5bDXxP+qgaBYt/arcdmlE+uSB8fknovvfubURpf/TgOixV/DObHVz85Rhqez7BhuYr2cH+CZqWWBM2 RrPEj8JP2n/66TLb58QnbBjwOTGRN7+IyDyUN85iZ1NQ8o39xDnVBcI/gto/Wjt4a1pArTzbCqOg4Y sA+L0HVET6MZJeWK3cMpvIT1GP1QNjxGGjD7uZtA3wl9kzfb5xI84cQc9S5Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were some recent questions about where and why to use the
random_kstack routines when applying them to new architectures[1].
Update the header comments to reflect the design choices for the
routines.

[1] https://lore.kernel.org/lkml/1652173338.7bltwybi0c.astroid@bobo.none

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/randomize_kstack.h | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index 1468caf001c0..5d868505a94e 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -40,10 +40,14 @@ DECLARE_PER_CPU(u32, kstack_offset);
  */
 #define KSTACK_OFFSET_MAX(x)	((x) & 0x3FF)
 
-/*
- * These macros must be used during syscall entry when interrupts and
+/**
+ * add_random_kstack_offset - Increase stack utilization by previously
+ *			      chosen random offset
+ *
+ * This should be used in the syscall entry path when interrupts and
  * preempt are disabled, and after user registers have been stored to
- * the stack.
+ * the stack. For testing the resulting entropy, please see:
+ * tools/testing/selftests/lkdtm/stack-entropy.sh
  */
 #define add_random_kstack_offset() do {					\
 	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
@@ -55,6 +59,23 @@ DECLARE_PER_CPU(u32, kstack_offset);
 	}								\
 } while (0)
 
+/**
+ * choose_random_kstack_offset - Choose the random offset for the next
+ *				 add_random_kstack_offset()
+ *
+ * This should only be used during syscall exit when interrupts and
+ * preempt are disabled. This position in the syscall flow is done to
+ * frustrate attacks from userspace attempting to learn the next offset:
+ * - Maximize the timing uncertainty visible from userspace: if the
+ *   offset is chosen at syscall entry, userspace has much more control
+ *   over the timing between choosing offsets. "How long will we be in
+ *   kernel mode?" tends to be more difficult to predict than "how long
+ *   will we be in user mode?"
+ * - Reduce the lifetime of the new offset sitting in memory during
+ *   kernel mode execution. Exposure of "thread-local" memory content
+ *   (e.g. current, percpu, etc) tends to be easier than arbitrary
+ *   location memory exposure.
+ */
 #define choose_random_kstack_offset(rand) do {				\
 	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
 				&randomize_kstack_offset)) {		\
-- 
2.32.0

