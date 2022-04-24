Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B4750D41D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 20:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbiDXSPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 14:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiDXSPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 14:15:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4150668F91;
        Sun, 24 Apr 2022 11:11:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d22so4131334wrc.13;
        Sun, 24 Apr 2022 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ig9YP3YTXVoTvXh+iWd0BxQVnOKiliBqH/4WwV9hMaQ=;
        b=GdRNvTfO2/Nn/vEPEoSQ3vXDGYmzsxeFwRwK+82Ps4kCWIuPhbRvuIzqBXYZdbCcCt
         a9cRcxwrEJBg1LmZjA9Y4FjSu/pLzhQnZsbTgWewj5gV/MPxHcewY51KLT7fSE3Yrd6t
         h1YhFgczYh0N3NTUI0UwkHVJXnYwuR2OYYF/iF4Yln3jNG9XvkZwtNs5vSeIwvo61c/p
         BfqcStZv4BcmYX08nUcEIIa+LPzHpHWnEkXV8NVt11/Ch9wN476quLX3eFxie0M0T637
         Sk5Ef+eRIZSQF2eDvvf1UKaKn9eOC0lSa3BfYA2yGVGJx2vcwOC58IEdfBD+g8bkTKab
         Mg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ig9YP3YTXVoTvXh+iWd0BxQVnOKiliBqH/4WwV9hMaQ=;
        b=pqekaEozeizWPrLhAy+5eyX28Fu3G2CQb/HHaodwcNR1S34VxrAbdrT/LifFtgyLeG
         uoje7XS6GaEqHmYHsTbAqpvJ/ycY+7iVJGBwUsBy9d731K5ivp8HgrHDlUYf7WGvQ4EY
         +QPeQ4/+Bj7mX5nembZyk/wnNVKDbMSN9IGLSaKNCcPtgokFuHF44El5ziPT/0m4nrK8
         IbzmwrQzTspCetjl/Mee3K4kjude5EP/9yV+q4pKwCawOXFt/jvfyKbtAcgX/MJVr7Tx
         qGtbKai83WX1lKsG0kMDkf8ZQYQkFkQiEf3VCfZytZISWm9UadjQ0p+9/kYSWOkf9TJ3
         w8Jw==
X-Gm-Message-State: AOAM533KQR6d2cSRVIc60GEmYEfHhAJh0qYb8xaEctXlD63cbLDkoop/
        0VlojtDOkxgXOK8T6j5V06M=
X-Google-Smtp-Source: ABdhPJzl8AxrYA9hU6qSgpunjLklruTGLN5eQDyxctexbG3YbYjoQpezFTE60y7Bma4U6LZiH7JRwQ==
X-Received: by 2002:a05:6000:1547:b0:20a:79dd:28bf with SMTP id 7-20020a056000154700b0020a79dd28bfmr11181514wry.505.1650823917456;
        Sun, 24 Apr 2022 11:11:57 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p7-20020a5d4e07000000b002079a418430sm6804254wrt.85.2022.04.24.11.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 11:11:57 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sumit Garg <sumit.garg@linaro.org>, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        op-tee@lists.trustedfirmware.org, linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwrng: optee-rng: remove redundant initialization to variable rng_size
Date:   Sun, 24 Apr 2022 19:11:56 +0100
Message-Id: <20220424181156.1364446-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable rng_size is being initialized with a value that is never read,
the variable is being re-assigned later on. The initialization is
redundant and can be removed.

Cleans up cppcheck warning:
Variable 'rng_size' is assigned a value that is never used.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/char/hw_random/optee-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
index a948c0727b2b..96b5d546d136 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -115,7 +115,7 @@ static size_t get_optee_rng_data(struct optee_rng_private *pvt_data,
 static int optee_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
 {
 	struct optee_rng_private *pvt_data = to_optee_rng_private(rng);
-	size_t read = 0, rng_size = 0;
+	size_t read = 0, rng_size;
 	int timeout = 1;
 	u8 *data = buf;
 
-- 
2.35.1

