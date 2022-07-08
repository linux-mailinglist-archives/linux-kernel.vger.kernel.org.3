Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5189956B339
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbiGHHNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbiGHHNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:13:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFB9796AF;
        Fri,  8 Jul 2022 00:13:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A005621ED5;
        Fri,  8 Jul 2022 07:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657264388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=53CEXyeuRhvrLzAgd2XWwxskqq0rZQskDVZ5oBYdUxw=;
        b=tknenM3NcdSgTGy93KDhDPMo1KEuJ0fj1X9YVl/SInidx5FkTa74E4QfRzAs9TIyryFsRx
        DIl94p7mhKbHD118bW8zM093M0xelRzLh1vwwKoU+ppy0kyjSbFOL0I97Az64SJj1X7V7h
        Y3J3UAlUovGfFAs1uY38gxsZT4EfBdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657264388;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=53CEXyeuRhvrLzAgd2XWwxskqq0rZQskDVZ5oBYdUxw=;
        b=aewu6It07jAUR9yXN1SCJeRTNqj6gQK4W7YSXPHegYFC+yuv60WmeTGHMULx5HcrBqF+Bj
        aJ51EWAxFuWJ6dBA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 552BD2C141;
        Fri,  8 Jul 2022 07:13:08 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     mturquette@baylibre.com
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v2 1/2] clk: pistachio: Fix initconst confusion
Date:   Fri,  8 Jul 2022 09:13:05 +0200
Message-Id: <20220708071306.4354-1-jslaby@suse.cz>
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

A variable pointing to const isn't const itself. It has to contain
"const" keyword after "*" too. So to keep it in __initconst (and not
mark properly as __initdata), add the "const" keyword exactly there.

Note we need to update struct pistachio_mux too. On the other hand, the
clk core already counts with "const char *const" already.

[js] more explanatory commit message.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: Martin Liska <mliska@suse.cz>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    [v2] as suggested by Stephen, instead of switching to __initdata, make
         it real const

 drivers/clk/pistachio/clk.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
index f9c31e3a0e47..2f4ffbd98282 100644
--- a/drivers/clk/pistachio/clk.h
+++ b/drivers/clk/pistachio/clk.h
@@ -31,10 +31,10 @@ struct pistachio_mux {
 	unsigned int shift;
 	unsigned int num_parents;
 	const char *name;
-	const char **parents;
+	const char *const *parents;
 };
 
-#define PNAME(x) static const char *x[] __initconst
+#define PNAME(x) static const char *const x[] __initconst
 
 #define MUX(_id, _name, _pnames, _reg, _shift)			\
 	{							\
-- 
2.36.1

