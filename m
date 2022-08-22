Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1B159B786
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiHVCRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiHVCQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:16:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D9223142
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:16:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso9858483pjj.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+0W7rWPWhLmI9QuHXdXsDD8LiCq/u7awU886T4LTBws=;
        b=Npc2Tz77mETNRwOyyPYKRPVZNQgGuakYpf5WKXaRUm6l7/hpc+nr6Rf44tM+jZIhxe
         elkqBJhS4gcgZWfly532U5KKp+x3q1RO51AaFDFke+JTzkOam5lw44eRT4a2sDRcM9KL
         PxUFE2eB1nsNKjEdszC+GxePBLzNsYiu/jepd/IULwWwgr9tMQSfBJ+pg/2ZRrQEOv1Q
         k1Vs11xybyIoMv7fIFI8+IckthGyeme2p3v84OID5T4hayU/HE9WAk/08seX2HOQc6nc
         L9pKYSdD/Hw+T6OlPqTOnWSp0bonCgmFwX+98AaJCvFOZa30kBXhe2BBaTIxdDtNdCOM
         u01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+0W7rWPWhLmI9QuHXdXsDD8LiCq/u7awU886T4LTBws=;
        b=IpHKZPUes1vYjj561x6S7kvBljdEHrjRbgomeoWcAEy88+g00Ire7ulJoYDfA2pXW3
         NL1/nDL6aFr4pnAOi9lFWISZQwAGahdYhUHbHlwFpxm4moeAAv6L3DKiyQ5pKUcn9vNc
         TKfwKe3dccgn8EKgNhquApDCikFA8dDOUJ5u8szTAxKJFDIvg882P5Sd6wnzIw83k7r1
         SaGRq8nnRApRbUeK2dVmTyO0E4BYUY/QTg+0Ho/vJ639rpccbJGNnTqEbujb2sNRr2CE
         oPFwbGHEWSTgJVpUls5W+i7Xk0eC41Z4YN1iIro+HQSEEpmFimbs5kpgMUdqtyu/VIrp
         5+Sg==
X-Gm-Message-State: ACgBeo2CUYJgwqXj7IaFq7Ly7ebyGHfOh+3cMA8tV06hQZMDonZtrCrh
        3CdW3h1Bw8rO/Kab0OOCoq3CEYYHKg==
X-Google-Smtp-Source: AA6agR7sI9w4tDb1cOlX9FSkP2tbSrmD7yqoY0aTCVdZqY2NheG24QO3KWL1XwhHXLDZaKxsym+Tqg==
X-Received: by 2002:a17:903:1106:b0:172:9801:cb96 with SMTP id n6-20020a170903110600b001729801cb96mr18140713plh.91.1661134597390;
        Sun, 21 Aug 2022 19:16:37 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79723000000b005321340753fsm7312139pfg.103.2022.08.21.19.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:16:36 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC 09/10] genirq/cpuhotplug: Ask migrate_one_irq() to migrate to a real online cpu
Date:   Mon, 22 Aug 2022 10:15:19 +0800
Message-Id: <20220822021520.6996-10-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220822021520.6996-1-kernelfans@gmail.com>
References: <20220822021520.6996-1-kernelfans@gmail.com>
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

In kexec quick reboot path, the dying cpus are still on the
cpu_online_mask, but the interrupt should be migrated onto a real online
cpu instead of a dying one. Otherwise, the interrupt has no opportunity
to move onto a live cpu.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel@vger.kernel.org
---
 kernel/irq/cpuhotplug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 1ed2b1739363..e85d6456f310 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -110,6 +110,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	if (maskchip && chip->irq_mask)
 		chip->irq_mask(d);
 
+	cpumask_andnot(affinity, affinity, cpu_dying_mask);
 	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
 		/*
 		 * If the interrupt is managed, then shut it down and leave
@@ -120,7 +121,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
 			irq_shutdown_and_deactivate(desc);
 			return false;
 		}
-		affinity = cpu_online_mask;
+		cpumask_andnot(affinity, cpu_online_mask, cpu_dying_mask);
 		brokeaff = true;
 	}
 	/*
-- 
2.31.1

