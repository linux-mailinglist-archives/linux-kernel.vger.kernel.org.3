Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA02C54DBDE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359525AbiFPHfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359518AbiFPHfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70D402DEA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655364900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kH2mMYjAnxjjN4IG5IjgXPzjzT8Xkuw9HJZPSbPbxmo=;
        b=DLpdB9JZ5ztnNB9UywWl1I9cM0yWzDFb9LO2M7AOzpjm3OBbSGakmB/B8ojGksI2BHuhC0
        klg1se29ULLpZrxpyolHqSGjHZv4oTK/d//LrM7OaWGfjspvIISshUOnwWPvHtJ0PKvmTp
        yS4YAYhfgWWyCuGVSao11ky+ipZKYFo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-aytaNk5VONy-XlwLrsCjog-1; Thu, 16 Jun 2022 03:34:51 -0400
X-MC-Unique: aytaNk5VONy-XlwLrsCjog-1
Received: by mail-wm1-f72.google.com with SMTP id o2-20020a05600c510200b0039747b0216fso742103wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kH2mMYjAnxjjN4IG5IjgXPzjzT8Xkuw9HJZPSbPbxmo=;
        b=yRQxMJI5lhnx1vLtXuIBSGjSnwhqfa++0BQxkHRKFwIx64WvDMpG1CB+oJjaS0FhiM
         0pTVJOuZVLZbVKQg50Br0/8d5aMFxNwDzUJo9lh/GMIWyp6zF1kv8uXV+JG7K891h69o
         mNUvdYuU0TQQS4OiON4s2JnDPO2ey7v7dQm/7ULRI+9sg5THVhNuXPnJ0vO0YUiBsyJq
         EUtt+i3gpcupTZezoD+/OYB9IAekwL1qgNdKNNcF88u6ffaUf/mRgnAluGhpXGWVHOVX
         3HjojL2kmdfu5AvjyojoP4ciFMX+WfpmmZrOry9RRWpVEixeX+SGLDm/LqkCFSGfLfIc
         vhgg==
X-Gm-Message-State: AJIora8Vq1X4rMFg2Z/PdRokc5KJhY43R4ZuTxSkGAPcyO8IukiRrG82
        OhOWH66WCmp0pZsSbKiLZjvvmNXbmW3cJ38en86WVR+h23oh/P+VOnMEvDKuwQQZopNuETgQpUd
        wcPnEjiFg4jtjKnSZPsmrbRs6aNo4FWnLyCL+ZUi4z5HRfx2Z9gcy71RjEr9KNsOXEMBFmRRP0r
        8=
X-Received: by 2002:a05:6000:2c6:b0:216:7691:5395 with SMTP id o6-20020a05600002c600b0021676915395mr3342284wry.478.1655364889713;
        Thu, 16 Jun 2022 00:34:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1thOdCAHz4LQEGXeHBOF2OCNJMn/Sb1jqRyj9lSYMHq4G9sGQ09XPdB5gtYo0IyQT4uAIGzug==
X-Received: by 2002:a05:6000:2c6:b0:216:7691:5395 with SMTP id o6-20020a05600002c600b0021676915395mr3342257wry.478.1655364889405;
        Thu, 16 Jun 2022 00:34:49 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d5004000000b0020fdc90aeabsm1020123wrt.82.2022.06.16.00.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 00:34:49 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 3/3] regmap: Wire up regmap_config provided bulk write in missed functions
Date:   Thu, 16 Jun 2022 09:34:35 +0200
Message-Id: <20220616073435.1988219-4-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616073435.1988219-1-javierm@redhat.com>
References: <20220616073435.1988219-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some functions that were missed by commit d77e74561368 ("regmap:
Add bulk read/write callbacks into regmap_config") when support to define
bulk read/write callbacks in regmap_config was introduced.

The regmap_bulk_write() and regmap_noinc_write() functions weren't changed
to use the added map->write instead of the map->bus->write handler.

Also, the regmap_can_raw_write() was not modified to take map->write into
account. So will only return true if a bus with a .write callback is set.

Fixes: d77e74561368 ("regmap: Add bulk read/write callbacks into regmap_config")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/base/regmap/regmap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index f37f80a52115..c3517ccc3159 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1880,8 +1880,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
  */
 bool regmap_can_raw_write(struct regmap *map)
 {
-	return map->bus && map->bus->write && map->format.format_val &&
-		map->format.format_reg;
+	return map->write && map->format.format_val && map->format.format_reg;
 }
 EXPORT_SYMBOL_GPL(regmap_can_raw_write);
 
@@ -2155,10 +2154,9 @@ int regmap_noinc_write(struct regmap *map, unsigned int reg,
 	size_t write_len;
 	int ret;
 
-	if (!map->bus)
-		return -EINVAL;
-	if (!map->bus->write)
+	if (!map->write)
 		return -ENOTSUPP;
+
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
 	if (!IS_ALIGNED(reg, map->reg_stride))
@@ -2278,7 +2276,7 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 	 * Some devices don't support bulk write, for them we have a series of
 	 * single write operations.
 	 */
-	if (!map->bus || !map->format.parse_inplace) {
+	if (!map->write || !map->format.parse_inplace) {
 		map->lock(map->lock_arg);
 		for (i = 0; i < val_count; i++) {
 			unsigned int ival;
-- 
2.36.1

