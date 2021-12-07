Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A16846B18D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhLGDmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbhLGDmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:42:00 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14450C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 19:38:31 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g19so12115138pfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 19:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dEomjkO6usZNSsctJD1p6Zcy57WfWwQNo29c7d2e1PI=;
        b=lrh+UI119wmZYIiv5/pwqnzAFqRWwrQ3oBh2Ht+A9FuMG5oJFf2BQrY02nI7hL++CH
         C0sZTPx/CO25rXbR2n6rwEKWHot4q2/tKnkY6xYVr+i6ejcgRPSjeHRg4bC3kU3m9ak8
         +wW82rZD607s1QjmBk83XxOJQ67JDkSK/4p7zyYkAhddbCWQvnQA9luZgBUPxS0w9Thu
         SkV3QQcFtF+b4V87z+NeHKbkMhLpOGlNUqjAgPtNV20yJ+n5eqKf/gymM/isZeUbxLRs
         4QFzgtu3aoEQaBtTnnG2TYQS8bfJb6yFp7ot9iVZsEEjJ2r5I/0Fw4UEYuuA6WhyBmIG
         T+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dEomjkO6usZNSsctJD1p6Zcy57WfWwQNo29c7d2e1PI=;
        b=Rjv0thFxowxPZA/2t81FBCwIuBY29JzrHfLlJUwF0hTjvuoW3aEZcBIddJnn5+Jas5
         P5ASmxzlh3Gw8PRek8IM70zL0cZXLRomAws8DE2fky440aK1zbfBeEeKsOuOv4vRegL7
         cdV6lElCF5Pb7NTfMKCVpcWHRQ913FOZAU8dZTnkBuHtw7pfmaedkzqLHEfBuC6LIp5A
         b4XGDmGUmQWHLcGVyWlU5dXOADODLUt73t25UOy5fDwFVvB8h09IxZraCvjvuc2cNo9q
         3tPhwgvkjIGZt+Vrt4BF9tGqZ8C7vbhOT1wry2NIMKhvfp+fATZihgQXwGVbTJ+OWg0L
         0TKw==
X-Gm-Message-State: AOAM533NebTVOcIEErL/TZNDIQj/VYwTWJQi6P7N3rDprnashSk1TRTX
        hQQS9mUAc/CfkMmlXBXKz+c=
X-Google-Smtp-Source: ABdhPJwZrWPAvA/NEeGakV91EOY/LMncWnJbcGrVlvuBvQ8lLHzjZXgFzpglWPpfHCy75GKOtyNKig==
X-Received: by 2002:a63:6687:: with SMTP id a129mr21428300pgc.477.1638848310524;
        Mon, 06 Dec 2021 19:38:30 -0800 (PST)
Received: from localhost.localdomain ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id n3sm11052865pgc.76.2021.12.06.19.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 19:38:29 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] fsi: scom: Fix error handling
Date:   Tue,  7 Dec 2021 14:08:10 +1030
Message-Id: <20211207033811.518981-2-joel@jms.id.au>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211207033811.518981-1-joel@jms.id.au>
References: <20211207033811.518981-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCOM error handling is made complex by trying to pass around two bits of
information: the function return code, and a status parameter that
represents the CFAM error status register.

The commit f72ddbe1d7b7 ("fsi: scom: Remove retries") removed the
"hidden" retries in the SCOM driver, in preference of allowing the
calling code (userspace or driver) to decide how to handle a failed
SCOM. However it introduced a bug by attempting to be smart about the
return codes that were "errors" and which were ok to fall through to the
status register parsing.

We get the following errors:

 - EINVAL or ENXIO, for indirect scoms where the value is invalid
 - EINVAL, where the size or address is incorrect
 - EIO or ETIMEOUT, where FSI write failed (aspeed master)
 - EAGAIN, where the master detected a crc error (GPIO master only)
 - EBUSY, where the bus is disabled (GPIO master in external mode)

In all of these cases we should fail the SCOM read/write and return the
error.

Thanks to Dan Carpenter for the detailed bug report.

Fixes: f72ddbe1d7b7 ("fsi: scom: Remove retries")
Link: https://lists.ozlabs.org/pipermail/linux-fsi/2021-November/000235.html
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-scom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index da1486bb6a14..3b427f7e9027 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -289,7 +289,7 @@ static int put_scom(struct scom_device *scom, uint64_t value,
 	int rc;
 
 	rc = raw_put_scom(scom, value, addr, &status);
-	if (rc == -ENODEV)
+	if (rc)
 		return rc;
 
 	rc = handle_fsi2pib_status(scom, status);
@@ -308,7 +308,7 @@ static int get_scom(struct scom_device *scom, uint64_t *value,
 	int rc;
 
 	rc = raw_get_scom(scom, value, addr, &status);
-	if (rc == -ENODEV)
+	if (rc)
 		return rc;
 
 	rc = handle_fsi2pib_status(scom, status);
-- 
2.33.0

