Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF7E54DBDF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359496AbiFPHfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359503AbiFPHex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38D5FDF3B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655364890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92fbAsWhdXO9hCI4vEDW2G0z+l/JIsnCOl1NXT2FpFA=;
        b=Df0r+4gd+zmm5WzbEatxAW1MzUB/rqhsHShdVwZRLnSV3dmovK9ziHmpIbr8m4/4ca7XfB
        PgumM6RVR7pRrFV633W3ywOhHhgkHJcWSkwHhIHZ/5W61sRCBPU9Z33ut/3DGg83cc19/k
        68RFSJj/qz4AieoIiKxp690tdGaqls8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-kgbKPTYtMzqASQGXqdHEHQ-1; Thu, 16 Jun 2022 03:34:48 -0400
X-MC-Unique: kgbKPTYtMzqASQGXqdHEHQ-1
Received: by mail-wm1-f69.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so288769wmr.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=92fbAsWhdXO9hCI4vEDW2G0z+l/JIsnCOl1NXT2FpFA=;
        b=yE3muP1LhxYC9OaMtCYVAwIQSf8UqsjXwwd4T9W3KIVXsqsQocrZWqzWQD34QCx2i7
         Wd+2ng7joXK9K7ww4RiJp/s55aPTWz7+WB+AEUniMbsESczsYoO2CsW0b6cQyV1rVOW2
         0GRamrgve6U+p/H5+39PqVkT1rtKNZFW74El4XIvp5RyrxkKMVyDAicD8UBEcmlarX6y
         HKOYpEn988V8K4g5JTiQFxcQXd/RHnPn9CoD3imNOt71n+gQeDA9Hp2aEtYJ/YFb8RcA
         0f2kA8+90UgAYsMnKorAZxMHZ7gBTYWHmrwjlvzQIrcoiYbP8CytHAxsxAvoZVACTlac
         ZqJQ==
X-Gm-Message-State: AOAM530YPjBVbQ1kpc3fIfDregiEHvHW9amtmRL9UABXL9ZkkYPoeCkC
        LGU7FMPzGRbDSVaBA9jjOOb9V6QTUuE+ulQPOCUN2ZLOeAxv33D/BZ5dTqMz/SQWy7z+KhHP0on
        NdC2lPghgUg+TH5seX1NdtsiYMV3bJfkHG0lBr8ZspeXZsXu4NppVeRLgcenlGhyXSLdHB2i4la
        4=
X-Received: by 2002:a05:600c:1da4:b0:39c:8ca8:5f1d with SMTP id p36-20020a05600c1da400b0039c8ca85f1dmr13926631wms.138.1655364887130;
        Thu, 16 Jun 2022 00:34:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxU3BGb02V/p5mAZ8mmpP1LYb/P00pxF9PtUD9HSDTKZLqsK6WDZf0USwcp4fqb6zkmyQdftg==
X-Received: by 2002:a05:600c:1da4:b0:39c:8ca8:5f1d with SMTP id p36-20020a05600c1da400b0039c8ca85f1dmr13926604wms.138.1655364886837;
        Thu, 16 Jun 2022 00:34:46 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d5004000000b0020fdc90aeabsm1020123wrt.82.2022.06.16.00.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 00:34:46 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/3] regmap: Re-introduce bulk read support check in regmap_bulk_read()
Date:   Thu, 16 Jun 2022 09:34:33 +0200
Message-Id: <20220616073435.1988219-2-javierm@redhat.com>
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

Support for drivers to define bulk read/write callbacks in regmap_config
was introduced by the commit d77e74561368 ("regmap: Add bulk read/write
callbacks into regmap_config"), but this commit wrongly dropped a check
in regmap_bulk_read() to determine whether bulk reads can be done or not.

Before that commit, it was checked if map->bus was set. Now has to check
if a map->read callback has been set.

Fixes: d77e74561368 ("regmap: Add bulk read/write callbacks into regmap_config")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 2221d9863831..e5bb70374ffc 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -3017,7 +3017,7 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 	if (val_count == 0)
 		return -EINVAL;
 
-	if (map->format.parse_inplace && (vol || map->cache_type == REGCACHE_NONE)) {
+	if (map->read && map->format.parse_inplace && (vol || map->cache_type == REGCACHE_NONE)) {
 		ret = regmap_raw_read(map, reg, val, val_bytes * val_count);
 		if (ret != 0)
 			return ret;
-- 
2.36.1

