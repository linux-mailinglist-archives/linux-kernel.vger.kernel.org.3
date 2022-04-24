Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA3350CFF9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 08:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiDXGTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 02:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiDXGS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 02:18:56 -0400
X-Greylist: delayed 913 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Apr 2022 23:15:45 PDT
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E004047AD9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 23:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1650780010; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=G89X2QBmE4EgM05XnfpsouYFoZIwMCV4C80WgFtSCHEqtJ1USTKQNGd75ZfgyKFfA/VR+4LaG2l90nRU4ptZDPGbIquuaCq/gh0yYuzFtkuQyQCQ8Xpz8j5aPQkm0PUpx0kmj00glUINx4wBOK4zo/NXy2Psfri2kL3itnB1IHA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1650780010; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=pq60l/Yh375tVKL8zIdox/f7EvRbMx2DWdqcnGIxLow=; 
        b=my5c5RvIj2i2qc6kQ8YLW6odsXvMl+pdBiN+aPMZdcg21ecrA9g5Mnac3ZSAWWd+wF6k6kWEgyPnKPp0wVtLbAXfQJLzODPIg9HKk7f2yERMXQ+6Xm7s1d9QfxFTXSAnCMxzBwJK2YACb/qXYJ1ZRl2SolMk3MgNQLv0qE3MLgM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1650780010;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=pq60l/Yh375tVKL8zIdox/f7EvRbMx2DWdqcnGIxLow=;
        b=JpEonNAv7xyTDgfxMVHzMV1Qf9VYuiUBA09QEAYdS5WfHIpAKRMHGKWVaHvYHRKO
        0FZo3Cter02dJQMXBir09R/RCF4bDvYK5a1wcfEpKZ1y0zaZdCotmkgIbqB3unYXgxT
        EEC+lp18e3PfzcsLeHx+q1kzin2W8zWCaEHGYKNc=
Received: from petra.. (64.225.114.122 [64.225.114.122]) by mx.zohomail.com
        with SMTPS id 1650780009289608.5266651606395; Sat, 23 Apr 2022 23:00:09 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH] clk: sunxi-ng: ccu-sun6i-rtc: set rtc-32k to critical
Date:   Sun, 24 Apr 2022 13:59:59 +0800
Message-Id: <20220424055959.109286-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC itself is the one and only consumer of rtc-32k clock. As the rtc
should be always running, set rtc-32k clock to critical, to prevent it
from being gated by the kernel.

Fixes: d91612d7f01a ("clk: sunxi-ng: Add support for the sun6i RTC clocks")
Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
index 8a10bade7e0d..3d9c9ce5a3db 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
@@ -241,6 +241,7 @@ static struct clk_init_data rtc_32k_init_data = {
 	.ops		= &ccu_mux_ops,
 	.parent_hws	= rtc_32k_parents,
 	.num_parents	= ARRAY_SIZE(rtc_32k_parents), /* updated during probe */
+	.flags		= CLK_IS_CRITICAL,
 };
 
 static struct ccu_mux rtc_32k_clk = {
-- 
2.35.1

