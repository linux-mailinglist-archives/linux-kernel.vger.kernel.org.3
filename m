Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBCC46E508
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbhLIJIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:08:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35536 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbhLIJIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:08:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 173A41FD50;
        Thu,  9 Dec 2021 09:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639040678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hA+GGZL+BK4ETMbAa98m16cIBCJHB9mGQ0QTimQ2P40=;
        b=S9hByI2jKya5MvyZxr20VYwxiVIoBLE20mjwjPa/0c2VvTGWZVw+PfuZxURf4utQx7n6WW
        CxQZiIz7v72iDA1g2UPz64Ji2DxWM93/ntJUYNBG79mje1t8JrMYoMmqGl7BzS7/fPjpHo
        cQzKduUEuVCSOcVO7+Z3hidv66tZIO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639040678;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hA+GGZL+BK4ETMbAa98m16cIBCJHB9mGQ0QTimQ2P40=;
        b=JwD/vyJM8SvU/u/DAv0HGryvMZZ+aIyp9UKdxEgIaHp7OJjxypEFAipiVz9AY2KDZ9EplZ
        LDMD3SexrJ6w7mCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F047813A86;
        Thu,  9 Dec 2021 09:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TCzaOKXGsWHlaQAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 09 Dec 2021 09:04:37 +0000
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
Subject: [PATCH v2 17/18] crypto: dh - try to match domain parameters to a known safe-prime group
Date:   Thu,  9 Dec 2021 10:03:57 +0100
Message-Id: <20211209090358.28231-18-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211209090358.28231-1-nstange@suse.de>
References: <20211209090358.28231-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A subsequent patch will make the DH implementation to reject any input
domain parameter set with ->group_id == DH_GROUP_ID_UNKNOWN in FIPS mode.
However, as the keyctl(KEYCTL_DH_COMPUTE) implementation simply passes
forward keys from userspace, it does not (and cannot) set ->group_id to
anything else than DH_GROUP_ID_UNKNOWN.

In order to still allow for keyctl(KEYCTL_DH_COMPUTE) to work on approved
domain parameters passed in from userspace in FIPS mode, make
crypto_dh_decode_key() to compare them against any of the known groups and
set ->group_id upon having found a match, if any.

Signed-off-by: Nicolai Stange <nstange@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 crypto/dh_helper.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
index ec9c4cdf57b2..b8a726b610a2 100644
--- a/crypto/dh_helper.c
+++ b/crypto/dh_helper.c
@@ -470,6 +470,36 @@ get_safe_prime_group(enum dh_group_id group_id)
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
+		return DH_GROUP_ID_UNKNOWN;
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
+	return DH_GROUP_ID_UNKNOWN;
+}
+
 static inline u8 *dh_pack_data(u8 *dst, u8 *end, const void *src, size_t size)
 {
 	if (!dst || size > end - dst)
@@ -568,6 +598,9 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 		if (memchr_inv(params->p, 0, params->p_size) == NULL)
 			return -EINVAL;
 
+		params->group_id = lookup_group_id(params->g, params->g_size,
+						   params->p, params->p_size);
+
 	} else {
 		const struct safe_prime_group *g;
 
-- 
2.26.2

