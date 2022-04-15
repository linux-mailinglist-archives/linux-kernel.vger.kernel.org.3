Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF158502D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355468AbiDOPjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356299AbiDOPj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:39:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728963DDD9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:37:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t1so11061985wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xf7zHgQF0LLYfyyhuEnZersihES6pOQgkISOqNV5ZRE=;
        b=xivuA2t3IqjLqIoQ9DSn1tMrItfP5C3kkoXLWvVqH9w2x08/1vOWwiFUeLyckHqQK7
         vANKxFbdrzik52hMtA8dmDDfP8zN7cEsf9psBAV4fFw2IJW5Kvi4WRQ2n/bblCJuagqX
         Fx2zCKxwYqijw8U0R9G7lFq7pqV1zofoFDnhFiXRcsiY7ce9odvnfWaF+Xl/pC+ND3BI
         94009nqeRJk3aFoGdIfdNXKhsJVSntrjRHiXylMsry0pwSVWdSSy1imAEcESzwkERfWP
         /NTB7H2oOoKDjiZnSwpJOA1R4z6V80qfUkxCKmYlepQLh57UdDOVMVKPzzPnAfsys7fJ
         kb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xf7zHgQF0LLYfyyhuEnZersihES6pOQgkISOqNV5ZRE=;
        b=vQjzbPVX9NgH19YFZyHO7ui4/sgK6ybWXmtn3JKuMefM7iKcjovVCWaTBb3XuoB8je
         itb/IJFYFcN5thIvApI5w9nu+1xXUG18S4pgppNoDy6uTsanUVeiPyGuruLRImqAUVhy
         Vpsrsnd7ZmXq6Ce4lfE4SD+cp+12d8oZwxGF3cNSQgIU4mi0elXDHAqm+V1DHmvWjkJT
         5Nb5rva6gksHXhb5pJV2vlKxq/mutP6u4LpcnsISiuLdfwijLDW+T5oeg5VSXbeuZtAQ
         Qh/3wqz75SVVaLzOLcJWDk83sJhH/Li1u9aFmFwvjNIlmWv6TUt/QNJ5BNzvv1NNzVjB
         PEKA==
X-Gm-Message-State: AOAM533Qsc+eGEUALpqGc2K/cInQl3aIq7j61fEJXv2EqjCld0sf2h95
        d3V1BXadZE56Z7lh4CYe/eZAJg==
X-Google-Smtp-Source: ABdhPJxQk5vHua4beVYxWbc+1z+j8NCqUCbLO9KGJcNxCFujTtigBhehGKkQbFGNgxlKqJVhVZebFA==
X-Received: by 2002:a05:6000:1684:b0:209:7fda:e3a with SMTP id y4-20020a056000168400b002097fda0e3amr5705338wrd.709.1650037020002;
        Fri, 15 Apr 2022 08:37:00 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc018000000b0038a18068cf5sm8459292wmb.15.2022.04.15.08.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:36:59 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] mfd: mt6397-core: add resources for PMIC keys for MT6359
Date:   Fri, 15 Apr 2022 17:36:25 +0200
Message-Id: <20220415153629.1817202-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415153629.1817202-1-fparent@baylibre.com>
References: <20220415153629.1817202-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the MFD resources in order to be able to probe and use the keyboard
driver for the MT6359 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/mfd/mt6397-core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index bddb40054b9e..1a368ad08f58 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -54,6 +54,13 @@ static const struct resource mt6358_keys_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6358_IRQ_HOMEKEY_R, "homekey_r"),
 };
 
+static const struct resource mt6359_keys_resources[] = {
+	DEFINE_RES_IRQ_NAMED(MT6359_IRQ_PWRKEY, "powerkey"),
+	DEFINE_RES_IRQ_NAMED(MT6359_IRQ_HOMEKEY, "homekey"),
+	DEFINE_RES_IRQ_NAMED(MT6359_IRQ_PWRKEY_R, "powerkey_r"),
+	DEFINE_RES_IRQ_NAMED(MT6359_IRQ_HOMEKEY_R, "homekey_r"),
+};
+
 static const struct resource mt6323_keys_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_PWRKEY, "powerkey"),
 	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_FCHRKEY, "homekey"),
@@ -122,6 +129,12 @@ static const struct mfd_cell mt6359_devs[] = {
 		.of_compatible = "mediatek,mt6358-rtc",
 	},
 	{ .name = "mt6359-sound", },
+	{
+		.name = "mtk-pmic-keys",
+		.num_resources = ARRAY_SIZE(mt6359_keys_resources),
+		.resources = mt6359_keys_resources,
+		.of_compatible = "mediatek,mt6359-keys"
+	},
 };
 
 static const struct mfd_cell mt6397_devs[] = {
-- 
2.35.2

