Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AC6585BB4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 21:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiG3TU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 15:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiG3TUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 15:20:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C6DB495
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:20:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id uj29so599617ejc.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=WLvWy4K8HcW3LAslZh7Wr86ITXJRS+ffnYQWYzLiedQ=;
        b=B5XKMTbs4j/0CtJ6lJcJQSrjp/VFFmFEiwFaK9Eox4+BF/aN0I3zWl0LV0lxiMLB7Y
         c6cR2WpfgnR+NjfxBIzFKaDwAu+PoOTS3+pGs4Mz2bxtiMgQca7hbEHYuqpvfI3VPcsq
         7W9yzuY1oOw+yKdnYfHkhClYfGrvpT6Z4DHxi2ywdq9OsjDN5mnTwYNoufdCShJ5dkpL
         bU+bpH4Uik4SqMrwFlaCc2WXIG/qRDDrN9CYiHyo/gi8IzzsU9ZFsUzy1xbMRkN6SzM/
         rdDhlBaN8gkvSeyTHuzt5cnsWuyHhEzj+Bs9Wwpa9TW24z0lD5I1t9sxPUjIN3IsjKB8
         3lTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=WLvWy4K8HcW3LAslZh7Wr86ITXJRS+ffnYQWYzLiedQ=;
        b=pDU4AanplEMs4/bnKZvYB5YCAPjq2Wt2aJAyLljOYG6OW3dJG6zexk0PTU0lM5uldT
         gQw+tR2ZAm11LN04s73satcnKvRTfI1Jff8p4aM/AcUH/h73zkacf/Lu2JfGVUBBfsHv
         gFS6T4C8mjE5vESymODlSAytU3py2PRPHzWMYUooTd/KhoGZLpPgQvTiBXqC5VMObdDu
         uwUIUw+Zt6X1lOZGTNAouPBo4QImFSE8cKV/U+Pw2ASgbybBbObus0wKHoAv5Do2+y53
         kEwqDwLxozEEZK25BpUUzqVk7IwHvCogF94EZqNoHoLcFRiicyizCj3U73o9BU5vx1Pi
         0VVw==
X-Gm-Message-State: AJIora+RJrSw0u6U1nnBNWXwXK4pEP7x6+CsCZATEyQbPFrvc1C9PmLw
        4AS60m6td4sHBk/gTxk7zmFIjknuElQ=
X-Google-Smtp-Source: AGRyM1sUvBVN9C33ftS/bi6aY2bbpN7dTz1bbU3T/IvMGkYU4Qqki8+lDRrjCraw0MglcO9B8hRFhA==
X-Received: by 2002:a17:906:730c:b0:72b:4f83:51c1 with SMTP id di12-20020a170906730c00b0072b4f8351c1mr7115513ejc.515.1659208820999;
        Sat, 30 Jul 2022 12:20:20 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id yw17-20020a170907245100b00722fadc4279sm3218418ejb.124.2022.07.30.12.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 12:20:20 -0700 (PDT)
Date:   Sat, 30 Jul 2022 21:20:19 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] staging: vt6655: Convert macro MACvEnableProtectMD to
 function
Message-ID: <ff985a2e3513f277011badb0103b443efedc8a4d.1659192760.git.philipp.g.hortmann@gmail.com>
References: <cover.1659192760.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659192760.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert macro to static function. Multiline macros are not liked by
kernel community. Rename variable dwOrgValue to reg_value to avoid
CamelCase which is not accepted by checkpatch.pl. Change variable
declaration to u32 as this improves readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 9 +++++++++
 drivers/staging/vt6655/mac.h         | 8 --------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 1fc8bdf8a311..3565aa53f007 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -216,6 +216,15 @@ static void vt6655_mac_dma_ctl(void __iomem *iobase, u8 reg_index)
 		iowrite32(DMACTL_RUN, iobase + reg_index);
 }
 
+static void MACvEnableProtectMD(void __iomem *iobase)
+{
+	u32 reg_value;
+
+	reg_value = ioread32(iobase + MAC_REG_ENCFG);
+	reg_value = reg_value | ENCFG_PROTECTMD;
+	iowrite32(reg_value, iobase + MAC_REG_ENCFG);
+}
+
 /*
  * Initialisation of MAC & BBP registers
  */
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 467c599a3289..84d203c56b1f 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -543,14 +543,6 @@
 #define MACvSelectPage1(iobase)				\
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL)
 
-#define MACvEnableProtectMD(iobase)					\
-do {									\
-	unsigned long dwOrgValue;					\
-	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
-	dwOrgValue = dwOrgValue | ENCFG_PROTECTMD;			\
-	iowrite32((u32)dwOrgValue, iobase + MAC_REG_ENCFG);		\
-} while (0)
-
 #define MACvDisableProtectMD(iobase)					\
 do {									\
 	unsigned long dwOrgValue;					\
-- 
2.37.1

