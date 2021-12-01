Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0810046443F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 01:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346091AbhLAAyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 19:54:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58186 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345922AbhLAAwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 19:52:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 806D01FD60;
        Wed,  1 Dec 2021 00:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638319772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uqN+KoCZ+C9BhFwzmXjcu2xieMALlbPBAiHPvURkpJQ=;
        b=Lat5lAbPE+RphGYj547/LoMG1vr5BLvUWu9DyIOWOQovk63wglyF900QgrUtvQgrWTvl2s
        5Y37jDEVtI+jF6TUxrtmVOYzUkCh9BpdYs60upO24XaYWLSBu3Io7ixIkXBOeN6sar4rNo
        QmFTvQeY44aAiBFzQFeMWBBdPTjLBtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638319772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uqN+KoCZ+C9BhFwzmXjcu2xieMALlbPBAiHPvURkpJQ=;
        b=8xQKxaiST0fQTnrcbYeSTXwq38uf5e/uCWQiX625NSo89MpHeGv7xTO8Gj4oZ/gOmWgi38
        IoS6jf6F/OhUIfDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D28C13C10;
        Wed,  1 Dec 2021 00:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2AR+GZzGpmH8KAAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 01 Dec 2021 00:49:32 +0000
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
Subject: [PATCH 12/18] crypto: dh - introduce support for ephemeral key generation to qat driver
Date:   Wed,  1 Dec 2021 01:48:52 +0100
Message-Id: <20211201004858.19831-13-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211201004858.19831-1-nstange@suse.de>
References: <20211201004858.19831-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous patch made the dh-generic implementation's ->set_secret() to
generate an ephemeral key in case the input ->key_size is zero, just in
analogy with ecdh. Make the qat crypto driver's DH implementation to
behave consistently by doing the same.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 drivers/crypto/qat/qat_common/qat_asym_algs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
index b0b78445418b..e0d3a70fa6b1 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -441,11 +441,20 @@ static int qat_dh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	struct qat_dh_ctx *ctx = kpp_tfm_ctx(tfm);
 	struct device *dev = &GET_DEV(ctx->inst->accel_dev);
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
 	qat_dh_clear_ctx(dev, ctx);
 
-- 
2.26.2

