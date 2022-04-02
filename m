Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26334EFF64
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 09:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbiDBHcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 03:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352067AbiDBHbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 03:31:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F341DEA85
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 00:29:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id c10so10040258ejs.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GQIynQ3bcr2B2Ezgs0ZsVUHSLQcz4dHVvcopVnG+tyE=;
        b=QD1SWZVErB3vqYcXw/ZCfyN4gLad2PktALbBk2X8iiJKOEupoptF3Lxf3rx/yr+sOY
         7jzkwvya/qORHs1Crk9jVLFbPHHeNuDthdVDuGuW27JGgtB151KXXL3aFcZMuWT689cW
         24xt8uWIV1yCjmSwNuw7QOuj+4WR9c3dbFuxRfP8a+mswcirtIZZpiwzU6h7SvR4OuAL
         6P/ywHRlbSRp/bCthL/itKDB+2p27Q9orJDvR/3GbaU9SXee2QLHycgwNQ1Mtm0Oy/Vh
         SmxNszRBZ6mOg03VP+pAvIavIPLQMxsCH/kNxczrd/geX2gXCFa0R7IJ+irnWbaAuTr2
         5XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GQIynQ3bcr2B2Ezgs0ZsVUHSLQcz4dHVvcopVnG+tyE=;
        b=HMXH/yvmBjO4UfJx1QweXsnkNIeYjzmIYYtH2tUonb8gDSu7J4Ijw0xJgBU5OvBZnP
         zxMiCJekXwDSQL5KUtsaKKjWLHXQYd1xdEUp3vTw74b2mizhBxdurfy6H2uMmEsWeW7F
         f8PT2fqxWxHaBburGQt+Y/vT8TYsUcCJ5AZLCrhZDJsg+wyoz9qWeerxrW+ue1hC6COx
         yKDkq510WFfGjvOXnKpCGAfvUJM3U1nd8gD0Gb1O8krrjen7rVz2JYHhYjcCsID7XaMn
         TVecF+hI0UswNU6+lgE2WS4hbJ6Pza94hVq6pcoEPwR9lqP2hMztU/GxXOkEKo1TUJ/h
         AzqQ==
X-Gm-Message-State: AOAM533Fqb9XuxC+X5DpqeBJkvToXbIgy584RDz3Hl+7QIQNLBkhO+mn
        s7DtFcFqP6nFcBGybd9nAjwrVv/FWKg=
X-Google-Smtp-Source: ABdhPJwPCRB53/y4teq4/3Q59TCXEeANxyoBE5/hQoHZfLgq1iPRvzkiFI0BeNWHfyax77j+lSF3Ow==
X-Received: by 2002:a17:906:8a6d:b0:6e0:68ac:7197 with SMTP id hy13-20020a1709068a6d00b006e068ac7197mr2996202ejc.703.1648884592132;
        Sat, 02 Apr 2022 00:29:52 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id t19-20020a056402525300b0041952a1a764sm2114882edd.33.2022.04.02.00.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 00:29:51 -0700 (PDT)
Date:   Sat, 2 Apr 2022 09:29:49 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] staging: vt6655: Convert macro PCAvDelayByIO to function
Message-ID: <b7551e92f42d60ff3bb74b5e28467f09781e3d06.1648882847.git.philipp.g.hortmann@gmail.com>
References: <cover.1648882847.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648882847.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert do-while(0) macro PCAvDelayByIO to function and relocate.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/srom.c | 13 +++++++++++++
 drivers/staging/vt6655/srom.h |  2 ++
 drivers/staging/vt6655/upc.h  | 13 -------------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index 1612c9702e31..8373aa783d76 100644
--- a/drivers/staging/vt6655/srom.c
+++ b/drivers/staging/vt6655/srom.c
@@ -139,3 +139,16 @@ void SROMvReadEtherAddress(void __iomem *iobase,
 		pbyEtherAddress++;
 	}
 }
+
+void PCAvDelayByIO(unsigned char u_delay_unit)
+{
+	unsigned char data;
+	unsigned long ii;
+
+	if (u_delay_unit <= 50) {
+		udelay(u_delay_unit);
+	} else {
+		for (ii = 0; ii < (u_delay_unit); ii++)
+			data = inb(0x61);
+	}
+}
diff --git a/drivers/staging/vt6655/srom.h b/drivers/staging/vt6655/srom.h
index b03073ffa18a..c34523c77d02 100644
--- a/drivers/staging/vt6655/srom.h
+++ b/drivers/staging/vt6655/srom.h
@@ -82,4 +82,6 @@ void SROMvReadAllContents(void __iomem *iobase, unsigned char *pbyEepromRegs);
 void SROMvReadEtherAddress(void __iomem *iobase,
 			   unsigned char *pbyEtherAddress);
 
+void PCAvDelayByIO(unsigned char u_delay_unit);
+
 #endif /* __EEPROM_H__*/
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index 7d5075ec3162..05e0cf2e7d97 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -38,19 +38,6 @@
 #define VNS_OUT_PORTD(io_address, data) \
 	iowrite32((u32)(data), io_address)
 
-#define PCAvDelayByIO(u_delay_unit)				\
-do {								\
-	unsigned char __maybe_unused data;			\
-	unsigned long ii;					\
-								\
-	if (u_delay_unit <= 50) {					\
-		udelay(u_delay_unit);				\
-	} else {						\
-		for (ii = 0; ii < (u_delay_unit); ii++)		\
-			data = inb(0x61);			\
-	}							\
-} while (0)
-
 /*---------------------  Export Classes  ----------------------------*/
 
 /*---------------------  Export Variables  --------------------------*/
-- 
2.25.1

