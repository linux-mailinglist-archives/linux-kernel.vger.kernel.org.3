Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2FF4BE854
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357644AbiBUMO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:14:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357612AbiBUMOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:14:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E7420F6B;
        Mon, 21 Feb 2022 04:11:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4E00721138;
        Mon, 21 Feb 2022 12:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645445478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4WSAO4KoAjJN30nEtBuKVSDbAprmPqyfN2R4/SBnjpI=;
        b=ofRCS6qKDoWg7EEMqQ5Z4wG6cGl7a9FUSQqS1mRtA5JEKE/rWIAL5zmciJe5QsUsn3Td85
        Lz+keTKhmrKlZkMQgv4q+59SMWK7Nk5KAOXUL7I5AlSddAFe+n9wjP4QpX8vkpZz26DwK7
        IW6eZHwNZajN2e5dzom2qaYp3wff8nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645445478;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4WSAO4KoAjJN30nEtBuKVSDbAprmPqyfN2R4/SBnjpI=;
        b=hrJU/N1uL6K7GjJ/0SanKtKOB807HboFScHCfeO3B485ySs8dbhlq7Fhp1uQvvoAuLiVEO
        zvjMRRGKKCS+hWBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 388A413A9C;
        Mon, 21 Feb 2022 12:11:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jX2GDGaBE2JzWwAAMHmgww
        (envelope-from <nstange@suse.de>); Mon, 21 Feb 2022 12:11:18 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v4 04/15] crypto: dh - constify struct dh's pointer members
Date:   Mon, 21 Feb 2022 13:10:50 +0100
Message-Id: <20220221121101.1615-5-nstange@suse.de>
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

struct dh contains several pointer members corresponding to DH parameters:
->key, ->p and ->g. A subsequent commit will introduce "dh" wrapping
templates of the form "ffdhe2048(dh)", "ffdhe3072(dh)" and so on in order
to provide built-in support for the well-known safe-prime ffdhe group
parameters specified in RFC 7919. These templates will need to set the
group parameter related members of the (serialized) struct dh instance
passed to the inner "dh" kpp_alg instance, i.e. ->p and ->g, to some
constant, static storage arrays.

Turn the struct dh pointer members' types into "pointer to const" in
preparation for this.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 include/crypto/dh.h | 6 +++---
 security/keys/dh.c  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/crypto/dh.h b/include/crypto/dh.h
index 2585f0e6bb69..67f3f6bca527 100644
--- a/include/crypto/dh.h
+++ b/include/crypto/dh.h
@@ -30,9 +30,9 @@
  * @g_size:	Size of DH generator G
  */
 struct dh {
-	void *key;
-	void *p;
-	void *g;
+	const void *key;
+	const void *p;
+	const void *g;
 	unsigned int key_size;
 	unsigned int p_size;
 	unsigned int g_size;
diff --git a/security/keys/dh.c b/security/keys/dh.c
index 4573fc15617d..b339760a31dd 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -15,7 +15,7 @@
 #include <keys/user-type.h>
 #include "internal.h"
 
-static ssize_t dh_data_from_key(key_serial_t keyid, void **data)
+static ssize_t dh_data_from_key(key_serial_t keyid, const void **data)
 {
 	struct key *key;
 	key_ref_t key_ref;
-- 
2.26.2

