Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049BE53DA45
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 07:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349057AbiFEF34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 01:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiFEF3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 01:29:54 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FAB29800;
        Sat,  4 Jun 2022 22:29:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a10so10367020pju.3;
        Sat, 04 Jun 2022 22:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=deKD5cIzgMgXwTOxKyXzSLAtYTvZcYkskErHRMjrma8=;
        b=Ryc8e11Wrd/p/oVJLbGDaBDyZ6iRSpYfKpbvBF6Tjf3Vyg7ewvMQmL7Kk6i5+4ifuW
         hz9K205bbgJ0lReKqyaIpOBZa6MYsA7GkpA8lkGIOLCt/KxaDhurOmbxXRTLbbpZDw6r
         YYCvjEY+nRz+hX+CAqeec9NyEfwlhbuy2C70NgSW4ZML25NoFZXWXbnTi2z7zibe/fQQ
         35f13qHV+5zu+jgEO3EdDCCEDEzeTyZAAU82Kag9nfrLUaCzR1ftA3MGaVDmvwtPpG+Z
         v323VRa8/RMS8SdqW5jsx5gDPvCBtdvkSQ7UAhO5zZY5kOExwYEIrgEw7lfDBDmQQl1J
         UJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=deKD5cIzgMgXwTOxKyXzSLAtYTvZcYkskErHRMjrma8=;
        b=pg5suUmZ7GbDFG+KL/IU81vlevYXBRAFdMJK4lt6xyNotUao2EobBIP99z/kpIbFxC
         y5WRdgc0cm28/eOJmxeZ/m+jVQNih7htbIu1WjIoxBKouBLVZh4J8r3rX+RQU7ixZAKB
         ygONRqMemLGALLbracWEatedl5zsT19q6LbIC7yi8Mf8VAX/7S188zCgTO4FfrvVyH2J
         MnuXstJQ2jmTJxIR0Bsg7TY5qwWA5JMbMfOwOSKaEoaYcM7ZJEmPNHdlYLsjaD9aQ69u
         pOlY8QN65Uan6QbLamlRYaPX/nUhYxkxv1sYaEGxQ8lpDJSvhKPtR+h2aMSEFtHWu9s6
         v5zg==
X-Gm-Message-State: AOAM533knjJBvGL7X3PyTVngEfGasouu4tTggbUgsa9jDXXXGUGTldYj
        jEWsC9Cd7ZjhlKBPVwFwy94=
X-Google-Smtp-Source: ABdhPJwzNGg6hHL1PSAE9VxopSHwc3gRfl4jKAtdKxaZN7lj5p0penl/d6LsR3/tK5SasQaNih3eaA==
X-Received: by 2002:a17:902:d643:b0:161:f4c2:fae with SMTP id y3-20020a170902d64300b00161f4c20faemr18302383plh.123.1654406991836;
        Sat, 04 Jun 2022 22:29:51 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id 12-20020a170902c10c00b001621c48d6c2sm939792pli.221.2022.06.04.22.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 22:29:51 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Miaoqian Lin <linmq006@gmail.com>,
        Daniel Hellstrom <daniel@gaisler.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc32,leon: Fix reference leak in leon_ipi_init
Date:   Sun,  5 Jun 2022 09:29:41 +0400
Message-Id: <20220605052943.54265-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() returns a node pointer with
refcount incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 1ca0c808c60f ("sparc32,leon: Implemented SMP IPIs for LEON CPU")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/sparc/kernel/leon_smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1eed26d423fb..85b22669c002 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -284,6 +284,7 @@ static void __init leon_ipi_init(void)
 		pp = of_find_property(rootnp, "ipi_num", &len);
 		if (pp && (*(int *)pp->value))
 			leon_ipi_irq = *(int *)pp->value;
+		of_node_put(rootnp);
 	}
 	printk(KERN_INFO "leon: SMP IPIs at IRQ %d\n", leon_ipi_irq);
 
-- 
2.25.1

