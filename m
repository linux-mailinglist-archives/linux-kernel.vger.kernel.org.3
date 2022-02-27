Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076F84C5CA1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 16:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiB0PoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 10:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiB0PoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 10:44:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A58641FB1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 07:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645976619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=smOWqrVZ4eE9JROh4nQ4evf5L+Z1zd/JgqN0UrYlquk=;
        b=Yn+7viEH/ujy6f82tWRnwzQKav9zw3enRazDnT1uEg1SnOu81MkxGCf668+g/3MyRkPnsw
        WvukC9Vci6IYYjH2Sba/ak6AK1ZieERqszXNnaND7bfYx3+Nuj3M0OZTE3AHIqxotuE/mx
        3jf4ha6NQxUyX0NLM7/yut3eNvjk15s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-gDyQaRIiPyS6sWHSDnayqA-1; Sun, 27 Feb 2022 10:43:38 -0500
X-MC-Unique: gDyQaRIiPyS6sWHSDnayqA-1
Received: by mail-qk1-f197.google.com with SMTP id 3-20020a370603000000b0060de5e49129so9507665qkg.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 07:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=smOWqrVZ4eE9JROh4nQ4evf5L+Z1zd/JgqN0UrYlquk=;
        b=Kgqd+c0OrR3akxjAqJvvlhsQ0lj+veoiWjJuBlRkbWOoG6yxkqzOPAfR5LhfK8wyGI
         UBjbGefqbNrh6/G7MX0lFysxruU4S6httbu5HH8j1JOZ2dizSQMYXmQ3NcSzDg86skpv
         1wgvwlEMXW25ethrPI4EK01ZT+WwnA2UGhHbhDR+R5x9ts4CVage9ekG5Ooh0b8a3dZv
         7zKrO8OtfeW87js9HCCEMJa5NfmfYu4q0YOyfSe61LNth0UlyqBtb/ASl9FIOw4BWDSx
         TqBapEKAAK91I8qACZ0gTblFZI8Av5HR+tn1juAtexSGOc81jiMs+bkwU+g1j165P2+W
         LyOg==
X-Gm-Message-State: AOAM530iNwfcA7v+DqAm4jCKtiCIRPPixcuWJx40GZTw0blT7pExOdgX
        l/veDzeXQMLqBENb5kSI6syeMv/Mf6YOAAAHK9ba+rQ9waDUQdBE7RzYqDEadZ8MvP34C1nxZeG
        2WKrsETJgFlkuO5qQ0+GlzaTk
X-Received: by 2002:a05:6214:23c8:b0:432:e64e:969a with SMTP id hr8-20020a05621423c800b00432e64e969amr5260655qvb.109.1645976617586;
        Sun, 27 Feb 2022 07:43:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWzeFRSiG3cOIAwp97dJ6GYhZ7NMFr89QVxs3UHGNUewDKGBxEIr1Lw8iFumUGLWe3rqDY1g==
X-Received: by 2002:a05:6214:23c8:b0:432:e64e:969a with SMTP id hr8-20020a05621423c800b00432e64e969amr5260645qvb.109.1645976617352;
        Sun, 27 Feb 2022 07:43:37 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id g19-20020ac87f53000000b002dd45d67a8esm5104596qtk.59.2022.02.27.07.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 07:43:36 -0800 (PST)
From:   trix@redhat.com
To:     roan@protonic.nl, jic23@kernel.org, lars@metafoo.de,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: scd4x: check return of scd4x_write_and_fetch
Date:   Sun, 27 Feb 2022 07:43:31 -0800
Message-Id: <20220227154331.80338-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/iio/chemical/scd4x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index 20d4e7584e923..b978330fb761c 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -471,7 +471,7 @@ static ssize_t calibration_forced_value_store(struct device *dev,
 	ret = scd4x_write_and_fetch(state, CMD_FRC, arg, &val, sizeof(val));
 	mutex_unlock(&state->lock);
 
-	if (val == 0xff) {
+	if (!ret && val == 0xff) {
 		dev_err(dev, "forced calibration has failed");
 		return -EINVAL;
 	}
-- 
2.26.3

