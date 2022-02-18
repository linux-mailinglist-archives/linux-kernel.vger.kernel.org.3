Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51C54BC260
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240054AbiBRV42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:56:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbiBRV41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:56:27 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB6E172E73
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:56:08 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z16so3380513pfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jd3r2YRXkmnjceM1iJsymvM2MhZ6yE+FzaYz5eSI10Q=;
        b=I2ZQlyCRAfSiGbErP4NFNZJPIcG+KqDsLhO2d5vAW9YusHzmiqE616sCh81iGqVFm4
         GJ5X0X/hkYUq3iRxtIYf7V7r3t2ueg8b2coyR6hPD2Q0iQwGmZlJSTzrNEXyN5gJubH7
         ntAKBXKoNPESnA5tzW0s+Bl6+qX2Z7CK0rDOo9szZ0JLkFlqWvaOv/5Ph08rwrw5VPTG
         8OIrvojU0PLls1W9g4J0OcNv4vdw5Dqnm1fLjFOLO2ernkWYpToFY0L+atfBRs+/0tKG
         zC1iYhugmGYkFc2txiEH5vRw1b+dOc4Z0ik5Ihty/aj7+MYTl8zG8UmRusRp8BrVM/j9
         sCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jd3r2YRXkmnjceM1iJsymvM2MhZ6yE+FzaYz5eSI10Q=;
        b=Nr6Mv9gKdGkcVYNu1lEqVlw+X6nXCGFqEfnUtxzwCQKrjiWZuuI+tP5NZDXTXBz5HQ
         FyEpoSg3DEq4ZoiYn3oY+TXMvUAwYThV5zqLW2kYdwVFgBxFP/EPANgQaEtslwYX15tt
         /DS746TExkWg5+1N1qYTX0KhvwzeR4fCYsRxC6NTjHQugGM4CANs4b9ctPczNCdv+cj2
         rA58jRb9Oz1PG7JJwgEw7xMHh4OIW0Sjqy4hh17f0yfuBQHqdbwZuUHzY8sOuxvXTdp7
         oClCTcwesOCLJbJM7TtyIoZng7uAF7H+3O6FovFa098staPAPAh+gXWhKAA9X1JdMVL2
         4h2A==
X-Gm-Message-State: AOAM533OyQV5lqSihN7MZPwaBbN/8JGxqCEgIm6gGW7zFYboYRqD2nsY
        5kDWcQqzZs0o4WMbxQYYlLU=
X-Google-Smtp-Source: ABdhPJyF1YnmqfKnA5fst01w5ktf4SeOg/e2333TGG0cUNe7fWAx5r608Z2jsPYipg3oOQAP7OVJ3Q==
X-Received: by 2002:a63:9dc3:0:b0:373:5fac:6063 with SMTP id i186-20020a639dc3000000b003735fac6063mr7781130pgd.531.1645221367951;
        Fri, 18 Feb 2022 13:56:07 -0800 (PST)
Received: from baohua-VirtualBox.localdomain (47-72-151-34.dsl.dyn.ihug.co.nz. [47.72.151.34])
        by smtp.gmail.com with ESMTPSA id m16sm4053838pfc.156.2022.02.18.13.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:56:07 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <song.bao.hua@hisilicon.com>
To:     maz@kernel.org, tglx@linutronix.de, will@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] irqchip/gic-v3: use dsb(ishst) to synchronize data to smp before issuing ipi
Date:   Sat, 19 Feb 2022 05:55:49 +0800
Message-Id: <20220218215549.4274-1-song.bao.hua@hisilicon.com>
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

dsb(ishst) should be enough here as we only need to guarantee the
visibility of data to other CPUs in smp inner domain before we
send the ipi.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5e935d97207d..0efe1a9a9f3b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1211,7 +1211,7 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before issuing the IPI.
 	 */
-	wmb();
+	dsb(ishst);
 
 	for_each_cpu(cpu, mask) {
 		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
-- 
2.25.1

