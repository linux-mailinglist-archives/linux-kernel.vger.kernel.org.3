Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D6533EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244786AbiEYOAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244571AbiEYN6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:41 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1D2A30A2;
        Wed, 25 May 2022 06:58:33 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-f2c296d320so1897598fac.8;
        Wed, 25 May 2022 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bqd9sDGFDhX0sNwntoJbXEX9hIUFOxizhST5DKGCTx4=;
        b=YO93NC7qYz2h4XaKkcaeSClzs/5jeYy58/YPkZad1JzBE6UA64qRby4Ca365zp2uf8
         iW0ohOKPyZIplzUf4ODMaZs1QVyeteraYs3w7UHRzpBs5WRPvVErxyydW6r6rEIDfREN
         5gQuc3paTF9sQPkaf8VhxpT2+pA22ZlX3BTKfJNOcAtKswYQWGOawlRCa8Lo7CZoTKWt
         pJN99PSXOy/Z+RXa4KZz+9U28NEJIDmXzhHicgpE8OLrbWBdSRuV4PGu1dh4BjdY/haC
         MrPDF4zHT9RWmkTC9MMtRBxwt7p1CWrj/hVpC6VXkssJkZ+iFBv+RHEtcq6Iny0FUbxk
         h9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Bqd9sDGFDhX0sNwntoJbXEX9hIUFOxizhST5DKGCTx4=;
        b=4EH0oCisEf5IypEVaGB7ziudTIAg+CCjrrsx6gKt6rb7QneMMFHJLunNCCSYrh/1qd
         QF9H+az5/8vJ7XaeSM7zfDUHf++6dbjSNN9wjBCeMExGplBAa3veT7y2T7P3d5Mwc0pP
         j7B80xUS3OxZ+cJc8zzvWGrMHgaoI105SfMZYoSw5MKku/XBEMrF8iYRojX9pcBGoXoA
         viUbGOfOj7tTXcAjgdmv9KEuy8nSUyB6IUeEYMHmVAhfQ8Nf+ER7BcmaIwm8a5/VU89y
         nHScpVTkjbLnNnGVH6SEgBxt+FRMobn9887/7Y6cU/7TG/JBPfE05he710mKwH+zT0mb
         qm2g==
X-Gm-Message-State: AOAM5312egWte9hhHGJL7NlTUpb4QDjYWQcP1LjywOT/39UVj+GEAshj
        xDTL/B6mtUOD7CXo9Sd1GBaX9UOkFeCPmA==
X-Google-Smtp-Source: ABdhPJxM9HooXJAsAPRhKAT5FJq0J45TjuNAwI2HENWgG6LxLK5s0XZL4GJKVjYTJCXO3cw9c2cFFQ==
X-Received: by 2002:a05:6870:2194:b0:f1:c284:a9c5 with SMTP id l20-20020a056870219400b000f1c284a9c5mr5736351oae.254.1653487112405;
        Wed, 25 May 2022 06:58:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r4-20020a05687002c400b000ee2bb503d0sm6036778oaf.50.2022.05.25.06.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 16/40] hwmon: (lm90) Add support for additional chip revision of NCT1008
Date:   Wed, 25 May 2022 06:57:34 -0700
Message-Id: <20220525135758.2944744-17-linux@roeck-us.net>
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

The NCT1008 datasheet, Revision 3, states that its chip revision is
0x57. This matches the ADT7461A chip revision, and NCT1008 is therefore
detected as ADT7461A. In revision 6 of the datasheet, the chip revision
register is no longer documented. Multiple samples of NCT1008 were found
to report a chip revision of 0x54. As it turns out, one of the patches
submitted to add NCT1008 support to the lm90 driver already included a
check for chip revision 0x54. Unfortunately, that patch never made it into
the kernel. Remedy the situation and explicitly detect chips with revision
0x54 as NCT1008.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index f676b809c470..17312d173b8a 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1556,7 +1556,12 @@ static const char *lm90_detect_analog(struct i2c_client *client, int chip_id,
 		    convrate <= 0x0a)
 			name = "adt7461";
 		break;
-	case 0x57:	/* ADT7461A, NCT1008 */
+	case 0x54:	/* NCT1008 */
+		if ((address == 0x4c || address == 0x4d) && !(config1 & 0x1b) &&
+		    convrate <= 0x0a)
+			name = "nct1008";
+		break;
+	case 0x57:	/* ADT7461A, NCT1008 (datasheet rev. 3) */
 		if ((address == 0x4c || address == 0x4d) && !(config1 & 0x1b) &&
 		    convrate <= 0x0a)
 			name = "adt7461a";
-- 
2.35.1

