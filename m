Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E287F531366
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbiEWOdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbiEWOdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:33:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB56D33A04
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:33:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so13895803pjq.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o5VXWNPSZA3rC+8/IoRn3B39pVcambgp6FwS9mwBIhE=;
        b=VGALFZc0nYQQoedtnupkwyTglseKhWTY2On5GWZjTBnVdfqeZRtT6V0EiUpJ4SUwsd
         r9zRnVuzUcyDeEjRa1u++eT4aTIC52q/m+Q/fVKQ3QanGuFNW7G8l2O3IGcZdTJf9Ptj
         vNJdha+QWBjmlb2h2upXjluOrjOKlA/5fjH+VuGtiQR8mnzvfFkot6ua1qompAvmKTP2
         rsM61K6/prGiCKWrP1ZOyPEXy7YHuCvAioTCZowwRpVdsQ9hyzAaHmZZbUFHIKue0Jum
         rInuwPcIRCPqJKhB2ASaMyZ7xevms3Vtn1jH86zuT5wA4Ado2Qk5+j7P/uwRR4EidLRf
         k4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o5VXWNPSZA3rC+8/IoRn3B39pVcambgp6FwS9mwBIhE=;
        b=74fQyzR5ioyieGcgwLRY4t9QsJugFBABFeNh/Xp92372Tyhp161RzPfAy5mYfTaBzc
         G79SpFqATRmKTy9YUcmaY4A/ckh0HEZ5xb+xg5i2ttAsCclPeUvHpFBRxCm0+juJeO+P
         pQi7JB+GQpkyVvSPnBgG4/6IhQEd1qJ5zBcwEjtgE7ieoBl573BbeH5yBK+gbiCDtih8
         IVKWM5dCYvS9zZabVZqAHt56TZDzhZy2f/r0ZU4b+1DuQuZUVmJBbuW7yx8n/P9E0u/t
         8l/LBpHZ8sjEO+WVA9ortsnPxnYllx9kDyGmUMiZ2c7XIqXvwf8jsdtzLFVJnBbwRqA2
         YU0w==
X-Gm-Message-State: AOAM533LVu817nDj13zsEHO7/lQifLy3X2EyPcuKMjWwRsql33vbXZzw
        +Fg2mNyhsdaepqjfKKiekNc=
X-Google-Smtp-Source: ABdhPJy22fsu+i3GK5N2DZ0aRKa6iZuZr30HkITvLYPMJ/oH+EPw7wfRAJ0866/BtpxvxVyX7CHwLg==
X-Received: by 2002:a17:90a:6c66:b0:1df:9399:9189 with SMTP id x93-20020a17090a6c6600b001df93999189mr26896192pjj.179.1653316387168;
        Mon, 23 May 2022 07:33:07 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id n18-20020a6563d2000000b003f655cf45c0sm4835848pgv.63.2022.05.23.07.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:33:06 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] mtd: maps: Fix refcount leak in ap_flash_init
Date:   Mon, 23 May 2022 18:32:55 +0400
Message-Id: <20220523143255.4376-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_matching_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: b0afd44bc192 ("mtd: physmap_of: add a hook for Versatile write protection")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/mtd/maps/physmap-versatile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/maps/physmap-versatile.c b/drivers/mtd/maps/physmap-versatile.c
index ad7cd9cfaee0..6ba6a1dd127c 100644
--- a/drivers/mtd/maps/physmap-versatile.c
+++ b/drivers/mtd/maps/physmap-versatile.c
@@ -93,6 +93,7 @@ static int ap_flash_init(struct platform_device *pdev)
 		return -ENODEV;
 	}
 	ebi_base = of_iomap(ebi, 0);
+	of_node_put(ebi);
 	if (!ebi_base)
 		return -ENODEV;
 
-- 
2.25.1

