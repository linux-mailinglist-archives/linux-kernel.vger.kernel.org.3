Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE08533EAA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiEYOC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244700AbiEYN7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:59:37 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FD4AF313;
        Wed, 25 May 2022 06:59:08 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id v66so25112996oib.3;
        Wed, 25 May 2022 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=by1luKnYQD47kAIDarg0Z6yZzdf85j8TYof3vvMeI/E=;
        b=Lm98wkNIxmF1KsH/wZjx6n1lrlSKyvurFMsuSbzSnl9U1Zdq1o/FD1IZUfUwtd+fvo
         CPweE0Vb0p+yw/yXgfPzVx4+bYwtsle3mFLSDAUgywC95eSdXoxVV1cDA9cHczU93lgg
         2lLiQxLCqYVA+tsf+tcv72yTPk5AYDZyqiswqYMuy+exyJuzHopN/QAhz22AeFZ3QNbR
         RxvCSCCixhaLeoP5zFgVEb1YHDxUkPX7GuxGerTEPpBYWEMJUmstKm0Y2f0z9HUKAj4y
         nr25XZjznP2kg4bRHf6/nS40yOwUbk8XSQ2lc3F6IDZ7FrabDUlBPAVmmoNFFE8KnrJT
         r2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=by1luKnYQD47kAIDarg0Z6yZzdf85j8TYof3vvMeI/E=;
        b=eVAGbmGTQpXBKWhj6SSXhFEp5IW7w3guxEaKpWsO1hcwKKSo+6yDowbE3t10m7g5Gf
         hdy0qGzUkLc5LIllUT7cBzTsexRqD1jlG42eqKTzKmHKkjvWaXiuESQeethEHiquhyfi
         HyOqPVsvZQFYJIsupOFcucpGHKlSfD5yWH8CYv7SpZVG9fbpFbw3/Splvt/M832Uenau
         hXVAlqV2VX0epLRLfnf95ISEu2tDRyvNdUFjPT8SbIrSVfspJ0Npq9tybixnGTGlJqzE
         xn0+UaTKGU6jjLDWrsItLhymkGOmMcre97GEcKHQsKDdW8bX8EQfxQBThHnRHdzbQNgm
         Yz4w==
X-Gm-Message-State: AOAM532fATUX1tlSBtWmO+8ihK6gAOF5zKPIbqsc0kg7XFAtYqcr3120
        SfeRzmwpyjsOWCyPskAo2EZ1nytJFr/q6g==
X-Google-Smtp-Source: ABdhPJyM0X8CbVcYiiBmM+wEIdRi69Z6Bik8RN5UxB7Awc4Bx+m1b52EVKq/d6JOXv+YXc+UWe/9xQ==
X-Received: by 2002:a05:6808:14c2:b0:32b:3faa:3d81 with SMTP id f2-20020a05680814c200b0032b3faa3d81mr5281743oiw.183.1653487147415;
        Wed, 25 May 2022 06:59:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x2-20020a9d5882000000b0060603221274sm5985670otg.68.2022.05.25.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:59:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 35/40] hwmon: (lm90) Add support for ADT7421
Date:   Wed, 25 May 2022 06:57:53 -0700
Message-Id: <20220525135758.2944744-36-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525135758.2944744-1-linux@roeck-us.net>
References: <20220525135758.2944744-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADT7421 is similar to ADT7461A but supports configurable Beta Compensation.
Packet Error Checking (PEC) is supported but undocumented.

A devicetree node is not added for the added chip since it is quite
unlikely that such an old chip will ever be used in a devicetree based
system. It can be added later if needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 4194b8838f20..d1435f55e31d 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -231,6 +231,7 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "adm1021", max1617 },
 	{ "adm1023", adm1023 },
 	{ "adm1032", adm1032 },
+	{ "adt7421", adt7461a },
 	{ "adt7461", adt7461 },
 	{ "adt7461a", adt7461a },
 	{ "adt7481", adt7481 },
@@ -1816,11 +1817,18 @@ static const char *lm90_detect_analog(struct i2c_client *client, bool common_add
 		return NULL;
 
 	switch (chip_id) {
-	case 0x00 ... 0x0f:	/* ADM1021, undocumented */
+	case 0x00 ... 0x03:	/* ADM1021 */
+	case 0x05 ... 0x0f:
 		if (man_id2 == 0x00 && chip_id2 == 0x00 && common_address &&
 		    !(status & 0x03) && !(config1 & 0x3f) && !(convrate & 0xf8))
 			name = "adm1021";
 		break;
+	case 0x04:		/* ADT7421 (undocumented) */
+		if (man_id2 == 0x41 && chip_id2 == 0x21 &&
+		    (address == 0x4c || address == 0x4d) &&
+		    (config1 & 0x0b) == 0x08 && convrate <= 0x0a)
+			name = "adt7421";
+		break;
 	case 0x30 ... 0x3e:	/* ADM1021A, ADM1023 */
 		/*
 		 * ADM1021A and compatible chips will be mis-detected as
-- 
2.35.1

