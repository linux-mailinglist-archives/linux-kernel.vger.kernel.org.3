Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF885A3C71
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 08:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiH1Gxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 02:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiH1Gxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 02:53:35 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6255B53025
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:53:33 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m1so6676040edb.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=yRQXOtrkeq9hOES6fAnWUIrrP3pelRSPhYzLt3Eo1sk=;
        b=kMBqaj2P1VnKYWzs4R0t5pa3wcydqvxjcvC2TsjHAqNMZMUCe8iFyLQJWQmJ1dwX7Q
         UUN8IS5G2ln8Kajo2ueEIj8fgNcmoXABuzykK9zBUcTYlxptT9+6kG0Fg8dzjhbF/BpI
         ed3NgOaA/5tvwXItnuNJkY9D9vGFaqoNgIkN8ZBAnHrFQaV3yCDzSylEpaeP4uONIivq
         bTfA52fm1WRtAafPOMnBNddz0MQTLlmEe8lfPPRp5/v8/ZH4y2XDnwrB46wbZHPwWpyr
         uDV6fmy+U9Wec01DV7rdlO5MTS3QOaP4qlUmib0ndDx/3QoawElQ1/+2ZhE0HaqBECpl
         bOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=yRQXOtrkeq9hOES6fAnWUIrrP3pelRSPhYzLt3Eo1sk=;
        b=FUzqSO0gQYJgYVJTFaMqwYr8p9M4llxbx5AnjsixoBHQgBrPnc5DyvBtTtxktj3WbM
         vXraG87IhZ4kzPqkhulWXSOBH1fdqCvouCqKnymypKqSsfoAqfG83A0NWbZKMiPQ2DuK
         fuxdS8O0I//4QX5mLx0FsHtz4m9k+cJj18QPO2oZ8Lq+7FtHu3MsKjfpN9uxpQ4t7HoV
         kRkWjVwSfhlNUVwSmX14Ih9zASgSF21yCiiEN3fisW0PrWlu1OZkgiNVYZRpLFN8uewh
         PZvpfFMxQ9GovYch2YIV4B3O6tjBAyMVWJF24NtkFLkY7vNFrS1IXmPrD1J2B+MPAjXZ
         j34Q==
X-Gm-Message-State: ACgBeo2Cd4436cxIrzKVZJ2dfzCbXXz+7E7FVvEl2Pz+N92ZJGPTVYN5
        PIbBAzc4z0obStz+j5QGOOY=
X-Google-Smtp-Source: AA6agR61vXLf0ejseVAOO0VdvjVj4GkNuFBuD9vJkWSNjsBPTYoDHXdbLHC28qMVL/hOT8MVocDgSQ==
X-Received: by 2002:a05:6402:28ca:b0:43b:5235:f325 with SMTP id ef10-20020a05640228ca00b0043b5235f325mr12093094edb.320.1661669611910;
        Sat, 27 Aug 2022 23:53:31 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id lo23-20020a170906fa1700b006fec4ee28d0sm2872732ejb.189.2022.08.27.23.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 23:53:31 -0700 (PDT)
Date:   Sun, 28 Aug 2022 08:53:29 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] staging: vt6655: Convert macro MACvSetBBType to function
Message-ID: <bd512f940427615ed4b134dd04f14095875eec5b.1661666677.git.philipp.g.hortmann@gmail.com>
References: <cover.1661666677.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661666677.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert macro to static function. Multiline macros are not liked by
kernel community. Rename variable dwOrgValue to reg_value and byTyp to
mask to avoid CamelCase which is not accepted by checkpatch.pl. Change
variable declaration to u32 as this improves readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/card.c | 10 ++++++++++
 drivers/staging/vt6655/mac.h  |  9 ---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index bbe05d9538a1..6711743dcf4a 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -55,6 +55,16 @@ static const unsigned short cwRXBCNTSFOff[MAX_RATE] = {
 
 /*---------------------  Static Functions  --------------------------*/
 
+static void MACvSetBBType(void __iomem *iobase, u32 mask)
+{
+	u32 reg_value;
+
+	reg_value = ioread32(iobase + MAC_REG_ENCFG);
+	reg_value = reg_value & ~ENCFG_BBTYPE_MASK;
+	reg_value = reg_value | mask;
+	iowrite32(reg_value, iobase + MAC_REG_ENCFG);
+}
+
 /*---------------------  Export Functions  --------------------------*/
 
 /*
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index a75cd318ee25..b6c4f2bb096a 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -543,15 +543,6 @@
 #define MACvSelectPage1(iobase)				\
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL)
 
-#define MACvSetBBType(iobase, byTyp)					\
-do {									\
-	unsigned long dwOrgValue;					\
-	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
-	dwOrgValue = dwOrgValue & ~ENCFG_BBTYPE_MASK;			\
-	dwOrgValue = dwOrgValue | (unsigned long)byTyp;			\
-	iowrite32((u32)dwOrgValue, iobase + MAC_REG_ENCFG);		\
-} while (0)
-
 #define MACvSetRFLE_LatchBase(iobase)                                 \
 	vt6655_mac_word_reg_bits_on(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_RFLEOPT)
 
-- 
2.37.2

