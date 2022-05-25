Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90ED533E82
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244654AbiEYOBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244666AbiEYN6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:48 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62199AE249;
        Wed, 25 May 2022 06:58:42 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id v9so20438509oie.5;
        Wed, 25 May 2022 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wkrhdTzZFBdfaObCK8hoJNGTchl6SYk4T1R8k1k68pg=;
        b=mOSz+quuCtrbsVf6zg810ztE02+IeItpyZUTHbLjaSUWofYwkyy4wdcRG5Lgwwkxe7
         aovshnhqTMu3qQLVvbwLjCR1mUdWNwIPch0ft5Ma0hJkCE5Vp6iFdeLDaB0qL3IM+Pzi
         eBTZ0CA1psAUgPED1BLlRoaFOR1up6Icghjtw5u7LNff6ulRddAZSOQDTs6kqJXGdID8
         HlQTh0d3+v/7pvMlVVHwCxFbBdFaHEb9k488aGJ3XdW5VniufhdoGs0UsSrNAC78oZpc
         aXYBhG6ZFsI/FiT3vESBKYLGVwkgR8300KWGcO2sMhwnCuNMkmCiN2tJOd6vDoQ+tCEj
         V2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wkrhdTzZFBdfaObCK8hoJNGTchl6SYk4T1R8k1k68pg=;
        b=snkMeBDIEmXqhcSpYImdq+zp06Sivyca8D7EZ7ImpADDpMpvUmgntmR6mn/fXMWUY3
         berqW1p34CPa2wl6WcevtriV8swKGbkvHaCRQn9J1DAFRhcQuiXCe0C+Baf8pBy75YZg
         l/OyyQ58YUzuNzNAvr1i2cf/t++nxOou7Zlmhf9BwYTLVLBs3wmkQ5O06dyzb5qV5tiQ
         +iT5GQVcsxulPsaks+RyPRGGgofTV9AKMGzMfG5VtLe6w0u2VbpwbxnwsIkcBKQ6D19x
         YBFBr06eT5v/KG9Hx95gtCWXDR5ggAHkPof2uPHr4WYexh8RnlanF9te8uvyndzSqeRE
         lsYw==
X-Gm-Message-State: AOAM532jvpIe1ZLORMqnrURFp+8msnS3z9XiJzvxlfYy5jmjtdZnGdJc
        w4qFQ+tTrWaAYHrJ2YEk2nEwsGH1PnDdhg==
X-Google-Smtp-Source: ABdhPJxzKW2WPmq5KSKUH6apX+birMySZgkUgy30ByrWuvu/M9uSQPajhNJsOOz1+gAaAj7pqbZpkA==
X-Received: by 2002:a05:6808:11c3:b0:2f9:62e0:ebe with SMTP id p3-20020a05680811c300b002f962e00ebemr5197311oiv.22.1653487121365;
        Wed, 25 May 2022 06:58:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m2-20020a4aab82000000b0035eb4e5a6bbsm6703745oon.17.2022.05.25.06.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 21/40] hwmon: (lm90) Strengthen chip detection for ADM1032, ADT7461(A), and NCT1008
Date:   Wed, 25 May 2022 06:57:39 -0700
Message-Id: <20220525135758.2944744-22-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525135758.2944744-1-linux@roeck-us.net>
References: <20220525135758.2944744-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADT7461A and NCT1008 support the undocumented manufacturer and chip ID
registers at 0x3e and 0x3f, and return 0x61 as chip ID. ADM1032 and
ADT7461 do not support those registers but return 0 when reading them.
Use this information to improve the accuracy of the chip detection code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index d2477e0c1e1e..abc64738e892 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1603,22 +1603,26 @@ static const char *lm90_detect_analog(struct i2c_client *client, int chip_id,
 
 	switch (chip_id) {
 	case 0x40 ... 0x4f:	/* ADM1032 */
-		if ((address == 0x4c || address == 0x4d) && !(config1 & 0x3f) &&
+		if (man_id2 == 0x00 && chip_id2 == 0x00 &&
+		    (address == 0x4c || address == 0x4d) && !(config1 & 0x3f) &&
 		    convrate <= 0x0a)
 			name = "adm1032";
 		break;
 	case 0x51:	/* ADT7461 */
-		if ((address == 0x4c || address == 0x4d) && !(config1 & 0x1b) &&
+		if (man_id2 == 0x00 && chip_id2 == 0x00 &&
+		    (address == 0x4c || address == 0x4d) && !(config1 & 0x1b) &&
 		    convrate <= 0x0a)
 			name = "adt7461";
 		break;
 	case 0x54:	/* NCT1008 */
-		if ((address == 0x4c || address == 0x4d) && !(config1 & 0x1b) &&
+		if (man_id2 == 0x41 && chip_id2 == 0x61 &&
+		    (address == 0x4c || address == 0x4d) && !(config1 & 0x1b) &&
 		    convrate <= 0x0a)
 			name = "nct1008";
 		break;
 	case 0x57:	/* ADT7461A, NCT1008 (datasheet rev. 3) */
-		if ((address == 0x4c || address == 0x4d) && !(config1 & 0x1b) &&
+		if (man_id2 == 0x41 && chip_id2 == 0x61 &&
+		    (address == 0x4c || address == 0x4d) && !(config1 & 0x1b) &&
 		    convrate <= 0x0a)
 			name = "adt7461a";
 		break;
-- 
2.35.1

