Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E274E18F7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 00:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244348AbiCSXQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 19:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbiCSXQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 19:16:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FF339B8F;
        Sat, 19 Mar 2022 16:14:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso6568915wmz.4;
        Sat, 19 Mar 2022 16:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nTQfK58lfNVp+J0LXWpfRWrYpUP0yrdZAkFT5Rd/9rE=;
        b=Fpog2uLZ+xedDEcYM2+jMa9eO9VcpgfQ4T3seCP4UP7rCUsGsJU2EQkQe+ChljVG3M
         30Lw3pdqCNfCQCuWRn4qQ+5x1qNbo1SUVB8oUmd9I1HRk7w1WHtOwSkrlBgQzCuFJVp3
         tlFAKn/RQ2kwCGVG51UKWivM/eLDnDs3vDH7UZQayj5nbwKfW48y7Eb11M11olixrJzL
         ObXHCuVji6eH4l+cB+rBNjWsNQ4KA+SHHJsQrLFjhdjAV1S6K63pxE63a7Sdy4rHbleO
         jbQ41sBLzmABwhULfNGUKP40kAeO9od7wS7XZil4fq5ygvbBLv486aBjRaIwEdYejeK+
         6Y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nTQfK58lfNVp+J0LXWpfRWrYpUP0yrdZAkFT5Rd/9rE=;
        b=hszGpVleitQNev2XLXJfVs8iW9B/032fhwlRl+anUcijK53sfb5mZDsSfplFM6EItW
         +gZLqYeZGq5j7CLNTLROrvHYwplQG+fajyaQjDp4sCCANMNfdkwdvM4UhOshOPTOAB5S
         jmpjuC4hMZG+mPEsEq0OxaAgM4pkYIEbl5wNl6ejdrn9DIHYMgE2yXdZI7X+K9H8u3Or
         T02zBQShZ6FbsgSxhp5EsrBC4P0oZ25mmPRBICw6oVId6WdYy6WPgF2b9m4VAhAkEs8O
         t8oCyWouPR1XcXK9QUq/RdHz/dMcsbNsTZULuXiwqjKlxix4WuUF4tJ5BznFoIt4qvt3
         OKcQ==
X-Gm-Message-State: AOAM533h0Zfe5ZDryn0Ewnzv+rH8EXztxJ1vpMejy7E2+nEL3n8hbvyq
        UaPB0ECpBK3jUVsU6In6fdU=
X-Google-Smtp-Source: ABdhPJxG/LUMlIE26DMoRWo47G0pHVBXXCSpct+Pg8H5rBhYwyTP1oG0aQdqwb3PMZdmXt8WsmRcRA==
X-Received: by 2002:a7b:ca42:0:b0:38c:6d09:1362 with SMTP id m2-20020a7bca42000000b0038c6d091362mr16794697wml.103.1647731686210;
        Sat, 19 Mar 2022 16:14:46 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c4f0c00b0038be825b774sm11120662wmq.45.2022.03.19.16.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 16:14:45 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: bnx2i: Fix spelling mistake "mis-match" -> "mismatch"
Date:   Sat, 19 Mar 2022 23:14:45 +0000
Message-Id: <20220319231445.21696-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There are a few spelling mistakes in some error messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/bnx2i/bnx2i_hwi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bnx2i/bnx2i_hwi.c b/drivers/scsi/bnx2i/bnx2i_hwi.c
index 5521469ce678..7fe7f53a41c0 100644
--- a/drivers/scsi/bnx2i/bnx2i_hwi.c
+++ b/drivers/scsi/bnx2i/bnx2i_hwi.c
@@ -2398,7 +2398,7 @@ static void bnx2i_process_conn_destroy_cmpl(struct bnx2i_hba *hba,
 	}
 
 	if (hba != ep->hba) {
-		printk(KERN_ALERT "conn destroy- error hba mis-match\n");
+		printk(KERN_ALERT "conn destroy- error hba mismatch\n");
 		return;
 	}
 
@@ -2432,7 +2432,7 @@ static void bnx2i_process_ofld_cmpl(struct bnx2i_hba *hba,
 	}
 
 	if (hba != ep->hba) {
-		printk(KERN_ALERT "ofld_cmpl: error hba mis-match\n");
+		printk(KERN_ALERT "ofld_cmpl: error hba mismatch\n");
 		return;
 	}
 
-- 
2.35.1

