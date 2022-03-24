Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33F44E5DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 06:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245427AbiCXFLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 01:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiCXFLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 01:11:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D556406;
        Wed, 23 Mar 2022 22:09:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E3D260ACB;
        Thu, 24 Mar 2022 05:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8CBC340EC;
        Thu, 24 Mar 2022 05:09:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BFq7sgrG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648098576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIf6XUpZNn8sdyg0oBZDJvT0q3CuPDNYwe6tNeipyVU=;
        b=BFq7sgrG6Kfp/UxzBKwBahmmqFqH3YoVM+Qfud2jawdf25sDFMS5ZZNAu8qpXokoNlFx9t
        N5DdkFJh0amprbtj/wuGIjDKsHGxnx/a287nq75d3oICW3EBPjCkCxcFrPnOhKDvH/Ud7t
        SrCrpkUzzEoPOgpv45UPfC64dWHUKqk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1da81b14 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 24 Mar 2022 05:09:36 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Graham Christensen <graham@grahamc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v2] random: treat bootloader trust toggle the same way as cpu trust toggle
Date:   Wed, 23 Mar 2022 23:09:30 -0600
Message-Id: <20220324050930.207107-1-Jason@zx2c4.com>
In-Reply-To: <20220323041123.146459-1-Jason@zx2c4.com>
References: <20220323041123.146459-1-Jason@zx2c4.com>
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

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Graham Christensen <graham@grahamc.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Link: https://github.com/NixOS/nixpkgs/pull/165355
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
v2 updates the documentation, using the same verbage as the trust_cpu
text.

 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 drivers/char/Kconfig                            | 3 ++-
 drivers/char/random.c                           | 8 +++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c658e5d2d52c..b9d764a49207 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4400,6 +4400,12 @@
 			fully seed the kernel's CRNG. Default is controlled
 			by CONFIG_RANDOM_TRUST_CPU.
 
+	random.trust_bootloader={on,off}
+			[KNL] Enable or disable trusting the use of the
+			a seed passed by the bootloader (if available) to
+			fully seed the kernel's CRNG. Default is controlled
+			by CONFIG_RANDOM_TRUST_BOOTLOADER.
+
 	randomize_kstack_offset=
 			[KNL] Enable or disable kernel stack offset
 			randomization, which provides roughly 5 bits of
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 740811893c57..55f48375e3fe 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -449,6 +449,7 @@ config RANDOM_TRUST_BOOTLOADER
 	device randomness. Say Y here to assume the entropy provided by the
 	booloader is trustworthy so it will be added to the kernel's entropy
 	pool. Otherwise, say N here so it will be regarded as device input that
-	only mixes the entropy pool.
+	only mixes the entropy pool. This can also be configured at boot with
+	"random.trust_bootloader=on/off".
 
 endmenu
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 81dab72b611a..40107f8b9e9e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -949,11 +949,17 @@ static bool drain_entropy(void *buf, size_t nbytes, bool force)
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
@@ -1161,7 +1167,7 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
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

