Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03153F1D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiFFVkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiFFVkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:40:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3687C7D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:39:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q26so11149167wra.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 14:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jamieiles.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=em1IHn0NxzIl6+tjg4rJxJdRlPkWKD7AgY1X7ddtRrM=;
        b=PHRW+YfAlgWwd60JmJEEDEJP2sVLw53JUSsTkW9zNS0P/ED1ryIG7B9OSAw2TggkXj
         ooWrYKeHGlOVcj3WNWzvPVvRo3NB4MXiZKoRPJQjyTE4N85wkzgMDiw75TGNDJhe1fzd
         OpLAKj2XG13c3GNy4uuzp4dpYs8gHiJEQFs4+c6Sn/3lOmnO0q0qo+O7YEN1NLzvyyhs
         XTQFzURvE8CyIYny+j8qSEnXI2fYXXm90VmVAFRWUV4pSE+DFmZIu1FKyYRlJCZiOOUe
         ZUqirYWIhBiCpvsKUgnpXOwxiQtjFoY2DBsXwEkUIN6s5jdrCS+ZrJdu1cRc9ltTAOS/
         ZWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=em1IHn0NxzIl6+tjg4rJxJdRlPkWKD7AgY1X7ddtRrM=;
        b=nKafy8+lSAio/q5sEoDapwVAvXLX4njJiIRJG7Co9Og5gm20dZIV6nmAKlVXvuBITW
         3MjDLd4VOkOPK6WuFC86yXTaQl0zWasaCnpS9A/WDtsCYk4DyDUAMz36wCIzQ5ixWi8z
         KjuyWq3W9veB9QLFE7JSWA8Oyn2yjGeD2BmMHcB8tmyIl0OhS47dQuaNUw8PwXz8Cvx+
         AJxUMbv46/BBXKd+/K3/2dcU6Gd2UFrnwrPxF8MGkMvXqc9v8VM0dIZrdbY0CfAF9WOM
         t0wrSI9ajBDKtYrVuhCirn+02xMDiKkV4gcq0e4xcOTtV3S9H/qQXzDqo6HPfAeKhqkF
         z+8A==
X-Gm-Message-State: AOAM530wSbrQwT9R+Lns0uStfh8Z2IgNUqCGsZiJqqzxGmXZbNwLijB9
        YZdPb70qkL6Gs1Qs013wpbH6FyJogPmuUA==
X-Google-Smtp-Source: ABdhPJwPvYCfZ2Z5iAmLoI+neaQu7PlpV7jFLc7ozHLUJhBTWgprVmLtP2p6/63Lsy83Ura6nQh87A==
X-Received: by 2002:a5d:54c3:0:b0:210:2a28:5666 with SMTP id x3-20020a5d54c3000000b002102a285666mr23930277wrv.345.1654551596120;
        Mon, 06 Jun 2022 14:39:56 -0700 (PDT)
Received: from localhost ([5.181.106.148])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b0039466988f6csm27918836wmq.31.2022.06.06.14.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:39:55 -0700 (PDT)
From:   Jamie Iles <jamie@jamieiles.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, maz@kernel.org
Cc:     michal.simek@xilinx.com, Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH] irqchip/xilinx: remove microblaze+zynq dependency
Date:   Mon,  6 Jun 2022 22:39:52 +0100
Message-Id: <20220606213952.298686-1-jamie@jamieiles.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xilinx IRQ controller doesn't really have any architecture
dependencies - it's a generic AXI component that can be used for any
FPGA core from Zynq hard processor systems to microblaze+riscv soft
cores and more.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 15edb9a6fcae..a81d57677a39 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -286,7 +286,7 @@ config XTENSA_MX
 
 config XILINX_INTC
 	bool "Xilinx Interrupt Controller IP"
-	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP
+	depends on OF
 	select IRQ_DOMAIN
 	help
 	  Support for the Xilinx Interrupt Controller IP core.
-- 
2.34.1

