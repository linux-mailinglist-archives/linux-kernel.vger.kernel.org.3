Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C806F5A5E24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiH3Ibu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiH3Ibp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:31:45 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF25A54C97;
        Tue, 30 Aug 2022 01:31:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n8-20020a17090a73c800b001fd832b54f6so8488856pjk.0;
        Tue, 30 Aug 2022 01:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=6wSm7CzeHPLuNMxq4EplKaDfOIoJeWhbi58gJYRctKU=;
        b=dsiCilVvOxsiRBtAhowtVXumcDgdpHbJpbaY45ERv05CGgaM8Zw1x2908VeRZAxKbo
         ZWdatgbTVXH6GeqzBmvDdHrt6NLa4iK4TKisLAQqhtfwxMIxK2J49JF68Dx4IX0qD1PB
         ksPx6+l+RxA4jT/dkK+HnzV7RGa9/hZMifzXcuIUdQ685f1W8TBog99w+Mo6gQ8MPY1Q
         MY0uhQlO8x45jYcz1xhyYrzh/H0MKyHlyIqd2kb13TYIspl+NTB3wzkDFAdYCcWJRuOY
         1APutMI4eib9c1oyZ8xL3MFYNsV+uwT6ghvxdAOuKSLwEqZUktxMzz9+c9EWJdQ7Sxa0
         LzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=6wSm7CzeHPLuNMxq4EplKaDfOIoJeWhbi58gJYRctKU=;
        b=JT9b7/yDKUhLGNQWM3phNjwBVz2phMIXvv2qMTQMyw87FE6MkbMfQfwVaIp5ZKhpU5
         cB7JFYCZaeB0NCUo/MEon82X1TkU1cRoxn5hBo8DbPh8S65GubMkca97aAuawNAtsAwY
         /HYtsowZ53fJJ6Bv+y5l+JAjboEA6MJX+pQgSvjcRlunGmxVw+0CukMqa6aBc7eHVOAm
         5cOU0o6CMcvguRKsH35k71NV4cw59C8R41ZKUMAT5R76Z51qEEryywdxNdqpN3Ze/UrY
         RwpX8tL6mJh6QMSmjOGiD5xp6fLiNtZYlFNUpOCmsfor9S7eEphi/YFhKiSHv1tVN4oZ
         snCg==
X-Gm-Message-State: ACgBeo0l6muXVWjBa9PgAdejnpzSqerZGWd79xKaQxspj3CGTpD2QpCj
        AOs+ZimTbEqpJMAkvTJbc8tAQeC5N1k=
X-Google-Smtp-Source: AA6agR54KJ1clIMF917ybQExo4l070oIELL3x/tQEsifxGrmwFq/eXLuuG8djq3gc3DK6cXnDlfHJg==
X-Received: by 2002:a17:902:e741:b0:175:2ffe:9280 with SMTP id p1-20020a170902e74100b001752ffe9280mr521225plf.153.1661848304204;
        Tue, 30 Aug 2022 01:31:44 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b00172f1d0825esm1352100plx.113.2022.08.30.01.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 01:31:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     james.smart@broadcom.com
Cc:     dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] scsi: lpfc: Remove the unneeded result variable 'n'
Date:   Tue, 30 Aug 2022 08:31:36 +0000
Message-Id: <20220830083136.276473-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value scnprintf() directly instead of storing it in another
redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/scsi/lpfc/lpfc_ct.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 13dfe285493d..f1e533794fad 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -1797,15 +1797,12 @@ int
 lpfc_vport_symbolic_port_name(struct lpfc_vport *vport, char *symbol,
 	size_t size)
 {
-	int n;
-
 	/*
 	 * Use the lpfc board number as the Symbolic Port
 	 * Name object.  NPIV is not in play so this integer
 	 * value is sufficient and unique per FC-ID.
 	 */
-	n = scnprintf(symbol, size, "%d", vport->phba->brd_no);
-	return n;
+	return scnprintf(symbol, size, "%d", vport->phba->brd_no);
 }
 
 
-- 
2.25.1
