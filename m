Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B52B46E4FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhLIJI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:08:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55018 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbhLIJIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:08:04 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7437121101;
        Thu,  9 Dec 2021 09:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639040670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvLmGA3Wf79OqXaVFy5VqSNuA6ofQr1xxyf4pL7ug7M=;
        b=FdiTTQ+JML75bE1UiBEFVWsVRdS4Omk9rOoJ72/avkUULD2nUz7QmShYttFbpnm9NxEsEI
        DCXVfrk2lUfTLBDEzrHjycmkz/Z6WLepxzGzwkYR4P7gVd+QOlnbzMBfaOTdQQqCzVjPn2
        1M0DktIfOtpbpR82J3m5/gLRatvkHmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639040670;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvLmGA3Wf79OqXaVFy5VqSNuA6ofQr1xxyf4pL7ug7M=;
        b=hC6wFY1E1MR04qZrnKFJ8it4OgkLCw1H6RlR88+/NbZ5jEUx0PYXokPxzn+oUMx5bxLmos
        GeZUDYrXYJYURgBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B70413A86;
        Thu,  9 Dec 2021 09:04:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U1ONFJ7GsWHBaQAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 09 Dec 2021 09:04:30 +0000
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
Subject: [PATCH v2 11/18] crypto: dh - introduce support for ephemeral key generation to hpre driver
Date:   Thu,  9 Dec 2021 10:03:51 +0100
Message-Id: <20211209090358.28231-12-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211209090358.28231-1-nstange@suse.de>
References: <20211209090358.28231-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous patch made the dh-generic implementation's ->set_secret() to
generate an ephemeral key in case the input ->key_size is zero, just in
analogy with ecdh. Make the hpre crypto driver's DH implementation to
behave consistently by doing the same.

Signed-off-by: Nicolai Stange <nstange@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index a032c192ef1d..02ca79e263f1 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -701,11 +701,20 @@ static int hpre_dh_set_secret(struct crypto_kpp *tfm, const void *buf,
 {
 	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
 	struct dh params;
+	char key[CRYPTO_DH_MAX_PRIVKEY_SIZE];
 	int ret;
 
 	if (crypto_dh_decode_key(buf, len, &params) < 0)
 		return -EINVAL;
 
+	if (!params.key_size) {
+		ret = crypto_dh_gen_privkey(params.group_id, key,
+					    &params.key_size);
+		if (ret)
+			return ret;
+		params.key = key;
+	}
+
 	/* Free old secret if any */
 	hpre_dh_clear_ctx(ctx, false);
 
@@ -716,6 +725,8 @@ static int hpre_dh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	memcpy(ctx->dh.xa_p + (ctx->key_sz - params.key_size), params.key,
 	       params.key_size);
 
+	memzero_explicit(key, sizeof(key));
+
 	return 0;
 
 err_clear_ctx:
-- 
2.26.2

