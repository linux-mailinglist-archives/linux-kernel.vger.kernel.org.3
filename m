Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF40B557584
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiFWIce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiFWIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:32:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B81548E4C;
        Thu, 23 Jun 2022 01:32:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CB3AF21CEF;
        Thu, 23 Jun 2022 08:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655973141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YhxK8ZZPI3lUmCLii+65rd4UgUV1fnm192cvOMrF6jY=;
        b=cSLQD/HW8YWib0EtDF6YMhVwjZqBHB1wXhqVj8oTrsAeRwlbEkB695BH54J5l9iI8bE9ZZ
        kQIjySKbdNyswhTWYCpa7RbTf8ty+MBBzFFi7CxTcwTcz8ZC2YsT9clsQbMa8OqC6pwuHo
        pJJwUlT4GyHdivZUZxMM8BpSMglX+Mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655973141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YhxK8ZZPI3lUmCLii+65rd4UgUV1fnm192cvOMrF6jY=;
        b=s6UwSurfXFe9u0KCb0T1ed3urucBA8q2fdMS61gbXg3x/jy9iqMp+DxXle8rghennq6GGy
        HzGe22e28xNhZFDg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BBDA12C143;
        Thu, 23 Jun 2022 08:32:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     mturquette@baylibre.com
Cc:     mliska@suse.cz, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/2] clk: renesas: rcar-gen4: Fix initconst confusion for cpg_pll_config
Date:   Thu, 23 Jun 2022 10:32:17 +0200
Message-Id: <20220623083217.26433-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623083217.26433-1-jslaby@suse.cz>
References: <20220623083217.26433-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

A variable pointing to const isn't const itself. It'd have to contain
"const" keyword after "*" too. Therefore, cpg_pll_config cannot be put
to "rodata".  Hence use __initdata instead of __initconst to fix this.

[js] more explanatory commit message.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/clk/renesas/rcar-gen4-cpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/rcar-gen4-cpg.c b/drivers/clk/renesas/rcar-gen4-cpg.c
index c7ed43d6aa67..e27832e5114f 100644
--- a/drivers/clk/renesas/rcar-gen4-cpg.c
+++ b/drivers/clk/renesas/rcar-gen4-cpg.c
@@ -23,7 +23,7 @@
 #include "rcar-gen4-cpg.h"
 #include "rcar-cpg-lib.h"
 
-static const struct rcar_gen4_cpg_pll_config *cpg_pll_config __initconst;
+static const struct rcar_gen4_cpg_pll_config *cpg_pll_config __initdata;
 static unsigned int cpg_clk_extalr __initdata;
 static u32 cpg_mode __initdata;
 
-- 
2.36.1

