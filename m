Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE558362F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 03:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbiG1BME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 21:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbiG1BMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 21:12:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C2418B0F;
        Wed, 27 Jul 2022 18:12:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o20-20020a17090aac1400b001f2da729979so3898623pjq.0;
        Wed, 27 Jul 2022 18:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lmQYtc1hSA2dj1fab7+3HzZDSuHervzNbSwsZTrDXjc=;
        b=dckY4rctkINyLcgKXr8vtXi/D9PEwpKwVFnjKS+yi0m8irntIaAIsIqSJtG+i2rbaV
         gKuUQlApE+I5ikOmJPKSyzqO55S7UbPOo2wrNzNtjXFVSQL3fQt7I0dZZGLXuxAA7p+n
         89yp41grVcp1cTEUIXfBsaBOz0YN9EzUn4ZJY4n+f7iJYCY0eXxW+N5pyw2ynpoXlMou
         B5gUYVurPhEhJHmONI3/V3r3NXrPrBeGsQ8D9N5H+u3LA3OZWXOIYz6u6hJMIc6ClnjT
         8puqcqLYVLtu2zmDOLRHc7/HSeo0N35Ut0wZ37crE+IgR0CVlXrMD5Owccp7G+qx/95x
         Ko2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmQYtc1hSA2dj1fab7+3HzZDSuHervzNbSwsZTrDXjc=;
        b=O8Dr3lY/uTKyjU8ITlyYUvxXBFRi1AkD9Qugb7n+f5kw7XkXu6Ks6T1I+Ym9l0m6c3
         5c2F4UN8OmKmIBQtrIAnxLDbVoJo6MDujcgTciL3S0wVg7lIoG2gq+dcmttvKGEI8GXE
         oX7jet1YcbnSVd8M4zVuI+a6tKB6AiVzG4o81dRgguDVu42R2cze83T/mr+H3fbnbQOU
         4xXe1Pwed1D2W/yTmrT590niC7Xy2w+RLMKwEX9e19+Xwra+pOrZ/dVGsTKdsNTw9DGu
         cb/ENpkcinzQg2rpjdZrP2orduR/Cv51cndXpAfPWPzF51CODRNzU1wJE2hDxZkCtRSU
         fFcg==
X-Gm-Message-State: AJIora/O8tMIIK7c6MV6GUO0OFZubrMbaN6NQ9sHkGLlsg9+S8SFFLpL
        xN0qpZAGewhedOoNxo2SJ2Cqo5vegeBkpw==
X-Google-Smtp-Source: AGRyM1sufE+nIab1k+JQR+33NqLDTGV8v4ashdniEEDLhYDXDAHeZRxxhwhpgftNKnmSfq6eSjmZgw==
X-Received: by 2002:a17:902:e84e:b0:16c:773:9daf with SMTP id t14-20020a170902e84e00b0016c07739dafmr24075745plg.43.1658970720570;
        Wed, 27 Jul 2022 18:12:00 -0700 (PDT)
Received: from localhost.localdomain (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id x194-20020a6286cb000000b0052ad49292f0sm14526215pfd.48.2022.07.27.18.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 18:12:00 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v4 1/2] iio: humidity: hdc100x: switch to probe_new callback
Date:   Thu, 28 Jul 2022 00:34:16 +0000
Message-Id: <20220728003417.3083353-2-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220728003417.3083353-1-potin.lai.pt@gmail.com>
References: <20220728003417.3083353-1-potin.lai.pt@gmail.com>
MIME-Version: 1.0
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

Switch to probe_new callback due to probe is deprecated soon.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/humidity/hdc100x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 9e0fce917ce4c..0d514818635cb 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -351,8 +351,7 @@ static const struct iio_info hdc100x_info = {
 	.attrs = &hdc100x_attribute_group,
 };
 
-static int hdc100x_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int hdc100x_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
 	struct hdc100x_data *data;
@@ -422,7 +421,7 @@ static struct i2c_driver hdc100x_driver = {
 		.name	= "hdc100x",
 		.of_match_table = hdc100x_dt_ids,
 	},
-	.probe = hdc100x_probe,
+	.probe_new = hdc100x_probe,
 	.id_table = hdc100x_id,
 };
 module_i2c_driver(hdc100x_driver);
-- 
2.31.1

