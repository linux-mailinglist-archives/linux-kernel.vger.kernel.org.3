Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87279556EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376907AbiFVW6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376778AbiFVW6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:58:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBBE3EF08
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:58:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n1so25178042wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jTgx8LlrV7VzfSAHm0aCpzWkqLuJ2p9NbNXPOJETWQA=;
        b=fmpkVEhXK4yJYvB+KQn0wvRcKJMjKVYlKQ9kpZzHQQfz94NXhacdSvniNKSMKYswC8
         jxcWauK1qf8CRwK3LQb+mGMAc6l8M0UBMtbP3Ui69a6WT15FTXL8Z8e4tX1B76XuOG1/
         pmioBquwiCqDixFjGp3qE+fuZFNCO5JJ1izNUtyEZhfqVXCGD57PiZtzgmts5i4z0mYB
         bjfSEVMoYLcZt7xwHIGtkB716T4GLhLGR+SPI8lve5FTjK7BWDZoiuyrqe1a6MeLBw/k
         2uz8BJy/Vtb1N8BjP2A7D9FKefK5gBO5vj6iz0We8LoYzvY4iiIs7D1FPRS8cq5U3U20
         CAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jTgx8LlrV7VzfSAHm0aCpzWkqLuJ2p9NbNXPOJETWQA=;
        b=59mNJvayfw3fGGYkB0Qsh6iG7WQDQzdBHtnLYYsXAl4JbS1Q8XqjHlveW9QLA/fUjw
         PRQLeL1V4lytGZfBWHnohbIA3UritIk6/2OPiFCS2LBohka+n024SALVs5k4AswXa3Wf
         +7XQ13GIrNylHzeQJ3wA/0gmdQ8fdjVqzeDTzXfbx+G9T/c5bdTMvp9FgK3i3Fc7tqsJ
         5gf7rIaBD6XWqbdhkdr2W490cw8YTBqQopOrVybVKhqGESiFEsKEYYWI3iBuJTBAm1N8
         QUteorBwdQpDOhdpvt/gx+fdXMfNzkOL+xk7ohzTgICSsDE8M5xJtgbfbso94flSNJz9
         X8oA==
X-Gm-Message-State: AJIora8YbV2rXn9C/lvfwJmyipw4k4xTgMpWfMuOeVtmys+fbLeJszou
        XD3WWfZTDxgmrw7FwNCR95W6LQ==
X-Google-Smtp-Source: AGRyM1uGgD1sCP490YQxm47iNCS04Crh/Cbzsildj6s05FTWtiAOE5LFiKCg5wzFGLXZzckLm86mXg==
X-Received: by 2002:a05:6000:2ce:b0:218:544d:432f with SMTP id o14-20020a05600002ce00b00218544d432fmr5334377wry.580.1655938729169;
        Wed, 22 Jun 2022 15:58:49 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id f8-20020a1cc908000000b0039c99f61e5bsm851458wmb.5.2022.06.22.15.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:58:48 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     palmer@rivosinc.com, palmer@dabbelt.com
Cc:     Conor.Dooley@microchip.com, Cyril.Jean@microchip.com,
        Daire.McNamara@microchip.com, Lewis.Hanly@microchip.com,
        aou@eecs.berkeley.edu, arnd@arndb.de, gregkh@linuxfoundation.org,
        herbert@gondor.apana.org.au, kw@linux.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        lorenzo.pieralisi@arm.com, mturquette@baylibre.com,
        paul.walmsley@sifive.com, robh@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [RESEND PATCH v4] MAINTAINERS: add polarfire rng, pci and clock drivers
Date:   Wed, 22 Jun 2022 23:58:23 +0100
Message-Id: <20220622225822.2166305-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
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

From: Conor Dooley <conor.dooley@microchip.com>

Hardware random, PCI and clock drivers for the PolarFire SoC have been
upstreamed but are not covered by the MAINTAINERS entry, so add them.
Daire is the author of the clock & PCI drivers, so add him as a
maintainer in place of Lewis.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..01a7bfa49bdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17136,12 +17136,15 @@ N:	riscv
 K:	riscv
 
 RISC-V/MICROCHIP POLARFIRE SOC SUPPORT
-M:	Lewis Hanly <lewis.hanly@microchip.com>
 M:	Conor Dooley <conor.dooley@microchip.com>
+M:	Daire McNamara <daire.mcnamara@microchip.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
 F:	arch/riscv/boot/dts/microchip/
+F:	drivers/char/hw_random/mpfs-rng.c
+F:	drivers/clk/microchip/clk-mpfs.c
 F:	drivers/mailbox/mailbox-mpfs.c
+F:	drivers/pci/controller/pcie-microchip-host.c
 F:	drivers/soc/microchip/
 F:	include/soc/microchip/mpfs.h
 
-- 
2.36.1

