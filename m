Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756A84A6F0A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343714AbiBBKmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:42:22 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36848 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343575AbiBBKlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:41:47 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B222D1F37C;
        Wed,  2 Feb 2022 10:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643798505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qEna0uTH1UTHJ6ogfrrmwa3fLSvsnDnWxQkjGAAebI=;
        b=d+7mwe+dJ0R+Ni0BM3Onekp1EVtC9+ZQNEg603nKIEZP8c7UAlXhngCcOkmMwmC3xtDBO7
        Lba7Dbn7kARzpVVO3S0MQ4VayKMwekkyN98BK5sTN6pN9kAsLPDfMPnVX4KII7zWZUlp3v
        aiiOi/k1JSUAMaO1S/43AEy460vWR7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643798505;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qEna0uTH1UTHJ6ogfrrmwa3fLSvsnDnWxQkjGAAebI=;
        b=fNtr+vOiIZWwgtmFBlGTBOEgTuGu4LrYZ+sM4AX7XMBAb6lsA61QRzbSGegCEPVP8Opzv3
        VoNa5BFSsytjnfAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AF8813E02;
        Wed,  2 Feb 2022 10:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RO09JOlf+mGcbAAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 02 Feb 2022 10:41:45 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v3 14/15] lib/mpi: export mpi_rshift
Date:   Wed,  2 Feb 2022 11:40:11 +0100
Message-Id: <20220202104012.4193-15-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220202104012.4193-1-nstange@suse.de>
References: <20220202104012.4193-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A subsequent patch will make the crypto/dh's dh_is_pubkey_valid() to
calculate a safe-prime groups Q parameter from P: Q = (P - 1) / 2. For
implementing this, mpi_rshift() will be needed. Export it so that it's
accessible from crypto/dh.

Signed-off-by: Nicolai Stange <nstange@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 lib/mpi/mpi-bit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/mpi/mpi-bit.c b/lib/mpi/mpi-bit.c
index 142b680835df..070ba784c9f1 100644
--- a/lib/mpi/mpi-bit.c
+++ b/lib/mpi/mpi-bit.c
@@ -242,6 +242,7 @@ void mpi_rshift(MPI x, MPI a, unsigned int n)
 	}
 	MPN_NORMALIZE(x->d, x->nlimbs);
 }
+EXPORT_SYMBOL_GPL(mpi_rshift);
 
 /****************
  * Shift A by COUNT limbs to the left
-- 
2.26.2

