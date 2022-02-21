Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7774BE203
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357862AbiBUMSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:18:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357678AbiBUMPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:15:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F065193EB;
        Mon, 21 Feb 2022 04:11:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D5FE41F393;
        Mon, 21 Feb 2022 12:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645445490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qEna0uTH1UTHJ6ogfrrmwa3fLSvsnDnWxQkjGAAebI=;
        b=G5g7N+WLdnY6++W5emhg0qPBZ2jbKWGyIM3FlV5/Ikl3B8b9V1QhqtOWm29mO24U1Soz8U
        B64jFQjszbHWQu1bjvWSuKFuILFnEbVrm4ksLATdwEpS1VqgT7uiT3J5k5qaz37mw1KHWb
        PCCyKxS+KP8mpaGYktzozpHn9jZ5g0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645445490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qEna0uTH1UTHJ6ogfrrmwa3fLSvsnDnWxQkjGAAebI=;
        b=Ak/cqFvhpZPKB5YPH2VE8jK8+HYB/ORCWAlfKWOIK6Plza6AWp3W51dFI6strheEcEfRj3
        GZEzga7Jc4j9N6Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1E1C13A94;
        Mon, 21 Feb 2022 12:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2JXILXKBE2KnWwAAMHmgww
        (envelope-from <nstange@suse.de>); Mon, 21 Feb 2022 12:11:30 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v4 14/15] lib/mpi: export mpi_rshift
Date:   Mon, 21 Feb 2022 13:11:00 +0100
Message-Id: <20220221121101.1615-15-nstange@suse.de>
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

