Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B754D2258
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350180AbiCHUMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349816AbiCHUMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:12:20 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF663BFAE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:11:23 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id g1so354878pfv.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OY3pa3G9JD3woXAIGpM5E3FP0EETrcSR7ogz+sSLuao=;
        b=Iv8yj1lw4mb+7oAmqqYXJj8XqS2ebfGzid3XKHww4S7suHRPZYzWPR0OWLC6eCV3MT
         JZo2BflCFOolEMHv95ovsD/KmJ1WvxPsHaBCgRBQyT8j743geAjemqYppqLFV/wfHY29
         2++GDRgv1T36RYbglaS5D5eG1SkmOaJ8Gi91Qffb2HuBD+vvT4QnZukDLnygSSjl7xhA
         aVcffdU2ftoyCbGzSfgoTo/utaUyPG85DCRzFCxFK4uojgh2pyqkaCz1U5e5+NPs0JLs
         +I6S/MxFDwY694Nr6p/WNUXMiVSb9B2WVFsnt8vG5byFW1StSss5GfHn/i29SwyjT3LI
         zZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OY3pa3G9JD3woXAIGpM5E3FP0EETrcSR7ogz+sSLuao=;
        b=QP/CXyZkxo3bSEthm1SOEHVHeeCT1RNE5TXta6hVpk/OwVZvuQO5yOgYHQajAQkynC
         hOYPmGxlI4gd+t+pYqh+hPcWknO49yfiuN7H6LBU9tU5Qufs8ynVVBq06xDu6oqJkZ8K
         V3D28k3mHtvCuGnd4/qFvHPnAmdESZMBFQapDkNOsCf+YKqkgm7etyarU96aRXJEvkDq
         eVxEfZworbaGAcgLfSWGf7utX5dN7VR1uXn1XDDDoW+uArJKPsUEZGP0HP11b4nB4G8z
         QhHZrKzdSwpIekVCm7qJP2qrCDUKcD5J6ND8ZSFpmidLxD9x07FY8YnEN9Zq6N071bV8
         07hA==
X-Gm-Message-State: AOAM532uiyNOFhKiJbPn+Qu/Fvv3Wy9cb31MMqKgHqk0JmJQHvOS8FDn
        zrQGroJAHBZ+rPko+D+SATpML8anqZQ=
X-Google-Smtp-Source: ABdhPJwSah1PEHIt8vsNbDi5eql8H2dnLGv3eUze1B7/G45TUdPuTktkSeFIsXG6Ax6I60yfqpOK/Q==
X-Received: by 2002:a05:6a00:1991:b0:4f7:1322:ca04 with SMTP id d17-20020a056a00199100b004f71322ca04mr9031438pfl.85.1646770282690;
        Tue, 08 Mar 2022 12:11:22 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a22-20020a056a000c9600b004f10137a096sm21958147pfv.50.2022.03.08.12.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:11:21 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip/gic: Improved warning about incorrect type
Date:   Tue,  8 Mar 2022 12:11:16 -0800
Message-Id: <20220308201117.3870678-1-f.fainelli@gmail.com>
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

Issue the warning for interrupt lines that have an incorrect interrupt
type and also print the hardware interrupt number to facilitate the
resolution of such problems.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-gic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b8bb46c65a97..6e4ef67325cc 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1077,7 +1077,8 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
 
 		/* Make it clear that broken DTs are... broken */
-		WARN_ON(*type == IRQ_TYPE_NONE);
+		WARN(*type == IRQ_TYPE_NONE,
+		     "HW irq %ld has invalid type\n", *hwirq);
 		return 0;
 	}
 
@@ -1088,7 +1089,8 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1];
 
-		WARN_ON(*type == IRQ_TYPE_NONE);
+		WARN(*type == IRQ_TYPE_NONE,
+		     "HW irq %ld has invalid type\n", *hwirq);
 		return 0;
 	}
 
-- 
2.25.1

