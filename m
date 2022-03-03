Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB55E4CC484
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 19:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiCCSB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 13:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiCCSBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:01:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D81A1C56;
        Thu,  3 Mar 2022 10:01:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7FC9B82664;
        Thu,  3 Mar 2022 18:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E79C340EF;
        Thu,  3 Mar 2022 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646330463;
        bh=xGgnnVHyGleDpVkH9gkP5NrpsGASPkv/CJewUK6NLDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JcO8OXDEAyL+U547uBOC8tTHMHCd+zP060n+yMQOOYLKkDW7vhWTYCZcQMDwossNu
         BIpKFOOxv8JWtfM4jVphHMuIVEv87l5eIWRVGUwYXo3p2Xciha+Zg8o8RP/Ha0T/20
         EAQuHUdE700SSmrxIf7ggqU8y/5ZRDHrigKXam8cZ59D0LucvX3lxxipeOdVeG2VPZ
         sjjuaxa4diGeHMhw9e8Qw1MD393dESCFq8yOGHrlc3IK/lq3wFz2/gG5blDgjx1o2i
         7RMv/WEJiK0XqoMtkpMl72YSn7UKOkgMLaNUnl6vLNs4Fv2IOf0CEIQALhduHgqIGX
         gg9nqfq2z+wlA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nPpl8-0000iq-AF; Thu, 03 Mar 2022 19:01:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] ARM: OMAP2+: drop hwmod-clock helper comment
Date:   Thu,  3 Mar 2022 19:00:14 +0100
Message-Id: <20220303180014.2639-3-johan@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220303180014.2639-1-johan@kernel.org>
References: <20220303180014.2639-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a4f6cdb0672f ("ARM: OMAP: omap_device: Add
omap_device_[alloc|delete] for DT integration"),
_add_hwmod_clocks_clkdev() is called from omap_device_alloc().

Drop the outdated comment referring to how this function was used ten
odd years ago.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/mach-omap2/omap_device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 3cfa7b01a24b..8b3701901991 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -96,9 +96,6 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
  * omap_device, this function adds an entry in the clkdev table of the
  * form <dev-id=dev_name, con-id=role> if it does not exist already.
  *
- * The function is called from inside omap_device_build_ss(), after
- * omap_device_register.
- *
  * This allows drivers to get a pointer to its optional clocks based on its role
  * by calling clk_get(<dev*>, <role>).
  * In the case of the main clock, a "fck" alias is used.
-- 
2.34.1

