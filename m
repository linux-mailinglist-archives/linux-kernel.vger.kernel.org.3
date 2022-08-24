Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECD659F492
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbiHXHxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbiHXHxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:53:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F82D83F31;
        Wed, 24 Aug 2022 00:53:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x14-20020a17090a8a8e00b001fb61a71d99so763221pjn.2;
        Wed, 24 Aug 2022 00:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=hlUCh9xjyN+gejZCmRefDyKkk5ypIdW9rzghdKaRkZw=;
        b=bwUNjjgObbmyLEH7lfNn4t9diFSgWGeiqt+V4mB92M8UpbtGv3YnpY4cATn44U0Z+C
         CWIQULITTbYdnlUsXVapXPCMu74yAmttCRQyR3q+fwWKj+/jKFX1DgP6rYMVV5VXsE1Z
         vDaxV8GQkRVOd5JPHVhA+TFtG6VyrKETaOAayyetnxo1lVdfA224fI9VcHuZ52cIJLBN
         MnzoZa1zTz1R8GOk6B6GmjDdCystOQHjJ5PJD2SMp406ewOowqKjnK7QAG0fu2JvrjD6
         41WnxBaKxJB7V3mMhGqgIPIsJ2h6WIRCZNMwKE5NGhclNeip9OkS+9ur7AeW45tlgVxa
         l2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=hlUCh9xjyN+gejZCmRefDyKkk5ypIdW9rzghdKaRkZw=;
        b=hCLcTzPSglyQqymbAN686H26gIjpNi0b7fqt4cz6vJk0Xcxu0YAhkUgJZlRdY1e4ft
         oWePKoopQG7E9W7+RknYTTdNPXfSVL6zMf8sfPASX2kfn57ZKaM+0oxe61lxuvXe816J
         eQr2Oczd6mM1+Yu/I4tlUEycyWpdccjRfoji03YmG7jBuTeHltZY4zRly02aYVVWfmBp
         Hc4xic7BcT7Xd27KXYB0NrUlOQtLTp7hR+qlznmrEvYUcbRfqaCWZugAVImzB8IUWzLc
         rbAeCUSaWumXMngA6IkhZ8n4M4NgObCpgOIVW7JmKdxRliCEpwwpVX5jFoQYy6gZZ9yi
         NKqg==
X-Gm-Message-State: ACgBeo3/nNki+3QnHv/MaHiSLsnkHZZZulbVOa0EbTlhvpmdFZ6OtlyA
        zdr52+EiVI78vC4RH1GofxxWhreXYp8=
X-Google-Smtp-Source: AA6agR5Egopn98B3/3bTy6SflR+cuCFFwvdd6+aCPaoLFGkcesPvIAX51ElaqeM4w8AISqX/5JNmmw==
X-Received: by 2002:a17:902:ea0d:b0:172:ce60:1d4f with SMTP id s13-20020a170902ea0d00b00172ce601d4fmr19656642plg.68.1661327590583;
        Wed, 24 Aug 2022 00:53:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i72-20020a62874b000000b0053715de411asm2268194pfe.138.2022.08.24.00.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 00:53:10 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     rafael@kernel.org
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ACPI: bus: Remove the unneeded result variable
Date:   Wed, 24 Aug 2022 07:53:06 +0000
Message-Id: <20220824075306.221472-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value from driver_register() directly instead of storing it
 in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/acpi/bus.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index c0d20d997891..661a63ea3248 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -973,16 +973,13 @@ EXPORT_SYMBOL_GPL(acpi_driver_match_device);
  */
 int acpi_bus_register_driver(struct acpi_driver *driver)
 {
-	int ret;
-
 	if (acpi_disabled)
 		return -ENODEV;
 	driver->drv.name = driver->name;
 	driver->drv.bus = &acpi_bus_type;
 	driver->drv.owner = driver->owner;
 
-	ret = driver_register(&driver->drv);
-	return ret;
+	return driver_register(&driver->drv);
 }
 
 EXPORT_SYMBOL(acpi_bus_register_driver);
-- 
2.25.1
