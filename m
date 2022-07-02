Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934F0563F1B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 10:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiGBIrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 04:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBIrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 04:47:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C4F19293;
        Sat,  2 Jul 2022 01:47:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a4so7567922lfm.0;
        Sat, 02 Jul 2022 01:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vy7/4tbj3XLf+DpLreSYSf+oxe5mn9Q33pXydZQga4Q=;
        b=fvXrwjZRbBrffHRM8JwBM4z8pBMYUm6Fsh9ZeXhzOfA0ahpHDdgMHDagsUYHe11hAP
         5+eFcNUy/tt1UZgX1n8jNQKkxP0YbMjVkZPBt8Xttnm7AmGDlDmnKAz2pPwWiUtFFODq
         yGYXdTx5/5HLY6+IA2nFWDzj4i7obtpLZE/bl/dBOVXUa8OHyL5Rus7Tj+AwHRYvA6Pg
         tIrPromxtwbKPOnzIguMrJQWMe8uS4ULQMFXg1gUaviR+MmBwMe5RfGfoQgCa1ZA51Lk
         38VKvHqIzk4Iuve+dcQr+bVL2nsPTTEs/EIzDbuPr6HfVm7MuUMwPQrWpHX0CDTzUjE4
         ZARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vy7/4tbj3XLf+DpLreSYSf+oxe5mn9Q33pXydZQga4Q=;
        b=hqTAcT72Wf5gzcbAQ9NfyBzpBQuT/bECKQbuOG4SRqI+MQ0GuMpSKhVK+njoMh6JSP
         PFJ/xL3YpwoGt2Y1XlOmonVpqxen0+UaZ80V8KAaulrEsV5HSD56QSKCYqfNRJ0B8IS+
         WfOB8cysFzGso4F+iuLDhS1t7nwQdXVAv4oF/vnNlKUqKRWfqPYWffVLvBD7zFqU1m98
         JQO0DV+Rc0ta+3dITVG4M/0mNux+mjo17x18rBkhFLSM6AioW/b1bWqiRA0mCrLXLMtr
         eQDyfoGH2O6hSaRPwb97OrDsdObLU1N8nunZo4YNTM4rAQXemIE+DdJAiHZ89srKWVta
         TROA==
X-Gm-Message-State: AJIora+7zZPR+dFNX84UqOEme2XjRPD+EXrKVsedpgfforRXeLRwJw0Z
        mjZVJeIq/u77E8/v/tFxKJju7PzRKRU=
X-Google-Smtp-Source: AGRyM1v/zjYwatx+gb38PYwgXomu3E79oePMRdz3/y41C5wMIHXmBRgF28i/W/6414JZUsWr8JeocA==
X-Received: by 2002:a05:6512:31c9:b0:47f:664b:34ae with SMTP id j9-20020a05651231c900b0047f664b34aemr11460725lfe.503.1656751628516;
        Sat, 02 Jul 2022 01:47:08 -0700 (PDT)
Received: from localhost.localdomain (c-2ec2f5c4-74736162.cust.telenor.se. [46.194.245.196])
        by smtp.gmail.com with ESMTPSA id p14-20020ac24ece000000b0047f8de9e6b0sm3965765lfr.104.2022.07.02.01.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 01:47:07 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] iio: magnetometer: rm3100: do not explicity set INDIO_BUFFER_TRIGGERED mode
Date:   Sat,  2 Jul 2022 10:50:05 +0200
Message-Id: <20220702085005.31666-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core sets INDIO_BUFFER_TRIGGERED as part of
devm_iio_triggered_buffer_setup().

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/magnetometer/rm3100-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 26195733ea3e..060914c63969 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -552,7 +552,7 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	indio_dev->info = &rm3100_info;
 	indio_dev->channels = rm3100_channels;
 	indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->currentmode = INDIO_DIRECT_MODE;
 
 	if (!irq)
-- 
2.36.1

