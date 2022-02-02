Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461AE4A6F12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343767AbiBBKmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:42:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41958 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343591AbiBBKlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:41:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B18521102;
        Wed,  2 Feb 2022 10:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643798504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T7D42mbyFyOr0nXM0heUBfey/sShYlFuQidjL1PwPws=;
        b=JRdmCgQMqpIAixFVXed1TwP7hhDatpy79vxH+LFy1aEE+dLSFUZdqU91PxCdxymplgiZLJ
        aE3+50xEMLFn7I6cnkAqtEYXmBOyZAm5VmbX5hk5cvHLj3EqMWi9G2iwYInUAA6jytSUkM
        V5fke7kWOcmsK713YR9FcDEb2dWz8+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643798504;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T7D42mbyFyOr0nXM0heUBfey/sShYlFuQidjL1PwPws=;
        b=CbO5UVopFWD11nP1eY2rQkVA9XjbsoLZHUadK/0Sq493GAblSTquuEXam9Zhe6AlfNo38Y
        CxQPcjU7AidtnMDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65E7113E02;
        Wed,  2 Feb 2022 10:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AeqwFuhf+mGWbAAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 02 Feb 2022 10:41:44 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v3 13/15] crypto: dh - disallow plain "dh" usage in FIPS mode
Date:   Wed,  2 Feb 2022 11:40:10 +0100
Message-Id: <20220202104012.4193-14-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220202104012.4193-1-nstange@suse.de>
References: <20220202104012.4193-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SP800-56Arev3, sec. 5.5.2 ("Assurance of Domain-Parameter Validity")
asserts that an implementation needs to verify domain paramtere validity,
which boils down to either
- the domain parameters corresponding to some known safe-prime group
  explicitly listed to be approved in the document or
- for parameters conforming to a "FIPS 186-type parameter-size set",
  that the implementation needs to perform an explicit domain parameter
  verification, which would require access to the "seed" and "counter"
  values used in their generation.

The latter is not easily feasible and moreover, SP800-56Arev3 states that
safe-prime groups are preferred and that FIPS 186-type parameter sets
should only be supported for backward compatibility, if it all.

Mark "dh" as not fips_allowed in testmgr. Note that the safe-prime
ffdheXYZ(dh) wrappers are not affected by this change: as these enforce
some approved safe-prime group each, their usage is still allowed in FIPS
mode.

This change will effectively render the keyctl(KEYCTL_DH_COMPUTE) syscall
unusable in FIPS mode, but it has been brought up that this might even be
a good thing ([1]).

[1] https://lore.kernel.org/r/20211217055227.GA20698@gondor.apana.org.au

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/testmgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index d715ddc22c6b..b7973a47c6f4 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4647,7 +4647,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 	}, {
 		.alg = "dh",
 		.test = alg_test_kpp,
-		.fips_allowed = 1,
 		.suite = {
 			.kpp = __VECS(dh_tv_template)
 		}
-- 
2.26.2

