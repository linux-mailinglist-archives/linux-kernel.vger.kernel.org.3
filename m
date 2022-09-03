Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D175AC198
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 00:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiICWYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 18:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiICWYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 18:24:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E8624E
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 15:24:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fc24so1317095ejc.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=9u5+ho/0K5aHmzAuhiNL0HZX6YntANsWhkWdEhasoT0=;
        b=LDzXe4qhBEfUT399qqj4B5iJfrWeSnxWQT1xJKKmWrizspBOA0tnpUamkGMw6sm/5A
         CKUNmfrfu6qTgk6Zj4Mi5dSebrveo02MLTdTpMThMvXDUgPS+iKNB+Dwj7MSpYEbaFTL
         9KBuTIYJ+Cy6mqsubnF0e8/A87LA7nvxG4iwEagfsbYRa5aSsWNGEl9jGH+Z+iG01lB2
         uAZuHALHhgz7MZdhm98qe7O4l03JSarN3DXl3cJQu2MyOCyL+YASDytIZ1d24FQIor5h
         fHK4vGglsnNdYJHIq1iQBKy1qdrIUxLjL3R4lF4aiBa8RMTxHnLyO660sixqWdQFJR2g
         wI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9u5+ho/0K5aHmzAuhiNL0HZX6YntANsWhkWdEhasoT0=;
        b=myKS0MQCrVLn2X0I2yC/YlkOivPBqmxYWNR/GkLT9YzaRMPOgtLd6gcqTxsZvRZncM
         9Wg9ucgmR3QH+BZAYS4xk1nf77Dv7v2WjfrqWHO0CLaqLbu6upaAJAGzqwYDXbIEWuD7
         1ii1N64scUj6A4Nk2i8KCB0OVzAP6Ce0GL5bhN1eoQ/jDEEUcy8dVf8QFPsO78kQZfC7
         xyPEtu6fjRpBwSgMiYdQAuYHLHnCwgmQbXr2fvxrxKsI1yymLeTfWbWuLnGvI44lH1ga
         lpwtnIb2Du5qjjJhpHEOEexzIlNjAAtzS5snEHAhhTbURvkmrfxmh/ZcotFv5/oL5vZu
         X52A==
X-Gm-Message-State: ACgBeo19WXQtDi5VQ/WCbfhHMr05H9m1bjfVnA0f7S/YckA7xn7CJdet
        5NDqTbAIBM1oLCxe40VbSlop2g==
X-Google-Smtp-Source: AA6agR5OERQf37zkCCwbB7/BOBcEoZib/hVqi1vz8sNYh3+R6a5MsH1BGvP/XftG48zEaf77MFWkwQ==
X-Received: by 2002:a17:907:d8d:b0:741:4d1a:5954 with SMTP id go13-20020a1709070d8d00b007414d1a5954mr24417067ejc.307.1662243868090;
        Sat, 03 Sep 2022 15:24:28 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be (ptr-4xh0y3sxu2v33e81l49.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:d4a:f526:3662:1129])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072abb95eaa4sm2917928eja.215.2022.09.03.15.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 15:24:27 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v2 3/3] iio: temperature: mlx90632 Change return value of sensor measurement channel
Date:   Sun,  4 Sep 2022 00:24:22 +0200
Message-Id: <20220903222422.3426156-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crt Mori <cmo@melexis.com>

The current EINVAL value is more applicable to embedded library, where
user can actually put the fixed value to the sensor. In case of the
driver if the value of the channel is invalid it is better in inform
userspace that Channel was out of range as that implies more to internal
driver error than invalid input. It also makes for easier debugging of
where the error comes from during the development.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 37edd324d6a1..d511d36942d3 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -435,7 +435,7 @@ static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
 		*channel_old = 1;
 		break;
 	default:
-		return -EINVAL;
+		return -ECHRNG;
 	}
 
 	return 0;
-- 
2.34.1

