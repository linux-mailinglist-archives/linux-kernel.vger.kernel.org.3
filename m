Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775234BE4DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357756AbiBUMRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:17:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357777AbiBUMPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:15:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5295FE3;
        Mon, 21 Feb 2022 04:11:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8CA9F1F390;
        Mon, 21 Feb 2022 12:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645445489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHU5RAcZQ7wzRYrRFP5tKcrw+t/AEFW4ygcVBSPLyq4=;
        b=V8yE7oxUdEAR4NSml4Dk/hBD1RDj+SvYd1QR2d52jcznwPJNI6RyjC8OjiQreMTGAGute5
        sycMeFKjKn4qyhpihVxoOaK4XRjiHM4DIbDFs/uHv4jJkS24vgjHzllTt9BILa+hTWQgBI
        M5trhUB/vVz38XvRuEOSgNFThUFD01g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645445489;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHU5RAcZQ7wzRYrRFP5tKcrw+t/AEFW4ygcVBSPLyq4=;
        b=TmK2/EuSBp2YgHYoOorw+pll8ZO1h1Hk0lZIodkCESE+rVox+ZsFwgJ/6xA2HI26W4epg7
        yD2Q3AnVXZ/NUrCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7843B13A94;
        Mon, 21 Feb 2022 12:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AovxG3GBE2KhWwAAMHmgww
        (envelope-from <nstange@suse.de>); Mon, 21 Feb 2022 12:11:29 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v4 13/15] crypto: dh - disallow plain "dh" usage in FIPS mode
Date:   Mon, 21 Feb 2022 13:10:59 +0100
Message-Id: <20220221121101.1615-14-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220221121101.1615-1-nstange@suse.de>
References: <20220221121101.1615-1-nstange@suse.de>
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
index 5fabd7bbfba5..2d632a285869 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4650,7 +4650,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 	}, {
 		.alg = "dh",
 		.test = alg_test_kpp,
-		.fips_allowed = 1,
 		.suite = {
 			.kpp = __VECS(dh_tv_template)
 		}
-- 
2.26.2

