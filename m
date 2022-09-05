Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05525ACD87
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbiIEIRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237328AbiIEIQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:16:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E240BD5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:16:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fv3so1621537pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/AdpGVT0N/8ncggFEAw2LdRk7MFt3IthPSmEwk0XZqA=;
        b=Hw2je1UG8XBw4S6KF2eztarDlGqDR7b6mYLkyxsePPDKfXtIzSyxOrRsC6suIVuFd1
         PXhuVKumBnRA+eXRMjTZJYC5M7lGz+HLTNrfyUmbGTig+61BjAs1cc8AVLVBEgCT5G1j
         isnAh3f2NDdAhhXALa85JKduwraI3xY/CxgU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/AdpGVT0N/8ncggFEAw2LdRk7MFt3IthPSmEwk0XZqA=;
        b=AdPbAgS42g049j3J87GBQ94IZHp9aRWNifQK1c4QIx542fpEAHyqK7lzlwtJJhFreI
         glcilQO8xeZSrcho02T027DNqZomS8IfS/E5ZJ7LqC/W10c/QI9MUnRt6/KsRejJLAx8
         ACbWv/ErqBdCCEl1QnUBCmsAif9ipVWylEuNHmBKdfeBbklm5C0w4y3V6+lmKfNRmMeI
         d0TJQEV4exzngcqCEeu+ZcyHJZQVQ6jeLnfTm0C1xEGC2+AEm7A+5sIW+rmCP/ckPB2+
         wrxuNMjqMgoX+6rGzwhTGKLfCxpofjwVxIaj2q53ECuAg0DJTn5SociWImZ8qeEUlhrN
         G2CA==
X-Gm-Message-State: ACgBeo1Lq/8db6N4VeKrJBhAmaHhUu3zZdI9meo1/RhfyRxFwHT+lP/5
        jRwP5Kl6mBnc++AFlAOIXv7U2Q==
X-Google-Smtp-Source: AA6agR4niiO1u8IFNIJZJRvYw1HVm7TuxwF5Dj8VtySPmiKR9n2jVVoA+BZnoNvLqcrPIjdizmJkZw==
X-Received: by 2002:a17:902:c40a:b0:174:7d05:97cd with SMTP id k10-20020a170902c40a00b001747d0597cdmr41363380plk.34.1662365788696;
        Mon, 05 Sep 2022 01:16:28 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:71e2:8444:42d9:4bb0])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b005363bc65bafsm7075864pfj.57.2022.09.05.01.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:16:28 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH RFC 6/7] zram: Add recompression algorithm choice to Kconfig
Date:   Mon,  5 Sep 2022 17:15:51 +0900
Message-Id: <20220905081552.2740917-10-senozhatsky@chromium.org>
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
index 386e49a13806..8ed41514b8f0 100644
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

