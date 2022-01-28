Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3676E49F176
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbiA1CzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345633AbiA1Cy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:54:56 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D057C061758
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:54:54 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id k13-20020a4a310d000000b002e6c0c05892so1136899ooa.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RTwg5KvKYjsTu6x08Cr32D16DOEKvzcD7sbsXNJ+uXY=;
        b=K8V/09ysiH0Fouxf5Tc2rZDy8N8WIUIQDQ8VPe4/cUpLFW9HQpJZ7Uj3Wbjyw5gPE2
         QIz6xbpoCcfcX5fKtHAkx6bcEapm3uxtJveoRK5Z8y0IruuB+u1j1MolkvZBVLXqrM2R
         dBYhHr9gPLSBM5qeG1W+NV5c/ZgJs+7DnCRFcn2V8ItQRlwUzkt1gke2xJLrd6DziEOl
         Emri/hIyeKIcunM9XtWYzUWazakwo5reUPYMPjEIQyKKywOt+HmHIXrihIQcyySpn5HL
         QKIk1B4WtMmJR7abmuQYk0IfKlRdr64gW4oDwMglZHwWzBQv/RmIfkiU2hRP+RM78wod
         A/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RTwg5KvKYjsTu6x08Cr32D16DOEKvzcD7sbsXNJ+uXY=;
        b=iXtuBLnaxinLnoXfExkTZ32Dt/Z5M19Y3gLTC0YlKzIGxPVVEz2IvHh2d3QAHWUC/j
         03rR+Kx1qH1AqMvrl9KI1hnQxZK1FIG9Oh9gHRW8tdrdtOc/GwqEkoWEwYWYMOBysGbI
         MXdKy5tpj7EK/+35zEXFwnsfhmMtoZjF6Fet2PFCmCTw97HRDNtZaExl1z2tfIluK80V
         f0YlfXACDwyoa2WxKsuPpcu8tzBulKXODdo1NsiLXnIsnScSQXxtRMqYj8BRwwJ6WjGn
         nD2eXtxSowkv19TD4tC4bbGWIrjrrkN98W7ewVWrWRbE1aqJ0lMjCK83wmlL9BpagDLg
         DSWA==
X-Gm-Message-State: AOAM532v7Em+S9vjZ2z1jopRjFP7VGK4Rs3YYfhe6UyD3DTCDOsJLT3A
        8OuYzi5bEJeUsNgpV6FyVOrRGQ==
X-Google-Smtp-Source: ABdhPJxuOarBgKU/g5GByZEi1kS52yQcDBSu+8HKDr3z0ak7bPikqPYdBhTJzL7n/TKmQdGTusvNXQ==
X-Received: by 2002:a4a:aa0e:: with SMTP id x14mr3373194oom.98.1643338493375;
        Thu, 27 Jan 2022 18:54:53 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id k6sm5677352oop.28.2022.01.27.18.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 18:54:52 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] soc: qcom: mdt_loader: Reorder parts of __qcom_mdt_load()
Date:   Thu, 27 Jan 2022 18:55:06 -0800
Message-Id: <20220128025513.97188-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128025513.97188-1-bjorn.andersson@linaro.org>
References: <20220128025513.97188-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the traversal of the program headers to the start of the function,
to make sure that min_ and max_addr are in scope as the call to
qcom_scm_pas_mem_setup() is moved in the next commit.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/mdt_loader.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 37e2e734bc5d..ee991784a738 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -213,6 +213,22 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = &phdrs[i];
+
+		if (!mdt_phdr_valid(phdr))
+			continue;
+
+		if (phdr->p_flags & QCOM_MDT_RELOCATABLE)
+			relocate = true;
+
+		if (phdr->p_paddr < min_addr)
+			min_addr = phdr->p_paddr;
+
+		if (phdr->p_paddr + phdr->p_memsz > max_addr)
+			max_addr = ALIGN(phdr->p_paddr + phdr->p_memsz, SZ_4K);
+	}
+
 	if (pas_init) {
 		metadata = qcom_mdt_read_metadata(fw, &metadata_len, fw_name, dev);
 		if (IS_ERR(metadata)) {
@@ -233,22 +249,6 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 		}
 	}
 
-	for (i = 0; i < ehdr->e_phnum; i++) {
-		phdr = &phdrs[i];
-
-		if (!mdt_phdr_valid(phdr))
-			continue;
-
-		if (phdr->p_flags & QCOM_MDT_RELOCATABLE)
-			relocate = true;
-
-		if (phdr->p_paddr < min_addr)
-			min_addr = phdr->p_paddr;
-
-		if (phdr->p_paddr + phdr->p_memsz > max_addr)
-			max_addr = ALIGN(phdr->p_paddr + phdr->p_memsz, SZ_4K);
-	}
-
 	if (relocate) {
 		if (pas_init) {
 			ret = qcom_scm_pas_mem_setup(pas_id, mem_phys,
-- 
2.33.1

