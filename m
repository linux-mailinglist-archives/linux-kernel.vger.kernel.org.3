Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135D750D916
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbiDYGDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241390AbiDYGDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:03:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC523916B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:59:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id z16so13862218pfh.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oe3oi00hY9d25rLOX7Yn+bJM0gAYGk23/Vo00LzepFk=;
        b=Yw82r2iZSJQ1Ahhi8phkHs3sU/BCi8bW8t47GvaGb4zjV/XF1W4BeZELoPlmv0V+sE
         KAU1kL5re7oqDhrLc/4Un/y9QSbwaGUqjDszO0l40ckoJDcc2AkRPv3jLUlzh/tjRges
         jnX1lmcLx8DArnRvutrFvurvnpV3ppjzjTWALpvxfH4OO4V3cSyPxkRNQKuPrL5NB7bE
         OOqR4DWYkIn6nFWTvhOQr9yvAizL1d7qC7K2S3XIFdrPwVWEs+h6F8IKG/g1JJgY/S/2
         MLcQE9w7sTeSFGSGjVsDFQEXjwI8ijZmcHBDAi8iZc1j5ZXjdI1ZygyidMAgJ/SvyC5x
         u4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oe3oi00hY9d25rLOX7Yn+bJM0gAYGk23/Vo00LzepFk=;
        b=Rjcq/h8G5iAD+FHm7T6x04/wKnvICI32WZtSpl0cXldNxuhDROxF1RL8UheIgCG8vL
         8+V6v2rKgsmYAZVoRTY7dRrNnxZYZKVUQXUn1JwyVxbRQxqFekdf9Fr/bVuiznHSa+Ff
         2587/kKMoYqiV9+z16Znl8T9jvWpOpe2rppkQuvIeYbIBrzHnAiaMqY54I8KshjA+ZKQ
         F4e3WVptrnqw0wOFs2mk83Zu4O7en3T5+9t3xE+dsUmY00kfmwhxo6Y+vS2PLu1l3FTT
         qitDhknMa0Pf+ZbOmk30FwVCs5MUpWTnT2zf67F8O9qcPOYNSKD/XrUy2H8WviQUDjJo
         61pg==
X-Gm-Message-State: AOAM531m13Tnl8GOOahA5AyDOln573/G2vn0whaEo+wznWTIC1ZMIWhR
        rPoOdDj/inF1ufrJUfN1MvM=
X-Google-Smtp-Source: ABdhPJwu3gO2ZduYJcLmRWurOnqMNaIvOlSMLJhFsFtA1HDERNSQ9IvBNMQpF28kbkPMgvTB3F+juw==
X-Received: by 2002:a63:5355:0:b0:3aa:2752:1553 with SMTP id t21-20020a635355000000b003aa27521553mr13950519pgl.254.1650866384506;
        Sun, 24 Apr 2022 22:59:44 -0700 (PDT)
Received: from localhost.localdomain ([103.197.71.140])
        by smtp.gmail.com with ESMTPSA id y2-20020a056a00190200b004fa865d1fd3sm10376330pfi.86.2022.04.24.22.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 22:59:43 -0700 (PDT)
From:   Stephen Zhang <starzhangzsd@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, peterz@infradead.org, laijs@linux.alibaba.com,
        lihuafei1@huawei.com, fenghua.yu@intel.com,
        chang.seok.bae@intel.com, zhangshida@kylinos.cn,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/traps: add CONFIG_BUG to the use of __warn()
Date:   Mon, 25 Apr 2022 13:59:35 +0800
Message-Id: <20220425055935.458583-1-starzhangzsd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangshida <zhangshida@kylinos.cn>

__warn() is declared when CONFIG_BUG is defined, so add
CONFIG_BUG when used.

Signed-off-by: zhangshida <zhangshida@kylinos.cn>
---
 arch/x86/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 1563fb995005..81cc28a59c24 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -246,7 +246,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
 	pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
 	if (!ibt_fatal) {
 		printk(KERN_DEFAULT CUT_HERE);
+#ifdef CONFIG_BUG
 		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
+#endif
 		return;
 	}
 	BUG();
-- 
2.25.1

