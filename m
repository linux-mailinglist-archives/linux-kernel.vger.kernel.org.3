Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E4747FA9E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 07:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbhL0GtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 01:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhL0GtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 01:49:01 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B88C06173E;
        Sun, 26 Dec 2021 22:49:01 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j18so30592597wrd.2;
        Sun, 26 Dec 2021 22:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=9GEBPEvt0VT6L7i9VkLzirlLtpJd9qg2rYhuZ+v5fko=;
        b=PP49wWfNC2VIjP2+X5A+camYx6y1BopaDn8JtAlID9cJqsY0qSWvd2/udh9hKqRUrs
         2OMAcc8icoQKZCGm08SJxYPuiLmbKOU5WJhmdThri5iCD9l3/VABOs7FbJHzfzjqP6tp
         8DBw7rqixTlYCIzV+jMN3hqqLvVEuAbPxkgjEjYeyHDZqih9vmEnNxsixtjQVDRvguBl
         B4ZnAbF5gVt49P7pRR5iomPLGFlPQ73MoxbhPfpULGKipeHE7hCopl2N/bRfbQHnMCQ2
         dP/dsnimXy9SWpnd1wFR962TQXTVakzMNx+A49hm9H/zu+hD3t3/xTnDmG1u3kE7m4sc
         OQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9GEBPEvt0VT6L7i9VkLzirlLtpJd9qg2rYhuZ+v5fko=;
        b=iE4BzsQaDi5YM+UQvkEf2UfH45tKvGkBplGGIMNJ9iBdwBEcSH427GUdYiiVjMSdCS
         qZSZqUVd+qCT0CH4JADu1Rwlf9kz5k747iROpQX2DqKk3YJZfezpYi7wqhE7gxWFN8O5
         KPuDnbRYd14TA/hG8w1yM2hVo0BunW11KjquE1uw96TUz6qRYz58vA9dcC9NFpF6s3T4
         OA2frQnZxGxyS4HhR0D5CfqY7wU5V2voOaJnYtk/d7U8YJPxG2YKZMuyNXqQoIqCQyIF
         Z63L4/Qquj6z5cKwXGdlgYRZ6QcUTW8WNGoZt23PohPP1J5ToaFY1wASdEnesVF2abET
         7ohA==
X-Gm-Message-State: AOAM531R2qhXmZY+DtJJ3yZ+7BVJqllcVCRzqpe8SLLyoMRgpCuKkw/U
        3OFwuZACQVlJGYFrjzWHpVY=
X-Google-Smtp-Source: ABdhPJz/5qkj47PfUrQ6sgv5xpWDdKZEK2ociZuvXLsmLrBYR3wE9bDznsVXxKbbiL0KRdRtFt3ZzQ==
X-Received: by 2002:a5d:4c4a:: with SMTP id n10mr11967344wrt.100.1640587739524;
        Sun, 26 Dec 2021 22:48:59 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2694:d700:4c6a:3560:d245:55a0])
        by smtp.gmail.com with ESMTPSA id z22sm14187358wmi.26.2021.12.26.22.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 22:48:59 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] mfd: db8500-prcmu: remove dead code for a non-existing config
Date:   Mon, 27 Dec 2021 07:48:39 +0100
Message-Id: <20211227064839.21405-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config DBX500_PRCMU_QOS_POWER was never introduced in the kernel
repository. So, the ifdef in  ./include/linux/mfd/dbx500-prcmu.h was never
effective.

Remove these dead function prototypes.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 include/linux/mfd/dbx500-prcmu.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index cbf9d7619493..2a255362b5ac 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -556,22 +556,6 @@ static inline void prcmu_clear(unsigned int reg, u32 bits)
 #define PRCMU_QOS_ARM_OPP 3
 #define PRCMU_QOS_DEFAULT_VALUE -1
 
-#ifdef CONFIG_DBX500_PRCMU_QOS_POWER
-
-unsigned long prcmu_qos_get_cpufreq_opp_delay(void);
-void prcmu_qos_set_cpufreq_opp_delay(unsigned long);
-void prcmu_qos_force_opp(int, s32);
-int prcmu_qos_requirement(int pm_qos_class);
-int prcmu_qos_add_requirement(int pm_qos_class, char *name, s32 value);
-int prcmu_qos_update_requirement(int pm_qos_class, char *name, s32 new_value);
-void prcmu_qos_remove_requirement(int pm_qos_class, char *name);
-int prcmu_qos_add_notifier(int prcmu_qos_class,
-			   struct notifier_block *notifier);
-int prcmu_qos_remove_notifier(int prcmu_qos_class,
-			      struct notifier_block *notifier);
-
-#else
-
 static inline unsigned long prcmu_qos_get_cpufreq_opp_delay(void)
 {
 	return 0;
@@ -613,6 +597,4 @@ static inline int prcmu_qos_remove_notifier(int prcmu_qos_class,
 	return 0;
 }
 
-#endif
-
 #endif /* __MACH_PRCMU_H */
-- 
2.17.1

