Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48C539F19
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350599AbiFAIMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350568AbiFAIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:12:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0FA255A7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:11:59 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s68so1198204pgs.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CjxfEwNZAv/Ns2YjhAVktI1vfhpKFNGdsrqBv+NvOkk=;
        b=aKhB0zYrAcHE9EQYEKT2g7DsA3648OnKR/M8ytLi01NrDKBfQOWtxZ0GlOwRXPWShx
         8X3OUs/gp80cLKaoNhpPXvuvrdxOQw7cpf+jK0webG1TA85XOEfve62vpkGjXVOkid2+
         6UL51qe0apR+nNwdNVXcSeY83YA5GKWB8H6meLszdRK8DIkJHe13oLACV4sQvvQqcSQB
         RcDaxRIkVlA8g1ym8drygJvmSLNOwhtQuLCtmb4jhLNFwrMgHRQuF2u0UtTcmGShGOpI
         7SreIHf38Ouddqe27CWE6Te3i0BxNVWqHQE4qw3F69h6z4TIn36NR2ZEMhYyy/U6OvyS
         BZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CjxfEwNZAv/Ns2YjhAVktI1vfhpKFNGdsrqBv+NvOkk=;
        b=xVWtMBekaySKys63Go2a2iU6qFK5tPKkcbJMzD0MWHL+VXO3H2cTpwM6fXvjTuTToM
         YjNlb+/Vi5C8QuaUI3MhF9c1XNg4dVsvamaejRy4QSC4aausjK5Kc5lnZSsh7d/6E0Jw
         Z1o+khgtt0lEloNfCg1wMzIN3YZMe1T937JZKTf6/0lJgeItnhfWe9y6/SP/sk3kdilA
         bt71AxyGpaQZ9v7BeJPcq8G+SuNMdSMPrucY/Nl81DxVdKVBWK7jaBFbnJqlMt4/tff8
         KOgJRa1fro3xn0x7/Cv+ES3Lgnd0NLwMlv/UJRSxuQfdbDLxd6Ee+zZN9jyuR4tH5LPw
         N64g==
X-Gm-Message-State: AOAM533vG5GpfBwXaLWKT3TVzN6thsc7JArWn2GrESdjDAqkSnQqLfIQ
        51uMKjkHycYYLpk1heMs7Z4=
X-Google-Smtp-Source: ABdhPJxjBIdiCetN9iBXLJVU/D5c4YBixW5Uqour1lmH8glwsFGvDrj0ZkgjEyCEoOM6tS+5L/X6GQ==
X-Received: by 2002:a63:184d:0:b0:3fb:74ce:effa with SMTP id 13-20020a63184d000000b003fb74ceeffamr23908491pgy.621.1654071119384;
        Wed, 01 Jun 2022 01:11:59 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id y1-20020a17090ad0c100b001e2f3831102sm792288pjw.17.2022.06.01.01.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:11:58 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        John Crispin <john@phrozen.org>,
        Bert Vermeulen <bert@biot.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH 4/6] irqchip/gic-v3: Fix error handling in gic_populate_ppi_partitions
Date:   Wed,  1 Jun 2022 12:09:28 +0400
Message-Id: <20220601080930.31005-5-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601080930.31005-1-linmq006@gmail.com>
References: <20220601080930.31005-1-linmq006@gmail.com>
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

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
When kcalloc fails, it missing of_node_put() and results in refcount
leak. Fix this by goto out_put_node label.

Fixes: 52085d3f2028 ("irqchip/gic-v3: Dynamically allocate PPI partition descriptors")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 2be8dea6b6b0..1d5b4755a27e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1932,7 +1932,7 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 
 	gic_data.ppi_descs = kcalloc(gic_data.ppi_nr, sizeof(*gic_data.ppi_descs), GFP_KERNEL);
 	if (!gic_data.ppi_descs)
-		return;
+		goto out_put_node;
 
 	nr_parts = of_get_child_count(parts_node);
 
-- 
2.25.1

