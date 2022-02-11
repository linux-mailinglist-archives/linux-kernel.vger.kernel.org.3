Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603AC4B1A72
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346383AbiBKAdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:33:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346365AbiBKAdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:33:08 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21215F7C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:33:08 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6D7EA2C0CC1;
        Fri, 11 Feb 2022 00:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1644539583;
        bh=9AoyTmrNG1bFwKaC2bK2uvY6+BloeSm9RcgQuQxez3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GDGb+BFivrnojGAWg0yNCMSdEnlKISaDpNh+PYVOAqUfECfOOaZhzztZHfE/H2aVd
         JV1pGxUJfkgmz7D1emSfd7twrvOHK1Zrv5RDE/0VOMj8NDS2K7FRrTmtWpLO35Av7A
         YZBo/AT9aa2Bb4BPNEDyxw1d9pViKLH+CAN6YYTYC4XqWRmayXzfcIBVn6agrq/jAR
         waIGxcKRe1nEBwvalO5tTCKKkfvTCNyMf/RZYXg5WF6ssitusfr7in0zEJIpR1m874
         YvNxcpdXPba3XuKUUShQ9KGHNEYf1F9+UryqYMQx1fbb+IYl6HlOn/JyNKoJM8u8PY
         45shPTpJjFepw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6205aec00002>; Fri, 11 Feb 2022 13:33:04 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 54F5F13ECE9;
        Fri, 11 Feb 2022 13:33:03 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 3BAE82A00D0; Fri, 11 Feb 2022 13:32:59 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, gregory.clement@bootlin.com, robh+dt@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] watchdog: orion_wdt: support pretimeout on Armada-XP
Date:   Fri, 11 Feb 2022 13:32:57 +1300
Message-Id: <20220211003257.2037332-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211003257.2037332-1-chris.packham@alliedtelesis.co.nz>
References: <20220211003257.2037332-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=c43Vvi1l c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oGFeUVbbRNcA:10 a=Moq0AktbSBU1Ap_EwrUA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e07a4c79ca75 ("watchdog: orion_wdt: use timer1 as a pretimeout")
added support for a pretimeout on Armada-38x variants. Because the
Armada-XP variants use armada370_start/armada370_stop (due to missing an
explicit RSTOUT mask bit for the watchdog). Add the required pretimeout
support to armada370_start/armada370_stop for Armada-XP.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/watchdog/orion_wdt.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 127eefc9161d..e25e6bf4647f 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -238,8 +238,10 @@ static int armada370_start(struct watchdog_device *w=
dt_dev)
 	atomic_io_modify(dev->reg + TIMER_A370_STATUS, WDT_A370_EXPIRED, 0);
=20
 	/* Enable watchdog timer */
-	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit,
-						dev->data->wdt_enable_bit);
+	reg =3D dev->data->wdt_enable_bit;
+	if (dev->wdt.info->options & WDIOF_PRETIMEOUT)
+		reg |=3D TIMER1_ENABLE_BIT;
+	atomic_io_modify(dev->reg + TIMER_CTRL, reg, reg);
=20
 	/* Enable reset on watchdog */
 	reg =3D readl(dev->rstout);
@@ -312,7 +314,7 @@ static int armada375_stop(struct watchdog_device *wdt=
_dev)
 static int armada370_stop(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev =3D watchdog_get_drvdata(wdt_dev);
-	u32 reg;
+	u32 reg, mask;
=20
 	/* Disable reset on watchdog */
 	reg =3D readl(dev->rstout);
@@ -320,7 +322,10 @@ static int armada370_stop(struct watchdog_device *wd=
t_dev)
 	writel(reg, dev->rstout);
=20
 	/* Disable watchdog timer */
-	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit, 0);
+	mask =3D dev->data->wdt_enable_bit;
+	if (wdt_dev->info->options & WDIOF_PRETIMEOUT)
+		mask |=3D TIMER1_ENABLE_BIT;
+	atomic_io_modify(dev->reg + TIMER_CTRL, mask, 0);
=20
 	return 0;
 }
--=20
2.35.1

