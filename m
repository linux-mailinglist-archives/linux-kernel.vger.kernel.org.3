Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54484ACB18
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiBGVS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbiBGVS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:18:27 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4152AC06173B;
        Mon,  7 Feb 2022 13:18:26 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z20so21586428ljo.6;
        Mon, 07 Feb 2022 13:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgr18DbTVjSE1ID/eUYZdFdfvhErb3HHLm5xvbBJepM=;
        b=mtg9bScP+gXWHAp+MMX0Q8txU3MWLUic9iK1a7pPjL/Rx1JpMVFiBgb3h/r20PnUyr
         AhVXAulMWKM2nFfJt0OSun0490VQfQcPNKW1IQKwU8RTntr7AEu4qi1aZdOH/VO/Vnrr
         /mzJ+V3kK7suq9wfyJX6fek88ey42+PBc+JYfEQj31Flp3HYMtHfjV3enYYqpoQtFuwO
         4po7LMzjNjVF33OOLCHgWaf726GyslQRnnb9WZpNoOLcQHVlyIQLgqJaZyY6Z8aDyMoe
         NjM9bAfAOcqNCIaJNGIvks/hZvLqiOiByMYAhtEx0AEaCXZMTblyjcgozIggNGudK8Aj
         +6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgr18DbTVjSE1ID/eUYZdFdfvhErb3HHLm5xvbBJepM=;
        b=IAfnNZy9xq3NQVKE4bZePFQIWXyTeBQJEsMDpOKV0aNm0mdEr2j2ssN2kFU1TL34mB
         qAnJaoWFcOzXBWY+Q67VS7RYqojj/Voes4wu0ZCVSdYkKPCHT3XXowqnf5Q6mYNvSUJ/
         YOgxmbyZEQ27MPDovEU80wSz5y653Yib1KOrsGh/N+JUkkQZMyHwPDJ5dsAKPikqArTg
         twItPcDlq0fkSAFGvj0mjwOfQ3gL6ruc8rHcE/P58fSSx0EoE7hNt28woTGZTjohvTWn
         ZnVJVHrCkusVFD6JsaR+2ItdBCOHB357/Ktxm78+ikK6QxFNsgWR44ZuFLN4dPel/5Mu
         B8Sg==
X-Gm-Message-State: AOAM533ruBDXZOWgfeFL71IeMV9X0Nqw3SpjmNDKThgJAPzIgSL6e3Qw
        S92tTu+9tJTWl+XWwKLz1kQ=
X-Google-Smtp-Source: ABdhPJzn7RBwbAMw+8YBS5Qho5rdh3V4+mjFFZghC2nf+BHTv35gSBIMo1t+Djn4dT1R2v+euGorgw==
X-Received: by 2002:a2e:94cf:: with SMTP id r15mr850226ljh.492.1644268704671;
        Mon, 07 Feb 2022 13:18:24 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id s30sm1637978lfp.93.2022.02.07.13.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:18:24 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/3] MIPS: OCTEON: Constify static irq_domain_ops
Date:   Mon,  7 Feb 2022 22:18:14 +0100
Message-Id: <20220207211816.57860-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207211816.57860-1-rikard.falkeborn@gmail.com>
References: <20220207211816.57860-1-rikard.falkeborn@gmail.com>
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

The only usage of these structs is to pass their address to either
irq_domain_add_tree() or irq_domain_create_linear(), both which takes
pointers to const struct irq_domain_ops. Make them const to allow the
compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 arch/mips/cavium-octeon/octeon-irq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 844f882096e6..07d7ff5a981d 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1274,13 +1274,13 @@ static int octeon_irq_gpio_map(struct irq_domain *d,
 	return r;
 }
 
-static struct irq_domain_ops octeon_irq_domain_ciu_ops = {
+static const struct irq_domain_ops octeon_irq_domain_ciu_ops = {
 	.map = octeon_irq_ciu_map,
 	.unmap = octeon_irq_free_cd,
 	.xlate = octeon_irq_ciu_xlat,
 };
 
-static struct irq_domain_ops octeon_irq_domain_gpio_ops = {
+static const struct irq_domain_ops octeon_irq_domain_gpio_ops = {
 	.map = octeon_irq_gpio_map,
 	.unmap = octeon_irq_free_cd,
 	.xlate = octeon_irq_gpio_xlat,
@@ -1974,7 +1974,7 @@ static int octeon_irq_ciu2_map(struct irq_domain *d,
 	return 0;
 }
 
-static struct irq_domain_ops octeon_irq_domain_ciu2_ops = {
+static const struct irq_domain_ops octeon_irq_domain_ciu2_ops = {
 	.map = octeon_irq_ciu2_map,
 	.unmap = octeon_irq_free_cd,
 	.xlate = octeon_irq_ciu2_xlat,
@@ -2226,7 +2226,7 @@ static int octeon_irq_cib_map(struct irq_domain *d,
 	return 0;
 }
 
-static struct irq_domain_ops octeon_irq_domain_cib_ops = {
+static const struct irq_domain_ops octeon_irq_domain_cib_ops = {
 	.map = octeon_irq_cib_map,
 	.unmap = octeon_irq_free_cd,
 	.xlate = octeon_irq_cib_xlat,
@@ -2578,7 +2578,7 @@ static int octeon_irq_ciu3_map(struct irq_domain *d,
 	return octeon_irq_ciu3_mapx(d, virq, hw, &octeon_irq_chip_ciu3);
 }
 
-static struct irq_domain_ops octeon_dflt_domain_ciu3_ops = {
+static const struct irq_domain_ops octeon_dflt_domain_ciu3_ops = {
 	.map = octeon_irq_ciu3_map,
 	.unmap = octeon_irq_free_cd,
 	.xlate = octeon_irq_ciu3_xlat,
-- 
2.35.1

