Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B486D46362D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbhK3OOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:14:01 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60360 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbhK3ON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:13:57 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4916D212B9;
        Tue, 30 Nov 2021 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638281437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dnEkwdPdKAGHHGEF5tN3IGx4PVT9y27Bh+g38lvNuD8=;
        b=IrZVVeItAjLfU3plqmvLpiZ+EgpBKl4wr3oTUnlRawpj0tDyhxXs3KJUe/J+M1Dpf0Z4cA
        2vu6d9eyAQd18otipYRqd9UT6DPI2DlZH0wmE3/fO8HPQitv0GrxvCPC3VXoOvagASd4Me
        JfocHcGufjJtcQLlWUt7zgQk2D7AJoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638281437;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dnEkwdPdKAGHHGEF5tN3IGx4PVT9y27Bh+g38lvNuD8=;
        b=sPNMXm29oqfapF1QVtdvr9ljx8SRLPUiqcW/RXV6fxnlJ7kFihwQJRBGgM8CKfTs4d5deO
        leDadFFmX4VlHsDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3139E13D4E;
        Tue, 30 Nov 2021 14:10:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xicGC90wpmF3LgAAMHmgww
        (envelope-from <nstange@suse.de>); Tue, 30 Nov 2021 14:10:37 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Torsten Duwe <duwe@suse.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH 2/3] crypto: jitter - don't limit ->health_failure check to FIPS mode
Date:   Tue, 30 Nov 2021 15:10:08 +0100
Message-Id: <20211130141009.6791-3-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211130141009.6791-1-nstange@suse.de>
References: <20211130141009.6791-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jitterentropy's Repetition Count Test (RCT) as well as the Adaptive
Proportion Test (APT) are run unconditionally on any collected samples.
However, their result, i.e. ->health_failure, will only get checked if
fips_enabled is set, c.f. the jent_health_failure() wrapper.

I would argue that a RCT or APT failure indicates that something's
seriously off and that this should always be reported as an error,
independently of whether FIPS mode is enabled or not: it should be up to
callers whether or not and how to handle jitterentropy failures.

Make jent_health_failure() to unconditionally return ->health_failure,
independent of whether fips_enabled is set.

Note that fips_enabled isn't accessed from the jitterentropy code anymore
now. Remove the linux/fips.h include as well as the jent_fips_enabled()
wrapper.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/jitterentropy-kcapi.c | 6 ------
 crypto/jitterentropy.c       | 4 ----
 crypto/jitterentropy.h       | 1 -
 3 files changed, 11 deletions(-)

diff --git a/crypto/jitterentropy-kcapi.c b/crypto/jitterentropy-kcapi.c
index e8a4165a1874..2d115bec15ae 100644
--- a/crypto/jitterentropy-kcapi.c
+++ b/crypto/jitterentropy-kcapi.c
@@ -40,7 +40,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/fips.h>
 #include <linux/time.h>
 #include <crypto/internal/rng.h>
 
@@ -60,11 +59,6 @@ void jent_zfree(void *ptr)
 	kfree_sensitive(ptr);
 }
 
-int jent_fips_enabled(void)
-{
-	return fips_enabled;
-}
-
 void jent_panic(char *s)
 {
 	panic("%s", s);
diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index 788d90749715..24e087c3f526 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -298,10 +298,6 @@ static int jent_stuck(struct rand_data *ec, __u64 current_delta)
  */
 static int jent_health_failure(struct rand_data *ec)
 {
-	/* Test is only enabled in FIPS mode */
-	if (!jent_fips_enabled())
-		return 0;
-
 	return ec->health_failure;
 }
 
diff --git a/crypto/jitterentropy.h b/crypto/jitterentropy.h
index c83fff32d130..b7397b617ef0 100644
--- a/crypto/jitterentropy.h
+++ b/crypto/jitterentropy.h
@@ -2,7 +2,6 @@
 
 extern void *jent_zalloc(unsigned int len);
 extern void jent_zfree(void *ptr);
-extern int jent_fips_enabled(void);
 extern void jent_panic(char *s);
 extern void jent_memcpy(void *dest, const void *src, unsigned int n);
 extern void jent_get_nstime(__u64 *out);
-- 
2.26.2

