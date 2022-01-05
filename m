Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AE6484BC6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 01:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiAEAhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 19:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiAEAhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 19:37:33 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4EFC061761;
        Tue,  4 Jan 2022 16:37:33 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-190-118.tukw.qwest.net [174.21.190.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 6C51E190;
        Tue,  4 Jan 2022 16:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1641343052;
        bh=GeuscGny1ziTVBaA6vYScM7v6qdUcEMdSpfwsytT5yg=;
        h=From:To:Cc:Subject:Date:From;
        b=DpjUe5Jkw8PDbQQ8t6uh8fS9pnLE0hLniXf3vdv3WfnhS+K37exVxXxNHV/aznYQo
         qZPBSCoahHeyDdStxET25OoHGstNCOQq+0ezsFKp3Ny/kxKOmOBQocCqjAQq8esaZO
         q4Y7qn0Vr0rTBg3ofu9i/uMZqg7sZImoPpYp4BGg=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Troy Lee <troy_lee@aspeedtech.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH] ARM: dts: Fix OpenBMC flash layout label addresses
Date:   Tue,  4 Jan 2022 16:37:18 -0800
Message-Id: <20220105003718.19888-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've ended up with some inconsistencies between the addresses in the
DT node labels and the actual offsets of the partitions; this brings
them back in sync.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Fixes: 529022738c8e ("ARM: dts: Add OpenBMC flash layout")
Fixes: 8dec60e7b8d0 ("ARM: dts: aspeed: Grow u-boot partition 64MiB OpenBMC flash layout")
---
 arch/arm/boot/dts/openbmc-flash-layout-64.dtsi | 2 +-
 arch/arm/boot/dts/openbmc-flash-layout.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi b/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
index 31f59de5190b..7af41361c480 100644
--- a/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
+++ b/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
@@ -28,7 +28,7 @@ rofs@a00000 {
 		label = "rofs";
 	};
 
-	rwfs@6000000 {
+	rwfs@2a00000 {
 		reg = <0x2a00000 0x1600000>; // 22MB
 		label = "rwfs";
 	};
diff --git a/arch/arm/boot/dts/openbmc-flash-layout.dtsi b/arch/arm/boot/dts/openbmc-flash-layout.dtsi
index 6c26524e93e1..b47e14063c38 100644
--- a/arch/arm/boot/dts/openbmc-flash-layout.dtsi
+++ b/arch/arm/boot/dts/openbmc-flash-layout.dtsi
@@ -20,7 +20,7 @@ kernel@80000 {
 		label = "kernel";
 	};
 
-	rofs@c0000 {
+	rofs@4c0000 {
 		reg = <0x4c0000 0x1740000>;
 		label = "rofs";
 	};
-- 
2.34.1

