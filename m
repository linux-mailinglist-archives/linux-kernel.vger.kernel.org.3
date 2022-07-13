Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4783572CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbiGME7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiGME7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:59:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2D913F69
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:59:01 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l23so17838236ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HbcwIWPSC+fHCTXFOVsF8fnI4X1+WKG7wU3WnkyeDuU=;
        b=o9musvqbQVU5I5PDu4GLHZOb+zFGklvW+bWoAKcw+fPMYo5FLQJNn5Ik47CvKDSlvd
         Ab87o0eSbRP1qCbZc0jxELNlz0amZjQnHSlaYooRoiBPqciTTdUTHlHaQC6cMQOAAKJ9
         qQ/M7r40tsBENKUvqBVUlcxH7IWdvSoJ7rtWlfrK8Ut5QH0Wjcd37gLDaQaiaSgLCBdT
         2VV4UBYun6kRBmR/uNu2R+As7hcT7FtsgnAUHOELtI4QqvC9DoLBZ8uoJvJGLaR3VKos
         ELRXbCVSomzrfY2BdnUTxHEUuFJxY+Xn6og/LbzrwIffNI7UaDjCy0GhU67ODP68xHPN
         DWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HbcwIWPSC+fHCTXFOVsF8fnI4X1+WKG7wU3WnkyeDuU=;
        b=ZBcyNviVAV0BX2B7rOJVxBc+RTF0dru2AbxdZ1NIIJ/LZBfBHrrF5Zfc2Yhelk0ERX
         QRP1Xtlmo9rO58zcKfS5GyY4p43LVBNo6NIgVKOuZuxn5LCpH1ucJT9AuTXBgmXC6upB
         d179NNNEUm/k8Esqfg2WqJh8oj30OKwZOpmkXJ6ISDvn6txJehzV/HehZOnwrpU+mXSO
         gVGVawqIfVaNjprmaSdiIJiXxRqegZ9GoaLYoBAz+ePqa+ZUHRHbedrEc3c97usOfTdq
         47E3FTmnCeSTOZ4N81pdq1LWRblNLEU/3Bpiyuy4fOKpQvdq1sJ8tN749MN4FtEw43+e
         yzwg==
X-Gm-Message-State: AJIora/c7QkechNWz9zLgjYyEEPBWZKdrxArpxJjqI/A984V4Qy7Q/5S
        Pl/lIpUbNyzxnLnuxqAV4GM=
X-Google-Smtp-Source: AGRyM1uKPuG2RuL009Jkm1vV9QPWuHjuZ9gD+QENU2/oRbaIlbDz1W0BLnCQmqlE336rNarCEbGnrg==
X-Received: by 2002:a17:907:1dca:b0:72b:3cb2:81f7 with SMTP id og10-20020a1709071dca00b0072b3cb281f7mr1443032ejc.567.1657688339683;
        Tue, 12 Jul 2022 21:58:59 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id h4-20020a50ed84000000b0043a85d7d15esm7151457edr.12.2022.07.12.21.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:58:59 -0700 (PDT)
Date:   Wed, 13 Jul 2022 06:58:56 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] staging: vt6655: Rename byRegOfs to reg_offset in four
 macros
Message-ID: <82f65d22ac8cd75b2c7790c13be3d0068968925b.1657657918.git.philipp.g.hortmann@gmail.com>
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

Fix name of a variable in four macros that use CamelCase which is not
accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 5c14a76ed799..b3803143673c 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,32 +537,32 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define MACvRegBitsOn(iobase, byRegOfs, byBits)			\
+#define MACvRegBitsOn(iobase, reg_offset, byBits)			\
 do {									\
 	unsigned char byData;						\
-	byData = ioread8(iobase + byRegOfs);				\
-	iowrite8(byData | (byBits), iobase + byRegOfs);			\
+	byData = ioread8(iobase + reg_offset);				\
+	iowrite8(byData | (byBits), iobase + reg_offset);		\
 } while (0)
 
-#define MACvWordRegBitsOn(iobase, byRegOfs, wBits)			\
+#define MACvWordRegBitsOn(iobase, reg_offset, wBits)			\
 do {									\
 	unsigned short wData;						\
-	wData = ioread16(iobase + byRegOfs);				\
-	iowrite16(wData | (wBits), iobase + byRegOfs);			\
+	wData = ioread16(iobase + reg_offset);				\
+	iowrite16(wData | (wBits), iobase + reg_offset);		\
 } while (0)
 
-#define MACvRegBitsOff(iobase, byRegOfs, byBits)			\
+#define MACvRegBitsOff(iobase, reg_offset, byBits)			\
 do {									\
 	unsigned char byData;						\
-	byData = ioread8(iobase + byRegOfs);				\
-	iowrite8(byData & ~(byBits), iobase + byRegOfs);		\
+	byData = ioread8(iobase + reg_offset);				\
+	iowrite8(byData & ~(byBits), iobase + reg_offset);		\
 } while (0)
 
-#define MACvWordRegBitsOff(iobase, byRegOfs, wBits)			\
+#define MACvWordRegBitsOff(iobase, reg_offset, wBits)			\
 do {									\
 	unsigned short wData;						\
-	wData = ioread16(iobase + byRegOfs);				\
-	iowrite16(wData & ~(wBits), iobase + byRegOfs);			\
+	wData = ioread16(iobase + reg_offset);				\
+	iowrite16(wData & ~(wBits), iobase + reg_offset);		\
 } while (0)
 
 #define MACvReceive0(iobase)						\
-- 
2.37.0

