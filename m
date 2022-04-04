Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218374F1E67
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381983AbiDDWJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380664AbiDDUvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:51:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDA6BE3D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 13:49:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d10so7782633edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HHEmg+fr5p/zbKaGECq76obXrCQuZc+PpCxxd81H4xU=;
        b=Cz54hptYqES688DjAAbK5czO5dvQwJXWybrVQUz2Hjpdayu4G9M+aKsH7cxy9316PJ
         U5WPwk6AVeK1i6n+mfHJ3fgkI3nDdpE09BI+O7d0ohSkx5ulHnWgLYlfzYqfjcMWndct
         Qj95V8Zo9hVqxFJ67G54ZJb3yXKA+AEF1+3RkEDPoG6NXkNxORQgUkf45FAOOcMVjnbT
         sDxvb6XKnn+mzi1/lmklPLH/oUCf3qaXfeTzlDdq3UZ8IcGBMoX5LBX7CR+gOhoUZNEa
         R9QYqtUVG7z11/VyDetgl3jWUS44DonGWFnopeCzI7rRvluX24Axc783zpChiPtMwUse
         qUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HHEmg+fr5p/zbKaGECq76obXrCQuZc+PpCxxd81H4xU=;
        b=YreoIYSbBYPSVQ7aK9HFF+ayCBpejuKw107IAu3qcS3icO+DP8l+0AJjfya6ypSoIL
         hqwQHg+ZOCu9h3OcKxNzHcLi8T0Oad8JrH3Xf12WnYtt9zFqPlMfsuG3x6BKEja+tBG1
         Wmormoxz+xdgmhvXzOtjOOsTluhIKmt+4zAx9McQR+BUzEsXvv82qsTVU9tS/707EedN
         c/TQq9VXm/ovZ2IZAH8DAkrYLQ0nGSbRSWZPRgVm6YRDXinMj+foUThdx9RnV4jJ+ApQ
         OjMP+oZ1BTXX59hnEqnLN2e0wPwTP8+FhwO1sRbP+pySLIb7IjmXY4smit8TELxVmG0Y
         2bkw==
X-Gm-Message-State: AOAM5310r/q5Xeb7TrRfXt6Q4JhCbIk5ma3YXAu0QXHGVGX2o2Jm+Joa
        Wev7zo3xPXKBz8zTlWkmNv4=
X-Google-Smtp-Source: ABdhPJzb0rUG+QU53FfEw54N6apRT/DD8Nwd8qgh5DuPSeWrgOt5+lJkNPBtiQ8TL7lv8frvx1EFLg==
X-Received: by 2002:a05:6402:4248:b0:419:4583:eaa2 with SMTP id g8-20020a056402424800b004194583eaa2mr3706edb.376.1649105349707;
        Mon, 04 Apr 2022 13:49:09 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640210ce00b00413211746d4sm5799012edu.51.2022.04.04.13.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:49:05 -0700 (PDT)
Date:   Mon, 4 Apr 2022 22:49:04 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] staging: vt6655: Remove macro PCAvDelayByIO
Message-ID: <af62ac8613e7c8ee236572d46137e8e202abf446.1649103348.git.philipp.g.hortmann@gmail.com>
References: <cover.1649103348.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649103348.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove do-while(0) and CamelCase macro PCAvDelayByIO as
it is not accepted by checkpatch.pl
As the macro is just used once with a constant <= 50 the
functionality of the macro is implemented by using
udelay() directly.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Changed converting macro to function to delete macro
          This patch was 7/7 and is now 6/6
---
 drivers/staging/vt6655/srom.c |  2 +-
 drivers/staging/vt6655/upc.h  | 13 -------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index 1612c9702e31..2719046f1ac0 100644
--- a/drivers/staging/vt6655/srom.c
+++ b/drivers/staging/vt6655/srom.c
@@ -80,7 +80,7 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 			VNS_IN_PORTB(iobase + MAC_REG_I2MCSR, &byWait);
 			if (byWait & (I2MCSR_DONE | I2MCSR_NACK))
 				break;
-			PCAvDelayByIO(CB_DELAY_LOOP_WAIT);
+			udelay(CB_DELAY_LOOP_WAIT);
 		}
 		if ((wDelay < W_MAX_TIMEOUT) &&
 		    (!(byWait & I2MCSR_NACK))) {
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

