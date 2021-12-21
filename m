Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B891E47C614
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbhLUSNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbhLUSNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:13:43 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AE3C061574;
        Tue, 21 Dec 2021 10:13:43 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id z4-20020a1c7e04000000b0032fb900951eso2302094wmc.4;
        Tue, 21 Dec 2021 10:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KkhoH6+A3+y/RK4E+6wgX4k5jzA+vrkcJUVCORNbtSo=;
        b=Mj6vdHiFsDzeaIBFBNnKFpUWdLETR1MbAKVKzY9oBtojNCZB1rjtlLBQHBhPR+M37Z
         gI0s/LF0f6qf5f9opvHxB4YLtMDaOc0alxsNEzg2dZkyy9B3cbBV5FAhdMK/M1FWpQ+e
         ta4f4TuEbQuFFCEw8LOBP5RraKTgxWxTlRsxleUcViwBPvTh6kCZyPX3QA30m7laeOsE
         lKgpPuM9KniuZn9TtTC0vWqb/vI1rZlQPCemSL9q1QE6mYfF0dsR6rBlGZ6p7RzpO+34
         xdfnYQ7vVXw/bRt1IWI8JFiowfKD6kDeGY0xEH/OgTDH+k0vDIPdNaIwr5Rralz1Qf8G
         xLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KkhoH6+A3+y/RK4E+6wgX4k5jzA+vrkcJUVCORNbtSo=;
        b=HlS10xWGYxStciawmWk0+m7XGDGwP3n9G3KE9SitiiM5vrU8YIpLenf88cQurQkyrG
         3CLyJIyhzoCL7ZcM+YAojtg9/G1VpXnwTgJ0nS8nIx9j2Kd0SobD/WCa9f0klCYYlJTx
         LBtdOTSAditgyPe2lcDWxiM7m+KPJbpmU1em8rCvZA1uywH1TGsJSEHAPnW1NPgeNYPz
         FnJM5N1Xx0vQTNNhyjb0Gm8HCDq2g/pQoyv2Y+DfluBSkTe1SaOSjFjCXtZulW3XxdhK
         QPtXF9wgLHV+En1Bt2Z9Ito5QFyHzsOMQKi4hmGUkDDKWO66WzITXD78WTlzrAbfOiMq
         NPVA==
X-Gm-Message-State: AOAM533bAG1gPbpG7lM74JoR4X+9ffMzF2QBml0DoDm0m0NsUzEftgjv
        Rye0BeKmi4h6WAcbAOWWW0aPa/YAhs9PwW+1gsQ/9Q==
X-Google-Smtp-Source: ABdhPJwoE6twfKQaGyivNwy6SByKI5P04Hv6OPekW5ZnN1vGmvjEL2idDW82hlnSVZe+AlL4DY/ZBw==
X-Received: by 2002:a1c:a5c5:: with SMTP id o188mr3837273wme.22.1640110421576;
        Tue, 21 Dec 2021 10:13:41 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j13sm3276069wmq.11.2021.12.21.10.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:13:41 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: omap_elm: remove redundant variable 'errors'
Date:   Tue, 21 Dec 2021 18:13:40 +0000
Message-Id: <20211221181340.524639-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'errors' is being used to sum the number of errors
but it is never used afterwards. This can be considered a
redundant set of operations and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mtd/nand/raw/omap_elm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
index 8bab753211e9..0b6aeb269c33 100644
--- a/drivers/mtd/nand/raw/omap_elm.c
+++ b/drivers/mtd/nand/raw/omap_elm.c
@@ -282,7 +282,7 @@ static void elm_start_processing(struct elm_info *info,
 static void elm_error_correction(struct elm_info *info,
 		struct elm_errorvec *err_vec)
 {
-	int i, j, errors = 0;
+	int i, j;
 	int offset;
 	u32 reg_val;
 
@@ -312,8 +312,6 @@ static void elm_error_correction(struct elm_info *info,
 					/* Update error location register */
 					offset += 4;
 				}
-
-				errors += err_vec[i].error_count;
 			} else {
 				err_vec[i].error_uncorrectable = true;
 			}
-- 
2.33.1

