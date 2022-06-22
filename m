Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F74554B45
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349184AbiFVNZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiFVNYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:24:55 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AAD39146;
        Wed, 22 Jun 2022 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zneSlm/FBIo8HIfpwrpeYXGfaaeCvJcmoVkNt34CA/4=; b=lGVQvzIIViuCsb85jMK1fqXWbp
        SuJd3L8bfoi0b1hP24/oURQXg4fPj6gq57kRoIiSclCzH6XLLxN9fFckP2iPxA6WUqjRnQNfhKXiL
        YsTZLIedMKg8AgVKd5kH0FTysKjfMj3z37hzTD3TQYzWGl9WCFG5AIiXm+PEQ9vxShN+hGleA8fnT
        8c3Zv82wa/d0T0qKphQLKygA6n3kUGUpca/GTMmfCBRtc5veU+c54RD+c6sesQsuj+LmbW/KM0zLm
        JB9LFN+FNW2t/fBz8uACrsDUFUj/6vPdnmiGcSwvsr6YQef/cGlGzNlF26E1xun7Q8W2Gag2dx93i
        /stqIcIw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1o40Kl-000abh-DJ; Wed, 22 Jun 2022 16:23:50 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: tegra: Mark BPMP channels as no-memory-wc
Date:   Wed, 22 Jun 2022 16:23:00 +0300
Message-Id: <20220622132300.1746201-2-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622132300.1746201-1-cyndis@kapsi.fi>
References: <20220622132300.1746201-1-cyndis@kapsi.fi>
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

The Tegra SYSRAM contains regions access to which is restricted to
certain hardware blocks on the system, and speculative accesses to
those will cause issues.

Patch 'misc: sram: Only map reserved areas in Tegra SYSRAM' attempted
to resolve this by only mapping the regions specified in the device
tree on the assumption that there are no such restricted areas within
the 64K-aligned area of memory that contains the memory we wish to map.

Turns out this assumption is wrong, as there are such areas above the
4K pages described in the device trees. As such, we need to use the
bigger hammer that is no-memory-wc, which causes the memory to be
mapped as Device memory to which speculative accesses are disallowed.

As such, the previous patch in the series,
  'firmware: tegra: bpmp: do only aligned access to IPC memory area',
is required with this patch to make the BPMP driver only issue aligned
memory accesses as those are also required with Device memory.

Fixes: fec29bf04994 ("misc: sram: Only map reserved areas in Tegra SYSRAM")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 1 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 0e9afc3e2f26..9eca18b54698 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1820,6 +1820,7 @@ sram@30000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x30000000 0x50000>;
+		no-memory-wc;
 
 		cpu_bpmp_tx: sram@4e000 {
 			reg = <0x4e000 0x1000>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index d1f8248c00f4..3fdb0b852718 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -2684,6 +2684,7 @@ sram@40000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x40000000 0x50000>;
+		no-memory-wc;
 
 		cpu_bpmp_tx: sram@4e000 {
 			reg = <0x4e000 0x1000>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index cb3af539e477..0213a7e3dad0 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1325,6 +1325,7 @@ sram@40000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x40000000 0x80000>;
+		no-memory-wc;
 
 		cpu_bpmp_tx: sram@70000 {
 			reg = <0x70000 0x1000>;
-- 
2.36.1

