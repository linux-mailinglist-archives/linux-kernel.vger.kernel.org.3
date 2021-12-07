Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8100C46C844
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbhLGXgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242605AbhLGXgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:36:47 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8A3C061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:33:16 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id w7-20020a634907000000b0032d64927016so261491pga.17
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 15:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NyP8sL/WxxBH7JUR2jE6+QS2DZJi6iBbnJsRRfn1ObM=;
        b=U7fvRAj6L3zYcu5y0Fz/ZCwr8xpf3hNHvev8A7QdvuEuIzGPmbEo++Tis3La8ai/oB
         HOxyA2IM3Z5xVkiLk8W8cBy5HHOrwv/9zuI121Fz3dKg0BmBi5rlWKwmSd/rokfrI5wb
         DeXaFIga8ilQ8DEiIYLTUYRRxNJyI+7fJgXYOl2uScg4MH/Z/6gImLw+yf/EwULMAqsb
         vSGVWk8lDHCyZhpvTpriaImWvBao8dDgppzh1Zf2U2zb/w2qRzKb53rPm+VMyzqHf0wn
         MVLVWdNK0N7SDSeqa6xOhVrjcjXFhHwdcoUJtrv0WBgtdvstsh6EkM8rQ5Icb8u3soki
         pDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NyP8sL/WxxBH7JUR2jE6+QS2DZJi6iBbnJsRRfn1ObM=;
        b=xdu2W0nkj5hXqp247EfwhZxYhGxFXSxSERo1pKWVkYVnZQZfbxjw1fNHdlTP1jE/F0
         63dXX1rgOU5/U+Pr0y/fRuc1T82H0kQCE30KrRiN9uTaeIETRF/9O2AWf7U5RTiftDhx
         8NQmyi9ZyZUMxJCbvFmVLGJ+gzqf1RzDXCg4+cf0t/LxmuAFqsbnmRorhmZPK39mL5K9
         wTw6o601ueQBSDZ83V5k7rgoLb4d9PStyEyY6jzPhqE7lEGxusA3fkxObOy0l+1Ea9bl
         O8kOLS1LQciq5RwMfDlCpvP/jrSsYBPMqpGY9qwHhI/Ma9SbH923aDzhtvXSh+XOtshQ
         jAbw==
X-Gm-Message-State: AOAM532Tfoa2NNgGSUmUMOtdPCvq4QxwepCwiJQISPB8a24AvcaIIe4h
        SHEaLaKepUnjvBUENgbmV3beIUmBZhU=
X-Google-Smtp-Source: ABdhPJx3NSvXc2AFJTTKB8653/2hxn63jAmQWpPvyztLFzfgc3/fRXpZtGiBTtQErQZQKkTQ7WKCWiSXsus=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:46ed:9c47:8229:475d])
 (user=pgonda job=sendgmr) by 2002:a05:6a00:24c7:b0:4a0:41b:38f9 with SMTP id
 d7-20020a056a0024c700b004a0041b38f9mr2364617pfv.54.1638919996068; Tue, 07 Dec
 2021 15:33:16 -0800 (PST)
Date:   Tue,  7 Dec 2021 15:33:03 -0800
In-Reply-To: <20211207233306.2200118-1-pgonda@google.com>
Message-Id: <20211207233306.2200118-3-pgonda@google.com>
Mime-Version: 1.0
References: <20211207233306.2200118-1-pgonda@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH V6 2/5] crypto: ccp - Move SEV_INIT retry for corrupted data
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

Move the data corrupted retry of SEV_INIT into the
__sev_platform_init_locked() function. This is for upcoming INIT_EX
support as well as helping direct callers of
__sev_platform_init_locked() which currently do not support the
retry.

Signed-off-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Brijesh Singh <brijesh.singh@amd.com>
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
 drivers/crypto/ccp/sev-dev.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index f527e5f9ed1f..ef7e8b4c6e02 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -241,7 +241,7 @@ static int __sev_platform_init_locked(int *error)
 	struct psp_device *psp = psp_master;
 	struct sev_data_init data;
 	struct sev_device *sev;
-	int rc = 0;
+	int psp_ret, rc = 0;
 
 	if (!psp || !psp->sev_data)
 		return -ENODEV;
@@ -266,7 +266,21 @@ static int __sev_platform_init_locked(int *error)
 		data.tmr_len = SEV_ES_TMR_SIZE;
 	}
 
-	rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
+	rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, &psp_ret);
+	if (rc && psp_ret == SEV_RET_SECURE_DATA_INVALID) {
+		/*
+		 * Initialization command returned an integrity check failure
+		 * status code, meaning that firmware load and validation of SEV
+		 * related persistent data has failed. Retrying the
+		 * initialization function should succeed by replacing the state
+		 * with a reset state.
+		 */
+		dev_dbg(sev->dev, "SEV: retrying INIT command");
+		rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, &psp_ret);
+	}
+	if (error)
+		*error = psp_ret;
+
 	if (rc)
 		return rc;
 
@@ -1091,18 +1105,6 @@ void sev_pci_init(void)
 
 	/* Initialize the platform */
 	rc = sev_platform_init(&error);
-	if (rc && (error == SEV_RET_SECURE_DATA_INVALID)) {
-		/*
-		 * INIT command returned an integrity check failure
-		 * status code, meaning that firmware load and
-		 * validation of SEV related persistent data has
-		 * failed and persistent state has been erased.
-		 * Retrying INIT command here should succeed.
-		 */
-		dev_dbg(sev->dev, "SEV: retrying INIT command");
-		rc = sev_platform_init(&error);
-	}
-
 	if (rc) {
 		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
 			error, rc);
-- 
2.34.1.400.ga245620fadb-goog

