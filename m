Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2723A4E4BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 05:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbiCWENA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 00:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCWEM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 00:12:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C1C55BD6;
        Tue, 22 Mar 2022 21:11:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24A1D61585;
        Wed, 23 Mar 2022 04:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52D9C340E8;
        Wed, 23 Mar 2022 04:11:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eFkXpepl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648008686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tmx+SMJ8klnka/a+PxgQZA13oU4YxVuHKjh55SA6rJI=;
        b=eFkXpepl82R3E7G6qgCYbO2N/529W0VVhuoKMXWp0mXsiorZoJfqxSqX19PlI6y8cmCzzt
        2B4mXKBqhnDf4h9JyuTK+SY+8bQ723mP7Ca1LcIKx9PL6h13YRLG0FdtehoYhFSY3pVmjE
        pKiR6h4RQfC9CROhWz8qB8ev44ECZ8I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3da1f10b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 23 Mar 2022 04:11:26 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>,
        Graham Christensen <graham@grahamc.com>
Subject: [PATCH] random: treat bootloader trust toggle the same way as cpu trust toggle
Date:   Tue, 22 Mar 2022 22:11:23 -0600
Message-Id: <20220323041123.146459-1-Jason@zx2c4.com>
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

If CONFIG_RANDOM_TRUST_CPU is set, the RNG initializes using RDRAND.
But, the user can disable (or enable) this behavior by setting
`random.trust_cpu=0/1` on the kernel command line. This allows system
builders to do reasonable things while avoiding howls from tinfoil
hatters. (Or vice versa.)

CONFIG_RANDOM_TRUST_BOOTLOADER is basically the same thing, but regards
the seed passed via EFI or device tree, which might come from RDRAND or
a TPM or somewhere else. In order to allow distros to more easily enable
this while avoiding those same howls (or vice versa), this commit adds
the corresponding `random.trust_bootloader=0/1` toggle.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Graham Christensen <graham@grahamc.com>
Link: https://github.com/NixOS/nixpkgs/pull/165355
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 7b7f5e6596c2..c8974e5f57e1 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -948,11 +948,17 @@ static bool drain_entropy(void *buf, size_t nbytes, bool force)
  **********************************************************************/
 
 static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
+static bool trust_bootloader __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER);
 static int __init parse_trust_cpu(char *arg)
 {
 	return kstrtobool(arg, &trust_cpu);
 }
+static int __init parse_trust_bootloader(char *arg)
+{
+	return kstrtobool(arg, &trust_bootloader);
+}
 early_param("random.trust_cpu", parse_trust_cpu);
+early_param("random.trust_bootloader", parse_trust_bootloader);
 
 /*
  * The first collection of entropy occurs at system boot while interrupts
@@ -1160,7 +1166,7 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
  */
 void add_bootloader_randomness(const void *buf, size_t size)
 {
-	if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
+	if (trust_bootloader)
 		add_hwgenerator_randomness(buf, size, size * 8);
 	else
 		add_device_randomness(buf, size);
-- 
2.35.1

