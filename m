Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9B15AE3CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbiIFJFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbiIFJFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:05:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E879419297
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:05:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z8so14244685edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 02:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BVTkmsVRm3h6Y3wK0B0yjGZ1PS4IZYgOdJPvequ14+g=;
        b=ggbnvJ7NocZ9WUbEwYN3BGobtwR4OaBbGhm/0zeamieq8vE+T/ilwVJZvX62SzwMS3
         3kVd0sysB9f87kGsN8yOj5qv6IolAUh+Ii0uhf/64OIu5N4AuX5Fjr068REpMDoq3nC6
         6YDL/pESHk7MX4J1HqhLyDSKtTFvxNvKKO2NgXbnU14msTz7qkhZ09jvrmVvREEf7ur3
         Tv1P7hPJl6zaBJY0e/QxfZNZY40C+6OkG8pxhj/kHgigr5lfQm9weO4Jah+vFJJE07lA
         xoC9lCed/x6CQEzRAmWh5JK5bp689DZFcSmgYU+WsVCN48vVvPBo5DkzXbqM8A0LLg9a
         FBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BVTkmsVRm3h6Y3wK0B0yjGZ1PS4IZYgOdJPvequ14+g=;
        b=SbnORyVtMxrK/QQ1n6epchGDA2rTxZW1XaILsWufNTTpD8BLBEywsBv1Sj0zXzF7+p
         UMWDzroxhYcitXtStt1gkXCqHWdATQY+i0/nH6iFl+AgPeTfQcCc/e+FoAjyC9ubsdSE
         QBfarZyN0DExlBSX9gUjl59eB0A1ShRQzdSFw5i6yCakBjVG/avg4s9DP4xDIq8T7+kh
         9jRXnXHkricN5LRNGEsdK/B8Ntp8AHOoucFnzVymkF9K/4kHGTHgYXzemmhSultpErxk
         vQ+MpcnQfj1MtSiJ/SrJ0s862GKI4b9hL34cY8iDvc8l+tXQsnXpxy3FLF8/PpJF7jeK
         O+RQ==
X-Gm-Message-State: ACgBeo1OU9m4tgJddQGaZfyqFF3n3iXXuZKYeJ1qSWQnEb6LL6Nbk760
        AiR8cOc9+KafVeyxrBeBHwDrAQ==
X-Google-Smtp-Source: AA6agR4I5MEUWAKxaPu2nUIahQaawT1vDJmagGnBvuKFRFJQ+/qgmOKCisiBHBL0d0J+G3178WFydg==
X-Received: by 2002:a05:6402:1f13:b0:44e:97dd:7b77 with SMTP id b19-20020a0564021f1300b0044e97dd7b77mr6090665edb.300.1662455100484;
        Tue, 06 Sep 2022 02:05:00 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id b29-20020a50ccdd000000b0044ebf63d337sm1612531edj.57.2022.09.06.02.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 02:05:00 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v3 3/3] iio: temperature: mlx90632 Change return value of sensor measurement channel
Date:   Tue,  6 Sep 2022 11:04:32 +0200
Message-Id: <61da82560512fbbda5f4124a1c907375da822b15.1662454215.git.cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1662454215.git.cmo@melexis.com>
References: <cover.1662454215.git.cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index 6b33284eb0b6..aee065a38772 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -436,7 +436,7 @@ static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
 		*channel_old = 1;
 		break;
 	default:
-		return -EINVAL;
+		return -ECHRNG;
 	}
 
 	return 0;
-- 
2.34.1

