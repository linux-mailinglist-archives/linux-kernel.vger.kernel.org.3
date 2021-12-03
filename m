Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79EC4679B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381608AbhLCOud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244894AbhLCOuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:50:17 -0500
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD07C0698C0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:46:47 -0800 (PST)
Received: by mail-io1-xd4a.google.com with SMTP id 7-20020a6b0107000000b005ed196a2546so2426517iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 06:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JWEgLWnbDmFFCeBV+2I916S5Yu2gVv1q9zpW5VdLWgE=;
        b=ZzbKvfBV3bmgA43H10WPAaTGXXYoSVa+Dww2LGp9kjxCzVz7hZ7snCXI64n3H9Pdd5
         DMyHaOYRDs7HhXCgsRhHTxgIoM9y2JqZ12v/AEAFeT5RL/C9tRJa9OB4NM87nruGsdR6
         H3J7zA2SUexdcOKG22ctSLFtt4q+Gjx9L1RBQJgIZl8JGhyBqMGYQqcmNVp1PkDL1ZGR
         0M9gJwtod2Fs7Z4Oy9O9gjoVHHNMh/dRNKHsDOSG20SYOLI5hVvvc4csztcjg2mfRqGG
         oZsjxDiZsEOIx4eyetjsVX5ENlGVV2w9dfRFG4QumtiU24G3egyCvHmdwsVofIqbWkLq
         fJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JWEgLWnbDmFFCeBV+2I916S5Yu2gVv1q9zpW5VdLWgE=;
        b=vhbC/bMATfO0EeAVdeN1qVJEa4/rgoUMqTi8IO83hGMFG7ZEkD57rQBLdY1Q4t0Xg9
         +E5mpMI95xUMyLeXUizPVodUpWGJUIDmsH49z17N92QFO29eyIA7lJQlEC+vPY7s7cjw
         DvK8I2gcSLlQ4AxahtzygpxxTqk+78q+pmW8/eAkdH6oRdkI1bMBamHuoQa1iYM7bRKd
         +VouznTxrMULJXayCEyajYMGE+dW+fAH8W7UgXrbMsPq03gKjQnIqhmg9eGu7/3QjbzS
         QjfOEnj32/SKn/JXhP62qDiihW4UhZketWMtLgyIgia/oqSSCn9x6ifnNzB2O1VJ6r7u
         hq0A==
X-Gm-Message-State: AOAM531qVdTAV3USj+IEcbHQUD+l16jKSMRjB/vxAVFxKpIpz5iwhff2
        bG8DfvHGtHm06tLEOBBkn6oZTpnOltY=
X-Google-Smtp-Source: ABdhPJxWzE9JbFktJxQjM8pHkKtyo21ASglcbRwARNXd3BXCb7hC5T9Y/oTi3aA0eEJDvoekoMeQl7S59Zw=
X-Received: from pgonda2.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:ac9])
 (user=pgonda job=sendgmr) by 2002:a02:9586:: with SMTP id b6mr25416004jai.24.1638542807341;
 Fri, 03 Dec 2021 06:46:47 -0800 (PST)
Date:   Fri,  3 Dec 2021 14:46:40 +0000
In-Reply-To: <20211203144642.3460447-1-pgonda@google.com>
Message-Id: <20211203144642.3460447-4-pgonda@google.com>
Mime-Version: 1.0
References: <20211203144642.3460447-1-pgonda@google.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [PATCH V5 3/5] crypto: ccp - Refactor out sev_fw_alloc()
From:   Peter Gonda <pgonda@google.com>
To:     thomas.lendacky@amd.com
Cc:     Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a helper function sev_fw_alloc() which can be used to allocate
aligned memory regions for use by the PSP firmware. Currently only used
for the SEV-ES TMR region but will be used for the SEV_INIT_EX NV memory
region.

Signed-off-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Acked-by: David Rientjes <rientjes@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Rientjes <rientjes@google.com>
Cc: John Allen <john.allen@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/ccp/sev-dev.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index ef7e8b4c6e02..7f467921b1dc 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -141,6 +141,17 @@ static int sev_cmd_buffer_len(int cmd)
 	return 0;
 }
 
+static void *sev_fw_alloc(unsigned long len)
+{
+	struct page *page;
+
+	page = alloc_pages(GFP_KERNEL, get_order(len));
+	if (!page)
+		return NULL;
+
+	return page_address(page);
+}
+
 static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 {
 	struct psp_device *psp = psp_master;
@@ -1094,14 +1105,10 @@ void sev_pci_init(void)
 		sev_get_api_version();
 
 	/* Obtain the TMR memory area for SEV-ES use */
-	tmr_page = alloc_pages(GFP_KERNEL, get_order(SEV_ES_TMR_SIZE));
-	if (tmr_page) {
-		sev_es_tmr = page_address(tmr_page);
-	} else {
-		sev_es_tmr = NULL;
+	sev_es_tmr = sev_fw_alloc(SEV_ES_TMR_SIZE);
+	if (!sev_es_tmr)
 		dev_warn(sev->dev,
 			 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
-	}
 
 	/* Initialize the platform */
 	rc = sev_platform_init(&error);
-- 
2.34.0.384.gca35af8252-goog

