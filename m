Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0048F533EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiEYOCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244847AbiEYOAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:00:12 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E56AAF30C;
        Wed, 25 May 2022 06:59:15 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id v66so25112996oib.3;
        Wed, 25 May 2022 06:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/M2wDrn8lT0P2wYsNtxidQj1uwd0KpXk6aB8e+bh3bU=;
        b=ZhAJwcMAutG2IT50UlAB507BazyaBYEr4BJ29oSegYYr6xYUM59HqWCan1P7OU3AJz
         bPNEqvgZW4NYHShpQOmJteKmt4pxcu2eDIP1iel4eruEUM2+rWiXoZEH6w1HW30WnepB
         /YNKqEikNvAS187JGxOmm8wZgkQ/bX1AI4W0fldg8UgyGQTScQNkLD37MRGWWSSt2KQV
         BdzOfjAYvdGl2Bsx7BpX3A+/9/kfV0qogudC40TlZkkPRMIpYT48HR407bK/J2dnSAM3
         fflgDU8iTt8lSeYGydYLYVtDRF6mj7FDMaUUSbtABUiZ6jnE6AmAM0nhoudc812t6266
         PVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/M2wDrn8lT0P2wYsNtxidQj1uwd0KpXk6aB8e+bh3bU=;
        b=001uaxrvIH2RuVEdD+BUqDe9Ss5uBRQIBWavvVlf1IcqQqAcIDRiybL7lD0LaBekjG
         57RnWE5SUsBWQLpON7FjveVjuKv37mHRZxfRAeP25L48wDkP+EqBUm374HAbddOIJx3E
         UYXrVBlLaFH/PlGftuTGf17rphcXThWNiedQGarvqcQXAsegp7aHElUAK35uqt9Q2Jvs
         mMXMSzjJ7TtloPnvcL/UW/SLaBQS2k+xIZJNIJ+ni9I9B6Ml0VAn1UV+u9dX7v8aYaTN
         RG4rcIqP2znG6HPsB6fUnIYAU1XEt9SLNFNO9rVJQHboMETEZhwZkXSWXJ1spd+wntkV
         MzXg==
X-Gm-Message-State: AOAM530Jp2SAK5vvnoG95oyaxCv4Z4BGRcTh5kOWV40+eJCoXFe4tuN2
        zohdY7lC+764DSEXpetP8ppq2BnCigyfhA==
X-Google-Smtp-Source: ABdhPJw8ba18c0a13wRBdd9mV24595zm36+A7mzmdGBMHYHDYhOCB6HbYDN8mWHrMakiK5mpw1ChHQ==
X-Received: by 2002:a05:6808:13ce:b0:328:da83:aba3 with SMTP id d14-20020a05680813ce00b00328da83aba3mr5460939oiw.265.1653487154924;
        Wed, 25 May 2022 06:59:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o66-20020acaf045000000b00325cda1ff8dsm6258758oih.12.2022.05.25.06.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:59:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 39/40] hwmon: (lm90) Add table with supported Analog/ONSEMI devices
Date:   Wed, 25 May 2022 06:57:57 -0700
Message-Id: <20220525135758.2944744-40-linux@roeck-us.net>
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

Add table with device names and known register values for supported
devices from Analog / ON Semiconductor.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 77102e0a4440..7f8397c362e8 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1828,6 +1828,42 @@ static const char *lm90_detect_analog(struct i2c_client *client, bool common_add
 	if (status < 0 || config2 < 0 || man_id2 < 0 || chip_id2 < 0)
 		return NULL;
 
+	/*
+	 * The following chips should be detected by this function. Known
+	 * register values are listed. Registers 0x3d .. 0x3e are undocumented
+	 * for most of the chips, yet appear to return a well defined value.
+	 * Register 0xff is undocumented for some of the chips. Register 0x3f
+	 * is undocumented for all chips, but also returns a well defined value.
+	 * Values are as reported from real chips unless mentioned otherwise.
+	 * The code below checks values for registers 0x3d, 0x3e, and 0xff,
+	 * but not for register 0x3f.
+	 *
+	 * Chip			Register
+	 *		3d	3e	3f	fe	ff	Notes
+	 * ----------------------------------------------------------
+	 * adm1020	00	00	00	41	39
+	 * adm1021	00	00	00	41	03
+	 * adm1021a	00	00	00	41	3c
+	 * adm1023	00	00	00	41	3c	same as adm1021a
+	 * adm1032	00	00	00	41	42
+	 *
+	 * adt7421	21	41	04	41	04
+	 * adt7461	00	00	00	41	51
+	 * adt7461a	61	41	05	41	57
+	 * adt7481	81	41	02	41	62
+	 * adt7482	-	-	-	41	65	datasheet
+	 *		82	41	05	41	75	real chip
+	 * adt7483	83	41	04	41	94
+	 *
+	 * nct72	61	41	07	41	55
+	 * nct210	00	00	00	41	3f
+	 * nct214	61	41	08	41	5a
+	 * nct1008	-	-	-	41	57	datasheet rev. 3
+	 *		61	41	06	41	54	real chip
+	 *
+	 * nvt210	-	-	-	41	-	datasheet
+	 * nvt211	-	-	-	41	-	datasheet
+	 */
 	switch (chip_id) {
 	case 0x00 ... 0x03:	/* ADM1021 */
 	case 0x05 ... 0x0f:
-- 
2.35.1

