Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D63D464441
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 01:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346129AbhLAAyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 19:54:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58218 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345936AbhLAAw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 19:52:57 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A05E61FD61;
        Wed,  1 Dec 2021 00:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638319774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=joQrOOQyphIMMpO+hffGJyfmGViT7Ez8ikNDXcmW/BY=;
        b=N+b8IFHX+tij7uPU4ldIRPuezWWMfY1B1B0o7iZjeIrR3c96E6kWWWAix7lkiSc+CRlWlX
        G2I2n01xuAkOs9lbpsHZzK1fWgSg3pigy7RBKFpUoq5tUr+/Vq4jyLXdq/nkv68Lt5FB0U
        3iMGY/++RjRcFsynLWu0fWSYFAr8tn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638319774;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=joQrOOQyphIMMpO+hffGJyfmGViT7Ez8ikNDXcmW/BY=;
        b=O6kbb+/bRejX16gSIKwBJR04fcAPYLD1AFWzpDHt6Z4mKc+01pb8Nto30UhN6L/b5Xn6OA
        72F1HmImMva1oOBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8027E13C10;
        Wed,  1 Dec 2021 00:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Puq4HZ7GpmECKQAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 01 Dec 2021 00:49:34 +0000
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
Subject: [PATCH 15/18] crypto: dh - store group id in dh-generic's dh_ctx
Date:   Wed,  1 Dec 2021 01:48:55 +0100
Message-Id: <20211201004858.19831-16-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211201004858.19831-1-nstange@suse.de>
References: <20211201004858.19831-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A subsequent patch will make the crypto/dh's dh_is_pubkey_valid() to
calculate the Q value from the P domain parameter for safe-prime groups,
for which by definition Q = (P - 1)/2. However, dh_is_pubkey_valid() will
need to check first whether the group in question is actually a safe-prime
group. In order to make this information available, introduce a new
->group_id member to struct dh_ctx and let dh_set_params() set it to the
value found in the struct dh as deserialized via crypto_dh_decode_key().

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/dh.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/crypto/dh.c b/crypto/dh.c
index 2e49b114e038..38547c5301da 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -13,6 +13,7 @@
 #include <linux/mpi.h>
 
 struct dh_ctx {
+	enum dh_group_id group_id;
 	MPI p;	/* Value is guaranteed to be set. */
 	MPI q;	/* Value is optional. */
 	MPI g;	/* Value is guaranteed to be set. */
@@ -55,6 +56,8 @@ static int dh_set_params(struct dh_ctx *ctx, struct dh *params)
 	if (dh_check_params_length(params->p_size << 3))
 		return -EINVAL;
 
+	ctx->group_id = params->group_id;
+
 	ctx->p = mpi_read_raw_data(params->p, params->p_size);
 	if (!ctx->p)
 		return -EINVAL;
-- 
2.26.2

