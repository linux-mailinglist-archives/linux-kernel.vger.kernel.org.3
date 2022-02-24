Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA67C4C33DC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiBXRk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiBXRkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:40:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D6D18FAF1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:39:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E64861C1E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4FFC340E9;
        Thu, 24 Feb 2022 17:39:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KxGxfdpJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645724392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fN/Nbfghcp7KZUv3h/U2uhdlYGPh+TBrCHrNxIdruI8=;
        b=KxGxfdpJ90OKZ8BH2caKi+mhhxzHAXZyyqXQwfTqtUnnsi0G2Jq3DoJrcIDDHIPsX9g9ar
        JSQE8Ic+lPbEM4gFqOTUAK4fPu8K1Nie8xf02PmIwBfXeyf18J6JLOTeY77Rh9Gbi8dRQY
        9M6O09/0ORd3LIVt1Eml5XxtvYaZo7w=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c6ef502b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 24 Feb 2022 17:39:51 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: use proper cycle_t type for random_get_entropy()
Date:   Thu, 24 Feb 2022 18:39:48 +0100
Message-Id: <20220224173948.34045-1-Jason@zx2c4.com>
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

random_get_entropy() returns a cycles_t, not an unsigned long, which is
sometimes 64 bits on various 32-bit platforms, including x86.
Conversely, jiffies is always unsigned long. This commit fixes things to
use cycles_t for fields that use random_get_entropy() and unsigned long
for fields that use jiffies.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 19bf44b9ba0f..4e37b8e2acc1 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1002,7 +1002,7 @@ int __init rand_initialize(void)
 
 /* There is one of these per entropy source */
 struct timer_rand_state {
-	cycles_t last_time;
+	unsigned long last_time;
 	long last_delta, last_delta2;
 };
 
@@ -1016,7 +1016,7 @@ struct timer_rand_state {
  */
 void add_device_randomness(const void *buf, size_t size)
 {
-	unsigned long time = random_get_entropy() ^ jiffies;
+	cycles_t time = random_get_entropy() ^ jiffies;
 	unsigned long flags;
 
 	if (crng_init == 0 && size)
@@ -1042,8 +1042,8 @@ EXPORT_SYMBOL(add_device_randomness);
 static void add_timer_randomness(struct timer_rand_state *state, unsigned int num)
 {
 	struct {
+		cycles_t cycles;
 		long jiffies;
-		unsigned int cycles;
 		unsigned int num;
 	} sample;
 	long delta, delta2, delta3;
@@ -1356,7 +1356,7 @@ static void entropy_timer(struct timer_list *t)
 static void try_to_generate_entropy(void)
 {
 	struct {
-		unsigned long now;
+		cycles_t now;
 		struct timer_list timer;
 	} stack;
 
-- 
2.35.1

