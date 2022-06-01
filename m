Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ABC539F1A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350585AbiFAIMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348673AbiFAILy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:11:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C74FB7D7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:11:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so1341798pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GWjGR+uUnc6AYWehSdkH/qKXs6QNn54ho2G5cZ8+zoc=;
        b=lO2Wb90PRtDZzwh2kw70sxt7A/gYeEkNtkUsS3yqAgTMWQOTDGZva4fzz7aMr+4i5C
         DJAuNZ4iAMF68sPTRHzMJwT0Ko9mpjCrn5dt1zjSqBBanJ9PRMJxrCYZNz4YWoScI+1f
         tE3E9sl6Ug1NFOXH6ezkTyoj2yQg7spcEAyiADgR5vbMerxjw85BIzJx6mpN2QjVo2t7
         bdc20Jtg3vL2gHqJj4G3MOIICtESleFZOhnw3LRN/i+ngeEg78csnWrvfMl4QGJjwdbm
         SyXqchhjD+rYzhWdJtf7b3EAyHxKrGzJOCN9iK5lTZYEI4lrsn0WflvXFUnPLmiCCfYZ
         t+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GWjGR+uUnc6AYWehSdkH/qKXs6QNn54ho2G5cZ8+zoc=;
        b=BJv80sbtrPs9zPR5MC7F5vV7war3qCgnK+2JjLFxYS9Rq5+WYoh7aR7etMiA5yncot
         B2TPlKG1/uffgIRZOqKyZrpHyW6oRml2A/ote8RvdV9ooLFGfjcYTMQG0CFuKi5jHk8W
         rJySaBpypSJmaYBxgs/87ivVMFq+Ms3oUS7eWBVcpyaUOx/W1DAVyfjg3p620n9vH9Ph
         DjDHUKqlp8zRTC2Il0rBqUikm/Zd+x/x6QKXAHT4mY663pNbUQmejl8U4Oxf/kF7BKS4
         NcodctdQuZZjuwkvsD2bTeFm/fgVZEc/9nVn/enIC2SiCSiLKpbu62nAvePy4g41Z3yq
         ozcQ==
X-Gm-Message-State: AOAM530tGxt9Vbj8cWsOI6f+NkBW/W+y6RGpTG3is/qhKWu0Tzbjur8R
        wlFkIhpjXgI9/R2AGecfP0Y=
X-Google-Smtp-Source: ABdhPJyELGcS1L/91yKuLn5SIOvjSQzhnoeJComUUBK/MJj1z2x7Sd+TlkrWgVt8POtKp+07fMGkLQ==
X-Received: by 2002:a17:90b:1e4f:b0:1e0:b91:39ef with SMTP id pi15-20020a17090b1e4f00b001e00b9139efmr32876048pjb.51.1654071109571;
        Wed, 01 Jun 2022 01:11:49 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id y1-20020a17090ad0c100b001e2f3831102sm792288pjw.17.2022.06.01.01.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:11:49 -0700 (PDT)
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
Subject: [PATCH 3/6] irqchip/apple-aic: Fix refcount leak in aic_of_ic_init
Date:   Wed,  1 Jun 2022 12:09:27 +0400
Message-Id: <20220601080930.31005-4-linmq006@gmail.com>
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
Add missing of_node_put() to avoid refcount leak.

Fixes: a5e8801202b3 ("irqchip/apple-aic: Parse FIQ affinities from device-tree")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/irqchip/irq-apple-aic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 478d0af16d9f..5ac83185ff47 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -1144,6 +1144,7 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 		for_each_child_of_node(affs, chld)
 			build_fiq_affinity(irqc, chld);
 	}
+	of_node_put(affs);
 
 	set_handle_irq(aic_handle_irq);
 	set_handle_fiq(aic_handle_fiq);
-- 
2.25.1

