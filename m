Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0DE464444
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 01:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhLAAyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 19:54:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46176 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345963AbhLAAxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 19:53:09 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E173218B5;
        Wed,  1 Dec 2021 00:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638319776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0kYjcIRJ+mIjkvtJdvPpy3tX0Jl/na4C4276sDNNrCM=;
        b=hyFa9HsoCO92KOt/swbuYXQHPYshJh4kQ8YRkyf9t67+og9Cpkvn0S9Ih5aXLcbu5uIdDZ
        AGmWpSzKSfzaO6ovbNLDVyGF04K1d21sZ80+W0tDGUPaLniwqoArOfeGh4WolzzLR/n/EH
        ks2Ep1ww913hfrz6rBUi5r6mGa0+psQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638319776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0kYjcIRJ+mIjkvtJdvPpy3tX0Jl/na4C4276sDNNrCM=;
        b=yeZIpWybSTbz2rqax6/Z2Nb2HZ/0hDUhjEARuJH/b+zNSsj796l2v5qe1OaK5jYReN1Wap
        3zFuyidL6zSIRoAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECAF313C10;
        Wed,  1 Dec 2021 00:49:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NwFDOJ/GpmEJKQAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 01 Dec 2021 00:49:35 +0000
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
Subject: [PATCH 17/18] crypto: dh - try to match domain parameters to a known safe-prime group
Date:   Wed,  1 Dec 2021 01:48:57 +0100
Message-Id: <20211201004858.19831-18-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211201004858.19831-1-nstange@suse.de>
References: <20211201004858.19831-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A subsequent patch will make the DH implementation to reject any input
domain parameter set with ->group_id == dh_group_id_unknown in FIPS mode.
However, as the keyctl(KEYCTL_DH_COMPUTE) implementation simply passes
forward keys from userspace, it does not (and cannot) set ->group_id to
anything else than dh_group_id_unknown.

In order to still allow for keyctl(KEYCTL_DH_COMPUTE) to work on approved
domain parameters passed in from userspace in FIPS mode, make
crypto_dh_decode_key() to compare them against any of the known groups and
set ->group_id upon having found a match, if any.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/dh_helper.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
index 5a8c9c50297f..cf632beca65e 100644
--- a/crypto/dh_helper.c
+++ b/crypto/dh_helper.c
@@ -471,6 +471,36 @@ get_safe_prime_group(enum dh_group_id group_id)
 	return NULL;
 }
 
+static enum dh_group_id lookup_group_id(const char *g, size_t g_size,
+					const char *p, size_t p_size)
+{
+	int i;
+
+	/* All safe-prime groups use a generator of g == 2. */
+	while (g_size && !*g) {
+		++g;
+		--g_size;
+	}
+
+	if (g_size != 1 || *g != 2)
+		return dh_group_id_unknown;
+
+	while (p_size && !*p) {
+		++p;
+		--p_size;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(safe_prime_groups); ++i) {
+		if (safe_prime_groups[i].p_size != p_size)
+			continue;
+
+		if (!memcmp(safe_prime_groups[i].p, p, p_size))
+			return safe_prime_groups[i].group_id;
+	}
+
+	return dh_group_id_unknown;
+}
+
 static inline u8 *dh_pack_data(u8 *dst, u8 *end, const void *src, size_t size)
 {
 	if (!dst || size > end - dst)
@@ -566,6 +596,9 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 		if (memchr_inv(params->p, 0, params->p_size) == NULL)
 			return -EINVAL;
 
+		params->group_id = lookup_group_id(params->g, params->g_size,
+						   params->p, params->p_size);
+
 	} else {
 		const struct safe_prime_group *g;
 
-- 
2.26.2

