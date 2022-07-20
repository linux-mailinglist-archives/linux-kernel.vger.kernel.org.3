Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E60C57BB61
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiGTQZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiGTQYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:24:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FE76249B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:24:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l23so33998921ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B83+a/WCg0K/QB4/cfV+I8us78zMwa7Te60tJq42yYo=;
        b=il3tFAHy2sjOz3Zwp7l/b3Lo+C6beKr7cQVDIQ7d1ylJSlTYCyR4UsSomA0KFBHK6v
         9DO3iFrTAMI5NzmF55sItLSS4OtivvuMwNBBuRpzS1U3jNUZ1zgBOqjc/VvG5W2ZAF2a
         Hs/G4v0OAkj7WzRmbRMGEXPmVIM6dFOZoijgg8q9ikd0BvA8ZzbPife0cOAJbEgBIXwy
         XoVzQIr8E4YDMSk0KRUDH4UcysgrfZ0EkqbcYYoAP+9ZuCC+YBjLPwVfuqOiEOgtCDbz
         5yLUlqwQp4RoANw67o16O4d6GZ0ZXKZKf3PYPTVvmlPz9Vb2SNmcXOSzY5A7kksJZvG9
         tR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B83+a/WCg0K/QB4/cfV+I8us78zMwa7Te60tJq42yYo=;
        b=Lg5t2YJermnBqblJ8R8n/4u1zOAEvYwuTruOCB2QyWBU9MZVT7qMDXCCimk/uV9dxd
         VDuV6Bf8nLg7Yp+9P3x3sK6lZbSLQeW6PUk9QKwcoTYESiz7mYE1mb7bbZweS5I5ldJR
         a6wu8ZBqsehoQqISfKuvPqAWtUGiOiErXOeFGmTfdF5gKKNXUjmCq8TwgaadNLoUopfw
         CE+eQbVPWo3oSsROpVU4+mwV5maBuukZAaZFaZ1kF91dmog0d+JoVuefNx7IV7EL1yXh
         mFcnKMVwz4YT9jvMY4ADrINU+z0nDTy2yJnaN245zr5U4Hetb0oOe7+iJ8fJtSamxqNh
         Sesw==
X-Gm-Message-State: AJIora9CWWFTG94AdKIyvGNu1tAmDGvJYTeeBfo6NmQc+b3B77RIB9iE
        tjm7mhgK58k8ePJXj/E6t8E=
X-Google-Smtp-Source: AGRyM1to0zNwyq4MbmCgppYXRLBhyZMSWlMhwNEziXeFIJaT+QuFHXt0kvN1NJRgoh0rdQsrmJR8ow==
X-Received: by 2002:a17:907:7608:b0:72b:4f33:bcce with SMTP id jx8-20020a170907760800b0072b4f33bccemr35617045ejc.252.1658334285589;
        Wed, 20 Jul 2022 09:24:45 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id b7-20020aa7dc07000000b0043bbd133358sm375834edu.37.2022.07.20.09.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 09:24:45 -0700 (PDT)
Date:   Wed, 20 Jul 2022 18:24:43 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: vt6655: Convert macro vt6655_mac_clear_stck_ds
 to function
Message-ID: <11d4aaf99e1d508c3019327937c7a160050847c1.1658333350.git.philipp.g.hortmann@gmail.com>
References: <cover.1658333350.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658333350.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert once used macro to static function.
Multiline macros are not liked by kernel community.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.c | 11 +++++++++++
 drivers/staging/vt6655/mac.h |  8 --------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index d7ee42df7062..3e9494c653dc 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -38,6 +38,8 @@
 
 #include "mac.h"
 
+static void vt6655_mac_clear_stck_ds(void __iomem *iobase);
+
 void vt6655_mac_reg_bits_on(void __iomem *iobase, const u8 reg_offset, const u8 bit_mask)
 {
 	unsigned char reg_value;
@@ -70,6 +72,15 @@ void vt6655_mac_word_reg_bits_off(void __iomem *iobase, const u8 reg_offset, con
 	iowrite16(reg_value & ~(bit_mask), iobase + reg_offset);
 }
 
+static void vt6655_mac_clear_stck_ds(void __iomem *iobase)
+{
+	unsigned char reg_value;
+
+	reg_value = ioread8(iobase + MAC_REG_STICKHW);
+	reg_value = reg_value & 0xFC;
+	iowrite8(reg_value, iobase + MAC_REG_STICKHW);
+}
+
 /*
  * Description:
  *      Test if all test bits off
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index c2c9cb07f32d..467c599a3289 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,14 +537,6 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define vt6655_mac_clear_stck_ds(iobase)				\
-do {									\
-	unsigned char reg_value;					\
-	reg_value = ioread8(iobase + MAC_REG_STICKHW);			\
-	reg_value = reg_value & 0xFC;					\
-	iowrite8(reg_value, iobase + MAC_REG_STICKHW);			\
-} while (0)
-
 #define MACvSelectPage0(iobase)				\
 	iowrite8(0, iobase + MAC_REG_PAGE1SEL)
 
-- 
2.37.1

