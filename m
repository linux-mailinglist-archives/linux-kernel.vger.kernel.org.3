Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECAB572CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbiGMFCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiGMFBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:01:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27796DB2FA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:01:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bp15so7583282ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nZkAZqKnI9+H1H1kAWgcyuU85x37ne0/76d0ZYb5OL0=;
        b=Dj3JbH0fpr01t2rsa0FSL/y1PKwqvge/1F6UWBZXpXNfWEoz7J1X2v38H27Binop/q
         3F3wjp/aG+ssIPcwgvlPDEq3p6HbU7BN5OhDnDDDT+xEv5bHK97LQZDrThAD9cQna0qA
         9i0mYxhDmQ56tAaBB3pippqIvHVSi5UuC0roWAqdXLCS2O7yEe1mbSqFGqNAg2KlGap0
         aFGKs39hla2GMo+/EPt3XdpEzh1OS2h9WE1ago0uTbKiHuGRAN1wnq+JDxsu3oQWzUeJ
         rSC9YrDwfVmtTOkteD3Iho3TTBgxPkc864a8PPFQ8DGEPIWK+yzhkCoHKJhxOyamaRHH
         TSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nZkAZqKnI9+H1H1kAWgcyuU85x37ne0/76d0ZYb5OL0=;
        b=3EamQwX0Fp7PQN7t/oYPnl0odZyAXzPpDHZLJPJq9FU0jSgLRz0XvvkNCOkZeYarJw
         y/EqnPQEy3Gyj3iZ0CvI5tKd0FF3oyLYgE+Ce9ykwcZ6xPdThw7Fo6B9aSAkkk5K3WYc
         5keB4M2KeY8pPITR6QA4SgPNU1d8SIknnPU4u5ydGUUNqwnJiHEMXrqS9b1Q8Vt/2Wox
         nlqIgPBtMAtNQyzVJ6RR66FVO7mVFJA8SS85Y708qYQhTz3OcN8W4xRXTlYV5IpaCsLg
         6jXuJSLM6Gl0QQvmHGn0g7WGq47G4nXshWNI4YR90rWuG0h4jYQqFdeDOlEAmTcOC7Fl
         I42Q==
X-Gm-Message-State: AJIora+7whukJeC+LXSFutLUkTT8HhnLIeDsxZ58z4tgFFlrpquxb+Po
        hKbFpa/J1p4oBKVT2JYRSEk=
X-Google-Smtp-Source: AGRyM1vt3+7GVjLQGpvstKyT4RfoRLldDpGOC/Eq4sMB6Gg3peL4p0eGi8qYIXbHVmoFFN92yQYzLw==
X-Received: by 2002:a17:906:58cf:b0:722:e4e1:c174 with SMTP id e15-20020a17090658cf00b00722e4e1c174mr1522888ejs.85.1657688488786;
        Tue, 12 Jul 2022 22:01:28 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id kz1-20020a17090777c100b0072b565507c5sm2870066ejc.203.2022.07.12.22.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:01:28 -0700 (PDT)
Date:   Wed, 13 Jul 2022 07:01:26 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] staging: vt6655: Convert macro vt6655_mac_reg_bits_on
 to function
Message-ID: <6b23869ec13b35359b135f005a81f3ed50e5801e.1657657918.git.philipp.g.hortmann@gmail.com>
References: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert macro vt6655_mac_reg_bits_on to function.
checkpatch.pl does not accept multiline macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.c | 8 ++++++++
 drivers/staging/vt6655/mac.h | 8 +-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index 688f7c685c97..902034a28c6c 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -38,6 +38,14 @@
 
 #include "mac.h"
 
+void vt6655_mac_reg_bits_on(void __iomem *iobase, const u8 reg_offset, const u8 bit_mask)
+{
+	unsigned char reg_value;
+
+	reg_value = ioread8(iobase + reg_offset);
+	iowrite8(reg_value | bit_mask, iobase + reg_offset);
+}
+
 /*
  * Description:
  *      Test if all test bits off
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 4d328b724559..031316d42dba 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,13 +537,6 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define vt6655_mac_reg_bits_on(iobase, reg_offset, bit_mask)		\
-do {									\
-	unsigned char reg_value;					\
-	reg_value = ioread8(iobase + reg_offset);			\
-	iowrite8(reg_value | (bit_mask), iobase + reg_offset);		\
-} while (0)
-
 #define vt6655_mac_word_reg_bits_on(iobase, reg_offset, bit_mask)	\
 do {									\
 	unsigned short reg_value;					\
@@ -666,6 +659,7 @@ do {									\
 #define MAKEWORD(lb, hb) \
 	((unsigned short)(((unsigned char)(lb)) | (((unsigned short)((unsigned char)(hb))) << 8)))
 
+void vt6655_mac_reg_bits_on(void __iomem *iobase, const u8 reg_offset, const u8 bit_mask);
 bool MACbIsRegBitsOff(struct vnt_private *priv, unsigned char byRegOfs,
 		      unsigned char byTestBits);
 
-- 
2.37.0

