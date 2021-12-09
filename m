Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CD446E504
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhLIJId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:08:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55078 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbhLIJII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:08:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 29B10210FF;
        Thu,  9 Dec 2021 09:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639040674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qEna0uTH1UTHJ6ogfrrmwa3fLSvsnDnWxQkjGAAebI=;
        b=MhiU269KjAOS4obbLGVQQqZxUkKt9Gt2myaii/4QpBVkJgG/HS9CRl59eZpwqtvXJ4AfWN
        Ne++hMjGZac4WsefswdWpmcVC/Cda7SAA52il4TtFLrKBzCvffP02xMsHCAQbj/Ci5stsl
        PJV4Ln7tCfSNW8mVuh930qLGgbHPBeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639040674;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qEna0uTH1UTHJ6ogfrrmwa3fLSvsnDnWxQkjGAAebI=;
        b=gMaEGehbob7umo25DhnzChGNU770Fnhiiy61MFG/8pjhqkHGdIFe4zHyKOhcpZCOIm0GAQ
        pkL9IeLm/E8d3fBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12E5B13A86;
        Thu,  9 Dec 2021 09:04:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kx/oAqLGsWHSaQAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 09 Dec 2021 09:04:34 +0000
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
Subject: [PATCH v2 14/18] lib/mpi: export mpi_rshift
Date:   Thu,  9 Dec 2021 10:03:54 +0100
Message-Id: <20211209090358.28231-15-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211209090358.28231-1-nstange@suse.de>
References: <20211209090358.28231-1-nstange@suse.de>
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

