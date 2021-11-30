Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFCB464069
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhK3Vod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344313AbhK3VoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:44:20 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C810C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 13:41:00 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 207so43777907ljf.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 13:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CKetsXi0RfQePeb7Tt2k29Lg8Dpvn5dR/0zuq13Hz8Q=;
        b=Gbo1XJS5KgXWCZNHjITuVdP5My4DnESy0GeSriHkPMRsh9K80eOCGXRbODTghbouTa
         hUhxDoA5GLCFxeyd3RKuIjTR1pUivP0X1/5gULz9nYQLBO4i7rRAnOqq5/PmTkZjAJrz
         zNQZ+Rs4CG/IVJ1PfNtF4v4X8P5B0YvOhXyvrcjXFnw8Wn8CshAXxqw7vHbX95NME1xI
         pe/3VtjYnetCrfhai4nRSfnNUJQ0huWig2vTXTorsJUmSzlo/3ofHWaAdIkhs2RGXCqB
         0Fj6Fcxy1PP8jQ4CUK655uGA1cyT7fmmy017gLu2ltJV2E4Ns32/iNSk48X9q9pg5L7e
         ohew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CKetsXi0RfQePeb7Tt2k29Lg8Dpvn5dR/0zuq13Hz8Q=;
        b=O9BzdjNCjhsN5TZMoIAeAsUcTO7re5FZBfwz6PjPcmv5rqRkrccZoYViXAYv2P61Gc
         Sg0+XIgCpooYKwN0258IYNYJTkzpJ0C1seNTWEKVykjMrA44uGXwN7tHqZvaKasFabhI
         yL7PJ156XM3NqT9VSRKeiStaWsZjvN3L1+8s9QnTInfHusJFaBmMAU6EsAaEgzM4iZe3
         sAVCuSYL4QGtgJ3ITXpRT6cwwLaRZVK0mJcHjqK/SAZhi8mWGassOK8kKdky9jK8+kJc
         4Xj8Yjrzk0hYGB9MU0zwP07LHjnhof/1jtNDJrTFHpzqaLtDOEgBmWNHjO9+s0UkAvAG
         6VtA==
X-Gm-Message-State: AOAM533mcbioY0bnqkZ8Q8KKpVacXubLmgOrIH2e7t3bOH+eIB3Fkms0
        XsRblfBNBiwuO5V0Yx8AFcQ=
X-Google-Smtp-Source: ABdhPJyYkAhiSldJBxfq710dLWFfVJVpeiKebpeNn65Uws5T5O0moktMVU8A7PN9tn3IPNPLnxNdOg==
X-Received: by 2002:a2e:9c91:: with SMTP id x17mr1519414lji.330.1638308458515;
        Tue, 30 Nov 2021 13:40:58 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id p3sm1836664lfg.205.2021.11.30.13.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:40:57 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] irqdomain: Constify irq_generic_chip_ops
Date:   Tue, 30 Nov 2021 22:40:43 +0100
Message-Id: <20211130214043.1257585-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of irq_generic_chip_ops is to pass its address to
irq_domain_add_linear() which takes a pointer to const struct
irq_domain_ops. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 include/linux/irqdomain.h | 2 +-
 kernel/irq/generic-chip.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 553da4899f55..d476405802e9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -131,7 +131,7 @@ struct irq_domain_ops {
 #endif
 };
 
-extern struct irq_domain_ops irq_generic_chip_ops;
+extern const struct irq_domain_ops irq_generic_chip_ops;
 
 struct irq_domain_chip_generic;
 
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 6f29bf4c8515..f0862eb6b506 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -451,7 +451,7 @@ static void irq_unmap_generic_chip(struct irq_domain *d, unsigned int virq)
 
 }
 
-struct irq_domain_ops irq_generic_chip_ops = {
+const struct irq_domain_ops irq_generic_chip_ops = {
 	.map	= irq_map_generic_chip,
 	.unmap  = irq_unmap_generic_chip,
 	.xlate	= irq_domain_xlate_onetwocell,
-- 
2.34.1

