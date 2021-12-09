Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663CC46E4FA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhLIJIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:08:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54984 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbhLIJID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:08:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 38B4921100;
        Thu,  9 Dec 2021 09:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639040669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCNr8rJh/Z4B+WmZ5iWuYLdPhezEMJc1dyDGBIavkOc=;
        b=sNmf15XpMKX2Jsc7FM26RogTM0P0H4ZPOL30J8AIScIp9AQucCEr8s47bIlaRH8nbEXw/x
        fI4Ws9ntfgOcofTu4GMgvAeVmHc/ZC1yoh+E/j9TJfO98OOsR6rh1G488FE1Yxuy7FCCQM
        5oj0adaN6/UyfNsDC+t82K2or+ZJ/gA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639040669;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCNr8rJh/Z4B+WmZ5iWuYLdPhezEMJc1dyDGBIavkOc=;
        b=lh0mABD108NFqaOyEUDgOo5cowAwqRyQZtUcDMUe63j2pQkp/kkrCyAwEuXS7Qg/+1i3iq
        Z6XoRxI+Mb1kiKBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D66613A86;
        Thu,  9 Dec 2021 09:04:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +ElXBZ3GsWG+aQAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 09 Dec 2021 09:04:29 +0000
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
Subject: [PATCH v2 10/18] crypto: dh - introduce support for ephemeral key generation to dh-generic
Date:   Thu,  9 Dec 2021 10:03:50 +0100
Message-Id: <20211209090358.28231-11-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211209090358.28231-1-nstange@suse.de>
References: <20211209090358.28231-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The support for NVME in-band authentication currently in the works ([1])
needs to generate ephemeral DH keys. Make dh-generic's ->set_secret()
to generate an ephemeral key via the recently added crypto_dh_gen_privkey()
in case the input ->key_size is zero. Note that this behaviour is in
analogy to ecdh's ->set_secret().

[1] https://lkml.kernel.org/r/20211122074727.25988-4-hare@suse.de

Signed-off-by: Nicolai Stange <nstange@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 crypto/dh.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/crypto/dh.c b/crypto/dh.c
index 131b80064cb1..2e49b114e038 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -71,25 +71,41 @@ static int dh_set_secret(struct crypto_kpp *tfm, const void *buf,
 {
 	struct dh_ctx *ctx = dh_get_ctx(tfm);
 	struct dh params;
+	char key[CRYPTO_DH_MAX_PRIVKEY_SIZE];
+	int err;
 
 	/* Free the old MPI key if any */
 	dh_clear_ctx(ctx);
 
-	if (crypto_dh_decode_key(buf, len, &params) < 0)
+	err = crypto_dh_decode_key(buf, len, &params);
+	if (err)
 		goto err_clear_ctx;
 
-	if (dh_set_params(ctx, &params) < 0)
+	if (!params.key_size) {
+		err = crypto_dh_gen_privkey(params.group_id, key,
+					    &params.key_size);
+		if (err)
+			goto err_clear_ctx;
+		params.key = key;
+	}
+
+	err = dh_set_params(ctx, &params);
+	if (err)
 		goto err_clear_ctx;
 
 	ctx->xa = mpi_read_raw_data(params.key, params.key_size);
-	if (!ctx->xa)
+	if (!ctx->xa) {
+		err = -EINVAL;
 		goto err_clear_ctx;
+	}
+
+	memzero_explicit(key, sizeof(key));
 
 	return 0;
 
 err_clear_ctx:
 	dh_clear_ctx(ctx);
-	return -EINVAL;
+	return err;
 }
 
 /*
-- 
2.26.2

