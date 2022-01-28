Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9BC49FF99
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244528AbiA1Rdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiA1Rdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:33:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB467C061714;
        Fri, 28 Jan 2022 09:33:41 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u11so6629058plh.13;
        Fri, 28 Jan 2022 09:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ao8NjMa37zJEFe2r9MsBKR2VMUSdhu4BCAQG2c75rDQ=;
        b=F6ZSDPxhKHfBEjDL4YcsRKdgGJ8VWs5qWxZZlr/CrIbG6Q4s+vaPMBDgsiuk31DKjQ
         T5RPT8FyK9U1I8v1eweLb5i0ve2TUIHFzy3OJXsNWbmgfa66+4up86RKUYdmQdF92Q7Z
         ryBX7ILD0piR3CD9l240OEgor9a2sGyr9cI9o1n5Kmwsad46VlnuzbFdByp9oPEbv1fP
         H91ZNNB3omjusyznVUkInHDspdUvWwLP6y2AE67hAqOHQrB+YDMYc2a/mulvn5bWH/L3
         mQgrFRUyGQB2MK7uNAXphwqTXp7Hj7zDiC5o9PUyM+2HPboCswKviWa5YumIzQo300Wq
         qaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ao8NjMa37zJEFe2r9MsBKR2VMUSdhu4BCAQG2c75rDQ=;
        b=Lzen3gpKVYfIbimygRTfKQi9GVQU7Ns8SD82v0niuYAOvTC8RAec0gCl8MiPYWt3be
         1IcdsImE7HXKNbKm2tfc9dQxSNfCoYG5fA8AwED5mws6x27PeoBOOAhxcTsWyvKEW4ed
         R985K6OKR5bEVQnq43dwDBK/b7nJ83OOUzcZZLboq3hXLlmLiSHUXTIzNmXjTE7Dj6kC
         OSMbM7MSdhqHKLGHwExCboBtUm8tOGG9SVm3QW/d0/cgJSA3+/yU9aiSxhmekw/eK22H
         gzufGqXmgHAJG3pSXIBr/VczH5o6J+BXPb+GsPgglev6+32rIjLvjyYKFnvzU1rNfrp5
         Pi+A==
X-Gm-Message-State: AOAM5324lFCm8CtfpLQFfriXbrX4UGeZYmA+Nh88E4a5TXhppuDf//Tg
        5E+pN40C3x8GQq8aQZw/3+3afNnqy6cHOElaCHE=
X-Google-Smtp-Source: ABdhPJwINMZvGAQ+RGr24gO4n8v3Uq1+6XfGb2pR4cBeZU2V4y9GJxPszxjME/Nn7qtNc4dK1pDO0w==
X-Received: by 2002:a17:903:2305:: with SMTP id d5mr9237955plh.14.1643391221529;
        Fri, 28 Jan 2022 09:33:41 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id l14sm10440643pjf.1.2022.01.28.09.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 09:33:40 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] power: supply: ab8500: Fix memory leak in ab8500_chargalg_sysfs_init
Date:   Fri, 28 Jan 2022 17:33:35 +0000
Message-Id: <20220128173336.643-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_init_and_add() takes reference even when it fails.
According to the doc of kobject_init_and_add()

   If this function returns an error, kobject_put() must be called to
   properly clean up the memory associated with the object.

Fix this issue by adding kobject_put().

Fixes: c5b64a990e7f ("power: supply: ab8500: Rename charging algorithm symbols")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/power/supply/ab8500_chargalg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index c4a2fe07126c..658139797509 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1907,8 +1907,10 @@ static int ab8500_chargalg_sysfs_init(struct ab8500_chargalg *di)
 	ret = kobject_init_and_add(&di->chargalg_kobject,
 		&ab8500_chargalg_ktype,
 		NULL, "ab8500_chargalg");
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(di->dev, "failed to create sysfs entry\n");
+		kobject_put(&di->chargalg_kobject);
+	}
 
 	return ret;
 }
-- 
2.17.1

