Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004EB58BC44
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiHGSOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiHGSOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:14:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3416365F3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:13:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x21so8960695edd.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=4L2Ey6uuwyz5FiRHKjwFd1Rwtr7ClW4F9v5PIxtOSOs=;
        b=WilrlL87tkAOk31c1/a6fXFIim59k8jArfK9u3y9MiBAgtrydTFPRKIzOeY/dlKBX6
         oxO8hOBp2eSJv/ho2SQvm0yxSNjy1WLraeC2G9botxKL0u4q+s7+gGdycpb0Mie4Zmh0
         swqLSFetLB5XhbdufQL4b/oX4H29ZIU4WgbhJNe9Vng+H9A2eRYpggplb+/53gjWRZCF
         2+V78a8LFZ9zYoyq0z7v6K++JMQPOW3FWno+oKvg1vnka2L4aXkl5phAycNZ+F3HgbBi
         6m7lTYNM5Gt8zPq3/O4k1Kt317jGWmlLqmIlKVkx88OenRUcG1zfuSoRqExEKK5HFAK6
         iclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=4L2Ey6uuwyz5FiRHKjwFd1Rwtr7ClW4F9v5PIxtOSOs=;
        b=Vit8ioxtz29DcmQcfsPBfVYI46QAV4RuKpKBA0Xz8VeObitxomwhqIMJ+3ONUN2ufH
         wBYyGlUoWXRSlBPPomEn1h6yE/GLpjN37p7zdpLpeO1PXL2zO46/G8PXgBS7KVLprGSE
         RpIpioHroLLdLK03Z+sbfTtX2EI3NMgIHuObHVqodT9n9Rw0/mpONMyi1X1unVVFZnLf
         vRgfFi/bvBHuuxo+hsoZ+c5x2msJTtRnLiv/xTikK/UkTAo0StPeJY7JgLYVfsXpzyx4
         sBgHH4KUNMy5uE+uE6BsujMm6OyFNUxK6epi4uU9Ay5Syq9NSzOBPWF4RXeCr72zo89E
         AHkA==
X-Gm-Message-State: ACgBeo2KJeKzrDLlR8eZM2mY3TfhW6QU5gIZ9xAVwdg0K49rWvdEznxf
        oFjgHrYAVOg02jO/tf5xOuLK/+raeQg=
X-Google-Smtp-Source: AA6agR5dkJAQKSJ3H1Ivo2Opn7Qvsx44GLA2MeeB6nT/q88o6cX2sB0ne4Tn4EQLxfHAfKR45ClEwQ==
X-Received: by 2002:a05:6402:b85:b0:43c:f8e8:96ba with SMTP id cf5-20020a0564020b8500b0043cf8e896bamr15497163edb.183.1659896028829;
        Sun, 07 Aug 2022 11:13:48 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id v18-20020a1709061dd200b0072ecef772a7sm3989417ejh.160.2022.08.07.11.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 11:13:48 -0700 (PDT)
Date:   Sun, 7 Aug 2022 20:13:46 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] staging: vt6655: Convert macro MACvDisableProtectMD
Message-ID: <4cb2b8025adde2a3addfd8e954faf18a0a8032aa.1659892670.git.philipp.g.hortmann@gmail.com>
References: <cover.1659892670.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659892670.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert macro MACvDisableProtectMD to static function which calls the
new common static function vt6655_mac_clear_bits. This saves
codelines and multiline macros are not liked by kernel community.
Function name is also changed to avoid CamelCase which is not accepted
by checkpatch.pl and to clean up namespace.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Added new function vt6655_mac_clear_bits
          Updated description
---
 drivers/staging/vt6655/device_main.c | 16 +++++++++++++++-
 drivers/staging/vt6655/mac.h         | 10 +---------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index ccfd4bfa0502..96945fb8d536 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -225,11 +225,25 @@ static void vt6655_mac_set_bits(void __iomem *iobase, u32 mask)
 	iowrite32(reg_value, iobase + MAC_REG_ENCFG);
 }
 
+static void vt6655_mac_clear_bits(void __iomem *iobase, u32 mask)
+{
+	u32 reg_value;
+
+	reg_value = ioread32(iobase + MAC_REG_ENCFG);
+	reg_value = reg_value & ~mask;
+	iowrite32(reg_value, iobase + MAC_REG_ENCFG);
+}
+
 static void vt6655_mac_en_protect_md(void __iomem *iobase)
 {
 	vt6655_mac_set_bits(iobase, ENCFG_PROTECTMD);
 }
 
+static void vt6655_mac_dis_protect_md(void __iomem *iobase)
+{
+	vt6655_mac_clear_bits(iobase, ENCFG_PROTECTMD);
+}
+
 /*
  * Initialisation of MAC & BBP registers
  */
@@ -1477,7 +1491,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 		if (conf->use_cts_prot)
 			vt6655_mac_en_protect_md(priv->port_offset);
 		else
-			MACvDisableProtectMD(priv->port_offset);
+			vt6655_mac_dis_protect_md(priv->port_offset);
 	}
 
 	if (changed & BSS_CHANGED_ERP_SLOT) {
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 4de9974e6c69..a7d6254fded0 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -12,7 +12,7 @@
  * Revision History:
  *      07-01-2003 Bryan YC Fan:  Re-write codes to support VT3253 spec.
  *      08-25-2003 Kyle Hsu:      Porting MAC functions from sim53.
- *      09-03-2003 Bryan YC Fan:  Add MACvDisableProtectMD & vt6655_mac_en_protect_md
+ *      09-03-2003 Bryan YC Fan:  Add vt6655_mac_dis_protect_md & vt6655_mac_en_protect_md
  */
 
 #ifndef __MAC_H__
@@ -543,14 +543,6 @@
 #define MACvSelectPage1(iobase)				\
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL)
 
-#define MACvDisableProtectMD(iobase)					\
-do {									\
-	unsigned long dwOrgValue;					\
-	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
-	dwOrgValue = dwOrgValue & ~ENCFG_PROTECTMD;			\
-	iowrite32((u32)dwOrgValue, iobase + MAC_REG_ENCFG);		\
-} while (0)
-
 #define MACvEnableBarkerPreambleMd(iobase)				\
 do {									\
 	unsigned long dwOrgValue;					\
-- 
2.37.1

