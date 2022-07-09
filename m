Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045E956C6E9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 06:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiGIEf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 00:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGIEfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 00:35:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCEB691CD;
        Fri,  8 Jul 2022 21:35:23 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s21so648292pjq.4;
        Fri, 08 Jul 2022 21:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=v5yD9L6s32T5k6XeGkSUl55j73gr0LL5Hqkv0eTGMqs=;
        b=TlGHnzG2HbqkDa6jSYYnIQwis01yN5cUOeoeZrlaiQS6ArN6UqFqYQaqyj/cHwV2gk
         MrWOiRjgja75OBFFnyeNIJsNxHFPQUW27cP7buGTWs1K0gB4ezsxwjzz55lyGGzjsNJh
         F01kjXBZr6ko1emTK43Ou7PpVL2ZFvr/QT1aj+FTQGE5MNlV5CpRjIFJ54LhjQ7/zpf1
         xRDUWwrovvh45qEA1E49/Fuc8T4427zJJ6DEcJDMcOgnqNMy9SSgiicjbh1RrlJzk4eP
         ohDNW/5UNAN9vSw6g1j6D2ml35rRN0yg3GdLufU29HWwQpC6MaWsU+JNGrYLq8/MEdjf
         vUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=v5yD9L6s32T5k6XeGkSUl55j73gr0LL5Hqkv0eTGMqs=;
        b=MpWD0DzZNP5y9Af4Z6gLQZfk6WDanezcoOAICVEm/ziBsZGRJnIx/gr3JUpgcSxbA1
         ig4EoBM5vr4AI8+XukaqWa/dyGhEBLpn4pn0y5o9RtTKC0/UDS2cXr7waOm5woSizv2p
         7bUjVgBiEHNEkBBIj4hXSxE5GfRii6yV1lYwrCtwGkrrCJnz0xC/rPM7eC3oLRCps+6S
         SqQyZ+bxdturIgUT84lJlro0LwHOZw0I7J2OqHOuEK6SNwHC57PcN2abo3QBZ8RnGP4X
         cJQihyxl9YNMvsHOFbttZ2j81sQ98Zmzs0mk8um55ygDE+lWygeGFjiLZL6oFFwU/ijn
         wTBw==
X-Gm-Message-State: AJIora8+JHQ29qkmrvZBngV8iPU0vt2tJD4lecbMLpBbhZ/AipnrzE5z
        JwENEa6EsiFpL49qs6RFoR4=
X-Google-Smtp-Source: AGRyM1sRV8fyXsuCNbhEGERYkce96bhH9r9pNNd4qdDPGr5unRkL4jZlTOTBBPRp38U82OrMV6bLKw==
X-Received: by 2002:a17:902:d4c8:b0:16a:480b:b781 with SMTP id o8-20020a170902d4c800b0016a480bb781mr7056001plg.79.1657341323014;
        Fri, 08 Jul 2022 21:35:23 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:5011:9ea9:1cc2:a4c0])
        by smtp.gmail.com with ESMTPSA id e27-20020a056a0000db00b0051bbd79fc9csm438218pfj.57.2022.07.08.21.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 21:35:22 -0700 (PDT)
Date:   Fri, 8 Jul 2022 21:35:19 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Artur Rojek <contact@artur-rojek.eu>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH] Input: adc-joystick - fix ordering in adc_joystick_probe()
Message-ID: <YskFh4NHnlcryMkk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should register the IIO buffer before we register the input device,
because as soon as the device is registered input handlers may attach to
it, resulting in a call to adc_joystick_open() which makes use of the said
buffer.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Not tested on hardware...

 drivers/input/joystick/adc-joystick.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
index 78ebca7d400a..e0cfdc84763f 100644
--- a/drivers/input/joystick/adc-joystick.c
+++ b/drivers/input/joystick/adc-joystick.c
@@ -222,13 +222,6 @@ static int adc_joystick_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	input_set_drvdata(input, joy);
-	error = input_register_device(input);
-	if (error) {
-		dev_err(dev, "Unable to register input device\n");
-		return error;
-	}
-
 	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
 	if (IS_ERR(joy->buffer)) {
 		dev_err(dev, "Unable to allocate callback buffer\n");
@@ -241,6 +234,14 @@ static int adc_joystick_probe(struct platform_device *pdev)
 		return error;
 	}
 
+	input_set_drvdata(input, joy);
+
+	error = input_register_device(input);
+	if (error) {
+		dev_err(dev, "Unable to register input device\n");
+		return error;
+	}
+
 	return 0;
 }
 
-- 
2.37.0.144.g8ac04bfd2-goog


-- 
Dmitry
