Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8412450A77C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390980AbiDURyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390955AbiDURyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:54:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6786D49CAE;
        Thu, 21 Apr 2022 10:51:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e2so1460496wrh.7;
        Thu, 21 Apr 2022 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=swQTkiKjFD5ptp4W3Ja/W8eTKagq0ceNN+OGlm4hQ/4=;
        b=NoPiKXW+7QpOjDKp7ziLUhiCsVn1X8FjKO8AO+JWtvK9ZEZrXXM28kWkJnfsWXH6MW
         5cY40nKZbGmAJRZulx5OrFs49VpNkpJ6uRKSP27CxctLa2/P6R1528Iv/tfYWr7/xF2E
         TF6d2AR4AVOWEtAJDTY6Khvw4JAMmo4QwwT1XcYTmZp0+ac1x67pns3W1J/+EUJAdxDh
         YTARN/nII2+baMOH3JIPs+z8ysYsqCLmRGUzAm4IzHwBNUqF1jSaWogUuF/HyAGid0zr
         tTjwFWrI2J0EJ6qhkBa+DiU1BVh12rNnu8e0iHYivIjip9J96ZzKyFXSFYka/uWZcImt
         xraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=swQTkiKjFD5ptp4W3Ja/W8eTKagq0ceNN+OGlm4hQ/4=;
        b=rNyzQQGjitSfbvom9Csl8hCTbBOlA6KFvL5TJDPyicQH/f+8ibAQZjPGMX4xkt7Czy
         GOvsJrMh3p1/Tgtc9jmwguFBWr1gZYZtG9P8jj+Zrmc+YV6ZDyI5FcuxkhHv0cNqa4VH
         tx/FcN5Zy2ajBg5KbY9c1xAPTlgCWSdEAW6kExifOkqd6vAM51Q999Ovy9yPcPUTmxic
         I2WswVXDh3BGV4yHkg/zP3cHBh/WggI6GD4ScogVroDN7QrpxHuOr+hAV2wP7V4OuW09
         gjBuplLN1nNmRLgKZF7u7Xk6puajgHmC1b/8xu2jN/dcJZnwAd2FyhsXv4Yd4/OC/5QA
         xnIQ==
X-Gm-Message-State: AOAM531N8qgGhqiWaA90VtKGElYQlpYsqoYnNSJvesRWWvW80hC6x8dP
        H1/vcZ2OIQbZf9T6rIwMQ4QnaEo9A+U=
X-Google-Smtp-Source: ABdhPJxPMncNG1jRjthRoVskLKjXa+e9urIccixdabrPtknrvZC5BkR+Y0mVLOuytrGVWUqzrrVCjg==
X-Received: by 2002:adf:b64b:0:b0:207:f20d:23f0 with SMTP id i11-20020adfb64b000000b00207f20d23f0mr643640wre.11.1650563482009;
        Thu, 21 Apr 2022 10:51:22 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038ece66f1b0sm2685634wms.8.2022.04.21.10.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:51:21 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 5/5] HID: uclogic: Disable pen usage for Huion keyboard interfaces
Date:   Thu, 21 Apr 2022 19:50:52 +0200
Message-Id: <20220421175052.911446-6-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421175052.911446-1-jose.exposito89@gmail.com>
References: <20220421175052.911446-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolai Kondrashov <spbnick@gmail.com>

Disable pen usage inputs for Huion interfaces reporting on-the-frame
buttons. We don't want to change those, as they mostly work, but we want
to avoid creation of a mute pen interface, confusing to users.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index b85585ac3372..22f9c4f9da8a 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -713,7 +713,8 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 
 	/* If it's a custom keyboard interface */
 	if (bInterfaceNumber == 1) {
-		/* Keep everything intact */
+		/* Keep everything intact, but mark pen usage invalid */
+		p.pen.usage_invalid = true;
 		goto output;
 	/* Else, if it's not a pen interface */
 	} else if (bInterfaceNumber != 0) {
-- 
2.25.1

