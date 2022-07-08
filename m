Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0969A56B338
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbiGHHNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbiGHHNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:13:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F7E76E8A;
        Fri,  8 Jul 2022 00:13:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 116FB1FE78;
        Fri,  8 Jul 2022 07:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657264389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMhC18ky2++3tPvUW/SF4keQKVbRQIhWZHoumy+pnZ4=;
        b=EnE3HRHmf01bQyQvM+RsqW4+SpnIZVxprw3naq4D1xDWg6GkfEIbcSDoenUSXfDKKCau32
        59R6hLHSzw+uRzOaTWkiZ+ddugvcPKTeKlXWVByv3K5oyGoQhVk2CL+h2TUGW91Dcxsegm
        Wxb3yXvQc8Z9eyKuovhVkBEjjXQh9b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657264389;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMhC18ky2++3tPvUW/SF4keQKVbRQIhWZHoumy+pnZ4=;
        b=od6cZmruIjKNxTEWN3+lnw0ZtqoPMjNcgM8do+GOsVrPfhv4GyoGlzmeiFpFfs+NNEF9I0
        ACLGjkqtqOHajSAw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AB2652C142;
        Fri,  8 Jul 2022 07:13:08 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     mturquette@baylibre.com
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Martin Liska <mliska@suse.cz>, Stephen Boyd <sboyd@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v2 2/2] clk: renesas: rcar-gen4: Fix initconst confusion for cpg_pll_config
Date:   Fri,  8 Jul 2022 09:13:06 +0200
Message-Id: <20220708071306.4354-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708071306.4354-1-jslaby@suse.cz>
References: <20220708071306.4354-1-jslaby@suse.cz>
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
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: Martin Liska <mliska@suse.cz>
Acked-by: Stephen Boyd <sboyd@kernel.org>
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

