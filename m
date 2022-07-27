Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6396A582F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiG0RUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241790AbiG0RSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:18:34 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67315C9D7;
        Wed, 27 Jul 2022 09:43:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g12so16615116pfb.3;
        Wed, 27 Jul 2022 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7g2N+LPpvhsI+BYoOxWNDid5mFnlKNRvqXEHXjEGn0U=;
        b=A6jby5d7R26MBqgj7KMfcldzXS6w2gH/jo+vEUq1Plwm8PiZhd38PzxNHQS3kcbY2I
         uWIvtD+fg3erW9oo9/YEN+T4d/SOHxvSBOgA/PSypI99mBG13MsjJdQhRK/BtSyf8dBa
         ZTI6j3M7PANrmH2yAAJFtGKTXjomJfXaDj/eQ3r/9kgWmZBVFRE1W1WQzOlF/Y/xPEs5
         c/JNnvRbD2Wh4StewQcbsWxHdynt0Rq2pQMEAXMSH6upFEcr1KpGKobgZkthS+ttixdb
         eBniJBFnolGFYwc6ISaHPzvwnm6d/9Z/tPc0ZmAaBF1im9s0iaLIOlghcvrxSmR+QklS
         WmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7g2N+LPpvhsI+BYoOxWNDid5mFnlKNRvqXEHXjEGn0U=;
        b=ICuOjNOTXRlZ8M8pgs4Dz1M62DU+TKbM6GZv+28gD+z/KUSAm/06ccn3iYs8QSJCnb
         c9ccesZz8VO7E5nIBmygrq+UNxbs+J+EUqMTcDgIXld0rsgO3QH7hHuWHRtUm0TpZ37l
         xtqkXVS6WOsT2LVx886q6edT3FYV2w2+LLOquvxrTDB/7tAE9cdsCF037Ux4Tfz6iYsR
         HAC14hne6faHq0IMTo3qls5cMuWqRuRz/9LcNACdi2x9amzgiZuSs2AcK38M+WL/Z46e
         8NbX2PbujDmNfmvaMXxPWeM5f7j1tK6kYtoMpsDjghDGg2Bov8UdQGJNpRroOaIKP8Jl
         kvvA==
X-Gm-Message-State: AJIora8mhSuC00F838o29sE5caeVAtykvNsS1m0F8ddrK1FvUg1Rv69i
        V44//JrYN7R5ipfulSsnvqE=
X-Google-Smtp-Source: AGRyM1tULZAvHviOJ7JER3HelOJx4Ch3pJ1dV6Gzj1h8whCCWRH25fRWyCLS31Z4Fo4YFHL4Nb9WBQ==
X-Received: by 2002:a65:6b8a:0:b0:3db:7dc5:fec2 with SMTP id d10-20020a656b8a000000b003db7dc5fec2mr19125770pgw.223.1658940233489;
        Wed, 27 Jul 2022 09:43:53 -0700 (PDT)
Received: from potin-quanta.. (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090a3d0d00b001ef3f85d1aasm2030480pjc.9.2022.07.27.09.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:43:52 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v3 1/2] iio: humidity: hdc100x: switch to probe_new callback
Date:   Thu, 28 Jul 2022 00:41:32 +0800
Message-Id: <20220727164133.973930-2-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727164133.973930-1-potin.lai.pt@gmail.com>
References: <20220727164133.973930-1-potin.lai.pt@gmail.com>
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

