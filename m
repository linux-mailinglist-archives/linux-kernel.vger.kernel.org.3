Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353D1464446
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 01:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345915AbhLAAzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 19:55:07 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46120 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345927AbhLAAwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 19:52:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DAFD4218B0;
        Wed,  1 Dec 2021 00:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638319773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NXnywiVMHG+5JOnuWv+Zk8oIW2CyLkb/2z/hvW1vh6c=;
        b=FL5xOUfG+UMRPlr6thZJghC1woUSKy+DdD9o2ZlfeP90JHq//JFGgKyGITOwTXMlZmE0Sv
        7OqqBQhnTy9ws9hXmbN3rhROpLfAgPjM4Vk+sKTBJpiV5R5ngvi0Kc2eWrLUEzyrTthF9j
        clqOTZ1r45QcKMdA7qkpKN7ZCoB2onM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638319773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NXnywiVMHG+5JOnuWv+Zk8oIW2CyLkb/2z/hvW1vh6c=;
        b=FxOevjpFK5oGFKxLlqoTLN0WHV7zO1HyOO8EJ8oeC4C95OhkfbO9V9JAF0m01298VsM63K
        qImgpgq2Tbn8aFBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C789F13C10;
        Wed,  1 Dec 2021 00:49:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1vAwL53GpmEAKQAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 01 Dec 2021 00:49:33 +0000
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
Subject: [PATCH 14/18] lib/mpi: export mpi_rshift
Date:   Wed,  1 Dec 2021 01:48:54 +0100
Message-Id: <20211201004858.19831-15-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211201004858.19831-1-nstange@suse.de>
References: <20211201004858.19831-1-nstange@suse.de>
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

