Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E20455DC97
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbiF0OV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbiF0OUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:20:45 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC25101FD;
        Mon, 27 Jun 2022 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kANBTyjo8cVvUxUMXvtoZL5Cy0kO7CpDsfY6ScJagNY=; b=S/9jk11seetK/vAh/u/FtwyAJb
        o4qeKpWdaS4HETJbGg9CyKlNZifLTmfRWLcSSKaNQHqf4TKf/efs808cYUp8tfRvG3rKYoTUhdahv
        AUTe+o3Kv+c8vukBkC9x5x6SZqBjbG6Sbdt+3kkCbjcs34hjHdYMpCU1ELRLMkGsBBmbeAN0Ob1Oa
        wA33NEi6hBQhff84Z16QrYNhnUW5gF621Y9d9Na8qMcrdp9/+0wO+sQi3S5zQohPLzbj5FsfJObSb
        IsuKdCjWHmzI4ZTz5TOAYLgEYYCDghdYRB+BUk29BJG4DE3/ag3o4Dl+2S9VRaWljSRC4Ujt6h56g
        4c9JvPkg==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1o5pbN-003N2J-GV; Mon, 27 Jun 2022 17:20:32 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7/v3 13/22] gpu: host1x: Deduplicate hardware headers
Date:   Mon, 27 Jun 2022 17:19:59 +0300
Message-Id: <20220627142008.2072474-14-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627142008.2072474-1-cyndis@kapsi.fi>
References: <20220627142008.2072474-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Host1x class information and opcodes are unchanged or backwards
compatible across SoCs so let's not duplicate them for each one
but have them in a shared header file.

At the same time, add opcode functions for acquire/release_mlock.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/hw/host1x01_hardware.h | 114 +---------------
 drivers/gpu/host1x/hw/host1x02_hardware.h | 113 +---------------
 drivers/gpu/host1x/hw/host1x04_hardware.h | 113 +---------------
 drivers/gpu/host1x/hw/host1x05_hardware.h | 113 +---------------
 drivers/gpu/host1x/hw/host1x06_hardware.h | 128 +-----------------
 drivers/gpu/host1x/hw/host1x07_hardware.h | 128 +-----------------
 drivers/gpu/host1x/hw/opcodes.h           | 150 ++++++++++++++++++++++
 7 files changed, 156 insertions(+), 703 deletions(-)
 create mode 100644 drivers/gpu/host1x/hw/opcodes.h

diff --git a/drivers/gpu/host1x/hw/host1x01_hardware.h b/drivers/gpu/host1x/hw/host1x01_hardware.h
index fe59df1d3dc3..cb93d7c1808c 100644
--- a/drivers/gpu/host1x/hw/host1x01_hardware.h
+++ b/drivers/gpu/host1x/hw/host1x01_hardware.h
@@ -15,118 +15,6 @@
 #include "hw_host1x01_sync.h"
 #include "hw_host1x01_uclass.h"
 
-static inline u32 host1x_class_host_wait_syncpt(
-	unsigned indx, unsigned threshold)
-{
-	return host1x_uclass_wait_syncpt_indx_f(indx)
-		| host1x_uclass_wait_syncpt_thresh_f(threshold);
-}
-
-static inline u32 host1x_class_host_load_syncpt_base(
-	unsigned indx, unsigned threshold)
-{
-	return host1x_uclass_load_syncpt_base_base_indx_f(indx)
-		| host1x_uclass_load_syncpt_base_value_f(threshold);
-}
-
-static inline u32 host1x_class_host_wait_syncpt_base(
-	unsigned indx, unsigned base_indx, unsigned offset)
-{
-	return host1x_uclass_wait_syncpt_base_indx_f(indx)
-		| host1x_uclass_wait_syncpt_base_base_indx_f(base_indx)
-		| host1x_uclass_wait_syncpt_base_offset_f(offset);
-}
-
-static inline u32 host1x_class_host_incr_syncpt_base(
-	unsigned base_indx, unsigned offset)
-{
-	return host1x_uclass_incr_syncpt_base_base_indx_f(base_indx)
-		| host1x_uclass_incr_syncpt_base_offset_f(offset);
-}
-
-static inline u32 host1x_class_host_incr_syncpt(
-	unsigned cond, unsigned indx)
-{
-	return host1x_uclass_incr_syncpt_cond_f(cond)
-		| host1x_uclass_incr_syncpt_indx_f(indx);
-}
-
-static inline u32 host1x_class_host_indoff_reg_write(
-	unsigned mod_id, unsigned offset, bool auto_inc)
-{
-	u32 v = host1x_uclass_indoff_indbe_f(0xf)
-		| host1x_uclass_indoff_indmodid_f(mod_id)
-		| host1x_uclass_indoff_indroffset_f(offset);
-	if (auto_inc)
-		v |= host1x_uclass_indoff_autoinc_f(1);
-	return v;
-}
-
-static inline u32 host1x_class_host_indoff_reg_read(
-	unsigned mod_id, unsigned offset, bool auto_inc)
-{
-	u32 v = host1x_uclass_indoff_indmodid_f(mod_id)
-		| host1x_uclass_indoff_indroffset_f(offset)
-		| host1x_uclass_indoff_rwn_read_v();
-	if (auto_inc)
-		v |= host1x_uclass_indoff_autoinc_f(1);
-	return v;
-}
-
-
-/* cdma opcodes */
-static inline u32 host1x_opcode_setclass(
-	unsigned class_id, unsigned offset, unsigned mask)
-{
-	return (0 << 28) | (offset << 16) | (class_id << 6) | mask;
-}
-
-static inline u32 host1x_opcode_incr(unsigned offset, unsigned count)
-{
-	return (1 << 28) | (offset << 16) | count;
-}
-
-static inline u32 host1x_opcode_nonincr(unsigned offset, unsigned count)
-{
-	return (2 << 28) | (offset << 16) | count;
-}
-
-static inline u32 host1x_opcode_mask(unsigned offset, unsigned mask)
-{
-	return (3 << 28) | (offset << 16) | mask;
-}
-
-static inline u32 host1x_opcode_imm(unsigned offset, unsigned value)
-{
-	return (4 << 28) | (offset << 16) | value;
-}
-
-static inline u32 host1x_opcode_imm_incr_syncpt(unsigned cond, unsigned indx)
-{
-	return host1x_opcode_imm(host1x_uclass_incr_syncpt_r(),
-		host1x_class_host_incr_syncpt(cond, indx));
-}
-
-static inline u32 host1x_opcode_restart(unsigned address)
-{
-	return (5 << 28) | (address >> 4);
-}
-
-static inline u32 host1x_opcode_gather(unsigned count)
-{
-	return (6 << 28) | count;
-}
-
-static inline u32 host1x_opcode_gather_nonincr(unsigned offset,	unsigned count)
-{
-	return (6 << 28) | (offset << 16) | BIT(15) | count;
-}
-
-static inline u32 host1x_opcode_gather_incr(unsigned offset, unsigned count)
-{
-	return (6 << 28) | (offset << 16) | BIT(15) | BIT(14) | count;
-}
-
-#define HOST1X_OPCODE_NOP host1x_opcode_nonincr(0, 0)
+#include "opcodes.h"
 
 #endif
diff --git a/drivers/gpu/host1x/hw/host1x02_hardware.h b/drivers/gpu/host1x/hw/host1x02_hardware.h
index af60d7fb016d..2d1282b9bc33 100644
--- a/drivers/gpu/host1x/hw/host1x02_hardware.h
+++ b/drivers/gpu/host1x/hw/host1x02_hardware.h
@@ -15,117 +15,6 @@
 #include "hw_host1x02_sync.h"
 #include "hw_host1x02_uclass.h"
 
-static inline u32 host1x_class_host_wait_syncpt(
-	unsigned indx, unsigned threshold)
-{
-	return host1x_uclass_wait_syncpt_indx_f(indx)
-		| host1x_uclass_wait_syncpt_thresh_f(threshold);
-}
-
-static inline u32 host1x_class_host_load_syncpt_base(
-	unsigned indx, unsigned threshold)
-{
-	return host1x_uclass_load_syncpt_base_base_indx_f(indx)
-		| host1x_uclass_load_syncpt_base_value_f(threshold);
-}
-
-static inline u32 host1x_class_host_wait_syncpt_base(
-	unsigned indx, unsigned base_indx, unsigned offset)
-{
-	return host1x_uclass_wait_syncpt_base_indx_f(indx)
-		| host1x_uclass_wait_syncpt_base_base_indx_f(base_indx)
-		| host1x_uclass_wait_syncpt_base_offset_f(offset);
-}
-
-static inline u32 host1x_class_host_incr_syncpt_base(
-	unsigned base_indx, unsigned offset)
-{
-	return host1x_uclass_incr_syncpt_base_base_indx_f(base_indx)
-		| host1x_uclass_incr_syncpt_base_offset_f(offset);
-}
-
-static inline u32 host1x_class_host_incr_syncpt(
-	unsigned cond, unsigned indx)
-{
-	return host1x_uclass_incr_syncpt_cond_f(cond)
-		| host1x_uclass_incr_syncpt_indx_f(indx);
-}
-
-static inline u32 host1x_class_host_indoff_reg_write(
-	unsigned mod_id, unsigned offset, bool auto_inc)
-{
-	u32 v = host1x_uclass_indoff_indbe_f(0xf)
-		| host1x_uclass_indoff_indmodid_f(mod_id)
-		| host1x_uclass_indoff_indroffset_f(offset);
-	if (auto_inc)
-		v |= host1x_uclass_indoff_autoinc_f(1);
-	return v;
-}
-
-static inline u32 host1x_class_host_indoff_reg_read(
-	unsigned mod_id, unsigned offset, bool auto_inc)
-{
-	u32 v = host1x_uclass_indoff_indmodid_f(mod_id)
-		| host1x_uclass_indoff_indroffset_f(offset)
-		| host1x_uclass_indoff_rwn_read_v();
-	if (auto_inc)
-		v |= host1x_uclass_indoff_autoinc_f(1);
-	return v;
-}
-
-/* cdma opcodes */
-static inline u32 host1x_opcode_setclass(
-	unsigned class_id, unsigned offset, unsigned mask)
-{
-	return (0 << 28) | (offset << 16) | (class_id << 6) | mask;
-}
-
-static inline u32 host1x_opcode_incr(unsigned offset, unsigned count)
-{
-	return (1 << 28) | (offset << 16) | count;
-}
-
-static inline u32 host1x_opcode_nonincr(unsigned offset, unsigned count)
-{
-	return (2 << 28) | (offset << 16) | count;
-}
-
-static inline u32 host1x_opcode_mask(unsigned offset, unsigned mask)
-{
-	return (3 << 28) | (offset << 16) | mask;
-}
-
-static inline u32 host1x_opcode_imm(unsigned offset, unsigned value)
-{
-	return (4 << 28) | (offset << 16) | value;
-}
-
-static inline u32 host1x_opcode_imm_incr_syncpt(unsigned cond, unsigned indx)
-{
-	return host1x_opcode_imm(host1x_uclass_incr_syncpt_r(),
-		host1x_class_host_incr_syncpt(cond, indx));
-}
-
-static inline u32 host1x_opcode_restart(unsigned address)
-{
-	return (5 << 28) | (address >> 4);
-}
-
-static inline u32 host1x_opcode_gather(unsigned count)
-{
-	return (6 << 28) | count;
-}
-
-static inline u32 host1x_opcode_gather_nonincr(unsigned offset,	unsigned count)
-{
-	return (6 << 28) | (offset << 16) | BIT(15) | count;
-}
-
-static inline u32 host1x_opcode_gather_incr(unsigned offset, unsigned count)
-{
-	return (6 << 28) | (offset << 16) | BIT(15) | BIT(14) | count;
-}
-
-#define HOST1X_OPCODE_NOP host1x_opcode_nonincr(0, 0)
+#include "opcodes.h"
 
 #endif
diff --git a/drivers/gpu/host1x/hw/host1x04_hardware.h b/drivers/gpu/host1x/hw/host1x04_hardware.h
index 4f9bcddf27e3..84d244e8af30 100644
--- a/drivers/gpu/host1x/hw/host1x04_hardware.h
+++ b/drivers/gpu/host1x/hw/host1x04_hardware.h
@@ -15,117 +15,6 @@
 #include "hw_host1x04_sync.h"
 #include "hw_host1x04_uclass.h"
 
-static inline u32 host1x_class_host_wait_syncpt(
-	unsigned indx, unsigned threshold)
-{
-	return host1x_uclass_wait_syncpt_indx_f(indx)
-		| host1x_uclass_wait_syncpt_thresh_f(threshold);
-}
-
-static inline u32 host1x_class_host_load_syncpt_base(
-	unsigned indx, unsigned threshold)
-{
-	return host1x_uclass_load_syncpt_base_base_indx_f(indx)
-		| host1x_uclass_load_syncpt_base_value_f(threshold);
-}
-
-static inline u32 host1x_class_host_wait_syncpt_base(
-	unsigned indx, unsigned base_indx, unsigned offset)
-{
-	return host1x_uclass_wait_syncpt_base_indx_f(indx)
-		| host1x_uclass_wait_syncpt_base_base_indx_f(base_indx)
-		| host1x_uclass_wait_syncpt_base_offset_f(offset);
-}
-
-static inline u32 host1x_class_host_incr_syncpt_base(
-	unsigned base_indx, unsigned offset)
-{
-	return host1x_uclass_incr_syncpt_base_base_indx_f(base_indx)
-		| host1x_uclass_incr_syncpt_base_offset_f(offset);
-}
-
-static inline u32 host1x_class_host_incr_syncpt(
-	unsigned cond, unsigned indx)
-{
-	return host1x_uclass_incr_syncpt_cond_f(cond)
-		| host1x_uclass_incr_syncpt_indx_f(indx);
-}
-
-static inline u32 host1x_class_host_indoff_reg_write(
-	unsigned mod_id, unsigned offset, bool auto_inc)
-{
-	u32 v = host1x_uclass_indoff_indbe_f(0xf)
-		| host1x_uclass_indoff_indmodid_f(mod_id)
-		| host1x_uclass_indoff_indroffset_f(offset);
-	if (auto_inc)
-		v |= host1x_uclass_indoff_autoinc_f(1);
-	return v;
-}
-
-static inline u32 host1x_class_host_indoff_reg_read(
-	unsigned mod_id, unsigned offset, bool auto_inc)
-{
-	u32 v = host1x_uclass_indoff_indmodid_f(mod_id)
-		| host1x_uclass_indoff_indroffset_f(offset)
-		| host1x_uclass_indoff_rwn_read_v();
-	if (auto_inc)
-		v |= host1x_uclass_indoff_autoinc_f(1);
-	return v;
-}
-
-/* cdma opcodes */
-static inline u32 host1x_opcode_setclass(
-	unsigned class_id, unsigned offset, unsigned mask)
-{
-	return (0 << 28) | (offset << 16) | (class_id << 6) | mask;
-}
-
-static inline u32 host1x_opcode_incr(unsigned offset, unsigned count)
-{
-	return (1 << 28) | (offset << 16) | count;
-}
-
-static inline u32 host1x_opcode_nonincr(unsigned offset, unsigned count)
-{
-	return (2 << 28) | (offset << 16) | count;
-}
-
-static inline u32 host1x_opcode_mask(unsigned offset, unsigned mask)
-{
-	return (3 << 28) | (offset << 16) | mask;
-}
-
-static inline u32 host1x_opcode_imm(unsigned offset, unsigned value)
-{
-	return (4 << 28) | (offset << 16) | value;
-}
-
-static inline u32 host1x_opcode_imm_incr_syncpt(unsigned cond, unsigned indx)
-{
-	return host1x_opcode_imm(host1x_uclass_incr_syncpt_r(),
-		host1x_class_host_incr_syncpt(cond, indx));
-}
-
-static inline u32 host1x_opcode_restart(unsigned address)
-{
-	return (5 << 28) | (address >> 4);
-}
-
-static inline u32 host1x_opcode_gather(unsigned count)
-{
-	return (6 << 28) | count;
-}
-
-static inline u32 host1x_opcode_gather_nonincr(unsigned offset,	unsigned count)
-{
-	return (6 << 28) | (offset << 16) | BIT(15) | count;
-}
-
-static inline u32 host1x_opcode_gather_incr(unsigned offset, unsigned count)
-{
-	return (6 << 28) | (offset << 16) | BIT(15) | BIT(14) | count;
-}
-
-#define HOST1X_OPCODE_NOP host1x_opcode_nonincr(0, 0)
+#include "opcodes.h"
 
 #endif
diff --git a/drivers/gpu/host1x/hw/host1x05_hardware.h b/drivers/gpu/host1x/hw/host1x05_hardware.h
index af3ab4b7f010..1dcde6ec7909 100644
--- a/drivers/gpu/host1x/hw/host1x05_hardware.h
+++ b/drivers/gpu/host1x/hw/host1x05_hardware.h
@@ -15,117 +15,6 @@
 #include "hw_host1x05_sync.h"
 #include "hw_host1x05_uclass.h"
 
-static inline u32 host1x_class_host_wait_syncpt(
-	unsigned indx, unsigned threshold)
-{
-	return host1x_uclass_wait_syncpt_indx_f(indx)
-		| host1x_uclass_wait_syncpt_thresh_f(threshold);
-}
-
-static inline u32 host1x_class_host_load_syncpt_base(
-	unsigned indx, unsigned threshold)
-{
-	return host1x_uclass_load_syncpt_base_base_indx_f(indx)
-		| host1x_uclass_load_syncpt_base_value_f(threshold);
-}
-
-static inline u32 host1x_class_host_wait_syncpt_base(
-	unsigned indx, unsigned base_indx, unsigned offset)
-{
-	return host1x_uclass_wait_syncpt_base_indx_f(indx)
-		| host1x_uclass_wait_syncpt_base_base_indx_f(base_indx)
-		| host1x_uclass_wait_syncpt_base_offset_f(offset);
-}
-
-static inline u32 host1x_class_host_incr_syncpt_base(
-	unsigned base_indx, unsigned offset)
-{
-	return host1x_uclass_incr_syncpt_base_base_indx_f(base_indx)
-		| host1x_uclass_incr_syncpt_base_offset_f(offset);
-}
-
-static inline u32 host1x_class_host_incr_syncpt(
-	unsigned cond, unsigned indx)
-{
-	return host1x_uclass_incr_syncpt_cond_f(cond)
-		| host1x_uclass_incr_syncpt_indx_f(indx);
-}
-
-static inline u32 host1x_class_host_indoff_reg_write(
-	unsigned mod_id, unsigned offset, bool auto_inc)
-{
-	u32 v = host1x_uclass_indoff_indbe_f(0xf)
-		| host1x_uclass_indoff_indmodid_f(mod_id)
-		| host1x_uclass_indoff_indroffset_f(offset);
-	if (auto_inc)
-		v |= host1x_uclass_indoff_autoinc_f(1);
-	return v;
-}
-
-static inline u32 host1x_class_host_indoff_reg_read(
-	unsigned mod_id, unsigned offset, bool auto_inc)
-{
-	u32 v = host1x_uclass_indoff_indmodid_f(mod_id)
-		| host1x_uclass_indoff_indroffset_f(offset)
-		| host1x_uclass_indoff_rwn_read_v();
-	if (auto_inc)
-		v |= host1x_uclass_indoff_autoinc_f(1);
-	return v;
-}
-
-/* cdma opcodes */
-static inline u32 host1x_opcode_setclass(
-	unsigned class_id, unsigned offset, unsigned mask)
-{
-	return (0 << 28) | (offset << 16) | (class_id << 6) | mask;
-}
-
-static inline u32 host1x_opcode_incr(unsigned offset, unsigned count)
-{
-	return (1 << 28) | (offset << 16) | count;
-}
-
-static inline u32 host1x_opcode_nonincr(unsigned offset, unsigned count)
-{
-	return (2 << 28) | (offset << 16) | count;
-}
-
-static inline u32 host1x_opcode_mask(unsigned offset, unsigned mask)
-{
-	return (3 << 28) | (offset << 16) | mask;
-}
-
-static inline u32 host1x_opcode_imm(unsigned offset, unsigned value)
-{
-	return (4 << 28) | (offset << 16) | value;
-}
-
-static inline u32 host1x_opcode_imm_incr_syncpt(unsigned cond, unsigned indx)
-{
-	return host1x_opcode_imm(host1x_uclass_incr_syncpt_r(),
-		host1x_class_host_incr_syncpt(cond, indx));
-}
-
-static inline u32 host1x_opcode_restart(unsigned address)
-{
-	return (5 << 28) | (address >> 4);
-}
-
-static inline u32 host1x_opcode_gather(unsigned count)
-{
-	return (6 << 28) | count;
-}
-
-static inline u32 host1x_opcode_gather_nonincr(unsigned offset,	unsigned count)
-{
-	return (6 << 28) | (offset << 16) | BIT(15) | count;
-}
-
-static inline u32 host1x_opcode_gather_incr(unsigned offset, unsigned count)
-{
-	return (6 << 28) | (offset << 16) | BIT(15) | BIT(14) | count;
-}
-
-#define HOST1X_OPCODE_NOP host1x_opcode_nonincr(0, 0)
+#include "opcodes.h"
 
 #endif
diff --git a/drivers/gpu/host1x/hw/host1x06_hardware.h b/drivers/gpu/host1x/hw/host1x06_hardware.h
index 5d515745eee7..c05cfa7e3090 100644
--- a/drivers/gpu/host1x/hw/host1x06_hardware.h
+++ b/drivers/gpu/host1x/hw/host1x06_hardware.h
@@ -16,132 +16,6 @@
 #include "hw_host1x06_vm.h"
 #include "hw_host1x06_hypervisor.h"
 
-static inline u32 host1x_class_host_wait_syncpt(
-	unsigned indx, unsigned threshold)
-{
-	return host1x_uclass_wait_syncpt_indx_f(indx)
-		| host1x_uclass_wait_syncpt_thresh_f(threshold);
-}
-
-static inline u32 host1x_class_host_load_syncpt_base(
-	unsigned indx, unsigned threshold)
-{
-	return host1x_uclass_load_syncpt_base_base_indx_f(indx)
-		| host1x_uclass_load_syncpt_base_value_f(threshold);
-}
-
-static inline u32 host1x_class_host_wait_syncpt_base(
-	unsigned indx, unsigned base_indx, unsigned offset)
-{
-	return host1x_uclass_wait_syncpt_base_indx_f(indx)
-		| host1x_uclass_wait_syncpt_base_base_indx_f(base_indx)
-		| host1x_uclass_wait_syncpt_base_offset_f(offset);
-}
-
-static inline u32 host1x_class_host_incr_syncpt_base(
-	unsigned base_indx, unsigned offset)
-{
-	return host1x_uclass_incr_syncpt_base_base_indx_f(base_indx)
-		| host1x_uclass_incr_syncpt_base_offset_f(offset);
-}
-
-static inline u32 host1x_class_host_incr_syncpt(
-	unsigned cond, unsigned indx)
-{
-	return host1x_uclass_incr_syncpt_cond_f(cond)
-		| host1x_uclass_incr_syncpt_indx_f(indx);
-}
-
-static inline u32 host1x_class_host_indoff_reg_write(
-	unsigned mod_id, unsigned offset, bool auto_inc)
-{
-	u32 v = host1x_uclass_indoff_indbe_f(0xf)
-		| host1x_uclass_indoff_indmodid_f(mod_id)
-		| host1x_uclass_indoff_indroffset_f(offset);
-	if (auto_inc)
-		v |= host1x_uclass_indoff_autoinc_f(1);
-	return v;
-}
-
-static inline u32 host1x_class_host_indoff_reg_read(
-	unsigned mod_id, unsigned offset, bool auto_inc)
-{
-	u32 v = host1x_uclass_indoff_indmodid_f(mod_id)
-		| host1x_uclass_indoff_indroffset_f(offset)
-		| host1x_uclass_indoff_rwn_read_v();
-	if (auto_inc)
-		v |= host1x_uclass_indoff_autoinc_f(1);
-	return v;
-}
-
-/* cdma opcodes */
-static inline u32 host1x_opcode_setclass(
-	unsigned class_id, unsigned offset, unsigned mask)
-{
-	return (0 << 28) | (offset << 16) | (class_id << 6) | mask;
-}
-
-static inline u32 host1x_opcode_incr(unsigned offset, unsigned count)
-{
-	return (1 << 28) | (offset << 16) | count;
-}
-
-static inline u32 host1x_opcode_nonincr(unsigned offset, unsigned count)
-{
-	return (2 << 28) | (offset << 16) | count;
-}
-
-static inline u32 host1x_opcode_mask(unsigned offset, unsigned mask)
-{
-	return (3 << 28) | (offset << 16) | mask;
-}
-
-static inline u32 host1x_opcode_imm(unsigned offset, unsigned value)
-{
-	return (4 << 28) | (offset << 16) | value;
-}
-
-static inline u32 host1x_opcode_imm_incr_syncpt(unsigned cond, unsigned indx)
-{
-	return host1x_opcode_imm(host1x_uclass_incr_syncpt_r(),
-		host1x_class_host_incr_syncpt(cond, indx));
-}
-
-static inline u32 host1x_opcode_restart(unsigned address)
-{
-	return (5 << 28) | (address >> 4);
-}
-
-static inline u32 host1x_opcode_gather(unsigned count)
-{
-	return (6 << 28) | count;
-}
-
-static inline u32 host1x_opcode_gather_nonincr(unsigned offset,	unsigned count)
-{
-	return (6 << 28) | (offset << 16) | BIT(15) | count;
-}
-
-static inline u32 host1x_opcode_gather_incr(unsigned offset, unsigned count)
-{
-	return (6 << 28) | (offset << 16) | BIT(15) | BIT(14) | count;
-}
-
-static inline u32 host1x_opcode_setstreamid(unsigned streamid)
-{
-	return (7 << 28) | streamid;
-}
-
-static inline u32 host1x_opcode_setpayload(unsigned payload)
-{
-	return (9 << 28) | payload;
-}
-
-static inline u32 host1x_opcode_gather_wide(unsigned count)
-{
-	return (12 << 28) | count;
-}
-
-#define HOST1X_OPCODE_NOP host1x_opcode_nonincr(0, 0)
+#include "opcodes.h"
 
 #endif
diff --git a/drivers/gpu/host1x/hw/host1x07_hardware.h b/drivers/gpu/host1x/hw/host1x07_hardware.h
index 82c0cc9bb0b5..d67364e03956 100644
--- a/drivers/gpu/host1x/hw/host1x07_hardware.h
+++ b/drivers/gpu/host1x/hw/host1x07_hardware.h
@@ -16,132 +16,6 @@
 #include "hw_host1x07_vm.h"
 #include "hw_host1x07_hypervisor.h"
 
-static inline u32 host1x_class_host_wait_syncpt(
-	unsigned indx, unsigned threshold)
-{
-	return host1x_uclass_wait_syncpt_indx_f(indx)
-		| host1x_uclass_wait_syncpt_thresh_f(threshold);
-}
-
-static inline u32 host1x_class_host_load_syncpt_base(
-	unsigned indx, unsigned threshold)
-{
-	return host1x_uclass_load_syncpt_base_base_indx_f(indx)
-		| host1x_uclass_load_syncpt_base_value_f(threshold);
-}
-
-static inline u32 host1x_class_host_wait_syncpt_base(
-	unsigned indx, unsigned base_indx, unsigned offset)
-{
-	return host1x_uclass_wait_syncpt_base_indx_f(indx)
-		| host1x_uclass_wait_syncpt_base_base_indx_f(base_indx)
-		| host1x_uclass_wait_syncpt_base_offset_f(offset);
-}
-
-static inline u32 host1x_class_host_incr_syncpt_base(
-	unsigned base_indx, unsigned offset)
-{
-	return host1x_uclass_incr_syncpt_base_base_indx_f(base_indx)
-		| host1x_uclass_incr_syncpt_base_offset_f(offset);
-}
-
-static inline u32 host1x_class_host_incr_syncpt(
-	unsigned cond, unsigned indx)
-{
-	return host1x_uclass_incr_syncpt_cond_f(cond)
-		| host1x_uclass_incr_syncpt_indx_f(indx);
-}
-
-static inline u32 host1x_class_host_indoff_reg_write(
-	unsigned mod_id, unsigned offset, bool auto_inc)
-{
-	u32 v = host1x_uclass_indoff_indbe_f(0xf)
-		| host1x_uclass_indoff_indmodid_f(mod_id)
-		| host1x_uclass_indoff_indroffset_f(offset);
-	if (auto_inc)
-		v |= host1x_uclass_indoff_autoinc_f(1);
-	return v;
-}
-
-static inline u32 host1x_class_host_indoff_reg_read(
-	unsigned mod_id, unsigned offset, bool auto_inc)
-{
-	u32 v = host1x_uclass_indoff_indmodid_f(mod_id)
-		| host1x_uclass_indoff_indroffset_f(offset)
-		| host1x_uclass_indoff_rwn_read_v();
-	if (auto_inc)
-		v |= host1x_uclass_indoff_autoinc_f(1);
-	return v;
-}
-
-/* cdma opcodes */
-static inline u32 host1x_opcode_setclass(
-	unsigned class_id, unsigned offset, unsigned mask)
-{
-	return (0 << 28) | (offset << 16) | (class_id << 6) | mask;
-}
-
-static inline u32 host1x_opcode_incr(unsigned offset, unsigned count)
-{
-	return (1 << 28) | (offset << 16) | count;
-}
-
-static inline u32 host1x_opcode_nonincr(unsigned offset, unsigned count)
-{
-	return (2 << 28) | (offset << 16) | count;
-}
-
-static inline u32 host1x_opcode_mask(unsigned offset, unsigned mask)
-{
-	return (3 << 28) | (offset << 16) | mask;
-}
-
-static inline u32 host1x_opcode_imm(unsigned offset, unsigned value)
-{
-	return (4 << 28) | (offset << 16) | value;
-}
-
-static inline u32 host1x_opcode_imm_incr_syncpt(unsigned cond, unsigned indx)
-{
-	return host1x_opcode_imm(host1x_uclass_incr_syncpt_r(),
-		host1x_class_host_incr_syncpt(cond, indx));
-}
-
-static inline u32 host1x_opcode_restart(unsigned address)
-{
-	return (5 << 28) | (address >> 4);
-}
-
-static inline u32 host1x_opcode_gather(unsigned count)
-{
-	return (6 << 28) | count;
-}
-
-static inline u32 host1x_opcode_gather_nonincr(unsigned offset,	unsigned count)
-{
-	return (6 << 28) | (offset << 16) | BIT(15) | count;
-}
-
-static inline u32 host1x_opcode_gather_incr(unsigned offset, unsigned count)
-{
-	return (6 << 28) | (offset << 16) | BIT(15) | BIT(14) | count;
-}
-
-static inline u32 host1x_opcode_setstreamid(unsigned streamid)
-{
-	return (7 << 28) | streamid;
-}
-
-static inline u32 host1x_opcode_setpayload(unsigned payload)
-{
-	return (9 << 28) | payload;
-}
-
-static inline u32 host1x_opcode_gather_wide(unsigned count)
-{
-	return (12 << 28) | count;
-}
-
-#define HOST1X_OPCODE_NOP host1x_opcode_nonincr(0, 0)
+#include "opcodes.h"
 
 #endif
diff --git a/drivers/gpu/host1x/hw/opcodes.h b/drivers/gpu/host1x/hw/opcodes.h
new file mode 100644
index 000000000000..649614499b04
--- /dev/null
+++ b/drivers/gpu/host1x/hw/opcodes.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Tegra host1x opcodes
+ *
+ * Copyright (c) 2022 NVIDIA Corporation.
+ */
+
+#ifndef __HOST1X_OPCODES_H
+#define __HOST1X_OPCODES_H
+
+#include <linux/types.h>
+
+static inline u32 host1x_class_host_wait_syncpt(
+	unsigned indx, unsigned threshold)
+{
+	return host1x_uclass_wait_syncpt_indx_f(indx)
+		| host1x_uclass_wait_syncpt_thresh_f(threshold);
+}
+
+static inline u32 host1x_class_host_load_syncpt_base(
+	unsigned indx, unsigned threshold)
+{
+	return host1x_uclass_load_syncpt_base_base_indx_f(indx)
+		| host1x_uclass_load_syncpt_base_value_f(threshold);
+}
+
+static inline u32 host1x_class_host_wait_syncpt_base(
+	unsigned indx, unsigned base_indx, unsigned offset)
+{
+	return host1x_uclass_wait_syncpt_base_indx_f(indx)
+		| host1x_uclass_wait_syncpt_base_base_indx_f(base_indx)
+		| host1x_uclass_wait_syncpt_base_offset_f(offset);
+}
+
+static inline u32 host1x_class_host_incr_syncpt_base(
+	unsigned base_indx, unsigned offset)
+{
+	return host1x_uclass_incr_syncpt_base_base_indx_f(base_indx)
+		| host1x_uclass_incr_syncpt_base_offset_f(offset);
+}
+
+static inline u32 host1x_class_host_incr_syncpt(
+	unsigned cond, unsigned indx)
+{
+	return host1x_uclass_incr_syncpt_cond_f(cond)
+		| host1x_uclass_incr_syncpt_indx_f(indx);
+}
+
+static inline u32 host1x_class_host_indoff_reg_write(
+	unsigned mod_id, unsigned offset, bool auto_inc)
+{
+	u32 v = host1x_uclass_indoff_indbe_f(0xf)
+		| host1x_uclass_indoff_indmodid_f(mod_id)
+		| host1x_uclass_indoff_indroffset_f(offset);
+	if (auto_inc)
+		v |= host1x_uclass_indoff_autoinc_f(1);
+	return v;
+}
+
+static inline u32 host1x_class_host_indoff_reg_read(
+	unsigned mod_id, unsigned offset, bool auto_inc)
+{
+	u32 v = host1x_uclass_indoff_indmodid_f(mod_id)
+		| host1x_uclass_indoff_indroffset_f(offset)
+		| host1x_uclass_indoff_rwn_read_v();
+	if (auto_inc)
+		v |= host1x_uclass_indoff_autoinc_f(1);
+	return v;
+}
+
+static inline u32 host1x_opcode_setclass(
+	unsigned class_id, unsigned offset, unsigned mask)
+{
+	return (0 << 28) | (offset << 16) | (class_id << 6) | mask;
+}
+
+static inline u32 host1x_opcode_incr(unsigned offset, unsigned count)
+{
+	return (1 << 28) | (offset << 16) | count;
+}
+
+static inline u32 host1x_opcode_nonincr(unsigned offset, unsigned count)
+{
+	return (2 << 28) | (offset << 16) | count;
+}
+
+static inline u32 host1x_opcode_mask(unsigned offset, unsigned mask)
+{
+	return (3 << 28) | (offset << 16) | mask;
+}
+
+static inline u32 host1x_opcode_imm(unsigned offset, unsigned value)
+{
+	return (4 << 28) | (offset << 16) | value;
+}
+
+static inline u32 host1x_opcode_imm_incr_syncpt(unsigned cond, unsigned indx)
+{
+	return host1x_opcode_imm(host1x_uclass_incr_syncpt_r(),
+		host1x_class_host_incr_syncpt(cond, indx));
+}
+
+static inline u32 host1x_opcode_restart(unsigned address)
+{
+	return (5 << 28) | (address >> 4);
+}
+
+static inline u32 host1x_opcode_gather(unsigned count)
+{
+	return (6 << 28) | count;
+}
+
+static inline u32 host1x_opcode_gather_nonincr(unsigned offset,	unsigned count)
+{
+	return (6 << 28) | (offset << 16) | BIT(15) | count;
+}
+
+static inline u32 host1x_opcode_gather_incr(unsigned offset, unsigned count)
+{
+	return (6 << 28) | (offset << 16) | BIT(15) | BIT(14) | count;
+}
+
+static inline u32 host1x_opcode_setstreamid(unsigned streamid)
+{
+	return (7 << 28) | streamid;
+}
+
+static inline u32 host1x_opcode_setpayload(unsigned payload)
+{
+	return (9 << 28) | payload;
+}
+
+static inline u32 host1x_opcode_gather_wide(unsigned count)
+{
+	return (12 << 28) | count;
+}
+
+static inline u32 host1x_opcode_acquire_mlock(unsigned mlock)
+{
+	return (14 << 28) | (0 << 24) | mlock;
+}
+
+static inline u32 host1x_opcode_release_mlock(unsigned mlock)
+{
+	return (14 << 28) | (1 << 24) | mlock;
+}
+
+#define HOST1X_OPCODE_NOP host1x_opcode_nonincr(0, 0)
+
+#endif
-- 
2.36.1

