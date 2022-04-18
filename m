Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5011505A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiDRO6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345110AbiDRO6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:58:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCEC32EF8;
        Mon, 18 Apr 2022 06:46:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e21so18618068wrc.8;
        Mon, 18 Apr 2022 06:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yoyp44JzkHGTT8ZqJq8l6tDNGuUOI937tn9ZpUzw9Wk=;
        b=gh/1az9LTsIQ8Waf71s3RlA7yMXX3Mse3hATc2/up5VvELAIhgtHel3pbElJrsVo2Z
         ekz2AFEXacg2HIbAA2Fp1xbsgwpbyk0bAfqoC2FOK0P62HXf9rb8Zmo7vAj1LTpS3iEj
         Ixi6t4b9Pd20eV09JXiONq1W46dNqBFKz4bhgiWiBdq2AVyq4uzV/BH3bEucMunsQkiF
         E8kaThovYTKQQnqJ4dxlKqjbJUWNMkNR497vhYUMVd3zuW+G4AoI9Gz8tzqCZOLjjWk1
         De79kUsuZqELYp1BmokBLWJ1QBrvDibANF6ZLTZEaqs49XeQBlZVX0ADsMUjKf2KtgH2
         iUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yoyp44JzkHGTT8ZqJq8l6tDNGuUOI937tn9ZpUzw9Wk=;
        b=lrOeSFWCoskZ4Z+OQ6Ryh0SW6EarHVbbpXdWVrS/PjcdlIbicCrokbR05kLALVW6AS
         VNxeX2HAnZBhvOeCGEXBQMQ0wZ8aANlGbcHN0SDwniedJFEL6+LA81fEo/iNoNsAWcq9
         OBki691CMZyBuB4Sa8lOz6jx3Kfpt+Fp+jq9pWR6JJW+8DzQkbpz+hBPJlLgWh1etIOy
         W1QVSQXu/Hky51rpubp99scZX5ZbjbG5EEnhxPrb/0nsJd1ZmDGOpdEr53asYNfc8Jcy
         SMEniYxZ6BCfEfRZV2DsMRfm+llcHJXuJGNEkZHSqHG6pH9024Uk1evIsOAbSJyko8WN
         tP6A==
X-Gm-Message-State: AOAM531rjiDvVPE7DLYAyW+WvY204F75s1ftjWkUDQyv2P6uymHEnRql
        rD9EdgNE9hrzZnPYfphrYoDVNeoMvXw=
X-Google-Smtp-Source: ABdhPJxAVkklnnI5HFoDgPCIommVtr6wdWI7ulYdjfDzlnh9LUgLfiMDzA4l6bYkJLTgZA9t1un9QA==
X-Received: by 2002:a5d:67d2:0:b0:207:a5cf:c14d with SMTP id n18-20020a5d67d2000000b00207a5cfc14dmr8421376wrw.365.1650289564671;
        Mon, 18 Apr 2022 06:46:04 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v11-20020a056000144b00b0020a9c02f60dsm1835302wrx.50.2022.04.18.06.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 06:46:04 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] staging: iio: ad2s1210: remove redundant assignment to variable negative
Date:   Mon, 18 Apr 2022 14:46:03 +0100
Message-Id: <20220418134603.81336-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Variable negative is being assigned a value that is never read, it is
being re-assigned later. The assignment is redundant and can be removed.

Cleans up clang scan build warning:
drivers/staging/iio/resolver/ad2s1210.c:502:3: warning: Value stored
to 'negative' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 74adb82f37c3..c0b2716d0511 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -499,7 +499,6 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 		ret = IIO_VAL_INT;
 		break;
 	case IIO_ANGL_VEL:
-		negative = st->rx[0] & 0x80;
 		vel = be16_to_cpup((__be16 *)st->rx);
 		vel >>= 16 - st->resolution;
 		if (vel & 0x8000) {
-- 
2.35.1

