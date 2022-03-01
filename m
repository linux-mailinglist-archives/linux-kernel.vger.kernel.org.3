Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683FA4C814C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiCACxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiCACxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:53:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49D054990F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646103154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wtwD31/3vxlTAO3x0e3WlhDgfN73zgYlAP/xJTtBWTk=;
        b=I6+7+QxHdZ8J/6p05l/OV96/ElySf2JaNBZI+2Y9khVD7dfsBdjXc53WU8WIsXh/n4q95K
        3QK493xshUFAPHYtLJzQrqdWxopbNDAjNIXyO+wVr4Up+XAva0ECwd/Rqlyt5e7I1No/m+
        XtWR64s66OX3f7OyRFClnTIXa4oq25E=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-d36KGS1MNPO9DJvbJ9_NdQ-1; Mon, 28 Feb 2022 21:52:33 -0500
X-MC-Unique: d36KGS1MNPO9DJvbJ9_NdQ-1
Received: by mail-qt1-f198.google.com with SMTP id a6-20020a05622a02c600b002dd2d38f153so6307952qtx.17
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wtwD31/3vxlTAO3x0e3WlhDgfN73zgYlAP/xJTtBWTk=;
        b=RVPWIS77mCVUK0jJU/OedCNY3fVPiaqVa8xkU4+m85v/8498lPn4S8NuxJZNOsPpDr
         l6l6ox/14vKUmbLH4XWXuD+/suXuCjuHGoqJahB+Z0WhI0qkqUEZ1m9swmjccnaEDcqO
         aAibFPZbeZumpunmq46JGDODr4XSPo0VVZwkgY8nbLX/n9mkmhqQ6yGTtffMEsrwLKpS
         VmdcRDdKiUvYW6ieMhimOiCjAdDdyPZCki7NUcyc2i2ZkMN9f9q4QcTragkar/B3u/Vm
         d0GXYPrh5WMf/c6GK09rv0knHVLLKzV1ND1KBQgtCjY0uI9eF1y2OACIDNEtX9JSwJNv
         s40g==
X-Gm-Message-State: AOAM533W+6Q8GE7XV3X+jUcTiQ9m7dM8KI3o6rm52Y7F+AOdaV5XBZeW
        faDdTWhLkLtsyYWMEheAK9Cp59ewtefYBit1lQWBQwNjd0hWoZdW7OKfrjDKXDGZTLjjIKp+r1d
        HwfX0IKUpAvEZodOjFCUdSJJZ
X-Received: by 2002:ae9:d842:0:b0:547:b883:932d with SMTP id u63-20020ae9d842000000b00547b883932dmr12459345qkf.646.1646103152638;
        Mon, 28 Feb 2022 18:52:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3IyXCmmpTR5dLhhN0LNYcofK/4TPhGco8CWp5Hk9TKdbj8OZ9i5OKyRghyBv/atBgK0FT8w==
X-Received: by 2002:ae9:d842:0:b0:547:b883:932d with SMTP id u63-20020ae9d842000000b00547b883932dmr12459338qkf.646.1646103152413;
        Mon, 28 Feb 2022 18:52:32 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id j10-20020ac85f8a000000b002dde6288fa7sm8383230qta.83.2022.02.28.18.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 18:52:31 -0800 (PST)
From:   trix@redhat.com
To:     roan@protonic.nl, jic23@kernel.org, lars@metafoo.de,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] iio: scd4x: check return of scd4x_write_and_fetch
Date:   Mon, 28 Feb 2022 18:52:23 -0800
Message-Id: <20220301025223.223223-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this problem
scd4x.c:474:10: warning: The left operand of '==' is a
  garbage value
  if (val == 0xff) {
      ~~~ ^
val is only set from a successful call to scd4x_write_and_fetch()
So check it's return.

Fixes: 49d22b695cbb ("drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor")
Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: rework return on error logic to be similar to existing code

 drivers/iio/chemical/scd4x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index 20d4e7584e923..37143b5526ee6 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -471,12 +471,15 @@ static ssize_t calibration_forced_value_store(struct device *dev,
 	ret = scd4x_write_and_fetch(state, CMD_FRC, arg, &val, sizeof(val));
 	mutex_unlock(&state->lock);
 
+	if (ret)
+		return ret;
+
 	if (val == 0xff) {
 		dev_err(dev, "forced calibration has failed");
 		return -EINVAL;
 	}
 
-	return ret ?: len;
+	return len;
 }
 
 static IIO_DEVICE_ATTR_RW(calibration_auto_enable, 0);
-- 
2.26.3

