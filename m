Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F301A46362E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242022AbhK3OOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:14:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60380 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236613AbhK3ON6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:13:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B78D521892;
        Tue, 30 Nov 2021 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638281438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQhE8yGgIftiH52A4CWTfhYlnu/uKm6rar23ZjE1g3o=;
        b=aeJVE1FSV0RHgteozLe3XORqMLb6MMqMztrFgX6zfnf1E23LZRpbBUl60rNhTY2DqlDIH7
        DNuYrsxOUBPBykeUyx7NEjtye1nCRpPgeqLOv7VxVcsLTXUdxHGxyivPx9GymTa6Wpvb0s
        tH8PX5f6yqdKx7SgLgTUfktObnQgIhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638281438;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQhE8yGgIftiH52A4CWTfhYlnu/uKm6rar23ZjE1g3o=;
        b=c6M2CeKp2xc7kB3QI2ga49txlMS65eLPFlgQg+z/aN1iMAmltVyyAQ8ecvDtbwWnGDGz/w
        0zPwpkJGbaOVtODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A366213D4E;
        Tue, 30 Nov 2021 14:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p/XRJt4wpmF5LgAAMHmgww
        (envelope-from <nstange@suse.de>); Tue, 30 Nov 2021 14:10:38 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Torsten Duwe <duwe@suse.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH 3/3] crypto: jitter - quit sample collection loop upon RCT failure
Date:   Tue, 30 Nov 2021 15:10:09 +0100
Message-Id: <20211130141009.6791-4-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211130141009.6791-1-nstange@suse.de>
References: <20211130141009.6791-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jitterentropy collection loop in jent_gen_entropy() can in principle
run indefinitely without making any progress if it only receives stuck
measurements as determined by jent_stuck(). After 31 consecutive stuck
samples, the Repetition Count Test (RCT) would fail anyway and the
jitterentropy RNG instances moved into ->health_failure == 1 state.
jent_gen_entropy()'s caller, jent_read_entropy() would then check for
this ->health_failure condition and return an error if found set. It
follows that there's absolutely no point in continuing the collection loop
in jent_gen_entropy() once the RCT has failed.

Make the jitterentropy collection loop more robust by terminating it upon
jent_health_failure() so that it won't continue to run indefinitely without
making any progress.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/jitterentropy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index 24e087c3f526..8f5283f28ed3 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -547,7 +547,7 @@ static void jent_gen_entropy(struct rand_data *ec)
 	/* priming of the ->prev_time value */
 	jent_measure_jitter(ec);
 
-	while (1) {
+	while (!jent_health_failure(ec)) {
 		/* If a stuck measurement is received, repeat measurement */
 		if (jent_measure_jitter(ec))
 			continue;
-- 
2.26.2

