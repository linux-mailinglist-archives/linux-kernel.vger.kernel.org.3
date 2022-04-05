Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4724F4EEF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582794AbiDEXtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573271AbiDESlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:41:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77622124B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 443B1616C5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A454C385A3;
        Tue,  5 Apr 2022 18:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649183944;
        bh=v+twvuAPSyK4b9502wrkUr1BlR4MnKo9qztL8KChOdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pv/LoVtXOikiDXbs7bvRbuyDMtSYWg3kDLXSm5gSlnXCaEDv8ryyXjbIGSmiISwCQ
         wyDN7BH5runsczVlOX1mNta4Ix1KXHlnwYSTfbvSChDhmoCtqbWI/rC6JkcF30GxzB
         vewmoNYu8MPfREU7T8OFmhmpXRBDRyzYocN5V8D0CJ7EkS6/VrD9gcxqhEMK6tUJIb
         pbT8gvjm3hS2sDVrm6MG4Mpgryubw25r2KH9VquuPGTDM1WP1paP5DiukvMJskpGxR
         UenfyqZD+PyIRpqNBCM5nGzl9UfCzmD/yVMXA1/82JZhkTft9bMEj95fk+ZrP/tm3w
         hsY3Qx5PU4bXg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nbo50-001tkq-8e; Tue, 05 Apr 2022 19:39:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v2 1/3] irqchip/gic-v3: Exposes bit values for GICR_CTLR.{IR,CES}
Date:   Tue,  5 Apr 2022 19:38:55 +0100
Message-Id: <20220405183857.205960-2-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405183857.205960-1-maz@kernel.org>
References: <20220405183857.205960-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, andre.przywara@arm.com, tglx@linutronix.de, eric.auger@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we're about to expose GICR_CTLR.{IR,CES} to guests, populate
the include file with the architectural values.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqchip/arm-gic-v3.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 12d91f0dedf9..728691365464 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -127,6 +127,8 @@
 #define GICR_PIDR2			GICD_PIDR2
 
 #define GICR_CTLR_ENABLE_LPIS		(1UL << 0)
+#define GICR_CTLR_CES			(1UL << 1)
+#define GICR_CTLR_IR			(1UL << 2)
 #define GICR_CTLR_RWP			(1UL << 3)
 
 #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)
-- 
2.34.1

