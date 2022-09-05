Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689405ACD86
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbiIEIQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbiIEIQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:16:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6419931219
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:16:12 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id m2so7848158pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fBzy0HH3oP/NJNf66NH/BQ/hBL6aSkPOwubVif8FhBg=;
        b=g7ZLQz5Z/UHV+cJtofiH2bNHxfIGDDEbPms2i+63gWIQo9iEQyAbHkz2T63xkNd232
         8HXFrR0soPJ/o36JPaLPBcmaa7Vd3YWV7WQT58naNwRYiytTnSSV3xbgOLXUZNYNacFI
         OgOIERWJrjBlsBwRdaLwSgka5CKVaWoBSNZl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fBzy0HH3oP/NJNf66NH/BQ/hBL6aSkPOwubVif8FhBg=;
        b=Ql9uyzFfLuSDPNY/dvjYX95Xt3Dier3hwfOC9J2E02xQjtcf06jCQq8GsXQZmPN5mL
         E/RHR/4ObvshbN0nvvE1iFmStG8tHcnSeD/8kf+ceTo87LlKUDkHfhoB5wjQYTxbTgnz
         kclUh/CCRoZYrm9Q8kpAgb8xo3cbs/MT5kmtFEmi53NDBd7zssrojkRtGmZqE2TTefWK
         dOKrIwKL2/hS6YwC2HJWiHZI0qcOiYoLqFEF5OhnEfzd8NbFvhmFjyxCpkURW7fWO5WS
         X1Jm9kvAHI1HH3pDrmjSWAkyIcwZdZE8KhAoqo7/Zkqj+ESH5wGk0kg9jhhkXnQeFeAE
         JWdQ==
X-Gm-Message-State: ACgBeo09UJuRiTSiHgDoUcdIsQzPUuNBcG37kPdFzY0P6av35OWLg0HY
        07uyTs+MGBVCcHOW6k1P6+wO/Q==
X-Google-Smtp-Source: AA6agR5A0zJxXzLe1uhfjaa6iSw5p5az5Rm6rkC00HQxMV7jvGbarLvaRVP5N167w0AAR8B/o/OXVw==
X-Received: by 2002:a17:902:d2ce:b0:175:994:7778 with SMTP id n14-20020a170902d2ce00b0017509947778mr30962616plc.43.1662365771902;
        Mon, 05 Sep 2022 01:16:11 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:71e2:8444:42d9:4bb0])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b005363bc65bafsm7075864pfj.57.2022.09.05.01.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:16:11 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 2/3] zram: Add recompression algorithm choice to Kconfig
Date:   Mon,  5 Sep 2022 17:15:45 +0900
Message-Id: <20220905081552.2740917-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220905081552.2740917-1-senozhatsky@chromium.org>
References: <20220905081552.2740917-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make (secondary) recompression algorithm selectable just like
we do it for the (primary) default one.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig    | 40 +++++++++++++++++++++++++++++++++++
 drivers/block/zram/zram_drv.c |  2 +-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 81ae4b96ec1a..fc2d4d66c484 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -89,3 +89,43 @@ config ZRAM_MULTI_COMP
 
           echo TIMEOUT > /sys/block/zramX/idle
           echo SIZE > /sys/block/zramX/recompress
+
+choice
+	prompt "Default zram recompression algorithm"
+	default ZRAM_DEF_RECOMP_ZSTD
+	depends on ZRAM && ZRAM_MULTI_COMP
+
+config ZRAM_DEF_RECOMP_LZORLE
+	bool "lzo-rle"
+	depends on CRYPTO_LZO
+
+config ZRAM_DEF_RECOMP_ZSTD
+	bool "zstd"
+	depends on CRYPTO_ZSTD
+
+config ZRAM_DEF_RECOMP_LZ4
+	bool "lz4"
+	depends on CRYPTO_LZ4
+
+config ZRAM_DEF_RECOMP_LZO
+	bool "lzo"
+	depends on CRYPTO_LZO
+
+config ZRAM_DEF_RECOMP_LZ4HC
+	bool "lz4hc"
+	depends on CRYPTO_LZ4HC
+
+config ZRAM_DEF_RECOMP_842
+	bool "842"
+	depends on CRYPTO_842
+
+endchoice
+
+config ZRAM_DEF_RECOMP
+	string
+	default "lzo-rle" if ZRAM_DEF_RECOMP_LZORLE
+	default "zstd" if ZRAM_DEF_RECOMP_ZSTD
+	default "lz4" if ZRAM_DEF_RECOMP_LZ4
+	default "lzo" if ZRAM_DEF_RECOMP_LZO
+	default "lz4hc" if ZRAM_DEF_RECOMP_LZ4HC
+	default "842" if ZRAM_DEF_RECOMP_842
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5f0181d9a69e..f144f31c3c4b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -44,7 +44,7 @@ static int zram_major;
 static const char *default_comp_algs[ZRAM_MAX_ZCOMPS] = {
 	CONFIG_ZRAM_DEF_COMP,
 #ifdef CONFIG_ZRAM_MULTI_COMP
-	"zstd",
+	CONFIG_ZRAM_DEF_RECOMP,
 #endif
 };
 
-- 
2.37.2.789.g6183377224-goog

