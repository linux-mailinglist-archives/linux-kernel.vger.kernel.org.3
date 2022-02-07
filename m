Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852A84AC0EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbiBGOSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390703AbiBGN7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:59:46 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DE8C0401C1;
        Mon,  7 Feb 2022 05:59:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r29so7007928wrr.13;
        Mon, 07 Feb 2022 05:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mcWbPuUD9zG5TmO7Q6+xyivnOj6cc3M0HEAfvxU+7N0=;
        b=itcITwBvp8aqCL8K9Inahp3hlAut70WgrUe2y7ZIrA9VKxPz5YUyvnE3a6pyDhe7A5
         9vh8ylalPe4+CfW7VnQE6FYt0nWmKLEUUimUbA5rYZRjK6R/yR/rnCzDMvMwOGqwR/Zi
         hZMn8ocr5DmpXhxBGcPQUF59bHnfxyRNzw9w21vKyd8f6n3YNIgvLlDsCdVZB41xbJNh
         rOJIDTfuOSzYS4lLL/sIW6fSo6jCT0OF5a+UjFIc0coPFk15bf2HDT8tVKRWAPjCj7yU
         YgAlaJkL6dDuWNxsVtQu0zHa2myy9fMZ2AJufcculCPCgrzfcE7r/xpAKnBJUON6DL2u
         CeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mcWbPuUD9zG5TmO7Q6+xyivnOj6cc3M0HEAfvxU+7N0=;
        b=j3Gl14xoooPcjP0mo/aGRjYZL25QLYbD8byGfeFDpuxkgVYIOxjTyV1EpWTsHp97x3
         9BG808HY0RBpvkxum89K7bU4RcCqKN9ay+VFYVQ9Hh7M7BryB2a1DApk4pR5hBB9OOdX
         ioGI0nLq+kcxC1UgDfVzdduWUmI+vK+lzSQuR4+CNU+QFuLAtOp/CF2YWEFUDjw1FfX5
         LmbreM0KP1wZSVFa8gZ52vLlgvjaJeCJP3jDCNgtajD6qL0UumEO7PfunoNbN4y3TeVH
         D3iujowfkeqao+weeGKMWzUlWXX7fRQ8CPDmelrNC4y5ZllZxMbb64ibm5TOGJa2O4h7
         1/+A==
X-Gm-Message-State: AOAM533WlbpllNtbtjjP7s2C9OjNbhHQkAMrWVyQy0y9XUaqRwwV/4bZ
        t7vsNoT4FMNpVxyXuWUq7Yfodq/3WGA=
X-Google-Smtp-Source: ABdhPJwoYphSKekOyNfRZroxq98own7clIJ9kHg2JAwpfGVrwxrfnBnu7pYQNCeL7DH24pgwwfvC9g==
X-Received: by 2002:adf:f312:: with SMTP id i18mr9978656wro.441.1644242384384;
        Mon, 07 Feb 2022 05:59:44 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id x7sm9910183wrt.77.2022.02.07.05.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 05:59:43 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: cpcap-adc: remove redundant assignment to variable cal_data_diff
Date:   Mon,  7 Feb 2022 13:59:43 +0000
Message-Id: <20220207135943.340629-1-colin.i.king@gmail.com>
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

The variable cal_data_diff is being assigned a value that is never read,
it is being re-assigned later on with a new value in both paths of an
if statement. The assignment is redundant, so remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/adc/cpcap-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index 40e59f4c95bc..b6c4ef70484e 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -474,7 +474,7 @@ static int cpcap_adc_calibrate_one(struct cpcap_adc *ddata,
 	for (i = 0; i < CPCAP_ADC_MAX_RETRIES; i++) {
 		calibration_data[0]  = 0;
 		calibration_data[1]  = 0;
-		cal_data_diff = 0;
+
 		cpcap_adc_setup_calibrate(ddata, channel);
 		error = regmap_read(ddata->reg, calibration_register,
 				    &calibration_data[0]);
-- 
2.34.1

