Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED0D4C3832
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 22:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiBXVwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 16:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiBXVw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 16:52:27 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCAA11B5F7;
        Thu, 24 Feb 2022 13:51:52 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so644985wmj.0;
        Thu, 24 Feb 2022 13:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmFWZxc6krmQRrhWIAxPmo8/k4kV7D8olzPCdDWyKQM=;
        b=X5E/edASjqW4AmDXaRw68tytzufmqT8gIqxKApCij5Cxi4pSXeLwRjLdO6j9F3wkH4
         i4fRl1qQo6SNEKbU1COrAitP5CDGXDsMmTpPb90lHkNOczhpfO27ZDei6Qwk650BSaUn
         MRyMz5vBByitj7LOA3ZtLFSMCTnc+dtxos3cpHnSxBVUE+k1MHBcWJ4CHroOBQ/DIfxf
         iZ1AA/BP1A40QlD+kDXVxmmLNB2lUHKqSxEvXwc4bbAmLUgvokKBXoAcykTt3uA6XL1/
         vkrabdcd6O4BDyWBNb9EhW9tgSyXS8tTaZFcAiURnm6W5Zv2y5/5lI+JAYPLTfGAHYmC
         5q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmFWZxc6krmQRrhWIAxPmo8/k4kV7D8olzPCdDWyKQM=;
        b=Q9ZGfIuiWDrCCyWY8geDmrq7buJbqsVZTwkVZG/IyysXa24/f4JOGvICuKpwwXP0Ai
         mjg/NMVsYtXPD9VpSAXWXvT04Slgiy7rXhR6LBxpOb8dYN/u8sHp+G5SeCtTM7BUzpr+
         sE9GNlSy1JOeTQcjkuDlG5uON6lT5i9mXYqppRx21s1V9nnQQmfi1dXs8FypDJ69b7Dm
         dwuoq+opESZHijQnDjast0Q6sSfltLaSClbS681bNpetosT8D8DZ7ZnZ7RPV5vXEdvba
         25C1WtKCfeGCv3RCoLyktOzK0yI3occ5MTaEVSmNkXUHjalZEPLD/1GFziJU+UQmg5au
         IYAA==
X-Gm-Message-State: AOAM530alIz2wit82jNKDeMmznl8y7GqedbY+ouea51/A6w0qMIstQtQ
        +xAmcLO5cYwyCS+9+FOkgzg=
X-Google-Smtp-Source: ABdhPJxZ1KpbZuMsHDzvLhXF6ZMUiAMtkH8QGbAfvEoDmlzEFAHsu+keY4Gj4RcH8HO14t7vwlBAyw==
X-Received: by 2002:a05:600c:2101:b0:381:2275:1d71 with SMTP id u1-20020a05600c210100b0038122751d71mr101315wml.90.1645739510678;
        Thu, 24 Feb 2022 13:51:50 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id x11-20020adfdccb000000b001e57922b8b6sm490014wrm.43.2022.02.24.13.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 13:51:50 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: accel: adxl367: Fix uninitialized variable handled
Date:   Thu, 24 Feb 2022 21:51:49 +0000
Message-Id: <20220224215149.146181-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable handle is not initialized leading to potential garbage
results with the or operations. Fix this by replacing the first
or operation to an assignment to ensure handled is initialized
correctly.

Fixes: cbab791c5e2a ("iio: accel: add ADXL367 driver")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/accel/adxl367.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index b452d74b1d4d..350a89b61179 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -884,7 +884,7 @@ static irqreturn_t adxl367_irq_handler(int irq, void *private)
 	if (ret)
 		return IRQ_NONE;
 
-	handled |= adxl367_push_event(indio_dev, status);
+	handled = adxl367_push_event(indio_dev, status);
 	handled |= adxl367_push_fifo_data(indio_dev, status, fifo_entries);
 
 	return handled ? IRQ_HANDLED : IRQ_NONE;
-- 
2.34.1

