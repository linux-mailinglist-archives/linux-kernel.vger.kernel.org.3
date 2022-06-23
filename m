Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72264557583
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiFWIc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiFWIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:32:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DBA48E41;
        Thu, 23 Jun 2022 01:32:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 498DD1FD47;
        Thu, 23 Jun 2022 08:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655973141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UNXy+AIePGQrQNDGEbOC/SAMi7bauyx2fqx70mo8RoA=;
        b=eJa6LFZhpwYOCBPR6xO3RGonynYLqgXG9Yy+8SS+EaclVWaBOgy4y+QVTkBT2jZC9tHFrW
        TSmvjW6j3e7VXfo0Vur7lgOu7e8ywgqnZk81xCFWFslWVsoMJfio4ey2UZEBgtLn/tMtZW
        oS99tKMSfllrDGAF6xgPMNCDkrwbLCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655973141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UNXy+AIePGQrQNDGEbOC/SAMi7bauyx2fqx70mo8RoA=;
        b=+9jBRQJkV/TfY69bDbXhfjT6BfjKLH66MUbuqlI5dFT3wF2s/ZxRpRl4hWzoz4CZxMhHNV
        AhC2gdgqhO/Sr0Aw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5F02A2C142;
        Thu, 23 Jun 2022 08:32:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     mturquette@baylibre.com
Cc:     mliska@suse.cz, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/2] clk: pistachio: Fix initconst confusion
Date:   Thu, 23 Jun 2022 10:32:16 +0200
Message-Id: <20220623083217.26433-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
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
"const" keyword after "*" too. Therefore, PNAME() cannot put the strings
to "rodata".  Hence use __initdata instead of __initconst to fix this.

[js] more explanatory commit message.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/clk/pistachio/clk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
index f9c31e3a0e47..742e5fab00c0 100644
--- a/drivers/clk/pistachio/clk.h
+++ b/drivers/clk/pistachio/clk.h
@@ -34,7 +34,7 @@ struct pistachio_mux {
 	const char **parents;
 };
 
-#define PNAME(x) static const char *x[] __initconst
+#define PNAME(x) static const char *x[] __initdata
 
 #define MUX(_id, _name, _pnames, _reg, _shift)			\
 	{							\
-- 
2.36.1

