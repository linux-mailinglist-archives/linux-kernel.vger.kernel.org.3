Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABE34A6F0D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244291AbiBBKls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:41:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36744 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243490AbiBBKlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:41:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 783BB1F383;
        Wed,  2 Feb 2022 10:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643798493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4WSAO4KoAjJN30nEtBuKVSDbAprmPqyfN2R4/SBnjpI=;
        b=1HE1xFDf8UqZhvphAYrHgCUwvX01n1bh9f3Ft+c/pkSzAU6V3DOLoeKkYaDgAaXCqnrhOz
        aeW4zzZj0wb8/IQJcq1HJ/61ushPSP1aklMulKL47QbzKE4zQYlv0DJ22Fs/gkwuLzylhM
        hHjwakd2bHJlaBeicT9LOzETiwmkdW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643798493;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4WSAO4KoAjJN30nEtBuKVSDbAprmPqyfN2R4/SBnjpI=;
        b=3Fn+iNLno4zkyOZvxFtUf/bkF/Vfb+V5gK9rGix1dTs2tZJ9AUxgQS3r4erQkyCqe6BzgL
        HHllsT+oN9juTeDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64B6E13E02;
        Wed,  2 Feb 2022 10:41:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s6J4F91f+mFtbAAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 02 Feb 2022 10:41:33 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v3 04/15] crypto: dh - constify struct dh's pointer members
Date:   Wed,  2 Feb 2022 11:40:01 +0100
Message-Id: <20220202104012.4193-5-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220202104012.4193-1-nstange@suse.de>
References: <20220202104012.4193-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

