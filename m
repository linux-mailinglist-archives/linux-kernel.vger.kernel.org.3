Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271FE48BF68
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351346AbiALICF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbiALICD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:02:03 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16459C06173F;
        Wed, 12 Jan 2022 00:02:03 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id g21so2012743qtk.4;
        Wed, 12 Jan 2022 00:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bEhlEuVXpzGCtr/OwoPqgO9LNAoq78aFIJRUYBfriOE=;
        b=AH4uqnmv7cqZTsuuP153+QuDaAWzpO91OVVp8Uj3ocrysTdGhr5AiMSX0wFlGEdyBr
         R1/Os8nz3J6Nmz0yYvSZAZZlx3bq9C/DADiua2VbqzaTMA6OQTGPjAacsZafqJYNZQ4v
         EEe3XD1E2vPk5fV1A1d7sFjMr3HDI3kBtKa60xbhtPGCQRY73T4dISth2JZ02tb5E0ug
         2FJ4pfJejv6q79f+35fm9WCl+ljtZvRSVo6mEEyxFIbh7ZMUHFirq2jnjj8+RrFHvvtX
         /O5lN/Lt9MSSf5RYCPqI0tatxXUMl9HdfwmETA93zO6FgwV9Gko7uzaT8KFJ6l+5V6AX
         wbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bEhlEuVXpzGCtr/OwoPqgO9LNAoq78aFIJRUYBfriOE=;
        b=MCjTRptHG1eKdBoDHvyTNOLet+5GbJrgL2Zld8/GTFV715Zrfqzlo1+tFI3RI1cXUs
         /l5tXeSxqASwDPJVYQ2mGK/KKn2Va4OomJ7JNGp6d1OstzRrOLCkeODR6sXzFP3t79JC
         Fc3Z9XBF80m9/BhrZNdX9awsJjlDFh1m1wzYj6tKZ0I8oWU7xbLORtciVcnIcIKaEvZO
         lYwI++dI45TN1p/fSuOU+rs0OvKa5ChqYut25sPyfkzwS8pbQi5y0Rfupj8Grrt0yrdd
         G885D8140IEJvTwtIwP17Q7PO48nFWJXiynUbqqxJ6wLKdkR1xWUiy+a9KJbp4HANcJA
         yIQg==
X-Gm-Message-State: AOAM533JpVAuH3D7dXFNzt42mviZh8fp8f6uyL2Vw25/Dq4FMVWXCQPv
        +uSsl+PtRr4bZuZnVGqfO3w=
X-Google-Smtp-Source: ABdhPJzjtFUsnPYP2mP0TlaxO87szbqn72Gor+1BUcFx/sdePe4veL5YpctAlIDekh97oT934wwRSg==
X-Received: by 2002:a05:622a:1313:: with SMTP id v19mr1999704qtk.12.1641974522331;
        Wed, 12 Jan 2022 00:02:02 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h9sm8302224qkp.106.2022.01.12.00.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:02:02 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     rafael@kernel.org
Cc:     lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/acpi/apei: remove redundant rc variable
Date:   Wed, 12 Jan 2022 08:01:55 +0000
Message-Id: <20220112080155.666868-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from apei_exec_write_register() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/acpi/apei/apei-base.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index c7fdb12c3310..87145b6b89aa 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -125,12 +125,9 @@ EXPORT_SYMBOL_GPL(apei_exec_write_register);
 int apei_exec_write_register_value(struct apei_exec_context *ctx,
 				   struct acpi_whea_header *entry)
 {
-	int rc;
-
 	ctx->value = entry->value;
-	rc = apei_exec_write_register(ctx, entry);
+	return apei_exec_write_register(ctx, entry);
 
-	return rc;
 }
 EXPORT_SYMBOL_GPL(apei_exec_write_register_value);
 
-- 
2.25.1

