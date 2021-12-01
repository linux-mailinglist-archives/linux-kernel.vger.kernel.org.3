Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00709464419
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 01:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345974AbhLAAxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 19:53:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45980 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345874AbhLAAwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 19:52:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 782FF212BA;
        Wed,  1 Dec 2021 00:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638319765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocpi9CYZRjBEqb5t4wY3qhR39QcUEQ6rBsxEFQGzL80=;
        b=gTefI4RHuzVd9hpb+YZVpcdUbz50CGXnYTjz0HP63KR5mOSxPmgdmO6g0Ze+hWmtmKT4ra
        fcyyJzcG58Bn6pf5akcykhRfnbanUyCYdT5J8KqtAYFIfBWbsMRsYKC06iFPZy63df+wWo
        ChialyB4Q+t92Q68z+rYA5ScxMI4hOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638319765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocpi9CYZRjBEqb5t4wY3qhR39QcUEQ6rBsxEFQGzL80=;
        b=WfpZsTrGXMmVQ3/+xBe+DXtDVOcS2UlZxk/nZNOizv6QMupvG5EpmKSBCBFBXMLbhVq9Mh
        PrRZOkhTXFrM1uCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6258013C10;
        Wed,  1 Dec 2021 00:49:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QRxbFpXGpmHhKAAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 01 Dec 2021 00:49:25 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH 02/18] crypto: dh - constify struct dh's pointer members
Date:   Wed,  1 Dec 2021 01:48:42 +0100
Message-Id: <20211201004858.19831-3-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211201004858.19831-1-nstange@suse.de>
References: <20211201004858.19831-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct dh contains several pointer members corresponding to DH parameters:
->key, ->p and ->g. A subsequent commit will make the struct dh
deserialization function, crypto_dh_decode_key(), to set these to
constant static storage arrays for some of the well-known safe-prime
groups.

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
index 1abfa70ed6e1..a58f6fb9f6db 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -14,7 +14,7 @@
 #include <keys/user-type.h>
 #include "internal.h"
 
-static ssize_t dh_data_from_key(key_serial_t keyid, void **data)
+static ssize_t dh_data_from_key(key_serial_t keyid, const void **data)
 {
 	struct key *key;
 	key_ref_t key_ref;
-- 
2.26.2

