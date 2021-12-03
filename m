Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1DB467F76
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383250AbhLCVsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbhLCVsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:48:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C41C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 13:45:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x5-20020a2584c5000000b005f89a35e57eso8583559ybm.19
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 13:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RHK+edLmIUWz40oQK0k2EB+zsYPqIcWKG5v/bzlYL3s=;
        b=WTpIu+BmV2MaJXQyIPqMOuqudR4ipfc/lBSg/RwPhhwNmdblAQrffksib3XJwv3Cz6
         9tArGjUra1DnWSC+O3WXDwjzhA2gap58LpwCvnFxcVLqvGZj9H2eQxaY2T3i12uZAtMf
         T2csBQYtknK6kXc2h/Adb7hE8pXt5rN3ocgdA52wcbyltoh+5ndKLtmNg+zKk80qHtXW
         XEDaaVX0jGPWzQGY7IUWoZhiuN27QNILDNtJtpzoOYUEJXXpe2jjlnZp7tBuwyAN2pzR
         N4F7vcCr5yccev+SlZyBMxN9mnkf/Qfa7yoTm4KW62ytrBEmdHZoe/sGWtydBcHq/x0b
         yomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RHK+edLmIUWz40oQK0k2EB+zsYPqIcWKG5v/bzlYL3s=;
        b=iicBxN+s3/ThiIakeFrSUnCsdeozZLgfe2WRyRXwBMjpEV4gQ9APTvJn5ExSZWjg5Y
         XV9N2mYjDkqOmZCJMB23/6QGB7MtHvh+hnCLEYw6wycLDeNUpMyHYoKLfxdZiS/3fbE/
         EbmghD9pVyBqdxFozPphIMU73za3rL6rvjhFCiGpSFfT9bWcVKWrmbh1Ixa5F2Xrn4BD
         G5g/jBvqIZwfr2sSfCr7F9lOh+YP5nHH1VUWAHFRBTKJQVZ1j73M7XxUTANQ72W4tQ7+
         ww2VTXY11bBRYBJ9TbHAztev2VVJVopu8g7q7zx7Aa79Lals9Ous8doDbyEiI26iEIhq
         Hvkg==
X-Gm-Message-State: AOAM530wAAsJF+lPe73CKsV1grtJGM1/R7zb7C57ZNO8StGhUpjF17IC
        6cJMH0BFMbWRvz2gZlDxZv9IfskyByE=
X-Google-Smtp-Source: ABdhPJy8UUaWD9v/1ifwYxxl6TnM6YwGFeelAwYAclkqiL0CQB7fPjx/km6+ewYKV0rAfywPEA3pB3mifTk=
X-Received: from pgonda2.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:ac9])
 (user=pgonda job=sendgmr) by 2002:a05:6902:701:: with SMTP id
 k1mr27777503ybt.71.1638567915585; Fri, 03 Dec 2021 13:45:15 -0800 (PST)
Date:   Fri,  3 Dec 2021 21:45:02 +0000
Message-Id: <20211203214502.3545842-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH V5.1 3/5] crypto: ccp - Refactor out sev_fw_alloc()
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

Mistakenly send old patch, this is the fixed version.

---
 drivers/crypto/ccp/sev-dev.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index ef7e8b4c6e02..8ea362ac014f 100644
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
@@ -1078,7 +1089,6 @@ EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
 void sev_pci_init(void)
 {
 	struct sev_device *sev = psp_master->sev_data;
-	struct page *tmr_page;
 	int error, rc;
 
 	if (!sev)
@@ -1094,14 +1104,10 @@ void sev_pci_init(void)
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
2.34.1.400.ga245620fadb-goog

