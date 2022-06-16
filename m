Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590F554DBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359532AbiFPHfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359508AbiFPHex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9421E0AF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655364891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Er7l8z53PbdFOnW6kEGMkIm/CzA/yPUfe0hwW1p2q3c=;
        b=LQQwijHchRC+rOV/N5HXYxewU8XZmKsyyK1z+i3dpz+xrb3ucK2pWTANT14BPzPWtRpDU9
        6Shw6pJKeNSMVZrRr4ak7IZ/Bsz9ahBbyHCSLwC+Hb6uwOShqLKpykM22SSfl3QMzhjABv
        UgotErVp0SUCPBCL1cS74UXkM3nkE90=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-9VNiRsB0Pa-2rYJoaOwutA-1; Thu, 16 Jun 2022 03:34:50 -0400
X-MC-Unique: 9VNiRsB0Pa-2rYJoaOwutA-1
Received: by mail-wm1-f71.google.com with SMTP id o2-20020a05600c510200b0039747b0216fso742079wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Er7l8z53PbdFOnW6kEGMkIm/CzA/yPUfe0hwW1p2q3c=;
        b=hdy//WTsG70/lBVBnCRPfMWIJEOWEuhsxSolfWxt6+6xOM/xWdd9FJPyEh17cx7xbD
         fGymwLXm+1N4tvM6HlP9U7euMGD2lip1QeGydOpmwImTmwptrbXGy1EnRfaJTv2Rwtb3
         T+kG2iSdmoYFipjb2x6QlgPe25Z6jIYJKiZb65TZWJHXp/famicxDVH0zG+BsbAua7it
         yYei/KlbSDRh4GbWkX8MFHD/HNxzMQVcDr+GY/k+f87PTNH/Ywks6N4yAhm9g6W0GWzT
         Wvgpjf7i1MsgrZrP3GS8n3yyNLpU+nZKs/mfC/MBNFSwAzsiLkhN9F+tlemiGLve3M2n
         OEJQ==
X-Gm-Message-State: AOAM533WYR7wKb6X2auEILNETcJF6/HjVvaSynPaxzr9N5kkbxKl7X1M
        B3I8z9hHwzLEZHzTR1LVbvq6Q02qRwMehhbvIsXY3pywY/gh71P30JAOQZahYgWWHGfrqZEPc9o
        MsLfRkc1PDG9Za5b9R+AHShVmV2Lr5g0TxwrQsYwv1sqXIIJnkxSlampwBfWfXDurhQZXTcvUmN
        8=
X-Received: by 2002:a05:600c:3b88:b0:39c:55b2:3d1 with SMTP id n8-20020a05600c3b8800b0039c55b203d1mr14415209wms.64.1655364888450;
        Thu, 16 Jun 2022 00:34:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxm/IZLlmQO5oDr4w/vGETAhtH9ZjNftsPO8fl+y/Dr4yCmvICItVVSoQBPx4+3ST8BJAJHWg==
X-Received: by 2002:a05:600c:3b88:b0:39c:55b2:3d1 with SMTP id n8-20020a05600c3b8800b0039c55b203d1mr14415184wms.64.1655364888155;
        Thu, 16 Jun 2022 00:34:48 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d5004000000b0020fdc90aeabsm1020123wrt.82.2022.06.16.00.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 00:34:47 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/3] regmap: Make regmap_noinc_read() return -ENOTSUPP if map->read isn't set
Date:   Thu, 16 Jun 2022 09:34:34 +0200
Message-Id: <20220616073435.1988219-3-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616073435.1988219-1-javierm@redhat.com>
References: <20220616073435.1988219-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before adding support to define bulk read/write callbacks in regmap_config
by the commit d77e74561368 ("regmap: Add bulk read/write callbacks into
regmap_config"), the regmap_noinc_read() function returned an errno early
a map->bus->read callback wasn't set.

But that commit dropped the check and now a call to _regmap_raw_read() is
attempted even when bulk read operations are not supported. That function
checks for map->read anyways but there's no point to continue if the read
can't succeed.

Also is a fragile assumption to make so is better to make it fail earlier.

Fixes: d77e74561368 ("regmap: Add bulk read/write callbacks into regmap_config")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/base/regmap/regmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index e5bb70374ffc..f37f80a52115 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2904,6 +2904,9 @@ int regmap_noinc_read(struct regmap *map, unsigned int reg,
 	size_t read_len;
 	int ret;
 
+	if (!map->read)
+		return -ENOTSUPP;
+
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
 	if (!IS_ALIGNED(reg, map->reg_stride))
-- 
2.36.1

