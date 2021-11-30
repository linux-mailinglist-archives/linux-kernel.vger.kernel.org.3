Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4465546362B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbhK3ON7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:13:59 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60350 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhK3ONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:13:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ADDED21891;
        Tue, 30 Nov 2021 14:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638281435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rDuo7pVZQTFs4L5N2DQh9ls5njhAaSZRsIp1d0oOqqM=;
        b=MycXBvQZy+GhLoWQ7GNY9rDq4mB3nDKifmrEY4aL7chFMNKTe8iWIW3Gt452qksK7xjpK8
        yagjWkXKUWtHUSglmWsG292wQDVUKUak3z5rAs5nOGfJJ4RIXBmFgvYqqq5BccV9mcYDHT
        eFCkq8eDRIouyiWbpB9rBYjkqhMt2Zc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638281435;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rDuo7pVZQTFs4L5N2DQh9ls5njhAaSZRsIp1d0oOqqM=;
        b=BdYWYQ0RA7zY45InW2ROkYg0LVk6BEQf8XrnQ4OAZwvQLijXJYqlXO6OvIkHyR4HRgRLit
        PIlqmbj/qs/gg3BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91A7613D4E;
        Tue, 30 Nov 2021 14:10:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K+L6IdswpmFzLgAAMHmgww
        (envelope-from <nstange@suse.de>); Tue, 30 Nov 2021 14:10:35 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Torsten Duwe <duwe@suse.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH 1/3] crypto: drbg - ignore jitterentropy errors if not in FIPS mode
Date:   Tue, 30 Nov 2021 15:10:07 +0100
Message-Id: <20211130141009.6791-2-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211130141009.6791-1-nstange@suse.de>
References: <20211130141009.6791-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A subsequent patch will make the jitterentropy RNG to unconditionally
report health test errors back to callers, independent of whether
fips_enabled is set or not. The DRBG needs access to a functional
jitterentropy instance only in FIPS mode (because it's the only SP800-90B
compliant entropy source as it currently stands). Thus, it is perfectly
fine for the DRBGs to obtain entropy from the jitterentropy source only
on a best effort basis if fips_enabled is off.

Make the DRBGs to ignore jitterentropy failures if fips_enabled is not set.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/drbg.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 5977a72afb03..177983b6ae38 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1193,11 +1193,14 @@ static int drbg_seed(struct drbg_state *drbg, struct drbg_string *pers,
 			pr_devel("DRBG: (re)seeding with %u bytes of entropy\n",
 				 entropylen);
 		} else {
-			/* Get seed from Jitter RNG */
+			/*
+			 * Get seed from Jitter RNG, failures are
+			 * fatal only in FIPS mode.
+			 */
 			ret = crypto_rng_get_bytes(drbg->jent,
 						   entropy + entropylen,
 						   entropylen);
-			if (ret) {
+			if (fips_enabled && ret) {
 				pr_devel("DRBG: jent failed with %d\n", ret);
 
 				/*
-- 
2.26.2

