Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8464ACB1C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbiBGVSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbiBGVSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:18:30 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7E0C061A73;
        Mon,  7 Feb 2022 13:18:27 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b9so29396740lfq.6;
        Mon, 07 Feb 2022 13:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3/Udx6MddBj6XcwtiKZbyxOoOI1dz9F34GThp2Ze/lo=;
        b=jgnmEPVa6cXu53T2QFDLqTGX7FoYOgHfXmNdJdqJeFWrKmoj7EEmes0Yldm25nEznu
         XFhERP/WQxELdmBp7V9+WQC1ENa1yFryCZbBptkZZ7fHbsUToR/l69i7YugmMi9byOcD
         QAwJBDKffCF4vdaeXLPjucidYmE1JBAq4NgMJ6JA520GwIgid00snN3MgctO7mUUI4Z4
         wRySp0shp/0c0D367Vh0ZFLEpDygTAJzre3uIrnUIj3I5OHULJNLpBXD8E824Ro7Slmw
         m9sHBrArwb7cLOViCSp9CdOa4+fQBPzNK8WSTpFLXEqVrMGPqtKQFqX2lT9bWFEgohDO
         qEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3/Udx6MddBj6XcwtiKZbyxOoOI1dz9F34GThp2Ze/lo=;
        b=yhC+UmhcRBR1H38I65vpLZAVqpyuzjwGJTP2VygaecGRYMjnfGZwyU9NcsS7ayBinU
         zeHMuOv8DngfZHij0qWE+wl0pv4qA5i6DqAi8l4Iq4oPe9ctdKJmeoCuS4x0tr58nIde
         ccas+BE/cAJzLxeJRhFhl412wM/j3gGcXkazLhdD1/1XLGv6s+wH/frzsuIWYNx3j5gP
         EjgY7tzj9U4Plou5R0tkyU8k/RPDlQKnTAZAbARp+QWlBsBhhKEGhfnc7KwTMmZaU63c
         mLRU3jcRKlsloTGZq4fD5cC8U9cTgTpSINYfBw7rZP0GWpUcbi0YCtt20E17xYEszeN3
         xI7g==
X-Gm-Message-State: AOAM531UHj+ylmQeiIFLDTJ9FYASVA6xRhnsZlAlk0OsuhZxTEEmGKeK
        6nppPxTJKRAr/ZhOXuK7A6g=
X-Google-Smtp-Source: ABdhPJwIa3zb4Y2vMPdilUAVSz4mIshUs3AGvEq8zwidaVLIK7J0SEJgv7/4jhBttwhtSnO2yns6dw==
X-Received: by 2002:a05:6512:131b:: with SMTP id x27mr479943lfu.96.1644268705666;
        Mon, 07 Feb 2022 13:18:25 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id s30sm1637978lfp.93.2022.02.07.13.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:18:25 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/3] MIPS: ath25: Constify static irq_domain_ops
Date:   Mon,  7 Feb 2022 22:18:15 +0100
Message-Id: <20220207211816.57860-3-rikard.falkeborn@gmail.com>
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
 arch/mips/ath25/ar2315.c | 2 +-
 arch/mips/ath25/ar5312.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index 76e43a73ba1b..8ccf167c167e 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -112,7 +112,7 @@ static int ar2315_misc_irq_map(struct irq_domain *d, unsigned irq,
 	return 0;
 }
 
-static struct irq_domain_ops ar2315_misc_irq_domain_ops = {
+static const struct irq_domain_ops ar2315_misc_irq_domain_ops = {
 	.map = ar2315_misc_irq_map,
 };
 
diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index 822b639dbd1e..cfa103518113 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -116,7 +116,7 @@ static int ar5312_misc_irq_map(struct irq_domain *d, unsigned irq,
 	return 0;
 }
 
-static struct irq_domain_ops ar5312_misc_irq_domain_ops = {
+static const struct irq_domain_ops ar5312_misc_irq_domain_ops = {
 	.map = ar5312_misc_irq_map,
 };
 
-- 
2.35.1

