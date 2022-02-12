Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6079B4B3200
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 01:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354448AbiBLA3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 19:29:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344273AbiBLA3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 19:29:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD8BD7E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:29:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68CCB61CB4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 00:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A56C340E9;
        Sat, 12 Feb 2022 00:29:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PJgyFx1J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644625745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JGlj9xKTqCKUDSazvzHm7AoG8NZOUjaUCMMHExPBXO8=;
        b=PJgyFx1JdU0HL7IYQ2dKvRLMCfiXWZ7qA7ADHlUmgkcsr0NiaNVDxJy+4KzK5/RFHMMPJH
        BNKggONT2rtMFkVGgnwIFGKBugKpjimSOci8ZmoS+G0gUP2tWaCUxan1I6m2MG1ZC4bVh5
        Ozjl1+3pOvkTTMkW8bm/FPxX1JK162g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5e080588 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 12 Feb 2022 00:29:05 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: do not take pool spinlock at boot
Date:   Sat, 12 Feb 2022 01:28:59 +0100
Message-Id: <20220212002859.622233-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since rand_initialize() is run while interrupts are still off and
nothing else is running, we don't need to repeatedly take and release
the pool spinlock, especially in the RDSEED loop.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Dominik - I'm still a bit unclear about early boot semantics that you
seem to know well. Is this patch correct?

 drivers/char/random.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d4b692c9de68..8088348190e6 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -966,10 +966,10 @@ int __init rand_initialize(void)
 			rv = random_get_entropy();
 			arch_init = false;
 		}
-		mix_pool_bytes(&rv, sizeof(rv));
+		_mix_pool_bytes(&rv, sizeof(rv));
 	}
-	mix_pool_bytes(&now, sizeof(now));
-	mix_pool_bytes(utsname(), sizeof(*(utsname())));
+	_mix_pool_bytes(&now, sizeof(now));
+	_mix_pool_bytes(utsname(), sizeof(*(utsname())));
 
 	extract_entropy(base_crng.key, sizeof(base_crng.key));
 	++base_crng.generation;
-- 
2.35.0

