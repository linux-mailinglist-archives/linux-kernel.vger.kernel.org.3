Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C363B48A214
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345038AbiAJVpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:45:03 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:37710 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244460AbiAJVpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:45:02 -0500
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:f8d5:1373:c8a9:137f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id F1D8F28F83E;
        Mon, 10 Jan 2022 22:45:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1641851101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mVZW6zUymC2sipnx6azNKWOw5trf7B7bHjG5CmzfceM=;
        b=Lew0sfyaHHxB22tG5Do3OtZTmU1SO43VLP6k4C0Ut8B07s7iTSByVWFPbrXG38Hj5nZhl8
        JdJ+B0BgmDi9PDzLBYDsFiDEBcAx0uCejT7Xr+jcEK/cjjKJITAZpXtaJgrGYX3x1Y8fPr
        JR/u6G/SWCpGtwl0jtlXR8PsQ7ExI9TC8eEInNKHnhVWKcsf1GSXzxSuujAvVq7q9GzNoq
        o1p2l6k3IrEEUFWA0bOr28WBrmnY9vgGedQQS9Ye5VQzhA4dA9vs6ChRFPRHpFdpUZU47Y
        s/ZbPXnBdyoLalt+NG9CVR2ScaxCUCQw6cmVgBxkleli1UO61u6eahBY0sM0CQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH] dt-bindings: power: reset: gpio-restart: Correct default priority
Date:   Mon, 10 Jan 2022 22:44:56 +0100
Message-Id: <20220110214456.67087-1-sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bcd56fe1aa97 ("power: reset: gpio-restart: increase priority
slightly") changed the default restart priority 129, but did not update
the documentation. Correct this, so the driver and documentation have
the same default value.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
This is a resubmission of RFC:
https://lore.kernel.org/all/cfcd00257daba5aa30b8d20a62ba542be1a6914c.1640887456.git.sander@svanheule.net/

The commit message for bcd56fe1aa97 mentions that it is a workaround for
rk3288-veryon boards. However, commit e28ea9dbc52d3 ("ARM: dts:
rockchip: add shared rk3288-veyron files") later adds a gpio-restart
node with a priority value of <200> for those boards, effectively
rendering bcd56fe1aa97 obsolete (for their use case).

Perhaps bcd56fe1aa97 could just be reverted instead of updating the
documentation.

An argument against reverting (a 6 year old patch) is that other boards
may have come to depend on the default value of 129. I don't know about
out-of-tree user of gpio-restart, but there are a few in-tree users of
gpio-restart /without/ an explicit priority:

arch/arm/boot/dts/imx53-ppd.dts (commit 2952d67637716)
  DTS submitted after changed default, but DTS copyright predates the
  changed default.

arch/microblaze/boot/dts/system.dts (commit 7cca9b8b7c5bc)
  The original DTS commit predates the changed default, but didn't use
  gpio-restart. The commit adding gpio-restart appears to indicate no
  other restart handlers are present on this platform, although it could
  be these were just being shadowed by the custom restart code.

arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts (commit 0a91330b2af9f)
  Recently added board; couldn't find any obvious alternative restart
  handlers.

Best,
Sander

 .../devicetree/bindings/power/reset/gpio-restart.yaml         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
index 3dd22220cb5f..a72d5c721516 100644
--- a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
+++ b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
@@ -43,7 +43,7 @@ properties:
   priority:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
-      A priority ranging from 0 to 255 (default 128) according to the following guidelines:
+      A priority ranging from 0 to 255 (default 129) according to the following guidelines:
 
         0:   Restart handler of last resort, with limited restart capabilities.
         128: Default restart handler; use if no other restart handler is expected to be available,
@@ -51,7 +51,7 @@ properties:
         255: Highest priority restart handler, will preempt all other restart handlers.
     minimum: 0
     maximum: 255
-    default: 128
+    default: 129
 
   active-delay:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.33.1

