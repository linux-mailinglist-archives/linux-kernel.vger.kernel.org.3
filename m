Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5F35A8429
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiHaRUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiHaRUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:20:40 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A4F6E8B3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:20:31 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id cr9so11480406qtb.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=/I4y0YK+VpCO/CUay/PbDqOuvxIs0Un9wpsU5e2kzjo=;
        b=ZShm0/XYuJ91hTuGCSE3w0AVpgFGdvzLcvwXIRu+Tb8xKhCSTVabC6cTnh9/gWfCY7
         0/Te+wkwE2YF56S4LiVAFOCTjFg+7p3QuQloQSa7fNkg5qJUQKx+FBg9K+sYFA07t775
         AxA2rQs/gZxof3K0I3ZwbS7eMN9wuHBq9EfVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/I4y0YK+VpCO/CUay/PbDqOuvxIs0Un9wpsU5e2kzjo=;
        b=uEXCrPI88LelpSMqS5EgF80t4kGnw6QSb172OKd+LykmsiRfUVKEkmgzXMyd+EblMf
         jhYpnVKi84jVKnI6IQMEL0mMoAlrLVI3K0oJ5DYY3Be0cNHfedLcK56R78YFd7cptzUa
         XvaX8ZwbV8UDWUektFsxEPHAsIGFGT9YaF5G3lrzXV4Vfs4yC/s05At8XJfnP466qps0
         pnoQUgiQVB1Tormmd26LFn3SGGsJvnWvgUSDc+AbNR/81yMV+oV1xfw/o+mQv/lwK610
         nHL44dGtiS6pRLLD1hXMJRXJYHQl1PKuFOuPbEUeHLnYFu+xX/4GY+NegqCZA0vcfJmM
         qBHQ==
X-Gm-Message-State: ACgBeo2E7T5gPWeIVc4nxoSgq78XdUorb9N9KqK9pqK337hvNPng+HYe
        uC5erjUNlWyCJH1zsF1OTJzBlSo2WlNUryWt
X-Google-Smtp-Source: AA6agR42Ox0JL/UqP+ixpBQ44ewts/NNWEdi9NCccq0XABy/HDBNzkv4LB2frYvPED+ZG48V/r7Srw==
X-Received: by 2002:ac8:5e0a:0:b0:344:9b69:eef0 with SMTP id h10-20020ac85e0a000000b003449b69eef0mr20114102qtx.666.1661966430257;
        Wed, 31 Aug 2022 10:20:30 -0700 (PDT)
Received: from trappist.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id ge17-20020a05622a5c9100b003430589dd34sm8962611qtb.57.2022.08.31.10.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:20:29 -0700 (PDT)
From:   Sven van Ashbrook <svenva@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Levin <levinale@google.com>, Rajat Jain <rajatja@google.com>,
        Andrey Pronin <apronin@google.com>,
        Stephen Boyd <swboyd@google.com>,
        Sven van Ashbrook <svenva@chromium.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Olivia Mackall <olivia@selenic.com>,
        Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>, linux-crypto@vger.kernel.org
Subject: [PATCH v1 1/2] random: make add_hwgenerator_randomness() more flexible
Date:   Wed, 31 Aug 2022 17:20:23 +0000
Message-Id: <20220831172024.1613208-1-svenva@chromium.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add_hwgenerator_randomness() currently blocks until more entropy
is needed. But, the required delay function will depend on the
the caller: e.g. freezable kthreads have their own freezable_XXX()
APIs; and delayed_work might prefer to use mod_delayed_work().

To accommodate these requirements, remove the blocking wait, and
let the function return the delay needed until more entropy is needed.

Signed-off-by: Sven van Ashbrook <svenva@chromium.org>
---

 drivers/char/hw_random/core.c |  7 +++++--
 drivers/char/random.c         | 13 ++++++-------
 include/linux/random.h        |  2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 16f227b995e8..3675122c6cce 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -491,6 +491,7 @@ static int __init register_miscdev(void)
 static int hwrng_fillfn(void *unused)
 {
 	size_t entropy, entropy_credit = 0; /* in 1/1024 of a bit */
+	unsigned long delay;
 	long rc;
 
 	while (!kthread_should_stop()) {
@@ -526,8 +527,10 @@ static int hwrng_fillfn(void *unused)
 			entropy_credit = entropy;
 
 		/* Outside lock, sure, but y'know: randomness. */
-		add_hwgenerator_randomness((void *)rng_fillbuf, rc,
-					   entropy >> 10);
+		delay = add_hwgenerator_randomness((void *)rng_fillbuf, rc,
+						   entropy >> 10);
+		if (delay > 0)
+			schedule_timeout_interruptible(delay);
 	}
 	hwrng_fill = NULL;
 	return 0;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 79d7d4e4e582..7b6c27065cf9 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -686,7 +686,7 @@ static void __cold _credit_init_bits(size_t bits)
  * the above entropy accumulation routines:
  *
  *	void add_device_randomness(const void *buf, size_t len);
- *	void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy);
+ *	unsigned long add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy);
  *	void add_bootloader_randomness(const void *buf, size_t len);
  *	void add_vmfork_randomness(const void *unique_vm_id, size_t len);
  *	void add_interrupt_randomness(int irq);
@@ -702,8 +702,8 @@ static void __cold _credit_init_bits(size_t bits)
  * available to them (particularly common in the embedded world).
  *
  * add_hwgenerator_randomness() is for true hardware RNGs, and will credit
- * entropy as specified by the caller. If the entropy pool is full it will
- * block until more entropy is needed.
+ * entropy as specified by the caller. Returns number time delay in jiffies
+ * until more entropy is needed.
  *
  * add_bootloader_randomness() is called by bootloader drivers, such as EFI
  * and device tree, and credits its input depending on whether or not the
@@ -857,10 +857,10 @@ EXPORT_SYMBOL(add_device_randomness);
 
 /*
  * Interface for in-kernel drivers of true hardware RNGs.
- * Those devices may produce endless random bits and will be throttled
+ * Those devices may produce endless random bits and should be throttled
  * when our pool is full.
  */
-void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
+unsigned long add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
 {
 	mix_pool_bytes(buf, len);
 	credit_init_bits(entropy);
@@ -869,8 +869,7 @@ void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
 	 * Throttle writing to once every CRNG_RESEED_INTERVAL, unless
 	 * we're not yet initialized.
 	 */
-	if (!kthread_should_stop() && crng_ready())
-		schedule_timeout_interruptible(CRNG_RESEED_INTERVAL);
+	return crng_ready() ? CRNG_RESEED_INTERVAL : 0;
 }
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
 
diff --git a/include/linux/random.h b/include/linux/random.h
index 3fec206487f6..6608b0fb4402 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -17,7 +17,7 @@ void __init add_bootloader_randomness(const void *buf, size_t len);
 void add_input_randomness(unsigned int type, unsigned int code,
 			  unsigned int value) __latent_entropy;
 void add_interrupt_randomness(int irq) __latent_entropy;
-void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy);
+unsigned long add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy);
 
 #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 static inline void add_latent_entropy(void)
-- 
2.37.2.672.g94769d06f0-goog

