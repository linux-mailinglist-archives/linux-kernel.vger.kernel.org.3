Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E4E46B18E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhLGDmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbhLGDmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:42:05 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860C4C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 19:38:35 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y8so8497559plg.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 19:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZC9U2jKVDuGs2UUeY7QPzNlMq63gmQj4X8NafYCGHc=;
        b=d6HVa48Wqm+KA2IPDIC1ZMFLQ0i5eNSB1YLPZ87AUHCmC1+y/o6GL69VEgD7C3gsNU
         lDnOVtvATEYAIsBDFpfBPVc0TJvRI8IHcL6XjIuwiUuG4ghVXpdpp8dWRrU0v4l7geAF
         LFIa90vwzZhyxNsWaZZvD8rQzUJrMP4TKQLcIaqctndnE/E29FFT5VjnPVFpIshg6weG
         NwMHMlEyv38zOzQl/FijI9RGv98sEvR4Jh13WyruuBRXQZ9mQB9g5YaKXPoMf7v3bYQP
         +wS/YzukRdi6KjHhvbjRxldg6uciwbibb5ojTwyhXXlaABFjXu1FwZUKR4sSJoNI1nVX
         eRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=hZC9U2jKVDuGs2UUeY7QPzNlMq63gmQj4X8NafYCGHc=;
        b=Huv7wfK1W6EmJyg93VBenb3YbIHCuDD9CtJXWzjmm+kvR1mlWMCUlw6S0JIWX1aE9s
         mbQLbR3fMv0At5f5nA6A7rGVs7xbEjADZZN+E+DzzZoUKO4Izl1YjK+ujJBrohLiP7GO
         4nHF7ENGRovN58wytphZ8TiXkH1eVg2wSMOXBx5TZzoBl5otwYjzIXuAIa4FnJ88j2C3
         L7AcajFdD8bp2S7ihLiykwBYUWJ7im0eqSn/Og8sueHO/qYE17UgEC6BqnJjaAGu/FTo
         VkR5Y4fbobVFGpRrp5KHxciG/DCNOw2VLAuavoc0YeIOJs88pOsM00Yr36fV9cCApNsM
         DqBQ==
X-Gm-Message-State: AOAM533NQPznsFHzbcAWoD2mf6WJGe3NBpm8nI6spQxJVSQpCAGVlmBv
        zQAG5X4AThJYGNCOTo0g65M=
X-Google-Smtp-Source: ABdhPJzoVxIlMCOvxhNtZeJLmhVfUSWj4JcvwOUXLx6L25N67aQzjKxegOiAi3hbGkk7eDbB18hHCg==
X-Received: by 2002:a17:90a:ec15:: with SMTP id l21mr3452892pjy.48.1638848314619;
        Mon, 06 Dec 2021 19:38:34 -0800 (PST)
Received: from localhost.localdomain ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id n3sm11052865pgc.76.2021.12.06.19.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 19:38:33 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] fsi: scom: Remove retries in indirect scoms
Date:   Tue,  7 Dec 2021 14:08:11 +1030
Message-Id: <20211207033811.518981-3-joel@jms.id.au>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211207033811.518981-1-joel@jms.id.au>
References: <20211207033811.518981-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit f72ddbe1d7b7 ("fsi: scom: Remove retries") the retries were
removed from get and put scoms. That patch missed the retires in get and
put indirect scom.

For the same reason, remove them from the scom driver to allow the
caller to decide to retry.

This removes the following special case which would have caused the
retry code to return early:

 -       if ((ind_data & XSCOM_DATA_IND_COMPLETE) || (err != SCOM_PIB_BLOCKED))
 -               return 0;

I believe this case is handled.

Fixes: f72ddbe1d7b7 ("fsi: scom: Remove retries")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-scom.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index 3b427f7e9027..bcb756dc9866 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -145,7 +145,7 @@ static int put_indirect_scom_form0(struct scom_device *scom, uint64_t value,
 				   uint64_t addr, uint32_t *status)
 {
 	uint64_t ind_data, ind_addr;
-	int rc, retries, err = 0;
+	int rc, err;
 
 	if (value & ~XSCOM_DATA_IND_DATA)
 		return -EINVAL;
@@ -156,19 +156,14 @@ static int put_indirect_scom_form0(struct scom_device *scom, uint64_t value,
 	if (rc || (*status & SCOM_STATUS_ANY_ERR))
 		return rc;
 
-	for (retries = 0; retries < SCOM_MAX_IND_RETRIES; retries++) {
-		rc = __get_scom(scom, &ind_data, addr, status);
-		if (rc || (*status & SCOM_STATUS_ANY_ERR))
-			return rc;
+	rc = __get_scom(scom, &ind_data, addr, status);
+	if (rc || (*status & SCOM_STATUS_ANY_ERR))
+		return rc;
 
-		err = (ind_data & XSCOM_DATA_IND_ERR_MASK) >> XSCOM_DATA_IND_ERR_SHIFT;
-		*status = err << SCOM_STATUS_PIB_RESP_SHIFT;
-		if ((ind_data & XSCOM_DATA_IND_COMPLETE) || (err != SCOM_PIB_BLOCKED))
-			return 0;
+	err = (ind_data & XSCOM_DATA_IND_ERR_MASK) >> XSCOM_DATA_IND_ERR_SHIFT;
+	*status = err << SCOM_STATUS_PIB_RESP_SHIFT;
 
-		msleep(1);
-	}
-	return rc;
+	return 0;
 }
 
 static int put_indirect_scom_form1(struct scom_device *scom, uint64_t value,
@@ -188,7 +183,7 @@ static int get_indirect_scom_form0(struct scom_device *scom, uint64_t *value,
 				   uint64_t addr, uint32_t *status)
 {
 	uint64_t ind_data, ind_addr;
-	int rc, retries, err = 0;
+	int rc, err;
 
 	ind_addr = addr & XSCOM_ADDR_DIRECT_PART;
 	ind_data = (addr & XSCOM_ADDR_INDIRECT_PART) | XSCOM_DATA_IND_READ;
@@ -196,21 +191,15 @@ static int get_indirect_scom_form0(struct scom_device *scom, uint64_t *value,
 	if (rc || (*status & SCOM_STATUS_ANY_ERR))
 		return rc;
 
-	for (retries = 0; retries < SCOM_MAX_IND_RETRIES; retries++) {
-		rc = __get_scom(scom, &ind_data, addr, status);
-		if (rc || (*status & SCOM_STATUS_ANY_ERR))
-			return rc;
-
-		err = (ind_data & XSCOM_DATA_IND_ERR_MASK) >> XSCOM_DATA_IND_ERR_SHIFT;
-		*status = err << SCOM_STATUS_PIB_RESP_SHIFT;
-		*value = ind_data & XSCOM_DATA_IND_DATA;
+	rc = __get_scom(scom, &ind_data, addr, status);
+	if (rc || (*status & SCOM_STATUS_ANY_ERR))
+		return rc;
 
-		if ((ind_data & XSCOM_DATA_IND_COMPLETE) || (err != SCOM_PIB_BLOCKED))
-			return 0;
+	err = (ind_data & XSCOM_DATA_IND_ERR_MASK) >> XSCOM_DATA_IND_ERR_SHIFT;
+	*status = err << SCOM_STATUS_PIB_RESP_SHIFT;
+	*value = ind_data & XSCOM_DATA_IND_DATA;
 
-		msleep(1);
-	}
-	return rc;
+	return 0;
 }
 
 static int raw_put_scom(struct scom_device *scom, uint64_t value,
-- 
2.33.0

